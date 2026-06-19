Return-Path: <stable+bounces-267400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j+m0CuNDNWpiqgYAu9opvQ
	(envelope-from <stable+bounces-267400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:28:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3BD6A6114
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:28:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hsbCKW8D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jcAsV996;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hsbCKW8D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jcAsV996;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267400-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267400-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66017303982D
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADD9394E80;
	Fri, 19 Jun 2026 13:27:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD494381B0A
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 13:27:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875660; cv=none; b=lNkHUnYk4Gl+NRw28B3YBWWLqwgMDCSHQbubcLU3kgvpxyv9srYgTvHB6V8W91WH/HlryzEHJHaMl08HJglCUqengNv2PWoQeuXFmMGKefn056PoJLHtd8enAQKPFI6FMBhGXu8kDfa1YsSEo+hZmzJ53tx7hKXff9vAp8Qe5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875660; c=relaxed/simple;
	bh=ty1T2BDf3hJMoXqpkjtpH+7oMOIdThNQ2eurAdbFp2Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfnmqKLV/t9OWhW5HHBSS82tbLbkRCPmn1fuIYovxyYdnZ8z9itGSnezPIHdpmPfLNo377/OhpdW4e8HhMdb4/B30p1qXnL9/OWb8fJOV6hPraljvroOfBHnJxqLYfYFbQoWINfhoPiUUmFPj6QnaKBfc5Do1F50iJHeR5FdTvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hsbCKW8D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jcAsV996; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hsbCKW8D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jcAsV996; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1054875D51;
	Fri, 19 Jun 2026 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781875657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRyLfeX9sXJHktJSeQPbzw+etVyvD+njKQjlfKOE5So=;
	b=hsbCKW8Dk24fM6G321A2c4/+2Lu02enbkrUyCq5SegvdhYa9kZ3tEPBm/6bbfa8ypBjTwo
	LCkAbJsFGVZL8K4gmip0Jq6EfcuMbZnFXhLw4kA0lZorf1I0SATpP+uLmRzMmR5oEGX9oy
	mDRp/GE9cyzB342djhrh+V8tn4AxW9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781875657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRyLfeX9sXJHktJSeQPbzw+etVyvD+njKQjlfKOE5So=;
	b=jcAsV996fZUR6Ggf9VHOmJtSP3SDX5IC4w32xyYm1uuhRTHMzfRp/Y3RNSPW61OCwrV/O1
	xxD9zohT3xr402Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781875657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRyLfeX9sXJHktJSeQPbzw+etVyvD+njKQjlfKOE5So=;
	b=hsbCKW8Dk24fM6G321A2c4/+2Lu02enbkrUyCq5SegvdhYa9kZ3tEPBm/6bbfa8ypBjTwo
	LCkAbJsFGVZL8K4gmip0Jq6EfcuMbZnFXhLw4kA0lZorf1I0SATpP+uLmRzMmR5oEGX9oy
	mDRp/GE9cyzB342djhrh+V8tn4AxW9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781875657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRyLfeX9sXJHktJSeQPbzw+etVyvD+njKQjlfKOE5So=;
	b=jcAsV996fZUR6Ggf9VHOmJtSP3SDX5IC4w32xyYm1uuhRTHMzfRp/Y3RNSPW61OCwrV/O1
	xxD9zohT3xr402Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4C53779A8;
	Fri, 19 Jun 2026 13:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EF3QKshDNWpYXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Jun 2026 13:27:36 +0000
Date: Fri, 19 Jun 2026 15:27:36 +0200
Message-ID: <87tsqyirsn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sean Wang <sean.wang@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mark-yw Chen <mark-yw.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Tomasz Figa <tfiga@chromium.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btmtksdio: fix infinite loop in btmtksdio_txrx_work()
In-Reply-To: <CAGp9LzpBUReZtrTEKgUr-+yvB+3tcs5hw7ziC4WaMRFNa2AYpg@mail.gmail.com>
References: <20260609121329.1262170-1-senozhatsky@chromium.org>
	<CAGp9LzpBUReZtrTEKgUr-+yvB+3tcs5hw7ziC4WaMRFNa2AYpg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,holtmann.org,gmail.com,mediatek.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-267400-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@kernel.org,m:senozhatsky@chromium.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:mark-yw.chen@mediatek.com,m:sean.wang@mediatek.com,m:tfiga@chromium.org,m:linux-bluetooth@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7F3BD6A6114

On Wed, 10 Jun 2026 08:52:31 +0200,
Sean Wang wrote:
> 
> Hi,
> 
> On Tue, Jun 9, 2026 at 7:19 AM Sergey Senozhatsky
> <senozhatsky@chromium.org> wrote:
> >
> > Every once in a while we see a hung btmtksdio_flush() task:
> >
> >  INFO: task kworker/u17:0:189 blocked for more than 122 seconds.
> >  __cancel_work_timer+0x3f4/0x460
> >  cancel_work_sync+0x1c/0x2c
> >  btmtksdio_flush+0x2c/0x40
> >  hci_dev_open_sync+0x10c4/0x2190
> >  [..]
> >
> > It all boils down to incorrect time_is_before_jiffies() usage in
> > btmtksdio_txrx_work().  The btmtksdio_txrx_work() loop is expected
> > to be terminated if running for longer than 5*HZ.  However the
> > timeout check is twisted:  time_is_before_jiffies(old_jiffies + 5*HZ)
> > evaluates to true when old_jiffies + 5*HZ is in the past i.e. when a
> > timeout has occurred.  Using OR with time_is_before_jiffies(txrx_timeout)
> > means that:
> > - before the 5-second timeout: the condition is `int_status || false`,
> >   so it loops as long as there are pending interrupts.
> > - after the 5-second timeout: the condition becomes `int_status || true`,
> >   which is always true.
> >
> > When the loop becomes infinite btmtksdio_txrx_work() loop never
> > terminates and never releases the SDIO host.
> >
> > Fix loop termination condition to actually enforce a 5*HZ timeout.
> >
> > Fixes: 26270bc189ea4 ("Bluetooth: btmtksdio: move interrupt service to work")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  drivers/bluetooth/btmtksdio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> > index 5b0fab7b89b5..c6f80c419e90 100644
> > --- a/drivers/bluetooth/btmtksdio.c
> > +++ b/drivers/bluetooth/btmtksdio.c
> > @@ -620,7 +620,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
> >                         if (btmtksdio_rx_packet(bdev, rx_size) < 0)
> >                                 bdev->hdev->stat.err_rx++;
> >                 }
> > -       } while (int_status || time_is_before_jiffies(txrx_timeout));
> > +       } while (int_status && time_is_after_jiffies(txrx_timeout));
> 
> yes, loop continues only while there is interrupt work and the timeout
> deadline is still in the future

I stumbled on this while backporting to distro kernels, and I wonder
whether this change is correct.

IIUC, this essentially makes the loop exiting right after the first
cycle; the patch changed from time_is_before_jiffies() to *_after_*(),
not only the logical OR to AND, and *_after_*() returns false, so the
whole condition becomes false, too.


thanks,

Takashi

