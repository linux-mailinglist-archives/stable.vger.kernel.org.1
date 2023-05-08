Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4B6FAACE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjEHLGo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbjEHLG0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA32C91B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B7AD62A74
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E7AC433EF;
        Mon,  8 May 2023 11:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543912;
        bh=P3W5YrNDzx5SS2ocMteFdnJlj3b6PdNMkOPFR6PYjVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpruBwAIWdmsiQi7cSu5frdNRw7gJe9HrGYly//Had2E5qe9Z6K6vsbZuzllad17k
         UBp4qd8Up25Z83Pm0INhgLV8TFm0ZwWJMGUL78j2aOjS5L5o+8xXAm9r3pTqK4EX4c
         D9puOAVpRz/mOhCTOcBcv89FZ97BAXNeTPftRX/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Auger <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 240/694] ACPI: VIOT: Initialize the correct IOMMU fwspec
Date:   Mon,  8 May 2023 11:41:15 +0200
Message-Id: <20230508094440.122336738@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

[ Upstream commit 47d26684185d09e083669bbbd0c465ab3493a51f ]

When setting up DMA for a PCI device, we need to initialize its
iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
this we use pci_for_each_dma_alias() which calls
viot_pci_dev_iommu_init(). This function incorrectly initializes the
fwspec of the bridge instead of the device being configured. Fix it by
passing the original device as context to pci_for_each_dma_alias().

Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
Link: https://lore.kernel.org/all/Y8qzOKm6kvhGWG1T@myrica
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/viot.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index ed752cbbe6362..c8025921c129b 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -328,6 +328,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 {
 	u32 epid;
 	struct viot_endpoint *ep;
+	struct device *aliased_dev = data;
 	u32 domain_nr = pci_domain_nr(pdev->bus);
 
 	list_for_each_entry(ep, &viot_pci_ranges, list) {
@@ -338,7 +339,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
+			return viot_dev_iommu_init(aliased_dev, ep->viommu,
 						   epid);
 		}
 	}
@@ -372,7 +373,7 @@ int viot_iommu_configure(struct device *dev)
 {
 	if (dev_is_pci(dev))
 		return pci_for_each_dma_alias(to_pci_dev(dev),
-					      viot_pci_dev_iommu_init, NULL);
+					      viot_pci_dev_iommu_init, dev);
 	else if (dev_is_platform(dev))
 		return viot_mmio_dev_iommu_init(to_platform_device(dev));
 	return -ENODEV;
-- 
2.39.2



