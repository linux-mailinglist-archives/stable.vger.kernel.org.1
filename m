Return-Path: <stable+bounces-80814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D8F990B5D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7069A1F22B53
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4701AE01C;
	Fri,  4 Oct 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZVG089f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6331AE013;
	Fri,  4 Oct 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065968; cv=none; b=IyzXTrGMxhHWStdq/XyEk7/WyU76Q58ELKAzCuCHgjW1ItV/ZIwyD32QVzvmPG43F/Q+KL6/ia98BQfkAK+bipau5dA/Cw0n42KWGNKB0+Av/aJoeJof2DO6UoeVN7t+iQIUGLqiOP/XNvea3zswE8kEfMGQ0AHpxYkYx2GrJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065968; c=relaxed/simple;
	bh=6d55/BnnI3qdnVXbI8ZqqtcV+rL6kt3+tYK6ms4ZHws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLzMwX7mK2Y+A6/lZptR4Mf5+P5km2nwziUwApn6JEVHA6/ZWLFdKZ51PYAa+jjrdRAIGmTTrO+vT/6Xi9WBtRVBt9wDabABuwv+exc6bQvLQiXMSvkvrFeW7+RYCRAv1OgJ2zJgFsy1dKodSixUd6wbKGSN/6U7U9eAiwV6JDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZVG089f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EBEC4CED0;
	Fri,  4 Oct 2024 18:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065967;
	bh=6d55/BnnI3qdnVXbI8ZqqtcV+rL6kt3+tYK6ms4ZHws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZVG089fQXh3esYcTOVSUahlg821DxyV/AJFNfw595OtzRV+L7QDZBJNmW8/o79te
	 /QLU2OOyNi0iw9oGUmEBTXhqbAoGOVGj70XruOjj01r8WMCJPEJCGBhoLZl2nymETD
	 G/vhnxLVYA0vnbqLclPFeeIhhKjjwXlBMLazPPS1Wjqr8w2Um260QjDT3anGY71W07
	 aAgBYBTVGHp95K7VLV0Ol+CchEPlyc+khU19d3zv+wddNBNKY+42QIMMGzS80llIHi
	 5G0mQvYIVZZFKxbGWitw3oxX3DzIuK2+7iZDV+Rf6aiTDbiGzpWFsi406A+KqHgmdK
	 xepa4wUjI9C6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.11 34/76] mfd: intel_soc_pmic_chtwc: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Fri,  4 Oct 2024 14:16:51 -0400
Message-ID: <20241004181828.3669209-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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


