Return-Path: <stable+bounces-62760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69F940F78
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4728AB28445
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6CB19FA9E;
	Tue, 30 Jul 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="phEcBlsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC619FA8E
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335300; cv=none; b=maM+KLdbtCiEc2Mi1QtTJgkTZ/oE8t8byr5PUk4eKsDbgT/+iN09ew3mCPs3q5nZPUOA0Wkyb3AsTPi+RrILtxOzhWhDqYzbcWHOl5a1hx8fq1VDQl26cI7Kg3f1zonyRRBpa2kjCjNeUfnltlpHcM6GZnrqf2KlaDALQTM898c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335300; c=relaxed/simple;
	bh=SOfUnbLIBTBFvsxrGeijU9qhJL5c9uXXCuQe1isUmD0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SQjszFvnSKj3e9ywjSWdLy0PrZGHoqK9EpKBpTRkqGWnARe4eJ9j7auyhLMGKpOyrpJpDveLQuOIrKFLnrp86c0GVRAbfuouMGXaAm5W2m/28skro2D/fjZVxyHnUVFiUPQOfUy0uQkOVLpYjIKQC4BIP95fTIx9njVyH/OVJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=phEcBlsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3209C4AF09;
	Tue, 30 Jul 2024 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335300;
	bh=SOfUnbLIBTBFvsxrGeijU9qhJL5c9uXXCuQe1isUmD0=;
	h=Subject:To:Cc:From:Date:From;
	b=phEcBlsavpCVAzHMHEi9Qd/+fU6Tvbt3k4lz4VRnsqtgz57qZQ2uIB050Rg8FaJ2s
	 Ii00g2AfXmCH8QmSKQ1OjfhQVSxDvFxxnsZaVJ4ViS/wH+op3QgGfHt7f4CzZ2UuxF
	 iGURHELQ/eo0lQ/U5oRV7PaAhkni4VDoS8QkEMp0=
Subject: FAILED: patch "[PATCH] MIPS: dts: loongson: Fix ls2k1000-rtc interrupt" failed to apply to 6.6-stable tree
To: jiaxun.yang@flygoat.com,tsbogend@alpha.franken.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:28:01 +0200
Message-ID: <2024073000-yelp-remnant-0e02@gregkh>
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
git cherry-pick -x f70fd92df7529e7283e02a6c3a2510075f13ba30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073000-yelp-remnant-0e02@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f70fd92df752 ("MIPS: dts: loongson: Fix ls2k1000-rtc interrupt")
dbb69b9d6234 ("MIPS: dts: loongson: Fix liointc IRQ polarity")
d89a415ff8d5 ("MIPS: Loongson64: DTS: Fix PCIe port nodes for ls7a")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f70fd92df7529e7283e02a6c3a2510075f13ba30 Mon Sep 17 00:00:00 2001
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 14 Jun 2024 16:40:11 +0100
Subject: [PATCH] MIPS: dts: loongson: Fix ls2k1000-rtc interrupt

The correct interrupt line for RTC is line 8 on liointc1.

Fixes: e47084e116fc ("MIPS: Loongson64: DTS: Add RTC support to Loongson-2K1000")
Cc: stable@vger.kernel.org
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index 3f5255584c30..c3a57a0befa7 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -92,8 +92,8 @@ liointc1: interrupt-controller@1fe11440 {
 		rtc0: rtc@1fe07800 {
 			compatible = "loongson,ls2k1000-rtc";
 			reg = <0 0x1fe07800 0 0x78>;
-			interrupt-parent = <&liointc0>;
-			interrupts = <60 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&liointc1>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		uart0: serial@1fe00000 {


