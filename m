Return-Path: <stable+bounces-153471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F7FADD4E4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8A53A4029
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A332ED157;
	Tue, 17 Jun 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FtjL4bSJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A642E92CD;
	Tue, 17 Jun 2025 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176071; cv=none; b=Vw6/C4nj5ekiaTcN9qyPj7QCwDU+jkRBZKPyXaZ7rjss5tg8IRsjQH8Zyg5nj7mg+xk6eBVcFtjmoN0zRnqTl043ut4mEfZtZwWfNN0qHskRUb3/kUJW/vosJwnu7ncHSSOuvGU3FCgWX1kKyKHfAq73V7nXNtWUI03MEzpH84I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176071; c=relaxed/simple;
	bh=NxavLxI984YPjCQSJmQwkKes+3btoJiNDRLPkuR2d/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icGC4z/4jOG5T7vSsSssNAGzka9OLmmLaxjqi3sJiPaoSCLY9GPtI+JQtm70krdGkOdeT4eD8hkIM16LYlIGG76Qb/hKZo7VoaccisaYBRMr3hX+4trp9pv4GNuKNg1cd52U+Odu2Xb6BArKgiBrY6MHErwhTm9aGdKnWXnpqjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FtjL4bSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC2AC4CEE3;
	Tue, 17 Jun 2025 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176071;
	bh=NxavLxI984YPjCQSJmQwkKes+3btoJiNDRLPkuR2d/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtjL4bSJq1i8Ez57q5hyfzPIE8jIGyiNlBGR6PSExTfar+zpTpWb8EPBwqrI3f4XB
	 cmCvjTJu8ni9I8TQ4L3gt/n/N+6dI+Tr8ug+8dKMNO9pfXm49pEUy3ntUl0sR8844C
	 Twbs8T1xsPxHT5anTwkAu72CJyHcrAVICw0s3aq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Li RongQing <lirongqing@baidu.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 193/512] vfio/type1: Fix error unwind in migration dirty bitmap allocation
Date: Tue, 17 Jun 2025 17:22:39 +0200
Message-ID: <20250617152427.464051719@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 4518e5a60c7fbf0cdff393c2681db39d77b4f87e ]

When setting up dirty page tracking at the vfio IOMMU backend for
device migration, if an error is encountered allocating a tracking
bitmap, the unwind loop fails to free previously allocated tracking
bitmaps.  This occurs because the wrong loop index is used to
generate the tracking object.  This results in unintended memory
usage for the life of the current DMA mappings where bitmaps were
successfully allocated.

Use the correct loop index to derive the tracking object for
freeing during unwind.

Fixes: d6a4c185660c ("vfio iommu: Implementation of ioctl for dirty pages tracking")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Link: https://lore.kernel.org/r/20250521034647.2877-1-lirongqing@baidu.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index bf391b40e576f..8338cfd61fe14 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -294,7 +294,7 @@ static int vfio_dma_bitmap_alloc_all(struct vfio_iommu *iommu, size_t pgsize)
 			struct rb_node *p;
 
 			for (p = rb_prev(n); p; p = rb_prev(p)) {
-				struct vfio_dma *dma = rb_entry(n,
+				struct vfio_dma *dma = rb_entry(p,
 							struct vfio_dma, node);
 
 				vfio_dma_bitmap_free(dma);
-- 
2.39.5




