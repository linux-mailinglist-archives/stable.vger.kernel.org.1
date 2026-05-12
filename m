Return-Path: <stable+bounces-246134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAxfN8FsA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:09:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A13526E38
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23E73302260C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088983C09EC;
	Tue, 12 May 2026 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ozySrK1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDB3BB105;
	Tue, 12 May 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608445; cv=none; b=bn5+VH8abjtFwwUmAhamRa0Bz7zJ33IaIlr/hI0g3hmIIh/Ysp4Qax4Ug33ZMjfV3h6h97jKcVCRUcnmxzFKT60ldK0sneZbFxLeEvst9zDvqgv1AsPD3zhOeBg/c9lborIZpe0ksPhA12+3XfohqcOrubuFrpVoDtF89/Lju6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608445; c=relaxed/simple;
	bh=svGy/UeIx248HOt2+DfIBZkKm4H4g2D863hd4w042So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=De1b2jENn0RF+rvQUFQoOPL+XzYILrFo7ni4VY2oUFmN6MQCyso8PUbpf2kAxsFay4OqTeDHQMMhsMrvU7qYxOKAvHjRLR3uyp4otGmThkPlWXlUE1ZLesslce0akUKTivup4D1s5e50pQScb/Oehb5UNgVd+qlIgIOH71dxQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ozySrK1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D82C2BCB0;
	Tue, 12 May 2026 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608445;
	bh=svGy/UeIx248HOt2+DfIBZkKm4H4g2D863hd4w042So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ozySrK1BQ9aBTWbjFkcrROkPEobgNuuRmPh/U6Dc/Nw7WaJ0s7RNVGYBvYT/X+D37
	 1ANdWqTw3Bg1M3dLgzE5VmP58VO8UKCxR7WSOjP3kTwoKokn7KRIo9mgMVn9oLtJyf
	 H17FEh43mFjlwOevQBFHjodoypIhGwTLoH0bDbc4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.18 040/270] ALSA: usb-audio: midi2: Restart output URBs on resume
Date: Tue, 12 May 2026 19:37:21 +0200
Message-ID: <20260512173939.299028451@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08A13526E38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246134-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

commit f3c57c9c2a49a21d784b7c04a2c883bffc070659 upstream.

USB MIDI 2.0 suspend saves the endpoint running state, clears it and
kills all endpoint URBs. Resume restores the running state, but only
restarts input endpoints.

For a running output endpoint, this leaves the endpoint marked running
with an empty URB queue. Output transfer progress depends on either the
rawmidi trigger path starting the queue or an output completion refilling
it. After suspend there is no completion left, and output data that
remains queued in the raw UMP or legacy rawmidi buffer can stay stalled
until userspace happens to trigger the stream again.

Restore the saved state with atomic accessors, keep input endpoints
restarted as before, and restart output endpoints that were running before
suspend. Clear the saved suspend state after restoring it.

Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Link: https://patch.msgid.link/20260504-usb-midi2-output-resume-v1-1-c089cc8ad3c6@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/midi2.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -227,7 +227,7 @@ static void kill_midi_urbs(struct snd_us
 	if (!ep)
 		return;
 	if (suspending)
-		ep->suspended = ep->running;
+		atomic_set(&ep->suspended, atomic_read(&ep->running));
 	atomic_set(&ep->running, 0);
 	for (i = 0; i < ep->num_urbs; i++) {
 		if (!ep->urbs[i].urb)
@@ -1190,10 +1190,11 @@ void snd_usb_midi_v2_suspend_all(struct
 
 static void resume_midi2_endpoint(struct snd_usb_midi2_endpoint *ep)
 {
-	ep->running = ep->suspended;
-	if (ep->direction == STR_IN)
+	atomic_set(&ep->running, atomic_read(&ep->suspended));
+	atomic_set(&ep->suspended, 0);
+
+	if (ep->direction == STR_IN || atomic_read(&ep->running))
 		submit_io_urbs(ep);
-	/* FIXME: does it all? */
 }
 
 void snd_usb_midi_v2_resume_all(struct snd_usb_audio *chip)



