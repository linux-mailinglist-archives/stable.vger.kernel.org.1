Return-Path: <stable+bounces-192864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFC8C44A0B
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 00:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77AF34E4BC7
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 23:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9E723BD1B;
	Sun,  9 Nov 2025 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SD6OkGgE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC721891AB
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 23:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730446; cv=none; b=oisi80kQwD7MSGJcEipOZra2XnMn9zH/ySDv0Ysc0HHGSpMIIpx2A7YQ2t8B2CGE1hMV5mkUP8D34UWNMHk01ZgZq2V3xZVFCEPJvk+5SS/Q73T8tAvrk/QKUCKfEWZ6lXh/B0ddFvBAir5L3nntNLegZxcrRQYUysnpdop/ngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730446; c=relaxed/simple;
	bh=zpfcTlGhej2jrFsVb8BghCsx1mvMa8mTpWX0mRhBF08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUspQjZUIZLGV14URk/m3ffEEJVihNqJgwllVM6WqlRFwrcNXFaHOCiQKboBj5hQYCudWbLyJNZUYhLejplCnsRz6nJTQAHqq69xzU70RJAnKAwiXda6OdaMXDNjvUEhSgJvRatPyvrEc4G46sDNrJUEZnQN0SleVbqMeD0bMrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SD6OkGgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9720C19422;
	Sun,  9 Nov 2025 23:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762730445;
	bh=zpfcTlGhej2jrFsVb8BghCsx1mvMa8mTpWX0mRhBF08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SD6OkGgEtwqMuJG9OVZ4hIM3FT9ugxS8wveZG3AzIVwte1YrZy3o8qemAfT3cqh7B
	 Ib+/ZfI8Aaphd0ex1OhuOfU43mDe8jwovLmE1IU7Upfte7IisAxh23qgR3QoBWw57P
	 UE/2Jnsbnv38dsM0fzm1fndmIt0zVONnlGqvv/PrSeWGko4ap0j7KnmhBh8BeDVpTq
	 bnargNRQqDTO/JTSpgCZ+olsTznBt+31q+im5tCS1zNu/20PmCLPrQu1bxItMS9CDh
	 wERGbTtGoqLjXW4Ct/lHlz5rWOexWGQlAxj/p0tDUMONDK5ZMpUfuql2nLT/35YrGP
	 uwW9hdQHeIwkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	syzbot+093a8a8b859472e6c257@syzkaller.appspotmail.com,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iommufd: Don't overflow during division for dirty tracking
Date: Sun,  9 Nov 2025 18:20:42 -0500
Message-ID: <20251109232042.530964-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110937-numbing-unworthy-d5de@gregkh>
References: <2025110937-numbing-unworthy-d5de@gregkh>
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
index 38b51613ecca9..3f48125e2b9f0 100644
--- a/drivers/vfio/iova_bitmap.c
+++ b/drivers/vfio/iova_bitmap.c
@@ -127,9 +127,8 @@ struct iova_bitmap {
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


