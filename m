Return-Path: <stable+bounces-92891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22B79C6973
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 07:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630C8B24839
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 06:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345F717D341;
	Wed, 13 Nov 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BK7grWs2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zbPinwz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BK7grWs2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5zbPinwz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6893617A922;
	Wed, 13 Nov 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480219; cv=none; b=n7LFW9SKNEeQbStVg9kuCe5mDDx+vpgfHfSbPqWe62AJ7B9vVKOwUPdlio9fNa/n3tJ306695G//sqehGreufSmVXQ05JPmBineaJuE6Jg11Zp9qPl1cC3fSzW6drmh9XKjZ7elmHneID836b+XCJDdw4Kqj/DehE/zo6dglw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480219; c=relaxed/simple;
	bh=fWr0Txakby/3WRoIzOUJcb1yqugsWJyH7uPit0HQezQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qERvPhgMA67asBZr0rR7OPaZ2+s0ltHwqEKBNZTyZPhX7GjT8pYblScv6ZbTsvAt1PO5cu0/4aawZkshM4hVpyF3hFs8F9hgXcOAn7QPyYh8G6kXdKQ1B6b4I+aAdmlcBd5dxgaejvOi+tJRWblQzTMOD5LPy7HPFLD/vLZbfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BK7grWs2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zbPinwz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BK7grWs2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5zbPinwz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B445A211D0;
	Wed, 13 Nov 2024 06:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731480215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EwV+jJYGsF0wWvCVejmO7qmdOyG5aTuIZV6/Wuwi3Y=;
	b=BK7grWs2qbPABTMpjuR9roHjLpAKGhAOdmxcuUY4/lME+7EuKiym8tkbomG+HFpNAZJhb4
	aVLRlB1T2Z0iPlM9iZaX5YauMiQwbdH46TrVzo06tQAM0LnRH6X0VJH/WSswUGuCY4QlRb
	8QkNwh3X7rZWvjMwJvdoKfyb3fOldlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731480215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EwV+jJYGsF0wWvCVejmO7qmdOyG5aTuIZV6/Wuwi3Y=;
	b=5zbPinwzC/qtQh7KwRQmj+JhaHpOz9F9jlhIzueZLeB/ilvADlUI4+YiIm9lmdvp7JmaEd
	wl3Bzsv0EbxY92Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731480215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EwV+jJYGsF0wWvCVejmO7qmdOyG5aTuIZV6/Wuwi3Y=;
	b=BK7grWs2qbPABTMpjuR9roHjLpAKGhAOdmxcuUY4/lME+7EuKiym8tkbomG+HFpNAZJhb4
	aVLRlB1T2Z0iPlM9iZaX5YauMiQwbdH46TrVzo06tQAM0LnRH6X0VJH/WSswUGuCY4QlRb
	8QkNwh3X7rZWvjMwJvdoKfyb3fOldlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731480215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EwV+jJYGsF0wWvCVejmO7qmdOyG5aTuIZV6/Wuwi3Y=;
	b=5zbPinwzC/qtQh7KwRQmj+JhaHpOz9F9jlhIzueZLeB/ilvADlUI4+YiIm9lmdvp7JmaEd
	wl3Bzsv0EbxY92Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E43113301;
	Wed, 13 Nov 2024 06:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rURXGZdKNGc1DAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 13 Nov 2024 06:43:35 +0000
Date: Wed, 13 Nov 2024 07:43:35 +0100
Message-ID: <87ttcbskfc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kailang <kailang@realtek.com>
Cc: Dean Matthew Menezes <dean.menezes@utexas.edu>,
	Takashi Iwai <tiwai@suse.de>,
	"stable@vger.kernel.org"
	<stable@vger.kernel.org>,
	"regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai
	<tiwai@suse.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Greg KH
	<gregkh@linuxfoundation.org>
Subject: Re: No sound on speakers X1 Carbon Gen 12
In-Reply-To: <ced4ebe356ad4e5796f059df8cdef3dd@realtek.com>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
	<2024101613-giggling-ceremony-aae7@gregkh>
	<433b8579-e181-40e6-9eac-815d73993b23@leemhuis.info>
	<87bjzktncb.wl-tiwai@suse.de>
	<CAEkK70TAk26HFgrz4ZS0jz4T2Eu3LWcG-JD1Ov_2ffMp66oO-g@mail.gmail.com>
	<87cyjzrutw.wl-tiwai@suse.de>
	<CAEkK70T7NBRA1dZHBwAC7mNeXPo-dby4c7Nn=SYg0vzeHHt-1A@mail.gmail.com>
	<87ttd8jyu3.wl-tiwai@suse.de>
	<CAEkK70RAWRjRp6_=bSrecSXXMfnepC2P2YriaHUqicv5x5wJWw@mail.gmail.com>
	<87h697jl6c.wl-tiwai@suse.de>
	<CAEkK70TWL_me58QZXeJSq+=Ry3jA+CgZJttsgAPz1wP7ywqj6A@mail.gmail.com>
	<87ed4akd2a.wl-tiwai@suse.de>
	<87bjzekcva.wl-tiwai@suse.de>
	<CAEkK70SgwaFNcxni2JUAfz7Ne9a_kdkdLRTOR53uhNzJkBQ3+A@mail.gmail.com>
	<877ca2j60l.wl-tiwai@suse.de>
	<43fe74e10d1d470e80dc2ae937bc1a43@realtek.com>
	<87ldyh6eyu.wl-tiwai@suse.de>
	<18d07dccef894f4cb87b78dd548c5bdd@realtek.com>
	<87h6956dgu.wl-tiwai@suse.de>
	<c47a3841cd554c678a0c5e517dd2ea77@realtek.com>
	<CAEkK70SojedmjbXB+a+g+Bys=VWCOpxzV5GkuMSkAgA-jR2FpA@mail.gmail.com>
	<87ldyctzwt.wl-tiwai@suse.de>
	<CAEkK70RAek2Y-syVt3S+3Q-kiriO24e8qQGDTrqC-Xt4kHzbCA@mail.gmail.com>
	<b97c52ec20594eecb074d333095a4560@realtek.com>
	<CAEkK70QottpLxq-prAEPe8TtPR=QBdQWuUrjf6ZT6PipcfS9xw@mail.gmail.com>
	<ced4ebe356ad4e5796f059df8cdef3dd@realtek.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 13 Nov 2024 07:22:48 +0100,
Kailang wrote:
> 
> Hi Takashi,
> 
> Attach patch will solve issue.

Applied now (with small corrections of white spaces).


thanks,

Takashi

