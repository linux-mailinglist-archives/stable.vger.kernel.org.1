Return-Path: <stable+bounces-258458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDtsN7wnG2qS/ggAu9opvQ
	(envelope-from <stable+bounces-258458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:09:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B861113F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C626C3025669
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31FC3AFCE3;
	Sat, 30 May 2026 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bKlv5Y5Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C937731E858;
	Sat, 30 May 2026 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164417; cv=none; b=jZYdEM9+Mkm8oWEHTSjLiStI4qJShox3zvHv+yHMESUFlCL4o8IutnwwxXRpIIWX9U62XZx8KduocpA51tFByXPcl7Sp8ceCi4208JYk5s0zBjxA3JzHPkZm1vPVZz0b+a5Iafz3PXyTxKeupuMOUAuU0wUiKFbMEyNn3Gj3Ai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164417; c=relaxed/simple;
	bh=N/UbdlyRkUe6BSVsSc7wcml2mm4QelgITZ4JvMvzkEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPX0OMjlFhgOQiELWgWDkVuSN+2wgV/ndwRg0QkLXo6RBbkrgPXPV675MzgfAzpw+Ui4nLbDcDJjYp0Al2rw7pKeWaDNAv/Kmw9fzWkDUxksB1ev47c6nxEE6H1fFvAeiXJaFXz/8zZEV7kxTburwe78ux5uizM7ZJDR5d/FlO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bKlv5Y5Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD7B1F00893;
	Sat, 30 May 2026 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164416;
	bh=izivYx5vMJJNCC+n+SiyzuqlhMIF9qwRTlDmmQwrnWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKlv5Y5ZQfWAv/F3myxDRZcroTdCvxPETmIZQ4YV3mu5D90DJwz9r1x3qafqCTmTT
	 VXOCl2CWRrT6HzwExt/lEggIuoehTUWzKxGwqxuPWpkHcKjpJaTGW3nixBsVeW/G8Z
	 j2ekQAlweNxF1SO8901+ipXrDFNU0CK7rCDpHyoE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Val Packett <val@packett.cool>
Subject: [PATCH 5.15 548/776] dt-bindings: clock: qcom,dispcc-sc7180: Define MDSS resets
Date: Sat, 30 May 2026 18:04:22 +0200
Message-ID: <20260530160254.328251759@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258458-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 359B861113F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit fc6e29d42872680dca017f2e5169eefe971f8d89 ]

The MDSS resets have so far been left undescribed. Fix that.

Fixes: 75616da71291 ("dt-bindings: clock: Introduce QCOM sc7180 display clock bindings")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Tested-by: Val Packett <val@packett.cool> # sc7180-ecs-liva-qc710
Link: https://lore.kernel.org/r/20260120-topic-7180_dispcc_bcr-v1-1-0b1b442156c3@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: b0bc6011c549 ("clk: qcom: dispcc-sc7180: Add missing MDSS resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/dt-bindings/clock/qcom,dispcc-sc7180.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/qcom,dispcc-sc7180.h b/include/dt-bindings/clock/qcom,dispcc-sc7180.h
index b9b51617a335d..0705103060748 100644
--- a/include/dt-bindings/clock/qcom,dispcc-sc7180.h
+++ b/include/dt-bindings/clock/qcom,dispcc-sc7180.h
@@ -6,6 +6,7 @@
 #ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_SC7180_H
 #define _DT_BINDINGS_CLK_QCOM_DISP_CC_SC7180_H
 
+/* Clocks */
 #define DISP_CC_PLL0				0
 #define DISP_CC_PLL0_OUT_EVEN			1
 #define DISP_CC_MDSS_AHB_CLK			2
@@ -40,7 +41,11 @@
 #define DISP_CC_MDSS_VSYNC_CLK_SRC		31
 #define DISP_CC_XO_CLK				32
 
-/* DISP_CC GDSCR */
+/* Resets */
+#define DISP_CC_MDSS_CORE_BCR			0
+#define DISP_CC_MDSS_RSCC_BCR			1
+
+/* GDSCs */
 #define MDSS_GDSC				0
 
 #endif
-- 
2.53.0




