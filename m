Return-Path: <stable+bounces-192870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22488C44A2C
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E350F188C294
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE98B1D6DA9;
	Sun,  9 Nov 2025 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlaHQWGA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB92D221299
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730868; cv=none; b=XIFv7qYX/N4Ja8ijnlziQP9L7/nwHb4K15RWGl/+QTljC8VmHZQUF/pLtwkDDL/wcWROZVKyxo2+0d022gHsty4DG+sqGnimVTt78RszbTfNIhhLFOQx6xooke1XJXQ2i6Rx8i1LhH6lkGhiMRrtVwF22Lq1MQ20IYQtCM4n/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730868; c=relaxed/simple;
	bh=AJL0M+acIUlJ5PR0d34sHYnS0tlJkpciCp0/gbHzztI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bwa8bILNz87Q0b7Nf5d7R1BTLhN7AafPf3jrovyaPs1Ktmk+ApMvDKKkoktrzy30XUwBrU2DCEiOzpEGM9g1v3cfyvHC46d8ljuAsD9gvF/Xhnp7D4fvS42YXfdwkYuvoHbu8t+odJQpue4NQNz9G+FWPq7Z5VYfCXFWImifw+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlaHQWGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419DBC4CEF7;
	Sun,  9 Nov 2025 23:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762730868;
	bh=AJL0M+acIUlJ5PR0d34sHYnS0tlJkpciCp0/gbHzztI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlaHQWGAfJxw0MPIqMWIVtb9EEwE1duRSwwoGs+zX1dMh1EcgoR3i+qHH17cuS8gj
	 +4AU4W2WI/UdHhVeEuM+dFFwSPk2+XCOBlO3gNIW2QscrLpKONSmTyUNjPOq9ygSdt
	 5zIQ0c5KE5J+sx5uBwZr/pu8J7lAsHLSOqYdTs/gDMdBXHVkWeqOlePj3R6lox19Rc
	 Kexf2fjSm4jC6Z9+8MfaXpzV9QfWOZGUgpG8qW/X24LIYxKfPbYw0V2IH9zrFtNZnO
	 ZvljI1YzgoWhUo7d7KBQ26yuy1YUaHnUtH1po26A4h+kh7z/7YoHmMxpF7SViIDdAu
	 YyUb57bfeGz/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iommufd: Don't overflow during division for dirty tracking
Date: Sun,  9 Nov 2025 18:27:45 -0500
Message-ID: <20251109232745.533736-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110935-stylist-chastise-3700@gregkh>
References: <2025110935-stylist-chastise-3700@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@ziepe.ca>

[ Upstream commit cb30dfa75d55eced379a42fd67bd5fb7ec38555e ]

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
[ drivers/iommu/iommufd/iova_bitmap.c => drivers/vfio/iova_bitmap.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/iova_bitmap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/iova_bitmap.c b/drivers/vfio/iova_bitmap.c
index 76ef63b940d96..eab0de7799fa2 100644
--- a/drivers/vfio/iova_bitmap.c
+++ b/drivers/vfio/iova_bitmap.c
@@ -126,9 +126,8 @@ struct iova_bitmap {
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
-- 
2.51.0


