Return-Path: <stable+bounces-67764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB179952D87
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F33A2829CB
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 11:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431F51714AF;
	Thu, 15 Aug 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="L4TRYGFU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Owek4JWF"
X-Original-To: stable@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687E21AC88A;
	Thu, 15 Aug 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723721512; cv=none; b=INOPIVr6dsRYTGbpkB0yUhu2JL3DMgWDXFSY0afm91tLGfjx9Ev1sSKdmX1shFApSA+8LZprtsRYgOnOnHuszll0yIYw6+wXbM9gWujvjMdHRFZfTrjY2IkA29BYV4PQbOXkqzRay6h8K8q1br/opzunGyqF2qlNRgjCydDMIU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723721512; c=relaxed/simple;
	bh=uOEvmvvUbvKcClHIfC2V4ruUmucz8oRd24FDQKXeHrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V5SmAWuYqWqLmgIVliJRPm/k95g6I/Vxtv3pkdMOoayLzEPbP1rsOFscP6i23uddB8hVJWa2Snv5CTLOYMefG9YAUrRwrPAFkv25dxh8qgvaVcVpe2BbhaXZF3ABlc8JOzqHLx69W6bigocmFmKuXYa+0rd5lTiME03aQWrdKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=L4TRYGFU; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Owek4JWF reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723721508; x=1755257508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ipxO4CjLCNJ0T17K5ElKb2AAs0WxMTRpNsXk8lsFmRo=;
  b=L4TRYGFUAh/MtaIoFClVPC57yOt78Tutcz8LXvcfW46FJyHmbcTsQ7kM
   +5yHnZzNHP0vFubmOQ8vsWcWFWq0rprzTX+zjZQ+Gczv5dHlO9hlYic3v
   /kfJq/hpklqzsGPjlxpEOOoWoUd7g8//PJoTEOvu3aW0RTNhgp520oDvE
   FMZrfs6+kJZYsUjL9nUuzdB+Li3GRmlnK3OM2hHPsJW/da9v4RXJ4fcKK
   ORDLnyTGCIe7iS+6hz5zBEO9FTtWb/51p8524G2rqYlOpYLD+nDKUnFUM
   7Zh+fZQgZH6m9MSga/1OcjmgEjyVGMsAJ2AKsi0FCgb+ASHaP0wqLLBeR
   w==;
X-CSE-ConnectionGUID: 3M0w8/i5SMaYbleX3oto2A==
X-CSE-MsgGUID: DWT8JmWgQGCQD8/f7Il2fg==
X-IronPort-AV: E=Sophos;i="6.10,148,1719871200"; 
   d="scan'208";a="38423597"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Aug 2024 13:31:39 +0200
X-CheckPoint: {66BDE71B-5-751552D8-F91D2344}
X-MAIL-CPID: 5C950045BAB5983D9B9414A56A745C26_4
X-Control-Analysis: str=0001.0A782F19.66BDE71B.00A7,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6E7AE160A50;
	Thu, 15 Aug 2024 13:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723721495; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ipxO4CjLCNJ0T17K5ElKb2AAs0WxMTRpNsXk8lsFmRo=;
	b=Owek4JWFkDG+oFWcBGXkKxn13h27rAOOcNAFK5p9I13RlZtgYCIyITM2iYIfmEvfI3tFMn
	yuO6KxmaoHd0SSxXo+r1vyTpbPd8+gQEmr6R0kkowwNVSzSuwrb7WVdcaR0VAvvvgIGP3T
	+9XQsPgnIcWcONdE/8Fbw/7ccX5lDnefufZWLmvyY7wCNOYpe56ebtM22PqXSs/f3DakuF
	+8cUun3aQqL0rqiYDkfmMSSdSw/8fEW1X3Y6eFBUxAofxfo84FFY5UWXeHnEKrVKmU1hsS
	BNVwNa3OetbH6aCSYqTgWmgPDwz2GbyIvIsxtjjletTX1yOFgdZtxMkD14u9jw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] dt-bindings: usb: microchip,usb2514: Fix reference USB device schema
Date: Thu, 15 Aug 2024 13:31:31 +0200
Message-Id: <20240815113132.372542-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

An USB hub is not a HCD, but an USB device. Fix the referenced schema
accordingly.

Fixes: bfbf2e4b77e2 ("dt-bindings: usb: Document the Microchip USB2514 hub")
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
As this USB hub also can contain an USB (ethernet) sub device, I copied
the subdevice part from usb-hcd.yaml.

I had to add 'additionalProperties: true' as well, because I got that warning
upon dt_binding_check otherwise:
> Documentation/devicetree/bindings/usb/microchip,usb2514.yaml: 
>   ^.*@[0-9a-f]{1,2}$: Missing additionalProperties/unevaluatedProperties constraint

I added a Fixes tag to keep this schema aligned in v6.10 stable tree.

Changes in v2:
* Do not update the example
* Adjust comit message accordingly
* Add Cc for stable
* Collected Krzysztof's R-b
* Shorten the SHA1 of the Fixes tag

 .../devicetree/bindings/usb/microchip,usb2514.yaml       | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
index 245e8c3ce6699..b14e6f37b2987 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Fabio Estevam <festevam@gmail.com>
 
 allOf:
-  - $ref: usb-hcd.yaml#
+  - $ref: usb-device.yaml#
 
 properties:
   compatible:
@@ -36,6 +36,13 @@ required:
   - compatible
   - reg
 
+patternProperties:
+  "^.*@[0-9a-f]{1,2}$":
+    description: The hard wired USB devices
+    type: object
+    $ref: /schemas/usb/usb-device.yaml
+    additionalProperties: true
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


