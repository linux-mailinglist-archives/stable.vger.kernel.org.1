Return-Path: <stable+bounces-271820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l0e3DpbZR2oegQAAu9opvQ
	(envelope-from <stable+bounces-271820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 17:47:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE5703FD2
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 17:47:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ru91m2IR;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271820-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271820-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30D0C3033508
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839E52C21D8;
	Fri,  3 Jul 2026 15:46:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D30282F3F
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:45:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093560; cv=none; b=HgJ7m6DprBSq/tIIiUTtlzgionYMvrP+9qE8tD9GQEJkdhgEXx3ARZQtfxlrrmSGRrmvh2KauZJjOazPGiQ4p+C7hAoRKU2R96cfRfwFRPbt6Jee5os1RN0+q1d0RqAN9UHpewHD2FAKzSTYDC5puZes+Abuopza9hniVkdZ4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093560; c=relaxed/simple;
	bh=0eHW1w2sw8/QGjlmZcCx6sq7hihGPmbxeRNEM8aLoWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXYYJQCoSquyzFhUDXA6+i8hlkMQxE/YMi1hvjNc7ISCTbHdphPPNur1tdr4tHdyXZTn7iFTXSAR4C8RFG/+H1xbApt+Ir+SMgdHKt+XxAH4W+9wawypox33lsdrReirTmK8ktQRZYKRR9U7CgBatYRtba53iEUX2jCIaVN4KVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ru91m2IR; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b8d99342so187855e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783093557; x=1783698357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z0Bc1ZmeOfqEtZgb3lF6zr0iTIVchQGs3e/FsoiNOcI=;
        b=ru91m2IRhGkOxm5BcF56WiepPZbH6mtnBpaLvKhD48dS9L6+KbC/EknwwI20WDeO5J
         ahA9KVe2VFhImKyZ+8sGsp9CSD8icHKUfWT56FLz2Zdi2tRka+L326C47zcP2PPz33mb
         jFHfyXcsvQXEeTwZP+WPGA4xrkHqwYBEBFAAwRJKt8uu5bVuIS96h9vNfOe74yhKKKUv
         FlP5f0//mFsuuDf4KJUL1bcTUX6suPbFbctLMhw2ZlzfmMDBuuZmxrseb93ks4fDJd3B
         7S984HxtgzRoUoilaqWtoeV986yW7J1/IiT5P+XAJ4dy1VHhkhgTK3sSKUmpKDDsmcmJ
         nhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093557; x=1783698357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0Bc1ZmeOfqEtZgb3lF6zr0iTIVchQGs3e/FsoiNOcI=;
        b=qlM9QcMjTOA2uB3ghbG/KrvdhiR1MWtTOcW05kUFxkIfIIxJUPc76RtESitbkkw2N8
         jM8RJTo1V6Judmn2Rub2PgnV94Thl52eRe9u/04ErfJBG4DT1cdZNnK7VAtCjyJK25S/
         0u89kTFrVa6ln7GpCngRoHN4gZUFPsWQnrjBcKQ9M4fRTP23Gv7ZXVfXan5gj5tdpYC2
         H9NBmNB/VoqyRfzwZMnVqVvtmKg7INKCwgxmzeDaacPROX0eNTOZKJCopVHwqGHk4no2
         RnFuJBYh6t7a7f6WQ6F1kaE8KsTl+oC7ijkuls6xjOxBsvwfLyVqG0+yrgSu83wxD/jM
         LVug==
X-Forwarded-Encrypted: i=1; AFNElJ+qgsu2pH6olUFputymSBuWKmvDXNuzQVOztQoQsSu78xHbEPcPkuNeS16ODxdgmPpWSPRpZSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAmmouJtkLRkt7T6n3Oss08wk4fwgILhQLojo8ZPEH2bPaYM7H
	OpuZYTRo9A2tHhLQHN6hE1LhXtEotNUNH0Rkh8iMj7TAwmKOaSm3E9/sXvmrH57cGw==
X-Gm-Gg: AfdE7cncUsPqjZWdeLRHqv/r08j+PscGEc6ZW8tPC+k6msRugmFtZVdChQAELPgw99z
	L20CF1wM+E336z3DlckiKrQoNLK0rZ+3/dZ2rj7fF8WAtpOm5OLEin9jSF3naIavzpo6/Esx53V
	hz4AUjiO+yXxAy6m8doiXUOUeMMHav+gmMPaxlkSXl4LK0Y2jvTiPnCeTbyM2gzEzS6a601qjNK
	5RMAYAL9QAqM3Cy1DFCyKes1hnMLfhuw4DnFaT6BWM+uS6JEv7eVqqYS9SvA9rfTLsGlLWq/IOa
	cEG2KIzHAzaVyfAO22JAtSI8H3DHeGa+WpLJrBTAwZ4XCpeeC9rzTlg+4fuursnMjxH+JQxtwGf
	ep2IFBoArhRz9377aII2JgUmkEdBwu6EMIWBXohnv7pZ7Gn5pRBJKl9CP5GcQ87YcoXUDBl4e6z
	Lo2jHJpUc7LRXxn4fhFsE7a6ny8Ztex/tYurGVtcl4YGZqs1AWmXxXd96Kr1ZIu8KBWBRMhOU=
X-Received: by 2002:a7b:cb93:0:b0:490:b2ae:44e1 with SMTP id 5b1f17b1804b1-493d10297camr51985e9.5.1783093556676;
        Fri, 03 Jul 2026 08:45:56 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bc21sm227111205e9.7.2026.07.03.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:45:56 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:45:52 +0200
Subject: [PATCH v2 1/3] HID: asus: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v2-1-c5ed7bc94772@google.com>
References: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
In-Reply-To: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783093554; l=1171;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=0eHW1w2sw8/QGjlmZcCx6sq7hihGPmbxeRNEM8aLoWY=;
 b=JrTtpyE5L5uoy3JxJ2tMU5gceaV3QRRv3ixIM8KEQnx4O1fJ0ZGTknzPYnp4Tlo6HiMPKmP40
 opA98pft3h0CTw3Aev/nQ+xb34+mH8F/eSjuF9fugqAUv0PuoYMabt3
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271820-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jikos@kernel.org,m:bentiss@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:mario.limonciello@amd.com,m:luke@ljones.dev,m:limiao@kylinos.cn,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jannh@google.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3CE5703FD2

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: 00e005c952f7 ("hid-asus: check ROG Ally MCU version and warn")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..befa990b3210 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,

-- 
2.55.0.rc0.799.gd6f94ed593-goog


