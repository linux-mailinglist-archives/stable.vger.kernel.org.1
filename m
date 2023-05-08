Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027826FA5D9
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjEHKNq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbjEHKNe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:13:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868A23AA34
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:13:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1536A6241D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254D9C433D2;
        Mon,  8 May 2023 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540805;
        bh=0voffYRagMHE6TiQX/na/15uQAS/80GKqLy6uw1vOUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AslCHnTHULQQHVtVq3Obc5xX6Vo9w2r8Z3wJhIHzhpuBBuboz5FWzolW6FBw45fX0
         d2wK6KNMLS40ViwSHywCKmbV++XHaGtA5ah6AUWLandj+lu9Y+VI0cd/A3O6ebmlgl
         bGN+o+9sSgxHtFjgTsMk00OBvjHTZNKUeNdA7W+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 504/611] NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease
Date:   Mon,  8 May 2023 11:45:46 +0200
Message-Id: <20230508094438.451805264@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 40882deb83c29d8df4470d4e5e7f137b6acf7ad1 ]

The spec requires that we always at least send a RECLAIM_COMPLETE when
we're done establishing the lease and recovering any state.

Fixes: fce5c838e133 ("nfs41: RECLAIM_COMPLETE functionality")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 03087ef1c7b4a..5b49e5365bb30 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -67,6 +67,8 @@
 
 #define OPENOWNER_POOL_SIZE	8
 
+static void nfs4_state_start_reclaim_reboot(struct nfs_client *clp);
+
 const nfs4_stateid zero_stateid = {
 	{ .data = { 0 } },
 	.type = NFS4_SPECIAL_STATEID_TYPE,
@@ -330,6 +332,8 @@ int nfs41_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	status = nfs4_proc_create_session(clp, cred);
 	if (status != 0)
 		goto out;
+	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
+		nfs4_state_start_reclaim_reboot(clp);
 	nfs41_finish_session_reset(clp);
 	nfs_mark_client_ready(clp, NFS_CS_READY);
 out:
-- 
2.39.2



