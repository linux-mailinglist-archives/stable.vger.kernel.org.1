Return-Path: <stable+bounces-80889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24854990C5F
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AE91C226C2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC7D1F689B;
	Fri,  4 Oct 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmdMs8SX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820E1F6893;
	Fri,  4 Oct 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066179; cv=none; b=HLkbvWYBg2451o06A2w4BG+gcMTVI+ft028v7fItzjZ7shBOOn12lwmsSGsCRAo/DM4EvrBZ89EGodQCVRdn6LX7LUvZ4lA7aPl33ICZqXvk9Ddxb25b5wyUciUZ9DnuyPVHu3oGzaLdwDK0tRCEXRlB53pagrO8PdJZjvHVhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066179; c=relaxed/simple;
	bh=6d55/BnnI3qdnVXbI8ZqqtcV+rL6kt3+tYK6ms4ZHws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQZtLSKM6kGNH636JtLy1Nf2HSKlTi/mL4RqZ3l7OhOmpGpSJKLoKcFZhdo+ENpM3a1p3YIoRcd05QZTl5gnLN/JZ6+640B+xDIxJ/+AHboljJfq3A2vg+pQprHTZY+JVBKpUfPCVFFP3aweJ0JuSEvd90OXthQBzRMbbAWermk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmdMs8SX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65950C4CECD;
	Fri,  4 Oct 2024 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066179;
	bh=6d55/BnnI3qdnVXbI8ZqqtcV+rL6kt3+tYK6ms4ZHws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qmdMs8SXQiVJF0Vluu1gFjAJ1gDPleW+XSv5elos64B96mpWLghIvvkBpmu5V962P
	 wtEaSObux6Coj+aayqLCcC1WvavKh31u58I0+VhfN8UNRW2lGrD/T9eMRs18RUY16p
	 oTbtJnbGUaLZdk+WfhsduslZknWuehXsqM0mQDsprS6FZyH9nfz2RKMUsXJPFkd2SY
	 2S31jqB2786EUpaifhrhDVzl+u1atplMXh51O5r2NeNPNySy6+2hPezuKLXniiU91H
	 WeQlZOGseSU0rA3+zyflnluxpt0PZqbTlvl1QWYp2KkmB05shNDAjhv65xLLrRo+5y
	 TLiY0+T+wNdiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 33/70] mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Fri,  4 Oct 2024 14:20:31 -0400
Message-ID: <20241004182200.3670903-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ae7eee56cdcfcb6a886f76232778d6517fd58690 ]

There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
turns out that the 2G version has a DMI product name of
"CHERRYVIEW D1 PLATFORM" where as the 4G version has
"CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
unique enough that the product-name check is not necessary.

Drop the product-name check so that the existing DMI match for the 4G
RAM version also matches the 2G RAM version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://lore.kernel.org/r/20240825132617.8809-1-hdegoede@redhat.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtwc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 7fce3ef7ab453..2a83f540d4c9d 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -178,7 +178,6 @@ static const struct dmi_system_id cht_wc_model_dmi_ids[] = {
 		.driver_data = (void *)(long)INTEL_CHT_WC_LENOVO_YT3_X90,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 	},
-- 
2.43.0


