Return-Path: <stable+bounces-218987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id im5kDzlanmlSUwQAu9opvQ
	(envelope-from <stable+bounces-218987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:11:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDF6190A93
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 670B831138B5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91271299950;
	Wed, 25 Feb 2026 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bc67pbb+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DF2BEC2E;
	Wed, 25 Feb 2026 01:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983892; cv=none; b=pXu1i4AfKCg4iyqfypxY2NBTkuB1Yk/9oe3pOsCyls5HqvswHugZ2LSGcSmNxRTx0Oy3xgMLUTDeOuFYBXgTlR0l1LYFd6FSTrLfyZp8DCRztv2LDY7HYWDPCvYlXKhVEKxrtAiihBB1YJc7l+DOXjI3a6pzOSj4hs7qyn5eYEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983892; c=relaxed/simple;
	bh=qaGu9+rvmKdeZYrZ25UKWNnt6oCdBPZIGWqP2xI2RkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWHCJOxOvPaswC7vkYP1Myyte3IWsv+FLGbeRK8pAS3AnEAoQ6TSdp4ZwvxFryn9dTvww/1GMXwpTcDWlCZoPn4xTMjtBaNsqZnSbjrTT4KAWJr3SUjByHRCTCo2Nk9VBrsPrdZ5xsCVOV2OLjhBpTIPA1uQPylkvomtZHQ5r0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bc67pbb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2C0C116D0;
	Wed, 25 Feb 2026 01:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983892;
	bh=qaGu9+rvmKdeZYrZ25UKWNnt6oCdBPZIGWqP2xI2RkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bc67pbb++ASAFU/THmKVRklerDAganNs1uiiQNZa18peUCiSLUV80duiKSvIME3RO
	 O2IDoi0G9oByjGDUQ86IXTvRNzo8+rFDNmAu1j+CP7xRXtXDoHGyO3YyYxiWuC0qgp
	 tIXuufYAZC4fTkKNhWeaqZF7/JjuJh9t35f+eg8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 164/641] arm64: dts: qcom: talos: Drop opp-shared from QUP OPP table
Date: Tue, 24 Feb 2026 17:18:10 -0800
Message-ID: <20260225012353.037113694@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-218987-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 9BDF6190A93
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

[ Upstream commit dda4bdd325326dd67ae4401f4f3d35b9cf781e3f ]

QUP devices are currently marked with opp-shared in their OPP table,
causing the kernel to treat them as part of a shared OPP domain. This
leads to the qcom_geni_serial driver failing to probe with error
-EBUSY (-16).

Remove the opp-shared property to ensure the OPP framework treats the
QUP OPP table as device-specific, allowing the serial driver to probe
successfully

Fixes: f6746dc9e379 ("arm64: dts: qcom: qcs615: Add QUPv3 configuration")
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251111170350.525832-1-viken.dadhaniya@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 64e7c9dbafc70..363b9f436cd0a 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -398,7 +398,6 @@ cdsp_smp2p_in: slave-kernel {
 
 	qup_opp_table: opp-table-qup {
 		compatible = "operating-points-v2";
-		opp-shared;
 
 		opp-75000000 {
 			opp-hz = /bits/ 64 <75000000>;
-- 
2.51.0




