Return-Path: <stable+bounces-16493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49057840D32
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0543F28835B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700B4157E6B;
	Mon, 29 Jan 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jt5tiCTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78215703C;
	Mon, 29 Jan 2024 17:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548061; cv=none; b=aLzaoHFDK6qhb+tuTCgnm6EWucXt2O2ETPKDK9vMakLR9gcJxtMRrXI2bUxeVKUw5wT6MfaB4MdNbxTG4/+UgVaTgNyZ00Ll7YaxhPndaO+37zPAroOi7cwYQ8MbzDgF9mLqepY6RD4AEdUqjZh3fSNPtetknW0nspRsMfmRGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548061; c=relaxed/simple;
	bh=M+Iv9FCb1P+oGZtkm7K7eeU/oYvtvoKuxY6HQobkCig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBpwPOmCeRMd55kHc6986XLIg3Jf3RW4jJhMAZCQrQ/RUGAmkZemvE/PMMBWleuliuThfaLNB0OQ1lKCp7noJuKXriklvD2cVPYUZGNxgxxp+WcZETbO3JY9LU5j2i56Qqs3hYfqxE9+6iK/uy0Oc48lcnPN/Fnbw9kSSkqpWzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jt5tiCTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920C7C433F1;
	Mon, 29 Jan 2024 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548060;
	bh=M+Iv9FCb1P+oGZtkm7K7eeU/oYvtvoKuxY6HQobkCig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jt5tiCTvOe6CeHTkmnL+8H53h+ZjCMwlQKBpEwjX1tf364tccQg6ASXSui40nUTbd
	 2HaQXPZrFab+sXwrsd1domWMPIj+yU2xqHLZLPA0IxdboDFFy5v72kx9PZKjtnaXUt
	 Uu8MqFc8rIz2gtFFpMlgAYB1Lt8xdxnhPOMCwLpM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.7 066/346] arm64: dts: qcom: sc8280xp-crd: fix eDP phy compatible
Date: Mon, 29 Jan 2024 09:01:37 -0800
Message-ID: <20240129170018.328971924@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan+linaro@kernel.org>

commit 663affdb12b3e26c77d103327cf27de720c8117e upstream.

The sc8280xp Display Port PHYs can be used in either DP or eDP mode and
this is configured using the devicetree compatible string which defaults
to DP mode in the SoC dtsi.

Override the default compatible string for the CRD eDP PHY node so that
the eDP settings are used.

Fixes: 4a883a8d80b5 ("arm64: dts: qcom: sc8280xp-crd: Enable EDP")
Cc: stable@vger.kernel.org      # 6.3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231016080658.6667-1-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -458,6 +458,8 @@
 };
 
 &mdss0_dp3_phy {
+	compatible = "qcom,sc8280xp-edp-phy";
+
 	vdda-phy-supply = <&vreg_l6b>;
 	vdda-pll-supply = <&vreg_l3b>;
 



