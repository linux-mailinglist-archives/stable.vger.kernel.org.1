Return-Path: <stable+bounces-116232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4ABA347CB
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D572518833E3
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8616626B098;
	Thu, 13 Feb 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vXHxDkgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307013C816;
	Thu, 13 Feb 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460776; cv=none; b=V8tqW5U3a7ZAzNUcBF2M0KykH7VSwOMaGxZPzZn4FOI6Tcdo+YpAU+GR9QKjVskQlrlLnAkfHn48wgG0NxVfskY2k71TJiFOAZVzg4MQgR7PfcD88bF/H60cn57O81LKFzmWaEyKih4eTHlepHBJZtcq2nYQlz/JV/OxSWZoGBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460776; c=relaxed/simple;
	bh=hcc3jaUC21Uf7TakrEnmR/nixjBRbR4luqrAmB5Yt5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gdxq19s9DTKLvw5noYz36802VexCYweDa2fx/vHeVVeOkrHvh5bax6IyyaWF0Tlg/AKSn4u/tTEBUhCfBC2gaPzsXR9XLcNLMul9MDTpCEz5zFIqbMntgRyzZnz2OPbO2upMfBhGx47HSIGWASW5cP62FIqSC9MHzJjkpEtTpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vXHxDkgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C81C4CED1;
	Thu, 13 Feb 2025 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739460776;
	bh=hcc3jaUC21Uf7TakrEnmR/nixjBRbR4luqrAmB5Yt5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vXHxDkgX+nvanIe/PlZnjcGaNKDL9dT2/sDClMhs2HlSlc0BFFdcrT6C5o3sjSm9w
	 isGopDBgfN59eWqOgOLgiEoz+dguN9hw+ceplp1Q1rGs/D6On7fwmaLAiiamRMjNhN
	 1+c/kxFuwmDM4e+Nnpxkm7LVg3VBtZ3egkHcIw8c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.6 177/273] arm64: dts: qcom: sm6350: Fix uart1 interconnect path
Date: Thu, 13 Feb 2025 15:29:09 +0100
Message-ID: <20250213142414.324937480@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
References: <20250213142407.354217048@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

commit be2f81eaa2c8e81d3de5b73dca5e133f63384cb3 upstream.

The path MASTER_QUP_0 to SLAVE_EBI_CH0 would be qup-memory path and not
qup-config. Since the qup-memory path is not part of the qcom,geni-uart
bindings, just replace that path with the correct path for qup-config.

Fixes: b179f35b887b ("arm64: dts: qcom: sm6350: add uart1 node")
Cc: stable@vger.kernel.org
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20241220-sm6350-uart1-icc-v1-1-f4f10fd91adf@fairphone.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -935,7 +935,7 @@
 				power-domains = <&rpmhpd SM6350_CX>;
 				operating-points-v2 = <&qup_opp_table>;
 				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
-						<&aggre1_noc MASTER_QUP_0 0 &clk_virt SLAVE_EBI_CH0 0>;
+						<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_QUP_0 0>;
 				interconnect-names = "qup-core", "qup-config";
 				status = "disabled";
 			};



