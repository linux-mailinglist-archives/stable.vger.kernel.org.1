Return-Path: <stable+bounces-114618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397FEA2F05B
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302A31882442
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77919204873;
	Mon, 10 Feb 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aWIBUT5k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717A20484A
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199186; cv=none; b=YCeohbr+BWOud6s8Lbdeexf4XkKhxmVGYucVVVuUJsQm13oH79g1pnW/ezUiKO2zeVQnLsaiGX+GVbtxyeMpyLHYBzyMor2zpXqI3nU1bE1IpAfpcWc+3Wjh7G9Oz7cE7BL5zt1rIzrAgmETJHBUxobotaLi7eKrHkJsfLNPbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199186; c=relaxed/simple;
	bh=YrEBI9iGyTnUXFsQv7Q9J6u2G/Mdq2QTQxZNnrH8t7g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iZvX5+pkr6F6cszvktyf8WsY7T1NAHZr7+yis5woSaSPup5eWhZvSFtC/swGVHa++hDnjbuSNdZ6ICcGsAxSD2ZoqKCI3opsmzKWOJkPEoiFwUaQQHOBv/En9Plwb8kplwqhiJkV5mO+FfZMqW73iNC2fXPk062QC01+PdkLg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aWIBUT5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A5EC4CED1;
	Mon, 10 Feb 2025 14:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199185;
	bh=YrEBI9iGyTnUXFsQv7Q9J6u2G/Mdq2QTQxZNnrH8t7g=;
	h=Subject:To:Cc:From:Date:From;
	b=aWIBUT5kwg3DCuK95dQ1HhsHQ14QhVIxCgU9Uk5BjHxu/AAWttuDGv2Tj+fxdJeEE
	 ZUeFiniaR6N0A5mNBhJZ6+haqZ7hWRqyoGDLp0E+TAKyK2OdwXzx0+DrEtu++k9mMF
	 2Nqi/tH+oHOGWnM8huWSze4Mz4eiRiDZpUy6qf4g=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sa8775p: Fix the size of 'addr_space'" failed to apply to 6.13-stable tree
To: manivannan.sadhasivam@linaro.org,andersson@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:53:02 +0100
Message-ID: <2025021002-fruit-finlike-25b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x ec2f548e1a92f49f765e2bce14ceed34698514fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021002-fruit-finlike-25b0@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec2f548e1a92f49f765e2bce14ceed34698514fc Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 31 Dec 2024 18:32:23 +0530
Subject: [PATCH] arm64: dts: qcom: sa8775p: Fix the size of 'addr_space'
 regions

For both the controller instances, size of the 'addr_space' region should
be 0x1fe00000 as per the hardware memory layout.

Otherwise, endpoint drivers cannot request even reasonable BAR size of 1MB.

Cc: stable@vger.kernel.org # 6.11
Fixes: c5f5de8434ec ("arm64: dts: qcom: sa8775p: Add ep pcie1 controller node")
Fixes: 1924f5518224 ("arm64: dts: qcom: sa8775p: Add ep pcie0 controller node")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20241231130224.38206-2-manivannan.sadhasivam@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 2429733ee36e..406698dfaf3c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -6478,7 +6478,7 @@ pcie0_ep: pcie-ep@1c00000 {
 		      <0x0 0x40000000 0x0 0xf20>,
 		      <0x0 0x40000f20 0x0 0xa8>,
 		      <0x0 0x40001000 0x0 0x4000>,
-		      <0x0 0x40200000 0x0 0x100000>,
+		      <0x0 0x40200000 0x0 0x1fe00000>,
 		      <0x0 0x01c03000 0x0 0x1000>,
 		      <0x0 0x40005000 0x0 0x2000>;
 		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
@@ -6636,7 +6636,7 @@ pcie1_ep: pcie-ep@1c10000 {
 		      <0x0 0x60000000 0x0 0xf20>,
 		      <0x0 0x60000f20 0x0 0xa8>,
 		      <0x0 0x60001000 0x0 0x4000>,
-		      <0x0 0x60200000 0x0 0x100000>,
+		      <0x0 0x60200000 0x0 0x1fe00000>,
 		      <0x0 0x01c13000 0x0 0x1000>,
 		      <0x0 0x60005000 0x0 0x2000>;
 		reg-names = "parf", "dbi", "elbi", "atu", "addr_space",


