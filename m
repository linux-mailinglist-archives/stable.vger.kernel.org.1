Return-Path: <stable+bounces-217071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FGDMjrUlGnHIAIAu9opvQ
	(envelope-from <stable+bounces-217071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96A15053C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53072304609E
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A202028C009;
	Tue, 17 Feb 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rC3lSs4f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B6261B70;
	Tue, 17 Feb 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361324; cv=none; b=IEnSdxpQS2ZMODbFe56afRj9ZZPpkOFmdez31Qz59GvVaRxYgDpILs7aSlV0qwqIFDhpBywSQFYfjJwYSwZtsAiKWxAqxL/b4Sw8J4XZ0k8iOZXjP0KaObNdmgRJOl9a3xmyMaQ4W0zkFUEfkgZO4i5SNJYRzVylHZ3csRMD7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361324; c=relaxed/simple;
	bh=u79HbR9jmIkQokuRhBKq1PxF+4uhckXTZBaMYrf3MOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgwBfJvVuw7LU/88Ob0lBzrkqYBtrQTYLLi2poVExuF77Wl1oahIZjC13Kt4PRVNT6Y4/Y4Au7UZWtNO+tJ7nsFVGtu3EdXxU7QY/VSzz6CQQDddM+sKk+CE4c7HCVe0gWmvlpkYVKv+pE23j/O90Oh/8Rkq7ZZswnz1SstZSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rC3lSs4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6865C4CEF7;
	Tue, 17 Feb 2026 20:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361324;
	bh=u79HbR9jmIkQokuRhBKq1PxF+4uhckXTZBaMYrf3MOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rC3lSs4f1nLNXWWK/S+YvS+AlgxzsfBDLI1nx8KSOzcnJA48b1yEJKTYup4o8ZNvU
	 clE7X5746A021xhpNpupgbkCYgpPOxI5s2YG6Eokmj5K364FmOAQ+GBclNBfT3OBrR
	 1ZhOy9HPi1VC4cXUnNgm1iK+Ni31ViiuPkfF8fs8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 35/64] platform/x86: classmate-laptop: Add missing NULL pointer checks
Date: Tue, 17 Feb 2026 21:31:31 +0100
Message-ID: <20260217200008.827327607@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200007.505931165@linuxfoundation.org>
References: <20260217200007.505931165@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217071-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6E96A15053C
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit fe747d7112283f47169e9c16e751179a9b38611e ]

In a few places in the Classmate laptop driver, code using the accel
object may run before that object's address is stored in the driver
data of the input device using it.

For example, cmpc_accel_sensitivity_store_v4() is the "show" method
of cmpc_accel_sensitivity_attr_v4 which is added in cmpc_accel_add_v4(),
before calling dev_set_drvdata() for inputdev->dev.  If the sysfs
attribute is accessed prematurely, the dev_get_drvdata(&inputdev->dev)
call in in cmpc_accel_sensitivity_store_v4() returns NULL which
leads to a NULL pointer dereference going forward.

Moreover, sysfs attributes using the input device are added before
initializing that device by cmpc_add_acpi_notify_device() and if one
of them is accessed before running that function, a NULL pointer
dereference will occur.

For example, cmpc_accel_sensitivity_attr_v4 is added before calling
cmpc_add_acpi_notify_device() and if it is read prematurely, the
dev_get_drvdata(&acpi->dev) call in cmpc_accel_sensitivity_show_v4()
returns NULL which leads to a NULL pointer dereference going forward.

Fix this by adding NULL pointer checks in all of the relevant places.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/12825381.O9o76ZdvQC@rafael.j.wysocki
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/classmate-laptop.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 9309ab5792cbc..ac02b22154d62 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -208,7 +208,12 @@ static ssize_t cmpc_accel_sensitivity_show_v4(struct device *dev,
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	return sprintf(buf, "%d\n", accel->sensitivity);
 }
@@ -225,7 +230,12 @@ static ssize_t cmpc_accel_sensitivity_store_v4(struct device *dev,
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	r = kstrtoul(buf, 0, &sensitivity);
 	if (r)
@@ -257,7 +267,12 @@ static ssize_t cmpc_accel_g_select_show_v4(struct device *dev,
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	return sprintf(buf, "%d\n", accel->g_select);
 }
@@ -274,7 +289,12 @@ static ssize_t cmpc_accel_g_select_store_v4(struct device *dev,
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	r = kstrtoul(buf, 0, &g_select);
 	if (r)
@@ -303,6 +323,8 @@ static int cmpc_accel_open_v4(struct input_dev *input)
 
 	acpi = to_acpi_device(input->dev.parent);
 	accel = dev_get_drvdata(&input->dev);
+	if (!accel)
+		return -ENXIO;
 
 	cmpc_accel_set_sensitivity_v4(acpi->handle, accel->sensitivity);
 	cmpc_accel_set_g_select_v4(acpi->handle, accel->g_select);
@@ -551,7 +573,12 @@ static ssize_t cmpc_accel_sensitivity_show(struct device *dev,
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	return sprintf(buf, "%d\n", accel->sensitivity);
 }
@@ -568,7 +595,12 @@ static ssize_t cmpc_accel_sensitivity_store(struct device *dev,
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	r = kstrtoul(buf, 0, &sensitivity);
 	if (r)
-- 
2.51.0




