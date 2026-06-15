Return-Path: <stable+bounces-263111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SKr3C+V2L2o1BAUAu9opvQ
	(envelope-from <stable+bounces-263111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:52:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C568323C
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 05:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fgv05xp1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263111-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-263111-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B3A730013B7
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 03:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F20277007;
	Mon, 15 Jun 2026 03:51:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B09826A1AF
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 03:51:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495518; cv=none; b=bDS9jDgvsb4wTmsS2fUYmuH0V/FvrGVMMtRVQ+38s8jlQXIFHb0BYwHShfF5iMhjGVQQCS8qk5XOk3CoLkn4/x+XO50dB+baKRy/MP7+Wnq4Y1MdJxqUfvZUUZY38Au8oK7ajgFNTPSWuhxvF4lA/kO3AdOr1XHJQI5zP9fh/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495518; c=relaxed/simple;
	bh=t8EJEUUqdj/9sNPeU5CSu6HDzruY9jlA7yzotRJYX5A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CP0mCffD4i+KYeJuNzEIhz7Cdwi8yghMLSR+GbU7/93Imp3d6cgW54SLZsFAUv2iVmYo54bYJVhEYHki9Pe1QJcEwX7xHhW9nb9xqjS0ELopTpCIh891GoMYhKfxfi1HSlqLpnU+zFy/ra+94Hw9sh5IL4tDT89JXqfGW2Ssaio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fgv05xp1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8B31F000E9;
	Mon, 15 Jun 2026 03:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781495516;
	bh=2Sx1P3/+7q+B2ZTb+dv6BiMSy5ZsLpI8Z83oxQrcWT8=;
	h=Subject:To:Cc:From:Date;
	b=fgv05xp1+mkFjhIcSmEUbGBL9NMgy1AFhoBrlrYHPd+ZdfPhRxLeIRJMsSH3YquYx
	 f3C3MMPwWYeWDwbvva7R27x58jtK/HlCN62TZYze/GEHVC6Qrn2Pd3GdcHtrmWH8KK
	 x7uCBESBOvMtujtM5qM92b64mcdI81ulTuVJiq+E=
Subject: FAILED: patch "[PATCH] soc: qcom: ice: Fix race between qcom_ice_probe() and" failed to apply to 6.6-stable tree
To: manivannan.sadhasivam@oss.qualcomm.com,andersson@kernel.org,sumit.garg@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 05:50:54 +0200
Message-ID: <2026061554-legal-rubbing-8905@gregkh>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263111-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:andersson@kernel.org,m:sumit.garg@oss.qualcomm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D7C568323C


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d922113ef91e6e7e8065e9070f349365341ba32e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061554-legal-rubbing-8905@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d922113ef91e6e7e8065e9070f349365341ba32e Mon Sep 17 00:00:00 2001
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Mon, 18 May 2026 19:22:17 +0530
Subject: [PATCH] soc: qcom: ice: Fix race between qcom_ice_probe() and
 of_qcom_ice_get()

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

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index b203bc685cad..91991864b4a3 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/xarray.h>
 
 #include <linux/firmware/qcom/qcom_scm.h>
 
@@ -113,6 +114,9 @@ struct qcom_ice {
 	u8 hwkm_version;
 };
 
+static DEFINE_XARRAY(ice_handles);
+static DEFINE_MUTEX(ice_mutex);
+
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
 {
 	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
@@ -631,6 +635,8 @@ static struct qcom_ice *of_qcom_ice_get(struct device *dev)
 		return qcom_ice_create(&pdev->dev, base);
 	}
 
+	guard(mutex)(&ice_mutex);
+
 	/*
 	 * If the consumer node does not provider an 'ice' reg range
 	 * (legacy DT binding), then it must at least provide a phandle
@@ -647,12 +653,13 @@ static struct qcom_ice *of_qcom_ice_get(struct device *dev)
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	ice = platform_get_drvdata(pdev);
-	if (!ice) {
-		dev_err(dev, "Cannot get ice instance from %s\n",
-			dev_name(&pdev->dev));
+	ice = xa_load(&ice_handles, pdev->dev.of_node->phandle);
+	if (IS_ERR_OR_NULL(ice)) {
 		platform_device_put(pdev);
-		return ERR_PTR(-EPROBE_DEFER);
+		if (!ice)
+			return ERR_PTR(-EPROBE_DEFER);
+		else
+			return ice;
 	}
 
 	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
@@ -716,24 +723,40 @@ EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
 
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
@@ -742,6 +765,7 @@ MODULE_DEVICE_TABLE(of, qcom_ice_of_match_table);
 
 static struct platform_driver qcom_ice_driver = {
 	.probe	= qcom_ice_probe,
+	.remove	= qcom_ice_remove,
 	.driver = {
 		.name = "qcom-ice",
 		.of_match_table = qcom_ice_of_match_table,


