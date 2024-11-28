Return-Path: <stable+bounces-95686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D29DB303
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 08:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE087B21D0D
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 07:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89BA1465AC;
	Thu, 28 Nov 2024 07:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cJWtHvbi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SGlRChCr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cJWtHvbi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SGlRChCr"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083F17C7C;
	Thu, 28 Nov 2024 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732777850; cv=none; b=JJxK+QAYNc3QX50U689btslhiHyy6mJWeA9kR5KRI16IiIsSoTd4Cq3kdwIMJk/s4P1rgCgmJteoSXYWbgv0Md4yuro7pjwf+gVQOQy0dob1QrHVHuTa5oFxVRFYNJMo+NXBzYM44+1Pk9RQtuPmOygmFm3/n0UL3xvj83AeXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732777850; c=relaxed/simple;
	bh=9oz5Ct94n4KZwy6DvnBTOjEMWYmoKI8Jb+GWSP+QZfQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SANFWxNE5SHtS9f03MRhen0ZdUtxS4t02e/v0IlM6dAX85TvD2yVSXGvd2JTNU3is2c8cYaLPtfpw9AB9IwmHxodGOnhKwxo2SCK5DfhmLZSrKLJmhxJucTxTUjVKRBJRObBRWz5EuMjNCJhOkTCFUqkvwYNAtA6Y4+im7HgBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cJWtHvbi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SGlRChCr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cJWtHvbi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SGlRChCr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C6EA1F44F;
	Thu, 28 Nov 2024 07:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732777846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y34tiR/NHZkthp77gBUQWQvQMNqHc+34yzGlX0fiW1Q=;
	b=cJWtHvbiEvRfT3LO+czNjU13RZefwP07vXDrvR0HYDQjqHHCMyptivnqYt5IUsgN1kVfCI
	lvwcot9CIqZ+j4KLfMd00Ytvyg1i/uD6rfJ3Zae/RmVW/Ts7/BF1YKtJt4aWLXa2qxzOax
	AuAuj+Rd91zBQ8bigE560DMnu+nE++U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732777846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y34tiR/NHZkthp77gBUQWQvQMNqHc+34yzGlX0fiW1Q=;
	b=SGlRChCrbT6WvZb3BpxR9EotAQqdZ+xPW8khOtBFIH9P/l0JYfVI5VcmENhDcr6kZUs+b1
	GHTc8ge+rwf8cvDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cJWtHvbi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SGlRChCr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732777846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y34tiR/NHZkthp77gBUQWQvQMNqHc+34yzGlX0fiW1Q=;
	b=cJWtHvbiEvRfT3LO+czNjU13RZefwP07vXDrvR0HYDQjqHHCMyptivnqYt5IUsgN1kVfCI
	lvwcot9CIqZ+j4KLfMd00Ytvyg1i/uD6rfJ3Zae/RmVW/Ts7/BF1YKtJt4aWLXa2qxzOax
	AuAuj+Rd91zBQ8bigE560DMnu+nE++U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732777846;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y34tiR/NHZkthp77gBUQWQvQMNqHc+34yzGlX0fiW1Q=;
	b=SGlRChCrbT6WvZb3BpxR9EotAQqdZ+xPW8khOtBFIH9P/l0JYfVI5VcmENhDcr6kZUs+b1
	GHTc8ge+rwf8cvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2D8413690;
	Thu, 28 Nov 2024 07:10:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xsHYLXUXSGeVEAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 28 Nov 2024 07:10:45 +0000
Date: Thu, 28 Nov 2024 08:10:45 +0100
Message-ID: <875xo76dfu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gax-c <zichenxie0106@gmail.com>
Cc: ivan.orlov0322@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	chenyuan0y@gmail.com,
	zzjas98@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: core: Fix possible NULL dereference caused by kunit_kzalloc()
In-Reply-To: <20241128010313.7929-1-zichenxie0106@gmail.com>
References: <20241128010313.7929-1-zichenxie0106@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: 0C6EA1F44F
X-Spam-Score: -2.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,perex.cz,suse.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 28 Nov 2024 02:03:14 +0100,
Gax-c wrote:
> 
> From: Zichen Xie <zichenxie0106@gmail.com>
> 
> kunit_kzalloc() may return a NULL pointer, dereferencing it without
> NULL check may lead to NULL dereference.
> Add NULL checks for all the kunit_kzalloc() in sound_kunit.c
> 
> Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> v2: Add Fixes tag.

The v1 patch was already applied with Fixes tag.


thanks,

Takashi

