Return-Path: <stable+bounces-238311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP+JGC7l4GlhnAAAu9opvQ
	(envelope-from <stable+bounces-238311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:33:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D164F40EDF0
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91BD43198318
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73493BE65F;
	Thu, 16 Apr 2026 13:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzDgFWqb"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606273BD22E
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 13:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345914; cv=none; b=qpNues7E4NDwGbI5k1uWBvtUYSlYdmHvEdhuLkfqmIXULE4N10ZtauT3+C0i5YqY0BWNlYgmI0VgdhQ9vdgn1YnaiYm/Vu+7I4bUxVqruTY0NueZ4S5o+GroaLpqFvfhwzAePITMIQXVrsSw7dv+HZYhMPn4j0M3KE9WgDp7zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345914; c=relaxed/simple;
	bh=IXGjDwTvh4h4KuOXx81DSKXrmdElgn4WOT2+I/2WUvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gDvwpA0m3Tv0VGAd83nSsBa+wxbXxiKAOiKQcbZtwjzJowHSoZR4h69Rm6p10rC477ID2c/JZsX2Pgx3hw93vyNcMPFi6b01LWfJvoB+xlXSx7PxFEVJK24PFmXuT1z+5P0t0KD5fCJsrDzr7UfVuU4ibSCfa2hNZt0JXtJQs9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rzDgFWqb; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c565476d7so3109242c88.1
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345912; x=1776950712; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jX6Ogp1BShOzt1WRlynqsHqsr7PXv7guMEAzRV9ZzCM=;
        b=rzDgFWqb3YKNeToVr2U3tK2mRUnj9bqSR+DoCTmvTRUCeP6T8Rtbfp1Bm0gABu6sVi
         NzxaOEj6X8BYN9ELPdVaIOP2MuhxE4ymUCSPX6hFNSSPtLvgWfjpL/34mZCgkkvUcyXa
         sPn5rpvPVtS4/Cq6219cIy0xx1lMtti+xOyTcRuhlORzkb7r/qnoIZqkpBr44lcz+yKI
         HvBvKRT4iLuzhjMvavw5//F1IJ7ztQXeELQkbFc7eyILuWVtR6nZ1jSpn3mVNbs0MMLs
         BlwwCRY89LQEuXCQdSw875BiG6/TI3ckQDtnkC0Up8Yg8whJR2F6Kfc9R4lrg1yFb7/l
         0JCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345912; x=1776950712;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jX6Ogp1BShOzt1WRlynqsHqsr7PXv7guMEAzRV9ZzCM=;
        b=scYh9XZV0eb9OJCIFE0sjO+wHeQ/hHljVJWRIX9H/7ovhtD2WTDfAUj5yLkWg2JwkA
         QyIU+CrKFjskX5vvaCq6AnZbI1LrCEf/H8f/8eVigMoIumljsEGG6AQguhNq/87HOFW1
         K2XtLi+VIE3yeBs5OKTmhqrL3Pq+PgUY3/ADAr/WE6y1RYG3+Q8PhEx2dY7cgwP3ckn+
         9jp3qZXMK9JsY79VHFLaJWToz8KjZ6WDM2rrocz4T8chpva9r/2IqwLl1ZNJOdSpxrfb
         3w3o9AomK/LCFu/3syORLqs293zsbSsh9+dkb48XnXi8/aRnmE1NPDTpISjqNlhNa6AC
         VuyA==
X-Forwarded-Encrypted: i=1; AFNElJ/caJTL9oLXIWtKvPdRVIjMQ7ETYpqdC9ZRVq3oLgdpO4oYzj+Hczk2olvka9xAGN7xwIAESwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvskIoXvxmEJHvkMsoRfN9SzwSpoQHorAs9HeqYYU3kpvPnS3
	ryIPw6vnflYJwGsdJz82D34/4F0YbSMEoaf5fdKMPrzt3q6xq58bRynh
X-Gm-Gg: AeBDieu/6m6iJGYTxRBZjt7DrfdrpCgdpFgtWDdY4trT2sAEvfESlrDSh8oqSbxX7TX
	y/rH6u+THMcYLKg4qDAU3gBCcLSelyhmJXvFp32K5WG9vVmmmcjhsn1Kdmcj6+q/+pSccwaG6f5
	+6ltEJhh5LzHH1AvMwLqGfxKjtZ7IKbD22OR/uk03+Qrvsv95F47YSTuCHqzVqD/f5nAweexaVA
	K5J22Hf31IVHwZpltRgacBvpu27TDhu7IIAsYsqY41ekCfTBvLXepna5KGFboLFDXCvA0P4rtiv
	4BAax97oJ2AMn1hin899q9WM3nsbRAjGJumrAZ4A1805IRmpcTY5h3/7qxBPz7ggPWYwqqI6NHB
	siFZKt6aN61Y/EudF1Q6t7w4td1O/9/2yy5iJn92kHQnAAZ+U4JU8XPkJ2PKP5ymjeBAFLdAnQW
	M9aeE5fvkaFsOIbg3Sq4zwCRzNw/6opINv9umF/UWSkUwWXBLbv2dKMVaguC5VGQMMQu1SiASnE
	xmLArXCi9t4ehA=
X-Received: by 2002:a05:7301:6788:b0:2c0:cc90:a71 with SMTP id 5a478bee46e88-2d5873b3c6amr16502650eec.8.1776345912315;
        Thu, 16 Apr 2026 06:25:12 -0700 (PDT)
Received: from [192.168.1.18] (177-4-160-195.user3p.v-tal.net.br. [177.4.160.195])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c50cee8sm7689556eec.7.2026.04.16.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 06:25:11 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 16 Apr 2026 10:24:40 -0300
Subject: [PATCH] ALSA: 6fire: Fix input volume change detection
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-alsa-6fire-input-volume-change-detection-v1-1-ec78299168df@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQ6CMBBEf4Xs2U1Kg5X4K8ZDga2uwUK6LTEh/
 LsreJuXmbxZQSgxCVyrFRItLDxFhfpUQf/08UHIgzJYY51paod+FI8ucNImziXjMo3lTfhfD5S
 pzyrRdDZdG8he2gCqmxMF/uxXt/vBUrqXrn9+2LYvJfMkoIwAAAA=
X-Change-ID: 20260416-alsa-6fire-input-volume-change-detection-de50b8fe278f
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, 
 Torsten Schenk <torsten.schenk@zoho.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2021;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=IXGjDwTvh4h4KuOXx81DSKXrmdElgn4WOT2+I/2WUvQ=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJkPHptwq97XNttRcaBmudR/ebY3/9R0Xn44s1mUSe0Ou
 822ziPvOkpZGMS4GGTFFFlWJy2y3NP14Gp93AoPmDmsTCBDGLg4BWAiNjsZ/tn1Pjl7f9Yh2xhD
 s90Ge3NcFN3XTFE9tTgunWVvZ+uxhV8Y/nsbahhHWj2Zks2l4rfM+GXMtnCNycIey76oOSzZ8nZ
 dNhsA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238311-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,perex.cz,zoho.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
X-Rspamd-Queue-Id: D164F40EDF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

usb6fire_control_input_vol_put() stores the analog capture volume
as a signed offset in rt->input_vol[] (-15..+15), but it compares
the cached value against the user-visible mixer value (0..30)
before subtracting 15.

This mixes two domains in the change detection path. Since the
runtime is zero-initialized, the visible default is 15; writing 0
right after probe is ignored, while writing 15 is reported as a
change even though the cached value remains 0.

Normalize the user value before comparing it with the cached offset.

Fixes: 06bb4e743501 ("ALSA: snd-usb-6fire: add analog input volume control")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/6fire/control.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/usb/6fire/control.c b/sound/usb/6fire/control.c
index dd25a6407b63..c77a21a9acd7 100644
--- a/sound/usb/6fire/control.c
+++ b/sound/usb/6fire/control.c
@@ -290,15 +290,17 @@ static int usb6fire_control_input_vol_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct control_runtime *rt = snd_kcontrol_chip(kcontrol);
+	int vol0 = ucontrol->value.integer.value[0] - 15;
+	int vol1 = ucontrol->value.integer.value[1] - 15;
 	int changed = 0;
 
-	if (rt->input_vol[0] != ucontrol->value.integer.value[0]) {
-		rt->input_vol[0] = ucontrol->value.integer.value[0] - 15;
+	if (rt->input_vol[0] != vol0) {
+		rt->input_vol[0] = vol0;
 		rt->ivol_updated &= ~(1 << 0);
 		changed = 1;
 	}
-	if (rt->input_vol[1] != ucontrol->value.integer.value[1]) {
-		rt->input_vol[1] = ucontrol->value.integer.value[1] - 15;
+	if (rt->input_vol[1] != vol1) {
+		rt->input_vol[1] = vol1;
 		rt->ivol_updated &= ~(1 << 1);
 		changed = 1;
 	}

---
base-commit: 10cdf5ba267d89b7fc5d9f693c65a6e4af3f8e13
change-id: 20260416-alsa-6fire-input-volume-change-detection-de50b8fe278f

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


