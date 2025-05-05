Return-Path: <stable+bounces-141047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8C4AAAD92
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219051B66E26
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F6A3F4676;
	Mon,  5 May 2025 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN5DZ096"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ADD37EA85;
	Mon,  5 May 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487319; cv=none; b=C2WpFjXlyhtMHNmts2GXdJC1Z3yPBU/3pLSH4CXVNHrO/85vG8FSXKNv1wb/WluQM99md+ZcOgZW93NytgqhUw+/u+3XfXG05/KgQoXLuvtT8EsceSD2gn6usHTueqp/hG8T20PIh/8R4FNzNJj+J7sMxLt0RGw3vzrYurpVu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487319; c=relaxed/simple;
	bh=Ri+uoAYihEtW5+8ixH8UW6Kg4Ak/15ZETE//xeGI+vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfjNhd6DwFilJ48lXWXRbTtDkv3RTWQaXU9lak2SAKtrvD61HQrVEvWwIGVEmPyo6meifgiHSKAQjeFX62VHNZKjrf2pMkTHBGIdWLyz5E3+C6FRrew2HnbWQ0CCgq3jDeiLfuYF/zih46jbR5DLt/CngcbeZDSax7thWvV2JkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN5DZ096; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0224C4CEEF;
	Mon,  5 May 2025 23:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487318;
	bh=Ri+uoAYihEtW5+8ixH8UW6Kg4Ak/15ZETE//xeGI+vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JN5DZ096esX8Ul5MhAlFjBccs26kgNM6ArDUmRgmZMyrsIrQGoQ0uEPC70dBunhes
	 MkdeHr5YaFqIU720OJQ1CbhD0th93FTq6Ma4TIKprHN4Nnook/ISHyLwzENetoy4rK
	 YeoBoGXyCWb914Jc3gKxqSgX28g6SbKk4ony5aiUXBeFymylTPhLTM1dk4N8hC8KRp
	 o4yACMPdU1XVFCmBCHLovv+4K3VeKW7A7EvFSuNxDDvdoXJpXuivdkQqLs1qdzuuxC
	 QLKqgQEbiBfn+1LwWMrzIq1E/olYbQCtc0/n9KO3o23XzcKXi9NPfhn+dXP4OfSDm9
	 hRqOTlVnAt7hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	timur@kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 03/79] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Mon,  5 May 2025 19:20:35 -0400
Message-Id: <20250505232151.2698893-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index d4c2a6b3839ec..3dc399704adc1 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1828,6 +1828,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
-- 
2.39.5


