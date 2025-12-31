Return-Path: <stable+bounces-204354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3920CEC164
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 034CA300942C
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38CF2580F2;
	Wed, 31 Dec 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YinHmWxO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D61C4A24
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767191545; cv=none; b=mErkQluUQqqFfIjXjMQ0BoALe6Yr5O4E6J3W/zhRZhDhzdhvyo03iVdxHs+YyCrC9KmqKb7nsmZ74wFj0oEq7xIHjvqYYgTfw4hvysVCffnjO1eQ89JKN6X8Iloyrl4Q56W8ZUPs9dqLIUfrKZBFjUfVzCNlw7aY6CwUr1gL/LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767191545; c=relaxed/simple;
	bh=ZYW3OWHBct9Tyo6H49B0tZ3H5uBrB4hQxdIUkQnjy6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUqzp1edA2dM5HDfv/FXRLXLIilWd0aom8Wv5xAXw7peemAjmOSxwnAxTwkxSofxwq+q4b81vK6re815G/a4lxs5av2vhhUj/m75FDwV4FpGFcQKMLJatIkRsAi2F4bUKrC6wmB42zyJV7Fjgk/ypXOpXxQ8lJ40hmMS59Lo4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YinHmWxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6817C113D0;
	Wed, 31 Dec 2025 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767191545;
	bh=ZYW3OWHBct9Tyo6H49B0tZ3H5uBrB4hQxdIUkQnjy6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YinHmWxOZyILYE4X6nLMx1uIJS4IV2gROQcsxf7sNAYELeSfn9muOEglq/Zlk4Wue
	 mO5g3xDFT/jhqigoDHrl2JdMpVVX8RoVodB+Ix8Mt8kYACjwiv7ofMcGr3HUagYAnn
	 xswyS1F6GiTBzbrjEgMk9dYxmR24sgPiRswdtHXUHsFphRjB5m1Mywlq5jEofm1dwX
	 yc1i+mMdFNYXCm9xqVbpg3sKULc7LDkUY3BsYq9xBXqin/vQAUXv691bFrnBllrtrV
	 U4vZiF24XYKe1ioWVe5g+NEY5WOFpzT4c0aKN14BKnhS1VUNNRRfTB/O6/Llbw+CS8
	 g3fuYSq/6f2lA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Amit Chaudhari <amitchaudhari@mac.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/7] gpiolib: acpi: Add quirk for ASUS ProArt PX13
Date: Wed, 31 Dec 2025 09:32:17 -0500
Message-ID: <20251231143218.3042757-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251231143218.3042757-1-sashal@kernel.org>
References: <2025122946-rotunda-passenger-2915@gregkh>
 <20251231143218.3042757-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[ Upstream commit 23800ad1265f10c2bc6f42154ce4d20e59f2900e ]

The ASUS ProArt PX13 has a spurious wakeup event from the touchpad
a few moments after entering hardware sleep.  This can be avoided
by preventing the touchpad from being a wake source.

Add to the wakeup ignore list.

Reported-by: Amit Chaudhari <amitchaudhari@mac.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4482
Tested-by: Amit Chaudhari <amitchaudhari@mac.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://lore.kernel.org/20250814183430.3887973-1-superm1@kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Stable-dep-of: 2d967310c49e ("gpiolib: acpi: Add quirk for Dell Precision 7780")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index c13545dce349..bfb04e67c4bc 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -344,6 +344,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 5.35
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/4482
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt PX13"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "ASCP1A00:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.51.0


