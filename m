Return-Path: <stable+bounces-11722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E1682FB14
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C42928C26A
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 21:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D55D15EAA3;
	Tue, 16 Jan 2024 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjLv0eoY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0687915EAA4;
	Tue, 16 Jan 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435332; cv=none; b=uE+nvvKrmvIIO6FlfmB2fL23e+bkx6yES1dCThPjKxirSEoxP9jfvSfzqgf7KTaDShbiFgm9qLy2U4ZFl1ZHyRB/4pibi2Vxz2CbqTtDPaYUbm/pn3qE0wbUyOirR1Ry/RjkKMfVdUzwN9Un4hW7RlXuubdvcaYyRisuHxn9uPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435332; c=relaxed/simple;
	bh=vjZYyZeDl59BTyWU7LFYGlJ62/taRWr+zV/pUjW8rkY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=bmv58R5EFA8WvItM0ocFDg4cQd5yoQhrELu6MpCpjrFbvqh7/T1BBip00C2NNOTlyUk33Qxg/b1IxUDanUv8/wM93u91fk4u3IaQcBmDftM5fzelm/s5Ex3tpY9AwISgPwT4w32VI5y/2jHz0GQeLNRoQhfBWw9M6N/Wew7l9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjLv0eoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B039CC43399;
	Tue, 16 Jan 2024 20:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435331;
	bh=vjZYyZeDl59BTyWU7LFYGlJ62/taRWr+zV/pUjW8rkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjLv0eoYjqWxVbmqhga/b1/Of/OrUpkkFH/Xk48YJ/JRu80srKawXRrRG29mUMvWt
	 BT4h2yQ3XcdONwY7C+sPRp7cUVdE/G4P1/zB0Tttwf1UzctpwZxDetw+JPcxLjIbBp
	 u40QjgoWwafKhCMycgIH20WZhlSyIn11tSkHFcB2yWS8Y9Z/B91O7aNnKpQfZiUcY2
	 QRpnX1HmL5FlWW6AQZKz/lC/7pYBZoKffu9PKwGX6xoO+LXCpc/azY5cxsPDQ7T+Kh
	 sMA0hlSnX+fvkIkBiKoeaEkd1wEkxr4qdMKB3EJIlRpYP+D1yrJN6FGmM3Kj8Ufjs2
	 NmINoUGxeEaEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 33/44] block: prevent an integer overflow in bvec_try_merge_hw_page
Date: Tue, 16 Jan 2024 15:00:02 -0500
Message-ID: <20240116200044.258335-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 3f034c374ad55773c12dd8f3c1607328e17c0072 ]

Reordered a check to avoid a possible overflow when adding len to bv_len.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20231204173419.782378-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 6d6e7b96b002..5c442ebc5500 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -770,7 +770,7 @@ static bool bio_try_merge_hw_seg(struct request_queue *q, struct bio *bio,
 
 	if ((addr1 | mask) != (addr2 | mask))
 		return false;
-	if (bv->bv_len + len > queue_max_segment_size(q))
+	if (len > queue_max_segment_size(q) - bv->bv_len)
 		return false;
 	return __bio_try_merge_page(bio, page, len, offset, same_page);
 }
-- 
2.43.0


