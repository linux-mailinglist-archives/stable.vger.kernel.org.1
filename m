Return-Path: <stable+bounces-230980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDGRFdiUyWlizgUAu9opvQ
	(envelope-from <stable+bounces-230980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 23:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 580CD3541C4
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 23:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 232C43003BF8
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 21:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174A38A709;
	Sun, 29 Mar 2026 21:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYBXuNmh"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629842C027B
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774818506; cv=none; b=OYoZXc1QboDlHws7gN8NGpjOeoX/v3lg+bvw/+ESc0ZkqGFDx7v/IpXjqItIqAcwu13VM6431tKhg8dGhR199djTZJEeHVgL4A/eH1NGXmNf9sLLH8wCEmGl3A3IqclynKoKt0jNxagPS0X9WT/EQ4gwfFlVPD0Tyb+8o3jdoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774818506; c=relaxed/simple;
	bh=57DrXeQnUGc6iR/CXOWyyyVZBnQ5MkHIKUWHPpAsMcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hJoOSnKCzwaIjTqBLDFQNamSrs71HsZ5WsjaQePuL2iM6V516eT+HeVnK24Uti3MZsGh3lOU05wvcVDhBk81GRuicdLPl1BYCzMgdVGKrDhBjxgJl5Ti1QN9RK0PSp7lTdae0UlIimBpbRTErrWKtry71kBSfiH6oanxW1y+Yu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYBXuNmh; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-56b6c7c8d00so2813894e0c.3
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774818502; x=1775423302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SVkfdJP2KulZKEM0URtofZekmehI6WAdAhgF+udGJlg=;
        b=QYBXuNmhrEM4+ehc8nYYU3k872EhjxsEghzm5IGgtDH8NKV20q/+ZAkEn7XYXzbbQf
         cLPbR7dLcTa1jDRMl0TfNkUY2QhmayEQobOqI1w4gxGKwKZ9Jbv1pHfX8y8vmEJWtJpH
         omKX1lUorfbUd9PUfy95kWLGNBb72sjleNpcUs8AKGOwrIfqFLNhmQZ+IiijnKEPfib+
         wvq7tOpr+Yvh9W8uw3Kk6jiw1uFLSSNJPdGC3/E7eCi1pEzS8bMEP0KLfyTdSGK6m5MN
         QLOhQOV6Lu3zK6QQevbAL3jUHOo20y38HiceWSGWVMYkUrwy69ktmjC4ohTwbi8xYPh2
         9rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774818502; x=1775423302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVkfdJP2KulZKEM0URtofZekmehI6WAdAhgF+udGJlg=;
        b=ilzDQiFmAWq0O9AYdvpXdV7RP7g3cQcxDGDGDhGiS1E3Dtw2l7SJ4JGMkFsZm3qlRc
         DtYicxn0omySAtg3a9xPGStduCVmdJS9V+yGHbtAFvZGiu3pdkMiZ4XvcSMYmUdfFDZ1
         cqIs2g3x5XI7obRe+SeHKgbU4+SG7iYrjeUDWJhSw3VxZMmt67MHB357zrwB4pBkR14x
         OoSr3LGHIE26tGgmmzoA4D5CpH1VI022R0vmjfMeVCF1H9vbAw2EaYgnZp2K2+S1Pyy+
         80gWdh7LVl284LDMO69qXce8jry/c+t4x1S5n9JfOiAD/pqOy8WkagZWIScn5H0XVZF1
         2J+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3kmpDc7S0nC2pTaFkuaurr2NCXieI2WXpHUeXbB9LGkNz82q3TatxnqUKCoF/HB2S0//Ngms=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThLrSf5+lVdKP3HsyGHFXPAFAQUFybmHxhPWT1DXdue5Q//f+
	AqAeWA9gEBeUPdB8P/SCdDEuOgIh7/OYVFqYYnu47oDssUEZCel8NuQA
X-Gm-Gg: ATEYQzxHr9iOj8mNZSh6Ke1bMDaC4onyaPZMzjLhvuQZ0JI+YLFzpXS4iN+xD+ZA3Yb
	CfsF2CkS+I+TO14cj2+16szr+S2ph+rRlULiW9eBECo70L3i6uAPDAqIwgYtS2Duq07txs+Umc1
	UqsBVX2SiL696U+U8/aS5UbYHyCq6m1RRK/OHB803N0CEEi+6VROMjGUKqixD5CYQ0LGsCWCxyS
	NtW01bX802LQj8tYE1X9TFC1+B3kos0Q82vbSnpURpbWmH43VGQLwlSnWapnKLqw29GkbLd/cfO
	uE4+/+IlKISYJoPTUf2GaI56DXOYKRazwxbhigh36FeV4SU4+lIuGOQU8y/Ofm1nbaVT4VDfLPk
	36sbVhS28KYEGfmGWZUSPs1DNdxUjs13tO5tRSv1qZ6XIy9osAGxfXn8Sjh1F2isBxH7wwJs7FN
	O9jwKESGC6hCFHPAewehmE7zDNz+xdM2b+IQ==
X-Received: by 2002:a05:6122:8b1b:b0:56b:815c:961d with SMTP id 71dfb90a1353d-56d4a4d3b83mr4099294e0c.5.1774818502268;
        Sun, 29 Mar 2026 14:08:22 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d77:aa::11:1d6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a46f4dsm6284108e0c.15.2026.03.29.14.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 14:08:21 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: marvin24@gmx.de
Cc: ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>
Subject: [PATCH v2] staging: nvec: validate battery response length before memcpy
Date: Sun, 29 Mar 2026 15:08:00 -0600
Message-ID: <20260329210800.597697-1-sebasjosue84@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.launchpad.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230980-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 580CD3541C4
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


