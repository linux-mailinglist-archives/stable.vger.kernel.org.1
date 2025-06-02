Return-Path: <stable+bounces-149035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9ECACAFEB
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C121816ED36
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8211F5846;
	Mon,  2 Jun 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lIqjgUdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9341A3A80;
	Mon,  2 Jun 2025 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872684; cv=none; b=VSiJd3PmXKCn7nUa5f7fPcyysjoYWLZBjz4JBthPFTvVO1ZMFJZqZoSMx9B06u7AE4sOu9bcl2jWjML7hyQmtU6K63kvUJxZ5yvS2Wy3rPHHFJTJXZJACQXk8jumMoILmi/sqHf71hQpeggVy/La241dKSU9kI8P3ihZKC5cveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872684; c=relaxed/simple;
	bh=4Y4MfD8RV8eIpwbLROPpl87pMyKGQRCn6LDigq1iFEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCS27ftVYWfWqToaKiu3DFXjLTO/CpLypHBU8he7GVbP+MHmcKZQQqk+B/PiypTzj80RTTbrfNWoN7lUB7dsWmF9bwe6tjGyLP4pmXcwYnBuusg65eBmKkLsc0rwEnrqxGafG+cfuhC86bczJ56PaT+t91FJj1yvfXYdqE//YWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lIqjgUdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7D2C4CEEB;
	Mon,  2 Jun 2025 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748872684;
	bh=4Y4MfD8RV8eIpwbLROPpl87pMyKGQRCn6LDigq1iFEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIqjgUdk511oMR6puQqr+zl05UUIlYYriROs01rVtWc69Olt5zsj2WVff4u3dud3b
	 6dBEKmK2ZziHFioD3fMbtc6dn44MmLV7zwr684lha9BniIg/9T9pWiwkoa3KyJrrx0
	 JNCHSVM4m4GI2S5ZV4EmJZFt0ecgi/grqUXPEqo4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.14 09/73] arm64: dts: qcom: sm8450: Add missing properties for cryptobam
Date: Mon,  2 Jun 2025 15:46:55 +0200
Message-ID: <20250602134242.057236968@linuxfoundation.org>
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

From: Stephan Gerhold <stephan.gerhold@linaro.org>

commit 0fe6357229cb15a64b6413c62f1c3d4de68ce55f upstream.

num-channels and qcom,num-ees are required for BAM nodes without clock,
because the driver cannot ensure the hardware is powered on when trying to
obtain the information from the hardware registers. Specifying the node
without these properties is unsafe and has caused early boot crashes for
other SoCs before [1, 2].

Add the missing information from the hardware registers to ensure the
driver can probe successfully without causing crashes.

[1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
[2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/

Cc: stable@vger.kernel.org
Fixes: b92b0d2f7582 ("arm64: dts: qcom: sm8450: add crypto nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Link: https://lore.kernel.org/r/20250212-bam-dma-fixes-v1-2-f560889e65d8@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -5283,6 +5283,8 @@
 			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <0>;
+			qcom,num-ees = <4>;
+			num-channels = <16>;
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x584 0x11>,
 				 <&apps_smmu 0x588 0x0>,



