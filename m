Return-Path: <stable+bounces-231212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIDrBf9yymnG8gUAu9opvQ
	(envelope-from <stable+bounces-231212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:56:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDE635B602
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BE3A305E805
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DF43D1706;
	Mon, 30 Mar 2026 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ20CY/V"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D73D1719
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875139; cv=none; b=ttjou1XkiayK60JuYTiRmGSqktvVE780+1pDIfimd2q0nD0GH+TxlTWXJ+pDqqIUR8k1xvq6qaTom7iG1gmiLZqQ7wCnExIqoBTWByE8ssjTV26aUXckoSv+pwm1a/DbOTf4nPUuFn5gYhjwcseG1J3ZJprGfgrTuXnPiG+RUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875139; c=relaxed/simple;
	bh=X0XeqVk1okPDExPdxveHKfJoDl26uOIaeLMRZyIoG0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hA2CddFRCTDz6ARhiRa0C9qs+uMxh90842FhKng+MQpDIu8rlIAsBp8UVvIHz48nVrcvZrxJst6oyjgX8NOe44o0Nut/RRIi7wNPkTKDiH9hdME/42R7ZkpWPtK0YYEnTkElDb+Rt9Fvpwn8FlCGa5uPniTaZ0Us4HVf/2UDcw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJ20CY/V; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-604fc147b7cso990388137.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774875137; x=1775479937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2T5sC1X4d4lvAdzHYW3GejS6hGTQduK0sRiN708dk4s=;
        b=QJ20CY/VupWwefOFzUflZGWD7YDVGN0rsW0a6JkR5HOAnCeXOqlbx7Ia7qZ42J5OiY
         z7FaZ/ZiDUAM53+CIjxKEprQlT0U9VocUzppHlBHyE7D9k9YcuuZuIixL2DKow9uzt7n
         rrG6lHOq7osTr3ITC4ORahVEVInVkn4+INIih0Sk/z0juCRmpU1Hjd5dE/IpR9hcFNDr
         fDaPVsCCqkyPLpLaR9320C0BATVMLpVCLfKONUANa8oWNz65GOp6/f8cjCCZhRlxKnAn
         f2bMgmA139VLFAeU5WqpiVJSltC1VKcM3n7WMxi8jdySXOOG5E+BA34XUEIjrnkAkrOO
         lZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875137; x=1775479937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T5sC1X4d4lvAdzHYW3GejS6hGTQduK0sRiN708dk4s=;
        b=RwukosXirMHcAL/lQlIU3dm/2t4i/OGQFcJhrLak3kckUZUckTeuqyR60UK0+yrSjJ
         0oFlRZYr42whwdOsxrzLvRnW+oeCUpp4+vqIQjP4xDWQEW7QOHuVJpGbqB29Uov2Bmdi
         aRsxixrj3htxYBlyIiXFeG+H9iT0TOpvVOegF9LmYu3eI/TZhERFLtRQ0DiF04c8Q3ag
         X7jUycGpFhx9hf2uilr8OO2xILeOeLahNu8WMK1ccvx7uXLveJAljefQyuBRL3Ot9XrM
         a3ygf4viJOJwNkxrq/PY+18ZfYT2lE1zd/l0ZUm0tkr8Am3fnxcsvaFHjZi93q7IibFS
         g9pQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+FIO/Dh5h7ANL8JkP5JP58JXP0zFPRBJgYAORVS/TKcbSu1P8BhQlZ7PnLGDsocHPnX8e0RA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdpiWk50KJdK6JgLXySPGZJxzT6GZB3lKKgu1TTNvcXgvR1Kle
	hi+c1QWVFxJhKRY3kdYVmAdI9qUScD56dseT6CB9RejJi7OFdGixT7b4
X-Gm-Gg: ATEYQzzNLC1w8dqsYEOLSaIGZ4NeObqM/WuG9t/vNxqhkCEveCMm9o1Y+TDeN0rFKfl
	cwgmyL9S504w4G2S0hYSlQKAiIgckjzC7WEOm6fTBQ5tKHvtyu3iSi52eIL7+MDJ5xuV+/7dV6j
	4kn57sczS4cpvkqly3czjrkJ0MAEmaltqQA7Jbd1/z0xrWQca7Nr//xthwxuevxA+lkQMqUhWep
	sLX+FyEdTbu0/leAOTuHsYr66VKIFp3LM4c65mdlAmJCnRxz/6HT9z95cipxOt6EtmdIc7nAQYo
	HZrIB3qrpVCzKJrXpWGRydV1D8vHO5wsuARKC7xukR8SADkikNGUrY4rfUWsiLYZV1qgIe841D5
	w+xAD5fpIMbObt9eDs/kFfStDNWyk9IVI8LOfyJzBqa5rk9GFBpC0qI8h3FUKTFJ4PBs87dgxRW
	LfUppL2AAia1C4wATdwjdDLFBV
X-Received: by 2002:a05:6102:26d5:b0:602:87b9:89ba with SMTP id ada2fe7eead31-604f925ae38mr3523377137.19.1774875136516;
        Mon, 30 Mar 2026 05:52:16 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac6:d6da:aa::11:1d6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9539e4420d9sm6888389241.8.2026.03.30.05.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 05:52:15 -0700 (PDT)
From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
To: gregkh@linuxfoundation.org
Cc: marvin24@gmx.de,
	linux-staging@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Sebasti=C3=A1n=20Alba=20Vives?= <sebasjosue84@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] staging: nvec: validate battery response length before memcpy
Date: Mon, 30 Mar 2026 06:52:00 -0600
Message-ID: <20260330125200.820693-1-sebasjosue84@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,lists.linux.dev,vger.kernel.org,gmail.com,intel.com];
	TAGGED_FROM(0.00)[bounces-231212-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 7EDE635B602
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603301722.axpoITcy-lkp@intel.com/
Tested-by: Marc Dietrich <marvin24@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sebastián Alba Vives <sebasjosue84@gmail.com>
---
v3:
  - Fix build error: add missing closing brace for TYPE case
    compound statement (kernel test robot)
v2:
  - Introduce NVEC_BAT_STRING_SIZE constant (Marc Dietrich)
  - Store res->length - 2 in local copy_len variable (Marc Dietrich)
  - Use NVEC_BAT_STRING_SIZE in strncmp call for consistency
 drivers/staging/nvec/nvec_power.c | 42 +++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nvec_power.c
index 2faab9fde..30719e142 100644
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
@@ -192,26 +193,41 @@ static int nvec_power_bat_notifier(struct notifier_block *nb,
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
 		break;
+	}
 	default:
 		return NOTIFY_STOP;
 	}
-- 
2.43.0


