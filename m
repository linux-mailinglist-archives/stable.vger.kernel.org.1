Return-Path: <stable+bounces-63874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C44941B0D
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D6A01C23297
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22B18801C;
	Tue, 30 Jul 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zMBVBbK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DF9188013;
	Tue, 30 Jul 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358230; cv=none; b=Xw9flTwEwcL5FfYl6DgvNJ9NjXmg5fOjInyFVPLsinSWQkjhAIdQ51CPhBXqAIwZm3XhTy89Q4Vqiz6jaeTNoSFkWoCOnML4WTdo2+HDxBBjoheOme75lkdRmdZu9bKazm2F6iB/E6vdIELH0pyShvrjkWpELTW37g76fDd63L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358230; c=relaxed/simple;
	bh=W3FDE2GdhYErqV0V4nWFN+/55Mt1Qudw4PzZaxdM5Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmCVCt+509+sfuETlqT/1nBsGKMSP/3Dw0z4KFWwWpSPw4+5cTR+1eZL6FMhAx3qWjjkRCqrTkV+OVxF1QzCclnqX6X5nEFz2PzJnYmxGfMoeHkO31dQsZUptmf7BaAmqw3GDFoMeqpzkWdoiKSAv2bS+zlZ7cJerERF/PCN9bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zMBVBbK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E4FC32782;
	Tue, 30 Jul 2024 16:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358230;
	bh=W3FDE2GdhYErqV0V4nWFN+/55Mt1Qudw4PzZaxdM5Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zMBVBbK19iI7YcNTbNKDJIAJowfF7kHzwLHZNsoeDZQr3ib5r/crHYL5PFZr6mOHt
	 1fg7D6ZI8ccMfQ+Nz9Z0v/pBwGXXJUAPtZHORWqZtYXnEQrafezqBu4f2xJ0TJP5EB
	 u6cnw9FAvWEEyRgku7P7KKWjAe5adXnsmsHph0Qg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 342/568] pinctrl: renesas: r8a779g0: Fix TPU suffixes
Date: Tue, 30 Jul 2024 17:47:29 +0200
Message-ID: <20240730151653.236511749@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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
index 8c19b892441a3..bb843e333c880 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -119,8 +119,8 @@
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
@@ -332,29 +332,29 @@
 
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
 
@@ -871,12 +871,12 @@ static const u16 pinmux_data[] = {
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
@@ -889,11 +889,11 @@ static const u16 pinmux_data[] = {
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
@@ -909,12 +909,12 @@ static const u16 pinmux_data[] = {
 
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
 
@@ -928,11 +928,11 @@ static const u16 pinmux_data[] = {
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
 
@@ -2403,64 +2403,63 @@ static const unsigned int ssi_ctrl_mux[] = {
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
@@ -2702,14 +2701,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
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
@@ -3020,15 +3019,14 @@ static const char * const ssi_groups[] = {
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




