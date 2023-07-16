Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DC875526A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGPUHh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjGPUHg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:07:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C869B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AECC860EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05BCC433C8;
        Sun, 16 Jul 2023 20:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538055;
        bh=iKLTh0xBqzIrPLXK+Eh1VJ/riM9VXM9o2bHUZQvE8jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGxINFwJXZVN6PXyzEofJ7JDmD2BUbhgIACYhZMFLj+OQREiEWuO63PHyjYvybsgH
         fH8OLCpeSM54RI3i8XPcw4l2ywb2DHyn6vg3Xu91yDbDHQ4E6qizF51uwIahslIrkr
         h2M6yduPD+MyjQVlvb/0/aqjRwXovsEPqEyc4/U8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Akihiko Odaki <akihiko.odaki@daynix.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 279/800] iommu/virtio: Detach domain on endpoint release
Date:   Sun, 16 Jul 2023 21:42:12 +0200
Message-ID: <20230716194955.570744812@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

[ Upstream commit 809d0810e3520da669d231303608cdf5fe5c1a70 ]

When an endpoint is released, for example a PCIe VF being destroyed or a
function hot-unplugged, it should be detached from its domain. Send a
DETACH request.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/r/20230515113946.1017624-2-jean-philippe@linaro.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 5b8fe9bfa9a5b..fd316a37d7562 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -788,6 +788,29 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+static void viommu_detach_dev(struct viommu_endpoint *vdev)
+{
+	int i;
+	struct virtio_iommu_req_detach req;
+	struct viommu_domain *vdomain = vdev->vdomain;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
+
+	if (!vdomain)
+		return;
+
+	req = (struct virtio_iommu_req_detach) {
+		.head.type	= VIRTIO_IOMMU_T_DETACH,
+		.domain		= cpu_to_le32(vdomain->id),
+	};
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		req.endpoint = cpu_to_le32(fwspec->ids[i]);
+		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
+	}
+	vdomain->nr_endpoints--;
+	vdev->vdomain = NULL;
+}
+
 static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			    int prot, gfp_t gfp, size_t *mapped)
@@ -990,6 +1013,7 @@ static void viommu_release_device(struct device *dev)
 {
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 
+	viommu_detach_dev(vdev);
 	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
-- 
2.39.2



