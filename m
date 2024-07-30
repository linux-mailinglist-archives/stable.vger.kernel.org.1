Return-Path: <stable+bounces-63525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88581941965
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBAE1C23636
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14930183CD5;
	Tue, 30 Jul 2024 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GzAYUW8n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FAE8BE8;
	Tue, 30 Jul 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357107; cv=none; b=gtgYRs/DjXNpqHCaw3ZrZWDoos5Jbw+tsDce3Guda5GwfOEvA4eKmtPzx7HcjwsvdoSNm8o0XppBeU3QuX0KRt3pdgZWzChy1iRXK24C7qnaCWVhmBa3lM1jpaXpqXMfHHK6pm/P1bUZuM+ZjdqlvIvcKNjOkkqAt7Y5PEw+Hqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357107; c=relaxed/simple;
	bh=r6TCM3eK1McQn777C2V2oQa5MIzZgGI8ni6SHVC3Ts0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtjiInrWpYFkvpx55OWEHBrKy7E08J8wLAOCO5osPnR28mv2tGifNIMKQlXTa1g52L0fiTk0ewn8+54T2GDTW7yFiv86xhH/LrpvuPKogNPytWcNO0Q+XPNgnLUsxzOK9NQXd42rAIXUpYJU+EeCYL6CIX8VBS6sOBjF2PgLPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GzAYUW8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4EBC32782;
	Tue, 30 Jul 2024 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357107;
	bh=r6TCM3eK1McQn777C2V2oQa5MIzZgGI8ni6SHVC3Ts0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzAYUW8nD78x3IDq2C+e++h6KHfsRrYBfoDE5vzkQt9fGTX5gPn9pYUj8+8O+THGm
	 KlPze8vjLbQ5qUGJljVwXMttEDhFbNglfy+DUiHRufCPYVr+gtptsBijVeznY58oWJ
	 aoAEuxUC+I8jQxl+vQsJHmaeiUXnEtoel28ObFpk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 259/440] pinctrl: renesas: r8a779g0: Fix TPU suffixes
Date: Tue, 30 Jul 2024 17:48:12 +0200
Message-ID: <20240730151625.959648144@linuxfoundation.org>
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

[ Upstream commit 3d144ef10a448f89065dcff39c40d90ac18e035e ]

The Timer Pulse Unit channels have two alternate pin groups:
"tpu_to[0-3]" and "tpu_to[0-3]_a".

Increase uniformity by adopting R-Car V4M naming:
  - Rename "tpu_to[0-3]_a" to "tpu_to[0-3]_b",
  - Rename "tpu_to[0-3]" to "tpu_to[0-3]_a",

Fixes: ad9bb2fec66262b0 ("pinctrl: renesas: Initial R8A779G0 (R-Car V4H) PFC support")
Fixes: 050442ae4c74f830 ("pinctrl: renesas: r8a779g0: Add pins, groups and functions")
Fixes: 85a9cbe4c57bb958 ("pinctrl: renesas: r8a779g0: Add missing TPU0TOx_A")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/0dd9428bc24e97e1001ed3976b1cb98966f5e7e3.1717754960.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 128 ++++++++++++-------------
 1 file changed, 63 insertions(+), 65 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index 27a2db38aa69c..595a5a4b02ecb 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -113,8 +113,8 @@
 #define GPSR2_11	F_(CANFD0_RX,		IP1SR2_15_12)
 #define GPSR2_10	F_(CANFD0_TX,		IP1SR2_11_8)
 #define GPSR2_9		F_(CAN_CLK,		IP1SR2_7_4)
-#define GPSR2_8		F_(TPU0TO0,		IP1SR2_3_0)
-#define GPSR2_7		F_(TPU0TO1,		IP0SR2_31_28)
+#define GPSR2_8		F_(TPU0TO0_A,		IP1SR2_3_0)
+#define GPSR2_7		F_(TPU0TO1_A,		IP0SR2_31_28)
 #define GPSR2_6		F_(FXR_TXDB,		IP0SR2_27_24)
 #define GPSR2_5		F_(FXR_TXENB_N_A,	IP0SR2_23_20)
 #define GPSR2_4		F_(RXDB_EXTFXR,		IP0SR2_19_16)
@@ -326,29 +326,29 @@
 
 /* IP3SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
 #define IP3SR1_3_0	FM(HRX3_A)		FM(SCK3_A)		FM(MSIOF4_SS2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_7_4	FM(HSCK3_A)		FM(CTS3_N_A)		FM(MSIOF4_SCK)		FM(TPU0TO0_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP3SR1_11_8	FM(HRTS3_N_A)		FM(RTS3_N_A)		FM(MSIOF4_TXD)		FM(TPU0TO1_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_7_4	FM(HSCK3_A)		FM(CTS3_N_A)		FM(MSIOF4_SCK)		FM(TPU0TO0_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP3SR1_11_8	FM(HRTS3_N_A)		FM(RTS3_N_A)		FM(MSIOF4_TXD)		FM(TPU0TO1_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3SR1_15_12	FM(HCTS3_N_A)		FM(RX3_A)		FM(MSIOF4_RXD)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP3SR1_19_16	FM(HTX3_A)		FM(TX3_A)		FM(MSIOF4_SYNC)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* SR2 */
 /* IP0SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP0SR2_3_0	FM(FXR_TXDA)		FM(CANFD1_TX)		FM(TPU0TO2_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_7_4	FM(FXR_TXENA_N_A)	FM(CANFD1_RX)		FM(TPU0TO3_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_3_0	FM(FXR_TXDA)		FM(CANFD1_TX)		FM(TPU0TO2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_7_4	FM(FXR_TXENA_N_A)	FM(CANFD1_RX)		FM(TPU0TO3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_11_8	FM(RXDA_EXTFXR)		FM(CANFD5_TX_A)		FM(IRQ5)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_15_12	FM(CLK_EXTFXR)		FM(CANFD5_RX_A)		FM(IRQ4_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_19_16	FM(RXDB_EXTFXR)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_23_20	FM(FXR_TXENB_N_A)	F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR2_27_24	FM(FXR_TXDB)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR2_31_28	FM(TPU0TO1)		FM(CANFD6_TX)		F_(0, 0)		FM(TCLK2_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR2_31_28	FM(TPU0TO1_A)		FM(CANFD6_TX)		F_(0, 0)		FM(TCLK2_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
-#define IP1SR2_3_0	FM(TPU0TO0)		FM(CANFD6_RX)		F_(0, 0)		FM(TCLK1_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_3_0	FM(TPU0TO0_A)		FM(CANFD6_RX)		F_(0, 0)		FM(TCLK1_B)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_7_4	FM(CAN_CLK)		FM(FXR_TXENA_N_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_11_8	FM(CANFD0_TX)		FM(FXR_TXENB_N_B)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_15_12	FM(CANFD0_RX)		FM(STPWT_EXTFXR)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2)		F_(0, 0)		FM(TCLK3_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3)		FM(PWM1_B)		FM(TCLK4_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2_A)		F_(0, 0)		FM(TCLK3_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3_A)		FM(PWM1_B)		FM(TCLK4_C)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_31_28	FM(CANFD3_RX)		F_(0, 0)		FM(PWM3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
@@ -865,12 +865,12 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP3SR1_7_4,	HSCK3_A),
 	PINMUX_IPSR_GPSR(IP3SR1_7_4,	CTS3_N_A),
 	PINMUX_IPSR_GPSR(IP3SR1_7_4,	MSIOF4_SCK),
-	PINMUX_IPSR_GPSR(IP3SR1_7_4,	TPU0TO0_A),
+	PINMUX_IPSR_GPSR(IP3SR1_7_4,	TPU0TO0_B),
 
 	PINMUX_IPSR_GPSR(IP3SR1_11_8,	HRTS3_N_A),
 	PINMUX_IPSR_GPSR(IP3SR1_11_8,	RTS3_N_A),
 	PINMUX_IPSR_GPSR(IP3SR1_11_8,	MSIOF4_TXD),
-	PINMUX_IPSR_GPSR(IP3SR1_11_8,	TPU0TO1_A),
+	PINMUX_IPSR_GPSR(IP3SR1_11_8,	TPU0TO1_B),
 
 	PINMUX_IPSR_GPSR(IP3SR1_15_12,	HCTS3_N_A),
 	PINMUX_IPSR_GPSR(IP3SR1_15_12,	RX3_A),
@@ -883,11 +883,11 @@ static const u16 pinmux_data[] = {
 	/* IP0SR2 */
 	PINMUX_IPSR_GPSR(IP0SR2_3_0,	FXR_TXDA),
 	PINMUX_IPSR_GPSR(IP0SR2_3_0,	CANFD1_TX),
-	PINMUX_IPSR_GPSR(IP0SR2_3_0,	TPU0TO2_A),
+	PINMUX_IPSR_GPSR(IP0SR2_3_0,	TPU0TO2_B),
 
 	PINMUX_IPSR_GPSR(IP0SR2_7_4,	FXR_TXENA_N_A),
 	PINMUX_IPSR_GPSR(IP0SR2_7_4,	CANFD1_RX),
-	PINMUX_IPSR_GPSR(IP0SR2_7_4,	TPU0TO3_A),
+	PINMUX_IPSR_GPSR(IP0SR2_7_4,	TPU0TO3_B),
 
 	PINMUX_IPSR_GPSR(IP0SR2_11_8,	RXDA_EXTFXR),
 	PINMUX_IPSR_GPSR(IP0SR2_11_8,	CANFD5_TX_A),
@@ -903,12 +903,12 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP0SR2_27_24,	FXR_TXDB),
 
-	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TPU0TO1),
+	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TPU0TO1_A),
 	PINMUX_IPSR_GPSR(IP0SR2_31_28,	CANFD6_TX),
 	PINMUX_IPSR_GPSR(IP0SR2_31_28,	TCLK2_C),
 
 	/* IP1SR2 */
-	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TPU0TO0),
+	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TPU0TO0_A),
 	PINMUX_IPSR_GPSR(IP1SR2_3_0,	CANFD6_RX),
 	PINMUX_IPSR_GPSR(IP1SR2_3_0,	TCLK1_B),
 
@@ -922,11 +922,11 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR2_15_12,	STPWT_EXTFXR),
 
 	PINMUX_IPSR_GPSR(IP1SR2_19_16,	CANFD2_TX),
-	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TPU0TO2),
+	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TPU0TO2_A),
 	PINMUX_IPSR_GPSR(IP1SR2_19_16,	TCLK3_C),
 
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	CANFD2_RX),
-	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TPU0TO3),
+	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TPU0TO3_A),
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	PWM1_B),
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TCLK4_C),
 
@@ -2379,64 +2379,63 @@ static const unsigned int ssi_ctrl_mux[] = {
 	SSI_SCK_MARK, SSI_WS_MARK,
 };
 
-/* - TPU ------------------------------------------------------------------- */
-static const unsigned int tpu_to0_pins[] = {
-	/* TPU0TO0 */
+/* - TPU -------------------------------------------------------------------- */
+static const unsigned int tpu_to0_a_pins[] = {
+	/* TPU0TO0_A */
 	RCAR_GP_PIN(2, 8),
 };
-static const unsigned int tpu_to0_mux[] = {
-	TPU0TO0_MARK,
+static const unsigned int tpu_to0_a_mux[] = {
+	TPU0TO0_A_MARK,
 };
-static const unsigned int tpu_to1_pins[] = {
-	/* TPU0TO1 */
+static const unsigned int tpu_to1_a_pins[] = {
+	/* TPU0TO1_A */
 	RCAR_GP_PIN(2, 7),
 };
-static const unsigned int tpu_to1_mux[] = {
-	TPU0TO1_MARK,
+static const unsigned int tpu_to1_a_mux[] = {
+	TPU0TO1_A_MARK,
 };
-static const unsigned int tpu_to2_pins[] = {
-	/* TPU0TO2 */
+static const unsigned int tpu_to2_a_pins[] = {
+	/* TPU0TO2_A */
 	RCAR_GP_PIN(2, 12),
 };
-static const unsigned int tpu_to2_mux[] = {
-	TPU0TO2_MARK,
+static const unsigned int tpu_to2_a_mux[] = {
+	TPU0TO2_A_MARK,
 };
-static const unsigned int tpu_to3_pins[] = {
-	/* TPU0TO3 */
+static const unsigned int tpu_to3_a_pins[] = {
+	/* TPU0TO3_A */
 	RCAR_GP_PIN(2, 13),
 };
-static const unsigned int tpu_to3_mux[] = {
-	TPU0TO3_MARK,
+static const unsigned int tpu_to3_a_mux[] = {
+	TPU0TO3_A_MARK,
 };
 
-/* - TPU_A ------------------------------------------------------------------- */
-static const unsigned int tpu_to0_a_pins[] = {
-	/* TPU0TO0_A */
+static const unsigned int tpu_to0_b_pins[] = {
+	/* TPU0TO0_B */
 	RCAR_GP_PIN(1, 25),
 };
-static const unsigned int tpu_to0_a_mux[] = {
-	TPU0TO0_A_MARK,
+static const unsigned int tpu_to0_b_mux[] = {
+	TPU0TO0_B_MARK,
 };
-static const unsigned int tpu_to1_a_pins[] = {
-	/* TPU0TO1_A */
+static const unsigned int tpu_to1_b_pins[] = {
+	/* TPU0TO1_B */
 	RCAR_GP_PIN(1, 26),
 };
-static const unsigned int tpu_to1_a_mux[] = {
-	TPU0TO1_A_MARK,
+static const unsigned int tpu_to1_b_mux[] = {
+	TPU0TO1_B_MARK,
 };
-static const unsigned int tpu_to2_a_pins[] = {
-	/* TPU0TO2_A */
+static const unsigned int tpu_to2_b_pins[] = {
+	/* TPU0TO2_B */
 	RCAR_GP_PIN(2, 0),
 };
-static const unsigned int tpu_to2_a_mux[] = {
-	TPU0TO2_A_MARK,
+static const unsigned int tpu_to2_b_mux[] = {
+	TPU0TO2_B_MARK,
 };
-static const unsigned int tpu_to3_a_pins[] = {
-	/* TPU0TO3_A */
+static const unsigned int tpu_to3_b_pins[] = {
+	/* TPU0TO3_B */
 	RCAR_GP_PIN(2, 1),
 };
-static const unsigned int tpu_to3_a_mux[] = {
-	TPU0TO3_A_MARK,
+static const unsigned int tpu_to3_b_mux[] = {
+	TPU0TO3_B_MARK,
 };
 
 /* - TSN0 ------------------------------------------------ */
@@ -2675,14 +2674,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(ssi_data),
 	SH_PFC_PIN_GROUP(ssi_ctrl),
 
-	SH_PFC_PIN_GROUP(tpu_to0),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to0_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to1),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to1_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to2),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to2_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to3),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(tpu_to3_a),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(tpu_to0_a),
+	SH_PFC_PIN_GROUP(tpu_to0_b),
+	SH_PFC_PIN_GROUP(tpu_to1_a),
+	SH_PFC_PIN_GROUP(tpu_to1_b),
+	SH_PFC_PIN_GROUP(tpu_to2_a),
+	SH_PFC_PIN_GROUP(tpu_to2_b),
+	SH_PFC_PIN_GROUP(tpu_to3_a),
+	SH_PFC_PIN_GROUP(tpu_to3_b),
 
 	SH_PFC_PIN_GROUP(tsn0_link),
 	SH_PFC_PIN_GROUP(tsn0_phy_int),
@@ -2988,15 +2987,14 @@ static const char * const ssi_groups[] = {
 };
 
 static const char * const tpu_groups[] = {
-	/* suffix might be updated */
-	"tpu_to0",
 	"tpu_to0_a",
-	"tpu_to1",
+	"tpu_to0_b",
 	"tpu_to1_a",
-	"tpu_to2",
+	"tpu_to1_b",
 	"tpu_to2_a",
-	"tpu_to3",
+	"tpu_to2_b",
 	"tpu_to3_a",
+	"tpu_to3_b",
 };
 
 static const char * const tsn0_groups[] = {
-- 
2.43.0




