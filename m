Return-Path: <stable+bounces-263360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sbmDGCYiMGp6OgUAu9opvQ
	(envelope-from <stable+bounces-263360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:02:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D806880CE
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 18:02:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=tapptrVp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263360-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263360-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6701131732F4
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5D3C65FE;
	Mon, 15 Jun 2026 15:52:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195313074B1
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:52:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538731; cv=none; b=V4mWcDoSP8w5dK6xGmvoJqA0du8LYGlh8nQKZCulvxcFX56Le1Gep86mryiG9kTkjTdcfBggLDvxJPHqJkNZ9Oh2m64DV8iZQKRtnXA9n3f8O2QM6ntVqHnjECpDNFXYOIiyRu98Th64h+TUkw3iiIzJgxuc1Mv7XCrNTgkSjT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538731; c=relaxed/simple;
	bh=6YGa/sKHrROMCndS3QEiSI3Dc8tMgXbIteX/xj8DXnQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c5+gZgYuCIzb2MtxjnylzICDBUX4czMB+bZvpJZurOYuTPrTOd3yixanlrP443zVmk9TPRh7LBylboS+SadfW93d7a2Uypq0mr4NSa4q/cBZ7svnqV0Wq1CVtfeHNpFDMmrBus2ZF26Gi12vgXuc7vFs8JquPlY3FowE7slCggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tapptrVp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FEA1F00A3A;
	Mon, 15 Jun 2026 15:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781538729;
	bh=Jdn2KQBq2KdPr88xNIgQ+a68k1B18N9zIRUf9vA3JzI=;
	h=Subject:To:Cc:From:Date;
	b=tapptrVppXSxZysDzfElYlZ+nbh5wY1y4/JHKwT4Ci3HjK9Cf+ZDhxFFT1Yw31m63
	 knwnjwzaEVr85h7yZ0wC2LBu6OsvBIzgHL8hSTWzowkJaXHa5ofH2hjixFo+Mbj+og
	 aUdh34590hGTG3g+vWtGnzrTImHdsLqpZmqUxW+8=
Subject: FAILED: patch "[PATCH] slimbus: qcom-ngd-ctrl: Fix up platform_driver registration" failed to apply to 6.1-stable tree
To: bjorn.andersson@oss.qualcomm.com,dmitry.baryshkov@oss.qualcomm.com,gregkh@linuxfoundation.org,mukesh.ojha@oss.qualcomm.com,srini@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:46:19 +0200
Message-ID: <2026061519-vest-submerge-1c40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bjorn.andersson@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:gregkh@linuxfoundation.org,m:mukesh.ojha@oss.qualcomm.com,m:srini@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263360-lists,stable=lfdr.de];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01D806880CE


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8663e8334d7b6007f5d8a4e5dd270246f35107a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061519-vest-submerge-1c40@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8663e8334d7b6007f5d8a4e5dd270246f35107a6 Mon Sep 17 00:00:00 2001
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:44:15 +0100
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Fix up platform_driver registration

Device drivers should not invoke platform_driver_register()/unregister()
in their probe and remove paths. They should further not rely on
platform_driver_unregister() as their only means of "deleting" their
child devices.

Introduce a helper to unregister the child device and move the
platform_driver_register()/unregister() to module_init()/exit().

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 428266949fdd..47ba9fb34d25 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1560,6 +1560,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	return -ENODEV;
 }
 
+static void qcom_slim_ngd_unregister(struct qcom_slim_ngd_ctrl *ctrl)
+{
+	struct qcom_slim_ngd *ngd = ctrl->ngd;
+
+	platform_device_del(ngd->pdev);
+}
+
 static int qcom_slim_ngd_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1662,7 +1669,6 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 		goto err_pdr_lookup;
 	}
 
-	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 
 err_pdr_alloc:
@@ -1676,7 +1682,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
-	platform_driver_unregister(&qcom_slim_ngd_driver);
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
+	qcom_slim_ngd_unregister(ctrl);
 }
 
 static void qcom_slim_ngd_remove(struct platform_device *pdev)
@@ -1752,6 +1760,28 @@ static struct platform_driver qcom_slim_ngd_driver = {
 	},
 };
 
-module_platform_driver(qcom_slim_ngd_ctrl_driver);
+static int qcom_slim_ngd_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&qcom_slim_ngd_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&qcom_slim_ngd_ctrl_driver);
+	if (ret)
+		platform_driver_unregister(&qcom_slim_ngd_driver);
+
+	return ret;
+}
+
+static void qcom_slim_ngd_exit(void)
+{
+	platform_driver_unregister(&qcom_slim_ngd_ctrl_driver);
+	platform_driver_unregister(&qcom_slim_ngd_driver);
+}
+
+module_init(qcom_slim_ngd_init);
+module_exit(qcom_slim_ngd_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Qualcomm SLIMBus NGD controller");


