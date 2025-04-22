Return-Path: <stable+bounces-134984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C47BA95BF0
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2436177A8D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BE12741C2;
	Tue, 22 Apr 2025 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiNluy+G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DEF270ED2;
	Tue, 22 Apr 2025 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288335; cv=none; b=AbfidtThweQfWPUnfcTFaKwyEIPJvOlKE1iIW3EWrG9mlGcFxDwPnuAeWJhxdTh2ixl7jWbrgVP/Z/3jfeu99OaLqsiB3/XJLU8OgOVd03uFoQ8+DrA9++QflM+k4ol48JE0okNvM9xS3/NtDUyAltOZv0qbAgtyfZuIVK76B6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288335; c=relaxed/simple;
	bh=3CdyHjIPA33wSfxaOgW6QQTe7emoA28YH/w1xuqXcno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lvn4MgFcmk1gKLDgGDEU/4XSQCJcJHEFCUUMRQSn8LyXILzP7lgz8yjVwXdIlETV2y+Z8DHLuRcTV9/xawjIMQtGl/8i6/VZBsBb2bNWZmhJTiPkK6d8tijXcl9S+cFqHjp3SGPsGjvFEMzR1Z7Gljzg+bvKUZ6F5/9+Ci/sJ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiNluy+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BF5C4CEED;
	Tue, 22 Apr 2025 02:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288334;
	bh=3CdyHjIPA33wSfxaOgW6QQTe7emoA28YH/w1xuqXcno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kiNluy+GIKv5kLLhRZ4inJu0JWtLCIwTdX8OTKR0qFPuKxr67C7MvRqDwjuVIzrdM
	 OgFj4T12Q/BjJIirdIrlhtpoc4BfsKhdO04buq4BrPHH8u+/C3eBBkYZDeBmim2XNw
	 UTpwxqw8KIkYpJCYSWvX1JIwmFuPbGTUe9ApYFGIzIORKJG9TQotAypM3eKwgSk6WI
	 Yxmuo1PySedokfdn3RIYwFqgjKiXEfd5D7BfaDzE/nEv1GaAOPnM+WujTjojnE3G4t
	 7bz1qhLb1/GvDnTXZJZPsQEIEGTFMBrpS8tC1vHdA79nyQZcHtwgd/TWAoH35ESY2Y
	 iYownZrJazLXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Meir Elisha <meir.elisha@volumez.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	song@kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 5/6] md/raid1: Add check for missing source disk in process_checks()
Date: Mon, 21 Apr 2025 22:18:45 -0400
Message-Id: <20250422021846.1941972-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021846.1941972-1-sashal@kernel.org>
References: <20250422021846.1941972-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
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
index 8427c9767a61b..de87606b2e04c 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2063,14 +2063,9 @@ static int fix_sync_read_error(struct r1bio *r1_bio)
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
@@ -2210,10 +2205,21 @@ static void sync_request_write(struct mddev *mddev, struct r1bio *r1_bio)
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


