Return-Path: <stable+bounces-165586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D18B165CC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC1518C3487
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912B72E03E4;
	Wed, 30 Jul 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ahu2yZS5"
X-Original-To: stable@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B951E0DE8;
	Wed, 30 Jul 2025 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897791; cv=none; b=X9EdRfm/AI9P4jmB4FiBuAU6yqLNzXBkQ1sdZBffRxyQI0VzCfXBh4TbfK7Ez1xouc6UFJB0ZlVcp1vcPKxdqCgkKagEaNXUKjy/YjIoIno1+7aLxi/YfrqEO2BXwqiPBOqg5I1jCWPE1lphvVaZtoWWa3x2d8jUI5159bp7WF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897791; c=relaxed/simple;
	bh=/p3QCeb5vrjQsgDySv7ceP1YaCttjBmqpB2bCe9hbyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kO7UnCuBmpSgoB4HLC2Xyi9zgDb6tjK5KrXdhM3rDe3Lqb+2Xj+y1SPHe8pIhEj8r3kSsZPRT2/O7XRTpIBcQiKEEdFg6EydXDErD6vBjnIFY4YAjOWoTho3uN34WFfL9I6JG+yeMLuyztx1fH4Fp6o4HxMR6JqSA1hdME996Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ahu2yZS5; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [IPv6:2001:4b98:dc4:8::235])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id F3A7B583E84;
	Wed, 30 Jul 2025 17:03:05 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F0BE442AA;
	Wed, 30 Jul 2025 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753894977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2UE0f0lxM12DzKY8SLP9Ryrfpakau+5gbE2rpdBN1A=;
	b=ahu2yZS5PpM6RqG4gIA/3xnCkg4qml3y3KjQG8RWCeS0mvQ8P3OO48pA1rjRhGSrKzrK7i
	xxkgydLuwN02xdb5Ml6RPck3kBzCDx+pkpu5ylKcKwPORFhLh8pcpuLaYUiDiF8tg+5cAv
	glJgPdehk+mWn7F0mT65XneDhDEyWbo+itCG78QK53R5CMcaxIXTAdpS7ALLA6xKJWjVKA
	b9Qfv5dmHeIaaouIiJVme4EiM4UyXGpj+CXD4PkLcdT2bu7dHbL2zd88p7K/SzgCeMxxFo
	PjPaPgg+Ccs6LAfJztYZtdj7421A95gj0SUdHn9FKnjKBuFY4dZ4M0n2GyRw3A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 30 Jul 2025 19:02:47 +0200
Subject: [PATCH 4/4] drm/tidss: Fix sampling edge configuration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-fix-edge-handling-v1-4-1bdfb3fe7922@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=/p3QCeb5vrjQsgDySv7ceP1YaCttjBmqpB2bCe9hbyY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBoilA3+uu7ksY6HhTrzvxrlNdnU7OHWYsxGYCQ2
 fxOj7ZMH/+JAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaIpQNwAKCRAgrS7GWxAs
 4tKXD/4sZ0sUqe4etG+L+kea89Ub7gI7TmlWL/HHW/R4eN/jjonq+ae5qyuwSAYLbvlFvEBEgyC
 qGTFg0GCF67gfuuN095HEUNZ1EP9dGB2S0Yqj3MKXM36OHsCG2DHXtsBaFxs62DBxrwgnA1tEa+
 04f30TQYPpAPR4oKH/FF1/MEfz3j0Idt7cQXQcbqV8svD0waNm95iMrezSX15XkMajTFFQ5fB+S
 tbzr/utpbB4oFoT+mpoLBLPIeaE6Y9MlIi+iui9Ze3e4E4DjGRtj10IzVkig8tKyF+juxQNq61s
 OFuZuBz0o9eRx1ZQSuOW5HQrSP+3EkS0Om7KQ6OvJNvn/22fQb0zhxbON9UZ9LNjx4ooAZ/NxHR
 e7kMUuRN/CN4K92cH4vXzB65xti1xFFgmoQUpvjIUSH4FSTSvcxbdPYgoVjLvrImV6IOCzwysv0
 A7bhsLRoY4ZsyY2jqRTICAx4X3SQ10DCf7JwLKfvd+mxkZivK9nxJ9t64krM0M8PpYjQ802gPk3
 5tao4daQfje4SJ0R/shh8sCut2UJrR2QEdLX62WNxIWlRWfqaQTRDDHTBv9hJF1Sg4Z0dtPmyYR
 XZlEuSKxYEjSz/DNucVZ6iYTK+KIHJy27udRLPlcsFeAVY9MJnojagC9sn5AbuY827lx87j98Ps
 241f24OZV4aqqFA==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtjedttdetieeigfeljeekteetvefhudekgeelffejheegieevhfegudffvddvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddtngdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehjhihrihdrshgrrhhhrgesihhkihdrfhhipdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheps
 hhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnmhesthhirdgtohhm

As stated in the AM62x Technical Reference Manual (SPRUIV7B), the data
sampling edge needs to be configured in two distinct registers: one in the
TIDSS IP and another in the memory-mapped control register modules. Since
the latter is not within the same address range, a phandle to a syscon
device is used to access the regmap.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>

---

Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c0277fa36425ee1f966dccecf2b69a2d01794899..65ca7629a2e75437023bf58f8a1bddc24db5e3da 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -498,6 +498,7 @@ struct dispc_device {
 	const struct dispc_features *feat;
 
 	struct clk *fclk;
+	struct regmap *clk_ctrl;
 
 	bool is_enabled;
 
@@ -1267,6 +1268,11 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 		       FLD_VAL(mode->vdisplay - 1, 27, 16));
 
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 0, 0);
+
+	if (dispc->clk_ctrl) {
+		regmap_update_bits(dispc->clk_ctrl, 0, 0x100, ipc ? 0x100 : 0x000);
+		regmap_update_bits(dispc->clk_ctrl, 0, 0x200, rf ? 0x200 : 0x000);
+	}
 }
 
 void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
@@ -3012,6 +3018,14 @@ int dispc_init(struct tidss_device *tidss)
 
 	dispc_init_errata(dispc);
 
+	dispc->clk_ctrl = syscon_regmap_lookup_by_phandle_optional(tidss->dev->of_node,
+								   "ti,clk-ctrl");
+	if (IS_ERR(dispc->clk_ctrl)) {
+		r = dev_err_probe(dispc->dev, PTR_ERR(dispc->clk_ctrl),
+				  "DISPC: syscon_regmap_lookup_by_phandle failed.\n");
+		return r;
+	}
+
 	dispc->fourccs = devm_kcalloc(dev, ARRAY_SIZE(dispc_color_formats),
 				      sizeof(*dispc->fourccs), GFP_KERNEL);
 	if (!dispc->fourccs)

-- 
2.50.1


