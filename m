Return-Path: <stable+bounces-241302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GFoGMNW72n5AQEAu9opvQ
	(envelope-from <stable+bounces-241302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:29:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FE5472878
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32655304A588
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170C73B8958;
	Mon, 27 Apr 2026 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i3eee9wh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lCab5OKS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i3eee9wh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lCab5OKS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38E3B8BA5
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292698; cv=none; b=I0fQrEGc/u5AmD6MmAk3RYZM3XohmYFiGavx8gzF+I/nwk7vN8EeYMUBVhcrpxkj5K+3OWfFuyXfeqUXVjAKL7pH5Cna8hTUopre4jxOQ91AsNFSHetS9PR1sGJVJXlmCfa3UdN76fQlalD7BmxB2gEQzE/xhsUNqC6/lpywpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292698; c=relaxed/simple;
	bh=bq6AYtThQM/BlyMoFtz9xPHlbmi6l0J3KGctBQ2eILM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RjTbzlNAznjI4C0EvqnfxnHE/tfeEho57NjxF1x3hYBf+AJM9peI6XmUYT4hCg+3o1S8mDu5U8+rU4lba39iyu5ubpchR7kieLPLCXFGxnAOX5THqqq6Wqtw5DJdake9AoBLLdV0YyUANp/1E4mmdySyV2QJjFMzXAhw9Teu14o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i3eee9wh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lCab5OKS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i3eee9wh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lCab5OKS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 269C55BCCC;
	Mon, 27 Apr 2026 12:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777292694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C41jj0nCRnj394j8mWu8Q6MF3z5QE/59gKEsW6WY6GU=;
	b=i3eee9whuNSVKYnsga7ebZmEC50ZU8QpRUEvEq9By2uC+tq6hpiE3Gkz03L2m6hVVAf9oe
	LU1rwDrlcnLah6j5rdZp8vTTniIygo6l9lqxDNnvGIt72ALU2Iyzjxvn3szq9pT1iwotXb
	dGy/77yZ0D2SG1nKfnaZEYM/XLoucYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777292694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C41jj0nCRnj394j8mWu8Q6MF3z5QE/59gKEsW6WY6GU=;
	b=lCab5OKSGMIwWA2jBbG7OtHd8/LVA7D25eWdMu9l5QNOVhU31lIver6heyeqDvhnmy+p2F
	35/OORK9MaqYwsAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i3eee9wh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lCab5OKS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777292694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C41jj0nCRnj394j8mWu8Q6MF3z5QE/59gKEsW6WY6GU=;
	b=i3eee9whuNSVKYnsga7ebZmEC50ZU8QpRUEvEq9By2uC+tq6hpiE3Gkz03L2m6hVVAf9oe
	LU1rwDrlcnLah6j5rdZp8vTTniIygo6l9lqxDNnvGIt72ALU2Iyzjxvn3szq9pT1iwotXb
	dGy/77yZ0D2SG1nKfnaZEYM/XLoucYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777292694;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C41jj0nCRnj394j8mWu8Q6MF3z5QE/59gKEsW6WY6GU=;
	b=lCab5OKSGMIwWA2jBbG7OtHd8/LVA7D25eWdMu9l5QNOVhU31lIver6heyeqDvhnmy+p2F
	35/OORK9MaqYwsAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D20CC593B0;
	Mon, 27 Apr 2026 12:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r6T7MZVV72myFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Apr 2026 12:24:53 +0000
Date: Mon, 27 Apr 2026 14:24:53 +0200
Message-ID: <877bpszj3e.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] sound: ua101: fix division by zero at probe
In-Reply-To: <20260426111239.103296-1-suunj1331@gmail.com>
References: <20260426111239.103296-1-suunj1331@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: F3FE5472878
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-241302-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, 26 Apr 2026 13:12:39 +0200,
SeungJu Cheon wrote:
> 
> Add a missing sanity check for bNrChannels in detect_usb_format()
> to prevent a division by zero in playback_urb_complete() and
> capture_urb_complete().
> 
> USB core does not validate class-specific descriptor fields such
> as bNrChannels, so drivers must verify them before use. If a
> device provides bNrChannels = 0, frame_bytes becomes zero and is
> later used as a divisor in the URB completion handlers, leading
> to a kernel crash.
> 
> Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>

Thanks, applied now.


Takashi

