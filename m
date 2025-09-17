Return-Path: <stable+bounces-179772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B67B7D497
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0A9164D0E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0125631BC8B;
	Wed, 17 Sep 2025 07:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GffCBaKw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D227F00A
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093897; cv=none; b=eW5sInTb4PAQrISnBuUYPniX8NmcmrzkA9hN8jBVSYWCmt26oZtzHckX3bnaVwHNVD9u1Qqbr614kEd9lz7RVWnwXbeiw+4MYMNPUEH6M4VVS3gLZJ3SkbBpSiSY9AOMK5Yin/0JLKlDCd3ElHoUfcH0rO2J9J9bK9TljTohV1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093897; c=relaxed/simple;
	bh=3izN0Ej/0MoJwNhG69KJ1X915pRAY9UVj2R5GIX5adA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EWrbQmtprnDkp8qu1a9A6pbNWtL6UCOkk7Cry8f3jAo+vGkQIfpohMPOdpI/CWyeGmT/RrcRX0Lrw5MEseo/kAzPHpEaaFOyeSTIs60HHkYhEISaRC1IVIQmnqEXOJMdGG2PICvJGtz+8T6HmVsES7yCvMksL5xCsc/YbwpJ8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GffCBaKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D94DEC4CEF0;
	Wed, 17 Sep 2025 07:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758093897;
	bh=3izN0Ej/0MoJwNhG69KJ1X915pRAY9UVj2R5GIX5adA=;
	h=Subject:To:Cc:From:Date:From;
	b=GffCBaKwQKd8/od4Yfmd6XL3pMnb68UKORfaM3ACyipcWo+/fUPpswpV4RuySaztn
	 x4Do3EpCsTkRC5okfCPijtzUhPakuDX1Rp54H0tH95sxRSDk3n5GC+H49QntfLorKM
	 7mBJqRhde8GRMTZyXI5F9Mmc+n5r3AJUyndMpUYs=
Subject: FAILED: patch "[PATCH] dt-bindings: serial: 8250: allow "main" and "uart" as clock" failed to apply to 6.16-stable tree
To: elder@riscstar.com,conor.dooley@microchip.com,gregkh@linuxfoundation.org,lkp@intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 09:24:53 +0200
Message-ID: <2025091753-raider-wake-9e9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x a1b51534b532dd4f0499907865553ee9251bebc3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091753-raider-wake-9e9d@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a1b51534b532dd4f0499907865553ee9251bebc3 Mon Sep 17 00:00:00 2001
From: Alex Elder <elder@riscstar.com>
Date: Tue, 12 Aug 2025 22:13:35 -0500
Subject: [PATCH] dt-bindings: serial: 8250: allow "main" and "uart" as clock
 names

There are two compatible strings defined in "8250.yaml" that require
two clocks to be specified, along with their names:
  - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
  - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"

When only one clock is used, the name is not required.  However there
are two places that do specify a name:
  - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
    compatible serial device is named "main"
  - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
    serial device is named "uart"

In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock
'uartclk' and 'reg' for nxp,lpc1850-uart"), Frank Li added the
restriction that two named clocks be used for the NXP platform
mentioned above.

Change that logic, so that an additional condition for (only) the
SpacemiT platform similarly restricts the two clocks to have the
names "core" and "bus".

Finally, add "main" and "uart" as allowed names when a single clock is
specified.

Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
Cc: stable <stable@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
Signed-off-by: Alex Elder <elder@riscstar.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250813031338.2328392-1-elder@riscstar.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index f59c0b37e8eb..b243afa69a1a 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -59,7 +59,12 @@ allOf:
           items:
             - const: uartclk
             - const: reg
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k1-uart
+    then:
       properties:
         clock-names:
           items:
@@ -183,6 +188,9 @@ properties:
     minItems: 1
     maxItems: 2
     oneOf:
+      - enum:
+          - main
+          - uart
       - items:
           - const: core
           - const: bus


