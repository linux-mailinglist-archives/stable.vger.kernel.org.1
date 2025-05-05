Return-Path: <stable+bounces-141670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F2AAB576
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365551C20E98
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029629A337;
	Tue,  6 May 2025 00:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B10Px3h7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37AB3AA172;
	Mon,  5 May 2025 23:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487106; cv=none; b=V3hptFAOR/z63h5tE0Y2WwKjYyuG22wgyYyZy2nqWmUGOcFYxyae1bj3EKjfOFJ5u8rQoRaC1cM53zX8RRo+g7xuUi2399g4u6Grv5PMZEmVpaeCpcfS9Or8qcXk3us+1q94LbtbQG+eUlfwiOgMPFf0sxUqTgk6s873LePZW+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487106; c=relaxed/simple;
	bh=3GR2R9wXN2dyEbVp5yc1avc4JIPZwfur1eHUN7uYmAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQPaKjlyzTToS9ZbvoMHqWxPNaFlvQYLg4FZuHWKSp22XFn8KDeZX7OfoSftxoUyXxEKD5TR5NDQKvdc/7QmAE/2v/R2c8Ht94OstDeQKjmG4709vfdPhMh+mXX29Tevhm6QeGHC7yPOQstmMJwHTQ+4O5dRdDCUy6nCKmtt7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B10Px3h7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99554C2BCB1;
	Mon,  5 May 2025 23:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487105;
	bh=3GR2R9wXN2dyEbVp5yc1avc4JIPZwfur1eHUN7uYmAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B10Px3h7ptyA/wqQEaCisrtyaw/qZpyX0VlmMoby38xRonANpJldMhnumjhSNAnrp
	 jndNAKodczwmK0QuoMjSbwj8dqMoYOUyXH/KEWzuGnG67K4YdEK48IfoEK4fAow30B
	 0PtiCS6IXpdDGfyr4Dhb2IojIoCHMYHB86ghQHBp3dTYRqPicrcKuh8E7JFc2QM9s7
	 8bvszkx8SpGxvvFNmH7ygD+wBElBkirLLhHOR1KyDbAGZmdNIg+NBmVCp+arKc26fq
	 vbF1DjBsP0fIO5MplL1QBOuh5WatoZ4kkVUR/iMTqEA1yFuTisojEPg9qnxzJdVWop
	 cQwQH3Vzu/hpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	timur@kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 004/114] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Mon,  5 May 2025 19:16:27 -0400
Message-Id: <20250505231817.2697367-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 5d564e8670c52..6f2606932867d 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1830,6 +1830,7 @@ static int fsl_diu_remove(struct platform_device *pdev)
 	int i;
 
 	data = dev_get_drvdata(&pdev->dev);
+	device_remove_file(&pdev->dev, &data->dev_attr);
 	disable_lcdc(&data->fsl_diu_info[0]);
 
 	free_irq(data->irq, data->diu_reg);
-- 
2.39.5


