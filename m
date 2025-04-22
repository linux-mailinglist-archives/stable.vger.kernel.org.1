Return-Path: <stable+bounces-134987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A52A95BF7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2F1188A653
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E117D27602F;
	Tue, 22 Apr 2025 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNR0wzLR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A7276024;
	Tue, 22 Apr 2025 02:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288340; cv=none; b=EoYwdvTOKMiFmYDFd0AnAcg+EHIaIg03axkhEaqOMrJRnUXbtJSVMBOXYA3mEitWYpIllAF8XWC1Eq5zcr2cwH70mnXsspKCO/5Rm0HebhjyCbDvWvIazTdsuIDjSUf40/frQSwnJjgEK9f5W5/nnoJ90m3c8ft39zZwrZPf0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288340; c=relaxed/simple;
	bh=pgXhOfQvL8s8yHa7U5vOct4qfwHa/rcUshJY9724B+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K4RL8YK+l/rtnhKW1Ku9mqrAs7XJIGrmDtM1+oKeh4utmr0Hj8Ku91tpZidj62qnfZ4C3fyMjmBu37DqaZqEpcTs5dbbFw72AaCGYlDoJfxT/qnG9CGs956SHbSwXwAcMHz8a/IblEzfAwb1vIAhEYYRKRiZxqBrM3ZdcXgiKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNR0wzLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A956AC4CEE4;
	Tue, 22 Apr 2025 02:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288340;
	bh=pgXhOfQvL8s8yHa7U5vOct4qfwHa/rcUshJY9724B+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNR0wzLREHxSpSomjJdUvh8RYwJdYJlOpb9kkO/3pH6251cLiALpeV0+BG+FLcrad
	 M/L6WcQRg3MmW3OjnuE0uczXTe2G4gYiBfv5WHrKvA6A0jkxN8VlNCLKmwE6iAT9Ti
	 HXfiO+kahYnL3n/gIq7kt6DXdxCDKhNMeah/r+DmhJPFeRkvvrebbolL6pyDwIbZtU
	 LHfSN9MTJimRgYojth+yX81e4HSzHVvMunn4QzNLbKRekfwqFadRvKsE4K9GkdW5pD
	 SvQJDV4TBLXOQrbLUsBTDN2SOE+wMufqIKp+W2IozV3Tch/VYwQ4UkySTHWWKEaqqo
	 inS1u2iurVKfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Meir Elisha <meir.elisha@volumez.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	song@kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/3] md/raid1: Add check for missing source disk in process_checks()
Date: Mon, 21 Apr 2025 22:18:55 -0400
Message-Id: <20250422021856.1942063-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021856.1942063-1-sashal@kernel.org>
References: <20250422021856.1942063-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
Content-Transfer-Encoding: 8bit

From: Meir Elisha <meir.elisha@volumez.com>

[ Upstream commit b7c178d9e57c8fd4238ff77263b877f6f16182ba ]

During recovery/check operations, the process_checks function loops
through available disks to find a 'primary' source with successfully
read data.

If no suitable source disk is found after checking all possibilities,
the 'primary' index will reach conf->raid_disks * 2. Add an explicit
check for this condition after the loop. If no source disk was found,
print an error message and return early to prevent further processing
without a valid primary source.

Link: https://lore.kernel.org/linux-raid/20250408143808.1026534-1-meir.elisha@volumez.com
Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
Suggested-and-reviewed-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3619db7e382a0..dada9b2258a61 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2034,14 +2034,9 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
 				if (!rdev_set_badblocks(rdev, sect, s, 0))
 					abort = 1;
 			}
-			if (abort) {
-				conf->recovery_disabled =
-					mddev->recovery_disabled;
-				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-				md_done_sync(mddev, r1_bio->sectors, 0);
-				put_buf(r1_bio);
+			if (abort)
 				return 0;
-			}
+
 			/* Try next page */
 			sectors -= s;
 			sect += s;
@@ -2181,10 +2176,21 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
 	int disks = conf->raid_disks * 2;
 	struct bio *wbio;
 
-	if (!test_bit(R1BIO_Uptodate, &r1_bio->state))
-		/* ouch - failed to read all of that. */
-		if (!fix_sync_read_error(r1_bio))
+	if (!test_bit(R1BIO_Uptodate, &r1_bio->state)) {
+		/*
+		 * ouch - failed to read all of that.
+		 * No need to fix read error for check/repair
+		 * because all member disks are read.
+		 */
+		if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) ||
+		    !fix_sync_read_error(r1_bio)) {
+			conf->recovery_disabled = mddev->recovery_disabled;
+			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+			md_done_sync(mddev, r1_bio->sectors, 0);
+			put_buf(r1_bio);
 			return;
+		}
+	}
 
 	if (test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
 		process_checks(r1_bio);
-- 
2.39.5


