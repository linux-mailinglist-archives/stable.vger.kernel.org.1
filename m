Return-Path: <stable+bounces-144132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC68AB4DE0
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D37A41891262
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95351FFC7E;
	Tue, 13 May 2025 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l+koJVOo"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A31F5846
	for <stable@vger.kernel.org>; Tue, 13 May 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124204; cv=none; b=YkXAbZhhB6JbkldxEpCAb2Lh+qDqCOSs+/JgF9ndXpT6YndemloRakzPqnueIZk2Br3emnto+T0tGed2wp/UdVPlyocSC0ZK9oI6/1JXAgNX/aBZTGRou6Ug7keNbbw1mvUHtxL8oFm13EMtkWwagcssn9pfqqpKbLgDorElC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124204; c=relaxed/simple;
	bh=Mr+1S6hjJ3g9gpaUqvrYhljpnhocR9DHcnv5rkKvjY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyEW8ksfTQH+stC18YdbQMtrdPwgLniFcE1a2nfP77tGhIYaJu0aU0rNU9pByFX5hlw1NJIJ/+ppXXtmZVB1WL/AEFcTIlZDMs7fgCSgcdqrZoctVEHrYp56oyt/GJ10VEbeqmfj/lrEQNz6LVWK8GM8+8TkRy3+9i+NOhK0XPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l+koJVOo; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fbf534f8dbso8173684a12.3
        for <stable@vger.kernel.org>; Tue, 13 May 2025 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747124199; x=1747728999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Xv3HD5FD7XV0d67klm477bUmRqFzEsWgu+CGNrq8oc=;
        b=l+koJVOokPYYPrQJv9ineJpak7GaChkvmjrB0P9GZEMDe/U8p5OH97JHBiUXD5mtCo
         F6Uh5hTOmjQAefXSymTJ/fz1Lsvv5gXhY4csZYDfJjVJR61rUSETdEHhfja/bUpscExL
         lObmV17XwKLwlvTP3dCnG7TgFCoMfHBvcJBFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747124199; x=1747728999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xv3HD5FD7XV0d67klm477bUmRqFzEsWgu+CGNrq8oc=;
        b=kfwbGiFKuXbquCuqlThyg/u2l5m9sEv4PItPI1ASdaDNlbpTSVEp2jE2CNxOjKVpnL
         nwbG2WKkQvvj8bCUxtSseKNravlI0ivKkKpaDP5SVZeggXC45onz7STbW+TGOk7rWCUy
         IFB63kmuAWixrfJE5Zlpivxu+kfZuSFVyf5Qp9RTcL7kFtV5UkKu3dkZK8BN8Do4nEI9
         2bo1fQEU1FOorFLx+cfag8bRcBBOZ2HkF/TIYqlD350tYwaoJ6+zhYXRl/xBstEnCWQx
         sdDREBDz6Mpn1yFYh/ig3BJRPcwvX7PKXdrTWN9iyriqJtwLv5ibWeEycqJRIQsEi52X
         0EZg==
X-Gm-Message-State: AOJu0YxoTBlGj380VtBHcRuZgW7CKJuGR6TLrsqs9BKY3R4h00hj80np
	2p1sjITxSC5bh4vuLCMe9ltj54WZtO64Pr1i7LVHxwvG4vu7gxUdCBHlBWesoAvmN/N/yR5vpMu
	KCA==
X-Gm-Gg: ASbGncsZqwb5XO4QGCRKAOCNhGF9KJ2lYUOls7+gD5w4tXZ57l+UMauGkyJPHroTGGp
	RSB3gDLYr43s0BpI+I8ZJh+a2Ey8LDunvOdrm0tpYIskRUb1XBIWywOIu28OTjt59yw+JTDcI3m
	6wsGTph0PGVxBRcOPr7TSjlk22+vxGwuU2H32loOd8aGoXPh7/uMqh4/dj79e6IG4Z/3YJlRwlH
	0p5YTrNDhAkX2lIrvFQ5wJXElsnchX8h3+5Lc9hFHBIUROt0bzK8bpA1OCIiU1/pPj7R2wsemsh
	VcU9Bgz7QE8+1ob7PUhwiPJPxdxYfWB42sNEPbASkB2lt/Z4TUhFmFyCJ4tIrvRnOkKgfPkGXa2
	Ye8kUFSGbc/CVkeog6vw/3hn77wt+MrClI8kl3FKR+w==
X-Google-Smtp-Source: AGHT+IGv1WXr0QYhu6AUi3H4F0EgJXEW/eWGFDE7w42ASWbqgLnPDs1qObFaDhaxeu4dekoYEF6LAQ==
X-Received: by 2002:a17:906:99c2:b0:ad1:8dde:5b7a with SMTP id a640c23a62f3a-ad21916973dmr1622224566b.43.1747124199315;
        Tue, 13 May 2025 01:16:39 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad23ad2b386sm551860766b.104.2025.05.13.01.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:16:38 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Tue, 13 May 2025 08:16:30 +0000
Message-ID: <20250513081630.534069-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
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
Change-Id: I8b77692a60f77b8ddbb0503088f447fe1bb6a512
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
2.49.0.1045.g170613ef41-goog


