Return-Path: <stable+bounces-141346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3569AAB298
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D6C7AE444
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECBF431F3F;
	Tue,  6 May 2025 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4sxJzDf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E12D8DA9;
	Mon,  5 May 2025 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485826; cv=none; b=GC1I2d5PdRembd2oy4YcB5GiU4iGzO8a2yQCJsVKwk66ye1F92LWGybdf+FrE3wEsOIMIwwjznLiE7kn7DW7lfj+tDm0zzqPGvn3Y9lIjy0jrdFUS4SerqhbwfrAxK4Ng1LUQXzxYS5bS4MIOma8McCpHwMefHX9/i/cwLBFeeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485826; c=relaxed/simple;
	bh=iZHQ+x/yJmF2kpb8qxJthxWQ4unr5cOMDIGLqJ6ibpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E7g+1iO/+n9D54NCmYS/KQfm0SanpOloNpsOOKYMhDAkgQB0IJ/GJShAJT2xOyt5yiOFxi5+mwgFeOvSuUxzPqGjY+K33s6QcE9+muke9sjL1inLHSctBG2qXc87YSYe9UTsIVyHf/6nqwkUXMHelcJ76fQTkhrctNqM4gC/2s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4sxJzDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8097FC4CEE4;
	Mon,  5 May 2025 22:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485825;
	bh=iZHQ+x/yJmF2kpb8qxJthxWQ4unr5cOMDIGLqJ6ibpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J4sxJzDfNnjbTdZS1gCvMq4bTf5jMNl+cGeC9i3luGeBcbNYG+wPLPUL5DFsm6mWT
	 xXjJxAbd3bgvzh9QdEqFhlCbrLlQgx2yQ8U7kXY3trrEfSFuNr8z10TA4Oy+UNmrBy
	 qd2Ry+RfOvse9gut2qDB72Q5XrNMg+Hcoz58oN+Fb18WlEU0Alni5vXEYXbNKGDIdc
	 cdxWtqLXkEzut1nnnjz+caZ016bq1UmGylfI75OiltproB1eyx9be8ziEsl9/JkNBc
	 qUdCkWu4ZSpok/9e4Hla5oObaomDj7oClSm//rfTL1dbT6qTHqp21yA5y42JAdtq3u
	 4beTfvd/9hlAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	timur@kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 017/294] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Mon,  5 May 2025 18:51:57 -0400
Message-Id: <20250505225634.2688578-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 0bced82fa4940..8cf1268a4e554 100644
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


