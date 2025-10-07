Return-Path: <stable+bounces-183553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E2CBC2421
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 19:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDFD188CC97
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE6C2E889C;
	Tue,  7 Oct 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvfxaTtv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7251FDE19
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858364; cv=none; b=uWPQNAG+9Dt5IiHc9BTYigM76PKaIWlUxHiG2AiiePP8lh3lPp0A5fc/5f7msMSecTzuNA9GdWW9ECSeVp8fEmbbnxUW9LOKuUwLA/B9XxkyrV+iD+uf4kRdihQkXhKMZ8OniWDCXvrCgCSg8mNes5QTsZ/QrqZ62otbtQjqiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858364; c=relaxed/simple;
	bh=E+aX5TOHEp/d3HJVpZn2bgZqwYp9dTDEPZHCmNXbvCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HZ4V4+wkXq4DfdL5wzOdZxu1qoCqGQQ0ur5h6+U6BXjnuiPcHVS7x9L6JhpDKYo/I/KrVJqHgm29mf/ZEo6bkBpwqQHHj8XJypqwc/7LiGOGsNpT0tlfjUgQEQ4HxEhrNqc30k7uxIHn5SAfrYQcSuc13Dc+GZOFUW3MvtwOj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvfxaTtv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f1f29a551so8332865b3a.3
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759858362; x=1760463162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8ZpYVM0V4I1RihtN3wza324vQ8Dd1czFpMPPhquAHA=;
        b=DvfxaTtv5unexpVlCHVdzbCGmcG9xoMWHRo1rC8VIsLC/7wyGXhHX0fdiTkEGq2UlR
         SMRHWVOHgeSFQXHDGrrVTA+ybKpkT4sIIssaCjnESDyxcuCmh4kcwVAVB7zpYtc2eloE
         OBv+cvEd2pjeoN0+o53Xx3tSx5eGQUtwXuI/5enGaqZd0PiTXcKtW8s3Jha7dLo/uzu4
         oqEaeMOzuatWyxkW1Jd4r7lHbtNT168rnMCdaUZ8ge1bHyABGjpGSdpvunZyfvAPvS1r
         SqqQYtD2mwsK2RGa/6hy8ci+AZVzcjfmIRVSPwmlqwCOaMFiami6GCBDGajry84AK72R
         Tywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759858362; x=1760463162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8ZpYVM0V4I1RihtN3wza324vQ8Dd1czFpMPPhquAHA=;
        b=DxzFNqlDV4tVCQeBubVShMrLxFvk89gLCuc0lC0M2ShIMRn8/vzjfrnj1SCc+9OXpD
         luZPsJHoh9W70rQtkRm5xrXYsoIb63eEI2K/lFMXcsFAieg3i2WN/aNs8aF+eOEMdYoi
         cQm6J34z9OOyWJaOAZGN3tWTMjRO6iZJBg486AXTtmvC0SEU8bysql7o0x7UzxzicudH
         qY6mRf2z7VMbKCEvjU1LzAyQQJPdcFS/5YXPNQ4/9/86FTXTPwVapvIL4L8IgtR86LS1
         k2SxqfqLBh6OB3+cZcohpzGfTzQs7brqsnir+hQ23dULc42BAFR1r3pK8vrMiTroNPX2
         u/PA==
X-Gm-Message-State: AOJu0YxbSf0QphAS7VFfNx+/JdUnk2heLXBzUnTi/J2wKB4/HlHRhNhO
	ZpLHrMXjrZerIENkZe3rOoKNjAXrwDGCzJZ0PLqREEKYWmZnlwpD5Ve0yEHcxbX+Mf0=
X-Gm-Gg: ASbGncsaq9Plvh0Vt+B2hStUABEhNmSUMq/rmyqjyAdEzNfBtNQXBN4lDLbMhIX2mbt
	8Zp88/x7WzBUaPJgIeBtIfr4Wod2mOdVADmsahVd1mPQxoMjyUrZbuvEXLjiKASbq/2mhPpFWPH
	uzVSa7so+6kQ4OdaIj36OyxzJUpmjFBowLRqkOo0ARj9Mw+sZ3eUD57/ce+lOsmeKnR1Jvm16l4
	Lj2IaykXaDuAnDNbDbrb5zSGu9Z36ed6mNRp7EgCTHtnJXMg7U3F+HoOhHC06Hzow4hwXW6/Xtu
	ZlZ/G3iJWeJs4bg0yUEuUE48USe3xBrz1tCaiPo7DeADttPPRrt9aM+S9VJZa9ytbsyBNhmDJHx
	ygCymKhHGOtvkF1p/ao5MUcOoqT8aObUVXTZS0Ob8tfoowuZcKpfozLQjaP+t6mgP+LY8oJAsJQ
	==
X-Google-Smtp-Source: AGHT+IExWMmFTXnDVcbabTZSsSq9hWpU8JqdDhoWXYn31Lw8poGbxgJvYey6hOLOtatkbJuCV9+qNw==
X-Received: by 2002:a05:6a00:23c1:b0:77c:6621:6168 with SMTP id d2e1a72fcca58-79387e05457mr328770b3a.30.1759858362279;
        Tue, 07 Oct 2025 10:32:42 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb288asm16271240b3a.30.2025.10.07.10.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 10:32:42 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.12.y 6.6.y 6.1.y 5.15.y 5.10.y 5.4.y] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Wed,  8 Oct 2025 02:31:34 +0900
Message-Id: <20251007173134.440372-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 9f2c0ac1423d5f267e7f1d1940780fc764b0fee3 ]

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index c3de2b137435..461e183680da 100644
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

