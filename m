Return-Path: <stable+bounces-148922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F3ACABED
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6558218858FF
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417681A285;
	Mon,  2 Jun 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zQHe3CGz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01786F9EC
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857787; cv=none; b=PaIWq5yJ0qUg2hFXoAqXgkOVnoY3pCiq9kLivG2MFvPYeLqHvOR1iTz0wpfJR1BrP++XH+O3+EEAkm6bqRFIzTBt7CqLX2Yx9jXp+fjOBysSyYC3tOay31TMCfw4rKpFDZngbxoH68IBlyskQ5egjq6ycxEJNlG9E6jE8ksmaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857787; c=relaxed/simple;
	bh=cz9Ec6CSUz8mTWAWYfDU9luQL2KKlvKP4jl381Zf9iU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=co+7XDYL0TP7RRO7wMQAk8BbsOW19H6hIWw0BpDanlslqqiElerT97ZBuwA51yR+yVrMWcghtw/jHihW2INg9n+GV7qph5hg1SewvaQebiW4293i83mmOkShMrT6APTYUu5eecHH+MPoHqanE/VT5vw2TYt6/utvHBrQpW5+IyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zQHe3CGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B70C4CEEB;
	Mon,  2 Jun 2025 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857786;
	bh=cz9Ec6CSUz8mTWAWYfDU9luQL2KKlvKP4jl381Zf9iU=;
	h=Subject:To:Cc:From:Date:From;
	b=zQHe3CGzwhcv/EwaUB2/didE0BbCYvPhcY92xB/34AAdJpK125EaKSVoxQRpVlM0b
	 KHvphj04WarbAgsiRKT3bTGaLxGIRrs+DdNy+1RaSMEFZJTKM0646+9oV8Lc/R5t5T
	 EIEsljyzvS2/gLC0gs4hbFDVS6rTbF0Z9BQUsp8M=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: x1-crd: Fix vreg_l2j_1p2 voltage" failed to apply to 6.14-stable tree
To: stephan.gerhold@linaro.org,abel.vesa@linaro.org,andersson@kernel.org,johan+linaro@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:49:36 +0200
Message-ID: <2025060236-swimming-deodorize-a6f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x 5ce920e6a8db40e4b094c0d863cbd19fdcfbbb7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060236-swimming-deodorize-a6f9@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

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
 


