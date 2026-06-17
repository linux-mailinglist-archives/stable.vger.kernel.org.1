Return-Path: <stable+bounces-266917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9IOqIksKM2oT8wUAu9opvQ
	(envelope-from <stable+bounces-266917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:57:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CC969C72D
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:57:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PMGGgh9G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266917-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266917-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90E663044711
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321393AFB18;
	Wed, 17 Jun 2026 20:57:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CD38D41A
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:57:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729865; cv=none; b=m8cLVtYNvJGYdHJZsUJb1ouyrlRtsTEIdEIHmu3/STPi6gz9T9KnIMuMCKKlg4RG/iL6BVlGEuB2S/y/Cc8QbC9fYUBW/pJLJRrkixUmoACos5RO1658XjT+04PO2SOTAkWE+GZrZT7rpIPOOBsVuXjCXFSny2Mz2PleonmRySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729865; c=relaxed/simple;
	bh=uKNqGESSw9Xcv0pxQ42mPBXbDqpuDvTntaFyy1tc2Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzIyne2fMJG9ixHwjWe200i80bLQyujpFY4wB0pWJC/etgpT5U1g2asx0gAl8r8lLx30EFPAtUJ4HWSXjGfgqQqEW0OVuJouF9d+t3O9CcQn6pmrMq8OkdJgK6c3jcGnr8t5bowa1cMAjPlpYvIlnYO85pkrSlOAxEYWWObkoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMGGgh9G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178D71F000E9;
	Wed, 17 Jun 2026 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729863;
	bh=pVTh6GeXxxWerWiVxGQD1CH2/WADkTaDGuCf9O38P7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PMGGgh9GmeDZpLct7RBJv2Xw3FYmnuiPQdN55KiNv57XRhLsArWIf16tX7EmXgq/H
	 dXD9EkOB1irgWhKbk0cI4WNAldCAqksbPm6NJDZ8PV5G37zDpU5IBlEXl8ROHl60Ww
	 iQR6NMsQ89NLmTPm5ZiwLoiSAVeVQubDV50XVTKN7ktr8iTqfm25MaMLv+WO1x3uqU
	 EsKAfCwioU63oiePPcIBIKzfLK9HiUl7sWRLsRivIfcXptY+LqOcG1bER3PYrmkXFw
	 5vCZhKavF/EUmojJdd3hL/qgtkByE80sM43KNKu69HigiXhtxfcx6LSWdf57NYYpBA
	 1ELZEhEbKuKUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] slimbus: qcom-ngd-ctrl: Initialize controller resources in controller
Date: Wed, 17 Jun 2026 16:57:41 -0400
Message-ID: <20260617205741.371145-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061537-motto-browsing-ffb0@gregkh>
References: <2026061537-motto-browsing-ffb0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bjorn.andersson@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266917-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5CC969C72D

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 07c564ea5fb859b7381429de935d5df4781947c6 ]

The work structs and work queue are controller resources, create and
destroy them in the controller context. Creating them as part of the
child device's probe path seems to be okay now that the controller's
probe has been updated, but if for some reason the child does not probe
successfully a SSR or PDR notification will schedule_work() on an
uninitialized "ngd_up_work".

Move the initialization of these controller resources to the controller
probe function to avoid any issues, and to clarify the ownership.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-7-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ed1eb491430bac..4005eeab8bbd1a 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1489,25 +1489,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
-		return ret;
-	}
-
-	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
-	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
-	ctrl->mwq = create_singlethread_workqueue("ngd_master");
-	if (!ctrl->mwq) {
-		dev_err(&pdev->dev, "Failed to start master worker\n");
-		ret = -ENOMEM;
-		goto wq_err;
-	}
-
-	return 0;
-wq_err:
-	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-	if (ctrl->mwq)
-		destroy_workqueue(ctrl->mwq);
 
 	return ret;
 }
@@ -1569,6 +1552,13 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->qmi.qmi_comp);
 	init_completion(&ctrl->qmi_up);
 
+	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
+	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
+
+	ctrl->mwq = create_singlethread_workqueue("ngd_master");
+	if (!ctrl->mwq)
+		return dev_err_probe(dev, -ENOMEM, "Failed to start master worker\n");
+
 	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
 	if (IS_ERR(ctrl->pdr)) {
 		dev_err(dev, "Failed to init PDR handle\n");
@@ -1591,14 +1581,19 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 err_pdr_lookup:
 	pdr_handle_release(ctrl->pdr);
+	destroy_workqueue(ctrl->mwq);
 
 	return ret;
 }
 
 static int qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
 	platform_driver_unregister(&qcom_slim_ngd_driver);
 
+	destroy_workqueue(ctrl->mwq);
+
 	return 0;
 }
 
@@ -1612,8 +1607,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-	if (ctrl->mwq)
-		destroy_workqueue(ctrl->mwq);
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;
-- 
2.53.0


