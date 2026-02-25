Return-Path: <stable+bounces-218198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sORAL0JRnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0B18EF53
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B119B305B01C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECB421D596;
	Wed, 25 Feb 2026 01:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYIRL+AK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63552505B2;
	Wed, 25 Feb 2026 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982989; cv=none; b=UuyL9QwCLNIcZkLArlCvr15XeAjshCj7wZDkA4Sy7GM6gieiddrr++KTpN9zNGbsifNoHrcrrw/3UoPDfv1qHjtlKBV2pMIVi2MlfEEb3XmRnt6bX4zj30e3crPgkOhvQyF+7IPdlMnpwyc/qUh20+QREDHZYTTh6wD+eSCGYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982989; c=relaxed/simple;
	bh=u83FIqNIic9TDvbFFppWJGjBX6vx80rk/Q2/PqR9r9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z/2KUjKpvjrf0UHdoJj9xlheSBMfqOZx+wS3DYmDs+KduAXBzoxIGZutOpXsTZsGcNVoDjGtzoZUO5eELDTSzNSZbMu9XZKyYc6YO0PAgTMUHBVr4HSYy5VjG0Ssnp3YaV2UOBdnw38rWbpGNJ9lNfCmtOkmqRIZ5TPCh+V5NLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SYIRL+AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1667C116D0;
	Wed, 25 Feb 2026 01:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982988;
	bh=u83FIqNIic9TDvbFFppWJGjBX6vx80rk/Q2/PqR9r9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYIRL+AKKkjmRhD4pkdCU/GaQvhOwB2YmiWG7X+j1XAGpEstFh6NV7NSUbLd9TA/k
	 vvBHuwlkrPcCq/X8MduBm4ULkqLt8GhZsi6VfxuS0Z36qieegTAByQT2pLa5Eu7Dz6
	 VccMq3YAzptNPkiSgrrjawG8LnS556wPTgIENqmY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abel Vesa <abel.vesa@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 158/781] arm64: dts: qcom: x1e80100: Fix USB combo PHYs SS1 and SS2 ref clocks
Date: Tue, 24 Feb 2026 17:14:27 -0800
Message-ID: <20260225012403.530494253@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-218198-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A9F0B18EF53
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abel Vesa <abel.vesa@linaro.org>

[ Upstream commit 3af51501e2b8c87564b5cda43b0e5c316cf54717 ]

It seems the USB combo SS1 and SS2 ref clocks have another gate, unlike
the SS0. These gates are part of the TCSR clock controller.

At least on Dell XPS 13 (9345), if the ref clock provided by the TCSR
clock controller for SS1 PHY is disabled on the clk_disable_unused late
initcall, the PHY fails to initialize. It doesn't happen on the SS0 PHY
and the SS2 is not used on this device.

This doesn't seem to be a problem on CRD though. It might be that the
RPMh has a vote for it from some other consumer and does not actually
disable it when ther kernel drops its vote.

Either way, these TCSR provided clocks seem to be the correct ones for
the SS1 and SS2, so use them instead.

Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Taniya Das <taniya.das@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251103-dts-qcom-x1e80100-fix-combo-ref-clks-v1-1-f395ec3cb7e8@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index a17900eacb203..9c9e567731556 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -2937,7 +2937,7 @@ usb_1_ss1_qmpphy: phy@fda000 {
 			reg = <0 0x00fda000 0 0x4000>;
 
 			clocks = <&gcc GCC_USB3_SEC_PHY_AUX_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&tcsr TCSR_USB4_1_CLKREF_EN>,
 				 <&gcc GCC_USB3_SEC_PHY_COM_AUX_CLK>,
 				 <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 			clock-names = "aux",
@@ -3008,7 +3008,7 @@ usb_1_ss2_qmpphy: phy@fdf000 {
 			reg = <0 0x00fdf000 0 0x4000>;
 
 			clocks = <&gcc GCC_USB3_TERT_PHY_AUX_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&tcsr TCSR_USB4_2_CLKREF_EN>,
 				 <&gcc GCC_USB3_TERT_PHY_COM_AUX_CLK>,
 				 <&gcc GCC_USB3_TERT_PHY_PIPE_CLK>;
 			clock-names = "aux",
-- 
2.51.0




