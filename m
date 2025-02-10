Return-Path: <stable+bounces-114610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2799A2F03D
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F29188715E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FFE1F8BCC;
	Mon, 10 Feb 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hoV29skZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641131BEF91
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199106; cv=none; b=pMh1xsvjFd1PLHUmL8Wu/kzB5aNnJRfIwDSQIqwBkOTHPZ9W7aK9UiSCn7DwkyDMbfdeHygGWquwDc72NJHpL4FrlneeerkezWfq6FNvuZxSZ8/MsXdMXkB3G6mJiAMNY4y97GfUgfDkdPuvBrSunVC50nFn2WIE2c0JrDp37i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199106; c=relaxed/simple;
	bh=Q88XfLw2D3/AQeL2rJ5dD22qjFqZtsrL7djSSHdwwlg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J5ghrtNQ0LL8iaqYfioaW5cKKXCGKs2owhXxIU1sJrlun5pcDCAuJhrzXIl/QzSVkfZ1QCvejj+p0Da1ZFj6cddmPuYVxh+UjkUn7BkT8wRQzKbEz+M3k+YYW+RAuN8qoWG7WHpNTKVKBiV/I9aDd1PXJUGLd8lx/MlKLSgmP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hoV29skZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450B2C4CED1;
	Mon, 10 Feb 2025 14:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199105;
	bh=Q88XfLw2D3/AQeL2rJ5dD22qjFqZtsrL7djSSHdwwlg=;
	h=Subject:To:Cc:From:Date:From;
	b=hoV29skZVvmQYDpTvvOeYFLCUUSSqzKB6adqavv4C1Bjj4hdp+1PaEOo+WGQWzwEv
	 vaoAIRoAcRjmlTcCpNJraaHvsKkbV4amKvmXUaHt1l1r8jmbvwKU8nvP5A8FmsjaZi
	 5uQwY0850hP8x/7+CnkmJyvqnJNGhGcyfXaZjSJc=
Subject: FAILED: patch "[PATCH] ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus" failed to apply to 5.15-stable tree
To: romain.naour@skf.com,khilman@baylibre.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:51:33 +0100
Message-ID: <2025021033-chariot-imminent-753d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c1472ec1dc4419d0bae663c1a1e6cb98dc7881ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021033-chariot-imminent-753d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c1472ec1dc4419d0bae663c1a1e6cb98dc7881ad Mon Sep 17 00:00:00 2001
From: Romain Naour <romain.naour@skf.com>
Date: Fri, 15 Nov 2024 11:25:37 +0100
Subject: [PATCH] ARM: dts: dra7: Add bus_dma_limit for l4 cfg bus

A bus_dma_limit was added for l3 bus by commit cfb5d65f2595
("ARM: dts: dra7: Add bus_dma_limit for L3 bus") to fix an issue
observed only with SATA on DRA7-EVM with 4GB RAM and CONFIG_ARM_LPAE
enabled.

Since kernel 5.13, the SATA issue can be reproduced again following
the SATA node move from L3 bus to L4_cfg in commit 8af15365a368
("ARM: dts: Configure interconnect target module for dra7 sata").

Fix it by adding an empty dma-ranges property to l4_cfg and
segment@100000 nodes (parent device tree node of SATA controller) to
inherit the 2GB dma ranges limit from l3 bus node.

Note: A similar fix was applied for PCIe controller by commit
90d4d3f4ea45 ("ARM: dts: dra7: Fix bus_dma_limit for PCIe").

Fixes: 8af15365a368 ("ARM: dts: Configure interconnect target module for dra7 sata").
Link: https://lore.kernel.org/linux-omap/c583e1bb-f56b-4489-8012-ce742e85f233@smile.fr/
Cc: stable@vger.kernel.org # 5.13
Signed-off-by: Romain Naour <romain.naour@skf.com>
Link: https://lore.kernel.org/r/20241115102537.1330300-1-romain.naour@smile.fr
Signed-off-by: Kevin Hilman <khilman@baylibre.com>

diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
index 6e67d99832ac..ba7fdaae9c6e 100644
--- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
@@ -12,6 +12,7 @@ &l4_cfg {						/* 0x4a000000 */
 	ranges = <0x00000000 0x4a000000 0x100000>,	/* segment 0 */
 		 <0x00100000 0x4a100000 0x100000>,	/* segment 1 */
 		 <0x00200000 0x4a200000 0x100000>;	/* segment 2 */
+	dma-ranges;
 
 	segment@0 {					/* 0x4a000000 */
 		compatible = "simple-pm-bus";
@@ -557,6 +558,7 @@ segment@100000 {					/* 0x4a100000 */
 			 <0x0007e000 0x0017e000 0x001000>,	/* ap 124 */
 			 <0x00059000 0x00159000 0x001000>,	/* ap 125 */
 			 <0x0005a000 0x0015a000 0x001000>;	/* ap 126 */
+		dma-ranges;
 
 		target-module@2000 {			/* 0x4a102000, ap 27 3c.0 */
 			compatible = "ti,sysc";


