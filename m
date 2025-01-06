Return-Path: <stable+bounces-107733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15291A02E0E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 554CE7A2F0E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738C61DE89A;
	Mon,  6 Jan 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNQBuJYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93F1DFD97;
	Mon,  6 Jan 2025 16:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181730; cv=none; b=icqp9tuL7ylN7fv39hhfpoEYi+GRe8/3Lib3H9yhd/WiSVKy4w2iPWR5bTOpIt0mCIksZcUGiogjXic28nXy+H3bt4esdpT4gQX97QBja0W3KRfvfJLCZh2mSGmlzHGtRYPBEsjkhG1Dzz0KyClmAbyqPRLBu6xMoBFKFMydoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181730; c=relaxed/simple;
	bh=+YjIooULW7nVYb671ov5Ko92zYnxSU3aZvoSxy+Y+ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F1rvuGdlmX49ZcERLz7wFWABdSr533CR86KPFVor+KRjrwRgAav71k60dxTW3wkqqns/Eg6kLCYSwAtHjDemZ0HUD+yzcgIipIApFu1Wcc/96Cy/YIXFECyPS0r+6Tu2Oa4EO5n4XBq5xjCkhSZxvd8BRuGQOxBgQMq2N3Yq5zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNQBuJYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03010C4CEDF;
	Mon,  6 Jan 2025 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181730;
	bh=+YjIooULW7nVYb671ov5Ko92zYnxSU3aZvoSxy+Y+ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNQBuJYxOxguILmq2+mTvkcbkGIKt69no+UoliWrPnNlDDAt6JcjDGiim9PFhtTL8
	 ioK0XkWM30MMHAd/PgYFO48cEKxiNw8whr9MWUbMF+qqr3mZJWXWXzJ1dVX5lBHbp9
	 EMU4YFOxfx1W51gKglzEjNP52jIeSSaU0IOMJwTalxWtsYtc9g0ZkkpldQ4l556oTn
	 T40ZnTkdAHbK2sEc0KTWhe68p36eNT9ywFaaQoYglNHJxG+MVQDQP038cEhyWebcx+
	 AA+fTbsZU4XYG9pRNQdSK9SAhc7t0vlC43WS0lhk/Hzv3PAHkGzD+fjHCoTx4qF5CH
	 44o4ggUX85rfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 2/2] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:05 -0500
Message-Id: <20250106164206.1122310-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106164206.1122310-1-sashal@kernel.org>
References: <20250106164206.1122310-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.69
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b579d6fdc3a9149bb4d2b3133cc0767130ed13e6 ]

Ensure we propagate npwg to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs information properly
propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 468833675cc9..c0b342cc93db 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.39.5


