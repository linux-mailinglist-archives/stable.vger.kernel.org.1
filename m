Return-Path: <stable+bounces-250553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAZ4BVMRDmrw5wUAu9opvQ
	(envelope-from <stable+bounces-250553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:53:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63E598DB5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A450318DCF2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70A6372691;
	Wed, 20 May 2026 16:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mM9LDYty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BE352C52;
	Wed, 20 May 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295712; cv=none; b=N0g6aDG2SK0KPIgIvvjOC6hg5rZX1ZrOgUSPjjOPVTQgW29mwTucNB/eKpkPFfrU1uXZ4pfHXtVoeX5vEbOtLY/Vyx+D8BTnMh9Pb3xOIZ6ghahvaK/dw7GkFl4++EapxqD+VkXOr9ZLcO5J7VzpJauHaeSDMq0w69jKju1eK2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295712; c=relaxed/simple;
	bh=FgY+DvKloEuP5Jaq9KZ2tOF4UyGsE4Vx/U9Ik+B8cHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpHp5AsqYSMFquT1jyD3HmOnFsB2YxVOjUwxlFoqUG8kC5uC/HW6lQfTxGEfS6yt6mic8voVwzdgqlDrcOvsc0158YfvFSkMISqMFMcOET7rtSXoK376uqEa7UOB0OKX/HmeKmHDeyHbRS/1zWkdscvDDUpD4GFFLAOmdcR0qjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mM9LDYty; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B53B1F000E9;
	Wed, 20 May 2026 16:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295710;
	bh=AIsnDuGbN1nxYuG/YCglAdymwBfgRPWDdamhkgEoO8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mM9LDYtyLyvhSYMJHUD3II/1gWN7Mnx1e5tW3voCMcVHqKkFjC2UasI0JFqiPRN59
	 9pfBe9jtznmD5UDGhCc5rqv+g/vYQGSp0FisUptbMba9VWn2XxWv1Gac+SKkueKJRd
	 8k57BeBxCfrAOOklYtLCMBL2IM448d+nb2tRT7zo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0516/1146] arm64: dts: qcom: sm8750: correct Iris corners for the MXC rail
Date: Wed, 20 May 2026 18:12:46 +0200
Message-ID: <20260520162159.862838578@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250553-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email]
X-Rspamd-Queue-Id: 9E63E598DB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 2755bdd02a43c204fb0ca02b93787a863c1cf9d2 ]

The corners of the MVS0 / MVS0C clocks on the MMCX rail don't always
match the PLL corners on the MXC rail. Correct the performance corners
for the MXC rail following the PLL documentation.

Fixes: c0d11ff90475 ("arm64: dts: qcom: sm8750: Add Iris VPU v3.5")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260313-iris-fix-corners-v1-6-32a393c25dda@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index f56b1f889b857..f34f112d3aa34 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2945,19 +2945,19 @@ iris_opp_table: opp-table {
 
 				opp-240000000 {
 					opp-hz = /bits/ 64 <240000000>;
-					required-opps = <&rpmhpd_opp_low_svs_d1>,
+					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_low_svs_d1>;
 				};
 
 				opp-338000000 {
 					opp-hz = /bits/ 64 <338000000>;
-					required-opps = <&rpmhpd_opp_low_svs>,
+					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_low_svs>;
 				};
 
 				opp-420000000 {
 					opp-hz = /bits/ 64 <420000000>;
-					required-opps = <&rpmhpd_opp_svs>,
+					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_svs>;
 				};
 
@@ -2969,19 +2969,19 @@ opp-444000000 {
 
 				opp-533333334 {
 					opp-hz = /bits/ 64 <533333334>;
-					required-opps = <&rpmhpd_opp_nom>,
+					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_nom>;
 				};
 
 				opp-570000000 {
 					opp-hz = /bits/ 64 <570000000>;
-					required-opps = <&rpmhpd_opp_nom_l1>,
+					required-opps = <&rpmhpd_opp_nom>,
 							<&rpmhpd_opp_nom_l1>;
 				};
 
 				opp-630000000 {
 					opp-hz = /bits/ 64 <630000000>;
-					required-opps = <&rpmhpd_opp_turbo>,
+					required-opps = <&rpmhpd_opp_nom>,
 							<&rpmhpd_opp_turbo>;
 				};
 			};
-- 
2.53.0




