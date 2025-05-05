Return-Path: <stable+bounces-140413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31164AAA8A2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0E15A698B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FB734DC78;
	Mon,  5 May 2025 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK3j2wEK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3334DC52;
	Mon,  5 May 2025 22:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484802; cv=none; b=XwoQKypch/1vp+zgUW8JTQnDOeUJUaY11Btt3azL1FvPeY8gMxTXZ12rp0oAeEuYx3aCAYbPdKwsXumIrdCy79CURyvdchx9zY5HgyIrjqcXb5ZiAm39D2MB74+MndN2w+vuCn0tsdBatsgUR9tPO9083MLZ02aIoccL1i3hJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484802; c=relaxed/simple;
	bh=acWgzjY+/uQlJhhVA40iUkpL52+iio36j0GL1qXLhSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mq5ab12Uzf5PfoED2eMxvLxN/OVEZNpd6qtTIn4evCJvyy6Iw52ysd+WYCnL2cNiP5e3rata/TYt328C87RRiLgIjEj56HvL1Ffom11izVOPsJPeYkC1TwhhUJPT3sHG2kjFaqlQY03RIty1wjrmJPqhu8DLdah49sgEM2E7DDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK3j2wEK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09721C4CEEE;
	Mon,  5 May 2025 22:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484801;
	bh=acWgzjY+/uQlJhhVA40iUkpL52+iio36j0GL1qXLhSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LK3j2wEKIL/fjEUdq7qxv5S7BgmSC8IsivhdebtwG8FdmXeIERdCQruX6SZZDG6/o
	 0bctby0C2cIJwEYy4XHb7TS9/HloIY227+WSIP2rroV101HpPUBoas2fBjGsgyOCT0
	 9bppahwQbtmbneWCsMhzPz+wKGaZvXA3hfELwDVar2c99BTWzilkicPK/DtBOcKVlr
	 M9tNlhUdGpS3u5kI4WoCrfe1oq/2zMYEhUuQVKZbe9VcwbE0p3LEJ1pMepLhMudTz8
	 q24A2A/0RfX4YpGOjare+gpJTpZeAB/G9E/egfElQz9FJi/UbZgJKyLZ7E8WdNXI1d
	 3JuiYPVhFbZug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	timur@kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 022/486] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Mon,  5 May 2025 18:31:38 -0400
Message-Id: <20250505223922.2682012-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 5ac8201c35337..b71d15794ce8b 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1827,6 +1827,7 @@ static void fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
-- 
2.39.5


