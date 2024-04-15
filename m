Return-Path: <stable+bounces-39495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE788A51D0
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06237283753
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B436073191;
	Mon, 15 Apr 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAjPgQMt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515E2F877
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188294; cv=none; b=odFXSWZS+U4TndR4T5PDCoFxd9nJ1kg8yQIQKCFoALAt2bX7fnFPiQVSwh53eNpP8O2X4WNWQOqZWx5HZVcUrCt/s6F38Fa4PXxkZG2tesymGfv3KUVCuGg4jiNXcgJ/FBfLPwyS6V20QgrGqG7rsRyZY6R1lT8jLAU3SoKvM5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188294; c=relaxed/simple;
	bh=z3+QOH/KzxFaY/lPntEvW2TLmJkyK7VSq2xkRbjOmAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJl3ooC7wUznHZG166kJAGHYmA1bBb+q/xeq04omHT/My98DZh13sx2JO/1gECJiPy2asVTWrFkanS0JessoqDWKChzRRKG90k8WrnRhxudrm/AhErkmfINQxPn3FyLCP9/iIoL0K2yZIPebOrX3Hk9zwfX2kIMFqZMLT3dWRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAjPgQMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35328C4AF08;
	Mon, 15 Apr 2024 13:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188294;
	bh=z3+QOH/KzxFaY/lPntEvW2TLmJkyK7VSq2xkRbjOmAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAjPgQMtxissvKHcA9vC8nzv9Keqp/Jk5ERPHl2Gx0PqESX0mTsfsEV0NcGs5YcDe
	 oDHHSLrSNOE8Fl43b4KaNhJdb49LLerj+ilrJHAmW89yRqP1aMUqpLzAoiaAf9Xbvr
	 p0dU2Ke6bQQ0saoJIox/RcAZinDjvE0wu41AHfDA0Zbk2gqEAFC5ZqIUEMiiiyztx3
	 aTMjm/waYsX6bc2tqdNw42UQsAWZ/i4VonbGK0c+8gLlZwrfQCGowaVG5NYxmNjDCJ
	 WXtdfOCas2GRi8XI5h8NhF4CyD+mdqIhcxemz6VHbWw7OXRHmKKIa4RhJeATAXczwE
	 VOoCykOFP/98w==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	stable@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 004/190] pinctrl: amd: Detect internal GPIO0 debounce handling
Date: Mon, 15 Apr 2024 06:48:54 -0400
Message-ID: <20240415105208.3137874-5-sashal@kernel.org>
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

[ Upstream commit 968ab9261627fa305307e3935ca1a32fcddd36cb ]

commit 4e5a04be88fe ("pinctrl: amd: disable and mask interrupts on probe")
had a mistake in loop iteration 63 that it would clear offset 0xFC instead
of 0x100.  Offset 0xFC is actually `WAKE_INT_MASTER_REG`.  This was
clearing bits 13 and 15 from the register which significantly changed the
expected handling for some platforms for GPIO0.

commit b26cd9325be4 ("pinctrl: amd: Disable and mask interrupts on resume")
actually fixed this bug, but lead to regressions on Lenovo Z13 and some
other systems.  This is because there was no handling in the driver for bit
15 debounce behavior.

Quoting a public BKDG:
```
EnWinBlueBtn. Read-write. Reset: 0. 0=GPIO0 detect debounced power button;
Power button override is 4 seconds. 1=GPIO0 detect debounced power button
in S3/S5/S0i3, and detect "pressed less than 2 seconds" and "pressed 2~10
seconds" in S0; Power button override is 10 seconds
```

Cross referencing the same master register in Windows it's obvious that
Windows doesn't use debounce values in this configuration.  So align the
Linux driver to do this as well.  This fixes wake on lid when
WAKE_INT_MASTER_REG is properly programmed.

Cc: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217315
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230421120625.3366-2-mario.limonciello@amd.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.c | 7 +++++++
 drivers/pinctrl/pinctrl-amd.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 509ba4bceefcb..41f12fa15143c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -114,6 +114,12 @@ static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
+
+	/* Use special handling for Pin0 debounce */
+	pin_reg = readl(gpio_dev->base + WAKE_INT_MASTER_REG);
+	if (pin_reg & INTERNAL_GPIO0_DEBOUNCE)
+		debounce = 0;
+
 	pin_reg = readl(gpio_dev->base + offset * 4);
 
 	if (debounce) {
@@ -191,6 +197,7 @@ static void amd_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
 	char *output_value;
 	char *output_enable;
 
+	seq_printf(s, "WAKE_INT_MASTER_REG: 0x%08x\n", readl(gpio_dev->base + WAKE_INT_MASTER_REG));
 	for (bank = 0; bank < gpio_dev->hwbank_num; bank++) {
 		seq_printf(s, "GPIO bank%d\t", bank);
 
diff --git a/drivers/pinctrl/pinctrl-amd.h b/drivers/pinctrl/pinctrl-amd.h
index 884f48f7a6a36..c6be602c3df73 100644
--- a/drivers/pinctrl/pinctrl-amd.h
+++ b/drivers/pinctrl/pinctrl-amd.h
@@ -21,6 +21,7 @@
 #define AMD_GPIO_PINS_BANK3     32
 
 #define WAKE_INT_MASTER_REG 0xfc
+#define INTERNAL_GPIO0_DEBOUNCE (1 << 15)
 #define EOI_MASK (1 << 29)
 
 #define WAKE_INT_STATUS_REG0 0x2f8
-- 
2.43.0


