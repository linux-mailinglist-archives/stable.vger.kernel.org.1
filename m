Return-Path: <stable+bounces-148929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5449EACABF6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13CAA3B1960
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D71E25F2;
	Mon,  2 Jun 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kxh/NzcF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186E38BE5
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857815; cv=none; b=Xe5oizuT0ibVCMPieAPpjDYfAph/wybTBAXZXwkUDw7fVEGoo40KmPH88tDUQHoz4C5ckwxmW+p1Sxa6TnT88hbAhsYoL7PqxJaez0zhFobOCnkT4mpB946mGOKEJZapr134j+qoSn34ja7vcV6GaWkgyUHSVRkiUheZlZdKupg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857815; c=relaxed/simple;
	bh=7KDs54ZB5iIkFgq/wnHQ+Aw471OQTM0nG9uitERQRBw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=eo0LfEItapt+J1Cczb1/J5Pa0zZlS4WdSXIAQ2eRs95wGWfcEThCnYm0ix15kAdW9pRFnyRqg/jBL2DDYkmPk9knirfWyeIFOi5fF/Xgncmps1z2mZFhXRkARipqiS1nPD6dHZEqCMjsKQxS1ebUGqUWSHcE3CHEA9pF8KqBc1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kxh/NzcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B464C4CEEB;
	Mon,  2 Jun 2025 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857815;
	bh=7KDs54ZB5iIkFgq/wnHQ+Aw471OQTM0nG9uitERQRBw=;
	h=Subject:To:Cc:From:Date:From;
	b=Kxh/NzcFLIGsv7s862fmkk2WbinE7g0wAqyQMA/3y6NJbVsrygvDVfHOcjv49lAZI
	 PrrBRMAxX1GXBl7X6qEJtBDr9RKQBQrh4NXKiZOSOCzkIf1q4PN1QX4siHN5m+iPpo
	 2laFmtmq3EEoubW+I+/UI6DCVa52mMvPx/DtASas=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: x1e78100-t14s: mark l12b and l15b always-on" failed to apply to 6.12-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:49:55 +0200
Message-ID: <2025060255-dislike-elaborate-1e0f@gregkh>
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
git cherry-pick -x 673fa129e558c5f1196adb27d97ac90ddfe4f19c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060255-dislike-elaborate-1e0f@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 673fa129e558c5f1196adb27d97ac90ddfe4f19c Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Fri, 14 Mar 2025 15:54:34 +0100
Subject: [PATCH] arm64: dts: qcom: x1e78100-t14s: mark l12b and l15b always-on

The l12b and l15b supplies are used by components that are not (fully)
described (and some never will be) and must never be disabled.

Mark the regulators as always-on to prevent them from being disabled,
for example, when consumers probe defer or suspend.

Fixes: 7d1cbe2f4985 ("arm64: dts: qcom: Add X1E78100 ThinkPad T14s Gen 6")
Cc: stable@vger.kernel.org	# 6.12
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20250314145440.11371-3-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index eff0e73640bc..160c052db1ec 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -456,6 +456,7 @@ vreg_l12b_1p2: ldo12 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l13b_3p0: ldo13 {
@@ -477,6 +478,7 @@ vreg_l15b_1p8: ldo15 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
 		};
 
 		vreg_l17b_2p5: ldo17 {


