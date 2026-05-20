Return-Path: <stable+bounces-251606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHobOKTyDWrA4wUAu9opvQ
	(envelope-from <stable+bounces-251606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938C594608
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD31F30948D3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E5A369D7E;
	Wed, 20 May 2026 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9J/BJkB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C3359A6F;
	Wed, 20 May 2026 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298419; cv=none; b=pqu6kmusy5LEbc/ph/Cbge90BCLRzkAxwuzJ6YtLePGapoSBvbvNxQO6eJfmIvW7KkOvqIuB2Z15fvb2MJD30Q3RghIn3VaN5idk2k7H7ZKJuR7kb35d7FrR1Wa+HZz4ijdz+H6tMyChP+Fv2bK5ZU1OJF5hc4yPR+M5632xmCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298419; c=relaxed/simple;
	bh=43BNf40EsYzBx3OErDkmDxpb7bYxFyHanzpgbQtb5cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRFxWUUkXIbhWe9MrXvG6Ewy2d6CLbRN4uBwGMUogDRBgZI+1UsAmQS8IKk4NJjyps8GQlBxGdx6aLYl7uLoIl30HS8SBE4hL7fsbgBYQt0XDLr4/+em5+h5uT0RsYgZyVfWdvGau4C4xyl4Vdk97UXQIlIXHAHTByOubzBkINQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9J/BJkB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACCF1F000E9;
	Wed, 20 May 2026 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298418;
	bh=xRvGiDChxOfpVfwFmtGrir/S4yBmiBYwVDHlHrzl04M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u9J/BJkBWbdDNwRBGMsNDvOXhu3sa2FDV5t8fPjWoVstqSP1Z/h4rXR/nzSy/H272
	 A0yQd1J1y6GPm/Id6jx701/cendy5+u92bzxZxWwY3TclGOvAXRStNjGInpmrdE5Kk
	 htSXByY51dIpRSdaqapyk9zKX8RJ4oJjRGkqyhJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 404/957] arm64: dts: qcom: sm8550: Fix xo clock supply of platform SD host controller
Date: Wed, 20 May 2026 18:14:47 +0200
Message-ID: <20260520162143.285766492@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-251606-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linaro.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0.134.86.160:email]
X-Rspamd-Queue-Id: 5938C594608
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index c9a781273e842..002ed12f942c0 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3175,7 +3175,7 @@ sdhc_2: mmc@8804000 {
 
 			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
 				 <&gcc GCC_SDCC2_APPS_CLK>,
-				 <&rpmhcc RPMH_CXO_CLK>;
+				 <&bi_tcxo_div2>;
 			clock-names = "iface", "core", "xo";
 			iommus = <&apps_smmu 0x540 0>;
 			qcom,dll-config = <0x0007642c>;
-- 
2.53.0




