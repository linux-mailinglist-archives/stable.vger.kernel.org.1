Return-Path: <stable+bounces-220481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPTwH+83o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB0F1C63A3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DFDE316618A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F239B3C54A4;
	Sat, 28 Feb 2026 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByvovmCm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561D3C549B;
	Sat, 28 Feb 2026 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300367; cv=none; b=IlUbQGxclWKY1A90MwF9n1AEfUBwgt8xpK4pQmNv/seFNFvBaHFmTzusluthg3QUC69Wtn6x2mBUVgx5oG+BuH6oQAI86YtkM6RagmweHVU5DDzhGN4KgKtugeuPxFAOU/QbomnHC4/YtJbI3LZWI/Z2N38/8lO2wwsvYa5t6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300367; c=relaxed/simple;
	bh=OIBxYoi4uypns6AwCV0b1xVjceQlkEIKTS9RSHW11rY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VihOiYe0ZidkmvG6jcqO5d3xYsupGgGFiCz68ROas2+XCrCmrT3x32cljC05rYWK/JjV5KerOcOLbh7aB3MvjY9eq0EptnXaun88TbVrPb+3YXLB8QmzwZFsQR4NRjvoyYVtMKnFT1O3Y+Wv4cHyjEyHQReBtXmfxxT70YQjfCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByvovmCm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B55C116D0;
	Sat, 28 Feb 2026 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300367;
	bh=OIBxYoi4uypns6AwCV0b1xVjceQlkEIKTS9RSHW11rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ByvovmCmVpASp4QKhoMppCvInPpoJ+zB1rycLnrXXX+uC74/JRC2qrGOIs+uOhhyB
	 6XBloSuylRgbOgCqTyhp8xwVKAg4BcrZIFXn9Sb2ResfmyOMibqGqQVVFIMcBqnULE
	 WVHCiuxkK7kBW0w4pFK41ulGOnMfuKIhy49AB8lVi6Q3tIHqoxieUyovLhI6Erj59n
	 HX9Sw7/UityFPcKX1j5WUrQfi39RBf9FxqbF69J5yjtgDkW2+c28mFfeZ6roVJOou5
	 AUgV3+OePOOutkjrt5hVs9EbDLoH117INrQXWU9SGmu11drGU27EpuOZMEnumT+28W
	 UfqR/oXh43U2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 402/844] block: fix partial IOVA mapping cleanup in blk_rq_dma_map_iova
Date: Sat, 28 Feb 2026 12:25:15 -0500
Message-ID: <20260228173244.1509663-403-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220481-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CCB0F1C63A3
X-Rspamd-Action: no action

From: Chaitanya Kulkarni <kch@nvidia.com>

[ Upstream commit 81e7223b1a2d63b655ee72577c8579f968d037e3 ]

When dma_iova_link() fails partway through mapping a request's bvec
list, the function breaks out of the loop without cleaning up
already mapped segments. Similarly, if dma_iova_sync() fails after
linking all segments, no cleanup is performed.

This leaves partial IOVA mappings in place. The completion path
attempts to unmap the full expected size via dma_iova_destroy() or
nvme_unmap_data(), but only a partial size was actually mapped,
leading to incorrect unmap operations.

Add an out_unlink error path that calls dma_iova_destroy() to clean
up partial mappings before returning failure. The dma_iova_destroy()
function handles both partial unlink and IOVA space freeing. It
correctly handles the mapped_len == 0 case (first dma_iova_link()
failure) by only freeing the IOVA allocation without attempting to
unmap.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq-dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index fb018fffffdcc..feead1934301a 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -126,17 +126,20 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
 				vec->len, dir, attrs);
 		if (error)
-			break;
+			goto out_unlink;
 		mapped += vec->len;
 	} while (blk_map_iter_next(req, &iter->iter, vec));
 
 	error = dma_iova_sync(dma_dev, state, 0, mapped);
-	if (error) {
-		iter->status = errno_to_blk_status(error);
-		return false;
-	}
+	if (error)
+		goto out_unlink;
 
 	return true;
+
+out_unlink:
+	dma_iova_destroy(dma_dev, state, mapped, dir, attrs);
+	iter->status = errno_to_blk_status(error);
+	return false;
 }
 
 static inline void blk_rq_map_iter_init(struct request *rq,
-- 
2.51.0


