Return-Path: <stable+bounces-243956-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLKaJI11+Wk48wIAu9opvQ
	(envelope-from <stable+bounces-243956-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 06:43:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F07F44C68C5
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 06:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3BFD3042254
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 04:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEBB3BD635;
	Tue,  5 May 2026 04:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J88MGhRS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572F3B8D40
	for <stable@vger.kernel.org>; Tue,  5 May 2026 04:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956032; cv=none; b=JjTjIV4rYPbCo924eYR7rKKzFyEMH5gZCLU25to7Vjrj1EKy02hWQ+0z+E7016sGcu2MgLg9H5o44ATFi6s1srmp8EMPESP5q9umV+Y+SrdX4pb7qWw3or+Ln5+hT6tMzppTrfbdDmzKCs+zKJHZoK6KckhpqrG3tI15Jv1GTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956032; c=relaxed/simple;
	bh=xg+AzQSH02m2ChqkHlHOL0nslwkp1ELZhv5oYpTQd1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FY3xZA33hSckT8HhwztwlyGSWMJ5RFNHQxJAt1z632uf1/RWml8MLSsVyQ/v8MJGlaokYW5epw1hLUFnsjmGy3wgd2tM2N/TrWMvHXP8ALmp+lqgufVfTSRBvUQjbDjHJ+UY1uY7AUgE+PfYmLIHAqOL0J9QB3XUh9ULrCrgCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J88MGhRS; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1305908ae11so928793c88.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777956030; x=1778560830; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wD6lG8b++LnD58VJ+TTawp1hDBka3Nn4267cv0Dov5Q=;
        b=J88MGhRSVu7EfWsDysKSWe7mlteHUGl+db2GB7cMG1wd/mYAVJ3uvx57Tkwmg/r3Mi
         AG4i1l3VLP224iJ0Tj8XbKEHYTei7WQvp7/lnIrpVATe6xLJePFTOniUUJu4Lqfjym3o
         erHZy7ohu24hiOLL2iGK8Zkt1nKyUO2Xwxmh8O1ZhlDaAwfihJGVZZjJHECTNqYZs+87
         eQ4bpMZPGbH94Va3M+g1w5cDVxDwo1DVzY8gk9WC1LZ2FlYr4UM8D27Q5oBViSkayHkp
         hLnN4wKRxY+s7ddlbXDjc3Yr54/GSDhCCZCGzB+CNTRRFz8NTv/nD0MX/cwQbYC9F2X/
         BSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777956030; x=1778560830;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD6lG8b++LnD58VJ+TTawp1hDBka3Nn4267cv0Dov5Q=;
        b=bKmITRKlyyulEMKgAw/GliZfsDVLiyjw84hgvvAcKZ7/cgEYa5MQ3MlKed6xZOyGM+
         l/Y9lP0RcJsKgmhh2GkM49bbMRQa7S9es/8/Put42yMpVmWgrDXG+DVsvXYXsrwUehYA
         d2MWOkaJvGb8eHC1sm0U5nfhRpp6cnRR2Hvw7B14dXCBP2IjwJygeUUdOArqMyM9Ida2
         9hB050PEdDTGw4Ilxq2NFmgVzHfeKr8h0e+GsW59VPqziplu3HDNS+TEkJbY8qIs1qPp
         H95Zz7lMXeJS3bjZhLyepIpcw7GTngB8wdXBEgAoKtIYRZrAICYP62qgf6P4m2nUi4iO
         5jbw==
X-Forwarded-Encrypted: i=1; AFNElJ8+Wz+VxHAtRc6mkkhwWfLeTMHjAr/449IkBhm0c8kc2CsXa6BCLdMQon1/mHsCsngWEncLnqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDV7NK9EmUTnTZ0wEouQJw0jlXfE4lzrD9CT7quWUGC13+eshB
	MUsEkEhi3RVftQRZT19PpgBPHKoQy6cgah3LIhIA2nMdjHcXeXarmgwucJqCkaQD
X-Gm-Gg: AeBDiet0gMJBsbbrad4+LCtZzdJsYDYJ7WjmhNm0Ctdy1A8Y5yt45xUiPWITODGls/g
	FVhKm+DDAlf0/xPbwgUsVDJVU/AdrP9CCJKnh+3Am0dQBf938p7IVoqUUQzH6gU5Z0pJ+az3w71
	XSAzM8ZsV/uwEM2Ct6RFn9jQ/8jPsECWwLM+sJXEdqp3MJaedy5keJ4t8i7aRgZknWymkd88MD4
	hPnNHKZx0+bazZ+ZvLhAgesZB/IGPUFlieMExRCzRd7n5WmkbMYOVx+vo+U8qjIN1LhYHntbdUr
	WaL2oVyhOM9QAfOBM+LF92VQsiOPcxEwINdwcuTowE7M9uuKUuXYXIYE5Du0QevY6HhPKuzRFbA
	liFy3UGdvDmK2svRD2OpddP6EIogAGPqqxDrxUS6lY0tBIByNlWXPTwJHwRM/PX58WZLtFWIoUh
	HUyeP6seGLj/6slYKFrQ9FGjA6PZZfGPuU8Xy7P+5lY78FumrRiljzeatddCsqUhJyQAQ9iMXTj
	N5ex4Q+dJkb
X-Received: by 2002:a05:7022:4392:b0:11b:f056:a19b with SMTP id a92af1059eb24-130b1752467mr1065462c88.18.1777956029887;
        Mon, 04 May 2026 21:40:29 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b2casm18920019eec.14.2026.05.04.21.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:40:29 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Tue, 05 May 2026 01:40:21 -0300
Subject: [PATCH] ALSA: virtio: Add missing 384 kHz PCM rate mapping
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260505-alsa-virtio-384k-rate-v1-1-ca092185bb03@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CQAxA0auQrm2ChTDoVQyLih2oGjDtSEwId
 3eU5Vv8v4KLqTicixVMFnWdp4zjoYB+5GkQ1Fs2UElNWRMhP51xUUs6Y9XWDzROgoGqKKcQKHI
 DuX2ZRP38v5dut7+vd+nTbwbb9gWphXDBeQAAAA==
X-Change-ID: 20260422-alsa-virtio-384k-rate-723fe9772fa6
To: Takashi Iwai <tiwai@suse.com>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>
Cc: virtualization@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=xg+AzQSH02m2ChqkHlHOL0nslwkp1ELZhv5oYpTQd1Y=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJk/S3aFnYviPKy76r+C6bLPDEvun9saHRe3+O5Dt1K7P
 MbT7xu3d5SyMIhxMciKKbKsTlpkuafrwdX6uBUeMHNYmUCGMHBxCsBEFFwZGS5E8Yk32zOpbn3G
 +2Ujh8qBGSlftlWk3KkUXpelIPmvMI2R4defJeFKDCLdGtuZPu+qEvm5deurfXqcrccFJHzfPL3
 /hQEA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: F07F44C68C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-243956-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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


