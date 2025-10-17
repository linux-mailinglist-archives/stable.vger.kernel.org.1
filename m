Return-Path: <stable+bounces-187140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8838BE9FFC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE86188A674
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C315336EFA;
	Fri, 17 Oct 2025 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xIF/bK0A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063AE2F12D9;
	Fri, 17 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715229; cv=none; b=uTGdXH7VNrwyDDi1kUNiNP7aHgM1d8Magdm6bw6IY/owLlfntpbEwXQ3vzpkQGuItx1Rx75J3eGg7wxJ51XclLo6sfKzgkvoB3C154bNlEl/9tHE5x6HN+OLYyBL5VyNeOes6EhA1MxOjVCkpH+/0JvVj1QmBdBfHSXt+mwmJKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715229; c=relaxed/simple;
	bh=UG42y1ktzQdfwF5MSQL2BEUijxJY504B8wQ8FA4CLKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbNVaJq2RLYc03KM0LhBQOEWnKdAhA7+N6zVdOJlbF3zyaaNJmSMBUo7iY5Bt2eazVlzYqtC841aqxHkXodqlyV77HisdVF6N6QWTdTTZyfLdMtpTfGCQ9PJadRUAsXavV4OoiBCMkz0NmtWxME5B/wbLK/XmvCmfkwT/N/OD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xIF/bK0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BEBC4CEE7;
	Fri, 17 Oct 2025 15:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715227;
	bh=UG42y1ktzQdfwF5MSQL2BEUijxJY504B8wQ8FA4CLKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xIF/bK0AjmpEMx57BuXWuPZsnZQqXhH47ZaNEZeFHN8qGqAxYreY9t57ScG+gbwhj
	 13uHBNsXqTa0ewxe0SKwlfFZCLgHp08TJRNQZI/LOs69MDO+EWKkN1m59AqwRuPXrm
	 7DmjlCVfmlWaljxHyOgdUJB5l449lKv9VmvcD9ts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.17 143/371] arm64: dts: qcom: msm8939: Add missing MDSS reset
Date: Fri, 17 Oct 2025 16:51:58 +0200
Message-ID: <20251017145207.109815946@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Gerhold <stephan.gerhold@linaro.org>

commit f73c82c855e186e9b67125e3eee743960320e43c upstream.

On most MSM8939 devices, the bootloader already initializes the display to
show the boot splash screen. In this situation, MDSS is already configured
and left running when starting Linux. To avoid side effects from the
bootloader configuration, the MDSS reset can be specified in the device
tree to start again with a clean hardware state.

The reset for MDSS is currently missing in msm8939.dtsi, which causes
errors when the MDSS driver tries to re-initialize the registers:

 dsi_err_worker: status=6
 dsi_err_worker: status=6
 dsi_err_worker: status=6
 ...

It turns out that we have always indirectly worked around this by building
the MDSS driver as a module. Before v6.17, the power domain was temporarily
turned off until the module was loaded, long enough to clear the register
contents. In v6.17, power domains are not turned off during boot until
sync_state() happens, so this is no longer working. Even before v6.17 this
resulted in broken behavior, but notably only when the MDSS driver was
built-in instead of a module.

Cc: stable@vger.kernel.org
Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250915-msm8916-resets-v1-2-a5c705df0c45@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -1249,6 +1249,8 @@
 
 			power-domains = <&gcc MDSS_GDSC>;
 
+			resets = <&gcc GCC_MDSS_BCR>;
+
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#interrupt-cells = <1>;



