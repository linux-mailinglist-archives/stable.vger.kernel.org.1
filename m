Return-Path: <stable+bounces-162609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8326DB05E99
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF39558019F
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A402E6D26;
	Tue, 15 Jul 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f0CHgzkH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239572DEA72;
	Tue, 15 Jul 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587005; cv=none; b=Ti8POJ9UOZ4o+9csD4ByFi7sL0LP9ACpYBKTii3d05SJwd+1fU5KaEUWiXOVjIs5g8rNtlKMFEV/TodXWQyTOZ2pUR47oLYCFY9FpxehiTf1Qly7GbgYvGaYof3At7HBQxNqawwbsBUFHpyCoFEfLlKPMu/ctY44LAahy+bwhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587005; c=relaxed/simple;
	bh=OHpGAv27Zp0dKGLXoDC6/+epby1B/MMYt6II+wZWbZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFgK18isp6NB9yw9c4axmoAdzl+TYKp7mxGhX3nSt1v1OX1J3WQPBavhUZoZvUpJm4wwE+DVbDKowymKBxBElFTyVFKs7KzB/VjrRkjyxfrcaa0pTkM/3Z40B2ZXa9heP6no5diy0p1nVR/tyqxZJ9o2Uu+IJrasVU1p6EmAKGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f0CHgzkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A955FC4CEE3;
	Tue, 15 Jul 2025 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587005;
	bh=OHpGAv27Zp0dKGLXoDC6/+epby1B/MMYt6II+wZWbZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0CHgzkH3AeXthN53Y07uSzR0PGm52txle286XGtXd5VJC5D61xNyENCIaUJDQbkn
	 RwyEvX7hwDtNl0Abbaa/Kbu+itFOqvlhq5qCzxNzL7jCPq3jsoQohtMqFFSmFGbuUl
	 TtQkyjnoCV9DsLQNNEpCiKWsqAjPbpe62ncdGMOM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nigel Croxon <ncroxon@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 131/192] raid10: cleanup memleak at raid10_make_request
Date: Tue, 15 Jul 2025 15:13:46 +0200
Message-ID: <20250715130820.153655262@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nigel Croxon <ncroxon@redhat.com>

[ Upstream commit 43806c3d5b9bb7d74ba4e33a6a8a41ac988bde24 ]

If raid10_read_request or raid10_write_request registers a new
request and the REQ_NOWAIT flag is set, the code does not
free the malloc from the mempool.

unreferenced object 0xffff8884802c3200 (size 192):
   comm "fio", pid 9197, jiffies 4298078271
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 88 41 02 00 00 00 00 00  .........A......
     08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace (crc c1a049a2):
     __kmalloc+0x2bb/0x450
     mempool_alloc+0x11b/0x320
     raid10_make_request+0x19e/0x650 [raid10]
     md_handle_request+0x3b3/0x9e0
     __submit_bio+0x394/0x560
     __submit_bio_noacct+0x145/0x530
     submit_bio_noacct_nocheck+0x682/0x830
     __blkdev_direct_IO_async+0x4dc/0x6b0
     blkdev_read_iter+0x1e5/0x3b0
     __io_read+0x230/0x1110
     io_read+0x13/0x30
     io_issue_sqe+0x134/0x1180
     io_submit_sqes+0x48c/0xe90
     __do_sys_io_uring_enter+0x574/0x8b0
     do_syscall_64+0x5c/0xe0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

V4: changing backing tree to see if CKI tests will pass.
The patch code has not changed between any versions.

Fixes: c9aa889b035f ("md: raid10 add nowait support")
Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
Link: https://lore.kernel.org/linux-raid/c0787379-9caa-42f3-b5fc-369aed784400@redhat.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid10.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 54320a887ecc5..0443a479809f9 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1182,8 +1182,11 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		}
 	}
 
-	if (!regular_request_wait(mddev, conf, bio, r10_bio->sectors))
+	if (!regular_request_wait(mddev, conf, bio, r10_bio->sectors)) {
+		raid_end_bio_io(r10_bio);
 		return;
+	}
+
 	rdev = read_balance(conf, r10_bio, &max_sectors);
 	if (!rdev) {
 		if (err_rdev) {
@@ -1370,8 +1373,11 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	}
 
 	sectors = r10_bio->sectors;
-	if (!regular_request_wait(mddev, conf, bio, sectors))
+	if (!regular_request_wait(mddev, conf, bio, sectors)) {
+		raid_end_bio_io(r10_bio);
 		return;
+	}
+
 	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 	    (mddev->reshape_backwards
 	     ? (bio->bi_iter.bi_sector < conf->reshape_safe &&
-- 
2.39.5




