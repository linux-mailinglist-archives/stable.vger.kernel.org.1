Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3647D3251
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjJWLSz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjJWLSx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:18:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C6892
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:18:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB32C433C7;
        Mon, 23 Oct 2023 11:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059930;
        bh=i/kDMz6kp2Tn4eAygMPi3hZkj3WY6UMEFU9NI5yHkyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXx+U0QoW0eShLh758aZNENNwJUJyc64vdY/m/gEbHRI4E51jNH5CIpGYGRcnUMpx
         AKS2cE540V4b6GElQXIsni5s0RPSTMaz5pX9F4/SaCplq2WBkf6H3hUwJF9/gwpP9i
         8B1bjOBpr76dTjRWJ1W81njdt1KvNMkXMqHXBt2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 4.19 92/98] s390/pci: fix iommu bitmap allocation
Date:   Mon, 23 Oct 2023 12:57:21 +0200
Message-ID: <20231023104816.776812564@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Schnelle <schnelle@linux.ibm.com>

commit c1ae1c59c8c6e0b66a718308c623e0cb394dab6b upstream.

Since the fixed commits both zdev->iommu_bitmap and zdev->lazy_bitmap
are allocated as vzalloc(zdev->iommu_pages / 8). The problem is that
zdev->iommu_bitmap is a pointer to unsigned long but the above only
yields an allocation that is a multiple of sizeof(unsigned long) which
is 8 on s390x if the number of IOMMU pages is a multiple of 64.
This in turn is the case only if the effective IOMMU aperture is
a multiple of 64 * 4K = 256K. This is usually the case and so didn't
cause visible issues since both the virt_to_phys(high_memory) reduced
limit and hardware limits use nice numbers.

Under KVM, and in particular with QEMU limiting the IOMMU aperture to
the vfio DMA limit (default 65535), it is possible for the reported
aperture not to be a multiple of 256K however. In this case we end up
with an iommu_bitmap whose allocation is not a multiple of
8 causing bitmap operations to access it out of bounds.

Sadly we can't just fix this in the obvious way and use bitmap_zalloc()
because for large RAM systems (tested on 8 TiB) the zdev->iommu_bitmap
grows too large for kmalloc(). So add our own bitmap_vzalloc() wrapper.
This might be a candidate for common code, but this area of code will
be replaced by the upcoming conversion to use the common code DMA API on
s390 so just add a local routine.

Fixes: 224593215525 ("s390/pci: use virtual memory for iommu bitmap")
Fixes: 13954fd6913a ("s390/pci_dma: improve lazy flush for unmap")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/pci/pci_dma.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -545,6 +545,17 @@ static void s390_dma_unmap_sg(struct dev
 		s->dma_length = 0;
 	}
 }
+
+static unsigned long *bitmap_vzalloc(size_t bits, gfp_t flags)
+{
+	size_t n = BITS_TO_LONGS(bits);
+	size_t bytes;
+
+	if (unlikely(check_mul_overflow(n, sizeof(unsigned long), &bytes)))
+		return NULL;
+
+	return vzalloc(bytes);
+}
 	
 static int s390_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
@@ -586,13 +597,13 @@ int zpci_dma_init_device(struct zpci_dev
 				zdev->end_dma - zdev->start_dma + 1);
 	zdev->end_dma = zdev->start_dma + zdev->iommu_size - 1;
 	zdev->iommu_pages = zdev->iommu_size >> PAGE_SHIFT;
-	zdev->iommu_bitmap = vzalloc(zdev->iommu_pages / 8);
+	zdev->iommu_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
 	if (!zdev->iommu_bitmap) {
 		rc = -ENOMEM;
 		goto free_dma_table;
 	}
 	if (!s390_iommu_strict) {
-		zdev->lazy_bitmap = vzalloc(zdev->iommu_pages / 8);
+		zdev->lazy_bitmap = bitmap_vzalloc(zdev->iommu_pages, GFP_KERNEL);
 		if (!zdev->lazy_bitmap) {
 			rc = -ENOMEM;
 			goto free_bitmap;


