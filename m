Return-Path: <stable+bounces-225743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOfPLTztuGknlwEAu9opvQ
	(envelope-from <stable+bounces-225743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:57:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA122A4280
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 06:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 870483023A73
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA91437FF60;
	Tue, 17 Mar 2026 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="exFK9pDg"
X-Original-To: stable@vger.kernel.org
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EEA330D24
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773726987; cv=none; b=sZH2IOUMkceFmPlb6JXu7AZ/BOT0cpgZtEQEKRnqHm1X0+/v4gkCybQT7+w5FQxE9zgkeegp0i5tGPwITqV5Mn/mTZ4EriVBpbPU7vP4g6eG29F2VihWJwj21ysvvhoXKL4NLjJnYHTsrWrq+CtCrhM2p8gnB3OqQnObvkN/esI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773726987; c=relaxed/simple;
	bh=m5hRpstAhLzD7IdCLDe2omPzSiOPFVQcFychh771G/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oiL/J+tvXAka4MwSKWRvUDxziJvE31hM9DwEZMhftgO2Z10QunSjIjz4i9u8b6YyTQnaDcLkVkFIWXJ/jMihCt79ZIMlDwrhE+OIfHD6iYeQC2vnyVD8829NI2wFKpDA2Gd6gfEzkkE+xNORa5uT80MmqLdNY+Pgzdyr1JK+g4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=exFK9pDg; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1773726982;
	bh=iFmfJiTQvAlM2r3FEyEidXEE7a1oeH2iEnZ701ze8ew=;
	h=From:Subject:Date:Message-Id;
	b=exFK9pDgiNsFDHVdGRXG2cU/AmJCVs3cmhR5ZB8trGMC5JsaRMoZsTg5yS5hIJrqY
	 pjBGUGIZCXUMk0aHAMxQVi5Z3lMldX1sdcuRldqKTRRS2HV+vCuTJyOi14YWbpJyw+
	 yqRaiiNI5E0D+f5L9MHQpCSTCUMVawclrm52ltzc=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.24) with ESMTP
	id 69B8ECFA00000461; Tue, 17 Mar 2026 13:56:12 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 89518510748276
X-SMAIL-UIID: 0C247DF6E08C4D0392A3DB3210FF5354-20260317-135612-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] ALSA: usb-audio: Kill timer properly at removal
Date: Tue, 17 Mar 2026 13:56:04 +0800
Message-Id: <20260317055604.669076-1-johnny_haocn@sina.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225743-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,d8f72178ab6783a7daea];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sina.com:dkim,sina.com:email,sina.com:mid,suse.de:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 0DA122A4280
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
index c6586da43a04..932ad94575e5 100644
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


