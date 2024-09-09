Return-Path: <stable+bounces-73976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDDE971025
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED139B22609
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07D1B1D7E;
	Mon,  9 Sep 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DcnxZcSK"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303621B143A;
	Mon,  9 Sep 2024 07:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868035; cv=none; b=TkWGXssqyMCpbS2ujVTw/rQZEwq18SQCOU1F6ee+yJndm0WVCxuL0ounH1g+WUrsuPwDyTGblmzhCFGy4PQQBvvxrguIklDRyAX7JNGdaDWpsVZF8Df+/bXDjiT8SFU6BomQDXMZJyiJYN0Dxo5XIsJN7IurBnjQ+ncskOKuIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868035; c=relaxed/simple;
	bh=PVu0AO3goLCjMmjEeFnjdb8rsuK1z5+HinRLmU09zvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi/ekM+kynFcuTmCRQUPCJDFvocGAIYAliOqidXaqsPxuRNkcfbBW/B9wGWujQKU63+swif4QkM0L3l86/dLkUVr+89aHt5bZbd+zGjapV9FTNV38Of9XEuR+vdgxmwPhBKjqP9jU10xUPkW1wPEPWF9Huryg6lHEmqTO6leSJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DcnxZcSK; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725868027;
	bh=HQ+u1pFtHvaYXeS206TMW008UyQVv1/1fvQ4x78GPS0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=DcnxZcSKWkDkUDRPzHPrKPvASeQ1PGV18ICsXCZNCz1OhMer8JJQXmLFgxm9/q4j5
	 RLWJqd/CBCbtE/Rr7W0cnTVIzswDw4GpISNBgTSDLsHlmI2DRS5wR9jgs6f/IxNRQB
	 tpgL6CQgmMMYgrl1wAePNonhnHZaVj2embLMnokY=
X-QQ-mid: bizesmtpsz13t1725868021tc81xv
X-QQ-Originating-IP: xgxCbM7/VxtkaC6p5voMkjfWvVx83murpI+h4hb+tFM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Sep 2024 15:46:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8765951806881718135
From: WangYuli <wangyuli@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	william.qiu@starfivetech.com,
	emil.renner.berthing@canonical.com,
	conor.dooley@microchip.com,
	wangyuli@uniontech.com,
	xingyu.wu@starfivetech.com,
	walker.chen@starfivetech.com,
	robh@kernel.org,
	hal.feng@starfivetech.com
Cc: kernel@esmil.dk,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH 6.6 2/4] riscv: dts: starfive: pinfunc: Fix the pins name of I2STX1
Date: Mon,  9 Sep 2024 15:46:28 +0800
Message-ID: <8830E9DA269F759D+20240909074645.1161554-2-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240909074645.1161554-1-wangyuli@uniontech.com>
References: <20240909074645.1161554-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Xingyu Wu <xingyu.wu@starfivetech.com>

These pins are actually I2STX1 clock input, not I2STX0,
so their names should be changed.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
index fb0139b56723..256de17f5261 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
+++ b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
@@ -240,8 +240,8 @@
 #define GPI_SYS_MCLK_EXT			30
 #define GPI_SYS_I2SRX_BCLK			31
 #define GPI_SYS_I2SRX_LRCK			32
-#define GPI_SYS_I2STX0_BCLK			33
-#define GPI_SYS_I2STX0_LRCK			34
+#define GPI_SYS_I2STX1_BCLK			33
+#define GPI_SYS_I2STX1_LRCK			34
 #define GPI_SYS_TDM_CLK				35
 #define GPI_SYS_TDM_RXD				36
 #define GPI_SYS_TDM_SYNC			37
-- 
2.43.4


