Return-Path: <stable+bounces-63518-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C64B94195C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD37F28688C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40E2183CDB;
	Tue, 30 Jul 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QMvzdjP2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF391A6192;
	Tue, 30 Jul 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357088; cv=none; b=RYm7WmBeYIqA41ZO45OjS6J7nJiltVlaz1dZvBVahBBNJOUY5GemLadv37VsStAYMKIzmEwoFmNLdPBIZ4ekgEwxMQ93NZoG+1okwumYfmIFSBv2LQvYEXjuKXQod8L8k0xrGBLpeAUAZ2i6A33M24TQOPJsas8YXVN45Hnh2dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357088; c=relaxed/simple;
	bh=RgqRFVSsMa2wnLQRRubgmXSAGuEvxrlQ4Z3LSC+pUWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9FjGm1IM+y8kJEGEDDJBEwOzfo/FvcATI2TZVfKhCCLca0iicM8+cwt6ozoA+C+bGPS3cCC8NdqF8PkKztHSg5NAg3JTa+FqVT6/XVQk2nQ6gs5viUST9dRcePVD+oUbBKmYdygHZfP0Ik1Ck5urVn+e/z8tyJVfVFoKIEdSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QMvzdjP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2D6C32782;
	Tue, 30 Jul 2024 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722357087;
	bh=RgqRFVSsMa2wnLQRRubgmXSAGuEvxrlQ4Z3LSC+pUWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMvzdjP23JcCjTFROA1Mh0PmN+BNsgSEVsCH8hVEa755ASFwOmvHmr20IUX9D/7K/
	 yVhRGGSvEEgZhYM9E44Xj2KyjSLszAqqMouySozImc8Pycld3cSqQ2G17FJYYGD0zo
	 aJWUjRwR8hCAxbsDL5vUat54LkeN7YGV9dXXh36c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 257/440] pinctrl: renesas: r8a779g0: FIX PWM suffixes
Date: Tue, 30 Jul 2024 17:48:10 +0200
Message-ID: <20240730151625.883742465@linuxfoundation.org>
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

[ Upstream commit 0aabdc9a4d3644fd57d804b283b2ab0f9c28dc6c ]

PWM channels 0, 2, 8, and 9 do not have alternate pins.
Remove their "_a" or "_b" suffixes to increase uniformity.

Fixes: c606c2fde2330547 ("pinctrl: renesas: r8a779g0: Add missing PWM")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/abb748e6e1e4e7d78beac7d96e7a0a3481b32e75.1717754960.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 76 ++++++++++++--------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index c4086f301cfc6..f0c85192c5db5 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -310,9 +310,9 @@
 #define IP1SR1_11_8	FM(MSIOF0_SCK)		FM(HSCK1_B)		FM(SCK1_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR1_15_12	FM(MSIOF0_RXD)		F_(0, 0)		F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR1_19_16	FM(HTX0)		FM(TX0)			F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_23_20	FM(HCTS0_N)		FM(CTS0_N)		FM(PWM8_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_27_24	FM(HRTS0_N)		FM(RTS0_N)		FM(PWM9_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR1_31_28	FM(HSCK0)		FM(SCK0)		FM(PWM0_A)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_23_20	FM(HCTS0_N)		FM(CTS0_N)		FM(PWM8)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_27_24	FM(HRTS0_N)		FM(RTS0_N)		FM(PWM9)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR1_31_28	FM(HSCK0)		FM(SCK0)		FM(PWM0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP2SR1 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
 #define IP2SR1_3_0	FM(HRX0)		FM(RX0)			F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
@@ -349,7 +349,7 @@
 #define IP1SR2_15_12	FM(CANFD0_RX)		FM(STPWT_EXTFXR)	F_(0, 0)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_19_16	FM(CANFD2_TX)		FM(TPU0TO2)		F_(0, 0)		FM(TCLK3_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_23_20	FM(CANFD2_RX)		FM(TPU0TO3)		FM(PWM1_B)		FM(TCLK4_A)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP1SR2_27_24	FM(CANFD3_TX)		F_(0, 0)		FM(PWM2)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP1SR2_31_28	FM(CANFD3_RX)		F_(0, 0)		FM(PWM3_B)		F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP2SR2 */		/* 0 */			/* 1 */			/* 2 */			/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -821,15 +821,15 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP1SR1_23_20,	HCTS0_N),
 	PINMUX_IPSR_GPSR(IP1SR1_23_20,	CTS0_N),
-	PINMUX_IPSR_GPSR(IP1SR1_23_20,	PWM8_A),
+	PINMUX_IPSR_GPSR(IP1SR1_23_20,	PWM8),
 
 	PINMUX_IPSR_GPSR(IP1SR1_27_24,	HRTS0_N),
 	PINMUX_IPSR_GPSR(IP1SR1_27_24,	RTS0_N),
-	PINMUX_IPSR_GPSR(IP1SR1_27_24,	PWM9_A),
+	PINMUX_IPSR_GPSR(IP1SR1_27_24,	PWM9),
 
 	PINMUX_IPSR_GPSR(IP1SR1_31_28,	HSCK0),
 	PINMUX_IPSR_GPSR(IP1SR1_31_28,	SCK0),
-	PINMUX_IPSR_GPSR(IP1SR1_31_28,	PWM0_A),
+	PINMUX_IPSR_GPSR(IP1SR1_31_28,	PWM0),
 
 	/* IP2SR1 */
 	PINMUX_IPSR_GPSR(IP2SR1_3_0,	HRX0),
@@ -931,7 +931,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_GPSR(IP1SR2_23_20,	TCLK4_A),
 
 	PINMUX_IPSR_GPSR(IP1SR2_27_24,	CANFD3_TX),
-	PINMUX_IPSR_GPSR(IP1SR2_27_24,	PWM2_B),
+	PINMUX_IPSR_GPSR(IP1SR2_27_24,	PWM2),
 
 	PINMUX_IPSR_GPSR(IP1SR2_31_28,	CANFD3_RX),
 	PINMUX_IPSR_GPSR(IP1SR2_31_28,	PWM3_B),
@@ -2066,13 +2066,13 @@ static const unsigned int pcie1_clkreq_n_mux[] = {
 	PCIE1_CLKREQ_N_MARK,
 };
 
-/* - PWM0_A ------------------------------------------------------------------- */
-static const unsigned int pwm0_a_pins[] = {
-	/* PWM0_A */
+/* - PWM0 ------------------------------------------------------------------- */
+static const unsigned int pwm0_pins[] = {
+	/* PWM0 */
 	RCAR_GP_PIN(1, 15),
 };
-static const unsigned int pwm0_a_mux[] = {
-	PWM0_A_MARK,
+static const unsigned int pwm0_mux[] = {
+	PWM0_MARK,
 };
 
 /* - PWM1_A ------------------------------------------------------------------- */
@@ -2093,13 +2093,13 @@ static const unsigned int pwm1_b_mux[] = {
 	PWM1_B_MARK,
 };
 
-/* - PWM2_B ------------------------------------------------------------------- */
-static const unsigned int pwm2_b_pins[] = {
-	/* PWM2_B */
+/* - PWM2 ------------------------------------------------------------------- */
+static const unsigned int pwm2_pins[] = {
+	/* PWM2 */
 	RCAR_GP_PIN(2, 14),
 };
-static const unsigned int pwm2_b_mux[] = {
-	PWM2_B_MARK,
+static const unsigned int pwm2_mux[] = {
+	PWM2_MARK,
 };
 
 /* - PWM3_A ------------------------------------------------------------------- */
@@ -2156,22 +2156,22 @@ static const unsigned int pwm7_mux[] = {
 	PWM7_MARK,
 };
 
-/* - PWM8_A ------------------------------------------------------------------- */
-static const unsigned int pwm8_a_pins[] = {
-	/* PWM8_A */
+/* - PWM8 ------------------------------------------------------------------- */
+static const unsigned int pwm8_pins[] = {
+	/* PWM8 */
 	RCAR_GP_PIN(1, 13),
 };
-static const unsigned int pwm8_a_mux[] = {
-	PWM8_A_MARK,
+static const unsigned int pwm8_mux[] = {
+	PWM8_MARK,
 };
 
-/* - PWM9_A ------------------------------------------------------------------- */
-static const unsigned int pwm9_a_pins[] = {
-	/* PWM9_A */
+/* - PWM9 ------------------------------------------------------------------- */
+static const unsigned int pwm9_pins[] = {
+	/* PWM9 */
 	RCAR_GP_PIN(1, 14),
 };
-static const unsigned int pwm9_a_mux[] = {
-	PWM9_A_MARK,
+static const unsigned int pwm9_mux[] = {
+	PWM9_MARK,
 };
 
 /* - QSPI0 ------------------------------------------------------------------ */
@@ -2631,18 +2631,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(pcie0_clkreq_n),
 	SH_PFC_PIN_GROUP(pcie1_clkreq_n),
 
-	SH_PFC_PIN_GROUP(pwm0_a),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(pwm0),
 	SH_PFC_PIN_GROUP(pwm1_a),
 	SH_PFC_PIN_GROUP(pwm1_b),
-	SH_PFC_PIN_GROUP(pwm2_b),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(pwm2),
 	SH_PFC_PIN_GROUP(pwm3_a),
 	SH_PFC_PIN_GROUP(pwm3_b),
 	SH_PFC_PIN_GROUP(pwm4),
 	SH_PFC_PIN_GROUP(pwm5),
 	SH_PFC_PIN_GROUP(pwm6),
 	SH_PFC_PIN_GROUP(pwm7),
-	SH_PFC_PIN_GROUP(pwm8_a),		/* suffix might be updated */
-	SH_PFC_PIN_GROUP(pwm9_a),		/* suffix might be updated */
+	SH_PFC_PIN_GROUP(pwm8),
+	SH_PFC_PIN_GROUP(pwm9),
 
 	SH_PFC_PIN_GROUP(qspi0_ctrl),
 	BUS_DATA_PIN_GROUP(qspi0_data, 2),
@@ -2891,8 +2891,7 @@ static const char * const pcie_groups[] = {
 };
 
 static const char * const pwm0_groups[] = {
-	/* suffix might be updated */
-	"pwm0_a",
+	"pwm0",
 };
 
 static const char * const pwm1_groups[] = {
@@ -2901,8 +2900,7 @@ static const char * const pwm1_groups[] = {
 };
 
 static const char * const pwm2_groups[] = {
-	/* suffix might be updated */
-	"pwm2_b",
+	"pwm2",
 };
 
 static const char * const pwm3_groups[] = {
@@ -2927,13 +2925,11 @@ static const char * const pwm7_groups[] = {
 };
 
 static const char * const pwm8_groups[] = {
-	/* suffix might be updated */
-	"pwm8_a",
+	"pwm8",
 };
 
 static const char * const pwm9_groups[] = {
-	/* suffix might be updated */
-	"pwm9_a",
+	"pwm9",
 };
 
 static const char * const qspi0_groups[] = {
-- 
2.43.0




