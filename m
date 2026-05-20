Return-Path: <stable+bounces-250594-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO4gBB/oDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250594-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:58:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84112592B6D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9D63309EE17
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C206375ACB;
	Wed, 20 May 2026 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F22tG9L1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110F136B059;
	Wed, 20 May 2026 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295820; cv=none; b=C1xYMkRK0OpEam2qrgqU+yz/5UFe+fFySrsHSO9TyL0r3TZzb/hQvk34rpwAzH0EWx0cHJBtFN9L/V6nZ2Nzwowx88kUsgs/EmI06crG0kgDuZxBBRARlfTZYLf1R6kc5UYRjGaWwUkyRZtZtfGL5s1eQUoj7HEywkHAv3LLLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295820; c=relaxed/simple;
	bh=jLvOhx0hntoNisHc6uuStrOneyJRjdfkI2yRjf01j98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8ypZrvUJxDdev9GCvsXyx7jHSm7CRKmUuFp1VvzmI8O0/tQ5va4crIRLL1idjyMUVrRJsO5TNFH5KhZDYRPLHQ8AF6mVKNMnnc1cqbJAGetZYLsJgs7djqgWz4VY32tBthq/hUj2rTNNxTrtUHrCrGVBWpWF7MezlKiaiWverw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F22tG9L1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774851F000E9;
	Wed, 20 May 2026 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295819;
	bh=MtI0YBTeg8Hrn4UbArBeR7uIBK4MVVCfgvQ201/3/Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F22tG9L1QU/xxIeRQEMXXd/yay9avNwh1OCwc5aYQGas1nT4geRSO/1lJblGCPS0E
	 oiID+4KJNV2zA7xBh1Sl3cBSYsZI/kWbVeJPu1YuoucEIu4Gcal/coXj9YHg/lsxr6
	 ThbYQVb3fRmYw4zamWjO4/gkWKGK8fnE0Fvv7V3s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0523/1146] arm64: dts: qcom: sm8550: Fix xo clock supply of platform SD host controller
Date: Wed, 20 May 2026 18:12:53 +0200
Message-ID: <20260520162200.018674171@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250594-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,0.134.86.160:email]
X-Rspamd-Queue-Id: 84112592B6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 30ac651c69bddbc83cab6d52fc5d2e03bed83282 ]

The expected frequency of SD host controller core supply clock is 19.2MHz,
while RPMH_CXO_CLK clock frequency on SM8650 platform is 38.4MHz.

Apparently the overclocked supply clock could be good enough on some
boards and even with the most of SD cards, however some low-end UHS-I
SD cards in SDR104 mode of the host controller produce I/O errors in
runtime, fortunately this problem is gone, if the "xo" clock frequency
matches the expected 19.2MHz clock rate.

Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20260314023715.357512-2-vladimir.zapolskiy@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 1f088219b2dae..a23f01ebe45d3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3210,7 +3210,7 @@ sdhc_2: mmc@8804000 {
 
 			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>;
+				 <&bi_tcxo_div2>;
 			clock-names = "iface", "core", "xo";
 			iommus = <&apps_smmu 0x540 0>;
 			qcom,dll-config = <0x0007642c>;
-- 
2.53.0




