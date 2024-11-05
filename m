Return-Path: <stable+bounces-89894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF99BD2DC
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E18541C222C0
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3C1D516F;
	Tue,  5 Nov 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XywpZdIG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238D17C7CE
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730825482; cv=none; b=clw3kPrr3L5OyOraovkExMGXojGBQTrGa4B6g/qTAZJSX8pWK9YZJ4hCnB154KqpQwL1I5nRhWJhvvO0hRVZFSKYrs+u5xO9SrIrgpRON77ZtAE0thyrKEkxV24WoXMLPpeQdnAND6y7M+RVa0+aTW9/UTosvGNuScE3CV2/UXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730825482; c=relaxed/simple;
	bh=0Lbe+TEPnIbs1p7etBsFHn22sHiVLMBls84qlNpRsJ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Wg9UIFhh0FSTIxfphvsgJpwjAjgOMkb6ZDxqjcC40R6VouqOS7STxkFYx5mYMGIt9J1Ntpf7nWuJSy62iQCqGefphFsdVsNbk8zwP1OSpT0/n02d0UtTno3mYsTMPx/Vo2DIMUlkoijptTnR5KHfeqYpKSbtrJgN91vSpAtXaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XywpZdIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29810C4CECF;
	Tue,  5 Nov 2024 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730825481;
	bh=0Lbe+TEPnIbs1p7etBsFHn22sHiVLMBls84qlNpRsJ8=;
	h=Subject:To:Cc:From:Date:From;
	b=XywpZdIGu9rdq7WhfkAOJtjbKS05SYA+xHAlR2C0uynVfNcrMRIM/qXz0uu6MbvFl
	 2gUeXZE2sg+89YfcLK1G7FcGZ+li2lGlJlBt7HHbV3HMe4h9VkbNurjn7SuOk7k0Dw
	 4myoLX6M1YHsnYvPv1uXbUfBSkLZHuTDRHbWsx5o=
Subject: FAILED: patch "[PATCH] soc: qcom: pmic_glink: Handle GLINK intent allocation" failed to apply to 6.6-stable tree
To: bjorn.andersson@oss.qualcomm.com,andersson@kernel.org,johan+linaro@kernel.org,johan@kernel.org,quic_clew@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:51:03 +0100
Message-ID: <2024110503-registry-reheat-cd11@gregkh>
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
git cherry-pick -x f8c879192465d9f328cb0df07208ef077c560bb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110503-registry-reheat-cd11@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8c879192465d9f328cb0df07208ef077c560bb1 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 23 Oct 2024 17:24:33 +0000
Subject: [PATCH] soc: qcom: pmic_glink: Handle GLINK intent allocation
 rejections

Some versions of the pmic_glink firmware does not allow dynamic GLINK
intent allocations, attempting to send a message before the firmware has
allocated its receive buffers and announced these intent allocations
will fail. When this happens something like this showns up in the log:

    pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
    pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125
    ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI read request: -125
    qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: failed to request power notifications

GLINK has been updated to distinguish between the cases where the remote
is going down (-ECANCELED) and the intent allocation being rejected
(-EAGAIN).

Retry the send until intent buffers becomes available, or an actual
error occur.

To avoid infinitely waiting for the firmware in the event that this
misbehaves and no intents arrive, an arbitrary 5 second timeout is
used.

This patch was developed with input from Chris Lew.

Reported-by: Johan Hovold <johan@kernel.org>
Closes: https://lore.kernel.org/all/Zqet8iInnDhnxkT9@hovoldconsulting.com/#t
Cc: stable@vger.kernel.org # rpmsg: glink: Handle rejected intent request better
Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Link: https://lore.kernel.org/r/20241023-pmic-glink-ecancelled-v2-2-ebc268129407@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 9606222993fd..baa4ac6704a9 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022, Linaro Ltd
  */
 #include <linux/auxiliary_bus.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -13,6 +14,8 @@
 #include <linux/soc/qcom/pmic_glink.h>
 #include <linux/spinlock.h>
 
+#define PMIC_GLINK_SEND_TIMEOUT (5 * HZ)
+
 enum {
 	PMIC_GLINK_CLIENT_BATT = 0,
 	PMIC_GLINK_CLIENT_ALTMODE,
@@ -112,13 +115,29 @@ EXPORT_SYMBOL_GPL(pmic_glink_client_register);
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 {
 	struct pmic_glink *pg = client->pg;
+	bool timeout_reached = false;
+	unsigned long start;
 	int ret;
 
 	mutex_lock(&pg->state_lock);
-	if (!pg->ept)
+	if (!pg->ept) {
 		ret = -ECONNRESET;
-	else
-		ret = rpmsg_send(pg->ept, data, len);
+	} else {
+		start = jiffies;
+		for (;;) {
+			ret = rpmsg_send(pg->ept, data, len);
+			if (ret != -EAGAIN)
+				break;
+
+			if (timeout_reached) {
+				ret = -ETIMEDOUT;
+				break;
+			}
+
+			usleep_range(1000, 5000);
+			timeout_reached = time_after(jiffies, start + PMIC_GLINK_SEND_TIMEOUT);
+		}
+	}
 	mutex_unlock(&pg->state_lock);
 
 	return ret;


