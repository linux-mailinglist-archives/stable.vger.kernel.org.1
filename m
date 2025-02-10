Return-Path: <stable+bounces-114626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E40E1A2F070
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E9827A1D97
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122FD1F8BC8;
	Mon, 10 Feb 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LZA9fRDR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA97252906
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199364; cv=none; b=uliReHRftAy8soic0DwPDcg+OL/pPzeuTLIzRnUsXOoNrRLZaG3c+zFm6rc1VrVHqJ1idWIypQHGtikq1CqacW6hWU2vQEyQhHAx1BjGfN+XIPybnpayblJipaz/AdhVReUewGnPprAfJm2f04Xr9Uyn/CCe7rTHvA1WjLEkmaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199364; c=relaxed/simple;
	bh=zIfLTHBsSbIH3LzCMN+XfNVP8xtqotaxWlaIXAfQ/Ms=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=g0gD+79/4xk+V8VbHe3nr5gutph7Q4+Ea8ORPvdwS9zo36Ss0pVunfyRmiRKYH3Cio2DW5yWdkd9NoHhWQWUUlkPrM8jfJvabPQHSK+bDv/J3r7kpNWdUq4+WCmz1QVSftf7NhOPpggDb3gvSykSnGmQ8vMxEiUY2SP2sKi7LjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LZA9fRDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3C6C4CED1;
	Mon, 10 Feb 2025 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199364;
	bh=zIfLTHBsSbIH3LzCMN+XfNVP8xtqotaxWlaIXAfQ/Ms=;
	h=Subject:To:Cc:From:Date:From;
	b=LZA9fRDRv5sznFo882bENj587jff8k4bIz1WtHfeANuWrEBQWQw2uNsHJLTb2v/xo
	 6gSin+5itUryj0o6au1gcqPSM/rvFg0aMm8HINx8j5r9V9KTaAA+WPbdYXkx/Abrkt
	 AnvlEnUf0R9/+FoKpIqx37Cq50YibP0fI4ghMrPw=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sm8450: Fix CDSP memory length" failed to apply to 6.1-stable tree
To: krzysztof.kozlowski@linaro.org,andersson@kernel.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:56:01 +0100
Message-ID: <2025021001-outflank-broken-2dd7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3751fe2cba2a9fba2204ef62102bc4bb027cec7b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021001-outflank-broken-2dd7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3751fe2cba2a9fba2204ef62102bc4bb027cec7b Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:53:54 +0100
Subject: [PATCH] arm64: dts: qcom: sm8450: Fix CDSP memory length

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 1172729576fb ("arm64: dts: qcom: sm8450: Add remoteproc enablers and instances")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241213-dts-qcom-cdsp-mpss-base-address-v3-5-2e0036fccd8d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 962023331ac4..b57edfbaf784 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2800,7 +2800,7 @@ vamacro: codec@33f0000 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8450-cdsp-pas";
-			reg = <0 0x32300000 0 0x1400000>;
+			reg = <0 0x32300000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,


