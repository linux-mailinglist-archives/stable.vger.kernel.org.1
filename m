Return-Path: <stable+bounces-115921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EE0A346E9
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D803AE550
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1F26B0BE;
	Thu, 13 Feb 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hsopTymu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E580B26B091;
	Thu, 13 Feb 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459721; cv=none; b=XJW32Dwv8/cc9npXZ3xtmCO/xiFiDxoiPmTSWRGHxUf0T/utv/OzGEHs2ai8GrMCQYVfLSmfUzOe9WmPDgZzDyPK+F6gNIAtvEBej4wUxF3qwR0kkOq3YZqLd6hKugeGNiTkE9FOAi4tnaq90S9K6BHL2oBEDWCOiC3co9wRx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459721; c=relaxed/simple;
	bh=VClj2eXSQcI2DaqrmZjJ+8GiPSY1gzKRCoptwoPd8pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NboqIKlya5SFYg8V0z+KUhkAbzK/E4bNK83IwqoYVStWrFtIwdl5O+D1jpwokNLUcSY8rP30tppkqd8njPg4wjsznen7lO1WSyQKVSNzaiOOXiQ81ag5TvN7mry7c38ib3N9BkDPfXhcuy/zZLRR/WlNRMrX/CrPzcIvbgOv+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hsopTymu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541E7C4CED1;
	Thu, 13 Feb 2025 15:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459720;
	bh=VClj2eXSQcI2DaqrmZjJ+8GiPSY1gzKRCoptwoPd8pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hsopTymuW2BfOOyLVp5x13Ztb2bQ0/Dt1I/S995eX95WQsmgkEvkBWMIOsW7ySLzz
	 lkpDjiQIBKEqHrcywMqnhNr+n8leSACdzHHFKkqwQ/zcNT2wczM1rRI5hzW/a0G7NA
	 /Wud3D8p99bEBMymNTNnyFPVLg/mDX/9slYYKqco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.13 312/443] arm64: dts: qcom: sm8350: Fix MPSS memory length
Date: Thu, 13 Feb 2025 15:27:57 +0100
Message-ID: <20250213142452.654856210@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit da1937dec9cd986e685b6a429b528a4cbc7b1603 upstream.

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 177fcf0aeda2 ("arm64: dts: qcom: sm8350: Add remoteprocs")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241213-dts-qcom-cdsp-mpss-base-address-v3-3-2e0036fccd8d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2214,7 +2214,7 @@
 
 		mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8350-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,



