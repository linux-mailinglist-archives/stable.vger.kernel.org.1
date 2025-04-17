Return-Path: <stable+bounces-133473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5220A9265D
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D464E7B5EFE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A532571B5;
	Thu, 17 Apr 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lxjo/+0H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAC1A3178;
	Thu, 17 Apr 2025 18:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913184; cv=none; b=l5PAPRJWYwdUMAtyfbBlqNtcJrT1qxuosGhBz1b+ZQgSSpDgT/WN0o3ad6m6/Fr7R7uj8j2OlpLyxqkgPqqeOrOMkKAFMoDQ084qSDwjg+HfCCUFFf03EEtgbQB79wgOfPEAiB3z2IqxPFrjmVYKNMXl2o60AXI4jxU97mqj2vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913184; c=relaxed/simple;
	bh=iSkOFRn2kRomzzcnOB6AezqAJu/QTEWE6JpZVxIW+WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvCdWay3M6CSgyqmW6hEk48ZHKGnK8QIURy5t+0BMf4lI1bhJatJjwTIaRzmkz/PrIZF9vu3B9evvkCdIs5l7Na+vDrF+bnEkiQ2x/5gG5fgNRAvx5BlDohgLiz0W3g92Xrq68fYXxfU7tl7pH/f97G9MK0DhPg7oMiOwXgoeKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lxjo/+0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C88C4CEE4;
	Thu, 17 Apr 2025 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913184;
	bh=iSkOFRn2kRomzzcnOB6AezqAJu/QTEWE6JpZVxIW+WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lxjo/+0HD8LSyCMaN95OwAYqX/nlCXtuulI3ePT5Qhj1i7XwPELQvKBgAX2PaCegi
	 iCG6ebIHMvx+iAW9q7iqfHSkV5tuca6JE0ZcSLy0lHI8ofzNcdXInFGwulZDlwSOE2
	 77ci0leCMxZ6LS16kSgP60v8ZbC9VPZbR9a/GDdU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.14 254/449] media: i2c: ov7251: Set enable GPIO low in probe
Date: Thu, 17 Apr 2025 19:49:02 +0200
Message-ID: <20250417175128.219986514@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit a1963698d59cec83df640ded343af08b76c8e9c5 upstream.

Set the enable GPIO low when acquiring it.

Fixes: d30bb512da3d ("media: Add a driver for the ov7251 camera sensor")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov7251.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/ov7251.c
+++ b/drivers/media/i2c/ov7251.c
@@ -1696,7 +1696,7 @@ static int ov7251_probe(struct i2c_clien
 		return PTR_ERR(ov7251->analog_regulator);
 	}
 
-	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	ov7251->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
 	if (IS_ERR(ov7251->enable_gpio)) {
 		dev_err(dev, "cannot get enable gpio\n");
 		return PTR_ERR(ov7251->enable_gpio);



