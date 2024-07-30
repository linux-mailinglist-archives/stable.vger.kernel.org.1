Return-Path: <stable+bounces-64280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D88941D20
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA061F249D9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D407D18A6B4;
	Tue, 30 Jul 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ta3z04mP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DE918454A;
	Tue, 30 Jul 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359597; cv=none; b=hjwEvRKem3D0r0GArN1G15RGCWIL6PT+At5IDKByOP6vVuZU0wJVbGM3Xt10aKnhuymP9NA6pI/GJb/qhc4WpFxTv/V9D/+Ad2yNrUHaDBs+hWSJg+U8IKO39Uju5A+8ob7qMW/iCr7hFdj1fu7Ga5V5FKxHSscBMW5e1+CoP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359597; c=relaxed/simple;
	bh=pv708lyJeJzNXNlRaGg0rfa4Q5r0BAcYRnBC1DU4F1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EW2fS2t1GRqJibvFiHBaZfgbMSo28tHbmbzQINM5Cqhonnf4Joy1yiEwBOOydujgbutyBaRP5TQ5KLVU2SyBatvxZBcoRJiwUdQVi/bztK0DOUcVUIYFyZpj7YczLN6VET92TwG2HqnBNtAn3as5tMExs2YmfLmPwL32wFeQYxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ta3z04mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B51C32782;
	Tue, 30 Jul 2024 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359597;
	bh=pv708lyJeJzNXNlRaGg0rfa4Q5r0BAcYRnBC1DU4F1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ta3z04mPsUlhO9lCECK79vWpittyR4f7k/HI+/uoFAHIbEQtfhPDoak74F3VqLy9w
	 F14c26NvjOwZAkE3MLPsJrBgIcwmeS6YI4J6Q1DaI+pC3ApmbgkQOLeBxU7Q/q5l0H
	 eh4R6GqVkBa6yw2yM2MwOGMVN/WB8h0vjdOXV9cQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 506/809] pinctrl: renesas: r8a779g0: Fix TCLK suffixes
Date: Tue, 30 Jul 2024 17:46:22 +0200
Message-ID: <20240730151744.722930064@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit bfd2428f3a80647af681df4793e473258aa755da ]

The Pin Multiplex attachment in Rev.1.10 of the R-Car V4H Series
Hardware User's Manual still has two alternate pins named both TCLK3
and TCLK4.  To differentiate, the pin control driver uses "TCLK[34]" and
"TCLK[34]_X".  In addition, there are alternate pins without suffix, and
with an "_A" or "_B" suffix.

Increase uniformity by adopting R-Car V4M naming:
  - Rename "TCLK2_B" to "TCLK2_C",
  - Rename "TCLK[12]_A" to "TCLK[12]_B",
  - Rename "TCLK[12]" to "TCLK[12]_A",
  - Rename "TCLK[34]_A" to "TCLK[34]_C",
  - Rename "TCLK[34]_X" to "TCLK[34]_A",
  - Rename "TCLK[34]" to "TCLK[34]_B".

Fixes: ad9bb2fec66262b0 ("pinctrl: renesas: Initial R8A779G0 (R-Car V4H) PFC support")
Fixes: 0df46188a58895e1 ("pinctrl: renesas: r8a779g0: Add missing TCLKx_A/TCLKx_B/TCLKx_X")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/2845ff1f8fe1fd8d23d2f307ad5e8eb8243da608.1717754960.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 44 +++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 3228a61ea4098..8c19b892441a3 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -275,7 +275,7 @@
 
 /* SR0 */
 /* IP0SR0 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_7_4	F_(0, 0)		FM(MSIOF3_SS1)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_11_8	F_(0, 0)		FM(MSIOF3_SS2)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_15_12	FM(IRQ3_A)		FM(MSIOF3_SCK)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -290,7 +290,7 @@
 #define IP1SR0_11_8	FM(MSIOF5_TXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR0_15_12	FM(MSIOF5_SCK)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR0_19_16	FM(MSIOF5_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR0_23_20	FM(MSIOF2_SS2)		FM(TCLK1)		FM(IRQ2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR0_23_20	FM(MSIOF2_SS2)		FM(TCLK1_A)		FM(IRQ2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR0_27_24	FM(MSIOF2_SS1)		FM(HTX1_A)		FM(TX1_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR0_31_28	FM(MSIOF2_SYNC)		FM(HRX1_A)		FM(RX1_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
@@ -323,12 +323,12 @@
 /* IP2SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
 #define IP2SR1_3_0	FM(HRX0)		FM(RX0)			F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2SR1_7_4	FM(SCIF_CLK)		FM(IRQ4_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_11_8	FM(SSI_SCK)		FM(TCLK3)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_15_12	FM(SSI_WS)		FM(TCLK4)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_11_8	FM(SSI_SCK)		FM(TCLK3_B)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_15_12	FM(SSI_WS)		FM(TCLK4_B)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2SR1_19_16	FM(SSI_SD)		FM(IRQ0_B)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2SR1_23_20	FM(AUDIO_CLKOUT)	FM(IRQ1_B)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP2SR1_27_24	FM(AUDIO_CLKIN)		FM(PWM3_A)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP2SR1_31_28	F_(0, 0)		FM(TCLK2)		FM(MSIOF4_SS1)		FM(IRQ3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP2SR1_31_28	F_(0, 0)		FM(TCLK2_A)		FM(MSIOF4_SS1)		FM(IRQ3_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP3SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
 #define IP3SR1_3_0	FM(HRX3_A)		FM(SCK3_A)		FM(MSIOF4_SS2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -346,15 +346,15 @@
 #define IP0SR2_19_16	FM(RXDB_EXTFXR)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_23_20	FM(FXR_TXENB_N_A)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_27_24	FM(FXR_TXDB)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_31_28	FM(TPU0TO1)		FM(CANFD6_TX)		F_(0, 0)		FM(TCLK2_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_31_28	FM(TPU0TO1)		FM(CANFD6_TX)		F_(0, 0)		FM(TCLK2_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR2_3_0	FM(TPU0TO0)		FM(CANFD6_RX)		F_(0, 0)		FM(TCLK1_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_3_0	FM(TPU0TO0)		FM(CANFD6_RX)		F_(0, 0)		FM(TCLK1_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_7_4	FM(CAN_CLK)		FM(FXR_TXENA_N_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_11_8	FM(CANFD0_TX)		FM(FXR_TXENB_N_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_15_12	FM(CANFD0_RX)		FM(STPWT_EXTFXR)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2)		F_(0, 0)		FM(TCLK3_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3)		FM(PWM1_B)		FM(TCLK4_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2)		F_(0, 0)		FM(TCLK3_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3)		FM(PWM1_B)		FM(TCLK4_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_31_28	FM(CANFD3_RX)		F_(0, 0)		FM(PWM3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
@@ -381,8 +381,8 @@
 #define IP1SR3_11_8	FM(MMC_SD_CMD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR3_15_12	FM(SD_CD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR3_19_16	FM(SD_WP)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_23_20	FM(IPC_CLKIN)		FM(IPC_CLKEN_IN)	FM(PWM1_A)		FM(TCLK3_X)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR3_27_24	FM(IPC_CLKOUT)		FM(IPC_CLKEN_OUT)	FM(ERROROUTC_N_A)	FM(TCLK4_X)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_23_20	FM(IPC_CLKIN)		FM(IPC_CLKEN_IN)	FM(PWM1_A)		FM(TCLK3_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR3_27_24	FM(IPC_CLKOUT)		FM(IPC_CLKEN_OUT)	FM(ERROROUTC_N_A)	FM(TCLK4_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR3_31_28	FM(QSPI0_SSL)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP2SR3 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -718,7 +718,7 @@ static const u16 pinmux_data[] = {
 
 	/* IP0SR0 */
 	PINMUX_IPSR_GPSR(IP0SR0_3_0,	ERROROUTC_N_B),
-	PINMUX_IPSR_GPSR(IP0SR0_3_0,	TCLK2_A),
+	PINMUX_IPSR_GPSR(IP0SR0_3_0,	TCLK2_B),
 
 	PINMUX_IPSR_GPSR(IP0SR0_7_4,	MSIOF3_SS1),
 
@@ -750,7 +750,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR0_19_16,	MSIOF5_RXD),
 
 	PINMUX_IPSR_GPSR(IP1SR0_23_20,	MSIOF2_SS2),
-	PINMUX_IPSR_GPSR(IP1SR0_23_20,	TCLK1),
+	PINMUX_IPSR_GPSR(IP1SR0_23_20,	TCLK1_A),
 	PINMUX_IPSR_GPSR(IP1SR0_23_20,	IRQ2_B),
 
 	PINMUX_IPSR_GPSR(IP1SR0_27_24,	MSIOF2_SS1),
@@ -845,10 +845,10 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP2SR1_7_4,	IRQ4_A),
 
 	PINMUX_IPSR_GPSR(IP2SR1_11_8,	SSI_SCK),
-	PINMUX_IPSR_GPSR(IP2SR1_11_8,	TCLK3),
+	PINMUX_IPSR_GPSR(IP2SR1_11_8,	TCLK3_B),
 
 	PINMUX_IPSR_GPSR(IP2SR1_15_12,	SSI_WS),
-	PINMUX_IPSR_GPSR(IP2SR1_15_12,	TCLK4),
+	PINMUX_IPSR_GPSR(IP2SR1_15_12,	TCLK4_B),
 
 	PINMUX_IPSR_GPSR(IP2SR1_19_16,	SSI_SD),
 	PINMUX_IPSR_GPSR(IP2SR1_19_16,	IRQ0_B),
@@ -859,7 +859,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP2SR1_27_24,	AUDIO_CLKIN),
 	PINMUX_IPSR_GPSR(IP2SR1_27_24,	PWM3_A),
 
-	PINMUX_IPSR_GPSR(IP2SR1_31_28,	TCLK2),
+	PINMUX_IPSR_GPSR(IP2SR1_31_28,	TCLK2_A),
 	PINMUX_IPSR_GPSR(IP2SR1_31_28,	MSIOF4_SS1),
 	PINMUX_IPSR_GPSR(IP2SR1_31_28,	IRQ3_B),
 
@@ -911,12 +911,12 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TPU0TO1),
 	PINMUX_IPSR_GPSR(IP0SR2_31_28,	CANFD6_TX),
-	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TCLK2_B),
+	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TCLK2_C),
 
 	/* IP1SR2 */
 	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TPU0TO0),
 	PINMUX_IPSR_GPSR(IP1SR2_3_0,	CANFD6_RX),
-	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TCLK1_A),
+	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TCLK1_B),
 
 	PINMUX_IPSR_GPSR(IP1SR2_7_4,	CAN_CLK),
 	PINMUX_IPSR_GPSR(IP1SR2_7_4,	FXR_TXENA_N_B),
@@ -929,12 +929,12 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP1SR2_19_16,	CANFD2_TX),
 	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TPU0TO2),
-	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TCLK3_A),
+	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TCLK3_C),
 
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	CANFD2_RX),
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TPU0TO3),
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	PWM1_B),
-	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TCLK4_A),
+	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TCLK4_C),
 
 	PINMUX_IPSR_GPSR(IP1SR2_27_24,	CANFD3_TX),
 	PINMUX_IPSR_GPSR(IP1SR2_27_24,	PWM2),
@@ -979,12 +979,12 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR3_23_20,	IPC_CLKIN),
 	PINMUX_IPSR_GPSR(IP1SR3_23_20,	IPC_CLKEN_IN),
 	PINMUX_IPSR_GPSR(IP1SR3_23_20,	PWM1_A),
-	PINMUX_IPSR_GPSR(IP1SR3_23_20,	TCLK3_X),
+	PINMUX_IPSR_GPSR(IP1SR3_23_20,	TCLK3_A),
 
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	IPC_CLKOUT),
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	IPC_CLKEN_OUT),
 	PINMUX_IPSR_GPSR(IP1SR3_27_24,	ERROROUTC_N_A),
-	PINMUX_IPSR_GPSR(IP1SR3_27_24,	TCLK4_X),
+	PINMUX_IPSR_GPSR(IP1SR3_27_24,	TCLK4_A),
 
 	PINMUX_IPSR_GPSR(IP1SR3_31_28,	QSPI0_SSL),
 
-- 
2.43.0




