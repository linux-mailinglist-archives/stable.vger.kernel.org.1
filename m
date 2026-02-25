Return-Path: <stable+bounces-219191-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMWRO2aFnmmGVwQAu9opvQ
	(envelope-from <stable+bounces-219191-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:15:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21591191E22
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACFF230FA4AA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 05:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600582D7DF1;
	Wed, 25 Feb 2026 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dh5p2mnr"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43AF2D7DE7;
	Wed, 25 Feb 2026 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771996254; cv=none; b=pNfbA2McqfHi7DQXmU9nDqLS5QUdEBbf1X9o4GylImFftgh3xiLvRnLTJUi48sqeeZJj4VeyGyZ5/v0xmrAVdgRB+GGmVF4d/+tTr9XmdX3y/Hes1QXG9FA73dZnTcBXzu/c91GEWI2dWv5LeQi3UaJkjh+lVCZ3BzfLPQCJ6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771996254; c=relaxed/simple;
	bh=XN8V5/NwlfkhYcM3yCngH5tWriYsrfiwq/1PFjo8gDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lamuh5zfLjTxVIEkcxCjisdH/kvbYchx77K2Q6UWwZyvnAoVDa9Vf+3zYyrExHmYKLlSBP3kfk5RwVxWSpiKxdnBwUvY1dSv5OE50soY0b24IB4NkURkvpVP9tJxp0uQjjsCJl5sbDtTGabqiYtWwKNEaqyzoiVNVY/M/2S3IdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dh5p2mnr; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=v1
	t4CMFI2vhOcmY+2r50Q5PeDVZ8H7dvDUdVDkY2X4A=; b=dh5p2mnrfkvHFoBucE
	dB++ZrFu14tAFSUNNY7QSH64Cza5gZ0KTVR621g714zZShvD6r0Hh9gtnuIOviuT
	DMDOcHD2rukXFQhICQ3UZKv06jOQ1/xiAqA/6Xkt9mWwejGwJJzyfULBg30/fb1Z
	G0MKnvvOGouLfawGokFNbY/8A=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wAHb3MxhJ5pdzFwOw--.824S2;
	Wed, 25 Feb 2026 13:10:10 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.6.y] usb: typec: ucsi: Move unregister out of atomic section
Date: Wed, 25 Feb 2026 13:10:08 +0800
Message-Id: <20260225051008.2547855-1-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHb3MxhJ5pdzFwOw--.824S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFWUAr1UZF1kWrW5urWUtwb_yoW7Xw1fp3
	42ka43Cr4UXay2gwsrWFZ0vFy5WF1kta9Fy3s7u343XFsxKw1DWry0yFyaqFy5Wr4kGF9r
	Kr4DtrW5Cr1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEyCJJUUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+hIvyGmehDK-DgAA3-
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,quicinc.com,linux.intel.com,linaro.org,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-219191-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	TAGGED_RCPT(0.00)[stable,linaro];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:email]
X-Rspamd-Queue-Id: 21591191E22
X-Rspamd-Action: no action

From: Bjorn Andersson <quic_bjorande@quicinc.com>

[ Upstream commit 11bb2ffb679399f99041540cf662409905179e3a ]

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
[ The context change is due to the commit 584e8df58942
("usb: typec: ucsi: extract common code for command handling")
in v6.11 which is irrelevant to the logic of this patch. ]
Signed-off-by: Rahul Sharma <black.hawk@163.com>
---
 drivers/soc/qcom/pmic_glink.c       | 10 +++++++++-
 drivers/usb/typec/ucsi/ucsi_glink.c | 27 ++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 2222ca4fa6e2..ae8bf1f4116a 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -115,8 +115,16 @@ EXPORT_SYMBOL_GPL(pmic_glink_client_register);
 int pmic_glink_send(struct pmic_glink_client *client, void *data, size_t len)
 {
 	struct pmic_glink *pg = client->pg;
+	int ret;
+
+	mutex_lock(&pg->state_lock);
+	if (!pg->ept)
+		ret = -ECONNRESET;
+	else
+		ret = rpmsg_send(pg->ept, data, len);
+	mutex_unlock(&pg->state_lock);
 
-	return rpmsg_send(pg->ept, data, len);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(pmic_glink_send);
 
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 82a1081d44f1..cddbeae91419 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -72,6 +72,9 @@ struct pmic_glink_ucsi {
 
 	struct work_struct notify_work;
 	struct work_struct register_work;
+	spinlock_t state_lock;
+	bool ucsi_registered;
+	bool pd_running;
 
 	u8 read_buf[UCSI_BUF_SIZE];
 };
@@ -270,8 +273,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
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
@@ -295,11 +310,12 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
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
@@ -332,6 +348,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 	init_completion(&ucsi->read_ack);
 	init_completion(&ucsi->write_ack);
 	init_completion(&ucsi->sync_ack);
+	spin_lock_init(&ucsi->state_lock);
 	mutex_init(&ucsi->lock);
 
 	ucsi->ucsi = ucsi_create(dev, &pmic_glink_ucsi_ops);
-- 
2.34.1


