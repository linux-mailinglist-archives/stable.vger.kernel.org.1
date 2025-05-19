Return-Path: <stable+bounces-144758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870B6ABB869
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5757118910F3
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 09:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60624244696;
	Mon, 19 May 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIS58Vi+"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E51F03F2
	for <stable@vger.kernel.org>; Mon, 19 May 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646127; cv=none; b=k+27rxzOUzOHgHtLNI3/74G2pih46g8MHp18nnwSgbX4cBXjVfpsKLHkyoY3lk0pUQkEHONxXj45PQoRFOGkh6Q+fWYjqnlaUrRlXn+PiZKmwbqOwpaxMvEo4vTNMDz3wfoeyQLbkVJTHIn9WvKEUiIGwLV89PnLnpQ/M/UmKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646127; c=relaxed/simple;
	bh=IjIxgd1YTxtbo3wY+95v6puXzn/nNNQcWv7VD88zT4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DauLu1WOrcYba+QU35kbnS5x0aG106Upih+xOp7QPwNV+wEyazHaXC9pAq01up0GcsusmlJ+pY8x6NNU4Mke7YHBST1m2ZvF6QD+YTUb7udl2fgzokJPYNXt/NZHx9WIsKT5wIjgz297ZFY8NXMJbflp0QOGHTmAk1bo+ZuuKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fIS58Vi+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-601a6e2e93cso2793290a12.1
        for <stable@vger.kernel.org>; Mon, 19 May 2025 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747646123; x=1748250923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlDtPn3IZX0SU/U2RNq5DAz9i7fgCCVP52BTkpkahy4=;
        b=fIS58Vi+lAOF67uvzY3OxOwIamwYS33jIzazWOxWkvwJTLMmX2e1PCDPiTd9aiyASK
         t9rqpWxz6KIoODhldpaQ3lTISv6dIquzIdrqfumMYye5aySfhQt7+FdopouE2R0sKht2
         P10nzzfPM8+Wqkz2hn8e6y9MmZLgBDhDTExT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747646123; x=1748250923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlDtPn3IZX0SU/U2RNq5DAz9i7fgCCVP52BTkpkahy4=;
        b=QdDSpTJh2hdGZTZkyXxtiBcdDYRIZA+dDBn/vj7UHZB9emaLgcPRhdv3g4dbmxvnDZ
         7fUGA+Z7ZwgzzAnlbrlBRDe/8LxJBXrrZZcxwXN0E7c8eVKYLhCm2fE9wR8ARXrQO8Ld
         Sl5rf6LpelsP0F6v0e9l6ASZfNFBWhvIjT20PhHLzvdOrP+B47OKJyBGdJaBD6ZwX/jP
         hqQQ+iVhqFWOxarY2V2HK4uXT2GIswQc6GAlllbxIx9yv0t36frDM7H7D7IP0BQ6r23c
         T7XKi9Qk9HIhFL/qb9cczE3jWZlMISeGvFEFGFG0pQbP64YLRfCaszqfxuTBQpVXMT+Q
         YkDA==
X-Gm-Message-State: AOJu0YxPali8IUdf6Q/CW1RP18P6ZEKUTPB95aXtatk5cQq2Hj07yDje
	nEmXzOkhhZDK49g7Hom3G2nR37eXKC6O8rKNZ1kHRwJzBU0xshqBwOLhccqI6AlqFV0Uh4KMGOR
	N0vLAJQ==
X-Gm-Gg: ASbGncvDDodqNYnoMWaKRzVjFEPjyWtQg7eWIb3Q+uwYVM6EhNgR8tz+pAPuJpQuG8B
	nHn1ini73GVp7bYk+UfQ0EkoHBswbNxfPeDCsVd8b4WDZL/4yDPxgqVI1xXiQkTNS8WKNpdEf8e
	+Q24KTV5jA/GxD69Z525eWiv0jww+2lvCFJKx40E/Qw/QRltn1aWwaEr2nAX27k1v0kZse+3WX6
	XSLztgiMjOihhBmbnTmzmSB20aXA2/IbYoDIMAMPPpS+AJX2VcIA4lNO1bGDYofkg5LkSs5BVOM
	WLyCs5FaVoxDK8t9HHQeaTgFWl+eGjFDGcRD6vA8EUhxgWS0DWhyfz0nu7hKgjqhFyw+mpBcqe2
	avSO0wrHygB8hnZ52U69QWUSWQdcCBshiJU6Wp87oiw==
X-Google-Smtp-Source: AGHT+IGT+rskrqJKAyDWXKYoqACJp4niMrLU1f6T4upuPocNBPI+VybWDV4lOI9V9uu5SMECzwWR0w==
X-Received: by 2002:a05:6402:1d49:b0:601:a921:baa with SMTP id 4fb4d7f45d1cf-601a92157f3mr5658959a12.11.1747646123200;
        Mon, 19 May 2025 02:15:23 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d501b60sm5603348a12.18.2025.05.19.02.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:15:22 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Mon, 19 May 2025 09:15:04 +0000
Message-ID: <20250519091504.3041039-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
In-Reply-To: <2025051222-thursday-outdoors-ffda@gregkh>
References: <2025051222-thursday-outdoors-ffda@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 364618c89d4c57c85e5fc51a2446cd939bf57802)
---
 drivers/usb/typec/ucsi/displayport.c | 19 +++++++++-------
 drivers/usb/typec/ucsi/ucsi.c        | 34 ++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h        |  3 +++
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 8c19081c3255..e3b5fa3b5f95 100644
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
index 2adf5fdc0c56..2a03bb992806 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1398,6 +1398,40 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
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
+		connected = con->status.flags & UCSI_CONSTAT_CONNECTED;
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
index 4a1a86e37fd5..793a8307dded 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -15,6 +15,7 @@
 
 struct ucsi;
 struct ucsi_altmode;
+struct ucsi_connector;
 
 /* UCSI offsets (Bytes) */
 #define UCSI_VERSION			0
@@ -62,6 +63,8 @@ int ucsi_register(struct ucsi *ucsi);
 void ucsi_unregister(struct ucsi *ucsi);
 void *ucsi_get_drvdata(struct ucsi *ucsi);
 void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
+bool ucsi_con_mutex_lock(struct ucsi_connector *con);
+void ucsi_con_mutex_unlock(struct ucsi_connector *con);
 
 void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 
-- 
2.49.0.1101.gccaa498523-goog


