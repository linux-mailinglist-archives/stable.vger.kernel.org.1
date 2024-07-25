Return-Path: <stable+bounces-61771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3593C701
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 18:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B4AE2814A1
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8EF19D095;
	Thu, 25 Jul 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ukQ8CSy+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LUaM8yiR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ukQ8CSy+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LUaM8yiR"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C319D07C
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923868; cv=none; b=bZlxwtuZhAdXLEW+AVpZjdNiNVbm6BjIMfV757ao0fJpgV3OqFJQBjc6N7Ks5RMA83Ky/czSc4E/wnVzWE5IqOfHu8vN8awMT9r8Jx9ixeSiNDrovqFbjeLvwtYZCeiGtCjM/crelGCf8vwDYv6U2vG90Zo7mUy4Px4crwF6/zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923868; c=relaxed/simple;
	bh=d/jhwZFwwjtKINW6Mu/4UJv5gqONcnrtOBXyeMZ8BOo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5isImyWAFaSPa2nZArXvTLw9+DbaOLsd+mwWKsmiZ9X4fVHuJ853BIGM9Aann05oLmIZx2X0dbE8b9sEAJ/WRq9Lw5yiA0CK7Wesq61JngaT93lrcMn/It9/vCblc8CZDGRKuI7BLmdvJX4n09JSLbQiHi2gQZ0ayPA1vFMfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ukQ8CSy+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LUaM8yiR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ukQ8CSy+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LUaM8yiR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76B4F1F7F1;
	Thu, 25 Jul 2024 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721923864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1UUImcYcUIfX/uQ5fz5pcoFaa9SfghJBU5p+2NwQQE=;
	b=ukQ8CSy+ggE4NZMfOecZfdvHV6DOoJvtF/SPvl84V5kZn518UN+MJtregXJAyX5dUNYVVx
	pX6b3IjirkMd7dj6bwAqUS1XbKToGxtZ6P+HuKd77+jSGqZeZGVDwHmXozmPIKB8KYRu2U
	P9Ubr+IBuRp5k+GmhT/8WRqNMTrWwvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721923864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1UUImcYcUIfX/uQ5fz5pcoFaa9SfghJBU5p+2NwQQE=;
	b=LUaM8yiR4ZkweHKsnVx1s9zZiQ3SxXqLGLuEdsDOgPRulGcHcXD5kLI8uW+HN2nszrj+I1
	5pTGHkXw294MOdDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ukQ8CSy+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LUaM8yiR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721923864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1UUImcYcUIfX/uQ5fz5pcoFaa9SfghJBU5p+2NwQQE=;
	b=ukQ8CSy+ggE4NZMfOecZfdvHV6DOoJvtF/SPvl84V5kZn518UN+MJtregXJAyX5dUNYVVx
	pX6b3IjirkMd7dj6bwAqUS1XbKToGxtZ6P+HuKd77+jSGqZeZGVDwHmXozmPIKB8KYRu2U
	P9Ubr+IBuRp5k+GmhT/8WRqNMTrWwvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721923864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U1UUImcYcUIfX/uQ5fz5pcoFaa9SfghJBU5p+2NwQQE=;
	b=LUaM8yiR4ZkweHKsnVx1s9zZiQ3SxXqLGLuEdsDOgPRulGcHcXD5kLI8uW+HN2nszrj+I1
	5pTGHkXw294MOdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43EFF1368A;
	Thu, 25 Jul 2024 16:11:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SAFzDxh5omavNQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jul 2024 16:11:04 +0000
Date: Thu, 25 Jul 2024 18:11:38 +0200
Message-ID: <877cd9ih8l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	tiwai@suse.de,
	stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>
Subject: Re: [PATCH] ALSA: firewire-lib: fix wrong value as length of header for CIP_NO_HEADER case
In-Reply-To: <94600ca4-47ce-4993-b6ce-dabb93ef01dc@embeddedor.com>
References: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
	<94600ca4-47ce-4993-b6ce-dabb93ef01dc@embeddedor.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 76B4F1F7F1
X-Spam-Score: -3.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]

On Thu, 25 Jul 2024 18:08:21 +0200,
Gustavo A. R. Silva wrote:
> 
> 
> 
> On 25/07/24 09:56, Takashi Sakamoto wrote:
> > In a commit 1d717123bb1a ("ALSA: firewire-lib: Avoid
> > -Wflex-array-member-not-at-end warning"), DEFINE_FLEX() macro was used to
> > handle variable length of array for header field in struct fw_iso_packet
> > structure. The usage of macro has a side effect that the designated
> > initializer assigns the count of array to the given field. Therefore
> > CIP_HEADER_QUADLETS (=2) is assigned to struct fw_iso_packet.header,
> > while the original designated initializer assigns zero to all fields.
> > 
> > With CIP_NO_HEADER flag, the change causes invalid length of header in
> > isochronous packet for 1394 OHCI IT context. This bug affects all of
> > devices supported by ALSA fireface driver; RME Fireface 400, 800, UCX, UFX,
> > and 802.
> > 
> > This commit fixes the bug by replacing it with the alternative version of
> > macro which corresponds no initializer.
> 
> This change is incomplete. The patch I mention here[1] should also be applied.

Yes, but this can be fixed by another patch, right?
At least the regression introduced by the given commit can be fixed by
that.  The other fix can go through Sakamoto-san's firewire tree
individually.


thanks,

Takashi

> BTW, there is one more line that should probably be changed in `struct fw_iso_packet`
> to avoid further confusions:
> 
> -       u16 payload_length;     /* Length of indirect payload           */
> +       u16 payload_length;     /* Size of indirect payload             */
> 
> Thanks
> --
> Gustavo
> 
> [1] https://lore.kernel.org/linux-sound/dabb394e-6c85-45a0-bc06-7a45262a9a8c@embeddedor.com/T/#m0b9b0e7dd4561dc58422cf15df2dbd2ddb44b54b
> 
> > 
> > Cc: <stable@vger.kernel.org>
> > Fixes: 1d717123bb1a ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning")
> > Reported-by: Edmund Raile <edmund.raile@proton.me>
> > Closes: https://lore.kernel.org/r/rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2/
> > Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > ---
> >   sound/firewire/amdtp-stream.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
> > index d35d0a420ee0..1a163bbcabd7 100644
> > --- a/sound/firewire/amdtp-stream.c
> > +++ b/sound/firewire/amdtp-stream.c
> > @@ -1180,8 +1180,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
> >   		(void)fw_card_read_cycle_time(fw_parent_device(s->unit)->card, &curr_cycle_time);
> >     	for (i = 0; i < packets; ++i) {
> > -		DEFINE_FLEX(struct fw_iso_packet, template, header,
> > -			    header_length, CIP_HEADER_QUADLETS);
> > +		DEFINE_RAW_FLEX(struct fw_iso_packet, template, header, CIP_HEADER_QUADLETS);
> >   		bool sched_irq = false;
> >     		build_it_pkt_header(s, desc->cycle, template,
> > pkt_header_length,

