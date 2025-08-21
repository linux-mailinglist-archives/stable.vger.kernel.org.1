Return-Path: <stable+bounces-172214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AA2B3020E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 20:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBA5B6192E
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69E2FB63C;
	Thu, 21 Aug 2025 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGmw+3ZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77D2C21C3
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800817; cv=none; b=pJ2pfz/IsNbQ6R6BgHMODtTfpvqBGv7tZxgYjc0OjCFrYS5+/70umr1tsRmKsvxhiFulMZCHs6vcBpPSDLuHb60BpCoJpVDQIIJA8FdgbYYXrJ25h7ZCwenqP4GQxFQ9zif28bkDZHYmHYElEcNB+t85veqOOD+2T0fzh1/pmkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800817; c=relaxed/simple;
	bh=Jns9dM6bNUD2PTcsoWc8SsUsE/eiP0j6c3h0Gkcyqd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkTnUdhK8GxQ3nlEMNjZvmBNDdJd86ycrAlnQn3y+o2GTu6ahnW8ANDSZP6HRIjnsjeanPaSzvdbXM3HaqkHrUytGQLSRO2sbKmgM2RSzcJD+XepwxLOogZ6vHIyhVuG3bBB3kb1eg8H35I0I0G5tZ2mFsHSKILOt8L9Pc3gprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGmw+3ZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E94C4CEEB;
	Thu, 21 Aug 2025 18:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755800817;
	bh=Jns9dM6bNUD2PTcsoWc8SsUsE/eiP0j6c3h0Gkcyqd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGmw+3ZTYzTklfahCE7bIo53qmzJByejkVtknqhJLwjVVOO5tJKyhsFlNirkCWpch
	 psIMbccRIjpeLQ0v7UPn2A2yMfiPKgCdrqJ6kF539KTl4NO1wEZCekJ5f5Nt84sWuA
	 ORMYsoy09O+1PTvu2mGAUY13yDY1GL01xPc+N2pyZ6/0HQHU6z4ujuPYwulqYX8Jw1
	 YtuEFdNUBvXkdBwlQrwbH2yuj6trgsfrz0H2cEyTtMXmoxOQQHOvkV9EBgWVscy0p4
	 dPXv2hHXazyGe6qixryLthd0ch7TYMxWL3g8JZIvAbVglC6OAEpUooke5oWQWUUMH6
	 Q8iV5brur7fOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig
Date: Thu, 21 Aug 2025 14:26:54 -0400
Message-ID: <20250821182654.891907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082138-collected-demeaning-2359@gregkh>
References: <2025082138-collected-demeaning-2359@gregkh>
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
index a6beb2c5a692..dbde78feda31 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -92,22 +92,39 @@ config SATA_AHCI
 
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


