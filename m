Return-Path: <stable+bounces-43628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DFC8C419B
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4EA2B217D0
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE2D1514E2;
	Mon, 13 May 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G8tDgjf/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FEC59164
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606192; cv=none; b=i1K0XiudYQvdUbVo4pv4BjN8batXQD2U3P1OOIgqnaC7GUmOlkIP2w9Tytpu0ya8QgGJcjbJoRSjw8c9BAyKhbY3kTaZATSS60MFExsE/ZL66i91UKoOPTVTV+vcsZAwnM5PiyXWCI8E5UAOtsMlwFB4MsKa86NevO4xqRHT5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606192; c=relaxed/simple;
	bh=qBOK0s4Bvn1KTAvNQSFS0U4J3Io3JjiaisMvBLE2mtY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OpdqZAcdSPvY0Zv87G7gDxQ2PQ+A1nSiMIAzfSc3iZ43BC7V/mWVo2nBTF3k0hysPWCFwArMHJUZpkH474QRVVXwrr7XSiMx/Flo0NnT8rxmxSXpM/54DePhlOe0klL15s7tWBQng3J9hKps8b7SriqWGmpsHbSCOR2TnObsiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G8tDgjf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A083C113CC;
	Mon, 13 May 2024 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715606192;
	bh=qBOK0s4Bvn1KTAvNQSFS0U4J3Io3JjiaisMvBLE2mtY=;
	h=Subject:To:Cc:From:Date:From;
	b=G8tDgjf/H98V//qK6+Byipt4SYsiBakE/h9QpYaWwuA9RIIbA3nkPore/fnvYS2DW
	 CKbCr7CJfXcYQ6iX0z4gahQye7eGHo5G3S81JJcvU2YJ/FnEs6krw3+I+4Q9gS3wTy
	 tgUtGzuoZS9t2ZCUYilLj9CDjLy3D+XbdSFBsidg=
Subject: FAILED: patch "[PATCH] usb: typec: qcom-pmic: fix use-after-free on late probe" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,bryan.odonoghue@linaro.org,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:16:21 +0200
Message-ID: <2024051321-backyard-cranial-5f34@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d80eee97cb4e90768a81c856ac71d721996d86b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051321-backyard-cranial-5f34@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

d80eee97cb4e ("usb: typec: qcom-pmic: fix use-after-free on late probe errors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d80eee97cb4e90768a81c856ac71d721996d86b7 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Thu, 18 Apr 2024 16:57:29 +0200
Subject: [PATCH] usb: typec: qcom-pmic: fix use-after-free on late probe
 errors

Make sure to stop and deregister the port in case of late probe errors
to avoid use-after-free issues when the underlying memory is released by
devres.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable@vger.kernel.org	# 6.5
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240418145730.4605-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index e48412cdcb0f..d3958c061a97 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -104,14 +104,18 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 
 	ret = tcpm->port_start(tcpm, tcpm->tcpm_port);
 	if (ret)
-		goto fwnode_remove;
+		goto port_unregister;
 
 	ret = tcpm->pdphy_start(tcpm, tcpm->tcpm_port);
 	if (ret)
-		goto fwnode_remove;
+		goto port_stop;
 
 	return 0;
 
+port_stop:
+	tcpm->port_stop(tcpm);
+port_unregister:
+	tcpm_unregister_port(tcpm->tcpm_port);
 fwnode_remove:
 	fwnode_remove_software_node(tcpm->tcpc.fwnode);
 


