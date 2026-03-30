Return-Path: <stable+bounces-231009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LKNA00Uymli5AUAu9opvQ
	(envelope-from <stable+bounces-231009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:12:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C4C355D56
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 08:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C20302A68E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 06:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11FA38759A;
	Mon, 30 Mar 2026 06:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs4qHoHG"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D9B33B95B
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 06:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851013; cv=none; b=Bg0eLLebI3LmI86SJr/6hEQXvHjzMhinoIs7jRjMWt/h3CDFEM6fBQMafl5mv1hLx0sCBfeoUKd00wcCraUya0t60izwZeEFFUdWrM1aaWR2sd881sRp1yGpI9VQaJewokdaEyF8lPN9qyrN9QQODLseyL2w9QRwRzMsWvoRXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851013; c=relaxed/simple;
	bh=57DrXeQnUGc6iR/CXOWyyyVZBnQ5MkHIKUWHPpAsMcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DlmigKqIHa4wPSQpm5BB3Xb0DKNy04CEjOeTJJRg+9wYIJwAM9MbCmItrh2vEes1pji7W/WaDAaQJi6936IM0nRBLA2yZu2SiIIqsnZoMp3nHbqQuXSmgWQytZx6Q3GCoTCa81hyICfvZRReiitpdF6n3jIiCMounfw6hhzMIiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs4qHoHG; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5ffe1c73287so1444130137.3
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 23:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774851011; x=1775455811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVkfdJP2KulZKEM0URtofZekmehI6WAdAhgF+udGJlg=;
        b=bs4qHoHGkb7YdhSUMkLyR+fYZeSFTOyp4dW7olvEW9+8evk+HFAWsU6JLCVPjeHJoA
         Q5xxHR6Nz9RorRUQMREo0aDKfEZEShpTdNU6CUuoykOV1qfNAbVaJzhyNsMFJe+Dilb/
         1x9I4XwVTRhciWZtTCWv6ovp4wrwjlQYDyKOL8fXOAiC7rFjHI4Dj2+YP+Pq4QBFv+nl
         D8vYMgZX4imi+/6XhRZJXow5hBRVb4QQVn7anFYyRnGH2SeSdlIkleFONdXOGkHxkuw9
         feA16jCUxVLnmhRC5bgWpjz0Jq1fnHjbqlhAUeRVrPjGJkVckorUgpxK7bkpB9jgimsU
         JVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774851011; x=1775455811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVkfdJP2KulZKEM0URtofZekmehI6WAdAhgF+udGJlg=;
        b=ZWPpOYKNFxQzIPC5GM9yZnAxWqjCfrB2fj3AfWk3pBE9k2AWitCo2qN6yIla0GTbvd
         B9Z+R4gxBlPn/bWjBr02wtp9IjI6rK0cNXVA8eW9ffjGwGrgB9q9W2jQ1jIkaMv0xa4/
         WhQmaO8AhkiG2c9kP5P8rWnwGotMLCF2lG/bbtwRfuzt/rdPtiPaChQrnJ3Xz2EysHvx
         ZEM60FxpXHdfAHV1CG3v6Ryrbg0a9s4IhTavBvpPmyEh7g++ixGZccjxfGY/W4fcV7pU
         0ssLS44YjQsHjJ8dlyOg4hu3KNuI/BZTQCJ7hgFcO6Tc1lDzEYV6tQZKnIpC+zLHrH/I
         wmiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo8ZlBIbN0SfPZLqf+JssLiBQ62XUbJJjJm9TD6HgJ9ikimIyt+ieQSN7RdkNv5OQ7hoLOQh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcuo9FYm86Q9/6fit+uJbl9BYeGOzYTcpivA1eWR+L3D6XrcI
	TiqqUfhdtxr6+gQqmnIrG00ykfHSMtU7LgpnlbV1IWa7KA9ceJE1ZwlA
X-Gm-Gg: ATEYQzx1BZ0Pa6bcem9zWdFwDcYIoigkVb3vejqMElX1bmaImBoDe6stmhsDZpvMRdg
	8ANO+aR4CAMk+IRqvd9WjAfvTF05iw7NCSpsS7j0PV+vAFepTuf3B1UFtpYwXrDjBLfUNKWubNa
	d9T9ntfGuDOVtUBhZOBOhNV8/+PDWuGT7dczxxXuMwSENBBGO7N+/YYTKZYeD5CDNVmVaCVR+1B
	28S3zEZTEFsb3Qq7JE6MGFZlrv+iYS+YUho5Gs9JO3sAkY4kWoN0N3PjBjvL+5ldi33onTQYtl4
	z4NVkNB5g1D+8UdjBojYEtdg5+qUEFkwsUrpngVEQWfdGVLeEQsk6VMWWkBCuvmMurlTjeUWfqy
	cOOooSuitt3XqpWyagDcVuVM88VDEunKHm8WJfqx1191VihVbsjRFqW7pzKvVJaI7iZXPJxcvqj
	ac85/0ut+8mhrvtLgI2mzIt1bb
X-Received: by 2002:a05:6102:cd0:b0:603:2173:d75e with SMTP id ada2fe7eead31-604f8d8b751mr3805351137.0.1774851010812;
        Sun, 29 Mar 2026 23:10:10 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6d9:aa::11:1d6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60512d3a037sm7133561137.9.2026.03.29.23.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 23:10:10 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: gregkh@linuxfoundation.org
Cc: marvin24@gmx.de,
	linux-staging@lists.linux.dev,
	ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
Subject: [PATCH v2] staging: nvec: validate battery response length before memcpy
Date: Mon, 30 Mar 2026 00:09:26 -0600
Message-ID: <20260330060926.751031-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,lists.linux.dev,lists.launchpad.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-231009-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 66C4C355D56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sebastián Alba Vives <sebasjosue84@gmail.com>

In nvec_power_notifier(), the response length from the embedded
controller is used directly as the size argument to memcpy() when
copying battery manufacturer, model, and type strings. The
destination buffers (bat_manu, bat_model, bat_type) are fixed at
30 bytes, but res->length is a u8 that can be up to 255, allowing
a heap buffer overflow.

Additionally, if res->length is less than 2, the subtraction
res->length - 2 wraps around as an unsigned value, resulting in a
large copy that corrupts kernel heap memory.

Introduce NVEC_BAT_STRING_SIZE to replace the hardcoded buffer
size, store res->length - 2 in a local copy_len variable for
clarity, and add bounds checks before each memcpy to ensure the
copy length does not exceed the destination buffer and that
res->length is at least 2 to prevent unsigned integer underflow.

Tested-by: Marc Dietrich <marvin24@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
---
v2:
  - Introduce NVEC_BAT_STRING_SIZE constant to replace hardcoded
    buffer size (Marc Dietrich)
  - Store res->length - 2 in local copy_len variable for clarity
    (Marc Dietrich)
  - Use NVEC_BAT_STRING_SIZE in strncmp call for consistency
 drivers/staging/nvec/nvec_power.c | 41 +++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nvec_power.c
index 2faab9fde..7b7980127 100644
--- a/drivers/staging/nvec/nvec_power.c
+++ b/drivers/staging/nvec/nvec_power.c
@@ -19,6 +19,7 @@
 #include "nvec.h"
 
 #define GET_SYSTEM_STATUS 0x00
+#define NVEC_BAT_STRING_SIZE 30
 
 struct nvec_power {
 	struct notifier_block notifier;
@@ -38,9 +39,9 @@ struct nvec_power {
 	int bat_temperature;
 	int bat_cap;
 	int bat_type_enum;
-	char bat_manu[30];
-	char bat_model[30];
-	char bat_type[30];
+	char bat_manu[NVEC_BAT_STRING_SIZE];
+	char bat_model[NVEC_BAT_STRING_SIZE];
+	char bat_type[NVEC_BAT_STRING_SIZE];
 };
 
 enum {
@@ -192,22 +193,36 @@ static int nvec_power_bat_notifier(struct notifier_block *nb,
 	case TEMPERATURE:
 		power->bat_temperature = res->plu - 2732;
 		break;
-	case MANUFACTURER:
-		memcpy(power->bat_manu, &res->plc, res->length - 2);
-		power->bat_manu[res->length - 2] = '\0';
+	case MANUFACTURER: {
+		size_t copy_len = res->length - 2;
+
+		if (res->length < 2 || copy_len > NVEC_BAT_STRING_SIZE - 1)
+			break;
+		memcpy(power->bat_manu, &res->plc, copy_len);
+		power->bat_manu[copy_len] = '\0';
 		break;
-	case MODEL:
-		memcpy(power->bat_model, &res->plc, res->length - 2);
-		power->bat_model[res->length - 2] = '\0';
+	}
+	case MODEL: {
+		size_t copy_len = res->length - 2;
+
+		if (res->length < 2 || copy_len > NVEC_BAT_STRING_SIZE - 1)
+			break;
+		memcpy(power->bat_model, &res->plc, copy_len);
+		power->bat_model[copy_len] = '\0';
 		break;
-	case TYPE:
-		memcpy(power->bat_type, &res->plc, res->length - 2);
-		power->bat_type[res->length - 2] = '\0';
+	}
+	case TYPE: {
+		size_t copy_len = res->length - 2;
+
+		if (res->length < 2 || copy_len > NVEC_BAT_STRING_SIZE - 1)
+			break;
+		memcpy(power->bat_type, &res->plc, copy_len);
+		power->bat_type[copy_len] = '\0';
 		/*
 		 * This differs a little from the spec fill in more if you find
 		 * some.
 		 */
-		if (!strncmp(power->bat_type, "Li", 30))
+		if (!strncmp(power->bat_type, "Li", NVEC_BAT_STRING_SIZE))
 			power->bat_type_enum = POWER_SUPPLY_TECHNOLOGY_LION;
 		else
 			power->bat_type_enum = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
-- 
2.43.0


