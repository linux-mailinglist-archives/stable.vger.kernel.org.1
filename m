Return-Path: <stable+bounces-186423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0B9BE96F7
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B36E9507ED6
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D5A337100;
	Fri, 17 Oct 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YX3YEEcg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EEF3370F6;
	Fri, 17 Oct 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713200; cv=none; b=fnO6Yxmx81978GsRHbGMJQaLpyq31BlERudXZ4XG1SWmISBjeZX18yvTzjAyMENw/hHF1tn8XCYf1aDNNs+qYrQHZGzlWWUjXRZe6HzKhIA1a2mNjvJb3y3/wg3OlBtsgCHVpxhd+Ny8P+K3XZsVXtl80WiNEYrVHIJ6Zb6zrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713200; c=relaxed/simple;
	bh=oO2nkXOM6SniMqOm/3kbccNNakPqEex/S3DIKU2Ki00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEzi+trbS5p3n/oJQuIvNXikbnl+IA+tTfkAWkcYv6Rs2RC6MpbEK2iQK5HTlQw4bcOh0EO+nwmOStoC8RSrug0oZEC+b0w9YP3JwVKZrcDjxNDLTvP9KAbxilVpEWxdNR9ZKPgJ8MddMufyp/J1lPr7GaC4wNZ/4hQhAUVNuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YX3YEEcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91838C4CEE7;
	Fri, 17 Oct 2025 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713200;
	bh=oO2nkXOM6SniMqOm/3kbccNNakPqEex/S3DIKU2Ki00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YX3YEEcg7kGCae09Hselbtm+hJO+7YziTpB5kgo54adyQGJCndrVPnFE5dxFHuXSm
	 T4B0IUkr1YFqX++7H8tJkU9EChvPaglOovOgTUALyTnT14IWSzdoJjP42ej9/sfy1h
	 nvbHs9/mN5FRaqq55ChiDehtVezI97l/BkxQalCU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.1 055/168] arm64: dts: qcom: sdm845: Fix slimbam num-channels/ees
Date: Fri, 17 Oct 2025 16:52:14 +0200
Message-ID: <20251017145131.048756923@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Gerhold <stephan.gerhold@linaro.org>

commit 316294bb6695a43a9181973ecd4e6fb3e576a9f7 upstream.

Reading the hardware registers of the &slimbam on RB3 reveals that the BAM
supports only 23 pipes (channels) and supports 4 EEs instead of 2. This
hasn't caused problems so far since nothing is using the extra channels,
but attempting to use them would lead to crashes.

The bam_dma driver might warn in the future if the num-channels in the DT
are wrong, so correct the properties in the DT to avoid future regressions.

Cc: stable@vger.kernel.org
Fixes: 27ca1de07dc3 ("arm64: dts: qcom: sdm845: add slimbus nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250821-sdm845-slimbam-channels-v1-1-498f7d46b9ee@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5134,11 +5134,11 @@
 			compatible = "qcom,bam-v1.7.0";
 			qcom,controlled-remotely;
 			reg = <0 0x17184000 0 0x2a000>;
-			num-channels = <31>;
+			num-channels = <23>;
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 			qcom,ee = <1>;
-			qcom,num-ees = <2>;
+			qcom,num-ees = <4>;
 			iommus = <&apps_smmu 0x1806 0x0>;
 		};
 



