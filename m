Return-Path: <stable+bounces-62759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C102E940F72
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30E91C2299F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 10:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B857B19FA9C;
	Tue, 30 Jul 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oh+eCGDA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F6E19FA99
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335293; cv=none; b=KBRp+TbsOBy4Uge57B0l0zEAhAP0ct7c8NAfIg4410boTwbORFrHsiSpANPyhw6MBzskp83imhWad1YqibvDCrFsC+gortj7ZUy+wxj7Wsdx9W0b2REM0GHT46n8esOmnHEBPxke44KnzYZCAOuHkmBJWOz5n5eoYRgLa/B+wAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335293; c=relaxed/simple;
	bh=oGTMDBynJP74umwV8Bm04QHm6yEHdpG+UEo5zqCVLgE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cjH/rxXUcSlyFg5Ml02hAjY1ZjpknIHkXuIO2K33Z+K2Enq3B3O15IBW2g8rJCSLAAuc/4LIxKmViZXpdiqckiqBnahYyS91V3h2W67he1hK8iC3VF1XiRxj08ZXe7qbayTYpiVFa6lFDLux7/wdmbZu64JgV+BdxogVBwaS8Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oh+eCGDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E191FC32782;
	Tue, 30 Jul 2024 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722335293;
	bh=oGTMDBynJP74umwV8Bm04QHm6yEHdpG+UEo5zqCVLgE=;
	h=Subject:To:Cc:From:Date:From;
	b=Oh+eCGDAzkJBbKoTdEcPewRgJN6EGEOR4wRetoS8SEGhw181G0z3ATQxUQNePgjsY
	 zQGiNYZIZOkSDwzPFjZwGxfeb7i1QMY5YH5uSION+7tYSIzFeNSFKeWfV9pdyjiRt3
	 yBgXiYZVZjdFhleKefMoNpilMxBSCf5tczpLeIYM=
Subject: FAILED: patch "[PATCH] MIPS: dts: loongson: Fix ls2k1000-rtc interrupt" failed to apply to 6.10-stable tree
To: jiaxun.yang@flygoat.com,tsbogend@alpha.franken.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 12:28:00 +0200
Message-ID: <2024073000-directory-swimmable-5878@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x f70fd92df7529e7283e02a6c3a2510075f13ba30
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073000-directory-swimmable-5878@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

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


