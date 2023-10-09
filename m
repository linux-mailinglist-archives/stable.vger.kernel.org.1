Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517A47BDDD9
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376798AbjJINNq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376977AbjJINN3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:13:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ABB136
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:12:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EBEDC433C7;
        Mon,  9 Oct 2023 13:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857172;
        bh=g2iHJstdEizDqWoapOwj8lHxDkyNsBHuBy30ht5IYK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWzMu9ryPaAzTSj/Uf1CeZtLDoxoYNMXy1MYB5YfQEf3b0teMmooe/CeGwaUSp95D
         6hJdmoOcKaYeyV+iCgZRi94S49cEAAiISR2bTpyclY7D0yO+Bp/YQK3Gd8gIaX+aoR
         fC35PWsRNQqEnhbOTyZ4RcR8ArH2jxFHsfNXXq6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 095/163] NFSv4: Fix a nfs4_state_manager() race
Date:   Mon,  9 Oct 2023 15:00:59 +0200
Message-ID: <20231009130126.653594757@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit ed1cc05aa1f7fe8197d300e914afc28ab9818f89 ]

If the NFS4CLNT_RUN_MANAGER flag got set just before we cleared
NFS4CLNT_MANAGER_RUNNING, then we might have won the race against
nfs4_schedule_state_manager(), and are responsible for handling the
recovery situation.

Fixes: aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 597ae4535fe33..9a5d911a7edc7 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2714,6 +2714,13 @@ static void nfs4_state_manager(struct nfs_client *clp)
 		nfs4_end_drain_session(clp);
 		nfs4_clear_state_manager_bit(clp);
 
+		if (test_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state) &&
+		    !test_and_set_bit(NFS4CLNT_MANAGER_RUNNING,
+				      &clp->cl_state)) {
+			memflags = memalloc_nofs_save();
+			continue;
+		}
+
 		if (!test_and_set_bit(NFS4CLNT_RECALL_RUNNING, &clp->cl_state)) {
 			if (test_and_clear_bit(NFS4CLNT_DELEGRETURN, &clp->cl_state)) {
 				nfs_client_return_marked_delegations(clp);
-- 
2.40.1



