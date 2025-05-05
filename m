Return-Path: <stable+bounces-141588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD8AAB4AF
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC11917AB62
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56EE4819E7;
	Tue,  6 May 2025 00:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZejMIhV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A962F230E;
	Mon,  5 May 2025 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486811; cv=none; b=mf1HrKMkmdOqTlCjkhKewxtqg6Ppw82tiIR5+KWx96e1vChxtZCh0OjjUS73+78xocUZ4efk13vnU5DLvkEIZxL+xIJ9J1azMHxxu55Qyn1XwTvjqWH/8MTlRQb7RA6i3hqxuTZm8m8mD4ViL5yla9t7ViaYpA+9kD68gBB1zSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486811; c=relaxed/simple;
	bh=dGzUyxuhzvfEM3R/PhIaZ3ZpTDVIzR52pu2g+3tx7Rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcX1G94ff+LEUX0CnMJcso1+bmajRLT/yS5NsD1kV1r7UM+N7DAuEkU3NWpWtwFCCBXX4RpdHZqMCIxoYQgwgsULCWxkN1p2rp1tqWVtMRAvrFf32VKshOKlxZJBE+xuVCj5aUx4oxYbnQ9S5mTHFxL0wG9K5oRfkcXSeKdKnFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZejMIhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0E1C4CEEF;
	Mon,  5 May 2025 23:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486810;
	bh=dGzUyxuhzvfEM3R/PhIaZ3ZpTDVIzR52pu2g+3tx7Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZejMIhVFxF1VmTq6oCnYhRW/dXbMoAufMJ5ifvu20NgPiUdrE4VnEe9To3n0iwa1
	 KG0ujiI6ra1fIbK/aI5pLl44IdooNHyEZWBzKn+YBirG4/ljzDX/4k7nyssGBz7CD3
	 AELYmrAZtkcq8o8OGpY82zSOAg7yoIrxBDqq+qCuVQOYw/qnvnljsvIALmKwwb7v+U
	 /RXpmAKYB3il8ZUo+5jKGb7/bnN0xO4bW1bW0unGG8Mq513+0OUB1xy86cvG3b52AP
	 A6E8c+r5nrNR35M8LUr7VinN0R7OvlZtQsf5AkEnIuaXmixVFQGD1nfl/EUZBjjALY
	 TG0oIUSdScD5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shixiong Ou <oushixiong@kylinos.cn>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	timur@kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 005/153] fbdev: fsl-diu-fb: add missing device_remove_file()
Date: Mon,  5 May 2025 19:10:52 -0400
Message-Id: <20250505231320.2695319-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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


