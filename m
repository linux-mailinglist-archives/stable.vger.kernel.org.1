Return-Path: <stable+bounces-149569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD743ACB38F
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F023A51B4
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB9522A4DB;
	Mon,  2 Jun 2025 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jWk5p+27"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD386221739;
	Mon,  2 Jun 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874354; cv=none; b=WsJH0gH+20MR9nCf4KeDO1RwrNEMN2IjUzY3C9RVqd9PfarnYVNL44YRO81DmnVrQ6z7GHziIYSU3tkbUPAZKPlaXu7neaitdIGmeZtVbxPsVnDzK78spL59ip5OPCLNxfwkNngNuHuc3v4j+cUUHBupYB2FHW+zXqFgWFPcx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874354; c=relaxed/simple;
	bh=3QBikKu2d9pjcVheP8wwpe/2WIxPs3hC+2cjFHPrx0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jj7xjyYtZjbVBfY+r42zPCLd9Wgg33W1m9Y6QeqON21Q5/ir8chwbdRo5ZBx2kLRe2j1UDWpv9rQ66CFGp2EC+d0fvFg+uZSQtDg9KK8LjbfIDwDVQCzYhjzhEbcwXsV1mUZV18oLoUebOlBFduGLmpA+SZciGNiyCUQmCSaoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jWk5p+27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F58FC4CEEB;
	Mon,  2 Jun 2025 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874354;
	bh=3QBikKu2d9pjcVheP8wwpe/2WIxPs3hC+2cjFHPrx0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWk5p+27Pm5ImENQJnvouW9v/mTVbdLXF7OM4tMaBmKicJ30qxrGYAhVhQscW64xM
	 hUoUNiH5pqR/k16jEgrKoFQvdXY6ulgbK5YlfYtZvO6D/H3BvdrkJfQJDLEFpdyjis
	 BPofXNeXOpRzHoGW44x7uBX9/5Gw+Suo+gfbm92o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Chau <johnchau@0atlas.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 434/444] platform/x86: thinkpad_acpi: Support also NEC Lavie X1475JAS
Date: Mon,  2 Jun 2025 15:48:18 +0200
Message-ID: <20250602134358.557404852@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Chau <johnchau@0atlas.com>

[ Upstream commit a032f29a15412fab9f4352e0032836d51420a338 ]

Change get_thinkpad_model_data() to check for additional vendor name
"NEC" in order to support NEC Lavie X1475JAS notebook (and perhaps
more).

The reason of this works with minimal changes is because NEC Lavie
X1475JAS is a Thinkpad inside. ACPI dumps reveals its OEM ID to be
"LENOVO", BIOS version "R2PET30W" matches typical Lenovo BIOS version,
the existence of HKEY of LEN0268, with DMI fw string is "R2PHT24W".

I compiled and tested with my own machine, attached the dmesg
below as proof of work:
[    6.288932] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    6.288937] thinkpad_acpi: http://ibm-acpi.sf.net/
[    6.288938] thinkpad_acpi: ThinkPad BIOS R2PET30W (1.11 ), EC R2PHT24W
[    6.307000] thinkpad_acpi: radio switch found; radios are enabled
[    6.307030] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    6.307033] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    6.320322] thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
[    6.371963] thinkpad_acpi: secondary fan control detected & enabled
[    6.391922] thinkpad_acpi: battery 1 registered (start 0, stop 85, behaviours: 0x7)
[    6.398375] input: ThinkPad Extra Buttons as /devices/platform/thinkpad_acpi/input/input13

Signed-off-by: John Chau <johnchau@0atlas.com>
Link: https://lore.kernel.org/r/20250504165513.295135-1-johnchau@0atlas.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index cde5f845cf255..bcb0689101e2b 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -11315,6 +11315,8 @@ static int __must_check __init get_thinkpad_model_data(
 		tp->vendor = PCI_VENDOR_ID_IBM;
 	else if (dmi_name_in_vendors("LENOVO"))
 		tp->vendor = PCI_VENDOR_ID_LENOVO;
+	else if (dmi_name_in_vendors("NEC"))
+		tp->vendor = PCI_VENDOR_ID_LENOVO;
 	else
 		return 0;
 
-- 
2.39.5




