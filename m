Return-Path: <stable+bounces-245001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OPVB3QJAGq9CAEAu9opvQ
	(envelope-from <stable+bounces-245001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:28:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8596F50288E
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 06:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E2CA305116C
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 04:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C62D1F44;
	Sun, 10 May 2026 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgwLiZiO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3C2BEC2C
	for <stable@vger.kernel.org>; Sun, 10 May 2026 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387158; cv=none; b=FwJid4dpesMDwah7iG2BRPjcZXsI0G4S2rBUMWddZkt0/CMBv7MzwzjXSEHz5W0BoARJZz6TQo1EZO1Dxe82tpjWZ/A1FpZGJbXlO45J06xTF9sX3SG5pPKpKdRWHAqvCVUPztX207zqGVmvRKg40azca2MY7J3Tu2H0TAL+AoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387158; c=relaxed/simple;
	bh=34+fkHSR6l4jKj4YWixRZYYin5/PZ48FReD1pd7ivFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCE3EeQxpAiMaAPbffMvBV7VbUpYbHi3zR3dHTMPxKRCS3r0z7Kc/CziQX+NqsK07bFHagyk3lbVMC8BthcZkfYeKtFwOEqiRr9GciaiPLaYomi238bEaftzBf2gS6ey1PdN3pRTDG1gt29Ud5B8V+J1dEamMSFmGVcmJkYIIDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgwLiZiO; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso1906128eec.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 21:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387155; x=1778991955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byCcm4UvUyAudsPVFuUMkipae/+5ZMC4ds8FS7jEx3I=;
        b=GgwLiZiO8kHYyhZ3YtGu3mlrNhgRyZqsKzi6oy+FvFeIYMboqd2Ld9wEYbOs7oUgQl
         TfDSJYwLurm9pTFfJXu166pzCzlLXDiPbafcQHKuYPCdzGb0jfsGOUu+U0DUlnsX5sX4
         LWBwX2XxFX7+0PxWzJyZ672s0Gevhjh/HozplsDsDeNVZMHwITm6G1TqVbXXZ+zkZ/X1
         UKq7Mgs8OoY9vEYoIR+5aEA6l60rg7vtUey9wOuvVaU2bGDauEKftmKV1xAwBsp1XbMk
         NDTyJGX2TAT+gXv4zTebSv9Q7QMap/C/8pUcneyyz5ZZ1z9r47oBA0YnkeXwh8XprJ+U
         NGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387155; x=1778991955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byCcm4UvUyAudsPVFuUMkipae/+5ZMC4ds8FS7jEx3I=;
        b=qTn67t3LGRRuXVoUofYaJPdU4NaiYRZNcUFChRfRdOpVCVYQw1cP9UJtUTuXrUM+as
         1cJcIZYiMMWEFhAbFsiNAkJmU+BiD+k0O537u9bqXggipyavfC3WiS1mbYfzI+yFzTnI
         jTmJNw/g/Rs8xbzIQCB0ZwkCRtDI2kTYri5CGKHaihDAXPhKH+66C9B87X0Tisiwtspa
         lUyPYI6tEv4Z4JXn7bvPoFQJQBUQckSgw9DZvkmRS6IElwrRj8PVPzch2t823aZHTuk7
         zcy2vpHRfQLPnK9mSTJsgTdN8tlA2AENS1i+FgFry/uSY+UCsOMBsG2zjqh4zYEko62/
         6ebw==
X-Forwarded-Encrypted: i=1; AFNElJ9jLYlj4hHlv9k6+4jHGYmvDwDmrh8ClGeL/2ebmo4Z9LoRVyvX7e4+vZrQaQsCPEM8g1KP248=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFxvRCzN74NBqyvzOmLMT3b5uEe5FSeTvMXcb+j3Nsi/wovK6G
	yi9Y7zhMRB7QO76kkU9N4/6HNx+oWwKjOP+hNRN0avzLHulFR7Bz/7zc
X-Gm-Gg: Acq92OFleh7tiR6oRoGSEDlhrWYJdQWnSndw9TC0GfZhlBuo9IubF+bAMLTR2IPuQEz
	6AVuCacAOXdGoB5OfsiU6ZU/gHnMf0d45mfJktDgQhZRNPon2W4HRH3lpVF6BgOBPJAjQq/Wg7P
	7MKogw3YSwi27Sgp8LEY/pjJ3TdwYkfGKlDbW4qYtqb6SADI6u1RiBi0i5ocORO7aEROgxfXc8/
	5jjvaiWEwoyUJj3/bh+/pQiR8d+UVqkAkgG0KpHIgntv0lb/7bInf6COGxGuXgICC22jG06+Tuh
	WV6Y79t6r4sdehydhIYemRIL1/yHj7cibOHRCs8o9JlOdgevX2iyQb1RP7s0b8pOuG0lU4a403R
	ETG7sAAvc906edTpaBKj4658A0+GH83c6f+2TZi0ePs0TENvKCJBGSTyDlV8+hH4H6jnblO+Gx4
	ZZ8BkHpIO1vA18MQZV9Lk0aiJn6DP4BTGnmG+W4uqJ+cv2NOJpAgPvQzKJnQ5H6fSyl9vuAda7n
	1VD
X-Received: by 2002:a05:7301:19a4:b0:2ed:a58c:942 with SMTP id 5a478bee46e88-2f6e28f9a48mr5723905eec.8.1778387155325;
        Sat, 09 May 2026 21:25:55 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm10069960eec.10.2026.05.09.21.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:25:55 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	Armin Wolf <W_Armin@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Rong Zhang <i@rong.moe>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	marshall@shzj.cc,
	hyacinth@shzj.cc,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v12 07/16] platform/x86: lenovo-wmi-helpers: Move gamezone enums to wmi-helpers
Date: Sun, 10 May 2026 04:25:37 +0000
Message-ID: <20260510042546.436874-8-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510042546.436874-1-derekjohn.clark@gmail.com>
References: <20260510042546.436874-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8596F50288E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245001-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rong.moe:email,squebb.ca:email]
X-Rspamd-Action: no action

In a later patch in the series the thermal mode enum will be accessed
across three separate drivers (wmi-capdata, wmi-gamezonem and wmi-other).
An additional patch in the series will also add a function prototype that
needs to reference this enum in wmi-helpers.h. To avoid having all these
drivers begin to import each others headers, and to avoid declaring an
opaque enum to hande the second case, move the thermal mode enum to
helpers where it can be safely accessed by everything that needs it from
a single import.

While at it, since the gamezone_events_type enum is the only remaining
item in the header, move that as well and remove the gamezone header
entirely.

Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
v12:
  - Drop fixes tag in formatting only patch.
  - Fix typo in commit message.
v11:
  - Move to earlier in the series as later patches depend on it.
---
 drivers/platform/x86/lenovo/wmi-events.c   |  2 +-
 drivers/platform/x86/lenovo/wmi-gamezone.c |  1 -
 drivers/platform/x86/lenovo/wmi-gamezone.h | 20 --------------------
 drivers/platform/x86/lenovo/wmi-helpers.h  | 13 +++++++++++++
 drivers/platform/x86/lenovo/wmi-other.c    |  1 -
 5 files changed, 14 insertions(+), 23 deletions(-)
 delete mode 100644 drivers/platform/x86/lenovo/wmi-gamezone.h

diff --git a/drivers/platform/x86/lenovo/wmi-events.c b/drivers/platform/x86/lenovo/wmi-events.c
index 0994cd7dd504..9e9f2e82e04d 100644
--- a/drivers/platform/x86/lenovo/wmi-events.c
+++ b/drivers/platform/x86/lenovo/wmi-events.c
@@ -17,7 +17,7 @@
 #include <linux/wmi.h>
 
 #include "wmi-events.h"
-#include "wmi-gamezone.h"
+#include "wmi-helpers.h"
 
 #define THERMAL_MODE_EVENT_GUID "D320289E-8FEA-41E0-86F9-911D83151B5F"
 
diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index a91089694727..5a8f4aee02cf 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -21,7 +21,6 @@
 #include <linux/wmi.h>
 
 #include "wmi-events.h"
-#include "wmi-gamezone.h"
 #include "wmi-helpers.h"
 
 #define LENOVO_GAMEZONE_GUID "887B54E3-DDDC-4B2C-8B88-68A26A8835D0"
diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.h b/drivers/platform/x86/lenovo/wmi-gamezone.h
deleted file mode 100644
index 6b163a5eeb95..000000000000
--- a/drivers/platform/x86/lenovo/wmi-gamezone.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-
-/* Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com> */
-
-#ifndef _LENOVO_WMI_GAMEZONE_H_
-#define _LENOVO_WMI_GAMEZONE_H_
-
-enum gamezone_events_type {
-	LWMI_GZ_GET_THERMAL_MODE = 1,
-};
-
-enum thermal_mode {
-	LWMI_GZ_THERMAL_MODE_QUIET =	   0x01,
-	LWMI_GZ_THERMAL_MODE_BALANCED =	   0x02,
-	LWMI_GZ_THERMAL_MODE_PERFORMANCE = 0x03,
-	LWMI_GZ_THERMAL_MODE_EXTREME =	   0xE0, /* Ver 6+ */
-	LWMI_GZ_THERMAL_MODE_CUSTOM =	   0xFF,
-};
-
-#endif /* !_LENOVO_WMI_GAMEZONE_H_ */
diff --git a/drivers/platform/x86/lenovo/wmi-helpers.h b/drivers/platform/x86/lenovo/wmi-helpers.h
index 651a039228ed..ed7db3ebba6c 100644
--- a/drivers/platform/x86/lenovo/wmi-helpers.h
+++ b/drivers/platform/x86/lenovo/wmi-helpers.h
@@ -16,6 +16,19 @@ struct wmi_method_args_32 {
 	u32 arg1;
 };
 
+enum lwmi_event_type {
+	LWMI_GZ_GET_THERMAL_MODE = 0x01,
+};
+
+enum thermal_mode {
+	LWMI_GZ_THERMAL_MODE_NONE =	   0x00,
+	LWMI_GZ_THERMAL_MODE_QUIET =	   0x01,
+	LWMI_GZ_THERMAL_MODE_BALANCED =	   0x02,
+	LWMI_GZ_THERMAL_MODE_PERFORMANCE = 0x03,
+	LWMI_GZ_THERMAL_MODE_EXTREME =	   0xE0, /* Ver 6+ */
+	LWMI_GZ_THERMAL_MODE_CUSTOM =	   0xFF,
+};
+
 int lwmi_dev_evaluate_int(struct wmi_device *wdev, u8 instance, u32 method_id,
 			  unsigned char *buf, size_t size, u32 *retval);
 
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index f63e568a4e12..b4ed7af50a24 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -46,7 +46,6 @@
 
 #include "wmi-capdata.h"
 #include "wmi-events.h"
-#include "wmi-gamezone.h"
 #include "wmi-helpers.h"
 #include "../firmware_attributes_class.h"
 
-- 
2.53.0


