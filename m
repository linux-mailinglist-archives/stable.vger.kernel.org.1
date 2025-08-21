Return-Path: <stable+bounces-172210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86635B301B6
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF8F7A3E05
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995034165B;
	Thu, 21 Aug 2025 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qerDqB9n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787AB2E62A4
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799742; cv=none; b=gmValpTeWRPM0CNoPdTPBTBHVr9jJfmOiknqXfwloSypYT1VfTCGEnpSceDXcgTs/GhyXnCDjIp1fs2kdA6Lh9tteJetbNbcYp0bVxvqeFgtCgx0pA4gRrT339TsFetRElP2EIIgmJ8TKerrZcm1qYayf84jefKy6xzLdmb3p28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799742; c=relaxed/simple;
	bh=HE3vWAXnwGn4TzTaG5AV9QKeo644xP4cwr3zK257TM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCl7YJL0/yyX3rp32clNcyQUVdGNBIvhPIOcRxSlO3BSpusPFk7Whb6y8NSsCdK8szZLOePdcqV2Dk7zB8vx9n8bQ8iktA9at1ouJ7r0MkFBYa4BWjpR17x88JrSlCsNjiz2M3AnOK9UxCDIEPXoJbEh2Yb/tttacyefH85qRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qerDqB9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1CDC4CEEB;
	Thu, 21 Aug 2025 18:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755799742;
	bh=HE3vWAXnwGn4TzTaG5AV9QKeo644xP4cwr3zK257TM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qerDqB9nSD3ZlepbY3YzAEQ+pfE5ebBw7mKcYspW2JWghQFrVH3ag+oKmhnMsVgPV
	 UoioxK/39sUsh8kxeNhxBa/8zGA7DkuhrlAf9hk0bziyGzGfsYyMwzNaK+zYe+xpaM
	 kfBR8j9xfmooiw6do8NbKyYMbaljly7rrmuEoAYUP2yPGERc1vMfAaOIM18pt2m8fQ
	 2TNXsoKxVweCgn1Aci9aCW12wVkSSoCKsTx5625DXj7yMS6BHv34wRHlpOj+Ipm2iP
	 3xKWTvtbVvipKPfNdeui+swed0vPISiL9cZ7bU8RSzr+Mn9CRlmMH9BO6SwnZIN0Qc
	 dTEvA9mlBtZiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
Date: Thu, 21 Aug 2025 14:08:59 -0400
Message-ID: <20250821180859.884176-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082137-platypus-ditzy-1762@gregkh>
References: <2025082137-platypus-ditzy-1762@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit ed62a62a18bc144f73eadf866ae46842e8f6606e ]

Improve the description of the possible default SATA link power
management policies and add the missing description for policy 5.
No functional changes.

Fixes: a5ec5a7bfd1f ("ata: ahci: Support state with min power but Partial low power state")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/Kconfig | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a7da8ea7b3ed..3630d86c74f1 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -117,22 +117,39 @@ config SATA_AHCI
 
 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy for mobile chipsets"
-	range 0 4
+	range 0 5
 	default 0
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
 	  for mobile / laptop variants of chipsets / "South Bridges".
 
-	  The value set has the following meanings:
+	  Each policy combines power saving states and features:
+	   - Partial: The Phy logic is powered but is in a reduced power
+                      state. The exit latency from this state is no longer than
+                      10us).
+	   - Slumber: The Phy logic is powered but is in an even lower power
+                      state. The exit latency from this state is potentially
+		      longer, but no longer than 10ms.
+	   - DevSleep: The Phy logic may be powered down. The exit latency from
+	               this state is no longer than 20 ms, unless otherwise
+		       specified by DETO in the device Identify Device Data log.
+	   - HIPM: Host Initiated Power Management (host automatically
+		   transitions to partial and slumber).
+	   - DIPM: Device Initiated Power Management (device automatically
+		   transitions to partial and slumber).
+
+	  The possible values for the default SATA link power management
+	  policies are:
 		0 => Keep firmware settings
-		1 => Maximum performance
-		2 => Medium power
-		3 => Medium power with Device Initiated PM enabled
-		4 => Minimum power
-
-	  Note "Minimum power" is known to cause issues, including disk
-	  corruption, with some disks and should not be used.
+		1 => No power savings (maximum performance)
+		2 => HIPM (Partial)
+		3 => HIPM (Partial) and DIPM (Partial and Slumber)
+		4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber)
+		5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber)
+
+	  Excluding the value 0, higher values represent policies with higher
+	  power savings.
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
-- 
2.50.1


