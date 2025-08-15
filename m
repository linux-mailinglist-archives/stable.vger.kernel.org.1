Return-Path: <stable+bounces-169741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD18CB2835F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBD016F80D
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367D308F2F;
	Fri, 15 Aug 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Ik7yeHF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9PB7iV+P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Ik7yeHF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9PB7iV+P"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C437308F23
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273379; cv=none; b=DIv6Qko617zfenlxxeX4oEhiCww44FfrnAtY3KcgJeOJXxUX4so8vrLmt5qa9IPF/4IOCbnYRb4HSyFMLz5Oo5Om3inpd/BIO6Q3fDY8DY5VaTNrLc6whxCpuxNyguMaSqm+0KAQpoIIuRcEKGXEbyXYVPjVh4ZI4Lr82FY5U0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273379; c=relaxed/simple;
	bh=gEwdIcohOGjRbsPGfRuPqK2Ha2RWLSqO/HjHSytgUTE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSu6hi9mgMtKBCB1eBk9Z6Dq1h5t2C2Az4j/wreMoQoMx69/wuZABesA7bQz3J3GMv4UQHZFIfd/14AJy6vs4QRsYUN6H52ry/GtzbNP4+qrzAQ7K/+XAAmXOJP/yhgRjHo7unudXdy9GJZIzRl1e9Od0SQfpBH1XqhMa3KwrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Ik7yeHF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9PB7iV+P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Ik7yeHF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9PB7iV+P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 899921F83E;
	Fri, 15 Aug 2025 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755273376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ylDpfvG+Q72KMn3EPDSQu7NP1xGDMKASI4nIBOOfG0=;
	b=2Ik7yeHF9Knd7JW6bm7KTVwYG3YjjPPK8+3D5ov9U0qCj+pCmOtSGEO1ED9ZdBxmuKTlKK
	O4P3iZ3yPmB1oJeyxVaIwcZrIZKPwePsMuuu0eqyCPj+3hM9zDqHi9v3IMfHGWahF6UCe5
	KOhmVd5W19eGHllj8QNLPhiFPG0o1Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755273376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ylDpfvG+Q72KMn3EPDSQu7NP1xGDMKASI4nIBOOfG0=;
	b=9PB7iV+PVh2bHUv9xiBnbOq/wPZtsadQRUsZHLWQAem4BOOpo9JyenWF5fmQMzRA3MaEUB
	j/bu/7kJNYFBTsBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755273376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ylDpfvG+Q72KMn3EPDSQu7NP1xGDMKASI4nIBOOfG0=;
	b=2Ik7yeHF9Knd7JW6bm7KTVwYG3YjjPPK8+3D5ov9U0qCj+pCmOtSGEO1ED9ZdBxmuKTlKK
	O4P3iZ3yPmB1oJeyxVaIwcZrIZKPwePsMuuu0eqyCPj+3hM9zDqHi9v3IMfHGWahF6UCe5
	KOhmVd5W19eGHllj8QNLPhiFPG0o1Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755273376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ylDpfvG+Q72KMn3EPDSQu7NP1xGDMKASI4nIBOOfG0=;
	b=9PB7iV+PVh2bHUv9xiBnbOq/wPZtsadQRUsZHLWQAem4BOOpo9JyenWF5fmQMzRA3MaEUB
	j/bu/7kJNYFBTsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3162713876;
	Fri, 15 Aug 2025 15:56:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z5e/CqBYn2heIAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 Aug 2025 15:56:16 +0000
Date: Fri, 15 Aug 2025 17:56:15 +0200
Message-ID: <87o6sgshnk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgeniy Harchenko <evgeniyharchenko.dev@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	chris.chiu@canonical.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add support for HP EliteBook x360 830 G6 and EliteBook 830 G6
In-Reply-To: <20250815095814.75845-1-evgeniyharchenko.dev@gmail.com>
References: <20250815095814.75845-1-evgeniyharchenko.dev@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Fri, 15 Aug 2025 11:58:14 +0200,
Evgeniy Harchenko wrote:
> 
> The HP EliteBook x360 830 G6 and HP EliteBook 830 G6 have
> Realtek HDA codec ALC215. It needs the ALC285_FIXUP_HP_GPIO_LED
> quirk to enable the mute LED.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Evgeniy Harchenko <evgeniyharchenko.dev@gmail.com>

Applied now.  Thanks.


Takashi

