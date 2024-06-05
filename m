Return-Path: <stable+bounces-48000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214388FCAF5
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A383328CE2B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4927195FE3;
	Wed,  5 Jun 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw8dL805"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29D195FD9;
	Wed,  5 Jun 2024 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588182; cv=none; b=BLY0lKi/InD+0e85ETDuAtIFi0PmXh/j9N/2lXrnN1W1uTV5iWyu6CKoFN1f/t1JNmFGj7EIH+0+CGKyO1jf3407e8Yg02UnNtMQYTle6VDBrCk5gcyo6UdmgekCpdbyqtxvdcPFuUWk5G7PIPUQX+y33FwUZWX3z0nZ9zfS6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588182; c=relaxed/simple;
	bh=6KgIFqyKayKEXnNF/obBfmrkXcZtNXQT4U+oTZVIPK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tw6YStz2rnKfFjx//h56VWXCSwl+mLfK28fuwv+vgegDSB46E3y32MpPUkwabSoSKSllj7oF2rwrfqNHlf+aEBoPDH1OkU/BnlmpfwbkHmSaIoUZocoEjg31GsompGGoeuccHHUy/MixZDnPl6QBoYOMykcxPiMKRJh2MVbRsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw8dL805; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C46C32786;
	Wed,  5 Jun 2024 11:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588181;
	bh=6KgIFqyKayKEXnNF/obBfmrkXcZtNXQT4U+oTZVIPK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jw8dL805RZxx57jw6uNtimblw5b6+hXb6emX+1WDgdK2XRcT17DaZXxH3uo7Lpj84
	 cm4WhcKhwH4u3b0GvqujIlxW8roxqMb3IYi0M1DOzYv6HWKnRLzvFhH6y6n4HfA7VU
	 IEYZ6FnXYulmhjhdzb5aFQvSp5fmxatqk9Zc6KjTzzL/AapRC1xO+lbRCtWbxu0BVo
	 iQI14aaqjEr4z4kT68H1diuchPgZi2VkYJooZ+PhMCQ67/DoZv3qs8Bxms8x7hD4Qc
	 iPnDlv8ajDOMP/Xjl1MmOHB/woMoUFWGl67XmLJgD2HpafMu1BZd04cJrmAPg8xadQ
	 Lmr9zx5zMymvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 07/28] usb: dwc3: pci: Don't set "linux,phy_charger_detect" property on Lenovo Yoga Tab2 1380
Date: Wed,  5 Jun 2024 07:48:36 -0400
Message-ID: <20240605114927.2961639-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0fb782b5d5c462b2518b3b4fe7d652114c28d613 ]

The Lenovo Yoga Tablet 2 Pro 1380 model is the exception to the rule that
devices which use the Crystal Cove PMIC without using ACPI for battery and
AC power_supply class support use the USB-phy for charger detection.

Unlike the Lenovo Yoga Tablet 2 830 / 1050 models this model has an extra
LC824206XA Micro USB switch which does the charger detection.

Add a DMI quirk to not set the "linux,phy_charger_detect" property on
the 1380 model. This quirk matches on the BIOS version to differentiate
the 1380 model from the 830 and 1050 models which otherwise have
the same DMI strings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240406140127.17885-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 497deed38c0c1..9ef821ca2fc71 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -8,6 +8,7 @@
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
  */
 
+#include <linux/dmi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -220,6 +221,7 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
 
 		if (pdev->device == PCI_DEVICE_ID_INTEL_BYT) {
 			struct gpio_desc *gpio;
+			const char *bios_ver;
 			int ret;
 
 			/* On BYT the FW does not always enable the refclock */
@@ -277,8 +279,12 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
 			 * detection. These can be identified by them _not_
 			 * using the standard ACPI battery and ac drivers.
 			 */
+			bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
 			if (acpi_dev_present("INT33FD", "1", 2) &&
-			    acpi_quirk_skip_acpi_ac_and_battery()) {
+			    acpi_quirk_skip_acpi_ac_and_battery() &&
+			    /* Lenovo Yoga Tablet 2 Pro 1380 uses LC824206XA instead */
+			    !(bios_ver &&
+			      strstarts(bios_ver, "BLADE_21.X64.0005.R00.1504101516"))) {
 				dev_info(&pdev->dev, "Using TUSB1211 phy for charger detection\n");
 				swnode = &dwc3_pci_intel_phy_charger_detect_swnode;
 			}
-- 
2.43.0


