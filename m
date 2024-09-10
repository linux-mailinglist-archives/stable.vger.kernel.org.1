Return-Path: <stable+bounces-74450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94904972F5C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A1CDB25646
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A26017BB01;
	Tue, 10 Sep 2024 09:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tm7lDarp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA243188CC4;
	Tue, 10 Sep 2024 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961840; cv=none; b=cYKNgL4w7B3D+u/G4BuTpbZG63c3CwC4YLrG9uVPggF5UCSxdRoSq0hXAL86/XhzkLYbYU9Gqi80OvWKlPjvPrOeAhmu21ySbJVYm6tylph7Y5P3GTuI/Jilcf/JKxp4AoqBbzIZFMc6qgvjdW+eY1MR9SNOTpY6tIag/jIyUn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961840; c=relaxed/simple;
	bh=VcveBPWE5aeME1lSkqoWweZyuypu6gL6WDTFmT2iMho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBLo9bTdKalv9orZDAGzgCQvZu3nBb+clo2kRRWlvJqK6dYrGrJv0HTkRSu4vfaEfNu8sQlykNk1b7Zw0UpxL2JSzlmAVDSTwXElqXhleqHvE685MXPYqg/bKSjRixRwr8rs5wXf0gkfuT/vip2gSBxkG+XrIc+QdSr2jhU/OUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tm7lDarp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38D9C4CEC3;
	Tue, 10 Sep 2024 09:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725961840;
	bh=VcveBPWE5aeME1lSkqoWweZyuypu6gL6WDTFmT2iMho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tm7lDarpND1f0hSS+Us6v1hxfJTwfCuyaIQPzVffr9bneeIFPAsA4t7/RgSnydV+C
	 0+HY19/1PX1tcPTbuRbPJ+pV5Ja9JEzMAXqP33IVCtGqOmPfT7esM/m+znUeFOpXUN
	 pTBxUntNfyXT6mcjguwmBGICbSde9/WLmZqAwp58=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 207/375] block: dont call bio_uninit from bio_endio
Date: Tue, 10 Sep 2024 11:30:04 +0200
Message-ID: <20240910092629.459841129@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit bf4c89fc8797f5c0964a0c3d561fbe7e8483b62f ]

Commit b222dd2fdd53 ("block: call bio_uninit in bio_endio") added a call
to bio_uninit in bio_endio to work around callers that use bio_init but
fail to call bio_uninit after they are done to release the resources.
While this is an abuse of the bio_init API we still have quite a few of
those left.  But this early uninit causes a problem for integrity data,
as at least some users need the bio_integrity_payload.  Right now the
only one is the NVMe passthrough which archives this by adding a special
case to skip the freeing if the BIP_INTEGRITY_USER flag is set.

Sort this out by only putting bi_blkg in bio_endio as that is the cause
of the actual leaks - the few users of the crypto context and integrity
data all properly call bio_uninit, usually through bio_put for
dynamically allocated bios.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20240702151047.1746127-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e9e809a63c59..c7a4bc05c43e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1630,8 +1630,18 @@ void bio_endio(struct bio *bio)
 		goto again;
 	}
 
-	/* release cgroup info */
-	bio_uninit(bio);
+#ifdef CONFIG_BLK_CGROUP
+	/*
+	 * Release cgroup info.  We shouldn't have to do this here, but quite
+	 * a few callers of bio_init fail to call bio_uninit, so we cover up
+	 * for that here at least for now.
+	 */
+	if (bio->bi_blkg) {
+		blkg_put(bio->bi_blkg);
+		bio->bi_blkg = NULL;
+	}
+#endif
+
 	if (bio->bi_end_io)
 		bio->bi_end_io(bio);
 }
-- 
2.43.0




