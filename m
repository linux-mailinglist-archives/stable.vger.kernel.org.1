Return-Path: <stable+bounces-238276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H0CH8Kl4GkEkgAAu9opvQ
	(envelope-from <stable+bounces-238276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:02:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85940BF3B
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7656E3080791
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6633921FF;
	Thu, 16 Apr 2026 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hxILrxRY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kDYVhYqs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mN0gdmgD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iHwYWYML"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38719381B1B
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329860; cv=none; b=n0tweR/DZjI1CqGZDseMCptIuLq5dLB5ZCN/PWmPBc3krOFmGWd/DSFq9D5eZGJxQ6Oy3gtfZTeY9BI6Gs850IsUgHsQQCGuJtB21mXiCj+FdLFMFOrnHmj1CixHNXy7XH3kRoZHF0HwDaRvbYNmus3fI7ry1hRWm5MoXYs2kDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329860; c=relaxed/simple;
	bh=ofvukmhZd/tQ/OgUruA+KBobhi/wYLsOepChT+YCaIw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALNebAyFjZ9/1U0YJQPaFW/bL4+7ShYYa5bJx8a5E8zOaVgd7DXdLeUIpU/JIYyFf+57s+/QpdRyDyLCOPxIaGaXmyj2l3aVOHccYS50CRy53et1D+ok+YcEwhtIl+tPa86FYjKbYwyyISRSYklR9Y8nIWH6m3ecthAJvbzj8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hxILrxRY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kDYVhYqs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mN0gdmgD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iHwYWYML; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DE40C5BD11;
	Thu, 16 Apr 2026 08:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776329852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQvNnGry76qxPYC6clCvGh41W0kGFBVU/d9VjmQrVwc=;
	b=hxILrxRYIWuKaqr433r6SmPTr1FWPrHFvywEB8kTTGkqwTWBW9zLxrhgL2/Pgk9NSUhLIT
	XjXP5ZCQi9NcO903Rw0DHozfa9reQvzSNhKGmsjaoOtGDCzdE0XszbuED1o8mtLkZ4MMlF
	fIHiyUXBJn2Q1vdBg9eG/uNJpnuFbqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776329852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQvNnGry76qxPYC6clCvGh41W0kGFBVU/d9VjmQrVwc=;
	b=kDYVhYqswPmpwf+RtymwAHQ5FehPVHs8UqJlqZb2Nha3o3F6h8usWqhr+g0DQszLzNXkcf
	jEdiWXM00H2catAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776329851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQvNnGry76qxPYC6clCvGh41W0kGFBVU/d9VjmQrVwc=;
	b=mN0gdmgDUEZfzfC8yh0iwEe24K2LPVpgV7Y4WI19KlnbVdlQYerIsPMV7Jxx1hzbPEd9iB
	czs9Mi0ZXNV6qppleymCDk13jU3k5OlrxeVs8/8fnV2wkIRL0fxXlehfJmUNmunviPqyq/
	s5nqGOzGDDl293LJCqcOsfDb14HzOe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776329851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQvNnGry76qxPYC6clCvGh41W0kGFBVU/d9VjmQrVwc=;
	b=iHwYWYMLBqAbiOG7qeE2wgYxcKr/AqDZd+2iVAF5v/yfCceksnDF/YxbjCxRZdfehTmtEC
	q2ZhiQNqH2SaG8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F6034BE97;
	Thu, 16 Apr 2026 08:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PR/SIXuk4GmtSgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 Apr 2026 08:57:31 +0000
Date: Thu, 16 Apr 2026 10:57:31 +0200
Message-ID: <87340vffk4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Xi Wang <xi.wang@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	stable@vger.kernel.org,
	syzbot+d56178c27a4710960820@syzkaller.appspotmail.com
Subject: Re: [PATCH] ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES
In-Reply-To: <20260415-usb-audio-uac2-rate-cap-v1-1-5ecbafc120d8@gmail.com>
References: <20260415-usb-audio-uac2-rate-cap-v1-1-5ecbafc120d8@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,gmail.com,vger.kernel.org,suse.de,syzkaller.appspotmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238276-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,d56178c27a4710960820];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF85940BF3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 17:04:53 +0200,
Cássio Gabriel wrote:
> 
> parse_uac2_sample_rate_range() caps the number of enumerated
> rates at MAX_NR_RATES, but it only breaks out of the current
> rate loop. A malformed UAC2 RANGE response with additional
> triplets continues parsing the remaining triplets and repeatedly
> prints "invalid uac2 rates" while probe still holds
> register_mutex.
> 
> Stop the whole parse once the cap is reached and return the
> number of rates collected so far.
> 
> Fixes: 4fa0e81b8350 ("ALSA: usb-audio: fix possible hang and overflow in parse_uac2_sample_rate_range()")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+d56178c27a4710960820@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d56178c27a4710960820
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Thanks, applied now.


Takashi

