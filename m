Return-Path: <stable+bounces-220631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGYMHUFBo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA21C6F9D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3387321C740
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8713EA5C8;
	Sat, 28 Feb 2026 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1NeDnzM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED9D3EA5BE;
	Sat, 28 Feb 2026 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300514; cv=none; b=cldNbRf+cuY26L3iZbRuYKHR9X4tS0/ykwwPvnc0Cas1Aa/wLG9xZ1WR8E1/ulxUihA4j7b2++WB0vueAqhyMJEpT3CiJphbTEUdYFmJcQNbTtZPCvUBdpW9cviluEkDhQ1gxdL1WGZCyxpLJ9RyZTYNnN3krJkhEhDX4rc/Q8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300514; c=relaxed/simple;
	bh=9TDccymzhbg0uNBI2s6j0V/aOaYjuZ7T4QGlrk/QbuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0LuS+qOCGIfFud5O9E4XONtP9c893ZUO8Bq061Q31HRA0VCTCzzkGdYnlD9fNOiyUG3+oAbzc+UaKOFrscYgoj/fMVoF4zFiZqfI0kO/+GoxaOye2U1mcsHpdU0HmBGGxlNtOSzluDmaa0GjqHd619H7NU0Ac0HpcIU8NH63z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1NeDnzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5774C19423;
	Sat, 28 Feb 2026 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300514;
	bh=9TDccymzhbg0uNBI2s6j0V/aOaYjuZ7T4QGlrk/QbuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1NeDnzMc2O1ncx1+3a1W48h9pzoJ/0JcSjqR+g7+ia9YLgnbooqdv1spm1vw8wxP
	 WKCsQZkWahWLW0NUsM2zQda5LWvrT4y3haF/vyKyiIVTolpib2VtPguLcuswjpZo1t
	 +Z0d0FaVx/8Hm7gk/GlMFnP1mge1OBozldPV3snbV2xKhUjKp/9TJQ4sZMd4lbg3ne
	 iEUNLfiLh39BZSrEO0TjpjEJf549tAX9xyLmYiKUAvP0lxpHVM5JtIDYeNrbD82h7l
	 oLrKgqAzF4+gmol6FIKS4Z5IAN98iBdMoKx85vO6K/KnJJy8IqsKe1Hhce3bl21bw2
	 g5Ap/+6rJKslw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 552/844] arm64: dts: qcom: sm8750: Fix BAM DMA probing
Date: Sat, 28 Feb 2026 12:27:45 -0500
Message-ID: <20260228173244.1509663-553-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220631-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3AA21C6F9D
X-Rspamd-Action: no action

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit 1c6192ec9c4ab8bdb7b2cf8763b7ef7e38671ffe ]

Bindings always required "qcom,num-ees" and "num-channels" properties,
as reported by dtbs_check:

  sm8750-mtp.dtb: dma-controller@1dc4000 (qcom,bam-v1.7.4): 'anyOf' conditional failed, one must be fixed:
    'qcom,powered-remotely' is a required property
    'num-channels' is a required property
    'qcom,num-ees' is a required property
    'clocks' is a required property
    'clock-names' is a required property

However since commit 5068b5254812 ("dmaengine: qcom: bam_dma: Fix DT
error handling for num-channels/ees") missing properties are actually
fatal and BAM does not probe:

  bam-dma-engine 1dc4000.dma-controller: num-channels unspecified in dt
  bam-dma-engine 1dc4000.dma-controller: probe with driver bam-dma-engine failed with error -22

Fixes: eeb0f3e4ea67 ("arm64: dts: qcom: sm8750: Add QCrypto nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251229115734.205744-2-krzysztof.kozlowski@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 3f0b57f428bbb..0efbf5e29f0f7 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2073,6 +2073,8 @@ cryptobam: dma-controller@1dc4000 {
 				 <&apps_smmu 0x481 0>;
 
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <20>;
 			qcom,controlled-remotely;
 		};
 
-- 
2.51.0


