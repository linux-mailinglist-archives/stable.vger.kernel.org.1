Return-Path: <stable+bounces-211638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMyADrGLd2m9hgEAu9opvQ
	(envelope-from <stable+bounces-211638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:43:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBBF8A484
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B1A13006788
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E833DEED;
	Mon, 26 Jan 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRF8Z8++"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E2340298
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442218; cv=none; b=qRZ3IwC3Z3bwzvG+hFLuyT3dyFB4LUZvjLyu8mAh7ajI05Ku61QU/nyP8zUU6PqaU0cIaJJg0pjvSl/a1MvtGOHldeWqrjA0zwWkeukavn+HXKEjbtTFY3EsMHgIWR/NfEugE1CXieQv+eynd/oBHxXW+iCQ74yNSs9YcSz1y+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442218; c=relaxed/simple;
	bh=ajJaiFheRV4IN9SuE0dsdQhk1yXInqD+peOJHXbBZ4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/yGffwM69h7LzL3DTN5d9GeJ82lKsiHm6Ekd5lH9waMpRCCopsuK8YCWy6vezrJ9pWenOPBXiyahvWCjVPHAuCE4kCeMvC2W1oCBECJvQGSs7KZRE5NJreBgZNOl6y4sTmJeP8eV5Bwy/5Zt8CPDddQb51+QxtkCavKampsxN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRF8Z8++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A1BC2BC86;
	Mon, 26 Jan 2026 15:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769442217;
	bh=ajJaiFheRV4IN9SuE0dsdQhk1yXInqD+peOJHXbBZ4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRF8Z8++lLdizJORCuGxHHYLAeJN+929RU+IK1FBkWG3n4VXOa++Ktg8tHg4hTJ58
	 86nOdpf7rBt5uStO8uNHDqw4iN6bTF3YOOPBIC11h71drkFpTv8bc398NEtzk1iYc0
	 0vsj5shWfTeb4Z6wgnG6q52Rx3IXCeGUTz5ZKW24l3UHaXx0jPaaCOnWCfvtBChITm
	 oIIg+AGmXBM9+yZNqsF4ovZVqoQvtEdhzhXKKgI8z1hKMGIVi/MJWZf3TyNxHxr+Y8
	 oiyInYsXADNM8l0dTbYuWKutACEydeTP4mIvTLuLzu07RBqGiURrgFjm4ppb1Lwd0t
	 nYaLdmrKKQ1Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] arm64: dts: qcom: talos: Correct UFS clocks ordering
Date: Mon, 26 Jan 2026 10:43:34 -0500
Message-ID: <20260126154334.3313728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012606-rebel-animator-928a@gregkh>
References: <2026012606-rebel-animator-928a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211638-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,1d84000:email]
X-Rspamd-Queue-Id: DBBBF8A484
X-Rspamd-Action: no action

From: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>

[ Upstream commit 8bb3754909cde5df4f8c1012bde220b97d8ee3bc ]

The current UFS clocks does not align with their respective names,
causing the ref_clk to be set to an incorrect frequency as below,
which results in command timeouts.

ufshcd-qcom 1d84000.ufshc: invalid ref_clk setting = 300000000

This commit fixes the issue by properly reordering the UFS clocks to
match their names.

Fixes: ea172f61f4fd ("arm64: dts: qcom: qcs615: Fix up UFS clocks")
Cc: stable@vger.kernel.org
Signed-off-by: Pradeep P V K <pradeep.pragallapati@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251126131146.16146-1-pradeep.pragallapati@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index 3d2a1cb02b628..64e7c9dbafc70 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -1260,10 +1260,10 @@ ufs_mem_hc: ufshc@1d84000 {
 				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
 				 <&gcc GCC_UFS_PHY_AHB_CLK>,
 				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
-				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
-				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
+				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
+				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 			clock-names = "core_clk",
 				      "bus_aggr_clk",
 				      "iface_clk",
-- 
2.51.0


