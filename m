Return-Path: <stable+bounces-251605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIneMur+DWpV5QUAu9opvQ
	(envelope-from <stable+bounces-251605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D248F596B28
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 92440308E61D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC58E369D7E;
	Wed, 20 May 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cymM+e6M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10636405A;
	Wed, 20 May 2026 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298416; cv=none; b=YuIolgl53mOw0FtNlQ0XZB0wdm6ZTgq3XpblwztdNRAWNEvrgjiCBNYHjAU3jLsUsAsl6n5rxz2rcvAyeRzspuHbwpXmMt+hH0CVW/3vzMbgIKBpAKp++YSmbPDO1ZunTR9taDdLT9SSohXdhaHe2U3YCJrBTIbiLMEmZdbnqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298416; c=relaxed/simple;
	bh=RoAujxKLkTd+qwQeicByL7UDrBQU6iF1f/7a+N+bV88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ichnd9Fa6eDE9I8YB9D8jy8MDaGsIwRwFuBXTNKcAg4Y1lDTnbnYGpUs3jHibNVzus5b4pO9ZEUF1zm7HFWp0cK/3uUPfYbPqvGop198F+uLQJlX/zSqp/5XdMGX6Acm++f8kghclXK+IyRw7XfqQIdl6TXiXi3AhqFZ4lJbWIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cymM+e6M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF6E1F000E9;
	Wed, 20 May 2026 17:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298415;
	bh=QyCOwMGEBd+LURqbsMG3IT+yzIZYN3RjvOfXcwMVjD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cymM+e6Mc7eESUMcwh5FqO9LsPxVafPvw6anIpncjsiTuHPt2HRtjkwzZ8W4KUDYM
	 BY96SVCgG5SiV4FA8vySpSbf1TT2Av63SiUg8W06Zm0udCDMyZzCDegkZVmj2GUKFf
	 jqeuhmJjrFgATiEANBE8/c5XviHshpHpahY79RtA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 395/957] arm64: dts: qcom: hamoa: correct Iris corners for the MXC rail
Date: Wed, 20 May 2026 18:14:38 +0200
Message-ID: <20260520162143.093343527@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251605-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D248F596B28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit baac8b5e43f42b632b912a6a837d94fd5bca48f2 ]

The corners of the MVS0 / MVS0C clocks on the MMCX rail don't always
match the PLL corners on the MXC rail. Correct the performance corners
for the MXC rail following the PLL documentation.

Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260313-iris-fix-corners-v1-1-32a393c25dda@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index efe8d5e7079fe..66c31c1799421 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5297,19 +5297,19 @@ opp-338000000 {
 
 				opp-366000000 {
 					opp-hz = /bits/ 64 <366000000>;
-					required-opps = <&rpmhpd_opp_svs_l1>,
+					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_svs_l1>;
 				};
 
 				opp-444000000 {
 					opp-hz = /bits/ 64 <444000000>;
-					required-opps = <&rpmhpd_opp_nom>,
+					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_nom>;
 				};
 
 				opp-481000000 {
 					opp-hz = /bits/ 64 <481000000>;
-					required-opps = <&rpmhpd_opp_turbo>,
+					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_turbo>;
 				};
 			};
-- 
2.53.0




