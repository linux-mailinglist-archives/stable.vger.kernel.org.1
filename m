Return-Path: <stable+bounces-244307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLseN3Gy+mltRwMAu9opvQ
	(envelope-from <stable+bounces-244307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 05:16:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C93A4D5D67
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 05:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 343893046382
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 03:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBFD2E0938;
	Wed,  6 May 2026 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DB9HhVSv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB02C21F4
	for <stable@vger.kernel.org>; Wed,  6 May 2026 03:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778037359; cv=none; b=d7xTzYGaOB4W+pVWlmTUikGqp6D1Mo0zdzFa9ThOiH0WSqoNckPzXbmHkun78IzMmr3+71XX5e+xjjfC7rzROgKYhD8j6hm3gT8qqHh7mEL132gVnH9Y5C2ZzWxrYS9p/tUtuIU1ZP2Il9c7AFt3lrJ1k0cXCel/h9A0sUgoNCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778037359; c=relaxed/simple;
	bh=D4Dm05R02gfMXqFBcn3iEZPk3hEFDGh7B79LWuzYI+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uLbXbL5JUwQ8FgUKUjoh80Pbs7qqsvJBAPT7H7f3tt8mJ9myJYHkFIe6hAQxpyV+IUEyOqBTuL7ifI5yQnKro5+sORnDqfGs8Guedlro4gFgbnNyWdWXHuwnWk/2h5ijK4rCm4bOJfl0L5fWXQW9KO0PpzihmLnaXO1uKOFEBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DB9HhVSv; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1305908ae11so4375123c88.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 20:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778037356; x=1778642156; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pP0UnLhxdUXdfJTdwn0EZn17bc3fnvL8TzqCEVSM0Kc=;
        b=DB9HhVSvZgrkBFJV4j156g0IZ2qfL2sVsDl7Ww8PjRCuAaekiGcDk1lCoZQvOJEV6g
         43z7HMbYPxIShLsxkxI1EKxZ9M2wCyhDGlcejEANhgOVTQrSkrw4w0T/vtHWTS2oyVWv
         7SVo4U5E5biIHP4p0ikizQaRgSk6i9oUm6Oyh3LSUWYRxJYbSGFXWwfvjt8F5WMEU4Ts
         T/siXFzLT41sCF6zA5u3PhDmWHek8720goWmE0QSV6+zU+b9JDSCMdoZWhsymWRd8X1R
         YELfmSo/PrsD8QNMPa8zmPO4zg9Wi9mtoukw5TMhqJgY+X9FtqdYBYNB/YAHqxnP+J8Z
         B5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778037356; x=1778642156;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pP0UnLhxdUXdfJTdwn0EZn17bc3fnvL8TzqCEVSM0Kc=;
        b=jkLfk61kjwznN7tAbrUg+h720nkIkFr8RooiavpLpUY+ahXhSqhJhn5kCs9LsZKyCn
         xQy33G9RxJjhKiZZPj/HRFtkJDxohblUnYlQ8djUER3Ejw46kp3k+CROKnur1hZ/fUYY
         7Er5RFkJGRswnvx3yy8aJTkA2UEhIuNlAfCcXRkKBIyvlienid5CR4PaUcdHH9ju9+O+
         prDOVPWgwUHQ5PoofzngU+a87baDTwR7q173cGlTby0BuV2GmesEhXdy9UL8UktzDZvI
         lgX0+9NK62z/ZwV3B5UbU9CTruCZ4/xSVkcmxNUpcKcp/6orXgdqigshkf84TYmTYW2B
         ywtA==
X-Forwarded-Encrypted: i=1; AFNElJ91Cj99u7k9n/5X1L+NtJlwOsX7K5R8oDJTHlu2piQV7FoU6L91VgqixCuF2kJ2LWTBmP9OOCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAh/9jDzqCoxloQqWNpjOESu8/6swj7TlSRbD/H66NA9lGEZwK
	5wi++dYRI00Q+dxnwAYKvwynRADKm5R5x9TGQljPPzoAarKliNyn9xS64lvUBy0i
X-Gm-Gg: AeBDievT4wRzXRoBso+HQNja6VkrSQOiLxfkaIOL4gEbF1Ug/N2wxax8Sq+GI8b8MpI
	EiZewMukuP2Fm8nHQuCQbEGzqCxhVXddew0mcE0gmRQhR4I4ftMSXxO6hCqgJ7CldIgQsZCAe5L
	JHEVH1xEnJ0Z+Y/N4mOX+cpedQZ3zmPEgB77XBAs8pT7nRXVAeSyLLISXXH1clNhfKiZgW/vy9v
	9UoCTRd1j2HqFfKqGRjireGDa652xVWq7XwTKEmuhflccdM29zCi1CrzC1yt+iuAwUegZp9y/c/
	Tl+vOjJwre4DcR46/DIWjbZEQqz4cNxAfxKn5ZukFbp+JFRyLR8kd4BifMN6krIsGxMeOdhGlCm
	L4Pksv2uv5yW6bqe9EtswnfYTdf7vYKSaNINogW5hh9ydijIIZs9n21tmAYT41Fv61uQQLlZdEx
	TiPacu0otvQn2qR0GEMFp31qEvuTgF7IwAL/OuKdfO6dcpl5CWTKbkl6InGkazC1IvGVYruaICk
	g11YB6o1C57G4k2GWXeGWs=
X-Received: by 2002:a05:7022:6b94:b0:12d:f0b0:e32b with SMTP id a92af1059eb24-131852d2ef5mr960167c88.6.1778037356149;
        Tue, 05 May 2026 20:15:56 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f00196bcsm1957989c88.0.2026.05.05.20.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 20:15:55 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 06 May 2026 00:15:48 -0300
Subject: [PATCH] ALSA: seq: Fix UMP group 16 filtering
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-alsa-seq-ump-group16-filter-v1-1-b75160bf6993@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAwAwK8gz1hKAsrQr1QdQjBgRCG1CaqE+
 HvTdrzlTlASJoVbdYLQwcrbWmDrCuIU1pGQ+2JwxnnTOodh0YBKL8zPhKNsOVmPAy87Cca+jY0
 NjfGeoAxJaOD3b78//tbczRT3bwnX9QFmoUlxfwAAAA==
X-Change-ID: 20260422-alsa-seq-ump-group16-filter-cd4c31a3066e
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3181;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=D4Dm05R02gfMXqFBcn3iEZPk3hEFDGh7B79LWuzYI+Q=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJm/NmVK1jR8qogQfpL1+mYnb/qqxSWqNl29T1rTDf56P
 zlivM6ko5SFQYyLQVZMkWV10iLLPV0PrtbHrfCAmcPKBDKEgYtTACYitpaR4czBU02/0uN4/5+/
 JRMeFBqfZfVmns/KvsDTW51lm3eWuzD8szu08/bfNzNsbjeuS54clKKdfIvpm0fXU5XF9dF8Tjc
 e8wAA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 5C93A4D5D67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244307-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The sequencer UAPI defines group_filter as an unsigned int bitmap.
Bit 0 filters groupless messages and bits 1-16 filter UMP groups 1-16.

The internal snd_seq_client storage is only unsigned short, so bit 16
is truncated when userspace sets the filter. The same truncation affects
the automatic UMP client filter used to avoid delivery to inactive
groups, so events for group 16 cannot be filtered.

Store the internal bitmap as unsigned int and keep both userspace-provided
and automatically generated values limited to the defined UAPI bits.

Fixes: d2b706077792 ("ALSA: seq: Add UMP group filter")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/core/seq/seq_clientmgr.c  | 2 +-
 sound/core/seq/seq_clientmgr.h  | 5 ++++-
 sound/core/seq/seq_ump_client.c | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 75a7a2af9d8c..5719637575a9 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1253,7 +1253,7 @@ static int snd_seq_ioctl_set_client_info(struct snd_seq_client *client,
 	if (client->user_pversion >= SNDRV_PROTOCOL_VERSION(1, 0, 3))
 		client->midi_version = client_info->midi_version;
 	memcpy(client->event_filter, client_info->event_filter, 32);
-	client->group_filter = client_info->group_filter;
+	client->group_filter = client_info->group_filter & SND_SEQ_GROUP_FILTER_MASK;
 
 	/* notify the change */
 	snd_seq_system_client_ev_client_change(client->number);
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index ece02c58db70..feea8bb7d987 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -14,6 +14,9 @@
 
 /* client manager */
 
+#define SND_SEQ_GROUP_FILTER_MASK	GENMASK(SNDRV_UMP_MAX_GROUPS, 0)
+#define SND_SEQ_GROUP_FILTER_GROUPS	GENMASK(SNDRV_UMP_MAX_GROUPS, 1)
+
 struct snd_seq_user_client {
 	struct file *file;	/* file struct of client */
 	/* ... */
@@ -40,7 +43,7 @@ struct snd_seq_client {
 	int number;		/* client number */
 	unsigned int filter;	/* filter flags */
 	DECLARE_BITMAP(event_filter, 256);
-	unsigned short group_filter;
+	unsigned int group_filter;
 	snd_use_lock_t use_lock;
 	int event_lost;
 	/* ports */
diff --git a/sound/core/seq/seq_ump_client.c b/sound/core/seq/seq_ump_client.c
index fdc76f23e03f..9079ccfdc866 100644
--- a/sound/core/seq/seq_ump_client.c
+++ b/sound/core/seq/seq_ump_client.c
@@ -369,7 +369,7 @@ static void setup_client_group_filter(struct seq_ump_client *client)
 	cptr = snd_seq_kernel_client_get(client->seq_client);
 	if (!cptr)
 		return;
-	filter = ~(1U << 0); /* always allow groupless messages */
+	filter = SND_SEQ_GROUP_FILTER_GROUPS; /* always allow groupless messages */
 	for (p = 0; p < SNDRV_UMP_MAX_GROUPS; p++) {
 		if (client->ump->groups[p].active)
 			filter &= ~(1U << (p + 1));

---
base-commit: 0d672ef050d4e1c3891c9944f72c85769978bbee
change-id: 20260422-alsa-seq-ump-group16-filter-cd4c31a3066e

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


