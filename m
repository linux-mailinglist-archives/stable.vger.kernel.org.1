Return-Path: <stable+bounces-136538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEAA9A6AB
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FC317B2FBF
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E40229B27;
	Thu, 24 Apr 2025 08:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Le1+fHVl"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B81227E8A
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745484284; cv=none; b=TyO+G5FIJBIXH1AxIrxfEqSr1urZ+5bFhBNYUbj0+dgS9I0m97JRtSqNmjeavcQobtUS2QjJnulqDmFCHSX/ACJaDpmXzBTP20E2plYmY6PeJ/liaLzq8pn2rm5X0RhQk6x4RxsrfVXV795WsoxxiMY2+1ix5Qu5KFEyx7MBmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745484284; c=relaxed/simple;
	bh=BCkwPiQJglWzF5ly3aXp13rahJGuza6cE4lQQ1R0SWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGCvLpSTVXMd8e9A+pEIHqaotWpw2KUdmXgDxWt3SidYG2T6EjNIWEu+slAB+XSFCPNsjsBH/+m70IAad8IRctGNq859mNrnXYYCxLqyd8J5gJTc7wWiG2/Cu7c5zytWQy9D+aHmoLNDXiB/Q740LtGt/vRpkOA7QOWrPzdyK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Le1+fHVl; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaecf50578eso114043966b.2
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745484279; x=1746089079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W64t7hrZYe3BMLaCDCRTPaqOT9dK6NO9YovOiyyQLrs=;
        b=Le1+fHVlsNMdfwVoqdVWZPX10WhnLIy86XezKhBqO2kPiqBfW+l8boU9YA5e0RQY4c
         X2sUCG9nkhP9ASGpeIA9NGYVTiY68jL3XY3aiAHXID3QiywH0dOdw+jzmRetrf6rUUXT
         x6MNO/12vzfZ7gz0hchoAAtA4gLf+zPUiFq3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745484279; x=1746089079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W64t7hrZYe3BMLaCDCRTPaqOT9dK6NO9YovOiyyQLrs=;
        b=julK/i8CK4s6zv5cs8OofpLGTsxPyvXi9OwxJg1QEZWcCByyBPRxAwwOiRQWkhBhBR
         T5y0RIcT9knckfhpq0+U1KKEtgsyQYJeeYLpsKVsgEjZpM4itCfo9yZ2GSpqUN+GlJ+Y
         LRwNMf89r3npjPxPPiBAA8qe7+7d1ndtLaI7uFws5TSOvXjQN5o3TSnxrv5E6RIA5Swe
         QDRAipmr8bEXQGLqnj0Yb/fZKqziXa9uOhYeadrdHTwpz1pDpDYiRSnC8HYkUoHxCi8t
         Wf188QNCTbFfMSxSp88MvOT6VPumvJvzMVVOOIgUrOF85IMMWk7ajG/HukzPjJADUKZ6
         zYuA==
X-Forwarded-Encrypted: i=1; AJvYcCUgAKdi9u3+sshaetJeu+RUInx36fpITPLZsaVo1K2VCy+syHU4mQSyQ7Nb58Ru19/ZFmt6sro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzOr9BeZKp4A0VklNhBV5Jb0rTEv6k39SSFkPwzSSCqNZ/I6B
	VDS4TzvFq0Boaar98LE5J+rbCRje2NUj6jNgtOH8pyaI1thUh6PMhn7qZUVBCQ==
X-Gm-Gg: ASbGncs9/p517xbgPde5o0dnMHGJveRGfGdHfifWGH/tnclDtg/XMBJd9K5QkiVtWnn
	dYRGH3u68/kT8ZyWKByMihIldfegeHdNg9JbXEHvg+qA/hWR0KyVkQ260qbPK+8scM+QKAuArES
	oDDsniF8OH5ykbsu3uJXpv7pFZPKNTWbVXKbRYrxKSFOQ1DzNvAOiB5EtAAg99Sq4h32d9Rx228
	lzu+5tJYr7og9nkZC08fLlWx8ZZ/ZShUoEtge88WpJSuOs2sD4fn+Ev28CCDCXkrmtbniF5wnwY
	YPUZWhzggcF0fic9Qdpux/j2ahw1bCrhvt29idUoxXWvmpK3WYUXKFCjIYSQ4WgEhkn0GEQCLpS
	au+G/gpKynA4eKg2lBaEmMpT4G1VSSjEnqQ==
X-Google-Smtp-Source: AGHT+IEXMMgniGW5dLlSgHFd4dZHP6L/l4pXs8kelOlAcfgxGUbBIWszmIZSLQOD8ZDAW/YII0aPQA==
X-Received: by 2002:a17:907:a48:b0:ac6:e327:8de7 with SMTP id a640c23a62f3a-ace573a6ee9mr143333766b.42.1745484279399;
        Thu, 24 Apr 2025 01:44:39 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (100.246.90.34.bc.googleusercontent.com. [34.90.246.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59c5eaf0sm69377466b.181.2025.04.24.01.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:44:38 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Madhu M <madhu.m@intel.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] usb: typec: ucsi: displayport: Fix deadlock
Date: Thu, 24 Apr 2025 08:44:28 +0000
Message-ID: <20250424084429.3220757-2-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
In-Reply-To: <20250424084429.3220757-1-akuchynski@chromium.org>
References: <20250424084429.3220757-1-akuchynski@chromium.org>
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
 drivers/usb/typec/ucsi/displayport.c | 19 +++++++++-------
 drivers/usb/typec/ucsi/ucsi.c        | 34 ++++++++++++++++++++++++++++
 drivers/usb/typec/ucsi/ucsi.h        |  2 ++
 3 files changed, 47 insertions(+), 8 deletions(-)

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
 
-- 
2.49.0.805.g082f7c87e0-goog


