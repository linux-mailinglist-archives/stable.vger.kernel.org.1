Return-Path: <stable+bounces-172213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5ABB301DA
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AA5178730
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A9284695;
	Thu, 21 Aug 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2vo8Y5N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7719EED3
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800302; cv=none; b=ig5PXzGn8zZIpQM6ZLrcWadKCi0Y2RjbZS+eKMj2P3iV5NXySPjwqzTe/QCvX71gAI+9dhQ1W3FDj6b0w9W1ein0RLAvw/AFayEzJLru4D8xkPsxelkmSwT2QG5RG0D+NxKeo6210KOdEFTDZ1ih6Ew/nQ4CZwh07abgj07fSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800302; c=relaxed/simple;
	bh=qBUu9ey73D6gncW/WtcF/rAkVmTK/mHSPFw+sWdwTRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtvFgQL/9fGH6dMVbglDrhgo5moONxX2GRoqd16s71BmIDYiq98nmLMpy+Mjrld1ZPVArrbHoe709OSvWIy60UElR7bUdD7naSM19DzQyLg3monRBGYo1A0+GY0t5EqDaSjftxlvoV0+KqvRWyjLQ3GKTP3HswJliuPNWYzYEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2vo8Y5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59DFC4CEEB;
	Thu, 21 Aug 2025 18:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755800300;
	bh=qBUu9ey73D6gncW/WtcF/rAkVmTK/mHSPFw+sWdwTRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2vo8Y5NAwdiEd8ybcwESVojo7KYVgoelLxnxwP9OUGFuXSXs4eO8TN2mpHJeXYRy
	 0PytbsG4bO23/jzj0OCM0S3fD/8lyCMxHI5/SwsAmx+oP60LZf064RU/fK59NHIQZa
	 MDVfXXkXlV5HV/eoxiHK8ocK6mkcNngMQ5BfEywrbUccn4AACdTwjD+Epb4WzMpLey
	 7ZQXjoj8665/rTqgp3oyjgtO/l+fSB4bQfyspSGIAulTqH8B7aCUX5TpoK8d8Guj0H
	 kZ3Y7J+QEQiYf1rIKDM+SQWWZQ+qNHvYRGe/8zj8Gh4Rju73QtS41J482xhr50uHNA
	 n2K2zggIkL9zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
Date: Thu, 21 Aug 2025 14:18:16 -0400
Message-ID: <20250821181816.887742-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082138-moustache-breezy-3b73@gregkh>
References: <2025082138-moustache-breezy-3b73@gregkh>
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
index 030cb32da980..a752253f7a5e 100644
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


