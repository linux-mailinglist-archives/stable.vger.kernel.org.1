Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952CA7BE0B7
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377307AbjJINnR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346443AbjJINnQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:43:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEEBB6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:43:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984F2C433C8;
        Mon,  9 Oct 2023 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858995;
        bh=41uqaong4k6+E57StNdecvUQydfrUVATMX2m0S23Q8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BoaGRGEhN1faxr+9VZSLp2jD504AoD46lHq7U9b8g1SXxab3g5Gw/92QEW88X6RAo
         9MEjbkxB410kFtri/7a6vgpGNajcI2NypmUPi/Cjc3obgHg4ijtlbyfPreuqHuUy7o
         M5tTeUAV3NfsebeNsTVU8GfTcZXIRhqF8rTycFuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Coddington <bcodding@redhat.com>,
        NeilBrown <neilb@suse.de>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 166/226] NFS: Cleanup unused rpc_clnt variable
Date:   Mon,  9 Oct 2023 15:02:07 +0200
Message-ID: <20231009130131.006341816@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit e025f0a73f6acb920d86549b2177a5883535421d ]

The root rpc_clnt is not used here, clean it up.

Fixes: 4dc73c679114 ("NFSv4: keep state manager thread active if swap is enabled")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Stable-dep-of: 956fd46f97d2 ("NFSv4: Fix a state manager thread deadlock regression")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4state.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index ff6ca05a9d441..3fcef19e91984 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1212,10 +1212,6 @@ void nfs4_schedule_state_manager(struct nfs_client *clp)
 {
 	struct task_struct *task;
 	char buf[INET6_ADDRSTRLEN + sizeof("-manager") + 1];
-	struct rpc_clnt *cl = clp->cl_rpcclient;
-
-	while (cl != cl->cl_parent)
-		cl = cl->cl_parent;
 
 	set_bit(NFS4CLNT_RUN_MANAGER, &clp->cl_state);
 	if (test_and_set_bit(NFS4CLNT_MANAGER_AVAILABLE, &clp->cl_state) != 0) {
-- 
2.40.1



