Return-Path: <stable+bounces-72887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B579796A8F6
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 22:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A24B23265
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452FE1E1A03;
	Tue,  3 Sep 2024 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqrzahnE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007501DB550;
	Tue,  3 Sep 2024 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725396250; cv=none; b=YZIRENqJ7wMcz1unajiKQiVMlDo/LMemcEN0jVnhUcgOXdUlgleiCYXxfF5UmOOsVqE2VR1666EKX/gI5c4vS363FLbrYnPQemUpzFdBpPxOXPwZ5HO2m4YW7Pt5zKo0+C47UQKqtNbK6K+EoFOjGr/0pVgB3VUZT9XEDnQsiQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725396250; c=relaxed/simple;
	bh=ktpNedWiKVoT5UydmXwBJ1Ij8Q+ec0nP0x9MYK8iiVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2OVxvOSBTGHBUytg/N57z8jYashE7TecLXiFhlmDVv97uBPAtINrYTYrNHZyQezYoMUWKGpdlQtYeNEra3nbf/XI77xLCk7hbBSBiAZ5ZX8wzd6RDp66pYT3gTet0CwFTb7XO+j/fO4cLKeO/T6GhGPXeIjQkLRcjihD/QopM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqrzahnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2DDC4CECA;
	Tue,  3 Sep 2024 20:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725396249;
	bh=ktpNedWiKVoT5UydmXwBJ1Ij8Q+ec0nP0x9MYK8iiVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nqrzahnEymISnLUGqnTTwryuMT8+jLrWwOZ+VWjHg8zxS9Eq0rs4qYQqOl91SFH/5
	 b2IcIwF5bDu/wrCqNqxyUAjh/BU9gBoIYIec+JG6UjmEwIHfgrNM+H5Y99zXPQhSC8
	 JRXG/dkIbc0u4Rv6kAZjfSBJ0feFJM/vkJPL1QsXly5vPWPP0hEloHjAr7qLxDwJR1
	 +1EHSpV8OeN1Cl3hZbsEaCwFhbhffB3jVS2XID+0pG+ntPFKPMKPJLjunEVQ0PC8cz
	 GcO6y2nfnUk35+u8sA8/y2jkMiuEG3TCyaZYVTpFmNZJW9+xGZYd+uKdSLMihLfbF0
	 T7aYkUQDZeGcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/20] platform/x86: x86-android-tablets: Make Lenovo Yoga Tab 3 X90F DMI match less strict
Date: Tue,  3 Sep 2024 15:23:43 -0400
Message-ID: <20240903192425.1107562-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903192425.1107562-1-sashal@kernel.org>
References: <20240903192425.1107562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.48
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit a3379eca24a7da5118a7d090da6f8eb8611acac8 ]

There are 2G and 4G RAM versions of the Lenovo Yoga Tab 3 X90F and it
turns out that the 2G version has a DMI product name of
"CHERRYVIEW D1 PLATFORM" where as the 4G version has
"CHERRYVIEW C0 PLATFORM". The sys-vendor + product-version check are
unique enough that the product-name check is not necessary.

Drop the product-name check so that the existing DMI match for the 4G
RAM version also matches the 2G RAM version.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20240825132415.8307-1-hdegoede@redhat.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/x86-android-tablets/dmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets/dmi.c b/drivers/platform/x86/x86-android-tablets/dmi.c
index 5d6c12494f082..0c9d9caf074cb 100644
--- a/drivers/platform/x86/x86-android-tablets/dmi.c
+++ b/drivers/platform/x86/x86-android-tablets/dmi.c
@@ -122,7 +122,6 @@ const struct dmi_system_id x86_android_tablet_ids[] __initconst = {
 		/* Lenovo Yoga Tab 3 Pro YT3-X90F */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
 		},
 		.driver_data = (void *)&lenovo_yt3_info,
-- 
2.43.0


