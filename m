Return-Path: <stable+bounces-183551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A496FBC2029
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 118A434FECC
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 16:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2572E6CBE;
	Tue,  7 Oct 2025 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2SmfgKB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86F42A8B
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852819; cv=none; b=Jp1ajmUXXYca8Y1bg+IDDGotioXpG0VwCNDpfi9Uo4ZIgW1tQahglhR+AYC5zIy/kCwL7oEE9LczLBYTdDNbTM7i3NFbjpISAt+Ijb0Kd3FcrGdsxtwyX3d2q2YQvLQZZTMshBcWWdjIoPR/TwH084JCVsYth8sn/Q2VqTYbcvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852819; c=relaxed/simple;
	bh=tOuaE0yzBvzmDNmWiObqpdAyTNJjwYPBrd8+TZV3+Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XitfAlsTxXX1HGBArp+JPsFmrKU7sF0NETts578vbzXGJlzFzvS8+F6vIgvnGG2Nq5qzutf1gPjR+2IkVoS2mXnd/F9i7D+2rW2ctFlQUWBNjN2vxa0Y7laBQ9On2KTt8aTey7tBkc2COk6CFdTDEc+UXEqsJ9WhRSY1WPMm50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2SmfgKB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27edcbbe7bfso100149595ad.0
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759852817; x=1760457617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUu2Hbw6HPA09/pxIefcvSfqvI47HFpD83KFx9cFtbk=;
        b=j2SmfgKB5iDmWmDue0DVxhAS7BEawG7V1vQJZhEBct4yMlBluubrYuMwTYgssWvftz
         whrDnMuPlIs1hWamgtcprSQEGa+YhMvO8C3CUqYjKJX2/tW771aQsUFHoDZJ4pQQyntj
         TtB8IyPFnKfSfBrzczSMK2pWSSaolfDdPTyfSmT2NEWf+gxR6xoML289OQV5S2F/zGq9
         B9RfzNLC1LWnG3oYisP2MHezLa0FqSw5RwnGGkI4ILZvGFCeT5bRqHfkqXcPAzC6b9wn
         z4eI43ewBuAVvFYtkcb3d483jqobLzM9gd0j3uqL2C76jtNFrpr+pg1WYDcEusf+z9gv
         WWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852817; x=1760457617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUu2Hbw6HPA09/pxIefcvSfqvI47HFpD83KFx9cFtbk=;
        b=Rs6q979DXdfmyfzoQr7KJm2ePgYtZKFbDtZ+tKiAdlGQVdr6hY39m0M438MqPRlJOY
         YJ1MFDPjJl3vPEs9F7g9DtbOWm2ChXkFIQ7kGTwC8iCcSX/PmXqCjsnthpQ4LDud3BTa
         VORAOuG1hTSWDQrdna4s/qDUfkwGGmeLhp8hUrxyA7Nds2Bd75+4IWl7XrTq+ksPTtpt
         zx9Vdovu6HwWyuFW1a3ULwVx0kFSK72KBQWKSZuen6RAsDPUeUSQbAojWvPVjyX6xYIs
         JptPS8244hXkfwcOVcyHO2/gdhqoqO/K5WOqlFmtNsLyiVFek6zcTlU02eRRFXJ1ca6Y
         A6JQ==
X-Gm-Message-State: AOJu0YywJ8jao8DHNXwxwrTNgpmI5RzwhISwGojdYaeF3pJo/7QWGbv7
	Mf95PvDb7aQZST9rabbMbAEnT/SNw12dFVGAXUXSwbIgA5PlNqtTOH8wHM2fhvr1e14=
X-Gm-Gg: ASbGncvdkgZMi1aWz7KXWvg7zTyICqMNcL94l6sTpBkIzUaTCSmnKk9EVi1aQCisFG3
	xdVVNtSoWO9+ofNjSx4uVoGYYQlBqGT1/vnvWU8x8jMlhpLwFdkOCaD3u9+V9H3JCKHa+NB4/Ks
	wgxW0HODvhOBXyXqAgQgJPaC9ijROJbbb/Ggm5OfsrcFvBjnyDVHJIIJU2SyIwdrUHBMAgW9eve
	P3hdm1FeFAIfEEg/htLG+04xqvgF/kGufiYr5D7m7ealKC13dh3a9biUt71hBKjCJiujFPWUTmE
	8pdKZbtyzKeCftuy63auNXKXmIoWQUDocRx83U0HPV7mxyIVPstIU3+SULpRukuNjxzllW71JJH
	s1lvu9C9GkPgFfp9wtzaT6RKVwpqr8swv9PQiBokHB8LsmoTqZ9wkto5e12jJwitEggUhr3e8Hg
	==
X-Google-Smtp-Source: AGHT+IGIvTWVj2P/7XIHmNkAV3Zuukq0q/OPVkyOHkHLW/63pwLaZLQx4P6CvcJZq0ImF/R8zQy05A==
X-Received: by 2002:a17:903:1ac8:b0:26f:f489:bba6 with SMTP id d9443c01a7336-290272f5913mr3577945ad.50.1759852817107;
        Tue, 07 Oct 2025 09:00:17 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d125ed2sm169568165ad.35.2025.10.07.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:00:16 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.12.y 6.6.y 6.1.y 5.15.y 5.10.y 5.4.y] ALSA: usb-audio: Kill timer properly at removal
Date: Wed,  8 Oct 2025 00:58:08 +0900
Message-Id: <20251007155808.438441-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 0718a78f6a9f04b88d0dc9616cc216b31c5f3cf1 ]

The USB-audio MIDI code initializes the timer, but in a rare case, the
driver might be freed without the disconnect call.  This leaves the
timer in an active state while the assigned object is released via
snd_usbmidi_free(), which ends up with a kernel warning when the debug
configuration is enabled, as spotted by fuzzer.

For avoiding the problem, put timer_shutdown_sync() at
snd_usbmidi_free(), so that the timer can be killed properly.
While we're at it, replace the existing timer_delete_sync() at the
disconnect callback with timer_shutdown_sync(), too.

Reported-by: syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/681c70d7.050a0220.a19a9.00c6.GAE@google.com
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20250519212031.14436-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ del_timer vs timer_delete differences ]
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 sound/usb/midi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index a792ada18863..c3de2b137435 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1530,6 +1530,7 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 			snd_usbmidi_in_endpoint_delete(ep->in);
 	}
 	mutex_destroy(&umidi->mutex);
+	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
@@ -1553,7 +1554,7 @@ void snd_usbmidi_disconnect(struct list_head *p)
 	spin_unlock_irq(&umidi->disc_lock);
 	up_write(&umidi->disc_rwsem);
 
-	del_timer_sync(&umidi->error_timer);
+	timer_shutdown_sync(&umidi->error_timer);
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
--

