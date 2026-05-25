Return-Path: <stable+bounces-254208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMheHZiwFGrRPQcAu9opvQ
	(envelope-from <stable+bounces-254208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:27:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE68B5CE5C1
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 22:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624163026A81
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C65B3290C8;
	Mon, 25 May 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYDnRejN"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F53955E0
	for <stable@vger.kernel.org>; Mon, 25 May 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740779; cv=none; b=N8S0Xx2RA877XnTkiV6myMzdvLQyp3dpfnFoXs/jJRUyFDG6qzGlFsjpgNvBMH4n/9tQPsbmAoKabnZpn9WP0DOgOvbEc5o6v1KvCdZ672dwm+pAxieHjjC9wpkw9kEfDFgHW6ts5jTwtDmFeez7P8jpC5vjSHSD9GXzLZnwzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740779; c=relaxed/simple;
	bh=2z3nyKEVA3fX4RWIlRXG+J+3x5NijVYYAa2uEK6YBRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czumyYrbHTWcY7ekDeU/psRGrP9fIiKiUzXHOok8jkF4/1M42V01y4FXlMIT3pGRu0bQRNzDCJjOzthAEclXYmE78tTJPG9L0/SM2wquhpywIzabLF8P4m1kjDZuOfT6A4YK+ewQVcmjfEobNs84S2t04DKeUb4BQfDPgWhFw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYDnRejN; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-694891f8f62so5445866eaf.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 13:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779740777; x=1780345577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r8RhsQYE6qApYlJu+dL8K8TLlcMeAFqJPIZDrl2xNw=;
        b=IYDnRejNayu9h5dPSYSq05118yfaxK1pNL/Rltj5WgXgfmuoUx5K3rwzZsrvEsKeR8
         /2Jz0qZt297ef4OnbrmHIpnkD9ds1829JqzSn9bru3cw+Pevax2SWgjIsNX7oSj9ccQy
         Zz8y26M7L9kClkD3ZAHbfJJSs4HzWAqNPYHiT1h6qYW0jKj5MLd+U5m2wY74OHBVuNEX
         fuSmG2watBgmJA+iBHI30F3xAWWG7jTmb14wKWulnrWCYjvn0byt1uIiYE1emWhC5IJw
         /aWV0qJXRF/K0JDWprRXFPoaC8MPei2UlBU4b/deiPgC+G3H+4KE0h9VOZlD55gDz0MH
         QnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779740777; x=1780345577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7r8RhsQYE6qApYlJu+dL8K8TLlcMeAFqJPIZDrl2xNw=;
        b=AHu7yIZ62TnF+eaJcWXef1hG/mKNrfXq9BvVK+H0xOR+Qa90qT/EoRwcFm5KwjPB7w
         zk/8+a9g8vo8L21W/U/Ov9/if+oWpyfAszVXSApbR5oCJZaMZfLp+YOw39Xo4iGjgsPI
         E25Sga+gKJmyixBesboqQMHZS9dqRiAS8f3XdggNm2/pUwd33uhoMETEvI2gQE8dCKRa
         W+h5Pzsm3a3oLmbEcAAHH41pK4xTJ/+Zr1AoNZS4AKOoraT+3A4x0pADF3v2euoKGdLl
         HvxpwSJftZ6VHJxSVOyO66ylD6LTJm4Oz1vjkC1fBzjIIpYDV3JpZzAxsLwHaQkdkYZs
         eASg==
X-Forwarded-Encrypted: i=1; AFNElJ+fhmOpWKO6EhfUI84Ffi+fvC/Ok0YtGABMwSkjmSrXGBLFS0F9/ZDT1badRGvF5h4c90fRLts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXrh4bMPzGGTTpkokgrFM275Za4a93vy8KbZnEccB6vpxEmB7
	EtRbzqwQuPvOD1SGvs1XPOM7lP3SdoefTJRxlnt2WzJxuzre9Xn7YSnR
X-Gm-Gg: Acq92OEQqPLhk+RpKnxgcOwBhffKWgDwvrdlL+wa7lJiiKGcKHZDXnM0BQg3d21I+x0
	lJZavYpt/KOz9gxMYTcqefb2ZWukCP7LWzR6H9UvkzxdabJFmXwDBpkXcyWi4XXM0bcBZK9QEjo
	5AVo9vwTrlTo4AEhXXPfg1cnO3kXu8C90GVq+78uSCsCW1Pf/AyNTR3CH1fm7V7D+xr/jHjl/Wg
	cuX3/25zuHo5Tzw3z7pu8Lh4/iqBJ7K4p7D0IsCjzFrRwORbOlqcDV1fzmIRJvwJsv7pMnK/nAC
	N+6TotaZnDH/GKW3vpcL1JGiegkuntaKARGsrnKrVC9EgiBtFctq8Xu9nWVyGxOt/ZlCSbrbipl
	cJKoqBT/j4wCL4kxoTAZZns3i4jPKw9mquqpBxo+DXy79DEhBhbOU16liP2RRO2lL4cnj5WvSA9
	t8siZJ4DpFC6+oDHycYVRvFdgW5cgG43qOO//DWkx2StCpNiXEgO8YL5L5TktR7Ex5YMuaGOGXK
	fagl+Q2VBdLyExt3O08YvP5iiqZLLHsqBx7JF0UlSGP+Lo=
X-Received: by 2002:a05:6820:178e:b0:69b:56aa:1525 with SMTP id 006d021491bc7-69d7e83e0f8mr9916091eaf.0.1779740777211;
        Mon, 25 May 2026 13:26:17 -0700 (PDT)
Received: from DESKTOP-J47FREO.mynetworksettings.com (171.sub-75-196-24.myvzw.com. [75.196.24.171])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b63512d63sm10898192fac.2.2026.05.25.13.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:26:17 -0700 (PDT)
From: Adrian Korwel <adriank20047@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	Adrian Korwel <adriank20047@gmail.com>
Subject: [PATCH 3/4] usb: gadget: f_uac1_legacy: cancel work in f_audio_disable()
Date: Mon, 25 May 2026 15:26:11 -0500
Message-ID: <20260525202612.680-3-adriank20047@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525202612.680-1-adriank20047@gmail.com>
References: <2026052517-undergrad-reformat-44bc@gregkh>
 <20260525202612.680-1-adriank20047@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-254208-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CE68B5CE5C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

f_audio_disable() was an empty stub that simply returned without
cancelling the pending playback work item. The work function
f_audio_playback_work() accesses audio->lock, audio->play_queue and
audio->card which reside in the audio struct that is freed by
f_audio_free() after disable returns.

Fix by adding cancel_work_sync() to ensure the playback work item is
not in flight when the audio struct is freed.

Fixes: d355339eecd9 ("usb: gadget: function: make current f_uac1 implementation legacy")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 6ad4b16769b7..798fbb8550bc 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -697,7 +697,9 @@ static int f_audio_get_alt(struct usb_function *f, unsigned intf)
 
 static void f_audio_disable(struct usb_function *f)
 {
-	return;
+	struct f_audio *audio = func_to_audio(f);
+
+	cancel_work_sync(&audio->playback_work);
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.43.0


