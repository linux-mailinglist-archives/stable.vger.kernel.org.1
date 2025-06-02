Return-Path: <stable+bounces-148931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA6FACABF8
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C710917B4E7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D4A197A7A;
	Mon,  2 Jun 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BJ3KDqDF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC4F9EC
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857821; cv=none; b=bdBsaTP9WQBKlKnWxrkUDkz/sczirWlryXOM0VO/8BtHZvBEkd9zS0M9WnicXDoV2LQ9b9rPGZKNveMEJ4g/Xye3/dlvqXkMRl5x/yrfYikDsfcxK18i17vBSPItWg+U4fXWifJ+kH4wGrlDCdtv5yjEYV4Rjk8gpG/CwmrdvIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857821; c=relaxed/simple;
	bh=FY91Bxwbula10RML0Un5zmJNJC2Ze7fNfh50+2Ipfbc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UXzXGSPsRUcsxrJJyyW7VPGoije5lIYW7i6jhMow57ECtqH5g4XXTVPeA3ppt3+MZzOySTwqcmAywrcMglWtGmHB2AWcbddUzUXzALDsttKZhJSR40u8PRx2ZpnFNh1NIBs9S8aRxzwpPnm47ewmlTsiq1EVFai6attf1SoMaWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BJ3KDqDF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FD4C4CEED;
	Mon,  2 Jun 2025 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857821;
	bh=FY91Bxwbula10RML0Un5zmJNJC2Ze7fNfh50+2Ipfbc=;
	h=Subject:To:Cc:From:Date:From;
	b=BJ3KDqDFsEzY3d/oKmTGVNAsa+imabZBF/Ijqpccqehi8UjpSoJMe9GN/UNE+dWm0
	 yA19+ufBWoSnS0U51LwHl32fMJiAi4hv5aqqsDhpLmpdSChzjCMjXQH/AucxTqc2Ja
	 IGjlUTD3+XTnD+nPmIFwTNJ1aj+NlM1OcUZxHKdg=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: x1e80100-crd: mark l12b and l15b always-on" failed to apply to 6.12-stable tree
To: johan+linaro@kernel.org,abel.vesa@linaro.org,andersson@kernel.org,konrad.dybcio@oss.qualcomm.com,quic_rjendra@quicinc.com,quic_sibis@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:50:02 +0200
Message-ID: <2025060202-important-scribing-f981@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x abf89bc4bb09c16a53d693b09ea85225cf57ff39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060202-important-scribing-f981@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From abf89bc4bb09c16a53d693b09ea85225cf57ff39 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Fri, 14 Mar 2025 15:54:33 +0100
Subject: [PATCH] arm64: dts: qcom: x1e80100-crd: mark l12b and l15b always-on

The l12b and l15b supplies are used by components that are not (fully)
described (and some never will be) and must never be disabled.

Mark the regulators as always-on to prevent them from being disabled,
for example, when consumers probe defer or suspend.

Fixes: bd50b1f5b6f3 ("arm64: dts: qcom: x1e80100: Add Compute Reference Device")
Cc: stable@vger.kernel.org	# 6.8
Cc: Abel Vesa <abel.vesa@linaro.org>
Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20250314145440.11371-2-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index 5ea7b30983d9..f73f053a46a0 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -606,6 +606,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -627,6 +628,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l16b_2p9: ldo16 {


