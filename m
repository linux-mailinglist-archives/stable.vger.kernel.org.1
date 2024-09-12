Return-Path: <stable+bounces-75929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8EA975F57
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 04:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23571C22650
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 02:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AF7DA9C;
	Thu, 12 Sep 2024 02:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="QSS2BlBm"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F113126C0E;
	Thu, 12 Sep 2024 02:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109773; cv=none; b=nm2Qc9Ump45cvJ/TMTe9cy7E/3kPnVcMcDTnMUx/Va/zTwuhYxB3/5k/53lRnRwHZTV6LaXNLeo+FqDFgpQM70AauM0IZPdj3O06qI0dJsnGZAJ3XIzLeKJMCIheqoggEX5cP0nmrBXTYWEwlB86CxhDfmfRjKp0LQ2/3rFkBRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109773; c=relaxed/simple;
	bh=xm7LbTv/MUcZzmyc0Yj1Cl/PvgH0OuuIJwbz1W9+4+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxYu36Nunq557R7hmLoa5q0VawLsWCfdXV2Gye/tE5fxPQQ70TYkJqI6QAhtqtnt07VCabOfL6Dm/APtu/wNSBFUyysZNO80opeS1f6TKOmmZHhfln46P6rNVh/fGA1ec9/4dMImqKNR4PhkmqlyvZbaIIUrqq2TDi4DP24W42Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=QSS2BlBm; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726109757;
	bh=Q+f7Y6NaDNcklTT7is2kRztTuiX4oAl/H2qYe+la9kk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QSS2BlBm94Zctf4Q9AnnDCYXHA49VU4uuNe7heSSSzPdTssAAZ5zPEvbuccIR7ndY
	 J7cu3iJ2mXHHbTm9f4uh6UXjRf5Gy/ur6e3UB/xPadaR9Kvl2AKhaiZ1TbI2hpOTwp
	 zaBeNkFu7voPWzb3se63r9EKve/gQFXFSb7VRecI=
X-QQ-mid: bizesmtp81t1726109752tgd9zc2a
X-QQ-Originating-IP: FwNYInude3/6pcUIZW5jorMw7+H52eujKyRqd6Fcx+8=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 12 Sep 2024 10:55:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4074563589889725486
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
Subject: [PATCH 6.6 v2 2/4] riscv: dts: starfive: pinfunc: Fix the pins name of I2STX1
Date: Thu, 12 Sep 2024 10:55:06 +0800
Message-ID: <3D0F65E42817C96F+20240912025539.1928223-2-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240912025539.1928223-1-wangyuli@uniontech.com>
References: <20240912025539.1928223-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

From: Xingyu Wu <xingyu.wu@starfivetech.com>

[ Upstream commit 4e1abae5688aae9dd8345dbd4ea92a4b9adf340d ]

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


