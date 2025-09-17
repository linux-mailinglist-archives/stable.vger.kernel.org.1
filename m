Return-Path: <stable+bounces-179834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54068B7C54F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A51461590
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 11:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE097371E9A;
	Wed, 17 Sep 2025 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th88gu7U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1AF371E82
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110273; cv=none; b=dLG+D7levpJWZdZA2QvPobf3BycRuHgeX00UmPjeQFEJhNRTHewD1g8b2jnZooPHKqmAQ+FDtPnlUMZ4wGKm0pJwnPJaebUTcW48S4qJhlR9h6F6OpE94V/gJPi6r7ZkMIv3RTkKO60k5rgCNfMM8hmOvqYpUqByNoYRlRtV1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110273; c=relaxed/simple;
	bh=tLhhj2lLyQQgreVxKhewCkhknQgvHFQyySY/yKocu0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBuHtZCJxJoJyGFo8bF+lXAHSQ+ssIJFp2klWL5w38SBbzqVAdDzjyTwX38R5r7vKBfJWauZc/tEtLmMKizVtZV5Wfiycx0a/2qOw/MP8Gb4w/td6TTXO5KqkLTuv3mYKfs6TC9vYHnj4TKyswH35D3Ww/AtDQXmLMkgMMcN+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th88gu7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A98C4CEFB;
	Wed, 17 Sep 2025 11:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758110271;
	bh=tLhhj2lLyQQgreVxKhewCkhknQgvHFQyySY/yKocu0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Th88gu7UWbudmc44/pRXLxZTgf1w2AKt0hya6fmKlNzOIF9n+FXw1z2qBd7zSNYqI
	 aWfqMqHJhSQbh3LwU+W00Tl9tCg0Za+c2ecb+UIaJhk9FW8wuT+gQgEfy7d527zQ89
	 NGhWrcJO7TSJemSElHydu7TkWGGQdRmv7b/DPP8vnES5hxCYVDd3E+Z9QHHeR+ukoW
	 +ibvXbCEmeujNTEetjexmDX/ARIzTV8mdp30riqi5Gby8UI8Z/E0nfpP2SBxOHmAc9
	 GbBdeQf0NOKe+r83EVTT7UExGSaiQCVs12bHSX1J8Fq1w7BjBWrmdav7KxLlgJKEAT
	 aIAH+XQy8IKXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Elder <elder@riscstar.com>,
	stable <stable@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 3/3] dt-bindings: serial: 8250: move a constraint
Date: Wed, 17 Sep 2025 07:57:46 -0400
Message-ID: <20250917115746.482046-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917115746.482046-1-sashal@kernel.org>
References: <2025091759-buddy-verdict-96be@gregkh>
 <20250917115746.482046-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Elder <elder@riscstar.com>

[ Upstream commit 387d00028cccee7575f6416953bef62f849d83e3 ]

A block that required a "spacemit,k1-uart" compatible node to
specify two clocks was placed in the wrong spot in the binding.
Conor Dooley pointed out it belongs earlier in the file, as part
of the initial "allOf".

Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
Cc: stable <stable@kernel.org>
Reported-by: Conor Dooley <conor@kernel.org>
Closes: https://lore.kernel.org/lkml/20250729-reshuffle-contented-e6def76b540b@spud/
Signed-off-by: Alex Elder <elder@riscstar.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20250813032151.2330616-1-elder@riscstar.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/serial/8250.yaml      | 46 +++++++++----------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf0..f59c0b37e8ebb 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -48,7 +48,6 @@ allOf:
       oneOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
-
   - if:
       properties:
         compatible:
@@ -66,6 +65,28 @@ allOf:
           items:
             - const: core
             - const: bus
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - spacemit,k1-uart
+              - nxp,lpc1850-uart
+    then:
+      required:
+        - clocks
+        - clock-names
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
 
 properties:
   compatible:
@@ -264,29 +285,6 @@ required:
   - reg
   - interrupts
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - spacemit,k1-uart
-          - nxp,lpc1850-uart
-then:
-  required:
-    - clocks
-    - clock-names
-  properties:
-    clocks:
-      minItems: 2
-    clock-names:
-      minItems: 2
-else:
-  properties:
-    clocks:
-      maxItems: 1
-    clock-names:
-      maxItems: 1
-
 unevaluatedProperties: false
 
 examples:
-- 
2.51.0


