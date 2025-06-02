Return-Path: <stable+bounces-148921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDB7ACABEC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D2E169DE0
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACAE197A7A;
	Mon,  2 Jun 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="etn/vuDF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77339F9EC
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857779; cv=none; b=otFOdFRPQTPMqlivWazI+/R+HHpiiBx0Y1IhnC+PY3q5Cf2SQZHCb6Lj2EQPxhk9tDxxBGIy0JVEEWQcmh2+3SUbL3gFEi1jpnyWL3Cs8LpnCvHBci3vqPB8uTpHnGd0JzX5xU5Xt1bYniyaE7Z1PVN1MPgQWdrxM4u7zSbrTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857779; c=relaxed/simple;
	bh=liUreBZh3GLnwns3enu7q59Daq1ymS13llryV5E0NW8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kX0aT4hdFCMvDduf8IsS6HTDYSD5C/zhy5OQmGGcDSNfnW6ivgcdXk42BtHQCfbSehSzIQdZWqSw3vxFMdeCN4kpq8J6TQ81uV1EjX4e25fIVZq136rHrv4jPFOmj8OfxTG7fiMet5+tHWsRKW74T/dLpVQBZAvCa9TM9ePyzQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=etn/vuDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8283CC4CEED;
	Mon,  2 Jun 2025 09:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857778;
	bh=liUreBZh3GLnwns3enu7q59Daq1ymS13llryV5E0NW8=;
	h=Subject:To:Cc:From:Date:From;
	b=etn/vuDFD4zs8TrzD1ObIEpV5qtM4y5VDGZT5nrtYjfVhmf4j/YqUvaiT2Oph7Qwq
	 8YTPsw7MygT2eAj5DIIty/vBp61pJr6/EXKWp0BwPvlMeaQ0hy5nwwnem2eNUIm9rA
	 H9Ljiynk5CCMgr30Vg1YvTTtXhcRIXRTn8orgQRA=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: x1-crd: Fix vreg_l2j_1p2 voltage" failed to apply to 6.15-stable tree
To: stephan.gerhold@linaro.org,abel.vesa@linaro.org,andersson@kernel.org,johan+linaro@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:49:36 +0200
Message-ID: <2025060236-coat-unsterile-20f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5ce920e6a8db40e4b094c0d863cbd19fdcfbbb7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060236-coat-unsterile-20f5@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ce920e6a8db40e4b094c0d863cbd19fdcfbbb7a Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 23 Apr 2025 09:30:07 +0200
Subject: [PATCH] arm64: dts: qcom: x1-crd: Fix vreg_l2j_1p2 voltage

In the ACPI DSDT table, PPP_RESOURCE_ID_LDO2_J is configured with 1256000
uV instead of the 1200000 uV we have currently in the device tree. Use the
same for consistency and correctness.

Cc: stable@vger.kernel.org
Fixes: bd50b1f5b6f3 ("arm64: dts: qcom: x1e80100: Add Compute Reference Device")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250423-x1e-vreg-l2j-voltage-v1-1-24b6a2043025@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index f73f053a46a0..dbdf542c7ce5 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -846,8 +846,8 @@ vreg_l1j_0p8: ldo1 {
 
 		vreg_l2j_1p2: ldo2 {
 			regulator-name = "vreg_l2j_1p2";
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 


