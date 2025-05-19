Return-Path: <stable+bounces-144761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5F4ABBA31
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72B81897F55
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885C72777F3;
	Mon, 19 May 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jsF+w4HB"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B6274FF2
	for <stable@vger.kernel.org>; Mon, 19 May 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647819; cv=none; b=KwNuJvXkfry7JkHdvMcCBqBbKe20cNflSbKpNAed8XQBuf2am1jUfFoM/bwWP9mYEV9qgZoukEpRQBM1vGDJUp5oA3iALu/SpoMtwpDeTyRggpDVxgI9eazOQYk1gCdL2G/ojwPYuxzqoSEDEc/exKrV3mdTrXWdNDSQVw4P484=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647819; c=relaxed/simple;
	bh=2AEyWU1axcaalXmnx/8DK74hl+K2KM3AcDzK6HZJ2Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfW4OYuS6sRGSy2vZhFsD9H5bDSEOGIJ/Yi3n3Q5debUecy1JRk4Hl9tYf2LWM0YOKKy53xkl7YB45sDD6GryJjnhdU51IQcXzPUHtQ1VHAFn2cK1s8i1QIQJ7m5InG7B5sZoLHMC6FeMN0eO0nmEEg0jI/3y2auFScAAlDzflE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jsF+w4HB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso7588077a12.3
        for <stable@vger.kernel.org>; Mon, 19 May 2025 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747647815; x=1748252615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4tiGig8JSReFDT5J1Yx/Hvv7S6VsYQvdCEKEDC4RQY=;
        b=jsF+w4HB6G/DDtth6rWJfmKrGuARhzlzEoT2UOUV1GnhsB9WOX3hHFMLKnZH4ctym6
         ra88VLiu3+e0e4cSUfs48qxFlVK+mxrNBhiPBaFruCkXqsN5aGdeXquMycCrhEfc9ZfU
         voPGGQqxpIn2M08bAUIXY4NFSNQ1okEwW3alQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647815; x=1748252615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4tiGig8JSReFDT5J1Yx/Hvv7S6VsYQvdCEKEDC4RQY=;
        b=arz1ZcV9JxaSU91hFZTo5hVZ4keBr5HLXtumjp943P0ordI4ghx2kopVW92QS+QtIR
         RciaLRdrV25yoqxvUv23b+QdskzDoPE2+IM4zLOAX1PfPuTumYfUU3sIim1LdscBf6Km
         Hqd58ssn3JRcl/Egh4IH7YA9fqzGMy2YqGytz43tnfuirjxI24+bA5FbQGoG/NhasSAv
         zaupj/vKlQ07SaTeq4S4gRx5SK/1Hiq42UKZqwkoZ2QVHRDszSi1tXRRHsOYRG8BFtYa
         AzmOeMBHLOQN2CrTK9z5MejdC0UFLMGS12Eg9ORq+ROZQM1aOl7qW0gdjPNi5ISqB1S9
         059g==
X-Gm-Message-State: AOJu0YxWlParQAf/8+GUvpb/Lf2Q8hWaBpwDsXLDqYqx/SceRHQH1SxH
	Pqs0cwXbS25uJqDXmNiw1Itqv3o0MHNhqJuj9v7o31NWoFC8kNb76P/7NUUQ5u/Mmc99VXtAuBZ
	A0Lqpaw==
X-Gm-Gg: ASbGncsgpLq0bLeNRX1lyvteQMv76jnonUYm1PGEyFTVP9AigGsp1X8O35vo79SrQvH
	Ujs3jmUC71HDQNYqtrN6yUlnWVZVtG09molvNBNVF+5jie2PODRcD+lddaGYR/rA21i4CzYuDl/
	uHpaJp/9gdjnrGUVmknYLHTn1VA/ZI1HDIxzi2okOrpTfmOA2d+w2FN57N6DP/m3Y+ghNZ1EWTD
	tjhtmgMTdW9dkREzgEI0hdSijy+QNUWVBpSQXjzF2cnfJuY8N850ErzAVGEDU+Ju1H/Zizm5gmE
	E/L+sXnk75Jhb/3rYnR3mVbw7GG1oIa5jE3795LqPfX/Adm9D3/pbTixA1NspQpzPvGCDwGoV7b
	QKJYS+dXDJO5OGb9JQ2TBQHYJIFoET0+SoZseQj6jYg==
X-Google-Smtp-Source: AGHT+IG7yVdsDo9QgaOXpSYJGcPVgOmbJxJ5p/8DX65pIYUOa7meSiL8f7CfcbDv0ZptAWpw/LVX/g==
X-Received: by 2002:a17:907:3d4e:b0:ad5:e0f:7850 with SMTP id a640c23a62f3a-ad536bde688mr971405766b.23.1747647815105;
        Mon, 19 May 2025 02:43:35 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4f8c20sm558250066b.181.2025.05.19.02.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:43:34 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Mon, 19 May 2025 09:43:30 +0000
Message-ID: <20250519094330.3225918-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
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
2.49.0.1101.gccaa498523-goog


