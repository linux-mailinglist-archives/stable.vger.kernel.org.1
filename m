Return-Path: <stable+bounces-172201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD33B30088
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE73917E2C2
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A242E543F;
	Thu, 21 Aug 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XboD76Tm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A72E3AE4
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795148; cv=none; b=LxCd48kyIR0OTHwVeLC6JbtmP9Nr41tQZ9mHx7DE2iyIIoUJp/VfPiyY3iKXGOSvQ145SxyLKyYqXlEvJ22XJUi8JkI8d/n3ruF9vZULWhxZeHW+IvTTJdzzlEuIi2UGIDb3syGuV3Osc+KYZmo1yzPY5GLiX1SfNE9RGCvaA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795148; c=relaxed/simple;
	bh=nID75TjCTwH6QXoUjuTFPPRmCZV3lA2f1vviSKotKH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YaJ1Zunfishz8wQSuaj2bVtrY9B4FpVRjy9UtmUj+q6P6njBn5GrOoH97PQAJ/rCEKqGcxcTjUTJ4IWTN4iX3QFYYGEcDM23kTwMT3Ei6Kp5OZi5/rgukeyidZTCBjDBcMh2avwpuxFymrgvQqj+QtvUrO07RZZRauISpykOX6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XboD76Tm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3DDC4CEEB;
	Thu, 21 Aug 2025 16:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755795147;
	bh=nID75TjCTwH6QXoUjuTFPPRmCZV3lA2f1vviSKotKH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XboD76TmiIr39wAENGLL76BUPiVWhSS1JqqUb/4XJRG3RAUurQNBiqtMIyMc4WB+f
	 IyMN6M7EcZ8J71Q3kxTxbHOQiUEr95zkABdCpCt9hJOi1f9uPgeFGJk5osXaM6cxtY
	 HptE2cV6D9i0evLumfBm8NGAgCUkDZw4o3plf1l4FVd8NsUj5dH0p32ikkdYuYMz7z
	 ZiZ1H//BeMlQVev5WB/hICQlajfxgR4zjnCKiykcDLv9FtZ9H5NR4AI4UOiXV6R9k4
	 hohqycUeF5QdXynlmVRaGec7RvLIQyM52uB3MDm6jn6qNrWdKqR7npnipYrLbd/S03
	 NxgFUrDY4lvCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
Date: Thu, 21 Aug 2025 12:52:24 -0400
Message-ID: <20250821165224.842834-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082137-earmuff-rifling-98cf@gregkh>
References: <2025082137-earmuff-rifling-98cf@gregkh>
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
index d9b305a3427f..5f96d15e0c09 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -117,7 +117,7 @@ config SATA_AHCI
 
 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy for low power chipsets"
-	range 0 4
+	range 0 5
 	default 0
 	depends on SATA_AHCI
 	help
@@ -126,15 +126,32 @@ config SATA_MOBILE_LPM_POLICY
 	  chipsets are typically found on most laptops but desktops and
 	  servers now also widely use chipsets supporting low power modes.
 
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


