Return-Path: <stable+bounces-169735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B15B282F0
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB3C1897EFE
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5722C0F9F;
	Fri, 15 Aug 2025 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OWA4nS4N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3DF4315F
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271765; cv=none; b=syQ+zLoprCBbWFPunjVJnkPwQm9GjMiKTEFNZvV1078KfndYwHMJjPTSsnY3jeeOJGlA9rOrWbvhofTFpsOMQaknfuk3erokqxsFrl4SanUFCoP6EvfvkQvHSGXAB2wM7RO/TdY+4bJVQ8fKl84+hUEv3P7VWR4LhLrQr6+Dsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271765; c=relaxed/simple;
	bh=8tubh7vv9Sunm5Q37XKJj7HM16M9lWjqUQRDvuUC8cw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZdZzTBA8GsiXt1YKMIQCV4+i+fcGHY9Iqdv0U4mvPK7IM0259SM5YkgZf3xr03jGxV1oSixJpy6QqXITyVMrelh6loCkZ1D5nP5F0rNpqxU5KVMcDrAVaG5Ih/F7DU3o4mt2KLnK5BUzi/61QkFrX0dVIil9pczUB/0nTkS8Peo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OWA4nS4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DF5C4CEF5;
	Fri, 15 Aug 2025 15:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755271764;
	bh=8tubh7vv9Sunm5Q37XKJj7HM16M9lWjqUQRDvuUC8cw=;
	h=Subject:To:Cc:From:Date:From;
	b=OWA4nS4NMy7QqB8+NJm8YZRvhIaI1VdMKDlbXFq7gUnCRhthKy0NU7/ld6rdLcVsz
	 /Hi5wE/Hn6ZdpAvhaRYClnm1v+u/LE5YndUnOjk5l+anttqJf/fUIuG+QmIQcRwtiU
	 9Z93i5OrG34lCFcI4lhoUzFj9oY4Uk6VrKfrja4g=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for" failed to apply to 6.12-stable tree
To: s-vadapalli@ti.com,vigneshr@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 17:29:21 +0200
Message-ID: <2025081521-dangle-drapery-9a9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 65ba2a6e77e9e5c843a591055789050e77b5c65e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081521-dangle-drapery-9a9a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 65ba2a6e77e9e5c843a591055789050e77b5c65e Mon Sep 17 00:00:00 2001
From: Siddharth Vadapalli <s-vadapalli@ti.com>
Date: Mon, 23 Jun 2025 15:36:57 +0530
Subject: [PATCH] arm64: dts: ti: k3-j722s-evm: Fix USB gpio-hog level for
 Type-C

According to the "GPIO Expander Map / Table" section of the J722S EVM
Schematic within the Evaluation Module Design Files package [0], the
GPIO Pin P05 located on the GPIO Expander 1 (I2C0/0x23) has to be pulled
down to select the Type-C interface. Since commit under Fixes claims to
enable the Type-C interface, update the property within "p05-hog" from
"output-high" to "output-low", thereby switching from the Type-A
interface to the Type-C interface.

[0]: https://www.ti.com/lit/zip/sprr495

Cc: stable@vger.kernel.org
Fixes: 485705df5d5f ("arm64: dts: ti: k3-j722s: Enable PCIe and USB support on J722S-EVM")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Link: https://lore.kernel.org/r/20250623100657.4082031-1-s-vadapalli@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index a47852fdca70..d0533723412a 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -634,7 +634,7 @@ p05-hog {
 			/* P05 - USB2.0_MUX_SEL */
 			gpio-hog;
 			gpios = <5 GPIO_ACTIVE_LOW>;
-			output-high;
+			output-low;
 		};
 
 		p01_hog: p01-hog {


