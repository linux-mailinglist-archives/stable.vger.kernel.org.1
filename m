Return-Path: <stable+bounces-240259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHJbEnAc6Gm/FAIAu9opvQ
	(envelope-from <stable+bounces-240259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 02:55:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8732440F22
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 02:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E428F301F4B2
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312551C84DE;
	Wed, 22 Apr 2026 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFuE5Hpy"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68B22F872
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776819250; cv=none; b=mbKCbtHm/XLupoZ7dl5WdP65D+ghnFvI6lH9TpS6/QXByzf/+FWEahokFSjw/ZDRsWeMgI2n3hzbN8UUU8uWX6IEUAR0wMoif6B57n7jafo2dc6cr+S2ud6d5lKEAWD9u2MJy4ZAtRyUEHAvMHtVsXsr1fczpCP8ld2luSGdEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776819250; c=relaxed/simple;
	bh=oULGjG5GZU5uTRY06JYOKrCRx+zd81vIOoy5cKg3Lag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HMJDMGcckCrAprATURQF5t8c7q8uvQlNNKk6exogjHCcnY7h4MgP8qEXsNfk1ztEVf9Q5CsbSKkGxcgEFa4fQM7w0PfQZYmsG8kwtWcVqt8MCH4pBOlcbcBHUQNctaWyWi5PA8OFomXpphpKWJDKGyLZsD6xKWqfwWy8o/J9YvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFuE5Hpy; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2e221a71e19so4591218eec.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776819248; x=1777424048; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEPznx1qAI8FTDXOwTfZzkvUsU4Rd9xTBemC7UbrqCQ=;
        b=eFuE5HpyF8N2RQI/pOFNebdlVTOmUOMcgPvHoaMY/xA7i+h28oO6N4asnReDN9mBpi
         bwT+wY2PmhhYZ2LfxoAuDGc7XsoLldrBLcxelkgLPj1RRX1vyx/PG0Kh5SFFlIBNEl4G
         e0an/6r5FB3dhhUb5MhacjMu2MsI9RVJ7kUsSDVUDskICYW+XzvsKPOVXRmOspCpoqM/
         Erzg5J0UaS6fS79Zpzr2SXP1vogn5Z/fcBDBpYwa5n9WvP+DSmTZuvKDynSsE8Ifkejk
         L1gETlSAkLYtp+nCyjrxOkI1ta72cHcBSO4JmoG0katjZX9nHGFGqh885kxUuPZPhSqq
         F87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776819248; x=1777424048;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEPznx1qAI8FTDXOwTfZzkvUsU4Rd9xTBemC7UbrqCQ=;
        b=Mr/BIQtc1scHb0I9a3cac3lQkAQjY3RILwcSxTd8aHjsBY4zrZbTASx+I94w9utM7B
         Wwq+hPkvDfQhb5LZY/QsBkFWgzIdEj1Huj3HVSS/70kQnZYbCM17d4SH9mXkdzzNORJz
         1fMzDkpznQNYToBOqeC5FwU8Y3NDRffy3mTgH9dTkA526F+eGKJm8E5athw3yON/wwBS
         ZhMVXDSk1Oe70W+A9uZAWS4BwKAeN9pPgT+ErTE9i5EukQQI5L0BhqvaxJmdUrEylgfX
         1GRViQMx1E3TYa4YEDgWNckoSvBaApSNLnSK491dwA0qnXl96RCZYm0AJ+8CQvkYmQDT
         bCdA==
X-Forwarded-Encrypted: i=1; AFNElJ83Vp0n6IMH/Isz1BBv3hHXwRWAlxE7U0k9FotErxcEx/PkEQu/wLq7wyknuM5m9wQbv7B6R5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDKRefdUFR12p/ptLjuNxtNjJr4KkJOZ4GhTFNhHDG0k6osHYm
	PHjmd09JY6To5u9xekTwu8abpM5iSPqQKTTC11ZJpatPjrLDSWVQq7Qz
X-Gm-Gg: AeBDietBtEYUuvMvCJC40I3CpxU6VDmpNNjpPeu5LA0LeRcZTiDvZ1+GGXBv+wwwgWA
	W/NmT3+yVAx2ce6IK2TPmrS81ap8Go2w70ykmxS1VE8ogOobG971cMg24u1fL4S2IM8Y5hxHjs9
	i1qmR7xChxHBhyXS6sp1ENGEGxLQNIqayIlzPPjdMJ7wMRci1VlD2gq8FKMUUk7Dp9rlJ9asRy2
	lET72nyc27xjianuX2rNaiLGuQrlG2w13+SmzaijuJoxW9SLzj82d5/7Vj42d27IDbWumSrJkuc
	0qLV8VEccSzZDsDNNl+iNHiM5ecQHVs8YkE83sF9LlFPYKdz2YRmke/HWWIsFIvxaHOM+5BQ8xl
	crRTRG2mwo7+v2TUscbDxXeyyIOnuVi5IQ9P5eOG03q3yZuK0nzw/FYmp4wMYFxxx0ddv6M43zr
	MTCHGjAINWE1TxNJ+ciiYmhgp0/iTzHAVB6FYsHBjagtVWKPDgvy8vrrzEdbsuYKDRxu6eG0Ggq
	ZB9tkpTcHpZ
X-Received: by 2002:a05:7300:4349:b0:2be:7fc2:fc38 with SMTP id 5a478bee46e88-2e466044e0fmr10934403eec.5.1776819247623;
        Tue, 21 Apr 2026 17:54:07 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa6134sm21804460eec.3.2026.04.21.17.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 17:54:07 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 21 Apr 2026 21:53:52 -0300
Subject: [PATCH] ALSA: usb-audio: Avoid false E-MU sample-rate
 notifications
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260421-alsa-emuusb-samplerate-notify-v1-1-8b63bbc1d7f1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSQ7CMAwAwK9UPmOpCy3LVxAHJ3HAqE2rOEGgq
 n8nwHEus4JyFFY4VytEforKHAqaXQX2TuHGKK4Y2rod6n1zQBqVkKec1aDStIwcKTGGOYl/48m
 7Y+d62w2mh3Iskb28fv/l+rdm82Cbvils2wcG4KA8gQAAAA==
X-Change-ID: 20260417-alsa-emuusb-samplerate-notify-9fd83d5c36b5
To: Takashi Iwai <tiwai@suse.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Sergiy Kovalchuk <cnb_zerg@yahoo.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=oULGjG5GZU5uTRY06JYOKrCRx+zd81vIOoy5cKg3Lag=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJkvZLTPpJsJNteUrMy4sbpI9eXnatXPpQGnSnWKddLma
 F0yvJnYUcrCIMbFICumyLI6aZHlnq4HV+vjVnjAzGFlAhnCwMUpABMxXsTIMPvRVbbgol1dVSfP
 JRx2v7TCLXjxtm2eB1LNuf22+5+55MfwP+KwVUBq7vtmRq7Fzzv+n4uZf/v31X7nY2s8Ih9ycfa
 FMQIA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[perex.cz,yahoo.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240259-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8732440F22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

snd_emuusb_set_samplerate() unconditionally notifies the E-MU
SampleRate Extension Unit control after issuing SET_CUR.

If snd_usb_mixer_set_ctl_value() fails, the control value has not
changed, yet snd_usb_mixer_notify_id() still invalidates the cache and
emits a value-change event to userspace.

Notify the control only after a successful write.

Fixes: 7d2b451e65d2 ("ALSA: usb-audio - Added functionality for E-mu 0404USB/0202USB/TrackerPre")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/mixer_quirks.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index a01510a855c2..5194a2ac1ea8 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1538,15 +1538,17 @@ void snd_emuusb_set_samplerate(struct snd_usb_audio *chip,
 {
 	struct usb_mixer_interface *mixer;
 	struct usb_mixer_elem_info *cval;
+	int err;
 	int unitid = 12; /* SampleRate ExtensionUnit ID */
 
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
 		if (mixer->id_elems[unitid]) {
 			cval = mixer_elem_list_to_info(mixer->id_elems[unitid]);
-			snd_usb_mixer_set_ctl_value(cval, UAC_SET_CUR,
-						    cval->control << 8,
-						    samplerate_id);
-			snd_usb_mixer_notify_id(mixer, unitid);
+			err = snd_usb_mixer_set_ctl_value(cval, UAC_SET_CUR,
+							  cval->control << 8,
+							  samplerate_id);
+			if (!err)
+				snd_usb_mixer_notify_id(mixer, unitid);
 			break;
 		}
 	}

---
base-commit: d60c26089541d574b854d7762e9f3c182a76ad9d
change-id: 20260417-alsa-emuusb-samplerate-notify-9fd83d5c36b5

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


