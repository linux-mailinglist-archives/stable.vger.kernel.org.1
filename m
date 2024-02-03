Return-Path: <stable+bounces-18131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EA8848181
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244231C229CD
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7C2175AD;
	Sat,  3 Feb 2024 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VjZqTNnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2373C111AE;
	Sat,  3 Feb 2024 04:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933570; cv=none; b=r9nwiZc4EtEsZLM2daJ6grb+c0TKkIRgbWaGNj+ZpAi9aAbnhg6SOTqC21jYqmA5v8bZ71zQJpv7ds0bUX6XEsLZwgCrgzoAGlI3VJlKVmW3KtFA56oLV8gvERyEQEOcnDfCIIQdDBiZACiY99tLOVyGUfA6yUAh0QOy+Jiu1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933570; c=relaxed/simple;
	bh=H5zcPGGjOUot4sQFPBqGdFJoaoy9fxsRaERHkvy/M9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jR9aGFzhGTS4NmaIAN7gzZ3VPN6G3PI+UJxdD9JXZceQ+m4G012RYS3hOL2mVcYfShhVRGqf099t2qKLbFaJa0MEblNpScdchrD9v3gvZrAFYwkzB9xBdTLK64lstZiEiqJaWNOjZi6X9qdsS1wMZG1LZm85zGQbl/WKf2f6XvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VjZqTNnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3E6C43390;
	Sat,  3 Feb 2024 04:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933570;
	bh=H5zcPGGjOUot4sQFPBqGdFJoaoy9fxsRaERHkvy/M9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VjZqTNnfWbTg48iZcgMTRyYO5ArUWZ4MZKDi0P+yJsklrZPFiGlAhkPGoR2MXwErj
	 P62EdpSUhTMUJPulNh3+XO2rN0I4p4DUOzoG+pfSbb78uKrs06gt06/mEfwfzqBrsy
	 i7eA1ZeUxlyrajoMP8LVqBj1iZjYcP5TORdZ1ndw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 125/322] ARM: dts: imx23-sansa: Use preferred i2c-gpios properties
Date: Fri,  2 Feb 2024 20:03:42 -0800
Message-ID: <20240203035403.183805062@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit e3aa1a82fb20ee97597022f6528823a8ab82bde6 ]

The 'gpios' property to describe the SDA and SCL GPIOs is considered
deprecated according to i2c-gpio.yaml.

Switch to the preferred 'sda-gpios' and 'scl-gpios' properties.

This fixes the following schema warnings:

imx23-sansa.dtb: i2c-0: 'sda-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
imx23-sansa.dtb: i2c-0: 'scl-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
index 46057d9bf555..c2efcc20ae80 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
+++ b/arch/arm/boot/dts/nxp/mxs/imx23-sansa.dts
@@ -175,10 +175,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio1 24 0		/* SDA */
-			&gpio1 22 0		/* SCL */
-		>;
+		sda-gpios = <&gpio1 24 0>;
+		scl-gpios = <&gpio1 22 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 	};
 
@@ -186,10 +184,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "i2c-gpio";
-		gpios = <
-			&gpio0 31 0		/* SDA */
-			&gpio0 30 0		/* SCL */
-		>;
+		sda-gpios = <&gpio0 31 0>;
+		scl-gpios = <&gpio0 30 0>;
 		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
 
 		touch: touch@20 {
-- 
2.43.0




