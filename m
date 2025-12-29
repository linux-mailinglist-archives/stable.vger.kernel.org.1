Return-Path: <stable+bounces-203669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC9CE7463
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03AD0300CCC8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F232BF48;
	Mon, 29 Dec 2025 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DpEzgScj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC8332BF20
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023906; cv=none; b=JTFeklByhOMjcTQ+sccAjdRmnMspxwjZcElCzjgBUXsRZFZrkGEp+UNbPnXxvYkV0r9sLbA+7xInz2T5S039xmEK98kgnqrQbqbO8eBG1JxVuhDj9iA4L5l0i0sb5Ax8KjmifMHxjvEm44/Tcf4qjuXHvvJtInofPsdND1pM/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023906; c=relaxed/simple;
	bh=Q3ei4sodW9INe/jc8Ol0Tcwt1L2cndtGkA1xwJlB0E8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GvozN9GylpjCmdl8fxbqrNyzD8HGxmvltSTvnU+R8GpDyzQ/nVLVBH2ISYb3lv2/5udPJlfjX+r/Q46d345B/4IGT5Wbj5P7Zp0O13+VlCnV9kB2exx169Z8DXfcle/+B05QiW+Sqow4KdLTl+r+R0BKbr967NRi3r1YCLcHwZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DpEzgScj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E00C4CEF7;
	Mon, 29 Dec 2025 15:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023906;
	bh=Q3ei4sodW9INe/jc8Ol0Tcwt1L2cndtGkA1xwJlB0E8=;
	h=Subject:To:Cc:From:Date:From;
	b=DpEzgScjvsyn1vSAjWiPHVVyJ1htV3x0d5QFOdVPEqBIIigJb1wzLDvbVGWRsq/YT
	 1nUUPJVjuK3P4aqTrMjTWn2DUWiahhb6AWTzVUPpkuQx9Zew1s3912Cb7C8G3EJln9
	 kt5rNIGQMCJCivZCnF+uQlcIIk2u7erVYAm2aZfw=
Subject: FAILED: patch "[PATCH] ARM: dts: microchip: sama5d2: fix spi flexcom fifo size to 32" failed to apply to 5.15-stable tree
To: nicolas.ferre@microchip.com,claudiu.beznea@tuxon.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:58:20 +0100
Message-ID: <2025122920-atop-frisk-5877@gregkh>
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
git cherry-pick -x 7d5864dc5d5ea6a35983dd05295fb17f2f2f44ce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122920-atop-frisk-5877@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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
 


