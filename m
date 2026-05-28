Return-Path: <stable+bounces-255570-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SqX5Cy+kGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255570-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F875F8828
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8594331A6B7A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F173FA5E1;
	Thu, 28 May 2026 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VJLM5lHh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD7D33CE8A;
	Thu, 28 May 2026 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999283; cv=none; b=r9wbkqpLTyc5sVeZ3Mawa5qZ13o9TRB/Uf9L5qoj2gfKfNZ54nLEbgDhYj+NcXwLj2GwdhAvhAV2qfYpe+kSwDCNpabGPcLQ4WXPeArso6vPPESSRB+I8bjp408igw8frGktf+L449bRM8TXUiTa7cfknTmWt7D+JZMFPEw5vaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999283; c=relaxed/simple;
	bh=YliCkXe5CeRDARX1GoQ8kiES3czC7irAT9/x5Q7uod0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyBG2zkp0ELU5SpLq4GrDvy6SBLNYbjvI7uoGjPo+Vi8sUoQrgDfMkv3WmayZPUWlcsG2j6qcUh6EeO8Qd8M1+xMMZNL8gCz8tEulydR6Co3NlB/8pLw0svEc1zGoNHywzQ3StOjwR37YmFOYfKVVP8wOSLQtM/WarCJd9dPUXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VJLM5lHh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575FB1F000E9;
	Thu, 28 May 2026 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999282;
	bh=EVZWh50usgx4zYpvbskga7BKBC5F/VVGZOFcOnv6nZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VJLM5lHhtGBNSFAQcHtfdpNA0fQIZ9kPpMTtfmc0ooK9Bfe9R30m5bMkFFMhkoGFd
	 LE3tlkfqwpiWbFZe/aCXXYNrgplCuvk9Z5w/p2U3aDBidipDCl3I6c52ZW8qmztaS/
	 +ShtJd14DjarnBmt0tv48t7PrDGn44N2raMX3QfY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanimir Varbanov <svarbanov@suse.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.18 012/377] dt-bindings: soc: bcm: Add bcm2712 compatible
Date: Thu, 28 May 2026 21:44:10 +0200
Message-ID: <20260528194638.743206747@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255570-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,broadcom.com:email,linaro.org:email,suse.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email]
X-Rspamd-Queue-Id: 63F875F8828
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanimir Varbanov <svarbanov@suse.de>

commit 34194cb385033656d347ebe45c241e4739a58125 upstream.

Add bcm2712-pm compatible and update the bindings to satisfy it's
requirements. The PM hardware block inside bcm2712 lacks the "asb"
and "rpivid_asb" register ranges and also does not have clocks, update
the bindings accordingly.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml |   38 ++++++++--
 1 file changed, 32 insertions(+), 6 deletions(-)

--- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
+++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
@@ -13,23 +13,21 @@ description: |
 maintainers:
   - Nicolas Saenz Julienne <nsaenz@kernel.org>
 
-allOf:
-  - $ref: /schemas/watchdog/watchdog.yaml#
-
 properties:
   compatible:
     items:
       - enum:
           - brcm,bcm2835-pm
           - brcm,bcm2711-pm
+          - brcm,bcm2712-pm
       - const: brcm,bcm2835-pm-wdt
 
   reg:
-    minItems: 2
+    minItems: 1
     maxItems: 3
 
   reg-names:
-    minItems: 2
+    minItems: 1
     items:
       - const: pm
       - const: asb
@@ -62,7 +60,35 @@ required:
   - reg
   - "#power-domain-cells"
   - "#reset-cells"
-  - clocks
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - brcm,bcm2835-pm
+              - brcm,bcm2711-pm
+    then:
+      required:
+        - clocks
+
+      properties:
+        reg:
+          minItems: 2
+
+        reg-names:
+          minItems: 2
+
+    else:
+      properties:
+        reg:
+          maxItems: 1
+
+        reg-names:
+          maxItems: 1
 
 additionalProperties: false
 



