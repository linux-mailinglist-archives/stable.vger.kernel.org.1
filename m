Return-Path: <stable+bounces-83429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99527999FE9
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 11:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CDB11C2182E
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 09:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8B020B214;
	Fri, 11 Oct 2024 09:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GxtCsEBy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EI7LEHQ/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ecCV4c4F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qr0VLfc0"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728021F942E;
	Fri, 11 Oct 2024 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728638228; cv=none; b=DIYj2/SZuqct5INDy13YWqI31ddlxkNryGqmpqTe5h6Dlwf50gmTs0pon92ahOwDUCsyaBWi9TgjwZUJNrJyuFcDCwht694bS63issnz+wOF34qIcz5uyCiER8zcREYZhBWK/T0GscbUnjP3r7dFuczPT0pUPG47vLlZJVbjrE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728638228; c=relaxed/simple;
	bh=PALyVzIVOFahpjkGR0jNU/L45VDE0hSJSYliXR7Uqmk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/rEW5Q/tc8uuldnUo5E6uFnKQlXn65XxlD39rfJrU/tjDgH1RQN+QzuOvxSw2Ea9lAMPR7lvAEjB2PkZgD4vwBsSfxWzWxxpAIY7Ad0z4YfSb4P8ocUNZ9xclmIW2KvyRKrHYzcVL6PFULlkZb0kVWLL60SfK6D5Tflk1rsmKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GxtCsEBy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EI7LEHQ/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ecCV4c4F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qr0VLfc0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91C9C21A5F;
	Fri, 11 Oct 2024 09:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728638224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmYmCVyl2rFwD9BiqgFd8yoAxWFD/1VIA+PgBB6i4+Y=;
	b=GxtCsEByyTBznOeEZGz3uCoxw7gXOR6+KKlRd/G6rNaN2SIo/uoJfHsjAa2jMQDp1AElH0
	7FKjQyweOcV1qZz5jP4CrATxTVeBwEDq8jpu8O4sJ83iDvlE1+Wq958QV0irqtYu4FC9e4
	AHdMSQSRZ+LtcMwHfjQ3OnDfXvCv2KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728638224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmYmCVyl2rFwD9BiqgFd8yoAxWFD/1VIA+PgBB6i4+Y=;
	b=EI7LEHQ/qCHa6ounjWn/JIxerdm18s+tw3pmADsXGOPOyD9g3V9PUGU4s6bgzs0cBATDBG
	4hocjl7vSf0a6kBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728638223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmYmCVyl2rFwD9BiqgFd8yoAxWFD/1VIA+PgBB6i4+Y=;
	b=ecCV4c4FuI3Vh+kvSCo62rf5CwUCjykXEbPXzGleKSTZhJP08KUAH6PoahbwEP/EqHJekb
	xozKjl1qS76MolhbvposaDEd8k5TNeFdPk924HfWfV9oicrthOvcrUXzJ6zHR0SKv2f2y8
	RvPogN+1YOuesRYVqmPpl/QPMsRvvnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728638223;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KmYmCVyl2rFwD9BiqgFd8yoAxWFD/1VIA+PgBB6i4+Y=;
	b=qr0VLfc0mbNLyJzUDgIL/xINESdVi6zfI0rjtkWMsfgn1n/qeDV4nY+XQ8El6RNOtz1feN
	i2ACX1+8hpyrooBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 451541370C;
	Fri, 11 Oct 2024 09:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G4NmDw/tCGcXKwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 11 Oct 2024 09:17:03 +0000
Date: Fri, 11 Oct 2024 11:18:00 +0200
Message-ID: <87ldyvm20n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	g@b4.vu,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: scarlett2: Add error check after retrieving PEQ filter values
In-Reply-To: <20241009092305.8570-1-zhujun2@cmss.chinamobile.com>
References: <20241009092305.8570-1-zhujun2@cmss.chinamobile.com>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Score: -3.30
X-Spam-Flag: NO

On Wed, 09 Oct 2024 11:23:05 +0200,
Zhu Jun wrote:
> 
> Add error check after retrieving PEQ filter values in scarlett2_update_filter_values
> that ensure function returns error if PEQ filter value retrieval fails.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> Cc: <stable@vger.kernel.org>

Applied now (with additional Fixes tag).


thanks,

Takashi

