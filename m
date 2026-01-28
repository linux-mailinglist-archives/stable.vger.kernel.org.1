Return-Path: <stable+bounces-212413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA1JBy82emnn4gEAu9opvQ
	(envelope-from <stable+bounces-212413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:15:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFEDA557D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36DDA305A64F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380B2E2DF4;
	Wed, 28 Jan 2026 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zksipOme"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B22DF155;
	Wed, 28 Jan 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615434; cv=none; b=gRD0Vv6a2G9IxIYDBlB6bprarOdD+9Gk94Z7doabylXPSMVCZMdbJ+OGHQRxo2YY/+457tm/X8A4Zsc44ANJ6+tBQIqTvGYr5ifBdhKJ33Ph4fZ1E/MqcHahKtFa2JO1mQWG8LEXRzg3VhBk/2OGIG5kHEQFKo3Hh4R/GFP1fDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615434; c=relaxed/simple;
	bh=tnpf+9NfsOSYw7l3kq63hB2ataraf2ZfvcpEuT9DaY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dfqmU0u8vqKa8HufUCIwvLhA8A1nONvexPJs/5Jn0d/Ej3C3ArePYXkFdkQD9whQ/zw2spy7qnB7SO2+ZsST4+RiuQyIbevIr/QCHPaBaV69n8b2ZRjIWq/E3B9xph6IIxLBly321MCuZIEHWpMkdxIL8t84OXwTj0f/mACaI+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zksipOme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AA1C4CEF1;
	Wed, 28 Jan 2026 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615434;
	bh=tnpf+9NfsOSYw7l3kq63hB2ataraf2ZfvcpEuT9DaY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zksipOme+16GJpf7g5Ncf3b60/nkPOGOBw+9aIG/hgrlpDP/Jjv3cyaidr/USb4ZQ
	 dStJdl48iEg9uKwbtTRK1oKR6yl409kGdtyB8gssvTfuX9yVhjhnxHU8ToXgpXmhIV
	 rkB8HuONCEN7sNVHdk997q3dNVGeaqNl3z3bocHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 001/227] arm64: dts: qcom: sc8280xp: Add missing VDD_MXC links
Date: Wed, 28 Jan 2026 16:20:46 +0100
Message-ID: <20260128145344.389302038@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212413-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,1.69.3.32:email,1b300000:email]
X-Rspamd-Queue-Id: 3EFEDA557D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[ Upstream commit 868b979c5328b867c95a6d5a93ba13ad0d3cd2f1 ]

To make sure that power rail is voted for, wire it up to its consumers.

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20251202-topic-8280_mxc-v2-3-46cdf47a829e@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 963ce2362a52e..d89938e17e093 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -5773,8 +5773,12 @@ remoteproc_nsp0: remoteproc@1b300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_NSP>;
-			power-domain-names = "nsp";
+			power-domains = <&rpmhpd SC8280XP_NSP>,
+					<&rpmhpd SC8280XP_CX>,
+					<&rpmhpd SC8280XP_MXC>;
+			power-domain-names = "nsp",
+					     "cx",
+					     "mxc";
 
 			memory-region = <&pil_nsp0_mem>;
 
@@ -5904,8 +5908,12 @@ remoteproc_nsp1: remoteproc@21300000 {
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&rpmhpd SC8280XP_NSP>;
-			power-domain-names = "nsp";
+			power-domains = <&rpmhpd SC8280XP_NSP>,
+					<&rpmhpd SC8280XP_CX>,
+					<&rpmhpd SC8280XP_MXC>;
+			power-domain-names = "nsp",
+					     "cx",
+					     "mxc";
 
 			memory-region = <&pil_nsp1_mem>;
 
-- 
2.51.0




