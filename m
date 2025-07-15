Return-Path: <stable+bounces-162610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097EB05E2D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E67B666B
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2E2E339C;
	Tue, 15 Jul 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+y/pITx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F828937D;
	Tue, 15 Jul 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587007; cv=none; b=ppdUlYT1BJHgvYTWXxVguu22LtQU4fNhIyp7dv4ByicwP+69TQTQ32fPUpFl+VQRvKRJt3XKWJiCt1jxq7oKPzqzBOjYyTqkgPhNIHt4KAgZBKKaKm53pg0EZBLfUxtocFtUy6nR7FYUcU/nV1Ef0VgEv2uvleFjqHamIG1XijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587007; c=relaxed/simple;
	bh=L0M4afixRbLolkrnyafjDwaYUm8jd8cdtSQy/y619FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4GguFZk3AT9PDyd3egkZxJBb7ft/u4XTnhzxuHkqocnEVKziEKhrcIkkjkOrH+Eg75xsYP/GlGdp1aF0cVW4jx7/XpmQnLehBl2k/gaaoMnQx8Jaf0jFOLB+06ilFgmfm2yjznJSGyQVatHUDj6VM2WfbqtQF9fk/N0U8KeaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+y/pITx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AFFC4CEE3;
	Tue, 15 Jul 2025 13:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752587007;
	bh=L0M4afixRbLolkrnyafjDwaYUm8jd8cdtSQy/y619FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+y/pITxE8wQ+zqVZfo/ZAKjRCjAIqewj9gTrhUN5np9dXyQesrsHHC5i2TM7+0fM
	 Alqp/FabfK+udnQNT9RKs18mfc4EftDB/7nsw4KjvDVjqvPg8CngPmQ7afbE5zP2Uk
	 p2AJmtZA8MLFOTZ5rLuH57/t18CquJA2Na2V2AUM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zheng Qixing <zhengqixing@huawei.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 132/192] md/raid1,raid10: strip REQ_NOWAIT from member bios
Date: Tue, 15 Jul 2025 15:13:47 +0200
Message-ID: <20250715130820.196871588@linuxfoundation.org>
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

From: Zheng Qixing <zhengqixing@huawei.com>

[ Upstream commit 5fa31c49928139fa948f078b094d80f12ed83f5f ]

RAID layers don't implement proper non-blocking semantics for
REQ_NOWAIT, making the flag potentially misleading when propagated
to member disks.

This patch clear REQ_NOWAIT from cloned bios in raid1/raid10. Retain
original bio's REQ_NOWAIT flag for upper layer error handling.

Maybe we can implement non-blocking I/O handling mechanisms within
RAID in future work.

Fixes: 9f346f7d4ea7 ("md/raid1,raid10: don't handle IO error for
REQ_RAHEAD and REQ_NOWAIT")
Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
Link: https://lore.kernel.org/linux-raid/20250702102341.1969154-1-zhengqixing@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c  | 3 ++-
 drivers/md/raid10.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 80efe737010b5..3d99a4e38e1c6 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1399,7 +1399,7 @@ static void raid1_read_request(struct mddev *mddev, struct bio *bio,
 	}
 	read_bio = bio_alloc_clone(mirror->rdev->bdev, bio, gfp,
 				   &mddev->bio_set);
-
+	read_bio->bi_opf &= ~REQ_NOWAIT;
 	r1_bio->bios[rdisk] = read_bio;
 
 	read_bio->bi_iter.bi_sector = r1_bio->sector +
@@ -1649,6 +1649,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 				wait_for_serialization(rdev, r1_bio);
 		}
 
+		mbio->bi_opf &= ~REQ_NOWAIT;
 		r1_bio->bios[i] = mbio;
 
 		mbio->bi_iter.bi_sector	= (r1_bio->sector + rdev->data_offset);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0443a479809f9..6a55374a6ba37 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1224,6 +1224,7 @@ static void raid10_read_request(struct mddev *mddev, struct bio *bio,
 		r10_bio->master_bio = bio;
 	}
 	read_bio = bio_alloc_clone(rdev->bdev, bio, gfp, &mddev->bio_set);
+	read_bio->bi_opf &= ~REQ_NOWAIT;
 
 	r10_bio->devs[slot].bio = read_bio;
 	r10_bio->devs[slot].rdev = rdev;
@@ -1259,6 +1260,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 			     conf->mirrors[devnum].rdev;
 
 	mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO, &mddev->bio_set);
+	mbio->bi_opf &= ~REQ_NOWAIT;
 	if (replacement)
 		r10_bio->devs[n_copy].repl_bio = mbio;
 	else
-- 
2.39.5




