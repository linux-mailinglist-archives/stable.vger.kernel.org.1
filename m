Return-Path: <stable+bounces-71706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADD89675BE
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 11:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A704D1C20CB0
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 09:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ECD1448CD;
	Sun,  1 Sep 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bYfwKmG3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2331CD29
	for <stable@vger.kernel.org>; Sun,  1 Sep 2024 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725182786; cv=none; b=Tb1DzKCNmSZ4WXdrd0KcvA1WzS8bGQHIZdy91kSOtSGeOw6KhmWucg8w8S9IfeLKNhcOueFsU0ogsw7Sy/OEpsd2WwcT6IZvRCHSS+FQRsxBDSsI4Nt92TjWR7N45MsNn/5FkA0mldtcqvFGw4akQi7q12VCfUDtkBiO4VbsS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725182786; c=relaxed/simple;
	bh=HLrNqDfC32v/ze+8rrONx3rfNxNj1AZM9nOpfmi/OuU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TfXKP8CtpZ4tdCBvZ4qAJlWqrIxUR6UvGVYJg8yCphZVmFn7xu2hdYZZDP16ZYYehOLvs9C+kfdtGwAeI2Q/+zwTDxio2VBaQo55r6HblCYG2IvUL6cYVmV3gAany99yD64SUX3AzZzl+45pjJg9YQaNlCbVKG6z+ZoanRQ5WDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bYfwKmG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC326C4CEC3;
	Sun,  1 Sep 2024 09:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725182785;
	bh=HLrNqDfC32v/ze+8rrONx3rfNxNj1AZM9nOpfmi/OuU=;
	h=Subject:To:Cc:From:Date:From;
	b=bYfwKmG3wPP4JmTtgP8tdG7/rmUfNEjU+hVpxnZZ5Wp8EC1VDdjdGJD7fTG8fyolP
	 5d7j9kuImMayWYhzVeR5bKuapBJ8H1S98GVg6RLaXY7OocsUmVnT14CZAswheEetN8
	 Ip403Xw3/wAHt9PbXd/3eMD1QkSJyBxUrTu/CbZ8=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Move unregister out of atomic section" failed to apply to 6.6-stable tree
To: quic_bjorande@quicinc.com,amit.pundir@linaro.org,andersson@kernel.org,dmitry.baryshkov@linaro.org,heikki.krogerus@linux.intel.com,johan+linaro@kernel.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 01 Sep 2024 11:26:21 +0200
Message-ID: <2024090121-distress-disengage-545d@gregkh>
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
git cherry-pick -x 11bb2ffb679399f99041540cf662409905179e3a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090121-distress-disengage-545d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

11bb2ffb6793 ("usb: typec: ucsi: Move unregister out of atomic section")
584e8df58942 ("usb: typec: ucsi: extract common code for command handling")
e1870c17e550 ("usb: typec: ucsi: inline ucsi_read_message_in")
5e9c1662a89b ("usb: typec: ucsi: rework command execution functions")
467399d989d7 ("usb: typec: ucsi: split read operation")
13f2ec3115c8 ("usb: typec: ucsi: simplify command sending API")
a7d2fa776976 ("usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()")
f7697db8b1b3 ("Merge 6.10-rc6 into usb-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11bb2ffb679399f99041540cf662409905179e3a Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <quic_bjorande@quicinc.com>
Date: Tue, 20 Aug 2024 13:29:31 -0700
Subject: [PATCH] usb: typec: ucsi: Move unregister out of atomic section

Commit '9329933699b3 ("soc: qcom: pmic_glink: Make client-lock
non-sleeping")' moved the pmic_glink client list under a spinlock, as it
is accessed by the rpmsg/glink callback, which in turn is invoked from
IRQ context.

This means that ucsi_unregister() is now called from atomic context,
which isn't feasible as it's expecting a sleepable context. An effort is
under way to get GLINK to invoke its callbacks in a sleepable context,
but until then lets schedule the unregistration.

A side effect of this is that ucsi_unregister() can now happen
after the remote processor, and thereby the communication link with it, is
gone. pmic_glink_send() is amended with a check to avoid the resulting NULL
pointer dereference.
This does however result in the user being informed about this error by
the following entry in the kernel log:

  ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI write request: -5

Fixes: 9329933699b3 ("soc: qcom: pmic_glink: Make client-lock non-sleeping")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Amit Pundir <amit.pundir@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Link: https://lore.kernel.org/r/20240820-pmic-glink-v6-11-races-v3-2-eec53c750a04@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 53b176d04fbd..b218460219b7 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -112,8 +112,16 @@ EXPORT_SYMBOL_GPL(pmic_glink_client_register);
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 {
 	struct pmic_glink *pg = client->pg;
+	int ret;
 
-	return rpmsg_send(pg->ept, data, len);
+	mutex_lock(&pg->state_lock);
+	if (!pg->ept)
+		ret = -ECONNRESET;
+	else
+		ret = rpmsg_send(pg->ept, data, len);
+	mutex_unlock(&pg->state_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pmic_glink_send);
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index f6f4fae40399..6aace19d595b 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -68,6 +68,9 @@ struct pmic_glink_ucsi {
 
 	struct work_struct notify_work;
 	struct work_struct register_work;
+	spinlock_t state_lock;
+	bool ucsi_registered;
+	bool pd_running;
 
 	u8 read_buf[UCSI_BUF_SIZE];
 };
@@ -244,8 +247,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 static void pmic_glink_ucsi_register(struct work_struct *work)
 {
 	struct pmic_glink_ucsi *ucsi = container_of(work, struct pmic_glink_ucsi, register_work);
+	unsigned long flags;
+	bool pd_running;
 
-	ucsi_register(ucsi->ucsi);
+	spin_lock_irqsave(&ucsi->state_lock, flags);
+	pd_running = ucsi->pd_running;
+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
+
+	if (!ucsi->ucsi_registered && pd_running) {
+		ucsi_register(ucsi->ucsi);
+		ucsi->ucsi_registered = true;
+	} else if (ucsi->ucsi_registered && !pd_running) {
+		ucsi_unregister(ucsi->ucsi);
+		ucsi->ucsi_registered = false;
+	}
 }
 
 static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
@@ -269,11 +284,12 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
 static void pmic_glink_ucsi_pdr_notify(void *priv, int state)
 {
 	struct pmic_glink_ucsi *ucsi = priv;
+	unsigned long flags;
 
-	if (state == SERVREG_SERVICE_STATE_UP)
-		schedule_work(&ucsi->register_work);
-	else if (state == SERVREG_SERVICE_STATE_DOWN)
-		ucsi_unregister(ucsi->ucsi);
+	spin_lock_irqsave(&ucsi->state_lock, flags);
+	ucsi->pd_running = (state == SERVREG_SERVICE_STATE_UP);
+	spin_unlock_irqrestore(&ucsi->state_lock, flags);
+	schedule_work(&ucsi->register_work);
 }
 
 static void pmic_glink_ucsi_destroy(void *data)
@@ -320,6 +336,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	INIT_WORK(&ucsi->register_work, pmic_glink_ucsi_register);
 	init_completion(&ucsi->read_ack);
 	init_completion(&ucsi->write_ack);
+	spin_lock_init(&ucsi->state_lock);
 	mutex_init(&ucsi->lock);
 
 	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);


