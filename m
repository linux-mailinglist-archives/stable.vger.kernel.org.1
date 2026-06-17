Return-Path: <stable+bounces-266902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nk+TM4v9Mmpl8QUAu9opvQ
	(envelope-from <stable+bounces-266902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:03:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3895069C499
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 22:03:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GKEOGha0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266902-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266902-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46133305993B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824392F0680;
	Wed, 17 Jun 2026 20:02:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8AE375F8E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:02:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726565; cv=none; b=nm4sHUi2TZd0+Z5hriMBePTL9Y069lFBcRfIyCmJhG3RIYDhTiMPSInttwtPCd0MzyNSjvw+OUWiARpl7GGlnWPy2BeFGBR1wRgOg5vcRuUCa1MErqGP6Hh5denUd3hDOnhGVKDCWSAEzhvylCJ0nS2QtQxG7IbPPj9mejxpiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726565; c=relaxed/simple;
	bh=AJy/oPVc2UUOK5sai0qM27japaon0R+yFtlDmHUyj8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzBkA0RVugYWg7ZnrTm2gr45KMMgsyjAPyCpo1cjxNV/+vUNyGA0p9WXduXHpn4by+3ynsmEEBIqAlYA0Np6DD8ps5YhagMaPaqJg6RZzECjLyxsDTXSiJEqcPYTM/j9jWKrKjDrrYHm+Yu8MQJUrjQe8iA64q/K0uhbTpXQUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKEOGha0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570571F00A3A;
	Wed, 17 Jun 2026 20:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781726564;
	bh=fWV/kVk3OH0LPvI5nm93z4iXlV23rCH3jGMftqWqSiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKEOGha03lGz86BTh9QiRw0Hg17PLQ5GtYQ42eH7SFGp8thEo6wVm8aMy1btsL9an
	 RQYNS154HSDEDPeb0aGJWau32fgb1BzAZ21+GpDtNq+y7oOBIRad/1nSu1r6RNM64H
	 T4pGMcOiKADkcdRJpzmLzY3ON6jERew7ovEkiApPPjkYyWfASbWFf6ylR8gb/2KnvM
	 pW/pC1bwapiI2xTGEmrdyLgCPejvxgw1L2ml1MTK9Ei1WWtfEvUmHiLFUlnlMUGYEt
	 8gSY40W86DZffaVraXJcgDll5Z9Nkwvwuk0KR+M5r+TmOCAI+UCA7N8H8pmo6YZql1
	 pSO90gFzQcsBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] slimbus: qcom-ngd-ctrl: Fix up platform_driver registration
Date: Wed, 17 Jun 2026 16:02:39 -0400
Message-ID: <20260617200241.310475-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617200241.310475-1-sashal@kernel.org>
References: <2026061505-reverb-graceful-8efb@gregkh>
 <20260617200241.310475-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266902-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bjorn.andersson@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:mukesh.ojha@oss.qualcomm.com,m:srini@kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:email,qualcomm.com:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3895069C499

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 8663e8334d7b6007f5d8a4e5dd270246f35107a6 ]

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
Stable-dep-of: 2a9d50e9ea40 ("slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 36 ++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 04a73dffeb1041..f8cc2c93e8e999 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1564,6 +1564,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
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
@@ -1666,7 +1673,6 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 		goto err_pdr_lookup;
 	}
 
-	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 
 err_pdr_alloc:
@@ -1680,7 +1686,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
-	platform_driver_unregister(&qcom_slim_ngd_driver);
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
+	qcom_slim_ngd_unregister(ctrl);
 }
 
 static void qcom_slim_ngd_remove(struct platform_device *pdev)
@@ -1756,6 +1764,28 @@ static struct platform_driver qcom_slim_ngd_driver = {
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
-- 
2.53.0


