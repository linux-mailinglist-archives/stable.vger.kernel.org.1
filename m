Return-Path: <stable+bounces-144504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E958AB838D
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710BA9E26E9
	for <lists+stable@lfdr.de>; Thu, 15 May 2025 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B36D296730;
	Thu, 15 May 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="smofWUw8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="caGiSVai";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GEoAtc9I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fupIJS6c"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6E284662
	for <stable@vger.kernel.org>; Thu, 15 May 2025 10:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303807; cv=none; b=TEFHdDoY0dVX1zxHCqzTsT2yppsO6SMZ1AmZo0I5des9o9Ai4JbCUTOQSQ2iVpHrlt1TWCN3CY0UIQcTDVlJH8CTwtOgzIpUHZagPBfRhQepj+duXk51sO1Q7y1IRTq3rqkysNA7r/VUOoZ9q2WUvpL7sddWEJ8ltPPRmlp2LpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303807; c=relaxed/simple;
	bh=fISSAn1u3Jt054A4poDiekIMdTl7D9WBxeFMhleCtiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg0KkZD+UmogXDNwHnnQ5LSGX9dsB6YTV0+NgZHQZVY0uO7OWlc8eGjj8qgVQvNFEQFTzXM4Em77j1FdDRp7HTx0EdbRfzR2a2ykDI4czJgbNC0O3pPcNPJhdN2agNIqxKR9Mst8jDMkOwVdgIi3t0dK8mliLoXSqv6TCMuO6Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=smofWUw8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=caGiSVai; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GEoAtc9I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fupIJS6c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ECA81F387;
	Thu, 15 May 2025 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747303803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwfRDpu5DIc29EVdkIkyL3zQAveuT1WFPU1eV24iLms=;
	b=smofWUw8kXHfacpV2w0f5x9BzXzJmUgkbAm/wIDPKdVJdZSno9lxRYvF0GFv/ALhYlnbxr
	AqNQkAzqVPzrpNqQiAUUndndIq6VOyzJqB0XPwoDl6XeA65EGcILr8Ai2hkQuFH8vBMjNq
	l4A5bmScQ1pVJpYXcL9HnSQMz99hXCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747303803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwfRDpu5DIc29EVdkIkyL3zQAveuT1WFPU1eV24iLms=;
	b=caGiSVai6ApoxBuDTbFsxGWoXDn4D4AzG+laQrBIXQmDhLdlcouV0KglxfRPLZcEiC+IsG
	J1zTGd0mnePFItDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GEoAtc9I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fupIJS6c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747303802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwfRDpu5DIc29EVdkIkyL3zQAveuT1WFPU1eV24iLms=;
	b=GEoAtc9IRR9pkrfZErZpbdcQfHtK9iE+Mf5nGjTsBUFRDyHokU8oJO4K9LBEJbMesswO/x
	Z/9CCkYUAlHzVQaLAzhSqcNoktePgaPyEDLzM85Tia76WBs/kOZPQuo98HyFxZRcNHGqJa
	BdEkbL1HTFzHzk5TuM9ArGveUIFxd3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747303802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwfRDpu5DIc29EVdkIkyL3zQAveuT1WFPU1eV24iLms=;
	b=fupIJS6cy5DcTr/LIX8zCnFomaA7FRsnUB4ipiSYDgmK0gGOd8h0Op3KUMRaj3Xh+weVyM
	sAi5CkbiR9yGbbCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C0D1137E8;
	Thu, 15 May 2025 10:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zv1IDnq9JWhEXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 May 2025 10:10:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8D41A08CF; Thu, 15 May 2025 12:10:01 +0200 (CEST)
Date: Thu, 15 May 2025 12:10:01 +0200
From: Jan Kara <jack@suse.cz>
To: Kitotavrik <kitotavrik.s@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Josef Bacik <josef@toxicpanda.com>, NeilBrown <neilb@suse.de>, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org, 
	Andrey Kriulin <kitotavrik.media@gmail.com>
Subject: Re: [PATCH v2] fs: minix: Fix handling of corrupted directories
Message-ID: <6hlyjsiwu5idkqbauvn7ruyztdc5wgkdtkiljk3ncfqfeaanf2@uinqsk54ehww>
References: <20250514103837.27152-1-kitotavrik.s@gmail.com>
 <s5pju6jp2k4ddyuuz2xydeys5lhashkbvwa2lmtw3dmtedupw5@sjdrgnhwsvza>
 <CAJFzNq55Vg8TDVPpDbJVs9bVTJP9KL5i3h6jL0zY57UyGC4xWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJFzNq55Vg8TDVPpDbJVs9bVTJP9KL5i3h6jL0zY57UyGC4xWA@mail.gmail.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4ECA81F387
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,infradead.org,toxicpanda.com,suse.de,vger.kernel.org,linuxtesting.org,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action

On Wed 14-05-25 22:13:24, Kitotavrik wrote:
> >  guess the easiest is to fudge i_nlinks count in memory to 2 to
> > avoid issues...
> 
> But if a subdirectory was in the corrupted directory(nlinks= 3), it
> will be replaced with nlinks 2. And after deleting subdirectory,
> nlinks was 1 and the problem will remain. Maybe should return EUCLEAN,
> regardless of the mounting mode.

Well, that does not help. You can also corrupt the directory link count so
that it is lower than the number of subdirectories. Then as you delete
subdirectories the parent directory link count is going to get invalid. So
at the places where you decrement parent directory link count (rename,
rmdir) you should check whether the link count doesn't drop below expected
minimum and abort the operation (and print error) if it would.

								Honza

> 
> 
> ср, 14 мая 2025 г. в 18:54, Jan Kara <jack@suse.cz>:
> >
> > On Wed 14-05-25 13:38:35, Andrey Kriulin wrote:
> > > If the directory is corrupted and the number of nlinks is less than 2
> > > (valid nlinks have at least 2), then when the directory is deleted, the
> > > minix_rmdir will try to reduce the nlinks(unsigned int) to a negative
> > > value.
> > >
> > > Make nlinks validity check for directory.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> > >
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Andrey Kriulin <kitotavrik.media@gmail.com>
> > > Signed-off-by: Andrey Kriulin <kitotavrik.s@gmail.com>
> > > ---
> > > v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
> > > <jack@suse.cz> request. Change return error code to EUCLEAN. Don't block
> > > directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.
> > >
> > >  fs/minix/inode.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> > > index f007e389d5d2..d815397b8b0d 100644
> > > --- a/fs/minix/inode.c
> > > +++ b/fs/minix/inode.c
> > > @@ -517,6 +517,14 @@ static struct inode *V1_minix_iget(struct inode *inode)
> > >               iget_failed(inode);
> > >               return ERR_PTR(-ESTALE);
> > >       }
> > > +     if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks < 2) {
> > > +             printk("MINIX-fs: inode directory with corrupted number of links");
> >
> > A message like this is rather useless because it shows nothing either about
> > the inode or the link count or the filesystem where this happened. I'd
> > either improve or delete it.
> >
> > > +             if (!sb_rdonly(inode->i_sb)) {
> > > +                     brelse(bh);
> > > +                     iget_failed(inode);
> > > +                     return ERR_PTR(-EUCLEAN);
> > > +             }
> >
> > OK, but when the inode is cached in memory with the wrong link count and
> > then the filesystem is remounted read-write, you will get the same problem
> > as before? I guess the easiest is to fudge i_nlinks count in memory to 2 to
> > avoid issues...
> >
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

