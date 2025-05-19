Return-Path: <stable+bounces-144750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D878ABB80B
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 10:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11591887969
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3B326A0DF;
	Mon, 19 May 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OLW93gpr"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20128266EFE
	for <stable@vger.kernel.org>; Mon, 19 May 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645089; cv=none; b=e0Y76XYSvHWnMXMp5Sz6e/WXQv2gZ+W0ncsJvyzGCzFY87LVHyWlfsdz90LBuQYCbSowJuF4xAj2tU1LqGSC8wo3D/Pg4QUq8jBs0nDfLSes+UU6o+tsBkBl1diqh5adjoN3HGkcxTR9/rbDri3PZIf+O4i/DTMyQYXJLFV2Di8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645089; c=relaxed/simple;
	bh=gfbTQ7Wrsy5ZLUasj6kx8wsCGlqAbb7UxZmDXVWP5bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPmMSyAJ7rbrU1oamWshx2oUU4gNp3dPhbmM1ll9r2Tl+YDK8MD1zaSp3OmwLES97WDgMbmVgi6dGC6g+9GENB4TveF2fDPwP/t2S90J9AxyDbG+4bsWBMOoYkyAJK/WvDcZ04R9KLOfYIS7m4aHg+3PVLcqgfqpK16SRF/K5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OLW93gpr; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-601dbd75b74so1480880a12.1
        for <stable@vger.kernel.org>; Mon, 19 May 2025 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747645084; x=1748249884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiuYJfJfWmyAqH81+BJQQPzTS54sfpgl4bzvUaCjIcQ=;
        b=OLW93gpr5StimmxHA3mZFBLAtThahVfm4GWEiJJTUss3hqrOuq+SRHzKM9WixpHC1t
         iIMEI4AnZhJOuPkxXtg6Ewl4k7i1ApA2x3BI/8qNmmTqgSTA0bUwj9G7k4vaVDyPgCyP
         CZLRNameJ1MQ3ANneeMVw5dDoInkUqAiDaRQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747645084; x=1748249884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiuYJfJfWmyAqH81+BJQQPzTS54sfpgl4bzvUaCjIcQ=;
        b=vvTatjMNk/sRbmLfGADVAvGRtPfSk8lU7XxqfKq7Uy2nF2fe5sS8ZH5l6DFetsZhKN
         7lwQLFGUj36T40JZPINrKwG/mew2FUahHN7qQcULf55xLQ4XmR/lTj9bliCf9bEe3qZP
         ce9xCk4dapzHt9E/dA6ivW/k3198suugDZL+0Oi6FLqAXHtMYB8bRM+cmFTzF5ED2wRy
         1rKW6oR97KBF/TMgsfGVY0423e1GCO8mVOSEugL3BGitWUyI3t9+r3Yg81hf8EGmNTs9
         pODLJdziIPA0BqrVz1JUc+NIBtHVs2h/ldseayqWyNW8OZ3wWoXx3JGsYboTwAnqRbNo
         hPgw==
X-Gm-Message-State: AOJu0Yyjm6ISSbK/N/qWQ/CO5AJXiLTntE1+SBzYlGqqk6CnOaT52N+m
	XsfjVvzUOVneAf0ECF2E6csGWD/V6JHQE1hjMSxUI1E5eeqernAGIk0fQEcwyLPIsYeydzyM4Ug
	1v5qYFw==
X-Gm-Gg: ASbGnct78XUK7LrL/Ql1sP+FD90xbD0uRQ6YQmX4PzlEy/tocqo+zRwSDYHy/PSY+qf
	nfgEbKtYz51p5ve0VWtc/GXlvMbA5MZU0oVOvdqpVIhp/xA4JiA6ebgSsRSc5q80gKrQpUvV8Mo
	D3QvCen/kM4DmwEx9yaEGn8PByS3bPpPxvCPwOP4cZLlNFuRckC4M9uZePk+CfKN8WTvZP+Y3XG
	jhtVnXRWE14y+susHGyo2jURTA1pC+9ZQHtx+exzsSPlfBg0WDYU1tGB7hX5Q3uLyhcGu16DWkD
	dnAJ3n4hSBBZVRyfJ2l2z3Ak3/qSVrlrB6qJYLQ6CyFpD1fw6i5PYQhgkvJS+MO2CTp4okYtYhf
	NQY5usVAkRKD3PbBvFTbpMRONiRX5cIP1LY6PCxNaMA==
X-Google-Smtp-Source: AGHT+IFYDIyBXl7RS4qYHV2FPHMm3DLs6Sb9hwPLLySSuHVFnEaWxyj0ziWVgxNAb0+zwn+pqbYWdw==
X-Received: by 2002:a17:906:f1c6:b0:ad5:2e5b:d16b with SMTP id a640c23a62f3a-ad536c1a81emr876563166b.27.1747645083937;
        Mon, 19 May 2025 01:58:03 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d272047sm557330166b.72.2025.05.19.01.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 01:58:03 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Mon, 19 May 2025 08:57:59 +0000
Message-ID: <20250519085759.2694434-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
In-Reply-To: <2025051224-washing-elated-c973@gregkh>
References: <2025051224-washing-elated-c973@gregkh>
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
 drivers/usb/typec/ucsi/ucsi.h        |  2 ++
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 5d24a2321e15..8aae80b457d7 100644
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
index 3f2bc13efa48..8eee3d8e588a 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1903,6 +1903,40 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
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
index a333006d3496..5863a20b6c5d 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -91,6 +91,8 @@ int ucsi_register(struct ucsi *ucsi);
 void ucsi_unregister(struct ucsi *ucsi);
 void *ucsi_get_drvdata(struct ucsi *ucsi);
 void ucsi_set_drvdata(struct ucsi *ucsi, void *data);
+bool ucsi_con_mutex_lock(struct ucsi_connector *con);
+void ucsi_con_mutex_unlock(struct ucsi_connector *con);
 
 void ucsi_connector_change(struct ucsi *ucsi, u8 num);
 
-- 
2.49.0.1101.gccaa498523-goog


