Return-Path: <stable+bounces-203666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E3CCE7466
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C9130169A2
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415223128BC;
	Mon, 29 Dec 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AoZTrs+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD5264627
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023894; cv=none; b=QX2Q5IvnRhTriUkqjPYtM5uZvo4R+a43j4rHcuss3/murlN5RCyqal9PaRCDGxddHozcZM3k/SxQTV6KFFS3v6wwl964gScrX7DD0BZCrsH3XapJNx+CWLLrrGeZv+lTk5OueflR22sms3DU8M+7HkvBE5RmutDmn9TyrvTjutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023894; c=relaxed/simple;
	bh=jz+Tg6281t9Y1t2zAY+LbQjhy8Kwx2GdSzc9Ie0prTs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GIr2s4YULyjIeSph+tUYoUlH/rHIucFb8BRRrmu1kFDkDe2mb+rR95mI+DRYPW2/weHL0pyUu59dsMDs8s+VgS8QQrN8IOoEbgfZhziW4wLlNvVBdz1YKGQlBQm3BnhBK49Qxsx7hKRE0lnuwmqGdV4yrh5oiss0wQwpxgtoZ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AoZTrs+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341DCC4CEF7;
	Mon, 29 Dec 2025 15:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023893;
	bh=jz+Tg6281t9Y1t2zAY+LbQjhy8Kwx2GdSzc9Ie0prTs=;
	h=Subject:To:Cc:From:Date:From;
	b=AoZTrs+TrULoMhgebiy778UShhHYhgsV46Zt+weQHdp07p8TSmDrtMkIdpaViIMt9
	 1VSPi/0lhLo1LaPEpmZ1vv9IR00VqDPqRyou2JgRnHS3ARhvoeVAKMsoZww9peF4SS
	 LhmV4DxakpppXK9WzhhjmGJPxu4t4lBbS5o51noA=
Subject: FAILED: patch "[PATCH] ARM: dts: microchip: sama7g5: fix uart fifo size to 32" failed to apply to 5.15-stable tree
To: nicolas.ferre@microchip.com,claudiu.beznea@tuxon.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:58:00 +0100
Message-ID: <2025122900-ripple-expert-4378@gregkh>
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
git cherry-pick -x 5654889a94b0de5ad6ceae3793e7f5e0b61b50b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122900-ripple-expert-4378@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5654889a94b0de5ad6ceae3793e7f5e0b61b50b6 Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Fri, 14 Nov 2025 11:33:13 +0100
Subject: [PATCH] ARM: dts: microchip: sama7g5: fix uart fifo size to 32

On some flexcom nodes related to uart, the fifo sizes were wrong: fix
them to 32 data.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20251114103313.20220-2-nicolas.ferre@microchip.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 381cbcfcb34a..03ef3d9aaeec 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -824,7 +824,7 @@ uart4: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
@@ -850,7 +850,7 @@ uart7: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};


