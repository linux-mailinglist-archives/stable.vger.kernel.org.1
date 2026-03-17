Return-Path: <stable+bounces-225734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Gy0YL4jCuGlWjAEAu9opvQ
	(envelope-from <stable+bounces-225734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 03:55:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A32A2F60
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 03:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B4D300A61F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFB82BD5BF;
	Tue, 17 Mar 2026 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="zOLlJdde"
X-Original-To: stable@vger.kernel.org
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B583915B998
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715912; cv=none; b=HzRggSpJ00goeAtigMTSXtJ4h1hrK7XArs/W3XV3qNjY7bU2vOzCWPReEY7eLhBnJ9xWSZPz0BoJINgIjSoDSxQwiKzHgVtoqZyQjgXcgIv3CX2xBkcDFyxuj2jOM1IxWfxlU+CUY6Bx6KIo6HFjppC7zYW4fD4GcFu4OFkSIgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715912; c=relaxed/simple;
	bh=jLKL2lKhXfI2/DmOf+pTLkxhLQTj7HGC29A5yiCe/9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BJdNAr1C42CqsEpaqws6wwEBaxKILlRKAleFc+JjLYbN1Go65G4SGfTTiDmaJ/6uikrRkTmKrY+g3VkEOWm1uEIzXp8x/Yr0VE7Jwbp2yPZIq30/IALqwSDfUTFeTDl29EHOLS9HnOb8eNGH4vWvg1LSNW+5G5AQ54Wmpoe/XtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=zOLlJdde; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773715908;
	bh=a3tVYHKGkp+Wt0rEwIghSMoFHSkOFOmADewWudRvcl0=;
	h=From:Subject:Date:Message-Id;
	b=zOLlJddeuV57emwLJjm2Zs+Q+o+qYO4hVppU9MfjifwD4jxGw5l51WKKhhW4+8ThI
	 q181l7VaioLRBZOunJvTqbYD01qMFUEDz/Obo/pAqLOIPirvkdDaMkjBFRe028D8X8
	 rovgyTRJnzdxDK2oLNq9H4dnESR4Mz6ZsK7gVpTA=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.23) with ESMTP
	id 69B8C1B600005749; Tue, 17 Mar 2026 10:51:36 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 9808178913048
X-SMAIL-UIID: A19FBD6092034B8C9D58D69725606AC0-20260317-105136-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1.y] ALSA: usb-audio: Kill timer properly at removal
Date: Tue, 17 Mar 2026 10:51:33 +0800
Message-Id: <20260317025133.554973-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225734-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[sina.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sina.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,syzkaller.appspotmail.com,sina.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,d8f72178ab6783a7daea];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.com:dkim,sina.com:email,sina.com:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: 5C5A32A2F60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
[ The context change is due to the commit 8fa7292fee5c
("treewide: Switch/rename to timer_delete[_sync]()")
in v6.15 which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 sound/usb/midi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index d300cd1f922b..08dd0f0b19a3 100644
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
2.34.1


