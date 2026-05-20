Return-Path: <stable+bounces-252194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMZUE4b4DWqR5AUAu9opvQ
	(envelope-from <stable+bounces-252194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:08:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC58D5955CA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD21B30873E8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858F834DCE4;
	Wed, 20 May 2026 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zM0XhLjf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2695C3769E0;
	Wed, 20 May 2026 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300038; cv=none; b=uz87znhzGvWOvq3I5C821VPBHXQ2cNoy82DPuBbH8Ejdf9scyQXf+0Wgn6YT+JalPyCpGLjrc9rfmiYcXsYzrxUWNsB4ivoYw9D+6CSqbMf97uJ0KJQLy4hWe22lSGvqgaaykILrt4W4tRlmo88KEw+HmvvTjTuZY+NUyTV+jKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300038; c=relaxed/simple;
	bh=huAfnK56Y2m9fumLScb/QblbkoWsqtPpGL+mGNtSES8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EA1OV274ENSxeI9K09icUbH0TLT2ggin+fgRXHYD8Hw62rKRnvDU8DM/ef0Q9X7N7IAdFPdNNDb4p2/LvYFxfMG7M4Vt55BOYvPj4Atq3u20QfyW0pYxk1PN6s82iJqhaxDPhvRyvbAScuc1mE+wqiXp2PGuR/FG+K3yUk/FZno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zM0XhLjf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8231F000E9;
	Wed, 20 May 2026 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300037;
	bh=ubaDCDzBt24Ntrbkr0Go4S8FWvOvXeKdwKChJQ1VB0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zM0XhLjf0+BWenQDrOJddzoyj2ooxb1YjQQ64TGJuX5M0NRTg9a+evPpqzfZ2G+Pz
	 kKTUlW/R0enquP2Hhkii9qPuJ4uBsQudLkOOGlK6pc+B8yE0XmaWmauxroQfzAvgbF
	 26inEteaFk+oschHG3500d5d5MX/E+xtydhCGppg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 023/666] platform/wmi: use generic driver_override infrastructure
Date: Wed, 20 May 2026 18:13:54 +0200
Message-ID: <20260520162111.734939858@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,gmx.de,linux.intel.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252194-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,gmx.de:email]
X-Rspamd-Queue-Id: CC58D5955CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit 8a700b1fc94df4d847a04f14ebc7f8532592b367 ]

When a driver is probed through __driver_attach(), the bus' match()
callback is called without the device lock held, thus accessing the
driver_override field without a lock, which can cause a UAF.

Fix this by using the driver-core driver_override infrastructure taking
care of proper locking internally.

Note that calling match() from __driver_attach() without the device lock
held is intentional. [1]

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
Fixes: 12046f8c77e0 ("platform/x86: wmi: Add driver_override support")
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Acked-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260324005919.2408620-7-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/wmi.c | 36 +++++-------------------------------
 include/linux/wmi.h        |  4 ----
 2 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 3cbe180c3fc0a..f13173eb070e6 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -696,39 +696,11 @@ static ssize_t expensive_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(expensive);
 
-static ssize_t driver_override_show(struct device *dev, struct device_attribute *attr,
-				    char *buf)
-{
-	struct wmi_device *wdev = to_wmi_device(dev);
-	ssize_t ret;
-
-	device_lock(dev);
-	ret = sysfs_emit(buf, "%s\n", wdev->driver_override);
-	device_unlock(dev);
-
-	return ret;
-}
-
-static ssize_t driver_override_store(struct device *dev, struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct wmi_device *wdev = to_wmi_device(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &wdev->driver_override, buf, count);
-	if (ret < 0)
-		return ret;
-
-	return count;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 static struct attribute *wmi_attrs[] = {
 	&dev_attr_modalias.attr,
 	&dev_attr_guid.attr,
 	&dev_attr_instance_count.attr,
 	&dev_attr_expensive.attr,
-	&dev_attr_driver_override.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(wmi);
@@ -797,7 +769,6 @@ static void wmi_dev_release(struct device *dev)
 {
 	struct wmi_block *wblock = dev_to_wblock(dev);
 
-	kfree(wblock->dev.driver_override);
 	kfree(wblock);
 }
 
@@ -806,10 +777,12 @@ static int wmi_dev_match(struct device *dev, const struct device_driver *driver)
 	const struct wmi_driver *wmi_driver = drv_to_wdrv(driver);
 	struct wmi_block *wblock = dev_to_wblock(dev);
 	const struct wmi_device_id *id = wmi_driver->id_table;
+	int ret;
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (wblock->dev.driver_override)
-		return !strcmp(wblock->dev.driver_override, driver->name);
+	ret = device_match_driver_override(dev, driver);
+	if (ret >= 0)
+		return ret;
 
 	if (id == NULL)
 		return 0;
@@ -891,6 +864,7 @@ static struct class wmi_bus_class = {
 static const struct bus_type wmi_bus_type = {
 	.name = "wmi",
 	.dev_groups = wmi_groups,
+	.driver_override = true,
 	.match = wmi_dev_match,
 	.uevent = wmi_dev_uevent,
 	.probe = wmi_dev_probe,
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 3275470b5531e..63cca3b58d6df 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -16,16 +16,12 @@
  * struct wmi_device - WMI device structure
  * @dev: Device associated with this WMI device
  * @setable: True for devices implementing the Set Control Method
- * @driver_override: Driver name to force a match; do not set directly,
- *		     because core frees it; use driver_set_override() to
- *		     set or clear it.
  *
  * This represents WMI devices discovered by the WMI driver core.
  */
 struct wmi_device {
 	struct device dev;
 	bool setable;
-	const char *driver_override;
 };
 
 /**
-- 
2.53.0




