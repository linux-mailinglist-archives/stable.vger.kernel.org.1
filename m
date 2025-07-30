Return-Path: <stable+bounces-165584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B84C5B165B5
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D55B18C7B56
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BD92E093F;
	Wed, 30 Jul 2025 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f7GHXv1l"
X-Original-To: stable@vger.kernel.org
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374A2DE6F8;
	Wed, 30 Jul 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897518; cv=none; b=h2QQloNQPnFbylA3ZIcY/EIyN9uNU/VztfHtjA8BQjE7XsISR0B8sUcOBpIn+HbzHOkRQfKmUgrQGUQTWtY9uiix5PWvLFMpqdvoIUDdkud9ZudfSHmWbZgPmuKaJFoGG6ua7O15wXsA4sEXgyejz17L6qcSVvHVjzePx+I11Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897518; c=relaxed/simple;
	bh=HLG5xT1A8odfzcfiuinlcthJrJAa5lkuCncAANUHOzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBwpa6ceIhDOeXpT4yBQCHjtlD5aeyeFPwrX+nIwxmdMR5I/+ZOJSjyd1ih/lFLSLsWpnzJdOB+hKw/6KuWyhZ1P0p7lL4zowNiUP639jorrvi01nDo98/oqHQ18SuVmKdlBmRPW07aGcAgfn/BCbpBTPwWy/b3K0zA42L2CXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f7GHXv1l; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [IPv6:2001:4b98:dc4:8::235])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id AB286583E7E;
	Wed, 30 Jul 2025 17:03:03 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17D92442A8;
	Wed, 30 Jul 2025 17:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753894976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VkEcz9Od8lumPLGSI2mDm7zd90f2J6ysx2IIFyeMJqI=;
	b=f7GHXv1lkyC5Z5PHrKkyeT6qbn/8ObZkq64MuI3kVq6v9CyV1NhYlJVFLHHtSITgx+Xlse
	pAtAm8R27EtjZxv5oceulWPucQ7w+ki+9KS88kW9zdAYQCbA/fG3I/oep1o+Ju4MGZQB9d
	moZqJVWvw5DbMycog67ggCgSpQbRgsjluKNYyiiihkDKZfIoiNTGLrlYYCOYtzqBZgewqf
	cZqN9Ehm9Kfo0FT5Sl5QlcnKZhli2bhXS7j9T2Q/ZcFyZNZ67LlTRZNVtbkYOJ2TpKBrcL
	/I+LSeg+q029Lk569x4SPkI2E6yoTWQPrKcoskHC8cfmDP30FJKcLQFaRxthDA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 30 Jul 2025 19:02:46 +0200
Subject: [PATCH 3/4] arm64: dts: ti: k3-am62-main: Add tidss clk-ctrl
 property
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-fix-edge-handling-v1-3-1bdfb3fe7922@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1288;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=HLG5xT1A8odfzcfiuinlcthJrJAa5lkuCncAANUHOzY=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBoilA3fOPjwvG0cZmE1+t6tNyHTDM5v1j5X4MXI
 s7lieBu5JGJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaIpQNwAKCRAgrS7GWxAs
 4kN5D/4kRrkpCIavS2bJuKWAbgwtv9Mn70in9EJNplGfJRxKJK6SIYrOELlRzPDRiDfqJFWMxLw
 On3QBUHIUvAfhBBG19FOYinL8DTawFHeCUqgkSPD3KzvTUfzqA0uJLcrJoE9ifGPyK1YjXPrHx0
 KKmeiQHNrqBvA14SVQgXhrgnPCY82Gtm8A345ffpvnkDRH8f+qhiToeRd/xnLctCIT1ZC+yRNRk
 fAzce1tW3zki5RzgumyzJYdJKorbep1zGd8bKNwZxA7+LtNfQI3VzuHZ31FBqQsM8q6aeuco3Pp
 O24GeniP37W6GzFsOT3rz9Z0k+66zDU8MaLWEGCf8av7oG5Of1n1qtlLKm/NgLIERIRviM1ojjr
 xMzPZyRhLQz+Fy/pOUXxxFFGaLjZgP5NhTc0nuLEyNlm1Z4wUxAD4cUP5L2r9wOOzI1HufQRBtA
 9UNsTiiuv76Y2dVR+FCwIYFsobp8/Ax5cIdp3/nJTfYxaH2Y5o3mnv+oVWyAv9SsiKXZwotbSOJ
 QLayqbrCTaaZ4xTwnA1o06WnH1dOvF4qCWttQobHkL0BUpvuq+kkCyNAS6N6JTj1Gjc/cemHOJF
 lpkxhaz/gh4NAHmJKMBft7eTAkC2px5FdDnHjSZeNAfy2a4Ggppek3VkiUAs38bW06SHvO0BD4c
 FKK2cXZHMELwtQw==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephedtjedttdetieeigfeljeekteetvefhudekgeelffejheegieevhfegudffvddvnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddtngdpmhgrihhlfhhrohhmpehlohhuihhsrdgthhgruhhvvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopehjhihrihdrshgrrhhhrgesihhkihdrfhhipdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtoheps
 hhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnmhesthhirdgtohhm

For am62 processors, we need to use the newly created clk-ctrl property to
properly handle data edge sampling configuration. Add them in the main
device tree.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---

Cc: stable@vger.kernel.org
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 9e0b6eee9ac77d66869915b2d7bec3e2275c03ea..d3131e6da8e70fde035d3c44716f939e8167795a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -76,6 +76,11 @@ audio_refclk1: clock-controller@82e4 {
 			assigned-clock-parents = <&k3_clks 157 18>;
 			#clock-cells = <0>;
 		};
+
+		dss_clk_ctrl: dss_clk_ctrl@8300 {
+			compatible = "ti,am625-dss-clk-ctrl", "syscon";
+			reg = <0x8300 0x4>;
+		};
 	};
 
 	dmss: bus@48000000 {
@@ -787,6 +792,7 @@ dss: dss@30200000 {
 			 <&k3_clks 186 2>;
 		clock-names = "fck", "vp1", "vp2";
 		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		ti,clk-ctrl = <&dss_clk_ctrl>;
 		status = "disabled";
 
 		dss_ports: ports {

-- 
2.50.1


