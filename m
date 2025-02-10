Return-Path: <stable+bounces-114619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB2A2F05C
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CCD1889A98
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179D2204840;
	Mon, 10 Feb 2025 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PXMQoC+B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40335280
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199196; cv=none; b=Lx2z3ArozSUf13dsYh6OUV8hUHlDNldfeM0S5/3vagHXwqJF3u+NNJWwE3BasW4qM/gQGwac7JyH4owyU3BlSu6glLh58pYqxbp5dyyr068J+cgpZIc+ObNxFUapaZZNHRsXY+FvhLK2FUcc6E8Ycs+pfE1sRIipqRxUZCdxGgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199196; c=relaxed/simple;
	bh=yasNjflfLdynTUv51HZjjIW5s7e+2C2N1MTT0HFDPNQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WniRg3xOJC9XeiBibqWfLk+zFum9vSHQE382GCddCwYdGGeZQzoRiKZwC7Cz7YSjsHah6/BwuUQQkF6//NfxkGr2iEAcbOdysYucF/1dqyoXHB/mKLrCcUH6YUyVXcy5VLqJfi58POTCOKKPqolYy1TNiOCpQmUFhp0KLJnTLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PXMQoC+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D129CC4CEDF;
	Mon, 10 Feb 2025 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199194;
	bh=yasNjflfLdynTUv51HZjjIW5s7e+2C2N1MTT0HFDPNQ=;
	h=Subject:To:Cc:From:Date:From;
	b=PXMQoC+BS0AUaCZZvRtpdRBVB/RTJe0Bfx1HMQogCDFgsGGLKEzdSUiyr4KU39FRW
	 pGbZ7p9B/8j+Dm/oLt6pA8UQfGrEgvMH+Hi+IVA6EJ6Io3P2FB91a0yq1YLsd1aPgA
	 A8/1fgNlSPFXUNJ/rWTmWlsyknb2ZCGX4hUJ5xP4=
Subject: FAILED: patch "[PATCH] arm64: dts: qcom: sa8775p: Fix the size of 'addr_space'" failed to apply to 6.12-stable tree
To: manivannan.sadhasivam@linaro.org,andersson@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:53:03 +0100
Message-ID: <2025021003-kennel-gnarly-379b@gregkh>
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
git cherry-pick -x ec2f548e1a92f49f765e2bce14ceed34698514fc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021003-kennel-gnarly-379b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


