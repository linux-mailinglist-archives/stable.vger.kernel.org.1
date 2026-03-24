Return-Path: <stable+bounces-230107-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE+NHAhpwmlScwQAu9opvQ
	(envelope-from <stable+bounces-230107-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:35:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6743306811
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F58309A082
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257F38654A;
	Tue, 24 Mar 2026 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NWkxjUCx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB53E3DBA
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348223; cv=none; b=AZAlc3J4LBt1GTEhNZ7aQcT6r0Y/IeMaX/4G0yGz/ILbzv/Hm8OqNpYhv0VDHqxOP8zlSUzshDFUHYACB2WeZvAB9bYc76fo5k/iJV2nfxaSXNO352QYZ+Nr4wcxgXVTEoXmvy4hqJegZ7KwnSJLGUMB9W9ozqO5GgWPSwWmB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348223; c=relaxed/simple;
	bh=qmvn95qLYi5zD/L9ziLnVeERZqUjiU0m9oMXTSssOxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0Ks2l01hXdhfmSy73JYe8W5/wlrwm/Defs3MLr7pb0nXvy1DJsXp45nuePGiUwuIAd0cWrEIuK31Gbj8r5NnEqtDa6mq6q0HWdEcGBcLX0uLfkvpPeiSeZjPDbiwYSA7aTWPubToMTwWYZSpG6fc1hGi3QUZ+ZVdOh91l6678c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NWkxjUCx; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6676d55d01dso5367466a12.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774348218; x=1774953018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ5B9EsEVAtAKUbh3SIdMjXFUTqdrORMXqDWfN2cV3k=;
        b=NWkxjUCxEo0Wp6N8/JGTSoR2kVyB1LwvkSIk8He9g/jMAcwLAflHid8S8nqaqVyhFz
         6kPQsb1JZUmAEHeZEuUQLoAy7J8n1+Dq/IXLBzg4jKESSpWhKsmTyDCVyg2SA7/HCnRk
         MauLX6OyZjJKTVX295BWIzSUIuYnR4BHGffSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774348218; x=1774953018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJ5B9EsEVAtAKUbh3SIdMjXFUTqdrORMXqDWfN2cV3k=;
        b=iASOnq9Xx5b8S5/yocKzHcGNEOTBSaW5hkq44ejpbKzyGZ+VrrCtyKzy0r3OjNLNMd
         4bhosYZhNKZvEu3LYqSapVBwk1h6WowdbMns1s5G65D1/MjDkC/KriCOeIIHh1IwQz5V
         7xhNH9Sd8EBqmetl2FTbvvU+1LPkZxLCqYaTUxP2IkiqHbfr9czUuUNsQDGec/ohxXOr
         xGYFYIfXPDRjVQpzt3d2xJJd/hyRzFa2IqBDDIOmz/ROmp6yUDukywPtrtqELbDB1yNx
         5bkxZcIjRdB2DcyoSIZHpzz13troBu78B0hw63oHNTmO9BGubN18DgaYE43dGuzti8q2
         MqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCrEPJGRmNy9zBJI6MouCwO/Y9HM5WSseJyZzYpbxOCO0c9gPwYXZpWZpciKyjLgfYxYjA/fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVMYxSw3LjCcu8tYjZnMgJu4ly+iPk5sU3zayxJoX3W8yrI80
	dLLdOSjBp26GEtjn+aMHbXiBWr+fjYjq9g+MBWoRclvHakdGebOGD9hf1OJAl7w/dGENTaSZB6M
	uo6q9Eg==
X-Gm-Gg: ATEYQzxgRuHWwU315YesPPKQO1Kv+dZS4rzuZlYoUO9vIZS92xiBAHd6XpQJUAgU0cF
	86erw0nzGDD8tg1exYmQZWn/czEl6Zo5Ze93Wf4w70w0j3fy9bAyoFfWBHhSns1Z5GFF06lCPvn
	YmJjiCxF+WzfJ6jvBFS2zuPObE6++FBmbeSTHrLAqMJxKJMvjIva4qZfg3W1Xa7Eb+/oLjTsZJ7
	iErumC61RxZcKnQNZwhTHVNMv9/EiizEwgPxe7JTAdwrpOmQMQFKiXxv87VF+dbRVgMIPCItpJt
	/aoKzMyY9CcIeGh7fFOuWT+dnLV9UkFtP34zf9kzesch7f1futgnYsI1n6amU1dolr2VN44/kSP
	pnLn187hE0o8GjaIBSai3RdJEE8YNQqIcSAAekMqVXjDNGc+fgcCTdfBvruxWHCS7jPGV+KT7WT
	SQVEsFC8NrJNoaq0Q7jOO4LKEW32CisWa9Zf2wEHKVng+L8FROdCXwoxg6CzA0t3JRIDgJ3NFgS
	lS+WJa4Ks2uIVZMo6taiAw=
X-Received: by 2002:a17:906:b74d:b0:b96:f329:e66 with SMTP id a640c23a62f3a-b982f39b31dmr905699266b.51.1774348218439;
        Tue, 24 Mar 2026 03:30:18 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (218.127.147.34.bc.googleusercontent.com. [34.147.127.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98416ac27asm496819666b.59.2026.03.24.03.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 03:30:17 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrei Kuchynski <akuchynski@chromium.org>,
	stable@vger.kernel.org,
	Madhu M <madhu.m@intel.corp-partner.google.com>
Subject: [PATCH v2] usb: typec: thunderbolt: Set enter_vdo during initialization
Date: Tue, 24 Mar 2026 10:30:12 +0000
Message-ID: <20260324103012.1417616-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230107-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akuchynski@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,chromium.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6743306811
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the current implementation, if a cable's alternate mode enter operation
is not supported, the tbt->plug[TYPEC_PLUG_SOP_P] pointer is cleared by the
time tbt_enter_mode() is called. This prevents the driver from identifying
the cable's VDO.

As a result, the Thunderbolt connection falls back to the default
TBT_CABLE_USB3_PASSIVE speed, even if the cable supports higher speeds.
To ensure the correct VDO value is used during mode entry, calculate and
store the enter_vdo earlier during the initialization phase in tbt_ready().

Cc: stable@vger.kernel.org
Fixes: 100e25738659 ("usb: typec: Add driver for Thunderbolt 3 Alternate Mode")
Tested-by: Madhu M <madhu.m@intel.corp-partner.google.com>
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in V2:
- Marked as a Fix

 drivers/usb/typec/altmodes/thunderbolt.c | 44 ++++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
index c4c5da6154da9..32250b94262a9 100644
--- a/drivers/usb/typec/altmodes/thunderbolt.c
+++ b/drivers/usb/typec/altmodes/thunderbolt.c
@@ -39,28 +39,7 @@ static bool tbt_ready(struct typec_altmode *alt);
 
 static int tbt_enter_mode(struct tbt_altmode *tbt)
 {
-	struct typec_altmode *plug = tbt->plug[TYPEC_PLUG_SOP_P];
-	u32 vdo;
-
-	vdo = tbt->alt->vdo & (TBT_VENDOR_SPECIFIC_B0 | TBT_VENDOR_SPECIFIC_B1);
-	vdo |= tbt->alt->vdo & TBT_INTEL_SPECIFIC_B0;
-	vdo |= TBT_MODE;
-
-	if (plug) {
-		if (typec_cable_is_active(tbt->cable))
-			vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
-
-		vdo |= TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_SPEED(plug->vdo));
-		vdo |= plug->vdo & TBT_CABLE_ROUNDED;
-		vdo |= plug->vdo & TBT_CABLE_OPTICAL;
-		vdo |= plug->vdo & TBT_CABLE_RETIMER;
-		vdo |= plug->vdo & TBT_CABLE_LINK_TRAINING;
-	} else {
-		vdo |= TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_USB3_PASSIVE);
-	}
-
-	tbt->enter_vdo = vdo;
-	return typec_altmode_enter(tbt->alt, &vdo);
+	return typec_altmode_enter(tbt->alt, &tbt->enter_vdo);
 }
 
 static void tbt_altmode_work(struct work_struct *work)
@@ -337,6 +316,7 @@ static bool tbt_ready(struct typec_altmode *alt)
 {
 	struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
 	struct typec_altmode *plug;
+	u32 vdo;
 
 	if (tbt->cable)
 		return true;
@@ -364,6 +344,26 @@ static bool tbt_ready(struct typec_altmode *alt)
 		tbt->plug[i] = plug;
 	}
 
+	vdo = tbt->alt->vdo & (TBT_VENDOR_SPECIFIC_B0 | TBT_VENDOR_SPECIFIC_B1);
+	vdo |= tbt->alt->vdo & TBT_INTEL_SPECIFIC_B0;
+	vdo |= TBT_MODE;
+	plug = tbt->plug[TYPEC_PLUG_SOP_P];
+
+	if (plug) {
+		if (typec_cable_is_active(tbt->cable))
+			vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
+
+		vdo |= TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_SPEED(plug->vdo));
+		vdo |= plug->vdo & TBT_CABLE_ROUNDED;
+		vdo |= plug->vdo & TBT_CABLE_OPTICAL;
+		vdo |= plug->vdo & TBT_CABLE_RETIMER;
+		vdo |= plug->vdo & TBT_CABLE_LINK_TRAINING;
+	} else {
+		vdo |= TBT_ENTER_MODE_CABLE_SPEED(TBT_CABLE_USB3_PASSIVE);
+	}
+
+	tbt->enter_vdo = vdo;
+
 	return true;
 }
 
-- 
2.53.0.983.g0bb29b3bc5-goog


