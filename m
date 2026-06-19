Return-Path: <stable+bounces-267298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id miJ7MNqjNGqSdgYAu9opvQ
	(envelope-from <stable+bounces-267298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:05:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 508D96A3992
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 04:05:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=fy0c414V;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267298-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267298-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C048F30325A3
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 02:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA33002A0;
	Fri, 19 Jun 2026 02:05:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5281548C;
	Fri, 19 Jun 2026 02:05:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781834709; cv=none; b=cfgbqSkwCYOQwKQdncokISBAToMj/IVbO9wVJpnUX/VF1gfCmSndArvAjz0R86jCmgQWnC2kK+mUNNB8hiunHX1F+ERhOsDOTw04wtShHaMiolNDVzetI+ytGoUyleisTGvJV//Jks4JslFrG82utusfKjb9P7qKEiXxqX2FXyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781834709; c=relaxed/simple;
	bh=dBGD6jqabAV3PJuOsDR1qavK5IMRs0aRj2Us+y8GoO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/ZUcDkIyTS3EyY7pcL+GMScTA5GjO86BO4rQHp8J6feVF43XgAeifDkhgfdnIXr37M0UQvcwKUGZDtXW1RTX3bIevqy965oGMUsAcpxRh0kBxDAQoykaB0Fi7iPsuoMxzwVTQg2OE7a/vLK89IuCIA2QxEjrRc/qBU0O6JzCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fy0c414V; arc=none smtp.client-ip=101.71.155.101
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42fb20a2d;
	Fri, 19 Jun 2026 09:59:43 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eddie James <eajames@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH v2] hwmon: (occ) unregister sysfs devices outside occ lock
Date: Fri, 19 Jun 2026 09:59:38 +0800
Message-Id: <20260619015938.494464-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617150859.741453-1-runyu.xiao@seu.edu.cn>
References: <20260617150859.741453-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9edd9b01fd03a1kunm407e3cffb962f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHh0dVhlDTUxJSkJCGhpCSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fy0c414Vr0flsxKyALO8vYtp8YHpxw8kNdpaqO8IunFWr/bYJ4juu2UxZjRVKB24jb2BBKcC225FKtMkZmOgqijfdVIEDFdzI0R5cCkfGEvaH8FgL32N5T6YL7zVemzxyI4JtyGbHUXB53sC95G6/dBW91CdSO0oj/pbIlRxIm8=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=u9SMLR0PZ6Z1EAlfD6iQJLrvEepdpOGcGg64ZwNBXOU=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267298-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@roeck-us.net,m:eajames@linux.ibm.com,m:arnd@arndb.de,m:sashal@kernel.org,m:linux-hwmon@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 508D96A3992

occ_active(false) and occ_shutdown() unregister sysfs-backed devices while
occ->lock is held.  hwmon_device_unregister() and sysfs_remove_group() can
wait for active sysfs callbacks to drain, and those callbacks can enter the
OCC update path and try to take occ->lock again.  That gives the unregister
paths the lock ordering occ->lock -> sysfs callback drain, while a callback
has the opposite edge sysfs callback -> occ->lock.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the real unregister and callback carrier:

  occ_shutdown()
  hwmon_device_unregister()
  occ_show_temp_1()
  occ_update_response()

Lockdep reported the circular dependency with occ_shutdown() already
holding the OCC mutex and hwmon_device_unregister() waiting on the sysfs
side:

  WARNING: possible circular locking dependency detected
  ... (sysfs_lock) ... at: hwmon_device_unregister+0x12/0x30 [vuln_msv]
  ... (&test_occ.lock) ... at: occ_shutdown.constprop.0+0xe/0x40 [vuln_msv]
  occ_update_response.isra.0+0xb/0x20 [vuln_msv]
  occ_show_temp_1.constprop.0.isra.0+0x23/0x40 [vuln_msv]
  *** DEADLOCK ***

Serialize hwmon registration and removal with a separate hwmon_lock.
Under that lock, detach occ->hwmon and update occ->active while occ->lock
is held so concurrent OCC state changes still see a stable state, then
drop occ->lock before calling hwmon_device_unregister().  Remove the
driver sysfs group before taking occ->lock in occ_shutdown(), so draining
the driver attributes cannot wait while the OCC mutex is held.  Also make
OCC update callbacks return -ENODEV after deactivation, so callbacks that
already passed sysfs active protection do not poll the hardware after
teardown has detached the hwmon device.

Fixes: 849b0156d996 ("hwmon: (occ) Delay hwmon registration until user request")
Fixes: ac6888ac5a11 ("hwmon: (occ) Lock mutex in shutdown to prevent race with occ_active")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Changes in v2:
- Return -ENODEV from occ_update_response() after OCC deactivation so
  already-active sysfs callbacks do not poll hardware after teardown.
- Move occ_shutdown_sysfs() outside occ->lock so driver sysfs callback
  draining does not run while the OCC mutex is held.

 drivers/hwmon/occ/common.c | 34 ++++++++++++++++++++++++++++------
 drivers/hwmon/occ/common.h |  1 +
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 89928d38831b..567b7bc2a6e9 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -214,6 +214,11 @@ int occ_update_response(struct occ *occ)
 	if (rc)
 		return rc;
 
+	if (!occ->active) {
+		rc = -ENODEV;
+		goto unlock;
+	}
+
 	/* limit the maximum rate of polling the OCC */
 	if (time_after(jiffies, occ->next_update)) {
 		rc = occ_poll(occ);
@@ -222,6 +227,7 @@ int occ_update_response(struct occ *occ)
 		rc = occ->last_error;
 	}
 
+unlock:
 	mutex_unlock(&occ->lock);
 	return rc;
 }
@@ -1106,11 +1112,16 @@ static void occ_parse_poll_response(struct occ *occ)
 
 int occ_active(struct occ *occ, bool active)
 {
-	int rc = mutex_lock_interruptible(&occ->lock);
+	struct device *hwmon = NULL;
+	int rc = mutex_lock_interruptible(&occ->hwmon_lock);
 
 	if (rc)
 		return rc;
 
+	rc = mutex_lock_interruptible(&occ->lock);
+	if (rc)
+		goto unlock_hwmon;
+
 	if (active) {
 		if (occ->active) {
 			rc = -EALREADY;
@@ -1155,14 +1166,17 @@ int occ_active(struct occ *occ, bool active)
 			goto unlock;
 		}
 
-		if (occ->hwmon)
-			hwmon_device_unregister(occ->hwmon);
+		hwmon = occ->hwmon;
 		occ->active = false;
 		occ->hwmon = NULL;
 	}
 
 unlock:
 	mutex_unlock(&occ->lock);
+	if (hwmon)
+		hwmon_device_unregister(hwmon);
+unlock_hwmon:
+	mutex_unlock(&occ->hwmon_lock);
 	return rc;
 }
 
@@ -1171,6 +1185,7 @@ int occ_setup(struct occ *occ)
 	int rc;
 
 	mutex_init(&occ->lock);
+	mutex_init(&occ->hwmon_lock);
 	occ->groups[0] = &occ->group;
 
 	rc = occ_setup_sysfs(occ);
@@ -1191,15 +1206,22 @@ EXPORT_SYMBOL_GPL(occ_setup);
 
 void occ_shutdown(struct occ *occ)
 {
-	mutex_lock(&occ->lock);
+	struct device *hwmon;
 
 	occ_shutdown_sysfs(occ);
 
-	if (occ->hwmon)
-		hwmon_device_unregister(occ->hwmon);
+	mutex_lock(&occ->hwmon_lock);
+	mutex_lock(&occ->lock);
+
+	hwmon = occ->hwmon;
+	occ->active = false;
 	occ->hwmon = NULL;
 
 	mutex_unlock(&occ->lock);
+
+	if (hwmon)
+		hwmon_device_unregister(hwmon);
+	mutex_unlock(&occ->hwmon_lock);
 }
 EXPORT_SYMBOL_GPL(occ_shutdown);
 
diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
index 7ac4b2febce6..82f600093c7f 100644
--- a/drivers/hwmon/occ/common.h
+++ b/drivers/hwmon/occ/common.h
@@ -101,6 +101,7 @@ struct occ {
 
 	unsigned long next_update;
 	struct mutex lock;		/* lock OCC access */
+	struct mutex hwmon_lock;		/* serialize hwmon registration/removal */
 
 	struct device *hwmon;
 	struct occ_attribute *attrs;

base-commit: 44c944a679974c2d18ee9b87070456d34193f3d4

