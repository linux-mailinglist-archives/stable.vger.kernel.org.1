Return-Path: <stable+bounces-192591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D6C3A300
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 11:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1867F4FB762
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21D30E83C;
	Thu,  6 Nov 2025 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MfNNOulw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kc/FdUaC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MfNNOulw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kc/FdUaC"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEE30E834
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423392; cv=none; b=LV/QqEtISt+5DJpEpkX360BuAqngPdUuhatY/HuAJK6+5xWEpckPQDC22hxAJo7K33EQVVcn6abyyWdaKsnCIIJ337CAwhWb+GLUx/kuCVijh0kFkj2iI2RF4R3bsHnJYiBVxYXqP+Q95HzQ9zbO035ffaB3eSe3VyAeKWOp8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423392; c=relaxed/simple;
	bh=TFc+yGHZ85bLLN3cHfSljpFf8GFiIzztJ+KyTNeBZxM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGYgMwVwCvfBWF8cIR+d3wV93UcSfbLc+wa4j2CcW2+NMr25fO3cRCKqFjN5pvqErhSC7aY2LLFSl/fOsFTIoHosqV2hA3w5TaXxLMguq/CAlEzTUVdS+NFA70VEEfVtrwyWMe0QypJDvMK3CtXgy9/y1rYuc+uRNpHtBJkIo7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MfNNOulw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kc/FdUaC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MfNNOulw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kc/FdUaC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C84D71F393;
	Thu,  6 Nov 2025 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AtBCtGM71tDu3DwCLHzCwXsJmyskiOYpRNM5kReOh0=;
	b=MfNNOulw91H2CfWWfgtthxIMS3tVlWThfsZeCM7doK2iTqydMeg2K/1+n70zeIzZQ1UoFG
	ae3aaq6BgVRqNHPxYP4WnL74O/7vZKA/XM9sEeJGeDMSi/f+Rv0vjqUchC0PxBG62Eh3tD
	JxsZGqjn2vQ6CMJqCBPE6RwHlFZwzRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AtBCtGM71tDu3DwCLHzCwXsJmyskiOYpRNM5kReOh0=;
	b=kc/FdUaCUFNFUo8M1bmn5MOWGhNYLcRcY4d5TFXPA50FFXSRLHQdYN0fEOKQ2QbjTKfJ7Z
	GSmJ4+GDSzG3GiCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AtBCtGM71tDu3DwCLHzCwXsJmyskiOYpRNM5kReOh0=;
	b=MfNNOulw91H2CfWWfgtthxIMS3tVlWThfsZeCM7doK2iTqydMeg2K/1+n70zeIzZQ1UoFG
	ae3aaq6BgVRqNHPxYP4WnL74O/7vZKA/XM9sEeJGeDMSi/f+Rv0vjqUchC0PxBG62Eh3tD
	JxsZGqjn2vQ6CMJqCBPE6RwHlFZwzRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7AtBCtGM71tDu3DwCLHzCwXsJmyskiOYpRNM5kReOh0=;
	b=kc/FdUaCUFNFUo8M1bmn5MOWGhNYLcRcY4d5TFXPA50FFXSRLHQdYN0fEOKQ2QbjTKfJ7Z
	GSmJ4+GDSzG3GiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96F4F13A31;
	Thu,  6 Nov 2025 10:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Np2qI1xyDGl/OAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 10:03:08 +0000
Date: Thu, 06 Nov 2025 11:03:08 +0100
Message-ID: <878qgjh40z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH] ALSA: wavefront: Clear substream pointers on close
In-Reply-To: <SYBPR01MB7881DF762CAB45EE42F6D812AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881DF762CAB45EE42F6D812AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,vger.kernel.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Thu, 06 Nov 2025 03:24:57 +0100,
Junrui Luo wrote:
> 
> Clear substream pointers in close functions to avoid leaving dangling
> pointers, helping to improve code safety and
> prevents potential issues.
> 
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Reported-by: Junrui Luo <moonafterrain@outlook.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Applied now.  Thanks.


Takashi

