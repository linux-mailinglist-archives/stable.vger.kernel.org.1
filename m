Return-Path: <stable+bounces-204924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161CBCF5990
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E05B300D291
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0777A280A52;
	Mon,  5 Jan 2026 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsPUbF5N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB0027F017
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647112; cv=none; b=cFE24bIWEZ1bKRMdDaHBiPv7i7c6LCKfnGUfbSWwA42pPFtf57FZdFF2dd13vkzrIEaRoftfM+w9sh4SxRF61hzJ4zkwHFfMQvup1H45R3Is1Emfk75hB/EWQV2Nu3nj6a9wtbzlH7PGHAomq9P2J20oL5mFDPU4HLehuROh1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647112; c=relaxed/simple;
	bh=DwXC7733t+28A9jZXScU80VpoGlysucNAgD/juagQ9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxN9nqo76d1mCVjLPDFxu3QHmoo0Hdt2PahRFxZYu0mbbUTUhGLkG3nF0obwBJA88UDdjpW69ujAXkYTAh8NFcHAyBH8cnJCYrXY+Ba0jeSyqlCCn6IgnR/eyZcc0IKR14znYCvicG5WSZT+/SE92ONwLHOJRTmtN+heIvt0FL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsPUbF5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF1CC116D0;
	Mon,  5 Jan 2026 21:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767647112;
	bh=DwXC7733t+28A9jZXScU80VpoGlysucNAgD/juagQ9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsPUbF5NN6/8ENofkTusj9/POlaqxq0GlFXnuQ32zgqi7tlnC0ZnRTWOTW6jPC9Me
	 nKwNbyP782Me290OKrjpfnBYyzW4e2H+w1ElV9q7vBtnilD6C81r16mufXAd8+MMcL
	 WH7loo7AyizYsuGDfJ69cF/lcLweMnoyBxbxKh+MbUy1635KNYT/OyZ963Ce1P4FNM
	 v7BnAqjMp4XUBlVB9uqafxf0ilVtE/vV3Xnqr5+3MDDa1UB9dA/UmSBB/C4QBnabiR
	 8a8CxQZK3+cD1a8/9JunHvINLRGLZawSTgm7VVNqVnMowFXKBFQQ1TW4DvDJQDhQyY
	 R4187YnUAKREw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: vpif_capture: fix section mismatch
Date: Mon,  5 Jan 2026 16:05:09 -0500
Message-ID: <20260105210509.2799904-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010534-slinging-linguini-bbf3@gregkh>
References: <2026010534-slinging-linguini-bbf3@gregkh>
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
index c034e25dd9aa..164d287c293e 100644
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


