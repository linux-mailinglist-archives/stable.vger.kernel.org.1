Return-Path: <stable+bounces-146706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55710AC54B5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9664E3B4C28
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664BC27E1CA;
	Tue, 27 May 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bKLa263I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593A276057;
	Tue, 27 May 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365056; cv=none; b=Lh8naYMeKY3wFhtSsxeDjjjpoH1Fxcz35ox5Gg+a2+AcKJZ5yT3HExFn4mkPgIhdgFihI2541U2dapxUtrx7Bfmn6QRXm5nPd3TCRsIrPwe+Cu3YvGArHio2zbzz2b212QDW9XE8ZmEGUw7HETZZOHnTx+ZBHEcVOrb4rguBnGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365056; c=relaxed/simple;
	bh=K09Xbxogggcu6iwUA6f7HMLPJhNXT7filKBCFmYTnWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQhsbLSA1mvfj1q7+ScPhKhDoQJHIDOWOK7PIL9EyN6TQjbdy9dT6KSAHuNBlXWFhc3sEMa2FwOCJq6XGCVDlgSdCnuZ2ztLWPY+YwDj71QV+z2I8jt27HF1fW+YIcvielxnT0Hh/iAkhJe68BLRGY6UoDECrOj4R1VDvRSetCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bKLa263I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AABCC4CEE9;
	Tue, 27 May 2025 16:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365056;
	bh=K09Xbxogggcu6iwUA6f7HMLPJhNXT7filKBCFmYTnWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bKLa263IEBJOc2k2vICrjr81VPkyZFKojU3x/8Sou/kCMoUSz5zhAccKMxbamy9Ba
	 o9NDpYkrmEOdIZHwc4XXWhubNENwU8iu+PrjLHP7P6yTHm37+djHNNfb5FslnVAuZj
	 h0eb5DPAGjSRcENz1elxjdWTmJaPrKJvVnE6Lpdg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 254/626] block: mark bounce buffering as incompatible with integrity
Date: Tue, 27 May 2025 18:22:27 +0200
Message-ID: <20250527162455.333757035@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 5fd0268a8806d35dcaf89139bfcda92be51b2b2f ]

None of the few drivers still using the legacy block layer bounce
buffering support integrity metadata.  Explicitly mark the features as
incompatible and stop creating the slab and mempool for integrity
buffers for the bounce bio_set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20250225154449.422989-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-settings.c | 5 +++++
 block/bounce.c       | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1e63e3dd54402..7858c92b44834 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -124,6 +124,11 @@ static int blk_validate_integrity_limits(struct queue_limits *lim)
 		return 0;
 	}
 
+	if (lim->features & BLK_FEAT_BOUNCE_HIGH) {
+		pr_warn("no bounce buffer support for integrity metadata\n");
+		return -EINVAL;
+	}
+
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY)) {
 		pr_warn("integrity support disabled.\n");
 		return -EINVAL;
diff --git a/block/bounce.c b/block/bounce.c
index 0d898cd5ec497..09a9616cf2094 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -41,8 +41,6 @@ static void init_bounce_bioset(void)
 
 	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 	BUG_ON(ret);
-	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
-		BUG_ON(1);
 
 	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
 	BUG_ON(ret);
-- 
2.39.5




