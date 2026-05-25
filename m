Return-Path: <stable+bounces-254206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAYDKYCwFGrRPQcAu9opvQ
	(envelope-from <stable+bounces-254206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:26:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F725CE5A4
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296A53016C9C
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BEB3955E8;
	Mon, 25 May 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVaMy6HK"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818E3947AE
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740778; cv=none; b=g5PY0x8GacVNtZWoeId9kHqWAwtOIpY7bu2fDNTPqhEW87B6ml8ZH9d4gq3Peye+egHgvsON9QhtWo9u0bKc1hQL02wxfygLU2/x9wiMIN0zevvR03kI6x9eGxSkIT8PtMVv6p3Ps+v2wXXXNSVH/404UERQckedMahFKY9EQ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740778; c=relaxed/simple;
	bh=grdFfHOkHxTLhLsS6j+FX41ur/btn/7guyqiP83xFg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rs6B5dc7hOUcGva+WyNE09/bwH8xQEFTqPyaG9o4vIYG9zPNHqueWHqAzYqM/+xnZPVICRUVnj0y8faV/s+EWdCXUMozL7EkqQsiqtzunuD3XV7Hm0R7yFUuqJMFm4fuYe8muZsfYfYxyh+QhrABNcCLIb+AVNHsLM0nVDU5ALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVaMy6HK; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-69d42abd04dso2668158eaf.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740775; x=1780345575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfK7e3u1o6Z9pLVZ7VLBuH4tZqriU9FnwEkSwlD5KZ8=;
        b=QVaMy6HKajbrUeuGQDYTeIaXXtInRbwb0I8OReAxc0GpJ5jR0rz0ByU/e1rKfUfPzM
         mIk6DK85dgmae4PfyEco+6rYhUNBXUM8+S4Oz4ms0RYxcIzMKp8+7SAS2NDzN4UyIcxY
         rE+C7pF1qQfh3+ocTAS3PFb62eUuP5XGQccW2UvaMXcV5yjPqmIsxXySE0o3SB1h+VPX
         sVGxiXnVSrwYFMuSeHMqp9K7TPzc99iszVJHaMQ7Es0S5mVXyNE0iHFo5dJyJAd0R4uF
         gEv2UiYE42ILISEYp+2hXUWSZ+EP1kSljdTSd9ieO8O8M4baakTnZjyvIaaeG2RqR/Gj
         Mn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740775; x=1780345575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tfK7e3u1o6Z9pLVZ7VLBuH4tZqriU9FnwEkSwlD5KZ8=;
        b=k0XvCQ3bkdBJm/DdfnYm6lOe1qm+f4y4sOA91uNnCTF+88ZBnUReA6xG7xU/0TcCMU
         1I8g4ZEiVcuu6Jtg2eg0xGfFxvD5D3i4XbAmhYnkgUIeGqpMLHlJeqgAsfntnB54innX
         R0rJhGzsXMcSo3+5q9jERsJYFfvPdqm9BD6YGTzr0KDm0hVsr2ccHclQVQHSMgXnzDRI
         3AC8Uj7O3ubbYjRHsGOHlR4X+bPoMheEvhBw3MY07rrk/cEn60OmTuAXwepxWNUDT2AI
         2FSc/Cdutwk/ej+59Ma1mUb04MDcCipzZU1ZUo+5GS1skvpGoL3YqioeYz7/SY0vXiUy
         c+Ww==
X-Forwarded-Encrypted: i=1; AFNElJ8MLeD/Lm7cPOHyhrxq559bTPcv+6XGAfFbKWxewx5d7uVNHEH1cARBYwHh2DflNNMkJTW2PWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxPe4BfufrcOpR6p4KwBpycJt4Y7o0iFZjB0RKnkRvblMaGvZT
	hC67CV89lS5yLN7HdfZ2dKWLy8IFjubBcXV5cFFAdzPbLd18OOEG2A27ydyBoGpt1tU=
X-Gm-Gg: Acq92OHoL9pbyxrWAhrxZaQx+a6DJQVvudEQJHNJGLH+vbakPLZ44c+f+uRO0WBzIgP
	jVUvtl0g2kyCaCUGuTAlrf3IT4CZNUzbQZRqAXSYvkR2ceTDITDQwAZL9EAsaWSCozaVSRYWd/x
	IZ+JN8i3x65f6JAZXH6Xn05mx9OVeOcXXFsmhaVYldut8RGRaaytjP7PGJW18a+smb21lF6PnC1
	o9TBw+BgAPFlys+6be+Sr06WOWFD1hbjm+s9Yh6YqYwSor0sPrVc2EdhiWLRZskV01HCxN+L1yK
	cCQ5UQrhYFUOclJGs1sk2Asy+r1n1S1K5WcplLb9CM5KQYOQoBwiS5Rc1uR8Bqo59rnugmnC7na
	r7++gDTUWCpqNBpX/ay+/W7h9yO45cF1936CGdii+3WAZlsPSY4kBtSSy6RJqtxYQk7ndzUM3M6
	BLpTortt5/jtzCQdlJmIJozUJOzQ7DVlfyTHrJiYvoVc8U10Y3LuKBi71UsJy8kONZz2lH5EpFK
	Ao9ihq3oFU0hQUaJi56PVE+mmWsDP8ah5/6IlLWa56Rqac=
X-Received: by 2002:a05:6820:1888:b0:69d:95d6:2629 with SMTP id 006d021491bc7-69d95d62775mr5413206eaf.26.1779740775642;
        Mon, 25 May 2026 13:26:15 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63512d63sm10898192fac.2.2026.05.25.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:26:15 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 1/4] usb: gadget: f_uac1_legacy: fix file handle leaks in gaudio_open_snd_dev()
Date: Mon, 25 May 2026 15:26:09 -0500
Message-ID: <20260525202612.680-1-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026052517-undergrad-reformat-44bc@gregkh>
References: <2026052517-undergrad-reformat-44bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,linux.intel.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-254206-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriank20047@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 12F725CE5A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gaudio_open_snd_dev() opens the ALSA control device file first, then
opens the PCM playback device. On two error paths the control file
handle is leaked:

When filp_open() for the playback device fails, the function returns
immediately without closing the already-opened control file handle.

When playback_default_hw_params() fails, its return value was ignored
and both the playback and control file handles were leaked.

Both leaks result in gaudio_cleanup() calling filp_close() on already
freed file objects, causing a use-after-free.

Fix by closing previously opened file handles before returning on
each error path, and by checking the return value of
playback_default_hw_params().

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/u_uac1_legacy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_uac1_legacy.c b/drivers/usb/gadget/function/u_uac1_legacy.c
index 01016102fa17..5bcd3afd6366 100644
--- a/drivers/usb/gadget/function/u_uac1_legacy.c
+++ b/drivers/usb/gadget/function/u_uac1_legacy.c
@@ -226,12 +226,20 @@ static int gaudio_open_snd_dev(struct gaudio *card)
 
 		ERROR(card, "No such PCM playback device: %s\n", fn_play);
 		snd->filp = NULL;
+		filp_close(card->control.filp, NULL);
+		card->control.filp = NULL;
 		return ret;
 	}
 	pcm_file = snd->filp->private_data;
 	snd->substream = pcm_file->substream;
 	snd->card = card;
-	playback_default_hw_params(snd);
+	if (playback_default_hw_params(snd) < 0) {
+		filp_close(snd->filp, NULL);
+		snd->filp = NULL;
+		filp_close(card->control.filp, NULL);
+		card->control.filp = NULL;
+		return -EINVAL;
+	}
 
 	/* Open PCM capture device and setup substream */
 	snd = &card->capture;
-- 
2.43.0


