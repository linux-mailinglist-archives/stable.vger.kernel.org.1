Return-Path: <stable+bounces-23363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ECB85FE75
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6786B2841EE
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73450153BC9;
	Thu, 22 Feb 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aBr3DIfq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENoQs/Z6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aBr3DIfq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ENoQs/Z6"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364E14C5AB
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620660; cv=none; b=af0XmCRE14IT+htdFTU8CfXQd6/445rkP4R3091zoUO0n4QzNxhx02mdg07g1Q19I/2HZvcd9m8U8zDZIK+dAryjjQodKhwHWAGGjiYXzNGIn1Oq30HbHcdOOhVfj8mC9K83i35zvFJqa0ukZlhR6g8E5o0vJfWhGTgbt3A4gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620660; c=relaxed/simple;
	bh=9uXYkXmpAZ30Wb+MHsasdSaidnWfh4BECJGKUcpMTeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Au5WxKqXN6t44ia/OLYB2R0duyUoSIK7AVpsQB437onDGGySsiH5MuGUrRi9ioU88Q2SijxmUnTLIRBiYMka6zFj8hCQt8CYbkniTOG4Jjqy1xuHvDvKKHQiWdVwGhJ5kHYiWzrRXjeWfuqPmgKZTo9fIMRoHCzmGTAMxiVdWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aBr3DIfq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENoQs/Z6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aBr3DIfq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ENoQs/Z6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51FB721E45;
	Thu, 22 Feb 2024 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708620656;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oq9Wxks2yPFaYtr6G/qmsZgultOBoolQtJzBQYHj9GY=;
	b=aBr3DIfqHc6n2OqMw1PFv4oO2wQgxCRuxwmySQPvfreT1MyBEC/tuF8aGj9m2USldBjBoZ
	ISdj1bNUT7LCj1o7pIsJRRSvUuddCbi+KC4GldRk7L4zxwiqDp1FS51X3nf8tvzEb2SE98
	SFwAsQQ9p8VTQGyjuNbgd1BXI7viwOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708620656;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oq9Wxks2yPFaYtr6G/qmsZgultOBoolQtJzBQYHj9GY=;
	b=ENoQs/Z6wNcVaGZZqN/xNbMYaz9e6PprinC0UnD/vyhd9DVEBxfkpPrrB9WT+jO7Y+TmUk
	vqJlpuLjbfw6yNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708620656;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oq9Wxks2yPFaYtr6G/qmsZgultOBoolQtJzBQYHj9GY=;
	b=aBr3DIfqHc6n2OqMw1PFv4oO2wQgxCRuxwmySQPvfreT1MyBEC/tuF8aGj9m2USldBjBoZ
	ISdj1bNUT7LCj1o7pIsJRRSvUuddCbi+KC4GldRk7L4zxwiqDp1FS51X3nf8tvzEb2SE98
	SFwAsQQ9p8VTQGyjuNbgd1BXI7viwOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708620656;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oq9Wxks2yPFaYtr6G/qmsZgultOBoolQtJzBQYHj9GY=;
	b=ENoQs/Z6wNcVaGZZqN/xNbMYaz9e6PprinC0UnD/vyhd9DVEBxfkpPrrB9WT+jO7Y+TmUk
	vqJlpuLjbfw6yNCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB4FD13419;
	Thu, 22 Feb 2024 16:50:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BISzKm9712VkBQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Thu, 22 Feb 2024 16:50:55 +0000
Date: Thu, 22 Feb 2024 17:50:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] sched/rt fixes for 4.19
Message-ID: <20240222165049.GA1373797@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240222151333.1364818-1-pvorel@suse.cz>
 <2024022218-fabric-fineness-0996@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022218-fabric-fineness-0996@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aBr3DIfq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ENoQs/Z6"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.05 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.04)[-0.195];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[34.86%]
X-Spam-Score: -2.05
X-Rspamd-Queue-Id: 51FB721E45
X-Spam-Flag: NO

Hi Greg,

> On Thu, Feb 22, 2024 at 04:13:21PM +0100, Petr Vorel wrote:
> > Hi,

> > maybe you will not like introducing 'static int int_max = INT_MAX;' for
> > this old kernel which EOL in 10 months.

> That's fine, not a big deal :)

Thanks for a quick info. I guess this is a reply to my question about
SYSCTL_NEG_ONE failure on missing SYSCTL_NEG_ONE. Therefore I'll create
static int __maybe_unused neg_one = -1; (which was used before 78e36f3b0dae).

> > Cyril Hrubis (3):
> >   sched/rt: Fix sysctl_sched_rr_timeslice intial value
> >   sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
> >   sched/rt: Disallow writing invalid values to sched_rt_period_us

> >  kernel/sched/rt.c | 10 +++++-----
> >  kernel/sysctl.c   |  5 +++++
> >  2 files changed, 10 insertions(+), 5 deletions(-)

> Thanks for the patches, but they all got connected into the same thread,
> making it impossible to detect which ones are for what branches :(

> Can you put the version in the [PATCH X/Y] section like [PATCH 4.14 X/Y]
> or just make separate threads so we have a chance?

I'm sorry, I'll resent all patches properly.

Kind regards,
Petr

> thanks,

> greg k-h

