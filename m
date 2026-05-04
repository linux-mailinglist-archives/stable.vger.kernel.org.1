Return-Path: <stable+bounces-243380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIDEDvmq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:19:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA74BF13A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57E2430345AA
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575BF3DC4D5;
	Mon,  4 May 2026 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FACOFOc7"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32923D5645
	for <stable@vger.kernel.org>; Mon,  4 May 2026 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903735; cv=none; b=RS8qfkbX9aD/Sxz0MotDwVEmoOhbhkrulOyTpJkVUu6v1HDvedwofiwN4O5hw0E6KGLcnqnmCn2YYDFF1cvRzY56ztwaP7UC+B3jEMBy/fYdL0rKrQVcZVWpIPFbZ8eoWjuzZ3AtHTIzqds8+k5lxB+6MZtXukNQAH7KrQkCBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903735; c=relaxed/simple;
	bh=ntupBoAYH3fMF82pW8zLlPf7lecYFnYUQau6eu9pJsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=C5uToFfaIjGm5xIZ+jXpRJdk7nDyUcTxiSviT524v3e69IcUOxAcSHzt5jM6HzbFTl/Hr9L6UBcSB091k7nO2NnQI0SwUvU8JyJq2dbdD26wFJgdKRpjRMnwuaNuCbi/R6Mk+5STg8D08mctyuNsLJcSx64c0MdQ40HiUPHInXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FACOFOc7; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f00a567cfaso822908eec.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 07:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903733; x=1778508533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq9KrqS3Q7K9ftxbbAePDLzdwZrp1AWI/uIHBK4Uqd4=;
        b=FACOFOc7lPqb0rqfMEvMeWNANgLaZXwY2QL+L5T0dp2boeUiBb3w8PJ+aznZ5eiKP+
         p5PRukEayehQ+BYFGgbh8rzQq4BnilYCVxbx7SllxaO8UqL0/7+Ck/JKbcrwo4z1QpET
         I2KcyJeZZHI/zXapkuvXYIAhQFcH5NEn1n3GUthQ8Hn/32bRAdxlR8JO9CDDMk3uNJ6P
         YZfc5Lg+aI3LY/k2zYInWLZvOT5nrefcjsXIKC/UMkiwNgGl/2RUEHHcuzGnKIffSowy
         CfOZhJ2ej4TaQNrTIG6rq8sxJwMNMAHSFYJAH30SYpC4mpU1MjG3dOv0j8U44DTdtLq2
         //aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903733; x=1778508533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq9KrqS3Q7K9ftxbbAePDLzdwZrp1AWI/uIHBK4Uqd4=;
        b=DU2kTTTaXXNZOQi/NGvLmodWk0GVtqjSJxIPJevhM2nTzmWFh/+uOehM1glpZr6YQ4
         wtvCzAf14YzZknj43CIoVIiXMVrNCuDeAirYaBvfA/64MSLbk50XOWzVpi/Mxi1z2Pab
         JLhlGaom/iXLRprlr1CCCzM/DeHWXFRkPOeXtBqcE12vQMfO5Yk7NCsImoKRpYSXFQWY
         AuN0kbTv+kDxja5KaPXb6I+PK7oWrrOsR//vYG0fGfNMY3cc4j0tyhD8ssFjyCS+41WR
         BfZj9/fljo02ZihdquKmF7SplPYhsapGdyYCmnUcVqKsf8lB5ZRH5r8rlgR2YgvlT9qp
         f+PQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DoA3VgdSbb13hfwOrA3TPg5ifHPgak9+hwX8bOrfNW4/80mekWmqi5RevvtSXeLs9gyIAdso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CVJE1ECIx8E5DgnK458/DTDjAC4DNSCiueKzQ0nA9OaT4O2T
	YA3qLZI3YVvjDwYA5riY/7ZQb844R6YjmHZwhL0zq67LQMa72cTgiAVu
X-Gm-Gg: AeBDieu+XJj8Wvf3aGY6j/8atrzWgB1mxqEJNQEiXZCbtf880ps8WmLyIO9C936nym3
	nku7+oup6ARt6CUuQFJQzU8v7Bb9Fj4dHbzpwISUlmQfhcENkBmXhtXMDmeGbBAkxLXn5cKFaDU
	igH/5TkrRMmNM8sT9yGCOSkjzsj8jlBgUh7ESeIZjcWSP3th+TA76/+7aLe1luEK2dcCk4YJxMs
	KaoSGl0sNAna3onGNjYdN74VJMpWozV+f6fYMy/Xy5fyeUpTlY5u2yAXq2YfGkwdI+r2PgSr2or
	+oDwWKCrPDLjcDWyvh9KWlVQZqoiLSM7UJY1By/K0LB6SeGrVIKlfq802FeP28noVTX8XsmBmwC
	SeVwbCLrJ7z4aXgPk6/ACSwf49+AbDZPxjXNOOYSphqfzvwLgkABw1Mh0w2EqPG84zb+XO/qG4F
	TugWG4V4UbLn+Ki3dLBfFM4aojYMqUbE0OXFpFVGRKbqNYhPCjmaVPLHzVme5MdAZldWLSVFrPm
	P9q1d9J+yt0
X-Received: by 2002:a05:7301:18ab:b0:2ed:a58c:956 with SMTP id 5a478bee46e88-2eda58c0affmr4415025eec.8.1777903732671;
        Mon, 04 May 2026 07:08:52 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b878317sm16680568eec.23.2026.05.04.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:08:52 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 04 May 2026 11:08:45 -0300
Subject: [PATCH] ALSA: usb-audio: midi2: Restart output URBs on resume
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-usb-midi2-output-resume-v1-1-c089cc8ad3c6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CQAxG4VchXdsEiwHjqxgXDPxoTbhkOiUmh
 Hd3lOW3OGcjQ1QY3YqNIlY1naeM86mg7tVOT7D22SSl1OVFhN0Cj9qr8Oxp8cQR5iO4auVaN6G
 pEEC5XiIG/fzP98dh8/BGl3472vcv9VliansAAAA=
X-Change-ID: 20260422-usb-midi2-output-resume-3a2867b73ebe
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=ntupBoAYH3fMF82pW8zLlPf7lecYFnYUQau6eu9pJsY=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJk/VhT+mJ3BbevW9XJvpXfiDVv169/FHsd56U3azq+r8
 ogppbato5SFQYyLQVZMkWV10iLLPV0PrtbHrfCAmcPKBDKEgYtTACay4AUjw6rHOt78Fu2eJtYK
 mn2FAW0LZS5d0+qPa219xXKu7n7pCUaGB9mvrB1j/q5Msv9er3+Iy2zhtgzdudXvn1i3HXZzT33
 IDAA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 72FA74BF13A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-243380-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

USB MIDI 2.0 suspend saves the endpoint running state, clears it and
kills all endpoint URBs. Resume restores the running state, but only
restarts input endpoints.

For a running output endpoint, this leaves the endpoint marked running
with an empty URB queue. Output transfer progress depends on either the
rawmidi trigger path starting the queue or an output completion refilling
it. After suspend there is no completion left, and output data that
remains queued in the raw UMP or legacy rawmidi buffer can stay stalled
until userspace happens to trigger the stream again.

Restore the saved state with atomic accessors, keep input endpoints
restarted as before, and restart output endpoints that were running before
suspend. Clear the saved suspend state after restoring it.

Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/midi2.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 3546ba926cb3..2785600d2312 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -227,7 +227,7 @@ static void kill_midi_urbs(struct snd_usb_midi2_endpoint *ep, bool suspending)
 	if (!ep)
 		return;
 	if (suspending)
-		ep->suspended = ep->running;
+		atomic_set(&ep->suspended, atomic_read(&ep->running));
 	atomic_set(&ep->running, 0);
 	for (i = 0; i < ep->num_urbs; i++) {
 		if (!ep->urbs[i].urb)
@@ -1188,10 +1188,11 @@ void snd_usb_midi_v2_suspend_all(struct snd_usb_audio *chip)
 
 static void resume_midi2_endpoint(struct snd_usb_midi2_endpoint *ep)
 {
-	ep->running = ep->suspended;
-	if (ep->direction == STR_IN)
+	atomic_set(&ep->running, atomic_read(&ep->suspended));
+	atomic_set(&ep->suspended, 0);
+
+	if (ep->direction == STR_IN || atomic_read(&ep->running))
 		submit_io_urbs(ep);
-	/* FIXME: does it all? */
 }
 
 void snd_usb_midi_v2_resume_all(struct snd_usb_audio *chip)

---
base-commit: fac9a31701803e4e41fdb7b5c71582c65cf47176
change-id: 20260422-usb-midi2-output-resume-3a2867b73ebe

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


