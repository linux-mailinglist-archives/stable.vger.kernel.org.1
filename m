Return-Path: <stable+bounces-162025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1DAB05B4C
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FFD7B5596
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA62D9EFF;
	Tue, 15 Jul 2025 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFRBKnbE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890C192D8A;
	Tue, 15 Jul 2025 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752585474; cv=none; b=vBZBCDA2wC3GcH0nyg75EDxjlWxUAwK+VZWhl0QSWP3lIQ+jtb4sRKFUga1vYXNc7IzW6f+KpA8ntzbYFQlWaSlyPsmnOdUNlG2jAPDhUBU3EZCNGPOTUst4KyuHNeErwM49pKdiBowhCXVhFGiFQb1+z9Qg8KPmcoQcWVWwKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752585474; c=relaxed/simple;
	bh=rfZvVPbBeQBVEYHKIPPEVM5jp67mtlzZ2pZ7mw8r2UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0gv3Kn2+FO3cmkYmeNgEcdJ126x0D5BsTbmmxkOdHAmd7TT1yFKnku4iHdJU49ryAeqSwsnfrBUJpKvKhUt1P9QC2xo/LtS0QxEVtIrxh7h0MHnvnHRilzXhQJi7PfiE/jGib3M3JNftKyKzD8Etz0ozE3lKh/vM47VsHzKaRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFRBKnbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BF2C4CEE3;
	Tue, 15 Jul 2025 13:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752585473;
	bh=rfZvVPbBeQBVEYHKIPPEVM5jp67mtlzZ2pZ7mw8r2UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LFRBKnbEihqGXeR4N935Gj22AXHGoZeCLmSWY2j6bVOhoxGxRlHxFqduIG6BfArZr
	 fh9TKU7iumC1NU7aP51uwySOo2LU4DJKnE9AHoEnJ7QzIMwc1EedbtilQh7raPjMSc
	 EUNLVsifKNCiepKYQ9aYsGysBmjOSw8WofWIX43Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 022/163] pinctrl: amd: Clear GPIO debounce for suspend
Date: Tue, 15 Jul 2025 15:11:30 +0200
Message-ID: <20250715130809.654955037@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130808.777350091@linuxfoundation.org>
References: <20250715130808.777350091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 8ff4fb276e2384a87ae7f65f3c28e1e139dbb3fe ]

soc-button-array hardcodes a debounce value by means of gpio_keys
which uses pinctrl-amd as a backend to program debounce for a GPIO.

This hardcoded value doesn't match what the firmware intended to be
programmed in _AEI. The hardcoded debounce leads to problems waking
from suspend. There isn't appetite to conditionalize the behavior in
soc-button-array or gpio-keys so clear it when the system suspends to
avoid problems with being able to resume.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>
Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
Link: https://lore.kernel.org/linux-input/mkgtrb5gt7miyg6kvqdlbu4nj3elym6ijudobpdi26gp4xxay5@rsa6ytrjvj2q/
Link: https://lore.kernel.org/linux-input/20250625215813.3477840-1-superm1@kernel.org/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Link: https://lore.kernel.org/20250627150155.3311574-1-superm1@kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index a12766b3bc8a7..debf36ce57857 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -933,6 +933,17 @@ static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend
 				  pin, is_suspend ? "suspend" : "hibernate");
 		}
 
+		/*
+		 * debounce enabled over suspend has shown issues with a GPIO
+		 * being unable to wake the system, as we're only interested in
+		 * the actual wakeup event, clear it.
+		 */
+		if (gpio_dev->saved_regs[i] & (DB_CNTRl_MASK << DB_CNTRL_OFF)) {
+			amd_gpio_set_debounce(gpio_dev, pin, 0);
+			pm_pr_dbg("Clearing debounce for GPIO #%d during %s.\n",
+				  pin, is_suspend ? "suspend" : "hibernate");
+		}
+
 		raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
 	}
 
-- 
2.39.5




