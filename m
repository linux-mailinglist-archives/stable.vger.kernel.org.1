Return-Path: <stable+bounces-12776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E8883735E
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F389B20C6F
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D83FE58;
	Mon, 22 Jan 2024 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I3EzxtMJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91BD3FB26
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953569; cv=none; b=DVmm7Xk/muPE8M8X+TVpOeLjW74K6QbslbUdUSL55A3U+QZvmUQ1/PuVsATo64wrhFzfEXB8paPNc0qrTO5n0v5pGmOrb1lsPnUM+7lh69CfKbES4J9ZYIpmC9SqoI+TW6EekmEja9/2CEEX/h6ujG/l5PxFBaOQbBuHo/tS+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953569; c=relaxed/simple;
	bh=SEHKMKO3Jfju34ZwVWX7A16qwH3zsnoz/NQLwKXQYOs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mIeWQgdIvN8tR/e66yWIexE8jpOQRiSN4Mx9HvxjLQJtYGlrkOyq93LH/i1Xd5wYUQvlWmsk0EOqBfGOWJHbq6HXrU3ef8m1mCDKiFclRW2XdP1t8e2GHGMC8u26ZZlaz1GiZabQrpqthNgEgDA7eyRDL605t8BdP/niHxZiOtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I3EzxtMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1B3C433F1;
	Mon, 22 Jan 2024 19:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705953569;
	bh=SEHKMKO3Jfju34ZwVWX7A16qwH3zsnoz/NQLwKXQYOs=;
	h=Subject:To:Cc:From:Date:From;
	b=I3EzxtMJQKqccT5rpjJRQX+F4QCdVW7WuRIydpeTv2ZWrEi1V2ZBoU5Q14MVc0YA6
	 vX1o0Mg/mzM9PVK3AqkU5UfN89jGUeXokwoIr7Me1UQt7255IC0U320e92PHhdN3RZ
	 zGTNicqD96D9ZZWAziQzvk4cdE3mzEaY7RhoU/RI=
Subject: FAILED: patch "[PATCH] iommu/dma: Trace bounce buffer usage when mapping buffers" failed to apply to 5.15-stable tree
To: isaacmanjarres@google.com,baolu.lu@linux.intel.com,jroedel@suse.de,murphyt7@tcd.ie,saravanak@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:59:26 -0800
Message-ID: <2024012226-unmanned-marshy-5819@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x a63c357b9fd56ad5fe64616f5b22835252c6a76a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012226-unmanned-marshy-5819@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

a63c357b9fd5 ("iommu/dma: Trace bounce buffer usage when mapping buffers")
f316ba0a8814 ("dma-iommu: Check that swiotlb is active before trying to use it")
a17e3026bc4d ("iommu: Move flush queue data into iommu_dma_cookie")
f7f07484542f ("iommu/iova: Move flush queue code to iommu-dma")
ea4d71bb5e3f ("iommu/iova: Consolidate flush queue code")
87f60cc65d24 ("iommu/vt-d: Use put_pages_list")
649ad9835a37 ("iommu/iova: Squash flush_cb abstraction")
d5c383f2c98a ("iommu/iova: Squash entry_dtor abstraction")
d7061627d701 ("iommu/iova: Fix race between FQ timeout and teardown")
2e727bffbe93 ("iommu/dma: Check CONFIG_SWIOTLB more broadly")
9b49bbc2c4df ("iommu/dma: Fold _swiotlb helpers into callers")
ee9d4097cc14 ("iommu/dma: Skip extra sync during unmap w/swiotlb")
06e620345d54 ("iommu/dma: Fix arch_sync_dma for map")
08ae5d4a1ae9 ("iommu/dma: Fix sync_sg with swiotlb")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a63c357b9fd56ad5fe64616f5b22835252c6a76a Mon Sep 17 00:00:00 2001
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Date: Fri, 8 Dec 2023 15:41:40 -0800
Subject: [PATCH] iommu/dma: Trace bounce buffer usage when mapping buffers

When commit 82612d66d51d ("iommu: Allow the dma-iommu api to
use bounce buffers") was introduced, it did not add the logic
for tracing the bounce buffer usage from iommu_dma_map_page().

All of the users of swiotlb_tbl_map_single() trace their bounce
buffer usage, except iommu_dma_map_page(). This makes it difficult
to track SWIOTLB usage from that function. Thus, trace bounce buffer
usage from iommu_dma_map_page().

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Cc: stable@vger.kernel.org # v5.15+
Cc: Tom Murphy <murphyt7@tcd.ie>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Link: https://lore.kernel.org/r/20231208234141.2356157-1-isaacmanjarres@google.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85163a83df2f..037fcf826407 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
+#include <trace/events/swiotlb.h>
 
 #include "dma-iommu.h"
 
@@ -1156,6 +1157,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 			return DMA_MAPPING_ERROR;
 		}
 
+		trace_swiotlb_bounced(dev, phys, size);
+
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
 					      iova_mask(iovad), dir, attrs);


