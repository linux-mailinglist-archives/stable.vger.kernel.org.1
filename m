Return-Path: <stable+bounces-165587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D555B165CF
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF97018C34C6
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D412E03FF;
	Wed, 30 Jul 2025 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jyl9vUZJ"
X-Original-To: stable@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D92DECBF;
	Wed, 30 Jul 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897818; cv=none; b=oJd2ZDcvv0SwplSTOt8EBwb2ptRfMNgWFAj0r8Sj8JWZ0niOwYGt8SHh8QHmyyOP9Mb84Pzlhs5/d9OQsLQ67A6UrT+d657tdYd3Vmf4EZT9kjk4tT20lF2og3IEaTxw7sMINx5drlcWHMjRfruQEZkUIVEPkcEiJpblBpXvt68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897818; c=relaxed/simple;
	bh=u/DBPrrXi1YUBX587wY3HEnl0jSOb8wEheVaHESnVqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QK3kVApRqrqUg7nfm0uvFoNeI5cvLcZR0nQsOfJVfogqyUIKkhvirM0qO2NOILWH+2lNSqXdaIqpiyt5FurN+uPubJ+CC4eEFrm27KvGUTgcL3BSWkL6I4q8Vg6ivvMwzhXfEiM6OQbeFXkHFGd10CK+U5YfG3qD6d1k+Kteav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jyl9vUZJ; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [IPv6:2001:4b98:dc4:8::235])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 9C00C583E49;
	Wed, 30 Jul 2025 17:03:00 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6D617442A9;
	Wed, 30 Jul 2025 17:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753894973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kp/er0tAcwSGh4h0rLep0cfDaCG3r32BhF8cj5ZTgVk=;
	b=Jyl9vUZJ4ufUq1ms4UZ/7fOnDkbDMxSZhF3bF8bgP0IY+3gWu5ROhf7v96XzIsQxFlePLO
	uRLVQ0YctxEXbu8CMbFOm8VhEDWrHGNRcZ+4yQQ4tosRmF/yPKYvyNZ9vABFwPCY43lgAm
	nk2zLRmMOVq7WvXWpJAJu8Eygu3/Ua6tYjeMYiKAcXB4SM1KYoVbEWg02EK/w+XQSJGHPh
	VirFa0cl1GYVP/Kgx3zUsvWlN7d/9aaa9xLUy+1tblitRXTAiqQRPbGkccRpTjINMbg3+3
	/yreuk97z2R5Cgu5hsAQxlFN305sUYhVXdQWtVbkHe9+THgfbfoZ/K3RqKmBQg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 30 Jul 2025 19:02:44 +0200
Subject: [PATCH 1/4] dt-bindings: display: ti,am65x-dss: Add clk property
 for data edge synchronization
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-fix-edge-handling-v1-1-1bdfb3fe7922@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1754;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=u/DBPrrXi1YUBX587wY3HEnl0jSOb8wEheVaHESnVqk=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBoilA2suPh4nRhBtWG5qKVTjCFsDGyeZE4Bq4Gd
 u0vOdgXHPSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaIpQNgAKCRAgrS7GWxAs
 4jDTEACExFMJe49yi3EY4yiiTXZOHCHmbi/MWe3IyQN+ciki2IfkgmVMuTsTy7rpQbH17Bif9wc
 vwhmqQUd9GLY5UuGlP6/ZT4glcRi24XWNt1/ckIagtL549N2+pymVinnz4EsmlhTXPL8u9/NSUO
 wLsqChLJutV+GEsLH7HwK5OxEB3I860UCqzasSTpQQp+61LsEBJurYYTiBR3n5nb+UwBWUvDqij
 COQGqOC4eTxHZZvLFmTiTI4NMNjsYRN0qp7mXrm8fEm6x4GOaxN9MPeZ4vdsmIFHsvJVD3bhwps
 C8Ilf7nLvXPtLNaB461Y8zi2WrSc+G1ckZi78Ru+PywCZ21uoAzZu5PbsTINnGzD1l2IxVdK4LZ
 W9RmeKNAO51b05+4og6UpqiWAVpvWxdf+hjgw/uh7I/6Ca/fGDO3NueIsOMObXZjqns96fQTdw7
 cca7cxsMWhuleKj22UjmpjUBMcU0WieUJBWghZTUPT+z5YZcsxCDW1upoORginI8Dh+8jHwZWwQ
 WHdjP7N7j0ST68qD78xlWlylKT/P/LbslrNfXJvEwC/YsTgIJoPuB5SvMS9mfL/nKXs1LI2uKlL
 lf9tAVcGVwffhm//IWarU1qK7ed/E6lxqM9ZA2kqGbBVE78pGzPIQlXp5oNhYW3cipmqKmNVMLD
 ZBNZ38Dmg1nF64Q==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtjedttdetieeigfeljeekteetvefhudekgeelffejheegieevhfegudffvddvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddtngdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehjhihrihdrshgrrhhhrgesihhkihdrfhhipdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheps
 hhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnmhesthhirdgtohhm

The dt-bindings for the display, specifically ti,am65x-dss, need to
include a clock property for data edge synchronization. The current
implementation does not correctly apply the data edge sampling property.

To address this, synchronization of writes to two different registers is
required: one in the TIDSS IP (which is already described in the tidss
node) and one is in the Memory Mapped Control Register Modules (added by
the previous commit).

As the Memory Mapped Control Register Modules is located in a different
IP, we need to use a phandle to write values in its registers.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

---

Cc: stable@vger.kernel.org
---
 Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 361e9cae6896c1f4d7fa1ec47a6e3a73bca2b102..b9a373b569170332f671416eb7bbc0c83f7b5ea6 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -133,6 +133,12 @@ properties:
       and OLDI_CLK_IO_CTRL registers. This property is needed for OLDI
       interface to work.
 
+  ti,clk-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to syscon device node mapping CFG0_CLK_CTRL registers.
+      This property is needed for proper data sampling edge.
+
   max-memory-bandwidth:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:

-- 
2.50.1


