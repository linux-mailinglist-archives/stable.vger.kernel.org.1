Return-Path: <stable+bounces-248837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP1VMflQB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:59:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 823215544C1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0BCE31225E2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3023530569C;
	Fri, 15 May 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nIko3zYF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BE3CEBA9;
	Fri, 15 May 2026 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862755; cv=none; b=hMv4VU4EwZPTEBuwspUEh0xiHQYyS9p6UVQ/nZmizeC6NqfygNn+n/CFq17KsUORtclKm6P4g1431KKRRAJkLHDfXNfnaJ9py7c1IGS5IhjECnQui+z0jQF3D5JiyVms9g5nBsUHLcSp5hWv21f98Lw5A1xRMl4cvfxxgJZApUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862755; c=relaxed/simple;
	bh=uU1x48hFvK15xDijy6K35kflJWHcdIYjvLy/77amIQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlH44j9FeYhzMOGVb7+hVpGY4Jets6qq5BvWn1PvbmzcEXEj2hTkTUUGCiELDDp0otdyN/XP6Vsdep2p/rtl6ZVtnXdcqSMH9yLp+tPR8iB8UEjVwLBmfWmwCNTlE00z1tfU3Cy30bKSoFOOqi4sfWLaL/Yl1O4lG+QeYwM129A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nIko3zYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C82FC2BCB0;
	Fri, 15 May 2026 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862754;
	bh=uU1x48hFvK15xDijy6K35kflJWHcdIYjvLy/77amIQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nIko3zYFG1GfKsTecbNDHFbeEaHNzM24/IGQC6oU1FAKmuW498IaZYT/bWLyJDc+x
	 vlksR4qlc75/Bvj8sIr9tbfPeHA69CWkDuRu26FLnuoACtzYQU9qFduuKPhAY2II9t
	 IiqSA8nc7OmoSRDpgQ6MEIHjVXBCkBQLSCgc0OWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 7.0 168/201] arm64: dts: qcom: kodiak: Fix PCIe1 PHY ref clock voting
Date: Fri, 15 May 2026 17:49:46 +0200
Message-ID: <20260515154702.215795283@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 823215544C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248837-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

commit 30e8b6d42e8988eaaf0c2efd8c3797cb3884faea upstream.

GCC_PCIE_CLKREF_EN controls a repeater that provides the reference clock
only to the PCIe0 PHY. PCIe1 PHY receives its refclk directly from the CXO
source.

If the PCIe1 driver in HLOS votes for or against GCC_PCIE_CLKREF_EN, it
will inadvertently modify the refclk to PCIe0 as well. Since PCIe0 is
managed by WPSS while PCIe1 is managed in HLOS, there is no mechanism to
coordinate these votes. As a result, HLOS may disable this repeater
during suspend and cut off the PCIe0 PHY refclk while PCIe0 is still
active.

Replace the unused GCC_PCIE_CLKREF_EN clock entry with RPMH_CXO_CLK to
reflect the actual hardware wiring and prevent unintended changes to
PCIe0 clocking.

Fixes: 92e0ee9f83b3 ("arm64: dts: qcom: sc7280: Add PCIe and PHY related nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260123-fix_pcie1_phy_clk-v1-1-38f82ea01792@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -2445,7 +2445,7 @@
 			reg = <0 0x01c0e000 0 0x1000>;
 			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
-				 <&gcc GCC_PCIE_CLKREF_EN>,
+				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_PCIE1_PHY_RCHNG_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK>;
 			clock-names = "aux",



