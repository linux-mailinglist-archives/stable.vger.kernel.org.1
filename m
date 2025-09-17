Return-Path: <stable+bounces-179831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DADB7C892
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5503A48328B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 11:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FB737426F;
	Wed, 17 Sep 2025 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/JSOo1f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DD7371EAF
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110160; cv=none; b=JPGUHQ6XKHJlhBUmM0oG69h7n9SB/rKBg5H87AEWK++emqxpzpwSkp0p8RkpRg4FfDA9WvuMCdL3ypWWR+PxM1RbQtldiQyrBGUy9r2Pcr9vzT9LFwOilfaJ0KS2dRDNMOrW4MZLoYVPeMmxU51Xnw9yAO1cwofIak/ftfeqW5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110160; c=relaxed/simple;
	bh=BuiJZY9t/av0THi/vREJ1zGYOtXvHmNENR5eKUxXMXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrFwXCAaADdxn4OP0mT3opQX0XzUU8d/ik7vb8yQnd9aXN3dAo7NFCz3qcpHG3NdzjWXSSY1JH8VkZnBU8rcAL9sefqq0E5kRaEnMTyJenXfF8qNNUFRjU8jjTVdYAYJSoi32ztCaIBg4dE86wQERNQ3sIPH8l83MGc11qTtd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/JSOo1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DF6C19422;
	Wed, 17 Sep 2025 11:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758110159;
	bh=BuiJZY9t/av0THi/vREJ1zGYOtXvHmNENR5eKUxXMXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i/JSOo1fMkYmM8LJl3E7SpbuHMlmGnUy7FT2HNEY0LZlnnQ1RfyoaCrjM0EpOjnDy
	 L+jnO+NKgjyPmYc/PwE/wZEd20rjciQj8EAcr6WS5PyrH7PJQbe1t4+jTNdHZefsa2
	 QkKmy6uyv5pHhrodzwSuePfDSkrh1yhMfpdGdJ/SML8c1daDGovAtuGD5AVtb+OuSD
	 JIah/SXjXQoCHZE0GAyMAwfmXqIAV3RQ6yGaykF5YeuMtkxdG21keQHXoUNm3W3C6Y
	 oUqivS8LccxyKuaqYQflLmwFQ2/ETQTOGUtrvsKnZOm43P5J5zpb0QFVbr0kQ18Bqo
	 qwO4eA1BAHMvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Elder <elder@riscstar.com>,
	stable <stable@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] dt-bindings: serial: 8250: allow "main" and "uart" as clock names
Date: Wed, 17 Sep 2025 07:55:54 -0400
Message-ID: <20250917115554.481057-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917115554.481057-1-sashal@kernel.org>
References: <2025091753-raider-wake-9e9d@gregkh>
 <20250917115554.481057-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Elder <elder@riscstar.com>

[ Upstream commit a1b51534b532dd4f0499907865553ee9251bebc3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 2766bb6ff2d1b..c1c8bd8e8dde6 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -60,7 +60,12 @@ allOf:
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
@@ -162,6 +167,9 @@ properties:
     minItems: 1
     maxItems: 2
     oneOf:
+      - enum:
+          - main
+          - uart
       - items:
           - const: core
           - const: bus
-- 
2.51.0


