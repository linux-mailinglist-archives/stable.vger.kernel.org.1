Return-Path: <stable+bounces-192802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A27C437A7
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DDC188B245
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01B1B85FD;
	Sun,  9 Nov 2025 03:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IfnhKmTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0796A189906
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657839; cv=none; b=IoX9USOS9JqRc7MkYjwGnKvubqBOcaNVDic5so3B3tXcnE6/nPPMHS2VGl/a6w1pioLAJ1PoXEiTzukuSDAuoJ0gFihasUo5daXWXvMyQOtfbrQOBZ7eGiWDOK9IQ4rHDzUJkbjFKpYMiVUvSuQdAswxMLMPEmbnbN+avebFCsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657839; c=relaxed/simple;
	bh=tl7Ld7BBfSl9aV1pZbbKuIwFdBxvOMhU9VvsfcpxF6U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NRHcp6oXrKzzAbV/VH9vPArPBzLoHdQ9Ya0lTbWuVac0OM+QsiDmi6v0cmwPoQsnpBL3QPobHNNOWwMTSEtrZHondvl2nRQ0ls4A59wcpnPp6UWgDotoVGutx5t24+oNpYa6F8N5TzzDroMnQ8TuOLpqC4gaauJsvlygZKU4RIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IfnhKmTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0BAC4CEF5;
	Sun,  9 Nov 2025 03:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762657838;
	bh=tl7Ld7BBfSl9aV1pZbbKuIwFdBxvOMhU9VvsfcpxF6U=;
	h=Subject:To:Cc:From:Date:From;
	b=IfnhKmTjatuyju5EB/c2/Clu1aW3jiqyhgmEyssStl11MncNPkxcDIzw5oOmiYI+K
	 ibNxOgILiyNg4JgCRBXDC8E2XK/tdLbz3FQSghM2xkkcF+x2NHnMzIJM8cyVd3l1Pr
	 v8PBdKER/lbsi/Zs1Sid//KYFoZT3a2052L6wNa0=
Subject: FAILED: patch "[PATCH] iommufd: Don't overflow during division for dirty tracking" failed to apply to 6.1-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com,joao.m.martins@oracle.com,kevin.tian@intel.com,nicolinc@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:10:35 +0900
Message-ID: <2025110935-stylist-chastise-3700@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cb30dfa75d55eced379a42fd67bd5fb7ec38555e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110935-stylist-chastise-3700@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cb30dfa75d55eced379a42fd67bd5fb7ec38555e Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Wed, 8 Oct 2025 15:17:18 -0300
Subject: [PATCH] iommufd: Don't overflow during division for dirty tracking

If pgshift is 63 then BITS_PER_TYPE(*bitmap->bitmap) * pgsize will overflow
to 0 and this triggers divide by 0.

In this case the index should just be 0, so reorganize things to divide
by shift and avoid hitting any overflows.

Link: https://patch.msgid.link/r/0-v1-663679b57226+172-iommufd_dirty_div0_jgg@nvidia.com
Cc: stable@vger.kernel.org
Fixes: 58ccf0190d19 ("vfio: Add an IOVA bitmap support")
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reported-by: syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=093a8a8b859472e6c257
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 4514575818fc..b5b67a9d3fb3 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -130,9 +130,8 @@ struct iova_bitmap {
 static unsigned long iova_bitmap_offset_to_index(struct iova_bitmap *bitmap,
 						 unsigned long iova)
 {
-	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;
-
-	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);
+	return (iova >> bitmap->mapped.pgshift) /
+	       BITS_PER_TYPE(*bitmap->bitmap);
 }
 
 /*


