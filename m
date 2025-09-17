Return-Path: <stable+bounces-179773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B13B7D47F
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E7C1657A9
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 07:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5303233721;
	Wed, 17 Sep 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yZ3gOzYo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE41226CF7
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758093904; cv=none; b=UywVP7QZg+nKV9pQSzQ4q3OROANTM83mE5QOuWQdPIfyL8nYfGP02TNalNLKZ7Ha0YRAbJ9XD0kAQ2/65Ig570DblNtWptW5qPis/bpxOLOG8eO4G8XKP3Lps/ics1Zd6DC96W5lAwLOtzFfMtbbbE7J06p3cWT1x7y+q9oL8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758093904; c=relaxed/simple;
	bh=/M2oF+iVxNC0+OmxyvJPnmr0l6yG29erPuRAvEgQ9M4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RJ4Ka75whpqE+bU+QW6QniB+xjPsO8Os6E36hstxFWeuSlctD8ojs6hawKHMjJLnWVrzgP0h39mhUCSkOcwKe43iyFAMs9xo6jwKRdPYlMekjNPkUeX/ce1yjiXan9WJ4avBTZIeyJrt8qQUfzgqQXdEk6LASVF5IS5X/t2kLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yZ3gOzYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FDCC4CEF0;
	Wed, 17 Sep 2025 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758093903;
	bh=/M2oF+iVxNC0+OmxyvJPnmr0l6yG29erPuRAvEgQ9M4=;
	h=Subject:To:Cc:From:Date:From;
	b=yZ3gOzYoQU8Mm04Zp4Jt2CLibskm+enogpjY8b9mv04uabk1EtK0LW8rgxDRExlFi
	 NFFLndZHMT+mrRxdS4WfUIZcJ48jDfwwqx8JGPBk2JZlYYPf1zNvO7ggWyH/5hvPkA
	 1rlDWMybTleAdmCA77011CKj+V+K2S/kfF1v8RmQ=
Subject: FAILED: patch "[PATCH] dt-bindings: serial: 8250: move a constraint" failed to apply to 6.16-stable tree
To: elder@riscstar.com,conor.dooley@microchip.com,conor@kernel.org,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 Sep 2025 09:24:59 +0200
Message-ID: <2025091759-buddy-verdict-96be@gregkh>
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
git cherry-pick -x 387d00028cccee7575f6416953bef62f849d83e3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025091759-buddy-verdict-96be@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 387d00028cccee7575f6416953bef62f849d83e3 Mon Sep 17 00:00:00 2001
From: Alex Elder <elder@riscstar.com>
Date: Tue, 12 Aug 2025 22:21:50 -0500
Subject: [PATCH] dt-bindings: serial: 8250: move a constraint

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

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf..f59c0b37e8eb 100644
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


