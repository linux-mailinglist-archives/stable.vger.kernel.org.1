Return-Path: <stable+bounces-58826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E9892C07A
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 584211C2345F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134271CCCC0;
	Tue,  9 Jul 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILq/f0SN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27761CCCAE;
	Tue,  9 Jul 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542197; cv=none; b=sYZyLtfCicsndWNEQpY6HsPFGVLf8zpvc0bvdAbtmShDjgFh0WwwgUpUvU7XZyhxxkaEIgiszv2xF4U3DJUrRfbJBUQkq9SxmkdH2S2NxEEto0TKpT0+AHfQ4EiuaTwAAjuZ70j+aufOyWg/C4zjj3qSTRelaOdSx8kozAC1WuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542197; c=relaxed/simple;
	bh=RoVkqZ9Kr2yPL4P59WLbHGn0Hyk+6fHlrZs8pASq/Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtOMj2mVPUyPwtBqHNcHALt68aAKCEAtUrYP+PYC6m1DCTGVLB2q2X0AZHFtLqUYZo21ygqMqRinBBYY8gleTLAc5GlKQE+PGvIvOVutoIXTYSV6baVlShM3HdifKt6Vs/goBjKe41VcdjZ7/I98Eq3gYFL/vzedwoDQzfU0qgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILq/f0SN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605CAC32782;
	Tue,  9 Jul 2024 16:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542197;
	bh=RoVkqZ9Kr2yPL4P59WLbHGn0Hyk+6fHlrZs8pASq/Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILq/f0SNqh0dswASeewY2Bewwh9ls9r+Ee0siNiVEQCVH2xZ1MmMEEYyq7GJdg0XP
	 Gd6nWyXAlTiW7vVwEsByIiJ/0SGxeGuwFrCPRnm0c0+ebS8IQiXIgGExl8bnZS/6xC
	 x6fl3lhF8a8RWOvy44BQlPBGLZRYqhicSaA70wjeQQf3mneOoqoj02bk8MlMoZXBcd
	 zYht3kJrdW2SK1hyWOfrozdfZBnGg8HScylbMtR4SRyVnFaxAmwrDo6crIQoe9bbRO
	 F0ANv5MHMTmxA7tNoyNXCluvr1C/IkQc67/bVLfjy5aaROt0+6eaofjTsSmeIxwGUZ
	 vrXHPX42LqQsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Agathe Boutmy <agathe@boutmy.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	matan@svgalib.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 24/33] platform/x86: lg-laptop: Change ACPI device id
Date: Tue,  9 Jul 2024 12:21:50 -0400
Message-ID: <20240709162224.31148-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 58a54f27a0dac81f7fd3514be01012635219a53c ]

The LGEX0815 ACPI device id is used for handling hotkey events, but
this functionality is already handled by the wireless-hotkey driver.

The LGEX0820 ACPI device id however is used to manage various
platform features using the WMAB/WMBB ACPI methods. Use this ACPI
device id to avoid blocking the wireless-hotkey driver from probing.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240606233540.9774-4-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/lg-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index 545872adbc52a..8f8eb13b2a6b2 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -768,7 +768,7 @@ static void acpi_remove(struct acpi_device *device)
 }
 
 static const struct acpi_device_id device_ids[] = {
-	{"LGEX0815", 0},
+	{"LGEX0820", 0},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
-- 
2.43.0


