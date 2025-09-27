Return-Path: <stable+bounces-181822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896DDBA6227
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 19:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A2567A55AB
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28222877D3;
	Sat, 27 Sep 2025 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0JjEyKB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C2226D18
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758994790; cv=none; b=Crd+UIXxt5XRRarljc6xVrRqERlBHPtrieONI3Vv1a6DgXDneEaAI4o5Z1WBcFS/P5XRo8tluZfVs3LVyFI6k0wMu1bBlt+rCXITFnzpmJuZBL5UuHdgaK2Eqf5312Yj998sg13euaIGxSjFhP1lIi8yQaK30jl+pBkL358+lVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758994790; c=relaxed/simple;
	bh=CB9nqcr/wZx3sYbWSmMvdTfrkigS3UhAGNiP+5quUM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DzhSFK3tlpSEjja7VZ6U5Vel5UYxp11FWCF1rX40B3pVKSwzzozOb6lndJ/ADEHLSkTBfkSid/rqyHc+pYggSEtEOBsH4iwN4IS09M37AtABViTNnPPUcnUVx3K0beR8w4Jb6o0YhHgA88XZ89hFI77Mj57bbzDeFYZIia6J3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0JjEyKB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so3070262a91.0
        for <stable@vger.kernel.org>; Sat, 27 Sep 2025 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758994788; x=1759599588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUqnN1F3bgHuD+82ry4kJwIftFdoS866ISrdw4jG2EM=;
        b=H0JjEyKBm4pbcFMcnKnklmj6wI4i7PHga5Kn7qd1VjKDFgEkRNo9nTI0/kA4HXMx6Z
         JgkBL8r2rssA165J+qPHsCpJaNbhBRYG3YmjrqL04stTG4J5F7oWwdf8qCQ6gnlV1Ul4
         WvNNiTRRg2D+aOi0crCD26owGoPzxpPAgBlA1alz5Fr9CJgdGnIpWGPlTFSp0TZr6T3H
         HCn6HxtepaFg+1BsaoIu9vR73KfTzqF2h3DjoIdABfPMt5kE96XWmUe0ueEFHUHZbyVr
         X1B4OigiEGxKK74deUmFqEJ061i30xyd1YCla+Vz3OnUVJPq51mDDSVDjW/ffhFWZunL
         Invw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758994788; x=1759599588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUqnN1F3bgHuD+82ry4kJwIftFdoS866ISrdw4jG2EM=;
        b=WenVLWO5UlUnephdmbG0NyiyoDJ1k2Canj7H/b0lDXpes6xICUbHDCLVcrmqVNHzQX
         6MiL+iIH39nCBmo+WBPnxh94khgTRqEOM0BJYvjVKmA3FmkdNGeBh7n5USJrJMFcsVJc
         T7fORbincMiYodos/TN1XaaYBKSeCFLpTabaSkWFGHLW765SQnBK1JCMLjIxZDiKUBbW
         zJYyL9+SPdlmtaMAwfycEeaoV13sn9QlgG9F6DFO0xZeA/icX/SatwhfNdBbwiiYsSAX
         tFN5SoUaZq1+lbZgrfZwmx4jDxTl/UnTWf6d6WHbIOx7Hjot1B1adyk7I6tJwDIdCo0i
         URaA==
X-Forwarded-Encrypted: i=1; AJvYcCXv4pMjZVpqZFaYgN92m9YJfhHNlpm1VjP0hm7rVWQcqCvIKpeqB2+vsFXq4tAasBLJVmcQaZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuxLU6CZBH1z5hoCqwUkbFaEBw163nmkGSiZYVzLFXvaItlIb
	c2fN1IavgLBRTZj8KcDhlKv/ArIwgojBUCEGbxqi2e24Ew+rJnRh1w/ByaJ4Z3Yu
X-Gm-Gg: ASbGnctuAxcVQa1d6TJPtm2ZTFVBumrN4lgrOOsKooPcpYF6jnPtxakuP2eL+uWdEEV
	r/eAdkolpuqWa/1dGiRgKBiflhUM5O/r62cBchw0CfR6R0h1J4uFNww2zuCFDobAy22y3BlBoZU
	kbC25uerjZdWfeu0i4eAuZaAlKVLOLPSxClxyKFHWM3DqBYb5b/5MWtdf31uDUIk3w3Tlo1d0gR
	MsJ0Jt0WZix4EpO2uOCBu6wE4sx93RlFLaUnPDvL8sQ8QCS9V3K8QMwsmwwsVEr0XhuX0GwGzHV
	APIeW9xyqtV2D7EJh7wdZnIXtsHD5HDiENLQuH6j3fxHwRsb+vVRU652D3mvIc4fzRnhGGvoZbZ
	YqfITiBUSFYV30sJpv7EaBAEt3/xyHqlU5YeQ54JRMtt+yVdKpA5qAXBKElzD
X-Google-Smtp-Source: AGHT+IGtvJzCfxKqyh3P6VUpzcJjl7MCBE1zezF/b+a1T0k+e3+Zv5Rfcds1WIgUWSp6qGUOi5ossA==
X-Received: by 2002:a17:90b:1d92:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-3342a2c0fcemr11749970a91.23.1758994787774;
        Sat, 27 Sep 2025 10:39:47 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a3cea96sm4377008a91.2.2025.09.27.10.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 10:39:47 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com
Cc: hdanton@sina.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Sun, 28 Sep 2025 02:39:24 +0900
Message-Id: <20250927173924.889234-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
removal") patched a UAF issue caused by the error timer.

However, because the error timer kill added in this patch occurs after the
endpoint delete, a race condition to UAF still occurs, albeit rarely.

Additionally, since kill-cleanup for urb is also missing, freed memory can
be accessed in interrupt context related to urb, which can cause UAF.

Therefore, to prevent this, error timer and urb must be killed before
freeing the heap memory.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 sound/usb/midi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index acb3bf92857c..97e7e7662b12 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,15 +1522,14 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	if (!umidi->disconnected)
+		snd_usbmidi_disconnect(&umidi->list);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
-		if (ep->out)
-			snd_usbmidi_out_endpoint_delete(ep->out);
-		if (ep->in)
-			snd_usbmidi_in_endpoint_delete(ep->in);
+		kfree(ep->out);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
--

