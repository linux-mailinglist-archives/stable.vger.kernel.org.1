Return-Path: <stable+bounces-203668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE9CE746C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FF883019B6C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D453128BC;
	Mon, 29 Dec 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l1RpkEBf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C758023F27B
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023902; cv=none; b=EydHd9ok4mUIyN5RnssYDPtzhGUfrbd8IGSL774Ug3zpGBZSTByn3NJCx451/fCAmTGfSREUCZy1qJ0k+SIpbG1n8oJi+NcQq/pgsUYzxAUQam8G6Oi1VMAJhgiLHcVOynoDlholqgewrlYpX8IjUtBNYxwHyf5kmQ4BbfJEx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023902; c=relaxed/simple;
	bh=50xc7E8Hf/mGHZjJu50QHUmWdLdAGMd38jjsC9A+wxs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bU4in98pa5k0on/k3SrQEgwS3dLvvmgPfaxOyyeuw1s6e+P/QBfGKKFFC514qlwZXwml4dMDTgyf7eF1bGsJuco0VaopZYKdoP2O+t8KE/gVQfRifqCkJmXBonHuvhrw3NWM2+5Tnv7P9GKDFnS+VgPpDaKyZSQGC2ePonpGzIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l1RpkEBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDB9C4CEF7;
	Mon, 29 Dec 2025 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023902;
	bh=50xc7E8Hf/mGHZjJu50QHUmWdLdAGMd38jjsC9A+wxs=;
	h=Subject:To:Cc:From:Date:From;
	b=l1RpkEBfZGMtl9CitvI2+4ILjTcpr8pYLdV+g+VxpYGO97o22KgaDrKMXel29EETY
	 sUv9dJtEUbetYwTOYGB22e551NnOGfouh1u4iebFCtfS/UEwswj5BkYY58PDIBixtc
	 mqOuqBvV0lW6JCioQfdRYmru0M+jCfCFUswWJ5J8=
Subject: FAILED: patch "[PATCH] ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32" failed to apply to 6.1-stable tree
To: nicolas.ferre@microchip.com,claudiu.beznea@tuxon.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:58:20 +0100
Message-ID: <2025122920-probably-crystal-786e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7d5864dc5d5ea6a35983dd05295fb17f2f2f44ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122920-probably-crystal-786e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d5864dc5d5ea6a35983dd05295fb17f2f2f44ce Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Fri, 14 Nov 2025 15:02:25 +0100
Subject: [PATCH] ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32

Unlike standalone spi peripherals, on sama5d2, the flexcom spi have fifo
size of 32 data. Fix flexcom/spi nodes where this property is wrong.

Fixes: 6b9a3584c7ed ("ARM: dts: at91: sama5d2: Add missing flexcom definitions")
Cc: stable@vger.kernel.org # 5.8+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20251114140225.30372-1-nicolas.ferre@microchip.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

diff --git a/arch/arm/boot/dts/microchip/sama5d2.dtsi b/arch/arm/boot/dts/microchip/sama5d2.dtsi
index 17430d7f2055..fde890f18d20 100644
--- a/arch/arm/boot/dts/microchip/sama5d2.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d2.dtsi
@@ -571,7 +571,7 @@ AT91_XDMAC_DT_PERID(11))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(12))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -642,7 +642,7 @@ AT91_XDMAC_DT_PERID(13))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(14))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -854,7 +854,7 @@ AT91_XDMAC_DT_PERID(15))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(16))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -925,7 +925,7 @@ AT91_XDMAC_DT_PERID(17))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(18))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 
@@ -997,7 +997,7 @@ AT91_XDMAC_DT_PERID(19))>,
 						 AT91_XDMAC_DT_PER_IF(1) |
 						 AT91_XDMAC_DT_PERID(20))>;
 					dma-names = "tx", "rx";
-					atmel,fifo-size = <16>;
+					atmel,fifo-size = <32>;
 					status = "disabled";
 				};
 


