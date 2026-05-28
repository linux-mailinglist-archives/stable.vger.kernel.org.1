Return-Path: <stable+bounces-255490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFfEEZChGGqblggAu9opvQ
	(envelope-from <stable+bounces-255490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:12:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527B5F80A8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4EE83036FB2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3603352019;
	Thu, 28 May 2026 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZXX2amdr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73156335566;
	Thu, 28 May 2026 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999058; cv=none; b=u2rluL9jcO0rkYuldZFfwKR4AaLbE/1NTGrIJ7UFJAnnjYUuKmAXmJxLLdgnksT2figjQ7EbxxvDQ2YP4/zNB/eYgpA7c+ww6MnSfcfpG4/EMuFZA4cTJuRUGpM8zoAD949WWUI/rQB6fUWc+0ttN44EUfFg1Gi0H1iQyP466uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999058; c=relaxed/simple;
	bh=dLpSV2Z/sMjAXhnznAGiRf/aLP5rWGbIb7kM4sq9H2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PH82HUPoZNpfeDGHjW0T+3A4NcDJpEEk/bMkIS2rB92fOeZgSDmwvKd7NNGuouHbjo8YW7pmIXVSVsPMMuaS9BJQnTO1UtqGX+vOQOgSQyjNAzKeg4V6COd5svA30kNvJc3QYbj/DY+vFQKA0L9KmzRtJLtbRCcgoQxouJLai0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZXX2amdr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A631F000E9;
	Thu, 28 May 2026 20:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999057;
	bh=a1wOe/DOVO16XrVwsZSwUPgXLnxiHj+q4cJb8L1qMO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXX2amdrvONvSIxe5Ir/jvkpb8Tzw5p3IH6gIJmBxQp9kOuBF8KbPG7p+c20/eev5
	 isJFDDNoteLtIqgHUh/jU3rWBWEmwRTcwnJ6oPdjHPjeQavriChZFE/IP+Fq8RqjH1
	 LE9xE7s4WoRSr+7O7Kg9KMccZaWHRUoa/+Sp4lUI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 357/461] dma-mapping: move dma_map_resource() sanity check into debug code
Date: Thu, 28 May 2026 21:48:06 +0200
Message-ID: <20260528194657.758355334@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255490-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,samsung.com:email,arm.com:email,nvidia.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0527B5F80A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>

[ Upstream commit af0c3f05866237f7592219bfe05387bc3bfc99b5 ]

dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
However, pfn_valid() only checks for availability of the memory map for
a PFN but it does not ensure that the PFN is actually backed by RAM. On
ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
share a section with RAM will falsely trigger the WARN_ON_ONCE and cause
dma_map_resource() to return DMA_MAPPING_ERROR.

This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
the SPI FIFO register (0xfe204004) falls in the same sparsemem section
as the end of RAM (0xf8000000-0xfbffffff), both in section 31
(0xf8000000-0xffffffff).

Move the sanity check from dma_map_resource() into debug_dma_map_phys()
and replace the unreliable pfn_valid() with pfn_valid() &&
!PageReserved(), which correctly identifies actual usable RAM without
false positives for MMIO regions that happen to have struct pages.

Since dma_map_resource() is dma_map_phys(DMA_ATTR_MMIO), the check
applies equally to both APIs. Any non-reserved page represents kernel
memory to a sufficient degree that using DMA_ATTR_MMIO on it is almost
certainly wrong and risks breaking coherency on non-coherent platforms.
ZONE_DEVICE pages used for PCI P2P DMA (MEMORY_DEVICE_PCI_P2PDMA) have
PageReserved set, so they will not trigger a false positive.

The check no longer blocks the mapping and uses err_printk() to
integrate with dma-debug filtering.

Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260513072209.1486986-1-jianpeng.chang.cn@windriver.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c   | 9 ++++++++-
 kernel/dma/mapping.c | 4 ----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 1a725edbbbf6a..3248f8b4d096d 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1251,7 +1251,14 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	entry->direction = direction;
 	entry->map_err_type = MAP_ERR_NOT_CHECKED;
 
-	if (!(attrs & DMA_ATTR_MMIO)) {
+	if (attrs & DMA_ATTR_MMIO) {
+		unsigned long pfn = PHYS_PFN(phys);
+
+		if (pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)))
+			err_printk(dev, entry,
+				   "dma_map_resource called for RAM address %pa\n",
+				   &phys);
+	} else {
 		check_for_stack(dev, phys);
 
 		if (!PhysHighMem(phys))
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 6d3dd0bd3a886..5d59372f42770 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -356,10 +356,6 @@ EXPORT_SYMBOL(dma_unmap_sg_attrs);
 dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
-	    WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
-		return DMA_MAPPING_ERROR;
-
 	return dma_map_phys(dev, phys_addr, size, dir, attrs | DMA_ATTR_MMIO);
 }
 EXPORT_SYMBOL(dma_map_resource);
-- 
2.53.0




