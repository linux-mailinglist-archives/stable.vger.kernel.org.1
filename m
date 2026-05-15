Return-Path: <stable+bounces-248838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNCdHglVB2pIygIAu9opvQ
	(envelope-from <stable+bounces-248838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:16:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF294554B9D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A031433E6AD7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60BF330675;
	Fri, 15 May 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ofODy21u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885A3264EC;
	Fri, 15 May 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862757; cv=none; b=Eq5B1tySwyBb3RlrHQ0z8AgfKu2lmoILpXdt5A2JdvfHapdF4VmknskVnANRmn8Ho1mWyNBwulJqMTBLPH4eidByGCqNsJMSm3PzimQ9Afvj3/1/gsSrh2rF2Mv5FfM2xCe+fLWYXtLRE2btHxo7qR37itfq1lkUj1i4Tv0Ed2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862757; c=relaxed/simple;
	bh=eVGejKbD4mjd/HS7Yrq2D6Ofzu7sfI7usFjgDIlAl+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4c31GMZ+ML5lJrCn6AFAS/8ctthE3+NHxcScbei9AIc5YUyVCm2XI7J4oDAviXM7+iwYdI58T46+EtvgmqtwjagQgOfes/qm4ydArYjSKjuz7ylfEoTM+wdiCh98ECyNAxby+cpCGHcyJifTHvqPg6R+6P2vVOerIloYz86gt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ofODy21u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F220C2BCC7;
	Fri, 15 May 2026 16:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862757;
	bh=eVGejKbD4mjd/HS7Yrq2D6Ofzu7sfI7usFjgDIlAl+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofODy21uL7pFP4LXda48PTOcBMICeoJtEgJt7sTkw0bPPrrOWuIOXjzvxr1MObOLG
	 HfVc6Y1jv5Rsp3zxp3MTx3VlMM2wWal4mC2fnTWZ8b3JFYmzENdmS8AJcyye8xAGqk
	 wELyjW/eGTGgT+k0nhybQJOViSukMvaYj9CdJJGs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 7.0 169/201] arm64: dts: qcom: lemans: Correct QUP interrupt numbers
Date: Fri, 15 May 2026 17:49:47 +0200
Message-ID: <20260515154702.236831767@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CF294554B9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248838-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.13.179.208:email,qualcomm.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

commit c5b22c88cc09b180e3a23010b29f4d02ec117a44 upstream.

Fix GIC_SPI interrupt numbers for QUPv3 SE6 nodes on Lemans SoC.
Using incorrect interrupt lines can prevent IRQs from triggering
and break I2C, SPI, and UART operation.

Fixes: 34a407316b7d3 ("arm64: dts: qcom: sa8775p: Populate additional UART DT nodes")
Fixes: 1b2d7ad5ac14d ("arm64: dts: qcom: sa8775p: add missing spi nodes")
Fixes: ee2f5f906d69d ("arm64: dts: qcom: sa8775p: add missing i2c nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260325-lemans-irq-num-v1-1-a470d544966a@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -1512,7 +1512,7 @@
 				reg = <0x0 0x898000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_i2c20_default>;
@@ -1539,7 +1539,7 @@
 				reg = <0x0 0x898000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_spi20_default>;
@@ -1564,7 +1564,7 @@
 			uart20: serial@898000 {
 				compatible = "qcom,geni-uart";
 				reg = <0x0 0x00898000 0x0 0x4000>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_uart20_default>;
@@ -2510,7 +2510,7 @@
 				reg = <0x0 0xa98000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_i2c13_default>;



