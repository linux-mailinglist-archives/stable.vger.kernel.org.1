Return-Path: <stable+bounces-206412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C75D0633B
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 22:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F8B830456BC
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 21:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77AA3328EA;
	Thu,  8 Jan 2026 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="MPnudNsW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zvtoLnw2"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF553328E0;
	Thu,  8 Jan 2026 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906279; cv=none; b=nuWNRist+JOCE+akHLO0dMTPDOTtIVAzK3CXHsrBhwVm6fx60Jt1Z7zYQqOgJyApGo4nRbFeKBtpsKpOzkQE4SrZPbNcFqsrS8GyviJoIceNie/6KYbeXcJvKYwWebgTzCl16tAemT2t05uPWPWLwYu+2CPP5mRzPw0ZLHSsVDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906279; c=relaxed/simple;
	bh=eh/RncIhcNF7K7NjRWfxhxp8BvQj2+b3J+GhqEj6jH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qktCO/JNu0j6YM1PxWeY+lfqPofprOz2OG+R+X+oQjnqhSvExXHj6OqqWIhLe0k+mbs6Zathq72N7PyZKD3WzISOeJ3YZqLacjuqtpamjTc6SXjf/Kw/NcaV1u3upqKr5ke0u1UGp5Q6n/PMMYqxamgzZM2M19YpWcePSx7htrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=MPnudNsW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zvtoLnw2; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 229401D00070;
	Thu,  8 Jan 2026 16:04:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Jan 2026 16:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767906276;
	 x=1767992676; bh=b8MwoLw3nQeq6OMFA9qd8hgLbODnrMCyrSn1Vrtcd/U=; b=
	MPnudNsWg0G3S3bPjBiCjdExs0KzqRHPVxxR/Gs4j/Y7ogZJzsL0nzrvIwqaEu8S
	UA8MAW1oByW2crii8X/cix8+9iRR8FZL784Y6qVEd1VHGCGmwYFc+eaQTvaCq4Vx
	iwGZyBuijapWQDQp4lBTUvoRgfclRduhH4SzFpXVrnpzTRvxKEagCqg93psH110S
	/G96C0baqopkGNaymRkDd23e0Wp0HE5sx7UmLwPpTMN9me/2+78iFKP1hmBSOaR7
	OxoE3FjJWnEn6EJTwVQjzRifVh1cL6HEIRiT7Fjcswybve5wsY1J4w/NGZBwEXxI
	cVO/GaARa2Sq6hZIo0twLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767906276; x=
	1767992676; bh=b8MwoLw3nQeq6OMFA9qd8hgLbODnrMCyrSn1Vrtcd/U=; b=z
	vtoLnw2Cw5nQpBOb/aXCTHaHFyRtPzp6QKstrLR0goHQCa5cQRRwUUHlbZRGe0O7
	y92lJHGjRSTDHE6xJU2u1H/IlRU6HADVHZ2URJLCHVDLQTVR4wbQEn4YSPOqSmhR
	I3jCXUzbB3UtcMU9TALLNqSZXo7J55jwWdrR0mdn1Se2Xq0LC1xIEEy7UM1dXcgl
	+ehOS3Ubfvopjyim/4KLU3Kp/dJXB+vuSYErb72U3QL6PbJcWUjt7reWRbyyV2qy
	r4OfOMXMUsXvESLUzeOQQPii+s1Fvb9qD6s+vOEJaWWX1+KV5gj+HllFO35oMlyg
	tyFLsxMbtUdkv0wHl54WQ==
X-ME-Sender: <xms:5BtgadbgDLzukVvbe4n38uDwSQ8y1J9j4eL0zJRmefCgNGocVs9wGw>
    <xme:5BtgaV88cq8RsE7lG0IcWeei4gRkARCFQRWknaN03krQMQbTaF95if4EW1X-xz4yI
    XmLY3ygkXbhExjFEzhiFQjLECMMqxb5cMfbl06baqiN0Ge3F42hcnM>
X-ME-Received: <xmr:5BtgafOk_6VQ0tPKy4QRd-nxYdWnlw7-QjbdUdSD3qOnk2eO4p186ss6cMMon5rHGUHv-Y5DT3Aj9bvH28VyVHv5Hyi3IwMYHz6i6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeileekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsrghhih
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehsvhgvnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoheplh
    hinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5BtgaSFfDlFKDgRf39Xm9qMJy_X9QOytiqRnv385aPov7g4LRZTHIw>
    <xmx:5Btgadw0m4awAO3LZHnYhW3r6zavCJ4CJtF9apzdxZF3IzkYEqV91Q>
    <xmx:5BtgaTqozZaRg2aKTHOBOnsa-gszjwdSeANEt0cCZJUZ5uhbs8gqtQ>
    <xmx:5BtgaTneHNn-HhJAHveJ2ChEjZ258hzcNMMNk2dxFwkK1U_9pjQTrg>
    <xmx:5BtgaXXHE-VfoZuPdU2q2Y4O36Uzst7OzWfbH9sj5hMckcvK0UD2pEx9>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 16:04:36 -0500 (EST)
From: Janne Grunau <j@jannau.net>
Date: Thu, 08 Jan 2026 22:04:01 +0100
Subject: [PATCH 1/3] arm64: dts: apple: t8112-j473: Keep the HDMI port
 powered on
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-apple-dt-pmgr-fixes-v1-1-cfdce629c0a8@jannau.net>
References: <20260108-apple-dt-pmgr-fixes-v1-0-cfdce629c0a8@jannau.net>
In-Reply-To: <20260108-apple-dt-pmgr-fixes-v1-0-cfdce629c0a8@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1920; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=eh/RncIhcNF7K7NjRWfxhxp8BvQj2+b3J+GhqEj6jH4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhswE6btlRbsbJk3fHHhLxEleW4JB6aDYxO+ynMd0RN5dL
 v6v8Nezo5SFQYyLQVZMkSVJ+2UHw+oaxZjaB2Ewc1iZQIYwcHEKwESswxkZ9l9ocJw/5d/36HZ7
 fdNnHGu3Jjxk0ypZseq0kXRVBMNCS4Z/1srl0+qDtn2JurdKSVlzj26jyDaPX+EXD5nPf7KMJya
 TAQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Add the display controller and DPTX phy power-domains to the framebuffer
node to keep the framebuffer and display out working after device probing
finished.
The OS has more control about the display pipeline used for the HDMI
output on M2 based devices. The HDMI output is driven by an integrated
DisplayPort to HDMI converter (Parade PS190). The DPTX phy is now
controlled by the OS and no longer by firmware running on the display
co-processor. This allows using the second display controller on the
second USB type-c port or tunneling 2 DisplayPort connections over
USB4/Thunderbolt.
The m1n1 bootloader uses the second display controller to drive the HDMI
output. Adjust for this difference compared to the notebooks as well.

Fixes: 2d5ce3fbef32 ("arm64: dts: apple: t8112: Initial t8112 (M2) device trees")
Cc: stable@vger.kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t8112-j473.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8112-j473.dts b/arch/arm64/boot/dts/apple/t8112-j473.dts
index 06fe257f08be498ace6906b936012e01084da702..4ae1ce919dafc40d849f7dcee948457158562316 100644
--- a/arch/arm64/boot/dts/apple/t8112-j473.dts
+++ b/arch/arm64/boot/dts/apple/t8112-j473.dts
@@ -21,6 +21,25 @@ aliases {
 	};
 };
 
+/*
+ * Keep the power-domains used for the HDMI port on.
+ */
+&framebuffer0 {
+	power-domains = <&ps_dispext_cpu0>, <&ps_dptx_ext_phy>;
+};
+
+/*
+ * The M2 Mac mini uses dispext for the HDMI output so it's not necessary to
+ * keep disp0 power-domains always-on.
+ */
+&ps_disp0_sys {
+	/delete-property/ apple,always-on;
+};
+
+&ps_disp0_fe {
+	/delete-property/ apple,always-on;
+};
+
 /*
  * Force the bus number assignments so that we can declare some of the
  * on-board devices and properties that are populated by the bootloader

-- 
2.52.0


