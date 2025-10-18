Return-Path: <stable+bounces-187842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006CEBED1B8
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 16:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21CD5E19D8
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 14:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2961D7999;
	Sat, 18 Oct 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqTFCzoU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0B185B67
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760799093; cv=none; b=m+J30PdgdyRIo+cDovJ9oWcOrfai9Yo+xWAL9A0WSuX+PHmIxvqSYoiLXHDqhLXPT1ArDUEmhxoxgo74w4d2Od8dbLooeIchtXhR5gV2RuYOnnCF3cWeoAYxLwdQrtnGuiZWDyan34k0LTupImDgeaCL2u7rRQ0yiygNSxb4g/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760799093; c=relaxed/simple;
	bh=E9LrDr+bFvomIu5wJ7hqk4+KJUcmPCsa8Bog+JQ2jxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzzhiJsDo+bYf+yD3StAOLjaYPi557tVsWeuarhV4TfNbe0OrzPfd+Gpb+u6nwXCjQnkUHxuoI2cScKNL2epTknwdfQai/T10MIYe/rBCxsYBnT6z+Ri6ZpGEg/knWhEtevJOJ0dPJ453GUfhBhusFxOakmzsLKWSPhIpVlX7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqTFCzoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3B7C4CEF8;
	Sat, 18 Oct 2025 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760799092;
	bh=E9LrDr+bFvomIu5wJ7hqk4+KJUcmPCsa8Bog+JQ2jxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqTFCzoUXouwa3vnXFnzp2q887x7zO7EOmSm+xcqIvvqogInNAIfwmLgRMcUvkW2A
	 s+nQ+pBV3pzvFH+ricFPE887+rGgRINao9p4Kb59I1onV8WZXbnsw3OyK90N4OdFUf
	 mSLzL2urkR9aYYINExog2K9B8mLgUGV43f/HP+7JIDEdKO/p58ZTtGpUAopXEz3Pmv
	 nRwiFlTWBynT6diX7avKJuCTwHmsUAd6njCJt5O5itMuVsGbMlIzSKymf7g/J/oGTH
	 wKCaeDHoz+/VZzZM4srDwnJvxhgVygALMPSXVZhN5arqBpCDqyty9XUVlDuCx9y0rV
	 3TOs/WA+efMYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] blk-crypto: fix missing blktrace bio split events
Date: Sat, 18 Oct 2025 10:51:29 -0400
Message-ID: <20251018145130.791122-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101656-curdle-duration-949d@gregkh>
References: <2025101656-curdle-duration-949d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 06d712d297649f48ebf1381d19bd24e942813b37 ]

trace_block_split() is missing, resulting in blktrace inability to catch
BIO split events and making it harder to analyze the BIO sequence.

Cc: stable@vger.kernel.org
Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ changed blk_crypto_fallback_split_bio_if_needed() to blk_crypto_split_bio_if_needed() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-crypto-fallback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index c322176a1e099..e47716fe289dd 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -18,6 +18,7 @@
 #include <linux/mempool.h>
 #include <linux/module.h>
 #include <linux/random.h>
+#include <trace/events/block.h>
 
 #include "blk-crypto-internal.h"
 
@@ -231,7 +232,9 @@ static bool blk_crypto_split_bio_if_needed(struct bio **bio_ptr)
 			bio->bi_status = BLK_STS_RESOURCE;
 			return false;
 		}
+
 		bio_chain(split_bio, bio);
+		trace_block_split(split_bio, bio->bi_iter.bi_sector);
 		submit_bio_noacct(bio);
 		*bio_ptr = split_bio;
 	}
-- 
2.51.0


