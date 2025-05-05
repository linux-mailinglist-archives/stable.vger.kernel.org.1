Return-Path: <stable+bounces-141472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1246AAAB3C6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092EA1C07B32
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7213133CC8B;
	Tue,  6 May 2025 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqo9dOhO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCD4288C1C;
	Mon,  5 May 2025 23:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486407; cv=none; b=oDLrOJg1foGttVcW/IepYWcqj3MmIcoNXESwgMfrIjDgQa4Pfhg4fOimwU1H2c7DxXsUSLeB5xhTcnGBefxiRql/IYhIm6nvzAZm035Y0qoZWUIiaXt6DdUkSfvJeFXvtbMCDUU2H5u6kM+S4/WbsyuqeJDJiWVodwhyNOaDGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486407; c=relaxed/simple;
	bh=dGzUyxuhzvfEM3R/PhIaZ3ZpTDVIzR52pu2g+3tx7Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HAfKTl7vUedoZTQ8rt/xY5D8wloSvHPfyjAMoITUi3teSgLRenoW6cMBX9jIsb2zWeWPWdLTRvac9/v6oeqNn+0c40hOaOTSL0GNl27Vr5/QbToyLH37CAJkpDSI6T29aYp0nPkpUWUnU6x9WDBosaY+vWfrKcJOa9U8zlRIHUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqo9dOhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4287FC4CEE4;
	Mon,  5 May 2025 23:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486407;
	bh=dGzUyxuhzvfEM3R/PhIaZ3ZpTDVIzR52pu2g+3tx7Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aqo9dOhOI9BTrAv2m7BCfIkkwvO6v2+Mz6A8Xo9PDkw9aue2mzBbEiT+OjXCTffDN
	 XMF2wmsUKuSAKhh2uweD2Y2Fp8U3tuNPSLp76DoJQJJggBd72qay/G2zBJWRkOTrtU
	 C9NdfIJbm/VkJYJw7P9MSX1bM/ioGTHRNwMBDrDZ8xv8cdVRf/w/UFXP68U5zTLtSX
	 HKe16RX1V/6yA3ovlqenW0GkY3Fr3Xpi4GLHhu5fQvwurU/x4HkqCCDElUV+gTLhGE
	 86g5nrEQmloJgD2hjxdHI26ZO5BbTcveqhgY/GjLLXcAaZ7PVX+HU3mJOx+GnykGBT
	 PaUIcPkErkujQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	timur@kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 013/212] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Mon,  5 May 2025 19:03:05 -0400
Message-Id: <20250505230624.2692522-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Shixiong Ou <oushixiong@kylinos.cn>

[ Upstream commit 86d16cd12efa547ed43d16ba7a782c1251c80ea8 ]

Call device_remove_file() when driver remove.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/fsl-diu-fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index ce3c5b0b8f4ef..53be4ab374cc3 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1829,6 +1829,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
-- 
2.39.5


