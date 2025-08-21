Return-Path: <stable+bounces-171979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61664B2F881
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 14:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8740DAC4D02
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 12:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083AF320CAE;
	Thu, 21 Aug 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DNoTaAVo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911F31DD84
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780100; cv=none; b=VkHtcb2d5T3DSubsCIStQl2Z63svWrSyxwXBwNIAdKaVCKgH8tHy2iUQ3m+EUVNAFCuKhnPzc4dKUZp4zpOQBSkRtMIrNIlwVnt24fNS1N3S6EU7ylmxC3IQxieBLMmJyILiI/1VHidslrN1hKZIK/Z2PDX3S0hHAH5xpyLyg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780100; c=relaxed/simple;
	bh=Cb1bbvS4kc0CgR7QFF2VfBCI02YWsVaChtIovTLEi8Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=APt0Yfuj+YJsL9x6HVpL1HgOmchEr6SYLVcqnuyhGIgDbhQo/O5RQxqTw+j0Wi7s16mReB2/ASA4Ml4Sx3cbZXA0CccB6Kp9qF42kUdtFDj1iNaz3dhvikZxzoI0mNz97opswyX2OOx6NpWkmH3dGNsGQnUaM8wINO8Ha1wBglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DNoTaAVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA62C4CEED;
	Thu, 21 Aug 2025 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755780100;
	bh=Cb1bbvS4kc0CgR7QFF2VfBCI02YWsVaChtIovTLEi8Q=;
	h=Subject:To:Cc:From:Date:From;
	b=DNoTaAVoCr+kiw1rCLBJTqnvwK1kfBgP5q5IiKLm39vOiT4y0uUao1ueeh45YZkSt
	 Jkx9far+nWR66tUFwk0rvghxcZG4yhDjurFx122AVjBYxjKSJaQQq9cfS7Y4PUqiYG
	 u9gY8Qvx9KVa+157Qauank1OCtR7JMlQj68+p4qw=
Subject: FAILED: patch "[PATCH] ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig" failed to apply to 6.6-stable tree
To: dlemoal@kernel.org,cassel@kernel.org,hare@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 14:41:37 +0200
Message-ID: <2025082137-grandly-daytime-751f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ed62a62a18bc144f73eadf866ae46842e8f6606e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082137-grandly-daytime-751f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed62a62a18bc144f73eadf866ae46842e8f6606e Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Wed, 18 Jun 2025 16:25:19 +0900
Subject: [PATCH] ata: Fix SATA_MOBILE_LPM_POLICY description in Kconfig

Improve the description of the possible default SATA link power
management policies and add the missing description for policy 5.
No functional changes.

Fixes: a5ec5a7bfd1f ("ata: ahci: Support state with min power but Partial low power state")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Niklas Cassel <cassel@kernel.org>

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e00536b49552..120a2b7067fc 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -117,23 +117,39 @@ config SATA_AHCI
 
 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy"
-	range 0 4
+	range 0 5
 	default 3
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
 	  for chipsets / "South Bridges" supporting low-power modes. Such
 	  chipsets are ubiquitous across laptops, desktops and servers.
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
 
-	  The value set has the following meanings:
+	  The possible values for the default SATA link power management
+	  policies are:
 		0 => Keep firmware settings
-		1 => Maximum performance
-		2 => Medium power
-		3 => Medium power with Device Initiated PM enabled
-		4 => Minimum power
+		1 => No power savings (maximum performance)
+		2 => HIPM (Partial)
+		3 => HIPM (Partial) and DIPM (Partial and Slumber)
+		4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber)
+		5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber)
 
-	  Note "Minimum power" is known to cause issues, including disk
-	  corruption, with some disks and should not be used.
+	  Excluding the value 0, higher values represent policies with higher
+	  power savings.
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"


