Return-Path: <stable+bounces-76181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF649979C05
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 09:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000211C22817
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD06B139CE2;
	Mon, 16 Sep 2024 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q9gS+DeN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CgOAiH2b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q9gS+DeN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CgOAiH2b"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D93B131BDD
	for <stable@vger.kernel.org>; Mon, 16 Sep 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726471765; cv=none; b=pghpVeVPQXuHI7LygiitP6ikjwPiVmuVugzsRjtk6m7lsve1WyR5+ehS5fkfX+WMFhMf/o640+lp3vgZYtk4idum77lh34xOAmR7UGAsUgrnieoBS1uA60pvp1dPF+oGN70i4KVSe6cHCdVmRA8lIYTM0pdSgztqesOw0PKgRGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726471765; c=relaxed/simple;
	bh=j9e8m4a1T6VTfjH18wvCXIvvnpn+FoPe5QeLbmyqI1A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxEETsgEhU1yn2wY4hwsnO55kXzTOg1mcl2FrgxqZqCw/RCcrELV/fNUQHyC8OQyv95p2FqA+C/jwMdB36ghZSNYQdyglqG0UVzr+3ZW3urL5CzvUGCFFndxGTAYG4shT5Z3VW7WDj4Bb8BB/Zka6vC+ksp9cM3co6QCg4kOGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q9gS+DeN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CgOAiH2b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q9gS+DeN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CgOAiH2b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 444DE1F86B;
	Mon, 16 Sep 2024 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726471762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bBgueuxUZvbQExAimI3tYuObMSYYaUPWGJbo808X5w=;
	b=Q9gS+DeNuTBVDoSXv6QxXSr1eThAyx5aEZnDZEJuuKHrSE5OEPbVIsO6kDx7ptXFlDecMP
	IDSC+9aNkK+JmDfeVKVD9g3XpCQOXmC0NMZez+QS76IDVwTUqLLUeaJytzQShxIJUVpXKE
	HQjQjeRmsIlSj0dbkyu7AAXXDQHnN68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726471762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bBgueuxUZvbQExAimI3tYuObMSYYaUPWGJbo808X5w=;
	b=CgOAiH2btemuKf2o+pnnQ3tlOo8Pvxu42HlYSl9wmUSSEEl8wiEn/c5A8oBfG6hTNi0+en
	VKi7+rjeOZ8UJCAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q9gS+DeN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CgOAiH2b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726471762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bBgueuxUZvbQExAimI3tYuObMSYYaUPWGJbo808X5w=;
	b=Q9gS+DeNuTBVDoSXv6QxXSr1eThAyx5aEZnDZEJuuKHrSE5OEPbVIsO6kDx7ptXFlDecMP
	IDSC+9aNkK+JmDfeVKVD9g3XpCQOXmC0NMZez+QS76IDVwTUqLLUeaJytzQShxIJUVpXKE
	HQjQjeRmsIlSj0dbkyu7AAXXDQHnN68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726471762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1bBgueuxUZvbQExAimI3tYuObMSYYaUPWGJbo808X5w=;
	b=CgOAiH2btemuKf2o+pnnQ3tlOo8Pvxu42HlYSl9wmUSSEEl8wiEn/c5A8oBfG6hTNi0+en
	VKi7+rjeOZ8UJCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B2831397F;
	Mon, 16 Sep 2024 07:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s2UjAVLe52YALQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 16 Sep 2024 07:29:22 +0000
Date: Mon, 16 Sep 2024 09:30:11 +0200
Message-ID: <87wmjc8398.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Ariadne Conill <ariadne@ariadne.space>,
	xen-devel@lists.xenproject.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "ALSA: memalloc: Workaround for Xen PV"
In-Reply-To: <ZufdOjFCdqQQX7tz@infradead.org>
References: <20240906184209.25423-1-ariadne@ariadne.space>
	<877cbnewib.wl-tiwai@suse.de>
	<9eda21ac-2ce7-47d5-be49-65b941e76340@citrix.com>
	<ZuK6xcmAE4sngFqk@infradead.org>
	<874j6g9ifp.wl-tiwai@suse.de>
	<ZufdOjFCdqQQX7tz@infradead.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 444DE1F86B
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 16 Sep 2024 09:24:42 +0200,
Christoph Hellwig wrote:
> 
> On Mon, Sep 16, 2024 at 09:16:58AM +0200, Takashi Iwai wrote:
> > Yes, all those are really ugly hacks and have been already removed for
> > 6.12.  Let's hope everything works as expected with it.
> 
> The code currently in linux-next will not work as explained in my
> previous mail, because it tries to side step the DMA API and abuses
> get_dma_ops in an unsupported way.

Those should have been removed since the last week.
Could you check the today's linux-next tree?


thanks,

Takashi

