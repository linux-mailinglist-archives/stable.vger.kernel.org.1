Return-Path: <stable+bounces-229844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFhZNhx+wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:53:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5582FA8FA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FE3130CB8D6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6AD3BD62F;
	Mon, 23 Mar 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NWLAze9G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58B3BA25B;
	Mon, 23 Mar 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283017; cv=none; b=rxtyRN6AdUg8fEKkIPqypRmcf6oHEum2e9d5lFvL3mENu27fxjJmzWWBT1n9e7iSGdi/a767sqvjReauhiLK5fkwWTDadAl9V5Dc2Vp1HNDLAoABawQTttr6aNyCBrqwS7enHynBvg2uN2iIHDf5oE7IlkenXCldQGZyU/v7JPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283017; c=relaxed/simple;
	bh=3Wxt6kfKzww9bmaR0kdr4Iu5ZYsG7cKK2MN/hxNVgoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLyhaGRL9hNRv2/7qepGn6xrTNXcHZzBpmVViTZeDeHQndxJl/T0b3MQimwkYcwEGfbJ2/Qg6+PQqzTJdjnxt+Sfo8DpAuaGyMduYihj8ZHtve4y4LJt4FK6On2cMe3U5thNjlZ1tnrUIpLe77QdC126oDQgtlGr1dn8Zb5IX0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NWLAze9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48086C4CEF7;
	Mon, 23 Mar 2026 16:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283017;
	bh=3Wxt6kfKzww9bmaR0kdr4Iu5ZYsG7cKK2MN/hxNVgoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NWLAze9GjRM1YjSNDveOjqqpqYDLzoZmGN/rf23ydpQmD5+0vENwd1im/ZhYXN9n2
	 7L+7AMfFFX5yyZHgvMAAMMlYCOdMo29cZqy53h8jmjI9aesQm2V0jGd5FnStTf1UlP
	 /ZJZX4mP6/0+/CQxFaWdtUQ3UeIQBBGj0kd7AQt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com,
	Takashi Iwai <tiwai@suse.de>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 6.1 369/481] ALSA: usb-audio: Kill timer properly at removal
Date: Mon, 23 Mar 2026 14:45:51 +0100
Message-ID: <20260323134534.120863417@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-229844-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,suse.de,sina.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,d8f72178ab6783a7daea];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,appspotmail.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,suse.de:email,sina.com:email]
X-Rspamd-Queue-Id: 3C5582FA8FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/midi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1530,6 +1530,7 @@ static void snd_usbmidi_free(struct snd_
 			snd_usbmidi_in_endpoint_delete(ep->in);
 	}
 	mutex_destroy(&umidi->mutex);
+	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
@@ -1553,7 +1554,7 @@ void snd_usbmidi_disconnect(struct list_
 	spin_unlock_irq(&umidi->disc_lock);
 	up_write(&umidi->disc_rwsem);
 
-	del_timer_sync(&umidi->error_timer);
+	timer_shutdown_sync(&umidi->error_timer);
 
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];



