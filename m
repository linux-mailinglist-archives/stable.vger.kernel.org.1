Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1519D74C314
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjGIL2G (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjGIL2F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9679713D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3538460BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B02C433C7;
        Sun,  9 Jul 2023 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902083;
        bh=rJbJ5dbHadLA+e0Lyeh8vKhF6hT2DijOWtDDSrMQy6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MSzsWNRStAv8Ij5Jlryo2fEy/QrjJdjBwxCVhecf/Dy8nCBFvaQjn549DHgH+9m0j
         ZyNE/JNAJaeKeiFVrOWEIB31g/LEG7DGzpCvvi1CgGQfUWVfkv4XmlpGi8Llb6BMV6
         0wzFFjCrfZ+u2H7Bpo6sEMg+g9q9/P6+tJu3uIbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 211/431] iommu/virtio: Return size mapped for a detached domain
Date:   Sun,  9 Jul 2023 13:12:39 +0200
Message-ID: <20230709111456.113892342@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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

[ Upstream commit 7061b6af34686e7e2364b7240cfb061293218f2d ]

When map() is called on a detached domain, the domain does not exist in
the device so we do not send a MAP request, but we do update the
internal mapping tree, to be replayed on the next attach. Since this
constitutes a successful iommu_map() call, return *mapped in this case
too.

Fixes: 7e62edd7a33a ("iommu/virtio: Add map/unmap_pages() callbacks implementation")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20230515113946.1017624-3-jean-philippe@linaro.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/virtio-iommu.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index fd316a37d7562..3551ed057774e 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -833,25 +833,26 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 	if (ret)
 		return ret;
 
-	map = (struct virtio_iommu_req_map) {
-		.head.type	= VIRTIO_IOMMU_T_MAP,
-		.domain		= cpu_to_le32(vdomain->id),
-		.virt_start	= cpu_to_le64(iova),
-		.phys_start	= cpu_to_le64(paddr),
-		.virt_end	= cpu_to_le64(end),
-		.flags		= cpu_to_le32(flags),
-	};
-
-	if (!vdomain->nr_endpoints)
-		return 0;
+	if (vdomain->nr_endpoints) {
+		map = (struct virtio_iommu_req_map) {
+			.head.type	= VIRTIO_IOMMU_T_MAP,
+			.domain		= cpu_to_le32(vdomain->id),
+			.virt_start	= cpu_to_le64(iova),
+			.phys_start	= cpu_to_le64(paddr),
+			.virt_end	= cpu_to_le64(end),
+			.flags		= cpu_to_le32(flags),
+		};
 
-	ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
-	if (ret)
-		viommu_del_mappings(vdomain, iova, end);
-	else if (mapped)
+		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
+		if (ret) {
+			viommu_del_mappings(vdomain, iova, end);
+			return ret;
+		}
+	}
+	if (mapped)
 		*mapped = size;
 
-	return ret;
+	return 0;
 }
 
 static size_t viommu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
-- 
2.39.2



