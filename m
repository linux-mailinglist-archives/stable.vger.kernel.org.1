Return-Path: <stable+bounces-144388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3892FAB6EB2
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D22188A6AE
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072F91AC458;
	Wed, 14 May 2025 15:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HZRY0Q+H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32AE1B5EB5
	for <stable@vger.kernel.org>; Wed, 14 May 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234939; cv=none; b=OGgWELrgi2sYkIC7xjTLQDdp9cmHmFA0u4tOSiB+/hXH/QY7Tcaz9/zxyWKAHFItnueKmcLUvUjzQ3s3bOdprN7Ak8U3hXilnC16j8gfHdQCujwnvA5DsHhdOm9ym/pf5OYgXfbtdhpruHRKEM+H56a9POGvUk2idn1IkaqdibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234939; c=relaxed/simple;
	bh=rne/UI/uhpyqHZtxBf8upAxQhGkEIQTClVfqioxOF0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW2yuTAe2WD7EqgLn2NFw/dbrTbEszUeZWvgH55G5b1QqStQLSxNgIA4bCfIRDirkACEsLfQMeFLgJ3k1VUFHM0sRjfHcZFY7wjHyRZFRBLKaefQskunjACWWr6n/RorILK+gL9dAbXNmkYhVSTszWFcTpdTio05zwXL6vqMF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HZRY0Q+H; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fbee322ddaso12647838a12.0
        for <stable@vger.kernel.org>; Wed, 14 May 2025 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747234933; x=1747839733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXtObF3xIyDtm4oC+RiV4mGd7UiqRnqMexVYEWFLh9I=;
        b=HZRY0Q+HNi1AX6RXEYouO6BtpYNHoaC17Khp+m6KOCDvsG4F0WokiiOtiw67MoFz68
         nIQX0+qxSXmQSW+dX3Ajo8Q493yP1WpGKLvUd05tNYkt9xNz/TF/tfWnekSrOKZHmxr2
         tkR1MSioXPYnJ42AYv5TbQQdSjSWZ0AOYfJzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747234933; x=1747839733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXtObF3xIyDtm4oC+RiV4mGd7UiqRnqMexVYEWFLh9I=;
        b=EoiAO2lbzZzRwzkBg6i7BjSicZH3/obv8guwd+fka7unbCrwbnRaFACmelzDFSaVbG
         1VKr4qPrnhq0UFwMWVleFsWgN+cWHMQAXVRp0ft9yaGRPaT0/iu10SJoPma3sQFLWQvg
         hiFutF8mIA60CqcWoqYCizQJ42Xv8V2IUuxI3dBgzigHqWJzLhvVssq/ABeOdd7hd1Jw
         4nkEo9yuiTDwyS0W8jEMtReiu+a7LwfrH6w+nrU/xUG7juakyEmlVf1ivbHkmR2TdrCF
         c2JjPHbe6P2S1pk4F9kCsoXBnLP5cqSPiXN4uAgagPG37Dg04cPlImBrsoiGlpxbqCpz
         nYMQ==
X-Gm-Message-State: AOJu0Ywiy8oaFfsvfdJaX1N5rD108irq4SKeyHicGU/51L6QfA/Ecf0P
	fvE5OLiD+OuFCzNNy/3gwGZ/IGuoRPHKlgcgwnOL/odBsBZDAmVrRfP49T9Ab0hmlRJRNE12PBr
	z6g==
X-Gm-Gg: ASbGnctKzJab+B2NGYQTphUXGkt8MFO1bP68xU9uHk1uVdPJznX1deqOFBqQrSZ/Gpy
	b5WR94V8pTmH+eR2NKqDp3jmobrJr38Q9kMJsWcadP38QT1pvGsJwq1xgN3q0nwELT8zeydlFxO
	C35znkvTrcB9fporGslrAT67Ex0sCk1cDSLkJKHZf9ULVBK1cWMoKrPDhkbTCHX+XC9LaFBN3BM
	1dOqEWjSPzL4Htzi89b0x/78abTqMBioLTJAaOyoCpp4Mx6OEtw7Ek1PRRarvgGS+ruSkew6S8r
	+avcHP3X7wENZgeFnYqqOOVjF9NT6f4Xp43av9R1V9WLVBIujpTU6iDmO4aQmu/TfHFAM0LS61t
	YaHPzYEdtXjQiiMnNrhKNR9rFI8elpEWB3uIfHY/RaA==
X-Google-Smtp-Source: AGHT+IHZ6e5kXrHQPP9JFsuhMXYQy5LcM1ovD4vXeIenhf74C8Oqmn+PhuWPeIIxH1/HfrwStGzNPw==
X-Received: by 2002:a05:6402:4413:b0:5fc:7c45:770 with SMTP id 4fb4d7f45d1cf-5ff988b9ed1mr3165136a12.20.1747234931792;
        Wed, 14 May 2025 08:02:11 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fd1950e6dbsm6266438a12.80.2025.05.14.08.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 08:02:11 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Wed, 14 May 2025 15:01:57 +0000
Message-ID: <20250514150157.2657456-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <2025051221-pacifist-liability-19cf@gregkh>
References: <2025051221-pacifist-liability-19cf@gregkh>
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
Change-Id: I72e0a5893a259321df1f38e54af36e61cbdc60a2
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
index 979af06f22d8..e42e146d5bed 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1351,6 +1351,40 @@ void ucsi_set_drvdata(struct ucsi *ucsi, void *data)
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
index 656a53ccd891..87b1a54d68e8 100644
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


