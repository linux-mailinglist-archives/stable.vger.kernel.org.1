Return-Path: <stable+bounces-63010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561879416AE
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF281F24DAD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0E5188002;
	Tue, 30 Jul 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X/t2LKyU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B02187FF2;
	Tue, 30 Jul 2024 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355364; cv=none; b=SAcSTKiyzZsKeHJ48IQvDVqDDLjmJRzdlVcWr+zIunr6k1EeSWOh/TW8jgfhQwNsMntnuCmmHJ/QGA6ZjiXjHUrYhb6CaINSvPI/h3Ogh0YavE69DQtXo1HCIzHtLJhJVVktdp12EEEixRihaCKmFl6ci31TdASQHwMiw3QEOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355364; c=relaxed/simple;
	bh=hzVmCNDt94f4cm62y3G5oU87vKKnrqxFhLdyAEOgU7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=and2P+f5cmN4xiMA5Dcv0QvSmrjFx1YNEnJF88z7cr1JGWAhvcucxqVh/EU/dErJYDaWGXDQWxDNzCFzd1GFtHvSXG6dCXzDhyKbqKEQWrO29Z9tDn9pDRFwdWIJ8BI/sEtNVJQe1nhmpy4ntOSQ7ciI+xmR8Drkv3IPnhnVd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X/t2LKyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DE0C32782;
	Tue, 30 Jul 2024 16:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355364;
	bh=hzVmCNDt94f4cm62y3G5oU87vKKnrqxFhLdyAEOgU7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/t2LKyU2zu5a3bg02KlxMtOj8qFqruIY4bXHM7I7ELBo9LAidI1cfFCsFVxz+N78
	 mfYGklhT0DmHJ6hi0Be2Ko8MPdidKBf1cKZfCYEy7PPlANlK/PDcQBoza1RmKQZgha
	 zKawoS5UvIRod/uAvyOkVqldcn55dhZtcMQclMQs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rayyan Ansari <rayyan@ansari.sh>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 044/809] ARM: dts: qcom: msm8226-microsoft-common: Enable smbb explicitly
Date: Tue, 30 Jul 2024 17:38:40 +0200
Message-ID: <20240730151726.393141542@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rayyan Ansari <rayyan@ansari.sh>

[ Upstream commit 81a0a21b6159c6a9ed1e39c23e755cd05a102ce3 ]

Enable the smbb node explicitly for MSM8x26 Lumia devices. These devices
rely on the smbb driver in order to detect USB state.

It seems that this was accidentally missed in the commit that this
fixes.

Fixes: c9c8179d0ccd ("ARM: dts: qcom: Disable pm8941 & pm8226 smbb charger by default")
Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20240424174206.4220-1-rayyan@ansari.sh
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
index 525d8c608b06f..8839b23fc6936 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226-microsoft-common.dtsi
@@ -287,6 +287,10 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&smbb {
+	status = "okay";
+};
+
 &usb {
 	extcon = <&smbb>;
 	dr_mode = "peripheral";
-- 
2.43.0




