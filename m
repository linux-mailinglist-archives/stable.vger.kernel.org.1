Return-Path: <stable+bounces-204935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 622D7CF5A63
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A55030935F3
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1047F2D9784;
	Mon,  5 Jan 2026 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5M1voj2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DE285CA7
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647869; cv=none; b=pB18/PrGzw5ZwsEu7J28g7D7xUYIjfzCowAbYYyhWr2evatoA2iL0AO2IO13unxQFHOmpGRv2znV/Ef+sNxVkx87QhGIi030vCTxv9MB4ypKByAD/TPwaNfhZ3I6yly8ix8DMOga9LKqqoeZtU6iWS9Vqpm4yCdFUk3zn/moKYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647869; c=relaxed/simple;
	bh=zvFZGn3lQSPESqdSScZnsNfi2myNnEI+wy4yOek0Rzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjcFoiK1nmmUVJ960e+YlDBJQV6lsLyT/s/UMzcfdSUaNYzOiYISsVQOn+AvjGS2ApEeNaRqOCvLDDgUTSEJlbUsOSslsis92Qhxk3XTqROHqgMbE1GFVwk1e2jpE+uPOoaEvaZhk+5JzEUuPsE73K90a3gniI+HQQBpLXhqzHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5M1voj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC4FC116D0;
	Mon,  5 Jan 2026 21:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647869;
	bh=zvFZGn3lQSPESqdSScZnsNfi2myNnEI+wy4yOek0Rzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5M1voj2gIr43XRBK0T1l9nqjjm837SJYI06MH27ryDimse09v1wsDX0dvxci7l5V
	 EgfxwEwILAQBvRUa01LpmGn+K1QIDIHe3HXGFCz/nh4JBxel4cgM5TWwb+n5efU+18
	 X1s5wGtxDuncu0fnv3o3XNH8aH0eQfiBoZ5aLHmOn+hn3g2wGfq62rm02v9hJdf5tX
	 bWfeXDxVwqcBGcZOI4jr3ITfcaxS50rDPCW6eX+7Rc2UqnWlZP/OgjRoY1yCbonRM+
	 BK5H4EH23zfFkB+9tzeQ7DM8qiTpAi+0i5zMUjo8wAOZEGh9ajFUJ6mPGQrN4KWXNn
	 hNXqvRs0cj6Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: vpif_capture: fix section mismatch
Date: Mon,  5 Jan 2026 16:17:47 -0500
Message-ID: <20260105211747.2802180-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010535-unmindful-hedge-1198@gregkh>
References: <2026010535-unmindful-hedge-1198@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 0ef841113724166c3c484d0e9ae6db1eb5634fde ]

Platform drivers can be probed after their init sections have been
discarded (e.g. on probe deferral or manual rebind through sysfs) so the
probe function must not live in init.

Note that commit ffa1b391c61b ("V4L/DVB: vpif_cap/disp: Removed section
mismatch warning") incorrectly suppressed the modpost warning.

Fixes: ffa1b391c61b ("V4L/DVB: vpif_cap/disp: Removed section mismatch warning")
Fixes: 6ffefff5a9e7 ("V4L/DVB (12906c): V4L : vpif capture driver for DM6467")
Cc: stable@vger.kernel.org	# 2.6.32
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpif_capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_capture.c b/drivers/media/platform/davinci/vpif_capture.c
index 72a0e94e2e21..f90de09c1485 100644
--- a/drivers/media/platform/davinci/vpif_capture.c
+++ b/drivers/media/platform/davinci/vpif_capture.c
@@ -1614,7 +1614,7 @@ vpif_capture_get_pdata(struct platform_device *pdev)
  * This creates device entries by register itself to the V4L2 driver and
  * initializes fields of each channel objects
  */
-static __init int vpif_probe(struct platform_device *pdev)
+static int vpif_probe(struct platform_device *pdev)
 {
 	struct vpif_subdev_info *subdevdata;
 	struct i2c_adapter *i2c_adap;
@@ -1817,7 +1817,7 @@ static int vpif_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(vpif_pm_ops, vpif_suspend, vpif_resume);
 
-static __refdata struct platform_driver vpif_driver = {
+static struct platform_driver vpif_driver = {
 	.driver	= {
 		.name	= VPIF_DRIVER_NAME,
 		.pm	= &vpif_pm_ops,
-- 
2.51.0


