Return-Path: <stable+bounces-263257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VHNAHvURMGpvMwUAu9opvQ
	(envelope-from <stable+bounces-263257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:53:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA19687625
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:53:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MqDC13mo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263257-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263257-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C79003076E38
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCB83FBEAC;
	Mon, 15 Jun 2026 14:43:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AF3FBB68
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:43:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534636; cv=none; b=mVcOqERXFhsfPC3jkKZxlst4nD06adSUJF/VNqArIf9oLlw9zpXsUfqk3Mx+loI+WSeZ+/2eeLTg2ziboelW5FILraessafZxXsWxcuqOWqNZ/AMKlBinkqW/CpV6ViAh+f8qEKZteHrjDmubhHjxM1IsvLLLdP1Om3bKAui8dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534636; c=relaxed/simple;
	bh=jAytqilMThdh1/iVQrmDplkY7uXRR3e0JC+TOJ9+Uq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLKd89jJnNvC+nA3/YVOLvLiHN0F7mKpUpn3KHoCeHEGb4heu3PMxU6GXCNjMdA87omZsMonhAGCLfTeesiD4Qv3FgWfjgLVctxgT8TDIFA4rt5t7plk2OOkinO5cGNi78DiEoVHw/zfPMBld2TEGaJyfScclsALnhHAkkm3tvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqDC13mo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EC01F000E9;
	Mon, 15 Jun 2026 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781534634;
	bh=IvmzOw5YZNW5PBcMLTJ6WdLrJ6BxRKyVz7YsQla7mto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MqDC13moc0wT+2HARHJEcD8HygCIkwZM2lNaXGsgF+j8mivzrqrKHa/WWb6ba3HxY
	 h9Djy55Q5Lp4RhBNdnrRuZ/a4JKsTjvbmHBBmw+ABTJq9x63s13lw/MvJ4Ke8HvVFB
	 +QZd6V7UOfErb+nZJxXtQLo5/3Rc4E0Dh60Kf9udXmJybx32nKp2apmWi/o0GfUwNl
	 8imwPgsWHpmy3FMLzlnAeymDpDgpx+x2jvvnP8kiXRW20L/QKGpO40wEmcmIouiJMp
	 QD3yLKcOyZXIZJgE6nDkAY2Ed4Pl211dd4WwK2j7Zj6iLO8u+teI5sF8sJhYZsCfZF
	 2p+TbB0kjBuBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] soc: qcom: ice: Fix race between qcom_ice_probe() and of_qcom_ice_get()
Date: Mon, 15 Jun 2026 10:43:52 -0400
Message-ID: <20260615144352.2161917-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061554-legal-rubbing-8905@gregkh>
References: <2026061554-legal-rubbing-8905@gregkh>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263257-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:sumit.garg@oss.qualcomm.com,m:andersson@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAA19687625

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit d922113ef91e6e7e8065e9070f349365341ba32e ]

The current platform driver design causes probe ordering races with
consumers (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE
probe fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops
with -EPROBE_DEFER, leaving consumers non-functional even when ICE should
be gracefully disabled. devm_of_qcom_ice_get() doesn't know if the ICE
driver probe has failed due to above reasons or it is waiting for the SCM
driver.

Moreover, there is no devlink dependency between ICE and consumer drivers
as 'qcom,ice' is not considered as a DT 'supplier'. So the consumer drivers
have no idea of when the ICE driver is going to probe.

To address these issues, store the error pointer in a global xarray with
ice node phandle as a key during probe in addition to the valid ice pointer
and synchronize both qcom_ice_probe() and of_qcom_ice_get() using a mutex.

If the xarray entry is NULL, then it implies that the driver is not
probed yet, so return -EPROBE_DEFER. If it has any error pointer, return
that error pointer directly. Otherwise, add the devlink as usual and return
the valid pointer to the consumer.

Xarray is used instead of platform drvdata, since driver core frees the
drvdata during probe failure. So it cannot be used to pass the error
pointer to the consumers.

Note that this change only fixes the standalone ICE DT node bindings and
not the ones with 'ice' range embedded in the consumer nodes, where there
is no issue.

Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com> # OP-TEE as TZ
Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Cc: stable@vger.kernel.org # 6.4
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260518-qcom-ice-fix-v7-1-2a595382185b@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
[ changed `.remove` to `.remove_new` for the void callback and replaced the `__free(device_node)` direct-return with an explicit `goto out` in `of_qcom_ice_get()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/ice.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index d6e205e3812a96..94e91835062b26 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/xarray.h>
 
 #include <linux/firmware/qcom/qcom_scm.h>
 
@@ -49,6 +50,9 @@ struct qcom_ice {
 	struct clk *core_clk;
 };
 
+static DEFINE_XARRAY(ice_handles);
+static DEFINE_MUTEX(ice_mutex);
+
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
 {
 	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
@@ -288,6 +292,8 @@ struct qcom_ice *of_qcom_ice_get(struct device *dev)
 		return qcom_ice_create(&pdev->dev, base);
 	}
 
+	guard(mutex)(&ice_mutex);
+
 	/*
 	 * If the consumer node does not provider an 'ice' reg range
 	 * (legacy DT binding), then it must at least provide a phandle
@@ -304,12 +310,11 @@ struct qcom_ice *of_qcom_ice_get(struct device *dev)
 		goto out;
 	}
 
-	ice = platform_get_drvdata(pdev);
-	if (!ice) {
-		dev_err(dev, "Cannot get ice instance from %s\n",
-			dev_name(&pdev->dev));
+	ice = xa_load(&ice_handles, pdev->dev.of_node->phandle);
+	if (IS_ERR_OR_NULL(ice)) {
 		platform_device_put(pdev);
-		ice = ERR_PTR(-EPROBE_DEFER);
+		if (!ice)
+			ice = ERR_PTR(-EPROBE_DEFER);
 		goto out;
 	}
 
@@ -378,24 +383,40 @@ EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
 
 static int qcom_ice_probe(struct platform_device *pdev)
 {
+	unsigned long phandle = pdev->dev.of_node->phandle;
 	struct qcom_ice *engine;
 	void __iomem *base;
 
+	guard(mutex)(&ice_mutex);
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		dev_warn(&pdev->dev, "ICE registers not found\n");
+		/* Store the error pointer for devm_of_qcom_ice_get() */
+		xa_store(&ice_handles, phandle, (__force void *)base, GFP_KERNEL);
 		return PTR_ERR(base);
 	}
 
 	engine = qcom_ice_create(&pdev->dev, base);
-	if (IS_ERR(engine))
+	if (IS_ERR(engine)) {
+		/* Store the error pointer for devm_of_qcom_ice_get() */
+		xa_store(&ice_handles, phandle, engine, GFP_KERNEL);
 		return PTR_ERR(engine);
+	}
 
-	platform_set_drvdata(pdev, engine);
+	xa_store(&ice_handles, phandle, engine, GFP_KERNEL);
 
 	return 0;
 }
 
+static void qcom_ice_remove(struct platform_device *pdev)
+{
+	unsigned long phandle = pdev->dev.of_node->phandle;
+
+	guard(mutex)(&ice_mutex);
+	xa_store(&ice_handles, phandle, NULL, GFP_KERNEL);
+}
+
 static const struct of_device_id qcom_ice_of_match_table[] = {
 	{ .compatible = "qcom,inline-crypto-engine" },
 	{ },
@@ -404,6 +425,7 @@ MODULE_DEVICE_TABLE(of, qcom_ice_of_match_table);
 
 static struct platform_driver qcom_ice_driver = {
 	.probe	= qcom_ice_probe,
+	.remove_new	= qcom_ice_remove,
 	.driver = {
 		.name = "qcom-ice",
 		.of_match_table = qcom_ice_of_match_table,
-- 
2.53.0


