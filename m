Return-Path: <stable+bounces-244622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGToKaDU/GlvUQAAu9opvQ
	(envelope-from <stable+bounces-244622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:06:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D664ED2DC
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 20:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AD5E30230CF
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 18:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7E3478E3A;
	Thu,  7 May 2026 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruNj0tlZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C264779B2
	for <stable@vger.kernel.org>; Thu,  7 May 2026 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778177129; cv=none; b=qub3kuHsGbXthKWhI2XAvKQ5d0dYwFx9jB/K6Ct5veAZF784QprdT9h0aHKaYY4PzHdgeV6cArPZ4hz2+NaZuvZMFJL9/JsK+WNKeSFxFkfyFcColN738YRH+1d2C0alH060osZORyYOuKiJj1HB2bE5SSIl8tFadYQRMCdwi2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778177129; c=relaxed/simple;
	bh=Piaa7AgWZQklS9FETl7ZC9C5QDxdRu2MXtjVntyVsJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUNs01c/Cu+yKbF/tjXpJUlZ7VNqDA8ZxPwkj3oVMdqZz+eodD2oTP0+Rxy40ObuZb3y+XzlTUVYc2zd00c0RV3eqGh+4q7AeJK2DUgN7nVcA6eCAE0hq3MIALaAbT3FquphQfC1puZO4jEMaQprn63V+TD8M53eNfxJIt3mLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ruNj0tlZ; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so2975315eec.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778177127; x=1778781927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CfDVFKSoZ/AeItTPx6z7QgTeQ9+ypXUzFJnVp37pF4=;
        b=ruNj0tlZ9ixQ8jTD8keFxHilDPQ1WMsX1era9ig8L/PKUzC7WtEPBx/bbxVsCYMfqZ
         2PtSdBuJaHXT8a81EFqJMtfruWKdGuq92zcF+fyPFI8mRPw7zlci5lznd6JWSRejnKNB
         ZBF8T1F5PqBl44vntEHvpsBR53H0gRuj3wWEnikyKy/Uwl8wKuqbkIVDGqgZCY00Nzan
         S/VixM5WUVpMNGAjc6VIMy+sIVDGgasa0uzkgb7xJLV3dAo/Ch5WYaYj6i0K1P2V6n+0
         VKElKZe3q8u3CWxiiCiJ2Z7SVfcPgs7EG6rOfbS6iIgiH2OwUTQXwVYrP57LEq4h9dcT
         iKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778177127; x=1778781927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CfDVFKSoZ/AeItTPx6z7QgTeQ9+ypXUzFJnVp37pF4=;
        b=Jj8uH/qtIZFGq6dYUP21kRRdAVFnDUkI9zBlZlY2uEjjSQaIXvRZzUKQO1GJhJgU+i
         QQKjNaYnMwmpjS/1WKh3laRxj7O2b7q0zqSSHyds5dzACH/TbnTtkYFbo1+l+8IivQtw
         xCtpdCbnJanbRtSh8lwYY0h9nmhW+2NEf7sWCTGNNTUtixgzR0pz4YZ9YEeMIl9z8fG1
         1ETzeK84xH+TYGSHzhT2JgMlq6ggiOSD0pCBuhITXiUpPhH5pW8O25OGfEptTKOCFhMU
         kk/cwHNSbOBQ0gNSz8hiBs8ak56gB7U6odJWbA0b1aWZ32gUkrr0w+yt6oSG9K7fEfNY
         Y6KA==
X-Forwarded-Encrypted: i=1; AFNElJ/BidRLAAOi4ZPc1oz8pNAOxNReYXb5qOUvsdzkekXHLaHERsQg3GVyo/gtmR2ACd7dGKQP4E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4calJu+nMBZoJLZkkBuIQZ+8VAlKPiJtNwyzr0ismoWMDo49
	fYoYPjKmocNDsbd29q2DMIWbalg7adNmgee8TY0tlQhHmpTdZmxK1ToG
X-Gm-Gg: Acq92OFKoUqlmYHeOb8Sfqq0yhp+/FgpauoAh4qOldf0cruXeebZR6WPrkcqfjyC6Md
	Y7PqIHImYkA7bBBZLVPDBGdQKHRD+qdJxV5xiv6lm7iKBVFYVK3xBAzMhgFzkJlrudJ3XY6O4Y4
	mHBAoCdR2Se2ta1Kz47hRBB8za2X3/dsOFjyDECBFsD3hg9uipCxn9N2Kh55aVuZNMUfmsf1+87
	jlatTktJEKHMFwsp0iETgpIR65Fobv7evsxpeh++HBj0prS6in0frB6J1czq0RgjsPQ4/JIMpuh
	0QtChxJo0+fYvrAWEzaNcxb9mrBcZoOpSukONFyIkxZwI9393VRGdIM2AZh8yx8ktV5AYO1Mw3s
	BGgz+6G9pJ+8/1Pv0Km+c5zEVytWcjFQ2iJXZ+91K/jIgZchKG5n50yccA5SsRSIG5TARSZ+42a
	4ko2WUmM8BoMOMdxpZ1h048z7RRIqMtEfPLTmWYfLrZp7eDKb3Aqk8WqQfaaxjWGnp8ddGhHTdA
	ha8
X-Received: by 2002:a05:7300:570d:b0:2f1:fbbb:e321 with SMTP id 5a478bee46e88-2f548a99568mr5243996eec.6.1778177127092;
        Thu, 07 May 2026 11:05:27 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f82bd73a64sm44332eec.12.2026.05.07.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 11:05:26 -0700 (PDT)
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
Subject: [PATCH v11 07/15] platform/x86: lenovo-wmi-helpers: Move gamezone enums to wmi-helpers
Date: Thu,  7 May 2026 18:04:59 +0000
Message-ID: <20260507180507.912966-8-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507180507.912966-1-derekjohn.clark@gmail.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 61D664ED2DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244622-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[squebb.ca:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rong.moe:email]
X-Rspamd-Action: no action

In a later patch in the series the thermal mode enum will be accessed
across three separate drivers (wmi-capdata, wmi-gamezonem and wmi-other).
An additional patch in the series will also add a function protoype that
needs to reference this enum in wmi-helpers.h. To avoid having all these
drivers begin to import each others headers, and to avoid declaring an
opaque enum to hande the second case, move the thermal mode enum to
helpers where it can be safely accessed by everything that needs it from
a single import.

While at it, since the gamezone_events_type enum is the only remaining
item in the header, move that as well and remove the gamezone header
entirely.

Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")
Cc: stable@vger.kernel.org
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
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


