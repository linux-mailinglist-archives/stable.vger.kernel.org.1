Return-Path: <stable+bounces-165588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B868FB165D2
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D934C18C4DB9
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF042E03FF;
	Wed, 30 Jul 2025 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QrZJunuz"
X-Original-To: stable@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979142DECBF;
	Wed, 30 Jul 2025 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897826; cv=none; b=kaTQqnB0DIuRUWPakNPMGSbXNsitfAVDsYp6hzswq2gwkzUeFcOgyG39J+cRbVMvaEfGX4iPLhMuIWyLulofY5HqE01UbJQs7wZcsRNuH6wB7bCtlIZ1crmw/TA9B2gRT6ZGvaaXNjzgU5TNq5Js4aqrnJt4PRm3s6nOU5e8PM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897826; c=relaxed/simple;
	bh=+vQmzWOpJ3o7m/vAWofAcDWRydefU96Ll29wNpFlYIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oteqsm0JTL/o/MKpQZ3lMt1Lb1XaRMoCPSRmFC5UGo4thLQUsHz7K9i+GJCjl/SbN0H++aVrymWQOjGOujY6d10514TRbz9+fLP+d/hTxvbvo3WBa4ciD3mGSpt671SEESy87LDH6df4BYdD1eoygeuVdmz7l1U/NpBn3Tu7RmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QrZJunuz; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [IPv6:2001:4b98:dc4:8::235])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 922CD583E6E;
	Wed, 30 Jul 2025 17:03:02 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE0E6442A6;
	Wed, 30 Jul 2025 17:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753894975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+xY4UZr8LvAM8jYcOJRM8hzadDR3NumATbc214IapM=;
	b=QrZJunuzAe9A32IXdLxegg+gs4exspfjaG6mJNmOBcAId+g/COu7BRFQUYml/7aUdlElg/
	5k019XhQbOTZakt5FNPO68V8akrtj04+biWh8SQvGRQOUPgDMvbHD1fZGBeDz45Ixctlsk
	PKwvSnyHqcNG+NyrMVm1mbF9njC7cm5l8roFPbJn8DbfXqYTzQnVn3fcQrGVEc3jgAx4ky
	IT/9gKcgJqkt3+pS6TkO9nGSvJ7Q1GVdhsQLbL5V0C1FC8QqHDFaROVS3yvIFS+eiG2b2O
	0vu2hi2xpPqRJ/GWLNBCQS1sF2qLKQ3rptTpHoRghTgJcYyXvh4I/3CBVu3rUQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 30 Jul 2025 19:02:45 +0200
Subject: [PATCH 2/4] dt-bindings: mfd: syscon: Add ti,am625-dss-clk-ctrl
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-fix-edge-handling-v1-2-1bdfb3fe7922@bootlin.com>
References: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
In-Reply-To: <20250730-fix-edge-handling-v1-0-1bdfb3fe7922@bootlin.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, 
 Benoit Parrot <bparrot@ti.com>, Lee Jones <lee@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>
Cc: thomas.petazzoni@bootlin.com, Jyri Sarha <jsarha@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1779;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=+vQmzWOpJ3o7m/vAWofAcDWRydefU96Ll29wNpFlYIo=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBoilA3M4ea0dmIilicR6aW0qGwK4i4ICkosRsvt
 d60pygWKgmJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaIpQNwAKCRAgrS7GWxAs
 4upxD/9zxSfXLrFH5tI+71ohX67Q17YO5UDoErAp8zVlMW9VQFTihgpw0Ulexzo5d2Hj9OgZl01
 SfQPcsgnY4J6Zm3lL6584731SIlWk3xkH77d3bSotXbkLhlMcOa5GaUJlV4aHOmnGv1Q7aDbw0W
 TARRvPlLlGPRqAqTUJ53I7cUnbq6edBc2CzOD3D6v/NS3NqArH9Um9vVoi+DKZxvQWFt4IHnc2k
 4uSQ2hl05y1oJi8uMlK2slSpysT5lwcdkj5rQ807cRw/AYXDM0Ftr3VbA+JKJj6uid/ngC9m2fY
 2HqinTX07O3pojp4hoKrCWTPRnsGJldzqispnktmQClZpq93W0gbsfa/tLXwuzWcke1vqqdAatv
 DCsU4M1dAEHE4v3Z6Fa9ogDw/n1dxQBAZ+LuqAVVeI9NO88/cZWrPBLTXXqvdcs9B51ImzSiFeC
 AMnGnG8pJeBNiA0NxsDtYS+Lo6YeDMoJbRx5huwzaKtc8100GsB41vZoykPFixIdLgqWHGPukPI
 KGs8NJRfQQdJBfIxym3w5v2AhI5+gnjH6mXF8HPv7DT9dgJIXY/+euv8krKh5XjniHVadMeD0Fe
 MxwqXZ2VW3tU/gEIjYD2Ok3gvpoy+lGr/WbBOIusOZLGQtxluZHSAiL07boSFEil0LqxqNxw5Uv
 HkMjHdbq7Qd0qNQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtjedttdetieeigfeljeekteetvefhudekgeelffejheegieevhfegudffvddvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddtngdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehjhihrihdrshgrrhhhrgesihhkihdrfhhipdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheps
 hhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnmhesthhirdgtohhm

The dt-bindings for the multi-function device (mfd) syscon need to include
ti,am625-dss-clk-ctrl. On AM625 chips, the display controller (tidss) has
external registers to control certain clock properties. These registers
are located in the device configuration registers, so they need to be
declared using syscon. They will later be used with a phandle in the tidss
node.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---

Cc: stable@vger.kernel.org
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 27672adeb1fedb7c81b8ae86c35f4f3b26d5516f..afe4a2a19591e90c850c05ef5888f18bdb64eac9 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -121,6 +121,7 @@ select:
           - ti,am62-opp-efuse-table
           - ti,am62-usb-phy-ctrl
           - ti,am625-dss-oldi-io-ctrl
+          - ti,am625-dss-clk-ctrl
           - ti,am62p-cpsw-mac-efuse
           - ti,am654-dss-oldi-io-ctrl
           - ti,j784s4-acspcie-proxy-ctrl
@@ -228,6 +229,7 @@ properties:
           - ti,am62-opp-efuse-table
           - ti,am62-usb-phy-ctrl
           - ti,am625-dss-oldi-io-ctrl
+          - ti,am625-dss-clk-ctrl
           - ti,am62p-cpsw-mac-efuse
           - ti,am654-dss-oldi-io-ctrl
           - ti,j784s4-acspcie-proxy-ctrl
@@ -256,4 +258,3 @@ examples:
         compatible = "allwinner,sun8i-h3-system-controller", "syscon";
         reg = <0x01c00000 0x1000>;
     };
-...

-- 
2.50.1


