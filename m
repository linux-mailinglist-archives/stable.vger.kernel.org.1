Return-Path: <stable+bounces-37857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD59889D718
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA7A28638A
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A0F1EB46;
	Tue,  9 Apr 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cS39/ljx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IooIRLhT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="In64Oyrx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="814UwSI4"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7C77F47E
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 10:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658987; cv=none; b=Xdqy/oFGDXwzru9av5SRGQepN3Vey5abWS0yAf7/0F8fX6Ir/K8trG3s7lyrixwwQRkAi4+Xi53LRtHgn+oVeAW6ugD+iMvVY/0yjt0F7AcShnpReYkZyYmEXjd2d+grLKy+n86JWXbK/XRppIFfTuAR99qh42yRbs3+FXt/qsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658987; c=relaxed/simple;
	bh=clZSYCm8yXjhSe/lZxlEFYTsVgJZsBuEBgajoRImvtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gd6NdQ+Bi8/9MbOWlv9/Z2tBz3fmNTUnNMbYqzGxtPSF4J4wRZ9DTIHbO8bRw69wqHyyB3uKnAuFvfzj5jS1NIBpahwytcbXk/HKHAzV2LXWiJ11OYwYPWJewS9IrHZFdCrhQVLlSQ4l0P/QzpU0wTx0+3KrGgtk1YDggvBGBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cS39/ljx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IooIRLhT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=In64Oyrx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=814UwSI4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E8DD420927;
	Tue,  9 Apr 2024 10:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712658983;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNz315dAJsBY0YA8qRy+0csxXa2onvzGzH++1Aawdpg=;
	b=cS39/ljxvJ8zWcgDnlVndRNktsDau24qbWNcTG73VnBWRZQ0JuRCdMIV8G8c9LAI0YL8V8
	NbUZ8DdlfP4J57NYu4Fz/16zrmcWpKC0RHAWYdHHkp+vN6OhnRLN5/z8ssx/ZiUZdowg5c
	5cVmTozODZHjTLCZ4T3kDWOJr41FPrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712658983;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNz315dAJsBY0YA8qRy+0csxXa2onvzGzH++1Aawdpg=;
	b=IooIRLhTJXroRMD94hjqcFkiemn88gaSjf/LU8rW7RimV/rUfr2/8WAMasTfnnPR1rKLna
	obigvZViLnWr3jBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712658982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNz315dAJsBY0YA8qRy+0csxXa2onvzGzH++1Aawdpg=;
	b=In64Oyrx8rX1KH5u8laLFOb/D/ZMzBUDza5s3Sw9wlTPCjsFLPGTcEmCS1VZysiVUa9cGM
	5xg4eRd2ZVK2GtVYU+F0iCszdMRnZz1EF9sbUZsaDtXo5wUZKPd/1PF1emGoVLiXsHnaEX
	N4qlc+shclSUehsAU1JWgnwa9zFqB7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712658982;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNz315dAJsBY0YA8qRy+0csxXa2onvzGzH++1Aawdpg=;
	b=814UwSI4+ZCC+5snx1K0jl8zr9va87//PTO5TFm2w7CF21j1codM7XFop/9oVHE1+ptqLS
	u9U3yqA+7kH9whCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BF4FE13253;
	Tue,  9 Apr 2024 10:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZYNQLSYaFWajVQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Tue, 09 Apr 2024 10:36:22 +0000
Date: Tue, 9 Apr 2024 12:36:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 5.15 463/690] nfsd: fix net-namespace logic in
 __nfsd_file_cache_purge
Message-ID: <20240409103621.GA110810@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240408125359.506372836@linuxfoundation.org>
 <20240408125416.405210374@linuxfoundation.org>
 <20240409064222.GA83048@pevik>
 <2024040933-patio-impotent-7a0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040933-patio-impotent-7a0a@gregkh>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,oracle.com:email,suse.cz:replyto,suse.cz:email];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -3.50
X-Spam-Flag: NO

> On Tue, Apr 09, 2024 at 08:42:22AM +0200, Petr Vorel wrote:
> > Hi all,

> > > 5.15-stable review patch.  If anyone has any objections, please let me know.

> > > ------------------

> > > From: Jeff Layton <jlayton@kernel.org>

> > > [ Upstream commit d3aefd2b29ff5ffdeb5c06a7d3191a027a18cdb8 ]

> > > If the namespace doesn't match the one in "net", then we'll continue,
> > > but that doesn't cause another rhashtable_walk_next call, so it will
> > > loop infinitely.

> > > Fixes: ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable")
> > > Reported-by: Petr Vorel <pvorel@suse.cz>
> > > Link: https://lore.kernel.org/ltp/Y1%2FP8gDAcWC%2F+VR3@pevik/
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/nfsd/filecache.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)

> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index 0b19eb015c6c8..024adcbe67e95 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -892,9 +892,8 @@ __nfsd_file_cache_purge(struct net *net)

> > >  		nf = rhashtable_walk_next(&iter);
> > >  		while (!IS_ERR_OR_NULL(nf)) {
> > > -			if (net && nf->nf_net != net)
> > > -				continue;
> > > -			nfsd_file_unhash_and_dispose(nf, &dispose);
> > I don't know the context (whether the fix is needed for 5.15 and older), but
> > patch does not apply because nfsd_file_unhash_and_dispose() was introduced in
> > ce502f81ba88 ("NFSD: Convert the filecache to use rhashtable") in v6.0-rc1.  It
> > was actually renamed from nfsd_file_unhash_and_release_locked() in that commit.
> > Also the context changed - nfsd_file_unhash_and_dispose() was introduced in the
> > commit which is supposed to be fixed in this commit, one would say that this fix
> > is not needed in older kernels (5.15, 5.10 and 5.4; 4.19 has completely
> > different code). But that's a question for Jeff or Chuck.

> This is part of a very large backport of nfsd patches to 5.15 to resolve
> a lot of reported issues, so that might be why it looks odd here.  It
> does seem to compile and boot ok for me, so maybe it's not an issue here
> as you aren't seeing the other patches in this series?

Hi Greg,

I'm sorry, I should realize that one of the 462 previous patches might have
changed the context. If it compiles and boots as whole it should be ok. I'm
sorry for the noise.

Kind regards,
Petr

> thanks,

> greg k-h

