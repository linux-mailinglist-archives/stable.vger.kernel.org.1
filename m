Return-Path: <stable+bounces-169830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF08B2882F
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 00:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DC1AC379A
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 22:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8B623956A;
	Fri, 15 Aug 2025 22:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTq5Inze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962328399
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755295684; cv=none; b=KR5JgGPF9Ia7HcFsJBXVGxGGvB+ctBUnSTKPX19524vtJNrs8eZjKPJ8XScusQdcTydiqtJ+cIsG6Xv0g1iyqVcBbLMi4THnBHS9UIbQzadP7EGO8AGzBdOBcONob4TP1xRO32ItQRCVnTBqLxiC8tlGtcm1FFoZCnR/P/TsNBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755295684; c=relaxed/simple;
	bh=fji00ayqVXhHDycHigNT5yJGfPf4bDaiL7AiflMHJeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ED89o8rgEsG92c+EyHKG6Vyp//ls0lOB5LWyGuTmbwhyE6JK3YKgxipI+4qVNb2n22+TknXxW98sobm1j7QMnWCEcfMVtzb2vmtsWfcVyEncqb5mJw9YKQOIdpxLCML93xDeZ14c3tjn0MbxPWQE92Hnf2/TPjunAYW51y4sATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTq5Inze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04281C4CEF0;
	Fri, 15 Aug 2025 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755295683;
	bh=fji00ayqVXhHDycHigNT5yJGfPf4bDaiL7AiflMHJeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTq5Inzeu9i3pwqclkF2hGqoipvTeF6wKWz3tHXykwBjkVcXwnJkNhjYrC4MjNA8e
	 6hUw2UJTKm1yTNWRm0P0+MCO7fnlemjzg1PHMBvkUJS/3ONkq69Eg+Q0l08sMGPbW7
	 dYp0lJEesN/Lo6StPwL85ymxXbOoUpShfsbkfcymLz947E+8LLqEl+QWPXYATlEOA8
	 JHjpqTrG1b6PC8TVeLJMX+iCtAFEUhGCZ8xCa30LmIbKLYaQ9BQqT+KgQSfZQhRI53
	 DtquejAcMmB8AvfFtKvE72bx9oIpxYCCrLXs26ELflayVpy4mkA279CirUbkXhzJRf
	 HsSEWFPHadqYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] block: Make REQ_OP_ZONE_FINISH a write operation
Date: Fri, 15 Aug 2025 18:07:59 -0400
Message-ID: <20250815220759.248365-2-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815220759.248365-1-sashal@kernel.org>
References: <2025081543-graffiti-nastily-6e2b@gregkh>
 <20250815220759.248365-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/blk_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 9fe714522249..b9c0b3281ace 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -388,11 +388,11 @@ enum req_op {
 	/* Close a zone */
 	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
 	/* Transition a zone to full */
-	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
+	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)13,
 	/* reset a zone write pointer */
-	REQ_OP_ZONE_RESET	= (__force blk_opf_t)13,
+	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
 	/* reset all the zone present on the device */
-	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
+	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
 
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
-- 
2.50.1


