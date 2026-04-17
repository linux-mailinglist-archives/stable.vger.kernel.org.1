Return-Path: <stable+bounces-238463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DtgiFEL04WnT0AAAu9opvQ
	(envelope-from <stable+bounces-238463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:50:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CF5418EF9
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6534431A2111
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244F03A874B;
	Fri, 17 Apr 2026 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LsstIir4"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB9361666;
	Fri, 17 Apr 2026 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415621; cv=none; b=GRlMgzVFnk+wjHJAMfc8P7UATqCXunq1zXAGt25O71iFomk0uJHb6t085QOm8jX/rnWprVjMdT5NS7VkPxE/4Fb2dotFhEAV6eVtQWMD4cmeyLtFyER3PJKQDSMyl64yGEK3Y9lnabarXwwj+pzA009NhFtSFPZT3nLaBDBL/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415621; c=relaxed/simple;
	bh=hoj3av86AEwW1BUzFJVRqssu+g5t+RxGVQxSwimnPBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgzO8d1u9Y6cJX7a9pIQRVQLI+PXe9tw2Wv2OxnmZlJaewG9p9iMjDaZCUFeUlhwLy9D4uhQQcgzfVUOE4unGKbsUbDmkS1Z6CZ1R83J2QfuK1GH4MDXLH3eol5Zz8DDBamNoeGDTjnw3lGGDP1lpgzmpaWkFeIqE246Mo8vAC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LsstIir4; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Wo
	0sU+HVuKmgK7HP/NjTY8OJzuaCuJtGr3cAzg9x+18=; b=LsstIir4p8Et1tfp6b
	me4t0KrgLcCaftdkqTkVSTKnmnJTn/lu0qTLeC0sGHk4CKtBQxt1F4XReHaCHkui
	qnQ0Zg+UpQqJgnidb3B0ORIN4ULJYe4Q0740ruJ7bIlwh5aQ3W7+O+gpxN2MAQKo
	spfla1Yn5uNVWcPpAwdW3v4B8=
Received: from China-163-team (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDH78My8+FpIMWAAQ--.106S2;
	Fri, 17 Apr 2026 16:45:51 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-sound@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Fri, 17 Apr 2026 16:45:16 +0800
Message-ID: <20260417084516.464-1-jetlan9@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDH78My8+FpIMWAAQ--.106S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFy3Xr1DZrWrGr13Jw48Crg_yoW8Cr43pF
	Z3Gr9xKrWrtrZ0y3y8tF1kZ3WkJan5Ka4DW3y7Wwn09F17J3Wxtw10yFWvgF47CFySga4a
	vrnFva1aq348K3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEyv3nUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCxADfqGnh80DhlQAA38
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com,suse.de,163.com];
	TAGGED_FROM(0.00)[bounces-238463-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,f02665daa2abeef4a947];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86CF5418EF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 sound/usb/midi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 08dd0f0b19a3..49a11e517e78 100644
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
2.43.0


