Return-Path: <stable+bounces-249453-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AljJ87ZC2p8PQUAu9opvQ
	(envelope-from <stable+bounces-249453-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:32:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E19576D5E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9908D3016EE3
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E709129B795;
	Tue, 19 May 2026 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwXdAX75"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A92673AA
	for <stable@vger.kernel.org>; Tue, 19 May 2026 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161544; cv=none; b=aWcyxkTYXxukO+ok1C+fkM7yY5b2iTCGDJSTaUTFSLpH46vc9JhTIlUOS9ePA6HOc2jZLKQVt5cFbK+Z5xMWaLxe3bh21na7r+8WTypOc7LtrCfH4rO14i++p5nE7TYzVc6170/tUxsDUca9785ly0KFjELnJtzmadU1ttj6HeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161544; c=relaxed/simple;
	bh=05iD/qAS6Hmb35Jwib5lGI7jVOda2cbtoKdufYvK23s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oAkSD2/KjNJ61/koX8fjxF9Kt11YJ03q0JnuaEjWh/5KMLhw+zmiM1A8P+9A5P9lvACAaGS1//AXvDz7nvi28V0oTdXQL+tYyDj9jHhzOxq4m5X9qgZ0+tIAUpk2/anfi+qfFq171uhQ2AALtmiNlvuUbBdr6Ox+OFIw/v2Ilo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwXdAX75; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-135200bc7d2so8377399c88.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 20:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779161542; x=1779766342; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KEhW2cv9pHxt/OV2GG0kUIG9UFFZnsrejYMLQtjg+Z0=;
        b=cwXdAX75PkFoBwGahK/R6PqLYrAGEa2JfncP2DonvPyYqEaSF3Vir4RqXGXMQBokHg
         ILFUklrXDNIw0yobRop9L7FixjBOTdtqme5joUirGfHtUQD3cBYpa/WAJT5eliF9AED2
         TsfWjYXC0zR6k+wWPEWPxdCrzL9itauLZPMTeHFeCTSEk7Fb7TzfG/Ct4qjlS+ff4K2r
         hvkkbqeKrlqcCpgy5v+WLX1C2xfbmYIoqSNVuX16jzlVhlg/xZFZ6086cPcsGosaoZ05
         pehVaLsm6KiLMjm0sRXRrGhZtV50T8KhekByKj/ts0iLPYNsKilF4X1E06vbEsk4NAQp
         N0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779161542; x=1779766342;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEhW2cv9pHxt/OV2GG0kUIG9UFFZnsrejYMLQtjg+Z0=;
        b=MxURFVizaOiRYklPmjTrnB8JrwG5hNsIRNUf6JTsNAM2uxcLsdLZSyO99t8fombFMu
         Nok1DyKGoTOM9fnY2LSSVzSEeDlquPKjSPt46w4Q7fosr43krVJUFGU8jZo7P8lbsI/i
         FxrJe93Tn5ZiJHWMYe7IGqEa5pIzkcyMj0VbMhyAlb86WCTe2C+R1vHmtbes3XYYZmP3
         EV8ai19pmIpcQ7eJbX8cfsqZZYxVNVdpU2xTW3pBtFXVwdBcHG3eE/vZxUcU2hkegA3H
         YXDnRfOClV5n67FGa5KOn6FnG1qwTcYJVW2UsG02Z2nCLCjCzsbU4SEJL5AvB5TZnDDr
         kQ9A==
X-Forwarded-Encrypted: i=1; AFNElJ+1Pv6hbEKaJSxwxyxY3GP2q6izTYZ1WqNb1hjeWD7mVWTWRGHnQ8jYk5D5L4MExkvaEfSS4xA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA1oNFFm3qcVgATwV9N40OEMaG9AyVPkkl1ivVxep2jzoU9K+O
	JYHcdphIwxCDEoYVNgvATCIWn9pe52Mh8QmjKA0VjF3HbN12GDrJEp+FBsHasie5
X-Gm-Gg: Acq92OHYXTWG2JEzF+/v1Fylt5HSMRmtYoYdl3PlxN0YunXtNk5gzKArXJyB0TykdMC
	6Z/f4GmyxOLgNfsO2Dwb9n3RRnK2/NmrZj8b+n7oIN4soW3xIV9/OPeBtQ6gjTCxOcowcZek/v3
	dlgS7BmeD+9CLRXXkShkGzyt6JU2+1Po2iS6SRN//hPdPcG62PWyKWa9VFpSzjHe43kott3yUDN
	jAhYHgAo+kI+5ixKMRw1JvSjNOhXRAwNsTPGRUFfgOkD7yl12++NJUfrTbEtFSoj77ZOHCB/O57
	Ychpy51d2xTLEa5UMj+nj2nSdjhNWm+HR/p79jq28XrF/2g1bZxtF3Qk+YAbjKOBnYzu+pwMuM1
	NVX0p4KWg9ZA8HsX4FmZYOeQD2rJeQSbVV8hTaS7iZ19hbocEVpYTIPe9UJyb5hX9em9VmUzTRK
	tT17p5vdQQEUfPLrn0jfVtkuNv04zA0AZ2JpAq1fZmVbfgj/b1XeWunsLt8UCbyFSKfx2nKkpDY
	Q==
X-Received: by 2002:a05:7300:ad30:b0:2e7:5737:8364 with SMTP id 5a478bee46e88-303984e17ffmr8988389eec.15.1779161542347;
        Mon, 18 May 2026 20:32:22 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bc9d4sm14971444eec.23.2026.05.18.20.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 20:32:21 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 19 May 2026 00:32:15 -0300
Subject: [PATCH] ALSA: ua101: Reject too-short USB descriptors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-alsa-ua101-desc-len-v1-1-4307d1a5e054@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrDuQhGDUq5QuYhx1RNKSMaUg3
 t1Ulx+89+8glJgEumqHRF8WfscC/aggzD5OhDwUg1GmVta06FfxmL1WGgeSgCtFdME61ThjywT
 K85No5N9Vfb5uS+4XCts/BcdxArjNHe13AAAA
X-Change-ID: 20260429-alsa-ua101-desc-len-7c4708724604
To: Takashi Iwai <tiwai@suse.com>, Clemens Ladisch <clemens@ladisch.de>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1589;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=05iD/qAS6Hmb35Jwib5lGI7jVOda2cbtoKdufYvK23s=;
 b=kA0DAAoW0F0/Glr/7oMByyZiAGoL2cOiu2gVWhKEuAYFu/ViMKEXNP0uSWkmwH7pZD+tJnVa0
 Ih1BAAWCgAdFiEEq2KiObyK4NV/XqhI0F0/Glr/7oMFAmoL2cMACgkQ0F0/Glr/7oNY5gD/ee4/
 FtAmiZRV3dQIczdwTSmIRIXyFC6lgKFP/HrGiSMBAJYYo/5uTbkhQQ84R7IzfdeagWJO6RLuva0
 B6bhZUJoG
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249453-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 03E19576D5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

find_format_descriptor() walks the class-specific interface extras by
advancing with bLength. It rejects descriptors that extend past the
remaining buffer, but it does not reject descriptor lengths smaller than
a USB descriptor header.

Reject too-short descriptors before using bLength to advance the local
scan. This keeps the UA-101 parser robust against malformed descriptor
data and matches the usual USB descriptor walking rules.

Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/misc/ua101.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index d129b42eb979..b9a62e94e06c 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -894,8 +894,9 @@ find_format_descriptor(struct usb_interface *interface)
 		struct uac_format_type_i_discrete_descriptor *desc;
 
 		desc = (struct uac_format_type_i_discrete_descriptor *)extra;
-		if (desc->bLength > extralen) {
-			dev_err(&interface->dev, "descriptor overflow\n");
+		if (desc->bLength < sizeof(struct usb_descriptor_header) ||
+		    desc->bLength > extralen) {
+			dev_err(&interface->dev, "invalid descriptor length\n");
 			return NULL;
 		}
 		if (desc->bLength == UAC_FORMAT_TYPE_I_DISCRETE_DESC_SIZE(1) &&

---
base-commit: 7c94f5e77906abd7b9ba81875ae238c802a187cb
change-id: 20260429-alsa-ua101-desc-len-7c4708724604

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


