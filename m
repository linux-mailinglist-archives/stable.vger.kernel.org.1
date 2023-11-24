Return-Path: <stable+bounces-251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8ED7F75DC
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B7B210FA
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 14:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB99328DC5;
	Fri, 24 Nov 2023 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FjxuxBbX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC78286BF
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 14:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC15C433CD;
	Fri, 24 Nov 2023 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700834441;
	bh=zjaWTL8QnUrENj6kSMTvb6L538s758TuZI52dbLFHnw=;
	h=Subject:To:Cc:From:Date:From;
	b=FjxuxBbXMacH89uQv1ZPr6bCiVgpYahOeapPAt+KWDvrTzoCf/RqXh4RkukRljD97
	 zltoGk9Z0ZocLntqTEBIoImYWgrJdzqiT2KPsfHiA+YcbuqwX+m+RXBFDoOpBhIgyo
	 earP7VNWwBjm9eA0csCxAwKnHCyEqXSFMBl+tD3c=
Subject: FAILED: patch "[PATCH] media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is" failed to apply to 6.1-stable tree
To: bryan.odonoghue@linaro.org,hverkuil-cisco@xs4all.nl,laurent.pinchart@ideasonboard.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 24 Nov 2023 14:00:38 +0000
Message-ID: <2023112438-resistant-countdown-f624@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e655d1ae9703286cef7fda8675cad62f649dc183
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023112438-resistant-countdown-f624@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e655d1ae9703 ("media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is greater than 3")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e655d1ae9703286cef7fda8675cad62f649dc183 Mon Sep 17 00:00:00 2001
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Wed, 30 Aug 2023 16:16:14 +0100
Subject: [PATCH] media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE when VC is
 greater than 3

VC_MODE = 0 implies a two bit VC address.
VC_MODE = 1 is required for VCs with a larger address than two bits.

Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
index 0f8ac29d038d..efc68f8b4de9 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
@@ -449,6 +449,8 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
 
 	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
+	if (vc > 3)
+		val |= 1 << CSI2_RX_CFG1_VC_MODE;
 	val |= 1 << CSI2_RX_CFG1_MISR_EN;
 	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
 


