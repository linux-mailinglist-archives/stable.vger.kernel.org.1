Return-Path: <stable+bounces-63508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4289941949
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338FE1F24D92
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737EA188014;
	Tue, 30 Jul 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IkIkJmBU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0E115699E;
	Tue, 30 Jul 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357056; cv=none; b=smSZ5/m8g0/YvgTnOQK/LPmjCD/1MndEhCuQttQCP/L6/X2gg5gOiFMl2ALGOXv8GCysUumXZ1UVPfDG3jEh3p+NnFE+WOgBiR6vCgvcWCmx15aYWOK13wlfZ5CL3XPvShKAXkuVKmVdEBbQDqSiq1+E5gUxPZwjxrpYEe1G8Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357056; c=relaxed/simple;
	bh=Qs9VvpHpObE9sYH3JEH4Hev/ds9CVWaT5TdgPErfMWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/4qLgK3nbbE17y2lsbN7r3825ByuM2+Wm/czuWmECSfKro6L3+0IUSSRvmO2FA6hvxHNwKXbkmxFiM829uZ6fO1FLD2eeZx7xweMb/xacpKZn7IfqsUVVcftGf9fDP0WmIMmKiSijGe4PyTj5CmrkQxaZdskUcRqA49RMPAXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IkIkJmBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941E4C4AF0A;
	Tue, 30 Jul 2024 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357056;
	bh=Qs9VvpHpObE9sYH3JEH4Hev/ds9CVWaT5TdgPErfMWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IkIkJmBURVd32AdCkvjTeKWzw2G1TRUE0J67fKr3C7AnjeFYvmxvKJzP/nlkovuOu
	 9AokIZcu2VX+jrpxeZK/S9LCd/s9sHJfjGb06PWoSK4AyMbhVPgpWeKv8UmtMQfC7P
	 CsL+3T+7atxPCmDSdhidLoc46koG/GY4AKGGeqpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 254/440] pinctrl: renesas: r8a779g0: Fix (H)SCIF1 suffixes
Date: Tue, 30 Jul 2024 17:48:07 +0200
Message-ID: <20240730151625.767527458@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3cf834a1669ea433aeee4c82c642776899c87451 ]

The Pin Multiplex attachment in Rev.1.10 of the R-Car V4H Series
Hardware User's Manual still has two alternate pin groups (GP0_14-18
and GP1_6-10) each named both HSCIF1 and SCIF1.  To differentiate, the
pin control driver uses "(h)scif1" and "(h)scif1_x", which were
considered temporary names until the conflict was sorted out.

Fix this by adopting R-Car V4M naming:
  - Rename "(h)scif1" to "(h)scif1_a",
  - Rename "(h)scif1_x" to "(h)scif1_b".

Adopt the R-Car V4M naming "(h)scif1_a" and "(h)scif1_b" to increase
uniformity.

While at it, remove unneeded separators.

Fixes: ad9bb2fec66262b0 ("pinctrl: renesas: Initial R8A779G0 (R-Car V4H) PFC support")
Fixes: 050442ae4c74f830 ("pinctrl: renesas: r8a779g0: Add pins, groups and functions")
Fixes: cf4f7891847bc558 ("pinctrl: renesas: r8a779g0: Add missing HSCIF1_X")
Fixes: 9c151c2be92becf2 ("pinctrl: renesas: r8a779g0: Add missing SCIF1_X")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/5009130d1867e12abf9b231c8838fd05e2b28bee.1717754960.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 208 ++++++++++++-------------
 1 file changed, 102 insertions(+), 106 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 1f64aeab186fc..36e043cff9441 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -285,13 +285,13 @@
 #define IP1SR0_15_12	FM(MSIOF5_SCK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR0_19_16	FM(MSIOF5_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR0_23_20	FM(MSIOF2_SS2)		FM(TCLK1)		FM(IRQ2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_27_24	FM(MSIOF2_SS1)		FM(HTX1)		FM(TX1)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_31_28	FM(MSIOF2_SYNC)		FM(HRX1)		FM(RX1)			F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_27_24	FM(MSIOF2_SS1)		FM(HTX1_A)		FM(TX1_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_31_28	FM(MSIOF2_SYNC)		FM(HRX1_A)		FM(RX1_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP2SR0 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP2SR0_3_0	FM(MSIOF2_TXD)		FM(HCTS1_N)		FM(CTS1_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR0_7_4	FM(MSIOF2_SCK)		FM(HRTS1_N)		FM(RTS1_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR0_11_8	FM(MSIOF2_RXD)		FM(HSCK1)		FM(SCK1)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR0_3_0	FM(MSIOF2_TXD)		FM(HCTS1_N_A)		FM(CTS1_N_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR0_7_4	FM(MSIOF2_SCK)		FM(HRTS1_N_A)		FM(RTS1_N_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR0_11_8	FM(MSIOF2_RXD)		FM(HSCK1_A)		FM(SCK1_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR1 */
 /* IP0SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -301,13 +301,13 @@
 #define IP0SR1_15_12	FM(MSIOF1_SCK)		FM(HSCK3_A)		FM(CTS3_N)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR1_19_16	FM(MSIOF1_TXD)		FM(HRX3_A)		FM(SCK3)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR1_23_20	FM(MSIOF1_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_27_24	FM(MSIOF0_SS2)		FM(HTX1_X)		FM(TX1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR1_31_28	FM(MSIOF0_SS1)		FM(HRX1_X)		FM(RX1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_27_24	FM(MSIOF0_SS2)		FM(HTX1_B)		FM(TX1_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR1_31_28	FM(MSIOF0_SS1)		FM(HRX1_B)		FM(RX1_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR1_3_0	FM(MSIOF0_SYNC)		FM(HCTS1_N_X)		FM(CTS1_N_X)		FM(CANFD5_TX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_7_4	FM(MSIOF0_TXD)		FM(HRTS1_N_X)		FM(RTS1_N_X)		FM(CANFD5_RX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_11_8	FM(MSIOF0_SCK)		FM(HSCK1_X)		FM(SCK1_X)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_3_0	FM(MSIOF0_SYNC)		FM(HCTS1_N_B)		FM(CTS1_N_B)		FM(CANFD5_TX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_7_4	FM(MSIOF0_TXD)		FM(HRTS1_N_B)		FM(RTS1_N_B)		FM(CANFD5_RX_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_11_8	FM(MSIOF0_SCK)		FM(HSCK1_B)		FM(SCK1_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR1_15_12	FM(MSIOF0_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR1_19_16	FM(HTX0)		FM(TX0)			F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR1_23_20	FM(HCTS0_N)		FM(CTS0_N)		FM(PWM8_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -748,25 +748,25 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR0_23_20,	IRQ2_A),
 
 	PINMUX_IPSR_GPSR(IP1SR0_27_24,	MSIOF2_SS1),
-	PINMUX_IPSR_GPSR(IP1SR0_27_24,	HTX1),
-	PINMUX_IPSR_GPSR(IP1SR0_27_24,	TX1),
+	PINMUX_IPSR_GPSR(IP1SR0_27_24,	HTX1_A),
+	PINMUX_IPSR_GPSR(IP1SR0_27_24,	TX1_A),
 
 	PINMUX_IPSR_GPSR(IP1SR0_31_28,	MSIOF2_SYNC),
-	PINMUX_IPSR_GPSR(IP1SR0_31_28,	HRX1),
-	PINMUX_IPSR_GPSR(IP1SR0_31_28,	RX1),
+	PINMUX_IPSR_GPSR(IP1SR0_31_28,	HRX1_A),
+	PINMUX_IPSR_GPSR(IP1SR0_31_28,	RX1_A),
 
 	/* IP2SR0 */
 	PINMUX_IPSR_GPSR(IP2SR0_3_0,	MSIOF2_TXD),
-	PINMUX_IPSR_GPSR(IP2SR0_3_0,	HCTS1_N),
-	PINMUX_IPSR_GPSR(IP2SR0_3_0,	CTS1_N),
+	PINMUX_IPSR_GPSR(IP2SR0_3_0,	HCTS1_N_A),
+	PINMUX_IPSR_GPSR(IP2SR0_3_0,	CTS1_N_A),
 
 	PINMUX_IPSR_GPSR(IP2SR0_7_4,	MSIOF2_SCK),
-	PINMUX_IPSR_GPSR(IP2SR0_7_4,	HRTS1_N),
-	PINMUX_IPSR_GPSR(IP2SR0_7_4,	RTS1_N),
+	PINMUX_IPSR_GPSR(IP2SR0_7_4,	HRTS1_N_A),
+	PINMUX_IPSR_GPSR(IP2SR0_7_4,	RTS1_N_A),
 
 	PINMUX_IPSR_GPSR(IP2SR0_11_8,	MSIOF2_RXD),
-	PINMUX_IPSR_GPSR(IP2SR0_11_8,	HSCK1),
-	PINMUX_IPSR_GPSR(IP2SR0_11_8,	SCK1),
+	PINMUX_IPSR_GPSR(IP2SR0_11_8,	HSCK1_A),
+	PINMUX_IPSR_GPSR(IP2SR0_11_8,	SCK1_A),
 
 	/* IP0SR1 */
 	PINMUX_IPSR_GPSR(IP0SR1_3_0,	MSIOF1_SS2),
@@ -792,27 +792,27 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP0SR1_23_20,	MSIOF1_RXD),
 
 	PINMUX_IPSR_GPSR(IP0SR1_27_24,	MSIOF0_SS2),
-	PINMUX_IPSR_GPSR(IP0SR1_27_24,	HTX1_X),
-	PINMUX_IPSR_GPSR(IP0SR1_27_24,	TX1_X),
+	PINMUX_IPSR_GPSR(IP0SR1_27_24,	HTX1_B),
+	PINMUX_IPSR_GPSR(IP0SR1_27_24,	TX1_B),
 
 	PINMUX_IPSR_GPSR(IP0SR1_31_28,	MSIOF0_SS1),
-	PINMUX_IPSR_GPSR(IP0SR1_31_28,	HRX1_X),
-	PINMUX_IPSR_GPSR(IP0SR1_31_28,	RX1_X),
+	PINMUX_IPSR_GPSR(IP0SR1_31_28,	HRX1_B),
+	PINMUX_IPSR_GPSR(IP0SR1_31_28,	RX1_B),
 
 	/* IP1SR1 */
 	PINMUX_IPSR_GPSR(IP1SR1_3_0,	MSIOF0_SYNC),
-	PINMUX_IPSR_GPSR(IP1SR1_3_0,	HCTS1_N_X),
-	PINMUX_IPSR_GPSR(IP1SR1_3_0,	CTS1_N_X),
+	PINMUX_IPSR_GPSR(IP1SR1_3_0,	HCTS1_N_B),
+	PINMUX_IPSR_GPSR(IP1SR1_3_0,	CTS1_N_B),
 	PINMUX_IPSR_GPSR(IP1SR1_3_0,	CANFD5_TX_B),
 
 	PINMUX_IPSR_GPSR(IP1SR1_7_4,	MSIOF0_TXD),
-	PINMUX_IPSR_GPSR(IP1SR1_7_4,	HRTS1_N_X),
-	PINMUX_IPSR_GPSR(IP1SR1_7_4,	RTS1_N_X),
+	PINMUX_IPSR_GPSR(IP1SR1_7_4,	HRTS1_N_B),
+	PINMUX_IPSR_GPSR(IP1SR1_7_4,	RTS1_N_B),
 	PINMUX_IPSR_GPSR(IP1SR1_7_4,	CANFD5_RX_B),
 
 	PINMUX_IPSR_GPSR(IP1SR1_11_8,	MSIOF0_SCK),
-	PINMUX_IPSR_GPSR(IP1SR1_11_8,	HSCK1_X),
-	PINMUX_IPSR_GPSR(IP1SR1_11_8,	SCK1_X),
+	PINMUX_IPSR_GPSR(IP1SR1_11_8,	HSCK1_B),
+	PINMUX_IPSR_GPSR(IP1SR1_11_8,	SCK1_B),
 
 	PINMUX_IPSR_GPSR(IP1SR1_15_12,	MSIOF0_RXD),
 
@@ -1574,49 +1574,48 @@ static const unsigned int hscif0_ctrl_mux[] = {
 };
 
 /* - HSCIF1 ----------------------------------------------------------------- */
-static const unsigned int hscif1_data_pins[] = {
-	/* HRX1, HTX1 */
+static const unsigned int hscif1_data_a_pins[] = {
+	/* HRX1_A, HTX1_A */
 	RCAR_GP_PIN(0, 15), RCAR_GP_PIN(0, 14),
 };
-static const unsigned int hscif1_data_mux[] = {
-	HRX1_MARK, HTX1_MARK,
+static const unsigned int hscif1_data_a_mux[] = {
+	HRX1_A_MARK, HTX1_A_MARK,
 };
-static const unsigned int hscif1_clk_pins[] = {
-	/* HSCK1 */
+static const unsigned int hscif1_clk_a_pins[] = {
+	/* HSCK1_A */
 	RCAR_GP_PIN(0, 18),
 };
-static const unsigned int hscif1_clk_mux[] = {
-	HSCK1_MARK,
+static const unsigned int hscif1_clk_a_mux[] = {
+	HSCK1_A_MARK,
 };
-static const unsigned int hscif1_ctrl_pins[] = {
-	/* HRTS1_N, HCTS1_N */
+static const unsigned int hscif1_ctrl_a_pins[] = {
+	/* HRTS1_N_A, HCTS1_N_A */
 	RCAR_GP_PIN(0, 17), RCAR_GP_PIN(0, 16),
 };
-static const unsigned int hscif1_ctrl_mux[] = {
-	HRTS1_N_MARK, HCTS1_N_MARK,
+static const unsigned int hscif1_ctrl_a_mux[] = {
+	HRTS1_N_A_MARK, HCTS1_N_A_MARK,
 };
 
-/* - HSCIF1_X---------------------------------------------------------------- */
-static const unsigned int hscif1_data_x_pins[] = {
-	/* HRX1_X, HTX1_X */
+static const unsigned int hscif1_data_b_pins[] = {
+	/* HRX1_B, HTX1_B */
 	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 6),
 };
-static const unsigned int hscif1_data_x_mux[] = {
-	HRX1_X_MARK, HTX1_X_MARK,
+static const unsigned int hscif1_data_b_mux[] = {
+	HRX1_B_MARK, HTX1_B_MARK,
 };
-static const unsigned int hscif1_clk_x_pins[] = {
-	/* HSCK1_X */
+static const unsigned int hscif1_clk_b_pins[] = {
+	/* HSCK1_B */
 	RCAR_GP_PIN(1, 10),
 };
-static const unsigned int hscif1_clk_x_mux[] = {
-	HSCK1_X_MARK,
+static const unsigned int hscif1_clk_b_mux[] = {
+	HSCK1_B_MARK,
 };
-static const unsigned int hscif1_ctrl_x_pins[] = {
-	/* HRTS1_N_X, HCTS1_N_X */
+static const unsigned int hscif1_ctrl_b_pins[] = {
+	/* HRTS1_N_B, HCTS1_N_B */
 	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 8),
 };
-static const unsigned int hscif1_ctrl_x_mux[] = {
-	HRTS1_N_X_MARK, HCTS1_N_X_MARK,
+static const unsigned int hscif1_ctrl_b_mux[] = {
+	HRTS1_N_B_MARK, HCTS1_N_B_MARK,
 };
 
 /* - HSCIF2 ----------------------------------------------------------------- */
@@ -2236,49 +2235,48 @@ static const unsigned int scif0_ctrl_mux[] = {
 };
 
 /* - SCIF1 ------------------------------------------------------------------ */
-static const unsigned int scif1_data_pins[] = {
-	/* RX1, TX1 */
+static const unsigned int scif1_data_a_pins[] = {
+	/* RX1_A, TX1_A */
 	RCAR_GP_PIN(0, 15), RCAR_GP_PIN(0, 14),
 };
-static const unsigned int scif1_data_mux[] = {
-	RX1_MARK, TX1_MARK,
+static const unsigned int scif1_data_a_mux[] = {
+	RX1_A_MARK, TX1_A_MARK,
 };
-static const unsigned int scif1_clk_pins[] = {
-	/* SCK1 */
+static const unsigned int scif1_clk_a_pins[] = {
+	/* SCK1_A */
 	RCAR_GP_PIN(0, 18),
 };
-static const unsigned int scif1_clk_mux[] = {
-	SCK1_MARK,
+static const unsigned int scif1_clk_a_mux[] = {
+	SCK1_A_MARK,
 };
-static const unsigned int scif1_ctrl_pins[] = {
-	/* RTS1_N, CTS1_N */
+static const unsigned int scif1_ctrl_a_pins[] = {
+	/* RTS1_N_A, CTS1_N_A */
 	RCAR_GP_PIN(0, 17), RCAR_GP_PIN(0, 16),
 };
-static const unsigned int scif1_ctrl_mux[] = {
-	RTS1_N_MARK, CTS1_N_MARK,
+static const unsigned int scif1_ctrl_a_mux[] = {
+	RTS1_N_A_MARK, CTS1_N_A_MARK,
 };
 
-/* - SCIF1_X ------------------------------------------------------------------ */
-static const unsigned int scif1_data_x_pins[] = {
-	/* RX1_X, TX1_X */
+static const unsigned int scif1_data_b_pins[] = {
+	/* RX1_B, TX1_B */
 	RCAR_GP_PIN(1, 7), RCAR_GP_PIN(1, 6),
 };
-static const unsigned int scif1_data_x_mux[] = {
-	RX1_X_MARK, TX1_X_MARK,
+static const unsigned int scif1_data_b_mux[] = {
+	RX1_B_MARK, TX1_B_MARK,
 };
-static const unsigned int scif1_clk_x_pins[] = {
-	/* SCK1_X */
+static const unsigned int scif1_clk_b_pins[] = {
+	/* SCK1_B */
 	RCAR_GP_PIN(1, 10),
 };
-static const unsigned int scif1_clk_x_mux[] = {
-	SCK1_X_MARK,
+static const unsigned int scif1_clk_b_mux[] = {
+	SCK1_B_MARK,
 };
-static const unsigned int scif1_ctrl_x_pins[] = {
-	/* RTS1_N_X, CTS1_N_X */
+static const unsigned int scif1_ctrl_b_pins[] = {
+	/* RTS1_N_B, CTS1_N_B */
 	RCAR_GP_PIN(1, 9), RCAR_GP_PIN(1, 8),
 };
-static const unsigned int scif1_ctrl_x_mux[] = {
-	RTS1_N_X_MARK, CTS1_N_X_MARK,
+static const unsigned int scif1_ctrl_b_mux[] = {
+	RTS1_N_B_MARK, CTS1_N_B_MARK,
 };
 
 /* - SCIF3 ------------------------------------------------------------------ */
@@ -2559,12 +2557,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(hscif0_data),
 	SH_PFC_PIN_GROUP(hscif0_clk),
 	SH_PFC_PIN_GROUP(hscif0_ctrl),
-	SH_PFC_PIN_GROUP(hscif1_data),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_clk),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_ctrl),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_data_x),	/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_clk_x),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(hscif1_ctrl_x),	/* suffix might be updated */
+	SH_PFC_PIN_GROUP(hscif1_data_a),
+	SH_PFC_PIN_GROUP(hscif1_clk_a),
+	SH_PFC_PIN_GROUP(hscif1_ctrl_a),
+	SH_PFC_PIN_GROUP(hscif1_data_b),
+	SH_PFC_PIN_GROUP(hscif1_clk_b),
+	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
 	SH_PFC_PIN_GROUP(hscif2_data),
 	SH_PFC_PIN_GROUP(hscif2_clk),
 	SH_PFC_PIN_GROUP(hscif2_ctrl),
@@ -2658,12 +2656,12 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif0_data),
 	SH_PFC_PIN_GROUP(scif0_clk),
 	SH_PFC_PIN_GROUP(scif0_ctrl),
-	SH_PFC_PIN_GROUP(scif1_data),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_clk),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_ctrl),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_data_x),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_clk_x),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(scif1_ctrl_x),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(scif1_data_a),
+	SH_PFC_PIN_GROUP(scif1_clk_a),
+	SH_PFC_PIN_GROUP(scif1_ctrl_a),
+	SH_PFC_PIN_GROUP(scif1_data_b),
+	SH_PFC_PIN_GROUP(scif1_clk_b),
+	SH_PFC_PIN_GROUP(scif1_ctrl_b),
 	SH_PFC_PIN_GROUP(scif3_data),		/* suffix might be updated */
 	SH_PFC_PIN_GROUP(scif3_clk),		/* suffix might be updated */
 	SH_PFC_PIN_GROUP(scif3_ctrl),		/* suffix might be updated */
@@ -2778,13 +2776,12 @@ static const char * const hscif0_groups[] = {
 };
 
 static const char * const hscif1_groups[] = {
-	/* suffix might be updated */
-	"hscif1_data",
-	"hscif1_clk",
-	"hscif1_ctrl",
-	"hscif1_data_x",
-	"hscif1_clk_x",
-	"hscif1_ctrl_x",
+	"hscif1_data_a",
+	"hscif1_clk_a",
+	"hscif1_ctrl_a",
+	"hscif1_data_b",
+	"hscif1_clk_b",
+	"hscif1_ctrl_b",
 };
 
 static const char * const hscif2_groups[] = {
@@ -2961,13 +2958,12 @@ static const char * const scif0_groups[] = {
 };
 
 static const char * const scif1_groups[] = {
-	/* suffix might be updated */
-	"scif1_data",
-	"scif1_clk",
-	"scif1_ctrl",
-	"scif1_data_x",
-	"scif1_clk_x",
-	"scif1_ctrl_x",
+	"scif1_data_a",
+	"scif1_clk_a",
+	"scif1_ctrl_a",
+	"scif1_data_b",
+	"scif1_clk_b",
+	"scif1_ctrl_b",
 };
 
 static const char * const scif3_groups[] = {
-- 
2.43.0




