Return-Path: <stable+bounces-61783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC2293C7D2
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4D71F21E1B
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 17:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1AE19D06C;
	Thu, 25 Jul 2024 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fYk3E86h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E2ODFwuU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fYk3E86h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E2ODFwuU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1A126286
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929922; cv=none; b=EpBMYL1YzYf6lqWDo9OBIIInDSSvjMDDqp6nKyqfu0iECkhb/gNLAm4pvOvs0c01tQbGWZKMdfYzYuSU9WaLzquUKQ3SCWmXdkK5tm/+vzDCGvS/9KzUBtRisBwI4OgS+ZjI5NSOkx+JGqHzYb4yzC5lwfzRwjdrHjxATyXbv2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929922; c=relaxed/simple;
	bh=12WVg3nkNN5dJr4yt7agDrOqYpMz/tzTOI0MbISKRRM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tQhbrllQVyYihWN/DErKT495OB84eXClUEHYugBTOBUYjflZd9E7pjbCvPA6xwIGc09GUFLfl06Cv3+M3WhALdSZZnSPj6uGTIl+NckHqglMV9Ac1ghAS6nghzRIYM+13+X2P5R3SDJ2JtmZ3OQw5WyB/p3TKF3H+7IqKd9sUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fYk3E86h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E2ODFwuU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fYk3E86h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E2ODFwuU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C82A1F824;
	Thu, 25 Jul 2024 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721929918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3FSe0mL3X9v9JJ+iNhnA+pFWgWbWdYPW2n58aGjUHk=;
	b=fYk3E86hc89SC/JtwvkEYQ45KcwCNQWA8pRWx8OvP0jXlGtpYe+Kxn9X3G6QOQ7RpYznnh
	FHNzn+ER85z0vFaBn991H9pdKicw1/KmpHv2v506p+Umve05GomvqtM9E0J9Mo0OpBAwUt
	+2jCBhkBrqckubx4CXbNd45GkOuul4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721929918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3FSe0mL3X9v9JJ+iNhnA+pFWgWbWdYPW2n58aGjUHk=;
	b=E2ODFwuUqydO3MXkVfkS4fi22KqiS3couW5kBxjk3rm8bJB+1JzhYexQd+YlRdiGIz1NLg
	hhBGx7ECxR1o8lAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721929918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3FSe0mL3X9v9JJ+iNhnA+pFWgWbWdYPW2n58aGjUHk=;
	b=fYk3E86hc89SC/JtwvkEYQ45KcwCNQWA8pRWx8OvP0jXlGtpYe+Kxn9X3G6QOQ7RpYznnh
	FHNzn+ER85z0vFaBn991H9pdKicw1/KmpHv2v506p+Umve05GomvqtM9E0J9Mo0OpBAwUt
	+2jCBhkBrqckubx4CXbNd45GkOuul4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721929918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u3FSe0mL3X9v9JJ+iNhnA+pFWgWbWdYPW2n58aGjUHk=;
	b=E2ODFwuUqydO3MXkVfkS4fi22KqiS3couW5kBxjk3rm8bJB+1JzhYexQd+YlRdiGIz1NLg
	hhBGx7ECxR1o8lAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D50621368A;
	Thu, 25 Jul 2024 17:51:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id niJ/Mr2Qomb5UwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 25 Jul 2024 17:51:57 +0000
Date: Thu, 25 Jul 2024 19:52:32 +0200
Message-ID: <8734nxickf.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Takashi Iwai <tiwai@suse.de>,
	stable@vger.kernel.org,
	Edmund Raile <edmund.raile@proton.me>
Subject: Re: [PATCH] ALSA: firewire-lib: fix wrong value as length of header for CIP_NO_HEADER case
In-Reply-To: <20240725162537.GB109922@workstation.local>
References: <20240725155640.128442-1-o-takashi@sakamocchi.jp>
	<94600ca4-47ce-4993-b6ce-dabb93ef01dc@embeddedor.com>
	<877cd9ih8l.wl-tiwai@suse.de>
	<9d039b39-06c1-4328-bd5b-8b2c757ee438@embeddedor.com>
	<20240725162537.GB109922@workstation.local>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Thu, 25 Jul 2024 18:25:37 +0200,
Takashi Sakamoto wrote:
> 
> Hi,
> 
> On Thu, Jul 25, 2024 at 10:16:36AM -0600, Gustavo A. R. Silva wrote:
> > Yes, but why have two separate patches when the root cause can be addressed by
> > a single one, which will prevent other potential issues from occurring?
> > 
> > The main issue in this case is the __counted_by() annotation. The DEFINE_FLEX()
> > bug was a consequence.
> 
> Just now I sent a patch to revert the issued commit[1].
> 
> I guess that we need the association between the two fixes. For example,
> we can append more 'Fixes' tag to the patch in sound subsystem into the
> patch in firewire subsystem (or vice versa).

OK, then I drop your patch for the sound stuff, and you can take it
through firewire tree.

Feel free to take my ack:
Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

