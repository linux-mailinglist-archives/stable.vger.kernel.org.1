Return-Path: <stable+bounces-58889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC4392C136
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509991C222E0
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA9B1A83C7;
	Tue,  9 Jul 2024 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTMQua9B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD231A83BD;
	Tue,  9 Jul 2024 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542396; cv=none; b=NurLlu5VOhJDalLQ13YncZ5hZP22zKFq59GV+yD24UQt++b63v8nv0bD0y5PG+L6JatgC/ErtG9L3BpDdGqBBXdlEk3fS5OX6pdeEmG6J1y4r5VnbEP7OpKPDpahlun5ogEVH2+VHqSsNcbzA9dsmDusPJm2pU0ONjWxWsBCK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542396; c=relaxed/simple;
	bh=ZRVHOBkWcLbOHvLTj6zdwf8ySR89N2yy5K8UWIG2bvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvETCjn/mkoGSUV4kwbRRMi4O6/dZvXCdf0K+1Efhf16XWVtH/+WYSj3anfXE0gfSTjhitTp585YXzOgdme/itTaaQcLJadMFfY50tfm4AjxjdlJaZtHJdb5+Z5gDjEFoFsInrtAzjP+pxoISYRRU7gY4rut0OvLU4goTuvPlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTMQua9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931FBC3277B;
	Tue,  9 Jul 2024 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542395;
	bh=ZRVHOBkWcLbOHvLTj6zdwf8ySR89N2yy5K8UWIG2bvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTMQua9BcO0lihElw4cgWzitMwpQOcNzCAeLZU0ylqDiY/B+FUGh6gR6D1n7riIQT
	 oJf/u1X2ykdtfHR6gg8R5spZYBuajZskYZ9hoiw/7Volts+Wuj52jrV5NHWnLS6pSR
	 47OqcWIDSkUBZHgN+jsBR2ETPdL/o8U5hgpXIaN/FRROEbVb6XNIrS1J5hurqiqDHY
	 wvLm8DkFz4uBaLvR4fkAJA8N7CHOw/TuWVP066CRlM/VAZL9IIkOSKdyHXpC+5w31q
	 VHWhwH7lxgpKpYgc4UzCKNRQTKBKXvw2RA9LQuO+oV8FYrJWs2CvPIu5xxotthHSv3
	 yV7G4d1e/Qxlw==
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
Subject: [PATCH AUTOSEL 5.10 10/14] platform/x86: lg-laptop: Change ACPI device id
Date: Tue,  9 Jul 2024 12:25:54 -0400
Message-ID: <20240709162612.32988-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162612.32988-1-sashal@kernel.org>
References: <20240709162612.32988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
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
index 6b48e545775c0..e3cf567470c8b 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -647,7 +647,7 @@ static int acpi_remove(struct acpi_device *device)
 }
 
 static const struct acpi_device_id device_ids[] = {
-	{"LGEX0815", 0},
+	{"LGEX0820", 0},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
-- 
2.43.0


