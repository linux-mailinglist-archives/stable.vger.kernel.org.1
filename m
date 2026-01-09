Return-Path: <stable+bounces-207322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 343FBD09C70
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A37330C85A0
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94D033B6C6;
	Fri,  9 Jan 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HRELTyWv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F131A7EA;
	Fri,  9 Jan 2026 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961725; cv=none; b=mWV8ib5xnGQ3tgowPE3DYjYFB5K5b/U9yodttY2vV5vpz+LOBPSykfCRRnZPRMdUONft+1Iv2CRINxay97MPxocKMWMWH+UZeVNJcqu92mo9oRFvd5E4XP++0z2zAMRiyVHya+1lBtB4dqi4g2up9kPnGLoM7l9VV15IABu5fiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961725; c=relaxed/simple;
	bh=uwRpUNFKlDcpRr81Qcr6Q/Wxyw4ilvT31bONgFHJUzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUwcsb9v9SrjyjLT/s4mOTMAmOvxKcW73mLkln1yHYZet7jcWXL16txAQCGPzTsxEt2DpwYV6nIVGepI7K/y6YUA1nq/5OOTKdKYvQaipR2wRaK2R+aDUUr49BpEtEqdADMWo9+AqtOtoNVw3ijBVUVU24nxabI8q5bi6Td0p1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HRELTyWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6DFC4CEF1;
	Fri,  9 Jan 2026 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767961725;
	bh=uwRpUNFKlDcpRr81Qcr6Q/Wxyw4ilvT31bONgFHJUzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRELTyWvAFPYYF/gzWio1/W1qDymiylry01Sn/344eRb3ZqJ/DuDGnWfstbSHQpn9
	 zSvNn2uXa/WuI3mCnBpGEI6yTGFj+a8zzTOCqmpsF1+l/XcDK2wdQKoR6JsLwcOXBT
	 6JZirxLbN85/58d/LwYVN4ehluZu/DvomfVdP+Lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactco.de>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 115/634] ps3disk: use memcpy_{from,to}_bvec index
Date: Fri,  9 Jan 2026 12:36:33 +0100
Message-ID: <20260109112121.760614122@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rene Rebe <rene@exactco.de>

[ Upstream commit 79bd8c9814a273fa7ba43399e1c07adec3fc95db ]

With 6e0a48552b8c (ps3disk: use memcpy_{from,to}_bvec) converting
ps3disk to new bvec helpers, incrementing the offset was accidently
lost, corrupting consecutive buffers. Restore index for non-corrupted
data transfers.

Fixes: 6e0a48552b8c (ps3disk: use memcpy_{from,to}_bvec)
Signed-off-by: René Rebe <rene@exactco.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ps3disk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 36d7b36c60c76..79d3779e1c7ad 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -85,10 +85,14 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 	struct bio_vec bvec;
 
 	rq_for_each_segment(bvec, req, iter) {
+		dev_dbg(&dev->sbd.core, "%s:%u: %u sectors from %llu\n",
+			__func__, __LINE__, bio_sectors(iter.bio),
+			iter.bio->bi_iter.bi_sector);
 		if (gather)
 			memcpy_from_bvec(dev->bounce_buf + offset, &bvec);
 		else
 			memcpy_to_bvec(&bvec, dev->bounce_buf + offset);
+		offset += bvec.bv_len;
 	}
 }
 
-- 
2.51.0




