Return-Path: <stable+bounces-56201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A791D8A6
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 09:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 042BB281627
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 07:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D8E60BBE;
	Mon,  1 Jul 2024 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="agxOA7Sm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xGl3+u28";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Th2fWMW1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EE14GiBt"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7622AD05;
	Mon,  1 Jul 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818002; cv=none; b=MnJNlB4XnBtF4wJtIvyNU1VY79ckOujXNviqxcxa30rOLs+n8y3M8S0aR+7wWjw2kYrMghccymUwOF2D/FpI6f7mN4j+N2BGtP/ci0ppgg+uKLsRJhUj3Y8zLJNv3FZlWWkazzCPmQbzGKAtqkjnbWRHU06i+5jTVvHJsHDBxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818002; c=relaxed/simple;
	bh=qUAkfJVWtPqbt4jLO5JajCL6NEIKpRiTrpsx0py35n8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVy/vnqt34LcdOgIl+EgxbZ2ZtTHPyTtF4LdE12Yszx6JodzWBjZvPU0lPTlt5GhHkkZt36Qn3gZ4j6WEFJiZxY3lJJynrQHP1posjLT5fCC7edLWV63XR8ueZNwoPGX/mdNgIUjPFtziyE8v1OLh/f4OTt5aox1F1zyGNm78rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=agxOA7Sm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xGl3+u28; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Th2fWMW1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EE14GiBt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D872521AC4;
	Mon,  1 Jul 2024 07:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719817993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RntfX8icZol8M8rrp5guiSaR0MaQ5iQBleFBw6EU+ME=;
	b=agxOA7SmcIn1byZ/ZvwfTRjQLi1CUcSqmOI+MZncs9FfpxmRV+FmQ+kefAyGlk46HAU+6V
	+q9IiVeP9TCd67G0FsqSB6zvhDOkvXP2wI1j1KDeHyGmOGWUa6onfurVEe4LoueD5aRjmZ
	TPr4ZiL6jn3gjR6dVTf8lGTFNiseSI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719817993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RntfX8icZol8M8rrp5guiSaR0MaQ5iQBleFBw6EU+ME=;
	b=xGl3+u28BKWvdWFJd76MPeG8IVKbqyD6OyLKgB01eY6jtR6k+TEhtV3lbcJ6Ts1Ee0JDXM
	ZIOTNO7aC1LETPCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719817992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RntfX8icZol8M8rrp5guiSaR0MaQ5iQBleFBw6EU+ME=;
	b=Th2fWMW1v12RsTvEle8mT0d4qTokMLn9WNJ+HKq+0KyzRT8rpA9+yUVQwBZDR7UotBEkQk
	3urM9wkja4tn8av58E4A2mTShNT0nlcTUxejfNeiuOaUR0oZHMl6aI/bl476bhc++nVkXw
	NMNofmmcH2fygWMd5OaIKoCCXNm7Y30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719817992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RntfX8icZol8M8rrp5guiSaR0MaQ5iQBleFBw6EU+ME=;
	b=EE14GiBtMgFFNDolbGLpPLz8I3c6al+BgVenqD/8nuWTMoc/eyl96gC6XTi28Cus1ugweU
	krqX21puNrcDPuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80BB6139C2;
	Mon,  1 Jul 2024 07:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I9cTHghXgmaOawAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 01 Jul 2024 07:13:12 +0000
Date: Mon, 01 Jul 2024 09:13:41 +0200
Message-ID: <87wmm5a8ka.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	broonie@kernel.org,
	shenghao-ding@ti.com,
	sbinding@opensource.cirrus.com,
	lukas.bulwahn@gmail.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.6 11/12] ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
In-Reply-To: <20240701001342.2920907-11-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
	<20240701001342.2920907-11-sashal@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.77 / 50.00];
	BAYES_HAM(-2.97)[99.85%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,opensource.cirrus.com,suse.de,perex.cz,suse.com,kernel.org,ti.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.77
X-Spam-Level: 

On Mon, 01 Jul 2024 02:13:30 +0200,
Sasha Levin wrote:
> 
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> [ Upstream commit 9b1effff19cdf2230d3ecb07ff4038a0da32e9cc ]
> 
> The ACPI IDs used in the CS35L56 HDA drivers are all handled by the
> serial multi-instantiate driver which starts multiple Linux device
> instances from a single ACPI Device() node.
> 
> As serial multi-instantiate is not an optional part of the system add it
> as a dependency in Kconfig so that it is not overlooked.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Link: https://lore.kernel.org/20240619161602.117452-1-simont@opensource.cirrus.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This change breaks random builds, so please pick up a follow-up fix
17563b4a19d1844bdbccc7a82d2f31c28ca9cfae
    ALSA: hda: Use imply for suggesting CONFIG_SERIAL_MULTI_INSTANTIATE
too.


thanks,

Takashi

