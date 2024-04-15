Return-Path: <stable+bounces-39509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC08A51EB
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C952F1C20CF7
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5371B3A;
	Mon, 15 Apr 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzzjfzPD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3755178C7F
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188333; cv=none; b=kayziSSVR2LlEyY7OWnMT0ptDveo0ZzzMrqohzCNc+8EOrLCsKzPWpH2c5kFjQvdWh/0FtEHQK30q41c+QR+HetzbBhqnOsx1lySBdIx0QyZk5QvM1Nr7ofdSB2BKovsmxbGeGfHI35HldLXQBoftpbh4ftUsjJ4LBLteqGAGEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188333; c=relaxed/simple;
	bh=uzGkdNESJzm0/DNgla3wdrjc24ZHwzggUK2nNUscNu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dX/7/WuQk7DGqs8XfW/xu9RsFA9EUVqkOYBNLXaf9+fMfMfdP+1Be/Q7oJNghNgxpNtgk/Ql7Iz+0Xj4OpfWRp0WUcHe8cft97aNXiH4/yFI/us+O+DTyh2Vru61a+VCaNaWlrIoSV6tbFNhr/rmGHhMS8QZw2V7rPX2fH3wth4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzzjfzPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5882C3277B;
	Mon, 15 Apr 2024 13:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188333;
	bh=uzGkdNESJzm0/DNgla3wdrjc24ZHwzggUK2nNUscNu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LzzjfzPDagvbIgqOHIWYPcwkwKl8QMy1+r4aLlspBe4BunqyiODf1s5AhXRF4V3kK
	 laFNX0s0/WsBFQTkgvd3N1EDnqRl8YBJUBMTtbgiHg7Nia/fVhNjEPa5W31SEftsX+
	 QK/X/Dl/Me23aCU1F4RXVpIwJCPuoFgWDMFqMDQlFzHpoOw3mMZqazOl57RUzOdZIf
	 KQC1KHN+DeWoQ1WVS0lXMcVFeCvtzHoGVyLAx+3ebLUsfYBgQj7f8eaezJIqRHA2nP
	 IsWkYTypIoE9SrSTkZULxwCastt3R6gJKWN2wL9v8gw1VgKX6dJ2S72US+IGrMlBO0
	 CdIa2ARmuto4w==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	stable@vger.kernel.org,
	Jan Visser <starquake@linuxeverywhere.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 032/190] pinctrl: amd: Only use special debounce behavior for GPIO 0
Date: Mon, 15 Apr 2024 06:49:22 -0400
Message-ID: <20240415105208.3137874-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 0d5ace1a07f7e846d0f6d972af60d05515599d0b ]

It's uncommon to use debounce on any other pin, but technically
we should only set debounce to 0 when working off GPIO0.

Cc: stable@vger.kernel.org
Tested-by: Jan Visser <starquake@linuxeverywhere.org>
Fixes: 968ab9261627 ("pinctrl: amd: Detect internal GPIO0 debounce handling")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230705133005.577-2-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 41f12fa15143c..693137e0574fd 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -116,9 +116,11 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 
 	/* Use special handling for Pin0 debounce */
-	pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
-	if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
-		debounce = 0;
+	if (offset == 0) {
+		pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+		if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+			debounce = 0;
+	}
 
 	pin_reg = readl(gpio_dev->base + offset * 4);
 
-- 
2.43.0


