Return-Path: <stable+bounces-144122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D88AB4D3D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 09:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA1D167968
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 07:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A331E9B30;
	Tue, 13 May 2025 07:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VKJnLSAc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14821BC4E
	for <stable@vger.kernel.org>; Tue, 13 May 2025 07:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122374; cv=none; b=ABYmTj/N1vgVz+QQvVbFKOrVG+oIc93di72cF/2zqFVP3TsTRCLeYo1l1c6zybTGpibbKzwfbvqJXHeCBTEUB/ksn/E0YqgQ1Rv3/Ns4DkZyHclpXjkNhaZrqEMwOXZtwlRF6nbiC1rCvQLh55DlQYpa4ITs+jIOP5OEfkDrNtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122374; c=relaxed/simple;
	bh=JIa9jxHomNF/vcmVu9Pcga+5jXPe8+fhk4BOKTu8vls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE4zKge1bGd4CP4xSek7lYGIms4klFAwl6RpxoweQMK/+TYpWC3MDOj5qv9ofUcdlq1stgofpZ3kkpoBwh3jiybUb8DD3OHGNg0Zf2GQv6G6wo7fKlFbuztWCyLl4Tyo/4VjGJpvdfB7IoERvHB5UvnCxBzLrU/CZITi3BDb+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VKJnLSAc; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso50843401fa.3
        for <stable@vger.kernel.org>; Tue, 13 May 2025 00:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747122370; x=1747727170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGWJZEHKSwXN0DHwy+YKyRTDYeFhRjvtX5z1aeOJwwY=;
        b=VKJnLSAcXsZ0EGv/giHxWNH5bsFhzgHqwsR1/5JTn7Jx8Rwc/C0cjOr74LPklmfGvj
         qOMUZmsBpzyl9uj1nZJ0Oh5MCfRXCcVSduDilBXCIwVA7/pgmROZbeja2xjW7egjgXHe
         yft3qi80IIl+UCW9xoaHhrzto+9NxvFtNQ4cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747122370; x=1747727170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGWJZEHKSwXN0DHwy+YKyRTDYeFhRjvtX5z1aeOJwwY=;
        b=WUVFv4IVwQp6jRYTG0l1VnluUKLMFEx7Jk4w61SCcdMvW662rrH87pIMECCMuHX0aA
         /pT8Bw+KkbkQ0KfQ1aUG8NgrwFyUvEmSAENSOmaI6XFc7PYPniL/nU5zPDRVv3Lk8SKc
         K2DSVELhMrc1wZzLYDL4nmJ3jl5rj5gjhY3cEAZ864Z1WE7YNX+FtuslnWxTQ+nyU9Gb
         cpvgYZc2mXHDbYJj6uy/TVWRi/ZLbQG0f08WLPFWEtMjapoenvFzGUL1yW/b0EGrfVNL
         pm0w5QCXW5GjMXT7hODLy8bIKm9EatqE06jk4n9RsuhCJPGu5Y5y1GO4mwMSY/KB3HNI
         LKyg==
X-Gm-Message-State: AOJu0YxAF0ayV8bSYDZPzs61e4MxnJlHmh5YxzjnlQCTEPn5UP6aIHQh
	5811+OIGj5e0XDgEetdg2t/n5WJHqnmkGt1Whj+JVdlDqPLpBnnX7DGfRttAuDfcIpQeUko8q9i
	PlQ==
X-Gm-Gg: ASbGncuyFW6VM0R1mVD/zehvP8rudyn0qiaYOoOQ1n8TgRYU4pypPxnwZc1nSxlF9t+
	LC+GRAQms3m4yN8TZCq+KBkxCrEoP1OPR55vt39h38qLKl331m2M8cli8qj+bZaaYf+cEDY6dth
	ooAnqTk/LYr3W8h+9p+zjgTDEGeSpa+QoS00biCbNATqbtoS5gJSVOVC1goMKqZyVszfbqFZcvG
	ooxbbOJZ8WE4y4mW1TMSLvU4qGkeO8g+OaFPJwjDYRybZbCK8LbQBeSf/OrjU3F5g0fTbNnDHBA
	fvaLLcAqrMIgxPhu/C4u3ZN5o6fo29EO41sG4sDe84EmOZllWnaHvqET01pqHUORKru2qMkJBRr
	YYm9eT371+TTU152IJ9Bupfbojcp9o0uh5f94nvzz+PuzajTi6pEh
X-Google-Smtp-Source: AGHT+IHDPU6jAOMCOVvzPD9ey9QEjQ38mQ6REAI36NQjpbm24KsWFkbs4ecZzmEx2hFYu2A59aOj2g==
X-Received: by 2002:a17:906:adce:b0:ace:d986:d7d2 with SMTP id a640c23a62f3a-ad2192b5c89mr1244002166b.49.1747121882902;
        Tue, 13 May 2025 00:38:02 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21f2145d6sm700626866b.95.2025.05.13.00.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:38:02 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Tue, 13 May 2025 07:37:53 +0000
Message-ID: <20250513073753.179129-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <2025051225-fiber-hummus-544f@gregkh>
References: <2025051225-fiber-hummus-544f@gregkh>
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
Change-Id: I0c09bb490e1170c13eaf0399cac9b84a9d51d8a3
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250424084429.3220757-2-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 364618c89d4c57c85e5fc51a2446cd939bf57802)
---
 drivers/usb/typec/ucsi/displayport.c | 19 +++++++++-------
 drivers/usb/typec/ucsi/ucsi.c        | 34 ++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h        |  2 ++
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 2431febc4615..6f5c46368cc5 100644
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
index 29a04d679501..ea98bc567494 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1559,6 +1559,40 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
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
index 921ef0e115cf..3bb23a2ea547 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -79,6 +79,8 @@ int ucsi_register(struct ucsi *ucsi);
 void ucsi_unregister(struct ucsi *ucsi);
 void *ucsi_get_drvdata(struct ucsi *ucsi);
 void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
+bool ucsi_con_mutex_lock(struct ucsi_connector *con);
+void ucsi_con_mutex_unlock(struct ucsi_connector *con);
 
 void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 
-- 
2.49.0.1045.g170613ef41-goog


