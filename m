Return-Path: <stable+bounces-266915-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dINVEQIHM2qm8gUAu9opvQ
	(envelope-from <stable+bounces-266915-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:43:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA20F69C657
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:43:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eYvumKc2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266915-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266915-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3F6E3078E9C
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 20:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B0386C2C;
	Wed, 17 Jun 2026 20:43:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C437B00F
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781729021; cv=none; b=URu/qLLyhCsW6fVgaGz2UM+qekgkX4ZxsqsYDAU+mbUJowb5620NtYd43aCl8SWoBIu4ax3wiquEMJGewDe2Q94Y59vJVQIqRZwEuzavcSNglmFrdbLrZrcGNOoO9a0jJvn6tctg7vDhsvM7MeVCr1+rMIRfvZlS2ieyF/c22lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781729021; c=relaxed/simple;
	bh=bOhbmCt+oFVJ9jsKtMt74ZG6kg58YvXE5tI5hP57JQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn2nU+bBNyKZNf9J4SzVyJ9fdV583aOvlaCoqq1Pbpk6GwumpVab6N5eLLWCHce/AeuHTuVesH2WppqSRB0kmGM+y9psRnwZajTuDs6tSAOBsqwA48cws3uF1N0yvsmkezVRPpLEY+Uh9mg89bZCFElqU/3LtS4Gmz9NpmyWAQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYvumKc2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E481F000E9;
	Wed, 17 Jun 2026 20:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781729020;
	bh=BcjZCajz8vdCzFsPNlUqRx/Pt3voqk5LgBh+WwTdT8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eYvumKc26ppY59rh0506Q1e9QpL2RwK1wvceWhZClZ86P90oq1ksACOaKTcvYJnao
	 3QXThSK4CFBJES/4HNEH0dVvk0B1Uy4LJcd0V1HKmJlk0U3AsriNDYYoa5hEROX+qL
	 4bQpteE+jJdLFg4+pAYzmX8BK97s1C7/164xEh3qZbGUphBkavuG1etLnQt3XL3L23
	 senoLfcbkc3KMRpTm1puFhz2ABh262BCSQBFyDMZqq/+c28//o4ujH1QtzXJJUkp6w
	 TTvmPHCTbhCww65G4DrRkCJDm/KZucvsfcHWoY3MStpdrkxoC2zp6PQaOTP98YEFJa
	 rr+n6IvRJWu7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] slimbus: qcom-ngd-ctrl: Initialize controller resources in controller
Date: Wed, 17 Jun 2026 16:43:38 -0400
Message-ID: <20260617204338.352068-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061535-tables-coil-a9e2@gregkh>
References: <2026061535-tables-coil-a9e2@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266915-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bjorn.andersson@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA20F69C657

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
index 3fa245a472b2ee..c79589b194d3bd 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1506,25 +1506,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
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
@@ -1582,6 +1565,13 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
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
 		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
@@ -1603,14 +1593,19 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
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
 
@@ -1624,8 +1619,6 @@ static int qcom_slim_ngd_remove(struct platform_device *pdev)
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-	if (ctrl->mwq)
-		destroy_workqueue(ctrl->mwq);
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;
-- 
2.53.0


