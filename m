Return-Path: <stable+bounces-131957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E32A826F6
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 16:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3451B67A81
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C8264F8C;
	Wed,  9 Apr 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nL8SGc+4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12DF264F88
	for <stable@vger.kernel.org>; Wed,  9 Apr 2025 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207361; cv=none; b=LTWM2yIlFdAGmQ5tHxmWhMxaW6nN2ko/H6j1gRVvyivgD9ItKOA6sQhazXmlIfTMD6IcAmCSVhxgMmEYI7JWOovEt/kV4Dqp6VIMwqE1VylqK8LZWe81NeWEHTqp7Hx8CeZd/dYw46301TUhGBZ7DuyANaY9qPU1suupu2PJf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207361; c=relaxed/simple;
	bh=iFyXqVFXEULPsNSqQwDUF2/Adtt/V3zIh9vrgqGq5bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeX07UIIUKhr/iVyt64edxQtBdq9MiAUZyYolfL8o+VUyH4pCCj9uqho0eq5k0vD+UZ6Nyu7T2Vg/ptK6agRbgZ8dL54PlBevnNbYBbuBCFTGamNh2Y7uZwmmOroLmGQ6eLkeegNvi77kVkm3x7uCmVarYxX59t61haPoXJKQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nL8SGc+4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso913665566b.1
        for <stable@vger.kernel.org>; Wed, 09 Apr 2025 07:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744207356; x=1744812156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5bQBdzdrrxAwjVcMoSn7R6YHyOz0D1Ji82aPtHYgp0=;
        b=nL8SGc+4dlyVuEapohvoPNZ7JPue1fzj9JSh9l4rQb763aOMiRYsXH/YJKlmcGTzGJ
         mAckIn+QgZSjm9MJMd+CQKRLvNqXgzKnV+iCX+w15eEC8iR2zp4boAeFiWSMArIQDOXM
         vO9tGpogD2TWWjj6mKFwNQuhOJtHgk2haOixM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207356; x=1744812156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5bQBdzdrrxAwjVcMoSn7R6YHyOz0D1Ji82aPtHYgp0=;
        b=ugPkucXqrhjAea82+230z1PwLtg3xqzBNQdPb0YrB5g5NZVvsB4BW14joO8Ws1sM9U
         u3xXDi3BPljkd+c1cUlwavZe9y5+SMp+CPqhwIl9in+E9pd6dsth64giKBya96tuvBSN
         qtkz7MMOhRXJ3Zc/SBOmdI+16QyosjTgFpOSU8X1uKy4C8RWdpHk7EQHdrW7TpcZ4qYJ
         MlpuFJqPXIJHzfm3UWZm9ykMjhil9n2Ebsnc4AIU5snyj5xE5x9W4IlR1Hr2KXvC/GZU
         2sOHIt8rsieC9+K+sCbWx7Ta7qzFQGDVn+AXt53IAKEtpOXf88SAQGpe+Z/tsAdaxeBa
         cldg==
X-Forwarded-Encrypted: i=1; AJvYcCW8/iHU1+RF9bLC4rfUq2d5Smy+IUWW/FQRZ7glBNb9sNQwkW1+WXM1dDT1VjcYDCk/qNp2Ydw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRBwc4XB19X0od7sfpry1YzbQn5IdbupneF3pdLzEVwqybVj0X
	q+e7Vp9VSxrpUpnVlucNefGOjAcrs/djfCskHzkQST4YE42PZb4aQ0dbqE84qA==
X-Gm-Gg: ASbGnct6jwLh0rx+kytnowCjYG8qV6Zhl4B5ucgNg+Nj5bw4fGwMzZVQZe9e7/0xRmF
	N0jTXDLXDfZ7txpphyVQzx0vhwHFLEavnr9/xpvS8E7v3i6HEc6JYe26GbFpBup9p+i3hIoW+pK
	P5+57wQNGMfgz1WryJxxw2DVCku6/eCIYC5kO0b6fgzL+yxsHpP7MugL4FHmcQfwNe3R6GerPVN
	blH6746M/9B9LXSl552JDnQZ2xbiY9Edk7PBTgadLxXnXXkp+jh9yeeBVas3bU0f/PlPZ2J9BDl
	SEnRkN+uVT6PvsBpWaVbLqP93ezKCpkvc2HggklweqjxHHRrPRoJOofaT6V9hZnarW8kru0EdgR
	7iT1CrHRTJPrAUxsMJ2DAvRwBKpIp4Xx8vg==
X-Google-Smtp-Source: AGHT+IF7PMb1R5q8p59rA8TPAQBNjDsN03YUpj4RFQLPJr+kj5p6VXfvnMhdUKLLBLycNLAOFsyk9g==
X-Received: by 2002:a17:907:97c9:b0:ac2:cdcb:6a85 with SMTP id a640c23a62f3a-aca9b65e427mr329385266b.22.1744207355609;
        Wed, 09 Apr 2025 07:02:35 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (185.155.90.34.bc.googleusercontent.com. [34.90.155.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be95d0sm102657966b.55.2025.04.09.07.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:02:35 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Madhu M <madhu.m@intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] usb: typec: ucsi: displayport: Fix deadlock
Date: Wed,  9 Apr 2025 14:02:20 +0000
Message-ID: <20250409140221.654892-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250409140221.654892-1-akuchynski@chromium.org>
References: <20250409140221.654892-1-akuchynski@chromium.org>
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

Cc: stable@vger.kernel.org
Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
---
 drivers/usb/typec/ucsi/displayport.c | 19 ++++++++-------
 drivers/usb/typec/ucsi/ucsi.c        | 36 ++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h        |  2 ++
 3 files changed, 49 insertions(+), 8 deletions(-)

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
index e8c7e9dc4930..ef867136e51d 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1922,6 +1922,42 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
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
+EXPORT_SYMBOL_GPL(ucsi_con_mutex_lock);
+
+/**
+ * ucsi_con_mutex_unlock - Release the connector mutex
+ * @con: The connector interface to unlock
+ */
+void ucsi_con_mutex_unlock(struct ucsi_connector *con)
+{
+	mutex_unlock(&con->lock);
+}
+EXPORT_SYMBOL_GPL(ucsi_con_mutex_unlock);
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
 
-- 
2.49.0.504.g3bcea36a83-goog


