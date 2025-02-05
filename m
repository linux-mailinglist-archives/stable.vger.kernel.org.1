Return-Path: <stable+bounces-113291-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC49A290F5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E1616A52A
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402618DF73;
	Wed,  5 Feb 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zO+moyg4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FD18C03B;
	Wed,  5 Feb 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766463; cv=none; b=fav/M+lYi/ZpEHl13fDEPEdutSMdByXRA860xVnwiDzPBXZS4x6Rs9rnrocLXuGwlS1Xk2N7L6i/Rto7ZBM0rDlKf4ZYEtfGPkOgrKt2w/tflLYLNz37vQjLCPW13BZiED11Wng8CN0YQuE1l9Jl9TCCbvGbV3glJ15LRSb8tak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766463; c=relaxed/simple;
	bh=gMPtpI9cY/ERhnKByzKL4WoOvEUVADcURg6Ro2PKndg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/C/h7jGZ5wgFgXOuDx3m3EYP5yXfa5gbhdkpzkPtpEmRAATLMddjw/jYIy25bwovFahFWN2C0KyIdVcTYLQKJB+p5xaULz1u17s8opNMhoBy9ubAYel/UrZXMoAzbkX/s6PuW27UoD6mExynDEf36Xfx2DTSwikx/V/bMn3mgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zO+moyg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B01C4CED1;
	Wed,  5 Feb 2025 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766463;
	bh=gMPtpI9cY/ERhnKByzKL4WoOvEUVADcURg6Ro2PKndg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zO+moyg4jTrnQIFNsrYe8M9tzstWga+Y6gwCr7nG9IzgjAtQQ9Ud1h887pL4jOiwq
	 zw5G7fhcCUhHQLZwzK/pED4YMhLss6Qjij2DRt07E86emNNdyO9EBE0TtOAnQenMue
	 qYMFeLIYlU58LEHhEP9UngFFv2d49gvlhLGyJ2AE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>,
	Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 326/590] ARM: dts: aspeed: yosemite4: correct the compatible string for max31790
Date: Wed,  5 Feb 2025 14:41:21 +0100
Message-ID: <20250205134507.747109617@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>

[ Upstream commit b1a1ecb669bfa763ee5e86a038d7c9363eee7548 ]

Fix the compatible string for max31790 to match the binding document.

Fixes: 2b8d94f4b4a4 ("ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC")
Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Link: https://patch.msgid.link/20241003074251.3818101-6-Delphine_CC_Chiu@wiwynn.com
Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 331578b24c204..14d1751031068 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -461,10 +461,8 @@
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
@@ -475,10 +473,8 @@
 			};
 
 			pwm@23{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			adc@33 {
@@ -513,10 +509,8 @@
 			};
 
 			pwm@20{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x20>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			gpio@22{
@@ -527,10 +521,8 @@
 			};
 
 			pwm@23{
-				compatible = "max31790";
+				compatible = "maxim,max31790";
 				reg = <0x23>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 
 			adc@33 {
-- 
2.39.5




