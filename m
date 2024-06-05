Return-Path: <stable+bounces-48168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68418FCD4A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D71528D08C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047F1A36BE;
	Wed,  5 Jun 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiTUujr3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14F81A36B7;
	Wed,  5 Jun 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589036; cv=none; b=FuUjEbCCJG/Dnxx/fgXuyhl9grvNqOvGcasX+5rtpWZXR7Jjc6ZDjsZqKkHJMnGVw0wZnLLchx/0aKi5vjHC8sx4wBAiVLBeOgeldRkC1ZvlZ6+27Bjyd6GrcB3UsL3VPfAqPn0uhhTGKbmQLwWf42OupvxZVR+JnQfdDhRPMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589036; c=relaxed/simple;
	bh=GNS9AW5xk91QvxSxcK6nVskhVX+Xg7DubMDBgAl/DNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q55kARnRXaHwI/YGNkrxI7qR2/VQnBbrGNGQzeMqURw7q2xoI5sMwEh+LYely+HzgvGlS+J8k24K0s9nZ9/HgQmTI7hGMBk4CA+xf83qTe+kJQmf88ygHj4VgbveoMao8y6J+DxcNvfXAtDpyoMBu8XIsq0loFXBC+Z2JQUVW7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiTUujr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E0DC32781;
	Wed,  5 Jun 2024 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589036;
	bh=GNS9AW5xk91QvxSxcK6nVskhVX+Xg7DubMDBgAl/DNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NiTUujr3yHuOF2ZvbOVuWS6Wzk3kTBZexI4bvLOmsdqIJbOKQBOCpb/+4pWaQhGlu
	 jJrZLVzX3StRQLaaWZI/65X5KC8UV3G4NvbZwwdra3XsQ/mwm3xDDTdKpj1Nc3QjmK
	 Q1xHtX1jeHfNYOc+jtv+ASTtm3sshbYetYz99Qdk36pvaJOREjyvSfx3UyfF7a5Ix+
	 wRLspWvGvx2981iz6SPGg+u/shbNA1NDfJFoqsH6XHWAXSQRIkVJr/E+mtCTydcd2L
	 /TYjNa4TchVUZ/fk7+nGTZcC64B9pyvIALG2a1ZIn3w/X1nWAIZoxvTmONBLAKZwBZ
	 i2b1v3miG4w4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	martin.petersen@oracle.com,
	hare@suse.de,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 18/18] null_blk: Do not allow runt zone with zone capacity smaller then zone size
Date: Wed,  5 Jun 2024 08:03:08 -0400
Message-ID: <20240605120319.2966627-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit b164316808ec5de391c3e7b0148ec937d32d280d ]

A zoned device with a smaller last zone together with a zone capacity
smaller than the zone size does make any sense as that does not
correspond to any possible setup for a real device:
1) For ZNS and zoned UFS devices, all zones are always the same size.
2) For SMR HDDs, all zones always have the same capacity.
In other words, if we have a smaller last runt zone, then this zone
capacity should always be equal to the zone size.

Add a check in null_init_zoned_dev() to prevent a configuration to have
both a smaller zone size and a zone capacity smaller than the zone size.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240530054035.491497-2-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/zoned.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 6f5e0994862ea..bc13adb23ad38 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -83,6 +83,17 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 		return -EINVAL;
 	}
 
+	/*
+	 * If a smaller zone capacity was requested, do not allow a smaller last
+	 * zone at the same time as such zone configuration does not correspond
+	 * to any real zoned device.
+	 */
+	if (dev->zone_capacity != dev->zone_size &&
+	    dev->size & (dev->zone_size - 1)) {
+		pr_err("A smaller last zone is not allowed with zone capacity smaller than zone size.\n");
+		return -EINVAL;
+	}
+
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-- 
2.43.0


