Return-Path: <stable+bounces-252462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GH0zKA79DWru5AUAu9opvQ
	(envelope-from <stable+bounces-252462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:27:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43298596339
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2972F3175DF0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8213F88B8;
	Wed, 20 May 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="shWk1/cA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EB12F363F;
	Wed, 20 May 2026 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300736; cv=none; b=M/IPjvcGzx4w1L7e3H72ELlvSSzr7h/XmMEo8zZJkRL+wrq0LdKgAdAPr+6pIpnNWQv3PplT3Lp1gSPVKUMEyWfsuEfSQaIVjQaeKngj7D9L4OQkmJcDokTKmr3Stv5knVtfxLo7fLVWD8/xmMw8KPT6ebOETw0zyM73TU7R2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300736; c=relaxed/simple;
	bh=1EoOIwCPAPp9papE0WXkNIrE6BkCzfqwtByPFRnts2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+Q0hT3OfM4timEwVFDcgVKZVGbgN3Q/G3ASSoKOb1pGfxUUPsHmATFpn+coE7fJEON9Y0ylqL+J28XYGDRfIuFAwe3HRs695ImdKKLDoIZwbxSynC3HMsCBvR1RRBRwFCm+Ou6HnINQtRdHO6Z/OJX34gKVoxA95RR3Fpi/rqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=shWk1/cA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FCC1F000E9;
	Wed, 20 May 2026 18:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300735;
	bh=Sim9d2YL2xQxqlsEUfbaKMcFrEAz7/KMNm3tTT4k/Dw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=shWk1/cAjZsaJtV6htdB6uspAZYGrX3ZNFa4O/NYoR/SnpulBTrqOrh+2pzHoc6na
	 529+TrbZKagskExdvPa3gP1jGRe0Ul24zFjQuVSt8x5uKKof6IYq4RPonVBKQDvlxQ
	 kgu8cj5oFc06zLNtCzzoEJ5LuqOlnH2Shn44nwbo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 287/666] arm64: dts: qcom: sm8650: Fix xo clock supply of SD host controller
Date: Wed, 20 May 2026 18:18:18 +0200
Message-ID: <20260520162117.437284399@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252462-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,linaro.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,0.134.86.160:email]
X-Rspamd-Queue-Id: 43298596339
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 390903efaa057c44fd80e7d9839419c50092018e ]

The expected frequency of SD host controller core supply clock is 19.2MHz,
while RPMH_CXO_CLK clock frequency on SM8650 platform is 38.4MHz.

Apparently the overclocked supply clock could be good enough on some
boards and even with the most of SD cards, however some low-end UHS-I
SD cards in SDR104 mode of the host controller produce I/O errors in
runtime, fortunately this problem is gone, if the "xo" clock frequency
matches the expected 19.2MHz clock rate.

Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20260314023715.357512-3-vladimir.zapolskiy@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index d38d44438477f..72a75dec13c73 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -3423,7 +3423,7 @@ sdhc_2: mmc@8804000 {
 
 			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>;
+				 <&bi_tcxo_div2>;
 			clock-names = "iface",
 				      "core",
 				      "xo";
-- 
2.53.0




