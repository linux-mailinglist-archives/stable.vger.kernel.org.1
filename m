Return-Path: <stable+bounces-258088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFbrDhMkG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:53:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7E2610942
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A251F30120DB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDB2261B9E;
	Sat, 30 May 2026 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Td4qn//T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DB351C2F;
	Sat, 30 May 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163180; cv=none; b=GPm602ytGp19yIrToSo1e9u7puqcyLSqcM0apKWL0R8N/5ccYqVikpaXbedWo/EgmolzFZqe7fuJ+6AIHH9XhdjGL6Dh7h3xZcayj7VnWk6njVxjOiTdMFGhMtZiIHjvcXmnujkIyhiszhLWVzW77HbmdCheGPdoB4dhWsrr4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163180; c=relaxed/simple;
	bh=ft2OHsOUCAx8YnT8l3YVbTLmP40aRlm/a9DDl4bVSyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D63eoWgwtKY50OCThBLmgseoNwNJM3STuz59zQFAH995x5nYhW+66tRnLLCZf6AbgX9GO5RlMiLEPz+/RCyVQatIeCskhqnT06bUdWtPWdaSh2kLzDl8xb5z4yKdTXDfXM1/5E/jJWNgnyWp/Cm2yiJ/pmhugXsEozoOMrwPlVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Td4qn//T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3171F00893;
	Sat, 30 May 2026 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163179;
	bh=sqyhx11KLmW71fOa9ZAQkbdFFZDOmT18C5hOU10EXl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Td4qn//T2IGiLOioE14zVTl20un5X/QSzY7SLReKm5RoCU+tZfZWTJY/YomM+W4g2
	 0WcZsb7gznJgd5X1an42qJMdUu3vMZbGZICot1XeHCEzxeerN7KX3mUePCOtliocz/
	 dGbWpIh5qQg24jjUzDZyTq3LOoJZRYMH2Yulq8YQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 180/776] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Sat, 30 May 2026 17:58:14 +0200
Message-ID: <20260530160245.149166489@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258088-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,suse.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f02665daa2abeef4a947];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9E7E2610942
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeongjun Park <aha310510@gmail.com>

commit 9f2c0ac1423d5f267e7f1d1940780fc764b0fee3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/midi.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,15 +1522,14 @@ static void snd_usbmidi_free(struct snd_
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
 



