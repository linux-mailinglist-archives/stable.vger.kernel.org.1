Return-Path: <stable+bounces-52516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91F90B111
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 16:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FB71F2B629
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E231A92CA;
	Mon, 17 Jun 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVrmfXwA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AE1A92C2;
	Mon, 17 Jun 2024 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630819; cv=none; b=h8Shy5nvZwL08wR1iTU4KKdxrlszocuJFi+/yle92QYszPKCpjhcFjTQNkyWiJV+xLkrmDDVrd0T8jqB6vOZHlVRD0QkiQt4BO6TTVXJwcGq1MjPmiss6NqBNqyqvMcFRPIxA9sAINuYXYI2bCXhh2P2M5jX3oj9tJ8ER/xW3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630819; c=relaxed/simple;
	bh=D448ZoV/9zsFaLm4hdJ2TqO6XtuiHJ0fgi3i1hWjrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaFkAXPvtIsckaGseV5MP+3a5ptgP5CXs6mSrejNlOQCLKTE6nkDC6/71GW7iR/6aAWr1sXCGsAZIHsv8vbZoq0uka0EKwsQXUu/ise8eIu5SHkpHb0fkxCO/zNCC2zBLW5HX2VqvzC8IhVuhSOL5yA2yvQP2cEKNUOBiThp9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVrmfXwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05B8C4AF48;
	Mon, 17 Jun 2024 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630819;
	bh=D448ZoV/9zsFaLm4hdJ2TqO6XtuiHJ0fgi3i1hWjrvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVrmfXwAg629jHmbh+yB1UzF7mTfGoS/JHo7LpDLnTI+/GiLvDtkc+72okG17khMM
	 DlW6ibGS1hRQh0f+2zpkE9Ek9qc0aQ/gHSAcszIZuc8FxCcjEINk/A60mx9LFKDPo5
	 l2DBreaAqxkhqg3rXpdzuYihpant6WYiWeVnjur9LjMVKpHP1Anu3AVyp8uZR3xxWo
	 xWp6/pJUxTUVqm+mOAUFid3YjiTqA8kNUy/B0nUgQJZJK+iA4jjNvqqBVpKNCXYMFV
	 LmnkjRRdPgVpG2coirtpdFIGlNWcFOdElECF5/5YD/J1cXol5PFEZJFy9XE77W1est
	 qvt54yfzmGagA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	hare@suse.de,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	zhouchengming@bytedance.com,
	yanjun.zhu@linux.dev,
	yukuai3@huawei.com,
	shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 19/21] null_blk: fix validation of block size
Date: Mon, 17 Jun 2024 09:25:56 -0400
Message-ID: <20240617132617.2589631-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132617.2589631-1-sashal@kernel.org>
References: <20240617132617.2589631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

[ Upstream commit c462ecd659b5fce731f1d592285832fd6ad54053 ]

Block size should be between 512 and PAGE_SIZE and be a power of 2. The current
check does not validate this, so update the check.

Without this patch, null_blk would Oops due to a null pointer deref when
loaded with bs=1536 [1].

Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20240603192645.977968-1-nmi@metaspace.dk
[axboe: remove unnecessary braces and != 0 check]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 87791265e09bf..ad0172f3fd4da 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1749,8 +1749,8 @@ static int null_validate_conf(struct nullb_device *dev)
 		return -EINVAL;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if (blk_validate_block_size(dev->blocksize))
+		return -EINVAL;
 
 	if (dev->queue_mode == NULL_Q_MQ && dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
-- 
2.43.0


