Return-Path: <stable+bounces-224529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGXEAPRUsGkJiQIAu9opvQ
	(envelope-from <stable+bounces-224529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:29:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC0F25594B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5353431CA482
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B483D1710;
	Tue, 10 Mar 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kqnAEbB6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oBfW7J5Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kqnAEbB6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oBfW7J5Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41EF2949E0
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163509; cv=none; b=cvHNsTXpC8EWQMntShPDOFKe+/XmtJAn4CtxLQveXegixOQc/C0r+MmpEHCFE/79167xf+yqr5bgmdA9E87X6mtVmaUMkPqXPL2v9OAR6ao6L05r7rvHy+Gsih15P+qq5jTJmtI7IxUNyRe+ArKdD6dJyVsILfJ8X6nWuA6EsWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163509; c=relaxed/simple;
	bh=X9K8266PYIrXt/mDmGLTxbtOIt/CN7sNaos1k59WePw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFgx+J7lm7Bf6ZjU7ROzVJUOE3f+1bKa1aroGJHrzeAY30UYtoTdF47RBJMOJneCzQKDJPlvJaF1EXdhCgVn8h4nUOtNCf+lVG1e4WR9aj6JBQOADBrMruyahj8tpY17pm5HkY62SmHVsJYCAFkZExYmp14lx+ZCcL16PWbOJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kqnAEbB6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oBfW7J5Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kqnAEbB6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oBfW7J5Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5159C5BCFF;
	Tue, 10 Mar 2026 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773163506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ankmUMc4iLPKVU5XNjpVjNeLZP7KF9IDia47WayHwPg=;
	b=kqnAEbB6bdJEn562AkPjZoUnrp5Rzhp3tmSo/mQmvYH5u3CwbGtJ4SLW2cc9m+vAUDjafn
	K2IxbKgI/uUcOuez1nrKnD7rFWfcK+Pi+9uBTByyNiva24/n1tQZ/IVhW1xD9qAvfpXqdk
	Yt3HSkfXl9MCca47pfhoManjYiW+30M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773163506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ankmUMc4iLPKVU5XNjpVjNeLZP7KF9IDia47WayHwPg=;
	b=oBfW7J5QgzG30SIa3KuBzCNLFXOdUBmFEwAa3so+ABEdEjYu57PjNP0ia2kRZxZKIjUOeT
	zX5Wv3c5vX0L2qCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773163506; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ankmUMc4iLPKVU5XNjpVjNeLZP7KF9IDia47WayHwPg=;
	b=kqnAEbB6bdJEn562AkPjZoUnrp5Rzhp3tmSo/mQmvYH5u3CwbGtJ4SLW2cc9m+vAUDjafn
	K2IxbKgI/uUcOuez1nrKnD7rFWfcK+Pi+9uBTByyNiva24/n1tQZ/IVhW1xD9qAvfpXqdk
	Yt3HSkfXl9MCca47pfhoManjYiW+30M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773163506;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ankmUMc4iLPKVU5XNjpVjNeLZP7KF9IDia47WayHwPg=;
	b=oBfW7J5QgzG30SIa3KuBzCNLFXOdUBmFEwAa3so+ABEdEjYu57PjNP0ia2kRZxZKIjUOeT
	zX5Wv3c5vX0L2qCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B9523F585;
	Tue, 10 Mar 2026 17:25:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mZ89BfJTsGkOUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Mar 2026 17:25:06 +0000
Date: Tue, 10 Mar 2026 18:25:05 +0100
Message-ID: <87tsunppfy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mehul Rao <mehulrao@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcm: fix use-after-free on linked stream runtime in snd_pcm_drain()
In-Reply-To: <CAMNhdctTJYdzQvv1MtZtqUjYSjrtiu_6J6E9eQJSjx-wmXfWKg@mail.gmail.com>
References: <20260305193508.311096-1-mehulrao@gmail.com>
	<87qzpttm77.wl-tiwai@suse.de>
	<CAMNhdctTJYdzQvv1MtZtqUjYSjrtiu_6J6E9eQJSjx-wmXfWKg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7AC0F25594B
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
	TAGGED_FROM(0.00)[bounces-224529-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:dkim,suse.de:mid]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 18:11:19 +0100,
Mehul Rao wrote:
> 
> 
> Hi Takashi,  
> 
> Thanks for applying!
> 
> It was found through an LLM-assisted static analysis pipeline that scans
> kernel subsystems for concurrency bugs, then verified with KASAN by writing a
> PoC that races snd_pcm_drain() against snd_pcm_close() on linked snd-dummy
> substreams from two threads.
> 
> The race window is narrow, so I injected a msleep(50) between the unlock and
> the runtime field access to reliably trigger the KASAN splat
> (slab-use-after-free in snd_pcm_drain). Without the delay it didn't fire in
> 3000 iterations though.
> 
> Please let me know if you would like these kinds of patches in the future. I
> am new to kernel development and this was one of my first patches. I am trying
> to learn as I go.

Sure, more fixes in this level of good quality are appreciated.


thanks,

Takashi

