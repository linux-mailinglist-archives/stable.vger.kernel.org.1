Return-Path: <stable+bounces-144386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24327AB6E8B
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 16:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F39F57B6598
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 14:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E41B3955;
	Wed, 14 May 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ogG57F5Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0088488
	for <stable@vger.kernel.org>; Wed, 14 May 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234181; cv=none; b=KWshKQ54No6ZQ9trSK4E7PoWVVgsrEQOFPs0w9UavyDv3Y3STwEOscoZ7LgVuWRWubSIP7rzbsdoo4r+Z1DgKFBxQfu3dnD8kMoQGMuZSKyxcMJoAXLhFSxmFtXLupLpK5KxBnn5m/GnC0DKR03GRL72ZuYrYQZoE3MLOMWAj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234181; c=relaxed/simple;
	bh=LxBmeG9apa13RF65iJ9w7HN/ckZU/Cln32UlkqhQiw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VimcjfB5VyaIb3lI+Es96VFjidQ5kJhEK/4NNAcfR9KvaXKTECwigDNuUL3L74lVzGcVEju32FU0nUqL1oQT0DW44HYjfA/k+bxHKCrsm8znofZrcAP1SMHvnLsO/yRNEiLCYFh8zQt6LiL23ajvaKC9AtP3Z0qfmxRICcFrfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ogG57F5Q; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fd32c133ccso5504414a12.0
        for <stable@vger.kernel.org>; Wed, 14 May 2025 07:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747234177; x=1747838977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKFvdnUqP+LhSuhe7Th6QtDzquQBj45+/ies/0ai7wg=;
        b=ogG57F5QLh0G12ia6LU+h+CSEkbi1NS8i/pFX4klRyyHevcMmKOS4yqxkNulZfVAic
         PgzdEurnh1LcAlTkfh6Kx02Ik2QWN2Cco3Ax9JSvBT4XnpG+w2BQY+l1biBS93I4rJPl
         GeduxsLB5WNkm8P/skM5z3Z3LGl7qpC0Uhd2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747234177; x=1747838977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKFvdnUqP+LhSuhe7Th6QtDzquQBj45+/ies/0ai7wg=;
        b=ZRtStYmv1LmAcLGSJbW87bkkafS3UJIKva0a+wTmg1H50Sje+CinV0REeD8u4t81Cs
         63KNoFQ5hy9L40LMwzLPit+nyo8YTIariE9vXJdrRHRqlEJVgZds6+r6PsVB0l9ILivK
         sWO//0Pu45aqU2iui48Gq+Q1QQSamNrADyr1sVmZr6jMLHjxwVkztXMdsHlyvs9JzC3T
         J9WptbTJw39HA2Us6KjRv5LVl0kVGxJwz0e9vvRByqGJXxZIQuUNwJWsEwP8gLFIE7QI
         LqlAh72ZxapIfDyrabgaq7Dz0jq47D65i7AhxkEnAQTM1qUPhuBgWzTTP3G3Cm/9Byzv
         60Ig==
X-Gm-Message-State: AOJu0YyFXvC4AohX0mSZWsfU3YMrMQ3lvAFKBw/KfBr8dxrAHEIChbe7
	dmCAEVNRU5v2BV+IxASGAgT2ElsOHUKwh1rkc4LM2o2vswt5r9KAM8Xyh3ZFbTe9YZwwgrase78
	=
X-Gm-Gg: ASbGnctnulKbSXzgv64QjHDPLIO7MGnCwZZ4Zhopn/RmbCY3ivzOvFwckPNbIOFsjKM
	bg+ckNSzxcZZToXzF3J6wIYa3wFkmjmmH1BQ2FeZlSBWTBsTs8iCR66TjUR1CTdu0EmTDKv2xhL
	jXwxVkbLTyASaLa/aEKzUcX1xxMHdM8sedlEkhF9hcAFLb26UNoMbftEv6HX12IiXhIWJoAZlM7
	IoLF0ZLNFTPG7HSD0RVzUK88aFqLuDFc+FexDVJ3GwbvinNo66yvnqI9dzPGnnF/k0p5WCGjosE
	URG9abuhJhajnMmLnHRrVfLJTqsueTxevG7rBuK3dbiBmgLo1FVkuV/yHN3OKvXl12d3rtGKr5Z
	58dse8o0AJf/5TxSzw6XpiOl0X+d6x8QpMzpLh2mt+Q==
X-Google-Smtp-Source: AGHT+IEDpKQ9N/Il1orx70zQdo1RauF5mDfG3cAlVgR+yrjGw+CWR7313k8Uj3lP/rxEOkqNYXtZVw==
X-Received: by 2002:a17:906:630e:b0:ad2:53b3:d81 with SMTP id a640c23a62f3a-ad4f71a8f35mr297943066b.35.1747234176546;
        Wed, 14 May 2025 07:49:36 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad24677c9e1sm618802666b.88.2025.05.14.07.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:49:36 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y] usb: typec: ucsi: displayport: Fix deadlock
Date: Wed, 14 May 2025 14:49:31 +0000
Message-ID: <20250514144931.2347498-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
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
Change-Id: Ib10b1ec42c210b49cf67155ed1df7b074a99405e
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
2.49.0.1045.g170613ef41-goog


