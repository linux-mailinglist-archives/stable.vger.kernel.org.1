Return-Path: <stable+bounces-48050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B488FCBBE
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B66B25E57
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFA51ABCA3;
	Wed,  5 Jun 2024 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/EnJ5dr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78DB19599F;
	Wed,  5 Jun 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588354; cv=none; b=K6MiXGNTSM8WFWTGPxwMJU1S+YcHMJwlSozyfpS6kZdgIdmzCuK2RwKYuHRCD2LBGXAGD2nUYx0IADo7UQHrpcRB9G1KV87UYgeH6XSD2MkZAWuP7prxCdAEFXJXevUahtr0mhinky+/hc/6yC1s9w1KkXGtRv9+jdSuS1yjKBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588354; c=relaxed/simple;
	bh=6KgIFqyKayKEXnNF/obBfmrkXcZtNXQT4U+oTZVIPK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKQZD2kHmj5D81q6HkqV/egZeNrmTSTsCQZA4AloBh9znbUZjZqnhZhJfWgirTbO+S8XjZN22ERUD76eqXhnE0Zk76VCOqJOhAOgchTZDlxjuIx7KwS+mgDeqjzyujG4WrlCBoBTCPn3bcBEACR38iwsZw5+gbP0Et4+ORROEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/EnJ5dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEBDC4AF08;
	Wed,  5 Jun 2024 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588354;
	bh=6KgIFqyKayKEXnNF/obBfmrkXcZtNXQT4U+oTZVIPK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L/EnJ5dr+STw5LAb2poqDDbdA+XOQjo2HhjXZAVdci25e5eAoPvRQq7lY5RyHNEdF
	 aa87fy2paBMAISDxF635v+kEhxiTY2kPQg0h72HIeublAIBQAdS2dy4TA+GTBlIuOP
	 aNXvXjYHJ43YyUsDyJkZpf9Yj/kHObobtyYIAgWA7nk97yumDn3FCWveDcdgeuDGIv
	 qbzblzSCnX5cQppFVnHyQlwTQw6Pv88tPQOWNt6+3V7pTiFoRffAQQ3YUJqXypXdZ/
	 GPMjf3Dw7SZrUln/YYheMXtmhNOkjCpJPANwgmMD4Za9JbmrVjvWIDY0nOUzYVsafz
	 9MPCx3GCO6JFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/20] usb: dwc3: pci: Don't set "linux,phy_charger_detect" property on Lenovo Yoga Tab2 1380
Date: Wed,  5 Jun 2024 07:51:48 -0400
Message-ID: <20240605115225.2963242-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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


