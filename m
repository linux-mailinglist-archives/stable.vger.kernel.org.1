Return-Path: <stable+bounces-181811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F3BA5C98
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 11:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F821B22755
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 09:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7E42D6E4B;
	Sat, 27 Sep 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NS2EjH+/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JOtPgCQ2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RSFSAqvG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SP7KW+Jv"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11397221FA0
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965947; cv=none; b=S//Sxxi73PM6MpR+1QtoDGSB9pq4+QZiOgJ9vYp/gRfvHO+GR+37DAn30lUqrzcb2dYtk4YAxDjhuGkID+9/SDb6o6uh0sRsHJiapLTCfn4KRLyuByFpxWD2ZPwsImKzX2N2ScnocCuupLJfPNUFn7tI+fSCL15iD4aOYarnzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965947; c=relaxed/simple;
	bh=ePwxy0VtePa8dkCZfHHQ0ZXHpxKb70EtWVouu2g/AH0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGe+Z247UsR+LWTBpw2V87OZgX8FE/fXUXoJusRZk5tstz/ebqAHqUZUNDgiIIC3xfnlnYg+boXwhfoGu8NEJPYHNJAGlI795FOocYZyYjVOWh1qCZjAjx9waeK+3T2wUfZV/sxv8vX8n5FVV905g3483fypL9rEw7Fn4V/8u94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NS2EjH+/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JOtPgCQ2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RSFSAqvG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SP7KW+Jv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B9B113E6ED;
	Sat, 27 Sep 2025 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758965943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84FaBtmFvZd+sdNdHLG3vlLvA5/4a6ErkNpX/PoLn1Q=;
	b=NS2EjH+/WhpmjpumKPiZlbpj7zNGm3vR4OPDP5YUb4R1KVDmYFfY3YgMBTrjuW5x0GDI7X
	GdrtLvOynoPUqDRMi3JEfrtorB4P0oLIqPnxTuo0f1OYqUKNTxNBiKgHSh2rpTTQ80D+Q2
	kKGLP1G/7Y4tnIudKX2OwVNyoM6bPU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758965943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84FaBtmFvZd+sdNdHLG3vlLvA5/4a6ErkNpX/PoLn1Q=;
	b=JOtPgCQ2rqQy4k62PA1TcVTjAjHMxTjz4kNZFEGEKQ/NvLHbXj0vTqxe7IU4Aob8Ez3NFS
	siEXj6WqQnfyjuDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RSFSAqvG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SP7KW+Jv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758965942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84FaBtmFvZd+sdNdHLG3vlLvA5/4a6ErkNpX/PoLn1Q=;
	b=RSFSAqvGQSHnaXB2Bg5GeMvsPTRSPh/SxIG2FevMc+vuWecK87YD5ahv1/uTVKiK664Ckl
	3JyfeAhwgc8xZyBsJaETiwdf2FIFhmjMLdC1jQuYZwtgk5upnMRz3BDm++9D4bn4RgxD3J
	Io78f6tz/y91lJozAw8xYdQnLivVsVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758965942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84FaBtmFvZd+sdNdHLG3vlLvA5/4a6ErkNpX/PoLn1Q=;
	b=SP7KW+Jv6PI11c9s3QYX0BQXa5uxYzRUaBCZNvktx2UcJ2TO1A1jXSr3YkViVMgoT7WyWe
	ty38X4Z7nw2L6XCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 768CE1373E;
	Sat, 27 Sep 2025 09:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uR8TG7aw12h9TQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 09:39:02 +0000
Date: Sat, 27 Sep 2025 11:39:02 +0200
Message-ID: <87zfag9qvd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
In-Reply-To: <CAO9qdTHSu6QmUVMo0pZj_=foz9CDtwKEYwjBx5vjj8gHzzVFNQ@mail.gmail.com>
References: <20250927044106.849247-1-aha310510@gmail.com>
	<87bjmwb9y6.wl-tiwai@suse.de>
	<CAO9qdTHSu6QmUVMo0pZj_=foz9CDtwKEYwjBx5vjj8gHzzVFNQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B9B113E6ED
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Spam-Score: -3.51

On Sat, 27 Sep 2025 10:48:02 +0200,
Jeongjun Park wrote:
> 
> Hi,
> 
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Sat, 27 Sep 2025 06:41:06 +0200,
> > Jeongjun Park wrote:
> > >
> > > The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
> > > removal") patched a UAF issue caused by the error timer.
> > >
> > > However, because the error timer kill added in this patch occurs after the
> > > endpoint delete, a race condition to UAF still occurs, albeit rarely.
> > >
> > > Therefore, to prevent this, the error timer must be killed before freeing
> > > the heap memory.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
> > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> >
> > I suppose it's a fix for the recent syzbot reports?
> >   https://lore.kernel.org/68d17f44.050a0220.13cd81.05b7.GAE@google.com
> >   https://lore.kernel.org/68d38327.a70a0220.1b52b.02be.GAE@google.com
> >
> 
> Oh, I didn't know it was already reported on syzbot.
> 
> > I had the very same fix in mind, as posted in
> >   https://lore.kernel.org/87plbhn16a.wl-tiwai@suse.de
> > so I'll happily apply if that's the case (and it was verified to
> > work).  I'm just back from vacation and trying to catch up things.
> >
> 
> Although it's difficult to disclose right now, I have already completed
> writing a PoC that triggers a UAF due to the error timer in a slightly
> different way than the backtrace reported to syzbot, and I have confirmed
> that no bugs occur when testing this patch through this PoC.

OK, so this sounds like a coincidence, but it's very likely the same
issue, so I'm going to put mark those syzbot reports.


thanks,

Takashi

