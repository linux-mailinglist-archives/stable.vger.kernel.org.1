Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E84875549E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjGPUcU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbjGPUcT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E731BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DE0160E2C
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6F7C433C8;
        Sun, 16 Jul 2023 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539537;
        bh=07SUWhg/e3h0ngKq0/29/n0cgKYansyBHZBlRJt5eGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KmFvXlzQyMKpv4lx3Zw1LUbI29F2+AIsTSp0H5Ngd40E1WGMKr8Y+mcZRCIucrGmI
         UOAb0U1iq6ZaLu29q8BdxZ1L/XJfIB9QZWEWoFzneWq7c6S43S4kEfTpWzIbOD7jzh
         gTPQVGU/P/oT8rijJt2eF5up4Yoo+78a5uuu2B5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 015/591] nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_dhchap
Date:   Sun, 16 Jul 2023 21:42:34 +0200
Message-ID: <20230716194924.260141960@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 0a7ce375f83f4ade7c2a835444093b6870fb8257 ]

nvme_auth_[reset|free] operate on the controller while
__nvme_auth_[reset|free] operate on a chap struct (which maps to a queue
context). Rename it for clarity.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: a836ca33c5b0 ("nvme-core: fix memory leak in dhchap_secret_store")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/auth.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c8a6db7c44980..d45333268fcf6 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -654,7 +654,7 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 	return 0;
 }
 
-static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
+static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 {
 	kfree_sensitive(chap->host_response);
 	chap->host_response = NULL;
@@ -676,9 +676,9 @@ static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
 	memset(chap->c2, 0, sizeof(chap->c2));
 }
 
-static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
+static void nvme_auth_free_dhchap(struct nvme_dhchap_queue_context *chap)
 {
-	__nvme_auth_reset(chap);
+	nvme_auth_reset_dhchap(chap);
 	if (chap->shash_tfm)
 		crypto_free_shash(chap->shash_tfm);
 	if (chap->dh_tfm)
@@ -868,7 +868,7 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 			dev_dbg(ctrl->device, "qid %d: re-using context\n", qid);
 			mutex_unlock(&ctrl->dhchap_auth_mutex);
 			flush_work(&chap->auth_work);
-			__nvme_auth_reset(chap);
+			nvme_auth_reset_dhchap(chap);
 			queue_work(nvme_wq, &chap->auth_work);
 			return 0;
 		}
@@ -928,7 +928,7 @@ void nvme_auth_reset(struct nvme_ctrl *ctrl)
 	list_for_each_entry(chap, &ctrl->dhchap_auth_list, entry) {
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		flush_work(&chap->auth_work);
-		__nvme_auth_reset(chap);
+		nvme_auth_reset_dhchap(chap);
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 }
@@ -1002,7 +1002,7 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 	list_for_each_entry_safe(chap, tmp, &ctrl->dhchap_auth_list, entry) {
 		list_del_init(&chap->entry);
 		flush_work(&chap->auth_work);
-		__nvme_auth_free(chap);
+		nvme_auth_free_dhchap(chap);
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	if (ctrl->host_key) {
-- 
2.39.2



