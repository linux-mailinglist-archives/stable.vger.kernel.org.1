Return-Path: <stable+bounces-77530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C56985EA2
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B775B2E076
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF320C153;
	Wed, 25 Sep 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN9+//Tk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C19720C14D;
	Wed, 25 Sep 2024 12:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266131; cv=none; b=hw5entDJUCrFpvDw5SCI4IMYrlBGIvAA+rirq/LjCc10JjZpdjxAsk2DbmKc+A5FLme1ztWXrA0eT/Hx4maFjTAf6UB+hEUD0H/wkU6G618Ro9wmAAZHeBYydl69ZnB0F2v0pGtYgO2YitsvWzooLac/SCuKNopMYWMYFITiuSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266131; c=relaxed/simple;
	bh=OnV7qzzwH6NPn/520Cf5g/lY+BS9FbbTVsUT194JJPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4TXVF3kPj0zXZTWWOr0ex8NYzG4IuJ8FQzinGvpstdl0F6LSNGmR5c0da4zPmFLB4eVVq6mfboE4+gnRdbXNpBOcn7MFrpKG8+Mfvk74rv0FxS3gjxR/z76M8xuHOKqNLybMMk4ddY7l8es2T41xeX+NaM/rJALoZiiWU74At4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN9+//Tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EDBC4CEC7;
	Wed, 25 Sep 2024 12:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266130;
	bh=OnV7qzzwH6NPn/520Cf5g/lY+BS9FbbTVsUT194JJPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cN9+//TkTOvgi6MvwLAWUJBx/iF7E+xTO4kxN/KZgKasYqq5+6WAYHVhJmSAc5+vD
	 0OxSf78Z05wKuWyDijLqv8GGU/07UrolDKdZ9ZPZX3sF4EDvW2jLWpl3jwJAJo7upG
	 Hk8ileB1drrMSbckaS6BS1q9aSIOWyN5A9PzyLSH0B59TADiVn2VfZgWZOLXzym6wk
	 EpOZ18B/xJAWkJd5VObmc2z7qMRu8714nsONbiWIyU42I73xjr9oOilbVLQfyEJauc
	 wF/8zrFwJ4LJLMPk9eZe4ZYQeMJ9XAAd53Le9j1c7CDNHv0TlEFv3Sl7LlM04mykUa
	 JXUaV+tZm2rxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 182/197] platform/x86: lenovo-ymc: Ignore the 0x0 state
Date: Wed, 25 Sep 2024 07:53:21 -0400
Message-ID: <20240925115823.1303019-182-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit d9dca215708d32e7f88ac0591fbb187cbf368adb ]

While booting, Lenovo 14ARB7 reports 'lenovo-ymc: Unknown key 0 pressed'
warning. This is caused by lenovo_ymc_probe() calling lenovo_ymc_notify()
at probe time to get the initial tablet-mode-switch state and the key-code
lenovo_ymc_notify() reads from the firmware is not initialized at probe
time yet on the Lenovo 14ARB7.

The hardware/firmware does an ACPI notify on the WMI device itself when
it initializes the tablet-mode-switch state later on.

Add 0x0 YMC state to the sparse keymap to silence the warning.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Link: https://lore.kernel.org/r/08ab73bb74c4ad448409f2ce707b1148874a05ce.1724340562.git.soyer@irl.hu
[hdegoede@redhat.com: Reword commit message]
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lenovo-ymc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/lenovo-ymc.c b/drivers/platform/x86/lenovo-ymc.c
index e0bbd6a14a89c..bd9f95404c7cb 100644
--- a/drivers/platform/x86/lenovo-ymc.c
+++ b/drivers/platform/x86/lenovo-ymc.c
@@ -43,6 +43,8 @@ struct lenovo_ymc_private {
 };
 
 static const struct key_entry lenovo_ymc_keymap[] = {
+	/* Ignore the uninitialized state */
+	{ KE_IGNORE, 0x00 },
 	/* Laptop */
 	{ KE_SW, 0x01, { .sw = { SW_TABLET_MODE, 0 } } },
 	/* Tablet */
-- 
2.43.0


