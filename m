Return-Path: <stable+bounces-164747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C66B8B12178
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 18:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6FAAC3CC6
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 16:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329722EF28F;
	Fri, 25 Jul 2025 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XVcwjVWw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="joLBJxms";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XVcwjVWw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="joLBJxms"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9742EE606
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459804; cv=none; b=UjNrsN8kUuvYsm2xBxYPeG3h3ZkKhv2frj/MWhXsj1DWiAGnc51pH9GbWDDy9cTdHHZC/uYG083yMAddMgvCIjLITPMebeBUb6LSuLc9bNHZlVtAzgj47AFnWmnV+6UHGnUYHjYgMs1NbwVId7WwuF4/iHtJrDikPXdm5FlGG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459804; c=relaxed/simple;
	bh=nA5PzzSn24HJ353yCbVh/NhjcA52KJF8UioOO2CRN2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mH6M5A6jJmpcEttBHhshCWBn7Aj8hak4tDEvkVyvROpu9akO2VNmfjXDOGj1YMA5dAikzPcyFCO/8fALoq8LXPGOT3GzlP+7fDrXFs5zJLFeQW//184qdhEe/LjGGhv2cghzL49eSN/3KycAS5yYqsUn0tm1YQLFTy7KTeoaAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XVcwjVWw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=joLBJxms; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XVcwjVWw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=joLBJxms; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A23131F795;
	Fri, 25 Jul 2025 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753459799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzzmnXod3F0xmGwLsBojXwSu1vrDZ6qn6GXPgitsM9w=;
	b=XVcwjVWwLOmuPeyvvzcKu6+bKkyqBF3SSTuwP6rxranRakJapb9n748pYq5hVlVpvF5qSM
	ddOYqQbDH6zXWpwOaBzSN0eKKyhK1r1fPcZVJyaop+d5oKWaARJYMQHl+WIOVoUrT93k4t
	33DvwIcRyZOmQ3qwB4vfh0LjV/FLLtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753459799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzzmnXod3F0xmGwLsBojXwSu1vrDZ6qn6GXPgitsM9w=;
	b=joLBJxmseqJsd02nTj8ecCUWc37VgYFtYN97kNYGAS2ICUJuEIyy5BXLyEO7igU/iVR3Rt
	3JCL5jlSRC5zL+Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XVcwjVWw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=joLBJxms
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753459799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzzmnXod3F0xmGwLsBojXwSu1vrDZ6qn6GXPgitsM9w=;
	b=XVcwjVWwLOmuPeyvvzcKu6+bKkyqBF3SSTuwP6rxranRakJapb9n748pYq5hVlVpvF5qSM
	ddOYqQbDH6zXWpwOaBzSN0eKKyhK1r1fPcZVJyaop+d5oKWaARJYMQHl+WIOVoUrT93k4t
	33DvwIcRyZOmQ3qwB4vfh0LjV/FLLtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753459799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RzzmnXod3F0xmGwLsBojXwSu1vrDZ6qn6GXPgitsM9w=;
	b=joLBJxmseqJsd02nTj8ecCUWc37VgYFtYN97kNYGAS2ICUJuEIyy5BXLyEO7igU/iVR3Rt
	3JCL5jlSRC5zL+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C96561373A;
	Fri, 25 Jul 2025 16:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VA5fLVasg2iecgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 25 Jul 2025 16:09:58 +0000
Date: Fri, 25 Jul 2025 17:09:57 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Bernard Metzler <BMT@zurich.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jakub Kicinski <kuba@kernel.org>, 
	David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] RDMA/siw: Fix the sendmsg byte count in siw_tcp_sendpages
Message-ID: <l5cavrkmzvebjqz62ttdajqc24q3fksxogiibv4tiee7c3j2lk@skxdyrnsqgmm>
References: <20250723104123.190518-1-pfalcato@suse.de>
 <DS0SPRMB00679C99808A4D85BAB6DADF995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
 <nwtutmewgtziygnp7drmhdxpenrbxumrjprcz7ls2afwub5lwf@due2djp7llv5>
 <DS0SPRMB006759C349217E60D43F923B995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0SPRMB006759C349217E60D43F923B995FA@DS0SPRMB0067.namprd15.prod.outlook.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: A23131F795
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Wed, Jul 23, 2025 at 04:49:30PM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Pedro Falcato <pfalcato@suse.de>
> > Sent: Wednesday, 23 July 2025 17:49
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>; Leon Romanovsky <leon@kernel.org>;
> > Vlastimil Babka <vbabka@suse.cz>; Jakub Kicinski <kuba@kernel.org>; David
> > Howells <dhowells@redhat.com>; Tom Talpey <tom@talpey.com>; linux-
> > rdma@vger.kernel.org; linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > stable@vger.kernel.org; kernel test robot <oliver.sang@intel.com>
> > Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix the sendmsg byte count in
> > siw_tcp_sendpages
> > 
> > On Wed, Jul 23, 2025 at 02:52:12PM +0000, Bernard Metzler wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Pedro Falcato <pfalcato@suse.de>
> > > > Sent: Wednesday, 23 July 2025 12:41
> > > > To: Jason Gunthorpe <jgg@ziepe.ca>; Bernard Metzler
> > <BMT@zurich.ibm.com>;
> > > > Leon Romanovsky <leon@kernel.org>; Vlastimil Babka <vbabka@suse.cz>
> > > > Cc: Jakub Kicinski <kuba@kernel.org>; David Howells
> > <dhowells@redhat.com>;
> > > > Tom Talpey <tom@talpey.com>; linux-rdma@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; linux-mm@kvack.org; Pedro Falcato
> > > > <pfalcato@suse.de>; stable@vger.kernel.org; kernel test robot
> > > > <oliver.sang@intel.com>
> > > [snip]
> > > > ---
> > > >  drivers/infiniband/sw/siw/siw_qp_tx.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
> > > > b/drivers/infiniband/sw/siw/siw_qp_tx.c
> > > > index 3a08f57d2211..9576a2b766c4 100644
> > > > --- a/drivers/infiniband/sw/siw/siw_qp_tx.c
> > > > +++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
> > > > @@ -340,11 +340,11 @@ static int siw_tcp_sendpages(struct socket *s,
> > struct
> > > > page **page, int offset,
> > > >  		if (!sendpage_ok(page[i]))
> > > >  			msg.msg_flags &= ~MSG_SPLICE_PAGES;
> > > >  		bvec_set_page(&bvec, page[i], bytes, offset);
> > > > -		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> > > > +		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, bytes);
> > > >
> > > >  try_page_again:
> > > >  		lock_sock(sk);
> > > > -		rv = tcp_sendmsg_locked(sk, &msg, size);
> > > > +		rv = tcp_sendmsg_locked(sk, &msg, bytes);
> > > >  		release_sock(sk);
> > > >
> > >
> > > Pedro, many thanks for catching this! I completely
> > > missed it during my too sloppy review of that patch.
> > > It's a serious bug which must be fixed asap.
> > > BUT, looking closer, I do not see the offset being taken
> > > into account when retrying a current segment. So,
> > > resend attempts seem to send old data which are already
> > > out. Shouldn't the try_page_again: label be above
> > > bvec_set_page()??
> > 
> > This was raised off-list by Vlastimil - I think it's harmless to bump (but
> > not use)
> > the offset here, because by reusing the iov_iter we progressively consume
> > the data
> > (it keeps its own size and offset tracking internally). So the only thing
> > we
> > need to track is the size we pass to tcp_sendmsg_locked[1].
> > 

Hi,

Sorry for the delay.

> Ah okay, I didn't know that. Are we sure? I am currently travelling and have
> only limited possibilities to try out things. I just looked up other

I'm not 100% sure, and if some more authoritative voice (David, or Jakub for
the net side) could confirm my analysis, it would be great.

> use cases and found one in net/tls/tls_main.c#L197. Here the loop looks
> very similar, but it works as I was suggesting (taking offset into account
> and re-initializing new bvec in case of partial send).
> 
> > If desired (and if my logic is correct!) I can send a v2 deleting that bit.
> > 
> 
> So yes if that's all save, please. We shall not have dead code.

Understood. I'll send a v2 resetting the bvec and iov_iter if we get no further
feedback in the meanwhile.

> 
> Thanks!
> Bernard.
> > 
> > [1] Assuming tcp_sendmsg_locked guarantees it will never consume something
> > out
> > of the iovec_iter without reporting it as bytes copied, which from a code
> > reading
> > it seems like it won't...
> > 
> > 
> > --
> > Pedro

-- 
Pedro

