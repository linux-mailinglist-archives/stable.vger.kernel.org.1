Return-Path: <stable+bounces-143255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF2AB3530
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28D23BFF90
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FB4265633;
	Mon, 12 May 2025 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cdbm5Dcj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7507136988
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047036; cv=none; b=iQlLaxaWnQxffHQu51ig+aNEIi1ZY/ySXMQ3eVEWbaZN6T1NyXtz+STe7PLzPXxpvmExoA3gCxyLpQFRq13aUCCHVY8YiePnl60IfjjzrL/SMxuqoHuSjCgBGB0ZaCEoh7o16po/nTFmNSleQYJ1jg58U0vjreJlM5yKd7Cm6lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047036; c=relaxed/simple;
	bh=j7Yo6tgpkoIX0V7axu7xRuLTgvPO02ozLJQ3y5r04Zs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W+dbAd34eWGmywDeoTGK2YJvrFNrbay2iZs22EFvo4sCQXXzNa1I3SOzYPzFGNt3Hlq4v57x/+OXcp6S6Rpw3S2Q5MiuwOJgRQuYXnnxM6rbtfzYWrTTA+ztttba51P4Xs4Uu1yiaOjv1LgK7zRVfdcb56gTxGqRV2VIxGCcgq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cdbm5Dcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E1BC4CEE7;
	Mon, 12 May 2025 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747047036;
	bh=j7Yo6tgpkoIX0V7axu7xRuLTgvPO02ozLJQ3y5r04Zs=;
	h=Subject:To:Cc:From:Date:From;
	b=Cdbm5DcjbnisPiGxquzESTHvkv7zql961+JIQRXP+45d+8q0Nxwk5P6vseo58u03o
	 SisbU+NjGEhQthAoeq45T1QHhQb2goHLPFVBynXv3PfHmcKL8SUsh62Kghm3w9Ma6V
	 xOLDtk3NUJmlmellvG4PyHkPFGip/BZ5YuA6WFro=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: displayport: Fix deadlock" failed to apply to 6.6-stable tree
To: akuchynski@chromium.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:50:25 +0200
Message-ID: <2025051225-fiber-hummus-544f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 364618c89d4c57c85e5fc51a2446cd939bf57802
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051225-fiber-hummus-544f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 364618c89d4c57c85e5fc51a2446cd939bf57802 Mon Sep 17 00:00:00 2001
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Thu, 24 Apr 2025 08:44:28 +0000
Subject: [PATCH] usb: typec: ucsi: displayport: Fix deadlock

This patch introduces the ucsi_con_mutex_lock / ucsi_con_mutex_unlock
functions to the UCSI driver. ucsi_con_mutex_lock ensures the connector
mutex is only locked if a connection is established and the partner pointer
is valid. This resolves a deadlock scenario where
ucsi_displayport_remove_partner holds con->mutex waiting for
dp_altmode_work to complete while dp_altmode_work attempts to acquire it.

Cc: stable <stable@kernel.org>
Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250424084429.3220757-2-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 420af5139c70..acd053d4e38c 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -54,7 +54,8 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	u8 cur = 0;
 	int ret;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override && dp->initialized) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
@@ -100,7 +101,7 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	schedule_work(&dp->work);
 	ret = 0;
 err_unlock:
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return ret;
 }
@@ -112,7 +113,8 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	u64 command;
 	int ret = 0;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
@@ -144,7 +146,7 @@ static int ucsi_displayport_exit(struct typec_altmode *alt)
 	schedule_work(&dp->work);
 
 out_unlock:
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return ret;
 }
@@ -202,20 +204,21 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 	int cmd = PD_VDO_CMD(header);
 	int svdm_version;
 
-	mutex_lock(&dp->con->lock);
+	if (!ucsi_con_mutex_lock(dp->con))
+		return -ENOTCONN;
 
 	if (!dp->override && dp->initialized) {
 		const struct typec_altmode *p = typec_altmode_get_partner(alt);
 
 		dev_warn(&p->dev,
 			 "firmware doesn't support alternate mode overriding\n");
-		mutex_unlock(&dp->con->lock);
+		ucsi_con_mutex_unlock(dp->con);
 		return -EOPNOTSUPP;
 	}
 
 	svdm_version = typec_altmode_get_svdm_version(alt);
 	if (svdm_version < 0) {
-		mutex_unlock(&dp->con->lock);
+		ucsi_con_mutex_unlock(dp->con);
 		return svdm_version;
 	}
 
@@ -259,7 +262,7 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 		break;
 	}
 
-	mutex_unlock(&dp->con->lock);
+	ucsi_con_mutex_unlock(dp->con);
 
 	return 0;
 }
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index e8c7e9dc4930..01ce858a1a2b 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1922,6 +1922,40 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
 }
 EXPORT_SYMBOL_GPL(ucsi_set_drvdata);
 
+/**
+ * ucsi_con_mutex_lock - Acquire the connector mutex
+ * @con: The connector interface to lock
+ *
+ * Returns true on success, false if the connector is disconnected
+ */
+bool ucsi_con_mutex_lock(struct ucsi_connector *con)
+{
+	bool mutex_locked = false;
+	bool connected = true;
+
+	while (connected && !mutex_locked) {
+		mutex_locked = mutex_trylock(&con->lock) != 0;
+		connected = UCSI_CONSTAT(con, CONNECTED);
+		if (connected && !mutex_locked)
+			msleep(20);
+	}
+
+	connected = connected && con->partner;
+	if (!connected && mutex_locked)
+		mutex_unlock(&con->lock);
+
+	return connected;
+}
+
+/**
+ * ucsi_con_mutex_unlock - Release the connector mutex
+ * @con: The connector interface to unlock
+ */
+void ucsi_con_mutex_unlock(struct ucsi_connector *con)
+{
+	mutex_unlock(&con->lock);
+}
+
 /**
  * ucsi_create - Allocate UCSI instance
  * @dev: Device interface to the PPM (Platform Policy Manager)
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 3a2c1762bec1..9c5278a0c5d4 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -94,6 +94,8 @@ int ucsi_register(struct ucsi *ucsi);
 void ucsi_unregister(struct ucsi *ucsi);
 void *ucsi_get_drvdata(struct ucsi *ucsi);
 void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
+bool ucsi_con_mutex_lock(struct ucsi_connector *con);
+void ucsi_con_mutex_unlock(struct ucsi_connector *con);
 
 void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 


