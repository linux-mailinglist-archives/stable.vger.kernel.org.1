Return-Path: <stable+bounces-149023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A52EACAFE7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C0D1BA2F23
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B0C20F07C;
	Mon,  2 Jun 2025 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IOc8XU20"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE61401B;
	Mon,  2 Jun 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872644; cv=none; b=rixu+shZn6FNN/vwg+7oEujA52Qh+smFHN+XPpQgidwz/qdUGdJQtLYAqngzQZt4Q6t510XP1naoMNtM0h7RME4wuRgSwJNELP6xpttalPfFxlczLlKvZb+shfyib4qJFLEfwT6YiI5zH278flDAZFbBtEjlg9qgCs3b9AJDl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872644; c=relaxed/simple;
	bh=b0lE0hAqx0M6AyjGe04PlGPwpCnHIyXXHwhQVvMEcyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thpuAVTx7OJ9rKsCs01lQrMzRU0NX2Q5YW2Z43SlL1IdbFLoo9SAQ5a2fSZMWPYXbHMqKPs2qYF6wThOZQGswnGglSC0F/thZItb8xAyXkaogdlJDytF1B63NhMAVgBznAraQ7zaZGFyfqNVYkbat6I1tx6AUUCK2fHcXdsPJwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IOc8XU20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569B8C4CEEB;
	Mon,  2 Jun 2025 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872643;
	bh=b0lE0hAqx0M6AyjGe04PlGPwpCnHIyXXHwhQVvMEcyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOc8XU20RjowDBcpBWEVgxks6ctmVwF7k1nmTIwynzN0EpkYd9gcqiL4pPINmdmwb
	 rB0RGWCid5zrbuflJRwEj915w/t62d6hWeZzW07HiBAf4cO+MnDqzO6gTHHfYNswLV
	 qEzqXkRHpnK4vfQ5NlnUb6fgHMVn4AXjbL3FTUe0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abel Vesa <abel.vesa@linaro.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.14 26/73] arm64: dts: qcom: x1e80100: Fix PCIe 3rd controller DBI size
Date: Mon,  2 Jun 2025 15:47:12 +0200
Message-ID: <20250602134242.729133050@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134241.673490006@linuxfoundation.org>
References: <20250602134241.673490006@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abel Vesa <abel.vesa@linaro.org>

commit 181faec4cc9d90dad0ec7f7c8124269c0ba2e107 upstream.

According to documentation, the DBI range size is 0xf20. So fix it.

Cc: stable@vger.kernel.org # 6.14
Fixes: f8af195beeb0 ("arm64: dts: qcom: x1e80100: Add support for PCIe3 on x1e80100")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250422-x1e80100-dts-fix-pcie3-dbi-size-v1-1-c197701fd7e4@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index c04a2615ca77..06175b33bd92 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3126,7 +3126,7 @@ pcie3: pcie@1bd0000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-x1e80100";
 			reg = <0x0 0x01bd0000 0x0 0x3000>,
-			      <0x0 0x78000000 0x0 0xf1d>,
+			      <0x0 0x78000000 0x0 0xf20>,
 			      <0x0 0x78000f40 0x0 0xa8>,
 			      <0x0 0x78001000 0x0 0x1000>,
 			      <0x0 0x78100000 0x0 0x100000>,
-- 
2.49.0




