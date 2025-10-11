Return-Path: <stable+bounces-184051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A305BCF071
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 08:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04DC3B02E9
	for <lists+stable@lfdr.de>; Sat, 11 Oct 2025 06:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670DD21D3F6;
	Sat, 11 Oct 2025 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OkwYArIG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dpPxog55";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LYfhIj3E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EWw9EcQJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B785626
	for <stable@vger.kernel.org>; Sat, 11 Oct 2025 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164232; cv=none; b=mNNrxISKUB2QA8ZIR44a7hFl8oCxD+D1G/aDK9xLhhIED2NQ9xoEg9KGrnuUmzo9gcem9eFAWgjn6UrBMIbi1TiuS1Ot2YKsn/IaeeHngWhulJIqlr6YaZ2vhW2sCM3N31404T/o9z38+1ccFo3Euy+qLBaeLVytGx0EnwVSv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164232; c=relaxed/simple;
	bh=3aN7aOCB0J/gSZUuDE9BjwChjumxOWgHjaDMf44O3Fg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNJlv0nWlOMGlisjGwHSJXvZ25pGFuMPbC4yxWLDfTEYfXJhQIGXYDsFmIDC2sujPLSn9dWkIK9EPLASo6WiDhwUi0t4z9U8suYd3TcChy2zbGuRj3xJ1ACjxAe8dRgC3mmt62Nbz0yvPR1ORBTaAJ5rtryA7uj54wrDLjHGkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OkwYArIG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dpPxog55; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LYfhIj3E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EWw9EcQJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 087EE2123E;
	Sat, 11 Oct 2025 06:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760164227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMunO0FeGlF1r1p7kWQNyUcoA0ePxiC/C1d6SeWYXTY=;
	b=OkwYArIGcBrCdWn8W0kWFgvOdGRnOaAZDpwkdLCnlb9A/bPQ/6PJXNpJxeby+UEnlr1n5B
	OTGlvAmXUwugwEk+F+X8C3ugrm4iZv+81XTh6ZhmHw/z386kjVvwNU3SSMHlrzwpgEek3v
	PSBi5GDnURjno7od6+1xl1Yr3LmRIfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760164227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMunO0FeGlF1r1p7kWQNyUcoA0ePxiC/C1d6SeWYXTY=;
	b=dpPxog55EcR35vweGLAPKiuTM5Jlo9iXIjM1mlCgeoghhZbABaLKLa77DzIMobx024qfAA
	h1tLlV7JthTN93Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760164226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMunO0FeGlF1r1p7kWQNyUcoA0ePxiC/C1d6SeWYXTY=;
	b=LYfhIj3EG5ZWa1ZtpWHIbLSe+o046J94Px0wriOcJwfyYozZbKn15u35uTShNY03Imi0o3
	9y6B1oukxwK1PxI8wp72ts37QPZbqWHMLsHXCAfZ4X9E+ZE3so5xyXZsH1IyvYboL8Ssmy
	O78yE+3jvRKjQ1MB1mmBxFlIqVqrgHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760164226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kMunO0FeGlF1r1p7kWQNyUcoA0ePxiC/C1d6SeWYXTY=;
	b=EWw9EcQJgfzLMl1t6CNu5S4Inv0HlHX1eKpxLfbdY+QodACF48N90SODTMPL0ciiXVX22k
	1N+ta40aTojw/hCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B22F313693;
	Sat, 11 Oct 2025 06:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ppswKoH56WiHDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 11 Oct 2025 06:30:25 +0000
Date: Sat, 11 Oct 2025 08:30:25 +0200
Message-ID: <87ms5y9chq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Arefev <arefev@swemel.ru>
Cc: David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: cs35l41: Fix NULL pointer dereference in cs35l41_get_acpi_mute_state()
In-Reply-To: <20251007073832.3662-1-arefev@swemel.ru>
References: <20251007073832.3662-1-arefev@swemel.ru>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[swemel.ru:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 07 Oct 2025 09:38:31 +0200,
Denis Arefev wrote:
> 
> Return value of a function acpi_evaluate_dsm() is dereferenced  without
> checking for NULL, but it is usually checked for this function.
> 
> acpi_evaluate_dsm() may return NULL, when acpi_evaluate_object() returns
> acpi_status other than ACPI_SUCCESS, so add a check to prevent the crach.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 447106e92a0c ("ALSA: hda: cs35l41: Support mute notifications for CS35L41 HDA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Applied now.  Thanks.


Takashi

