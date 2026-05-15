Return-Path: <stable+bounces-247777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ITXCMkiB2rasAIAu9opvQ
	(envelope-from <stable+bounces-247777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:42:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A830550A28
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D30E30D9762
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F136A3C276B;
	Fri, 15 May 2026 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKYXsXr8"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226633A451F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851964; cv=none; b=cg+8nkclzLEepv5LOPSWPIzZGPZ7F5EfBklw8hp8Yzg0a/3vYDSd2prVFp3H/iAoX82MgWiofc7SwXHhbaNi54L1qMyXQpTo6vekAVPYQxpF0stlMCP99te2llRQdJ6SoPLktTNsa9yihi6eH0ql+FLF5pTqoBZj5GZlrD3pGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851964; c=relaxed/simple;
	bh=ou1StnidYf6G/yTiPb1Jyr10n23l4lsfoChEA55hU/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ecRs0SxUwaGNA9luJbZgHgbsaphOZBXw3TUeKxeERPNMCPV4iKWBqyGVwIpRG3WSwiMiUPFebo2HVuh7KMakWS6EZ1MxtejZkrw5bX/TaBXioGRbAR1qpcEyLWKkRR7QEY2Ze9RsIVW5Sanbg2N7pk8R2q4SkBnzegqpvB/aVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKYXsXr8; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c156c4a9efso12728163eec.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778851961; x=1779456761; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8duf5TvyhmY/rcIc+GeiPIXbLWq3N+o607ETTSlKvE=;
        b=dKYXsXr8ONhvtSB5m1MRU4zqzaLNRlPYwxl5ZpKPZPtfkOhbX7ki+vFrqxb+0arIl0
         zG9OZN7EA88SuiHkilwq7e0M6FH+14e2Xvy3FBesU/JPl5cRmjFbfvADc9mMkL91jAuf
         zQHXjqA5iS4z3rRB6LZ0cLXPp6yrw/55xuarkgs/sKED16D+d5GM9unRDi9Uv4KrTZUL
         NKCrG2hEIJCJwtYwq6NZtaeksZ2MItLOLucY8BM/GNlehgFefqxjHJVVlTn0i9hbAliR
         /XC0tvJreCQYxd0OdUx4lQXDtRDH2TvfTFLJkZBzbqd4stkQZh04c7CBlEEDZlCY4rV9
         nWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851961; x=1779456761;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8duf5TvyhmY/rcIc+GeiPIXbLWq3N+o607ETTSlKvE=;
        b=P0VuyJIfLJYRZqFLOv9ECMp2BAzxwgMSS1IYXo4yngdlzpEsD2sNWrIKys4/gmVG0E
         GFeLUiOBwHTL/A9EDuzD1VYbQE4GvZo367V94NfMM7HzJ+t05hh8mXNFOXVthzr6Woxu
         WVnMLP3PhdYvo9efPqZ29QehznChZoXK4ZRzdKjiKnqySjoKYcv6udz0QH1hAm7oDLc5
         g5HKeh42KFe7abfVNHgA1JkaAlwpdbSwJyrsZZdswjcHfaQ94x+oNFB6tksmaNLzpPWi
         kqrokNNAeQqa7xypBZ9JKTJSoSTlNINFyxobCYk2WY4iVJiImYyPHZNJPpzKpisIYEWS
         dzTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ch31ptV4lV9yx00Im15R4K5u1FvLjBO1U8VKtq9MrHqwOZqE4wZu6S8JNvhvULBB4Hm1Nn4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIAIVyHsyrQV/8h0H6MdUzSQotjbKOPNKZ0I4uLXU3SuaUf2M
	FenukTB4vvVyrVNL5ZfUBiaIfDnGW6snEZ85hb8oPSGySwA6AOL86qMp
X-Gm-Gg: Acq92OFxfM+TlAIqocBNhnXrHPU/y0Kl/kKtr6eFom5WqXRdd30wuCnd/S/hYnIfJlB
	OhQGfv1hptRU1M/zZz/7tx2NiJw54hOfBwCBQu7WhHVGzOMr+5nfg1KQ+RTsr6vSsdDRbfgRv8U
	yOc3IFn1GABGdcSAeFmtwjPYTEiqj/KXqFiREYGJOSWuxZQk9uwUh8rBNYtl1YevsEtbbzoe5N9
	8+u+y9zlhmhz6pxhzDSrHzGKzsV3ETrdERjN3H1+CnlWSqQpOPgMiMxSNKPimteWQq3p7B4wJq2
	P0feOZh1ytnZlacwaFU0dXub8sHAPTqZdHTUiLZnThKIaZPi9wAF+ZYNEyapNzmgfPvjrKu0VBW
	yqljOlw30a6HkxD6TXJxRG/f13a3tk6zlRQmiDrPTjuS4DQaEzt6vQe0GJ/qmkq5OZPUEo7OZtH
	Yk6QgT3+kUuFI+WM2UqSK5pumtNf0PiIfmZ2QDfJfyoJNxmEuAJg4227xH6c7qkHBMI87TtTFPG
	VFMpIREMxpqitbqmo9aljo=
X-Received: by 2002:a05:7300:641b:b0:2d9:6373:ad24 with SMTP id 5a478bee46e88-30398652478mr1931599eec.26.1778851960947;
        Fri, 15 May 2026 06:32:40 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302973bcd0csm7114643eec.24.2026.05.15.06.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:32:40 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Fri, 15 May 2026 10:32:25 -0300
Subject: [PATCH RESEND] ALSA: virtio: Add missing 384 kHz PCM rate mapping
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-alsa-virtio-384k-rate-v1-1-35ecb5df835c@gmail.com>
To: Takashi Iwai <tiwai@suse.com>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>
Cc: virtualization@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2404;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=ou1StnidYf6G/yTiPb1Jyr10n23l4lsfoChEA55hU/0=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFnsCqWHmmc4HlFaGTmvdaXOz8pl2o75E6fGT7wy++jn/
 1OjcpP7OkpZGMS4GGTFFFlWJy2y3NP14Gp93AoPmDmsTCBDGLg4BWAiDzYy/E+0yGg8uf9H4MPr
 4td580LOLazidggyb0zJYXboqzi4r4iR4dSBSPd5N084vVKzFFDNeHwmQZ3/w/L524xf5c5lX+H
 /mQsA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 7A830550A28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-247777-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The VirtIO sound UAPI defines VIRTIO_SND_PCM_RATE_384000, and ALSA
has SNDRV_PCM_RATE_384000. However, virtio-snd's rate conversion
tables stop at 192 kHz.

A device advertising only 384 kHz is rejected as having no supported
PCM frame rates. A device advertising 384 kHz together with lower rates
does not expose 384 kHz through the ALSA hardware constraints. The
selected ALSA rate also needs a reverse mapping for SET_PARAMS.

Add the missing 384 kHz entries to both conversion tables.

Fixes: 29b96bf50ba9 ("ALSA: virtio: build PCM devices and substream hardware descriptors")
Fixes: da76e9f3e43a ("ALSA: virtio: PCM substream operators")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/virtio/virtio_pcm.c     | 3 ++-
 sound/virtio/virtio_pcm_ops.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index eb9cc8131905..be3893de40a5 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -77,7 +77,8 @@ static const struct virtsnd_v2a_rate g_v2a_rate_map[] = {
 	[VIRTIO_SND_PCM_RATE_88200] = { SNDRV_PCM_RATE_88200, 88200 },
 	[VIRTIO_SND_PCM_RATE_96000] = { SNDRV_PCM_RATE_96000, 96000 },
 	[VIRTIO_SND_PCM_RATE_176400] = { SNDRV_PCM_RATE_176400, 176400 },
-	[VIRTIO_SND_PCM_RATE_192000] = { SNDRV_PCM_RATE_192000, 192000 }
+	[VIRTIO_SND_PCM_RATE_192000] = { SNDRV_PCM_RATE_192000, 192000 },
+	[VIRTIO_SND_PCM_RATE_384000] = { SNDRV_PCM_RATE_384000, 384000 }
 };
 
 /**
diff --git a/sound/virtio/virtio_pcm_ops.c b/sound/virtio/virtio_pcm_ops.c
index 6297a9c61e70..1105e7ff3523 100644
--- a/sound/virtio/virtio_pcm_ops.c
+++ b/sound/virtio/virtio_pcm_ops.c
@@ -90,7 +90,8 @@ static const struct virtsnd_a2v_rate g_a2v_rate_map[] = {
 	{ 88200, VIRTIO_SND_PCM_RATE_88200 },
 	{ 96000, VIRTIO_SND_PCM_RATE_96000 },
 	{ 176400, VIRTIO_SND_PCM_RATE_176400 },
-	{ 192000, VIRTIO_SND_PCM_RATE_192000 }
+	{ 192000, VIRTIO_SND_PCM_RATE_192000 },
+	{ 384000, VIRTIO_SND_PCM_RATE_384000 }
 };
 
 static int virtsnd_pcm_sync_stop(struct snd_pcm_substream *substream);

---
base-commit: fac9a31701803e4e41fdb7b5c71582c65cf47176
change-id: 20260422-alsa-virtio-384k-rate-723fe9772fa6

Best regards,
--
Cássio Gabriel <cassiogabrielcontato@gmail.com>
-- 
Cássio Gabriel <cassiogabrielcontato@gmail.com>


