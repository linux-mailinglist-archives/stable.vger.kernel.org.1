Return-Path: <stable+bounces-93479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0D99CDA5D
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CAD1F22C5F
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2DB187862;
	Fri, 15 Nov 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wSSwXWjT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pK/eawzK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S/ekDse9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F3wZq/SB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F242AA3;
	Fri, 15 Nov 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731658801; cv=none; b=E+RcbXyE0hoJ+40luqYPYwVNfpZrvu8tyr0GAmCLiRiiuo83ZFOCJh/M0veTj/z3ZjWTyQtDSyurje9/AqZY56Pb20y1jL5h0HQLgukqc0IqwOW3lc5KIxY2R9+THeXUmuQqSXpxplCkh7kn4Mpc8MT78iD+j/buvskAjGtl0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731658801; c=relaxed/simple;
	bh=EPIJWquNJXJ1mIWez9vQUyqrd8TEHhNHe09McgvSzEI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmS1URSZvMAM81kdfcFsfiEsO4JcPWxO1M8xGyCYiB02/+CH0tvaGHCOn6EypgSz33I7gNbbCTDPVkFAzT2AH9tXaZFvVGOhVTlkBmeJ8GUHTpJhAo0OUhFjIsMDRWUZ3XsOnQY6WNQ6CX2/BsQg9DID+ZCix0K9III7KML6TUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wSSwXWjT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pK/eawzK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S/ekDse9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F3wZq/SB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D6E39211F9;
	Fri, 15 Nov 2024 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731658798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6loe5mwuNp8SD+WgZ2xYTjNSfnf6EhgG8xZm+HSkQU=;
	b=wSSwXWjTMPqsFyoHxSWCUsy8JhafdIWDWM6Ezl3YtszU2fUb0Nfi8wT3A4eRXL9/NHLAR3
	xL2gMs8OGvN9YnmeoJy9wE4M8adwOsfkcXsnyHwlzoaQLC743hNaT4UfX7am3zPc/fIJea
	lZhG+gH7Hp0Ez5PQUiCQ2zlk5gHVfgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731658798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6loe5mwuNp8SD+WgZ2xYTjNSfnf6EhgG8xZm+HSkQU=;
	b=pK/eawzKTIl2EDa0ZlOg4fZ6jqg/VF7DC5QK4YuUydM8YROULGW9boydAIAZPERMclYpEG
	aPv6m4H4awYmoXAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731658797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6loe5mwuNp8SD+WgZ2xYTjNSfnf6EhgG8xZm+HSkQU=;
	b=S/ekDse9tLjwZ8bqb8eO1HsBwgMD8qyCkrdU7E8+lqV0NeUmzWVEO8ZozyQYIvhYB4hKdH
	kHYEgtMHlaBd80YaRqdSB4BvP0kDTjPJrRC9aCziftmbkDnDQ+N5LXqfvHCwAK0HcYXqlV
	bf9hbVuAQPlPCpAF3myEr2aCqdb66mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731658797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6loe5mwuNp8SD+WgZ2xYTjNSfnf6EhgG8xZm+HSkQU=;
	b=F3wZq/SBhcEym07aHZTt6PAAWwKkmvZjrF1YV62jpc6Xw03NypS9Y6BGnsaKTfz59aJt5c
	Wkkzf8xJi/RWhcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA99134B8;
	Fri, 15 Nov 2024 08:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7VzYIC0EN2fCLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Nov 2024 08:19:57 +0000
Date: Fri, 15 Nov 2024 09:19:57 +0100
Message-ID: <87jzd4syc2.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Terry Junge <linuxhid@cosmicgizmosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Wade Wang <wade.wang@hp.com>,
	perex@perex.cz,
	tiwai@suse.com,
	kl@kl.wtf,
	wangdicheng@kylinos.cn,
	k.kosik@outlook.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix control names for Plantronics/Poly Headsets
In-Reply-To: <4717b9c4-8d9f-40d8-903e-68be30ac7d82@cosmicgizmosystems.com>
References: <20241114061553.1699264-1-wade.wang@hp.com>
	<87plmythnv.wl-tiwai@suse.de>
	<4717b9c4-8d9f-40d8-903e-68be30ac7d82@cosmicgizmosystems.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,hp.com,perex.cz,suse.com,kl.wtf,kylinos.cn,outlook.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Thu, 14 Nov 2024 19:44:52 +0100,
Terry Junge wrote:
> 
> Thanks Takashi,
> 
> On 11/13/24 11:10 PM, Takashi Iwai wrote:
> > On Thu, 14 Nov 2024 07:15:53 +0100,
> > Wade Wang wrote:
> >>
> >> Add a control name fixer for all headsets with VID 0x047F.
> >>
> >> Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
> >> Signed-off-by: Wade Wang <wade.wang@hp.com>
> > 
> > Thanks for the patch, but from the description, it's not clear what
> > this patch actually does.  What's the control name fixer and how it
> > behaves?
> 
> It will be better described in the v2 patch.
> 
> It modifies names like
> 
> Headset Earphone Playback Volume
> Headset Microphone Capture Switch
> Receive Playback Volume
> Transmit Capture Switch
> 
> to
> 
> Headset Playback Volume
> Headset Capture Switch
> 
> so user space will bind to the headset's audio controls.

OK, that makes sense.  I suppose that both "Headset Earphone Playback
Volume" and "Receive Playback Volume" don't exist at the same time,
right?


Takashi

