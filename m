Return-Path: <stable+bounces-34553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A54893FD3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CB31F22175
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB3147A62;
	Mon,  1 Apr 2024 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wONPKtRP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB9B43AD6;
	Mon,  1 Apr 2024 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988508; cv=none; b=gWBKrth/186lBFjX/YwJbn0xELK+ce3tydJujbdN2H+qMQyiq1dBvmnOWDjv+4k5X7uZLCsMOYPR8VcJFrE8fgpKWXMzXrpkGLjxH9pVG0znskMlaUBW8f+aQ1B5kbOFjfgU7YhDmIaRZTBiJJHUWMOrFqamGVdeTcNfrA2wS9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988508; c=relaxed/simple;
	bh=V19j8Le84iitx6OPut0SBy4DGJ9sVPyCaTGgXmPafRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEWtQlUi77k3zg1RbYKXtXTIFIN1ftYCohrOZGNHthK9RbHsvI6IMyDuxTGjy4Bfshh9ZnjHhXwW8JB3QZ/TY7TJOmVZ1NL4FMG5cWiqq/BElpY19zM+zsjfFPzgQTRyFLHmG9T4ocT90Fy+g3OVfKb3ZtcG8cf/fhSzbvQ1S6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wONPKtRP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DD2C433C7;
	Mon,  1 Apr 2024 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988508;
	bh=V19j8Le84iitx6OPut0SBy4DGJ9sVPyCaTGgXmPafRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wONPKtRPpirV6rD4pc0AJw0ZjWyOnSGSk9bbTKNFP41MiY+0hUt71thSiMcfKmh7F
	 tsKCl157NMAuzFI+A1zt2lr1WQyLvPFMWqKgMCeQGZILZSz8MH2WZoTh47UtCoOV5H
	 N78744tg1gtgWlslpesJIBLoFc1O5xaoUb5Zvc1U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt <cryptearth@googlemail.com>,
	Conrad Kostecki <conikost@gentoo.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 206/432] ahci: asm1064: asm1166: dont limit reported ports
Date: Mon,  1 Apr 2024 17:43:13 +0200
Message-ID: <20240401152559.279083002@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Conrad Kostecki <conikost@gentoo.org>

[ Upstream commit 6cd8adc3e18960f6e59d797285ed34ef473cc896 ]

Previously, patches have been added to limit the reported count of SATA
ports for asm1064 and asm1166 SATA controllers, as those controllers do
report more ports than physically having.

While it is allowed to report more ports than physically having in CAP.NP,
it is not allowed to report more ports than physically having in the PI
(Ports Implemented) register, which is what these HBAs do.
(This is a AHCI spec violation.)

Unfortunately, it seems that the PMP implementation in these ASMedia HBAs
is also violating the AHCI and SATA-IO PMP specification.

What these HBAs do is that they do not report that they support PMP
(CAP.SPM (Supports Port Multiplier) is not set).

Instead, they have decided to add extra "virtual" ports in the PI register
that is used if a port multiplier is connected to any of the physical
ports of the HBA.

Enumerating the devices behind the PMP as specified in the AHCI and
SATA-IO specifications, by using PMP READ and PMP WRITE commands to the
physical ports of the HBA is not possible, you have to use the "virtual"
ports.

This is of course bad, because this gives us no way to detect the device
and vendor ID of the PMP actually connected to the HBA, which means that
we can not apply the proper PMP quirks for the PMP that is connected to
the HBA.

Limiting the port map will thus stop these controllers from working with
SATA Port Multipliers.

This patch reverts both patches for asm1064 and asm1166, so old behavior
is restored and SATA PMP will work again, but it will also reintroduce the
(minutes long) extra boot time for the ASMedia controllers that do not
have a PMP connected (either on the PCIe card itself, or an external PMP).

However, a longer boot time for some, is the lesser evil compared to some
other users not being able to detect their drives at all.

Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
Cc: stable@vger.kernel.org
Reported-by: Matt <cryptearth@googlemail.com>
Signed-off-by: Conrad Kostecki <conikost@gentoo.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
[cassel: rewrote commit message]
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 682ff550ccfb9..df3fd6474bf21 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -671,19 +671,6 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
 static void ahci_pci_save_initial_config(struct pci_dev *pdev,
 					 struct ahci_host_priv *hpriv)
 {
-	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
-		switch (pdev->device) {
-		case 0x1166:
-			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
-			hpriv->saved_port_map = 0x3f;
-			break;
-		case 0x1064:
-			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
-			hpriv->saved_port_map = 0xf;
-			break;
-		}
-	}
-
 	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
 		dev_info(&pdev->dev, "JMB361 has only one port\n");
 		hpriv->saved_port_map = 1;
-- 
2.43.0




