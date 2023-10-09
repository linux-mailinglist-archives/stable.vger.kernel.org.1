Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9878D7BDEB3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376383AbjJINWL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376386AbjJINWK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:22:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414DB8F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:22:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EDDC433CB;
        Mon,  9 Oct 2023 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857728;
        bh=ABTlEW+FEprEl9xW6muexYlc81B4dUiW2Fsbv7HbJz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jt5fdYi/MZhvgAmGf2mt2rR1jxPQVnfH14s3qU/bYxWQCMudB0fR2v1jSWCbRarE8
         aGUDp8xAsQOt9QQjyujfgpDpgIVTLo82duF1bUpjQPCCG+n6lnvmGpB34MHAt3DAC6
         mcSj8SgPG95datBvSq94vIC7tckVWYCkg1wvSBns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 101/162] NFSv4: Fix a nfs4_state_manager() race
Date:   Mon,  9 Oct 2023 15:01:22 +0200
Message-ID: <20231009130125.712978911@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index ed789e0cb9431..457b2b2f804ab 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2710,6 +2710,13 @@ static void nfs4_state_manager(struct nfs_client *clp)
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



