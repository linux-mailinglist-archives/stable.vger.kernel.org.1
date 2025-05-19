Return-Path: <stable+bounces-144748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC319ABB73E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 10:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB359189796C
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 08:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1216A8D2;
	Mon, 19 May 2025 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XqfxcOvi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A461DE4EF
	for <stable@vger.kernel.org>; Mon, 19 May 2025 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747643511; cv=none; b=os685+yD/s/KYD5s7opHoZtc0KPDNmUuoTMfKNoQogSP+K996nLSak9KYiYtY+YwKefRI4u79IM2UqksNA0eiVsBYvtX+K14XOljew/AbX4QVtu78LoRfL0akRVFbf4yrGOvZiMyWkIIRA1XAJ1WRJZYLZA1e8f+UWqSaQpD2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747643511; c=relaxed/simple;
	bh=zIFIlCCWtPGWlLUavTNkl4locEvlm2n4wH1CCttlPyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jU5JL7lkuzmGCdt5SNGtw6MbRj4XETO9QcaELAO9MmBljqDW9n/+5oiIgNPnysYaSgdPaG0dliEntR6IopAws/EZQnt6+xOeM0HRqmh/IfV0O7tq65tY+Gxg+Wv2myQEK0h0D9zc6SR9pGswoqkjRNvdELdlm08v8ZQ36u4hvj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XqfxcOvi; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-601609043cfso4020960a12.0
        for <stable@vger.kernel.org>; Mon, 19 May 2025 01:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747643507; x=1748248307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BFRe3xRm5Ny6A3mvWEK5yWknGzJIHhQqa60e9uWEjw=;
        b=XqfxcOvi27bTtvsqrVzZsTW5MeAoUFltKBA/J047O0CT+71UtOKMOyXDFVANOnq4WD
         5vLKgepiHuLpEDEwB3Vw2QAp8aU7Gt6M+4UsuIRlI2R/4pZTan8DP4amwD9iB4PLZVF1
         o/S9XqmyBR/nxb6lnaHrzl05nHgPpQjJ/X0ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747643507; x=1748248307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BFRe3xRm5Ny6A3mvWEK5yWknGzJIHhQqa60e9uWEjw=;
        b=KQyR9u3zah42OHRIMIlrr+veSg/n3vBhu43tj46AekjEqwA/A+Et6A2AHB9zMMXgsr
         QjJ2ZdFxDOSz8r+XCbigBvPyMMzzVbO0Rsuc5QR50FL9drO7tgR6lCWiavt3XA2Gc/9J
         lAkfb9bGkogDWEFa+SiRg/gExEbjodQeRsF4qV/Lw7mU/iVa5j6GmBP08IYuWimuFbCh
         ZJdNPzKNs71ctzK1vJswOCECG2Y1MeX5VdQOg7fjKCxu0lpF2bYzCBAbILg8IpHVEWjv
         DIoIpgX7ftY2Nk/jsyl8rK3y5Zjh6KJDovVX6apPMVxiJhINi/F6o+WCkzvKQIsfQiBf
         5OWw==
X-Gm-Message-State: AOJu0YykwzpuLMrIU7hNrcGY+mMaab4vgQmN+jSvJjRlTvl6R2tGWkCh
	qaH195QvED++qeycTfNmPSvOTn52Mgp1EKuRHSLbCA20sx+An9IWNL3iq5F+uYpgsO3NkLJnyef
	/wiy7PQ==
X-Gm-Gg: ASbGncsWrJx6zeweX53cey8rAFF9V6w2iaIf2tqfIer0L7/dj7gjTng3sU84clQi3DE
	D/HTwwvuh9vyvnLm77fGyKYWWc2Oku7RWB/uQvbty7fqC4wl/3XLazBYzxTyX7uCbYMC1ZyuFDE
	eqHj9cexK8Iy3zl99wKyxyZqLgA4BzaGgGcnsuaasb28d6Jc1o0cJgdZdgKiaADeBuBBfdEnfOb
	wy8bCGVkt9GXRlP6ugYHmrRcC3lFoIuGZfrUR3xODhW5LFr5PeW0ELUoIEW/8dq7/UKYHUxDCXU
	PtbO1H5AO63YAeCusnA5IvcBexvqBT9EOe+pv7usFNyS+0a4X3UiXDYjNIOjawn3Ab8GmdGt9te
	pAQOZ0q+YA2jI4cxwyNWoNGpm05R9p1ktokPfrokrYJlyqsWLy/aE
X-Google-Smtp-Source: AGHT+IGpp6RwGjR3YilIgnxlUPggrQN9vCB2hvw8/qp98ALRPxFtDxkqn9MC7P1dHa+Bb9aoiJFfDA==
X-Received: by 2002:a17:906:dc93:b0:ad5:6ca3:c795 with SMTP id a640c23a62f3a-ad56ca3cb15mr341930966b.33.1747643507459;
        Mon, 19 May 2025 01:31:47 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4cbe90sm552776666b.165.2025.05.19.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 01:31:47 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.6.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Mon, 19 May 2025 08:31:41 +0000
Message-ID: <20250519083141.2406448-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
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
2.49.0.1101.gccaa498523-goog


