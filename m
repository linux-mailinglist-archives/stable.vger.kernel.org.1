Return-Path: <stable+bounces-169867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3991EB2909E
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 23:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA135A75E5
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C79218851;
	Sat, 16 Aug 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAls4bfU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678421DFDE
	for <stable@vger.kernel.org>; Sat, 16 Aug 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755378358; cv=none; b=HaDE01QU9GUoKOcnys4syqHjrXsjZu4bH1dcRWiY5UEwHKoUn/o566R7W5Umq8k9u2F5Ttor2BvuZ5K+Sd9UQ2wzSTb6WTeTZUhwJRx4CrWnlb3sVa68eUg4cNzu1ttkIvmG85On33Yt04yxDzTpnEK5OD662sd6k55K12y0lOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755378358; c=relaxed/simple;
	bh=dVbgOrn/mYq/IoA8JAHdPidPRMjNUoKHXMnXIztDKrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=satPnnokWp9cbkRizTptgvKrD5sXwq41G5JdV2rYsBwqw+p9edFocO+hm/aghWnTkNmj3Hmk2F4p+spjg3L5TJ1/KxUaGzMOOBN7m+c5zHR7Lzx82l6zboatO1opOL9JUdqLTons7ox2SedOIHNnGrCHPHjU//Jj91Rblf5x4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAls4bfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A78FC4CEEF;
	Sat, 16 Aug 2025 21:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755378358;
	bh=dVbgOrn/mYq/IoA8JAHdPidPRMjNUoKHXMnXIztDKrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAls4bfUV3KcRfYkzhyh7XvFA3cXRatZWOl3AwhgqIukrMISnNyz6u/uYqjBjjIIo
	 +Izzjp92ClmpLGBl7M44xyPzFQvIjTKiDn81jsdqWgYhNKFfoGYCTOvAnbhc43Dx5N
	 n4O6MFG647LwokCO5/65bsbOTa+dEulD/Gf9sguWlEWy+7AlGwjsfqoJF+hBTtgYGL
	 MTj1tBDTD4zTWLIe4OFAO11p2pgqjyTTgnVURuD4skf8xmI31Z14uJmtmnjehOI8ZH
	 Z20c3fcTV9bzo3+kwvTrNnYcquU/gRBB2lmyKyojOCpst1VDUTeJ31AxNcd+PvH4y3
	 jyon2DBO7nDUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] block: Make REQ_OP_ZONE_FINISH a write operation
Date: Sat, 16 Aug 2025 17:05:52 -0400
Message-ID: <20250816210552.1246430-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081544-slackness-vantage-3e99@gregkh>
References: <2025081544-slackness-vantage-3e99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit 3f66ccbaaef3a0c5bd844eab04e3207b4061c546 ]

REQ_OP_ZONE_FINISH is defined as "12", which makes
op_is_write(REQ_OP_ZONE_FINISH) return false, despite the fact that a
zone finish operation is an operation that modifies a zone (transition
it to full) and so should be considered as a write operation (albeit
one that does not transfer any data to the device).

Fix this by redefining REQ_OP_ZONE_FINISH to be an odd number (13), and
redefine REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_ALL using sequential
odd numbers from that new value.

Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250625093327.548866-2-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ More renumbering... ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/blk_types.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 36ce3d0fb9f3..86da1c97e4ab 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -341,13 +341,13 @@ enum req_opf {
 	/* Close a zone */
 	REQ_OP_ZONE_CLOSE	= 11,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= 12,
+	REQ_OP_ZONE_FINISH	= 13,
 	/* write data at the current zone write pointer */
-	REQ_OP_ZONE_APPEND	= 13,
+	REQ_OP_ZONE_APPEND	= 15,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= 15,
+	REQ_OP_ZONE_RESET	= 17,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= 17,
+	REQ_OP_ZONE_RESET_ALL	= 19,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= 34,
-- 
2.50.1


