Return-Path: <stable+bounces-58873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE17992C0FA
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4CE1C2086F
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 16:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADC018FA1E;
	Tue,  9 Jul 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxM9jPJP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EB18FA11;
	Tue,  9 Jul 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542342; cv=none; b=tUJ0kN8B3pmB4l0itTb89y9b89KyfCt6OFWGRi4G41iKK38QPit+R8kdjTuvyOlCfQcDzYB7uuDkd3/bUOn9M3wFKiOhdrNtmlv2PxjLDvXL0HWOMSVqaTuHHDyzpYwwojwNrow06+w5ThBK4gYcLGcXOfJXepqWEKiNR5YYK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542342; c=relaxed/simple;
	bh=LfflC9vvOYsvgBC6GhLTD6FIpi3avh4Z5kpJV7ixlFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3XmeWW+gI54ny6Obi/ZAc7/XDq5/1repWF11KhxOiOBymOaJngGvogRE5HiKUjfeF4y29Pf8bdnOAzmGTbBZdH+G4WZhVtfopAt702D8A2Y2v0bpcz8FztdA/KYXBF/W3IauA/lbDeqS1dBgpjaWF4YweQsNgGWbolScJg3nlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxM9jPJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B258AC32786;
	Tue,  9 Jul 2024 16:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542342;
	bh=LfflC9vvOYsvgBC6GhLTD6FIpi3avh4Z5kpJV7ixlFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxM9jPJPddEYBfsaan4spLVMzaH2nrLNH1nDlK632sTBxEP69Nw3a9exfqfP1dz22
	 +aQ/gVMysvSwRf+bGTHeEuWp1nQHBZi0aMI0rf0P8gL/DNbCCSV940eqWRT0KBrLCJ
	 3/5H0ahSXxfl6dhvD3akAR02vGzjOmWOPrQDie8pEcFFeeaIXQuqGSYmUQFctMDZR0
	 iIYTBZiwANdA/AREfYuMQanxxJoAdKj1QbmckVRSaW1A2zxW/9L4q+OrNtvQmwiwve
	 Ebn2M2q/6BFNusECI3lc3phGbsERPJaX7LxrDJZ+/ZByw94OWHlPaIPhA8nnGW3acV
	 JfPa+lVbq7lxA==
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
Subject: [PATCH AUTOSEL 5.15 11/17] platform/x86: lg-laptop: Change ACPI device id
Date: Tue,  9 Jul 2024 12:24:55 -0400
Message-ID: <20240709162517.32584-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162517.32584-1-sashal@kernel.org>
References: <20240709162517.32584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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
index 96960f96f775c..807bd4283b979 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -718,7 +718,7 @@ static int acpi_remove(struct acpi_device *device)
 }
 
 static const struct acpi_device_id device_ids[] = {
-	{"LGEX0815", 0},
+	{"LGEX0820", 0},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
-- 
2.43.0


