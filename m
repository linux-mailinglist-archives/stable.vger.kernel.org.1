Return-Path: <stable+bounces-118775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A3BA41B30
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCE23AB678
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA981EA7E6;
	Mon, 24 Feb 2025 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wOX+PaZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08A1E868
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740393257; cv=none; b=b/7sHVlxotHSTNfz+/HbImXKX9Bg1EXKtwfrlTHyzK+CjvYMAcHvUXfiiVYpk6gFFUCaY6Yc97syhmwTx6ReBFaCpRfMrXdlEOCg+dg83LIMOxbq44/rCmWM5kcvEbL5rH6ja5is+j3gSLMRW5pWqTLTP80Hpl7n2qAsF+lVIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740393257; c=relaxed/simple;
	bh=KvJ0+TwifnniBmeKq/niT7fqYo+61i4lPF4Rp14vyNM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oKYUqQydmZ2OooFfLRegBYZw0vFDH+DkpjbmlC6HIQvkpfo18BhC9K9ozB+b9lq99aYqvaLgY4uiq7jESKrAvscSpAGPNhgxZrPOV8gVWlvgzirAdpJYOIii0g7VVhANtnpw2RWc0HfCx0qV2fwgzyF98MxqVlxENtHDMRkn7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wOX+PaZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E6DC4CED6;
	Mon, 24 Feb 2025 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740393256;
	bh=KvJ0+TwifnniBmeKq/niT7fqYo+61i4lPF4Rp14vyNM=;
	h=Subject:To:Cc:From:Date:From;
	b=wOX+PaZJFiHlXxQ60vq+Lpfz8USPQBuiBD98jiZR5sT2L9ku1VVHUjjfDh74tK4wa
	 aEB/JggJuQSwdovH4CWiCuVzCiSaolOoZTcu4UB7ATTPlvDenCsWmF8YZUtW980rPF
	 2MOLSbWsbvlWEQDLvc2gKdnnDksJ5sPv+wSBz1UA=
Subject: FAILED: patch "[PATCH] EDAC/qcom: Correct interrupt enable register configuration" failed to apply to 5.10-stable tree
To: quic_kbajaj@quicinc.com,bp@alien8.de,manivannan.sadhasivam@linaro.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Feb 2025 11:34:00 +0100
Message-ID: <2025022400-flinch-overfeed-d8e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c158647c107358bf1be579f98e4bb705c1953292
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022400-flinch-overfeed-d8e9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


