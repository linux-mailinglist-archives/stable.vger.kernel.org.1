Return-Path: <stable+bounces-118774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD210A41B2D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 221B67A6BBC
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A2F1EA7E6;
	Mon, 24 Feb 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R5gzgTnu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782C19068E
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393244; cv=none; b=rasoRngB4bdoEqS+PV+BNu5dDMvrgT+ds2b00/Y/IxFJi7rtidYt4zEDs/iYbyLlnylpg0X6Bb2KkHXanLAjxPvrqBrjOFYV3JN59g9uukgKDhOMlJaej2tEsZvM1Z9qikawumBr4clMGaFQeV5iwRq8oZismpKF/jW9QwuaiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393244; c=relaxed/simple;
	bh=1+WsiAfj3ZBCOT4XImS68XvK6KaTeJq67hsjw8pt+EE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jk2bAPzAiEP07GtgjrX0CX007NetGCUHlrzL6L4qEypD9gamy4SNwA6nQpO6xEDl1Bs0vgdb++x9XhR9aatowBtWPEIHPKCk5PCnZ8f2d5wD4UVn36cSdbuY1J4kKMrKcsqDOsA2J/xyRImcWuhrQIwmGp3UoWREn23ABAOw/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R5gzgTnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4774CC4CEE6;
	Mon, 24 Feb 2025 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740393244;
	bh=1+WsiAfj3ZBCOT4XImS68XvK6KaTeJq67hsjw8pt+EE=;
	h=Subject:To:Cc:From:Date:From;
	b=R5gzgTnu7OrjxdWq6Wve8kKQWOgnsWzH8kL0q/g79XnhYxCVm0VmQk5cNeOzlWOyr
	 U24hFZh/99TjEx1A27f+6pwqEd/bZrLHnXOwlmfilDlw78w7hN//eV5Vi+4ZjvgEfs
	 mq6yYsunztVy7okvgj78WsEmkA3pTmTVc1c47WHc=
Subject: FAILED: patch "[PATCH] EDAC/qcom: Correct interrupt enable register configuration" failed to apply to 5.15-stable tree
To: quic_kbajaj@quicinc.com,bp@alien8.de,manivannan.sadhasivam@linaro.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:33:59 +0100
Message-ID: <2025022459-overdress-tank-afb8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c158647c107358bf1be579f98e4bb705c1953292
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022459-overdress-tank-afb8@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c158647c107358bf1be579f98e4bb705c1953292 Mon Sep 17 00:00:00 2001
From: Komal Bajaj <quic_kbajaj@quicinc.com>
Date: Tue, 19 Nov 2024 12:16:08 +0530
Subject: [PATCH] EDAC/qcom: Correct interrupt enable register configuration

The previous implementation incorrectly configured the cmn_interrupt_2_enable
register for interrupt handling. Using cmn_interrupt_2_enable to configure
Tag, Data RAM ECC interrupts would lead to issues like double handling of the
interrupts (EL1 and EL3) as cmn_interrupt_2_enable is meant to be configured
for interrupts which needs to be handled by EL3.

EL1 LLCC EDAC driver needs to use cmn_interrupt_0_enable register to configure
Tag, Data RAM ECC interrupts instead of cmn_interrupt_2_enable.

Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for QCOM SoCs")
Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20241119064608.12326-1-quic_kbajaj@quicinc.com

diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
index 04c42c83a2ba..f3da9385ca0d 100644
--- a/drivers/edac/qcom_edac.c
+++ b/drivers/edac/qcom_edac.c
@@ -95,7 +95,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 	 * Configure interrupt enable registers such that Tag, Data RAM related
 	 * interrupts are propagated to interrupt controller for servicing
 	 */
-	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
 				 TRP0_INTERRUPT_ENABLE,
 				 TRP0_INTERRUPT_ENABLE);
 	if (ret)
@@ -113,7 +113,7 @@ static int qcom_llcc_core_setup(struct llcc_drv_data *drv, struct regmap *llcc_b
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_2_enable,
+	ret = regmap_update_bits(llcc_bcast_regmap, drv->edac_reg_offset->cmn_interrupt_0_enable,
 				 DRP0_INTERRUPT_ENABLE,
 				 DRP0_INTERRUPT_ENABLE);
 	if (ret)


