Return-Path: <stable+bounces-237769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XnCdE9YH3mmvmQkAu9opvQ
	(envelope-from <stable+bounces-237769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:24:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B78223F7DB7
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D44D8302D539
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777BF3BE64C;
	Tue, 14 Apr 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GMhcB/pa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FH6LDq0g";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GMhcB/pa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FH6LDq0g"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192DB3BE16C
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158595; cv=none; b=tPArFmXDJanxbs93Sd7g9XVXikuofr/bi5BYqDQQWaAfIy+IBzJxfLj5mF8KqLKocw53fw6U9cHB5tUPGGUafn7t/nJ7FRaRRI4a5VJV49NFo7fOb71+F7kF6BHzaE4NA3j+j0Eo2UXAJcpA3BHvzXzE+PbH9iPaeIzG7HvePpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158595; c=relaxed/simple;
	bh=KTBUlGMJYr9IGuriA/svTsS3bHGoYMYFfmYh9bcrGHM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIhlh++KpHoyUpDM03cedIheQ0tNKAtjjsAF/VrRlnqUU6SN/F7ndxgybIm1VObD9hhFnUoWjobS8hc9F/bIT1yFdjyVTpR5qWcFv1WV1tKqsRdwTdDrzICV7Xhn6oV8HwTfzud4V4HT609A684KhzrCub5N3pGHOdZRYg2WmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GMhcB/pa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FH6LDq0g; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GMhcB/pa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FH6LDq0g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EF985BD6B;
	Tue, 14 Apr 2026 09:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776158590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDQq2EjT4xNSu90VwfSW/Tt5LnrBIUXr0GnN405XN1I=;
	b=GMhcB/pa5SzbYdGHQO3Wr/PFo6nuPDRjZ584QUkrXZQwztPNOSt2Sr44XvP0KXFMk5TkM1
	TysMyQTrGNPMgL0Q7+8cwlY3wSeiJIG8wVCZ58VQKCaDpmie0p+aph32TwetwZOKuS7pKH
	E2/S4WHwUtEnpC0PEmBqauVO5GTNHJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776158590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDQq2EjT4xNSu90VwfSW/Tt5LnrBIUXr0GnN405XN1I=;
	b=FH6LDq0gNCbzcAhMiAaGddh/kp4qTDxfbhOMptj/Xt+lq3MAOwKquVMRiVJGgW44ew0DFD
	EpgTnR+5eTKQKZAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776158590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDQq2EjT4xNSu90VwfSW/Tt5LnrBIUXr0GnN405XN1I=;
	b=GMhcB/pa5SzbYdGHQO3Wr/PFo6nuPDRjZ584QUkrXZQwztPNOSt2Sr44XvP0KXFMk5TkM1
	TysMyQTrGNPMgL0Q7+8cwlY3wSeiJIG8wVCZ58VQKCaDpmie0p+aph32TwetwZOKuS7pKH
	E2/S4WHwUtEnpC0PEmBqauVO5GTNHJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776158590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aDQq2EjT4xNSu90VwfSW/Tt5LnrBIUXr0GnN405XN1I=;
	b=FH6LDq0gNCbzcAhMiAaGddh/kp4qTDxfbhOMptj/Xt+lq3MAOwKquVMRiVJGgW44ew0DFD
	EpgTnR+5eTKQKZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20BC94B389;
	Tue, 14 Apr 2026 09:23:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0MzABn4H3mkwSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 14 Apr 2026 09:23:10 +0000
Date: Tue, 14 Apr 2026 11:23:09 +0200
Message-ID: <87pl41sxoi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ziqing Chen <chenziqing@xiaomi.com>
Cc: <tiwai@suse.com>,
	<perex@perex.cz>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [PATCH] ALSA: control: Validate buf_len before strnlen() in snd_ctl_elem_init_enum_names()
In-Reply-To: <20260414090542.151447-1-chenziqing@xiaomi.com>
References: <20260414090542.151447-1-chenziqing@xiaomi.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237769-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,xiaomi.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B78223F7DB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 11:05:42 +0200,
Ziqing Chen wrote:
> 
> snd_ctl_elem_init_enum_names() advances pointer p through the names
> buffer while decrementing buf_len. If buf_len reaches zero but items
> remain, the next iteration calls strnlen(p, 0).
> 
> While strnlen(p, 0) returns 0 and would hit the existing name_len == 0
> error path, CONFIG_FORTIFY_SOURCE's fortified strnlen() first checks
> maxlen against __builtin_dynamic_object_size(). When Clang loses track
> of p's object size inside the loop, this triggers a BRK exception panic
> before the return value is examined.
> 
> Add a buf_len == 0 guard at the loop entry to prevent calling fortified
> strnlen() on an exhausted buffer.
> 
> Found by kernel fuzz testing through Xiaomi Smartphone.
> 
> Fixes: 8d448162bda5 ("ALSA: control: add support for ENUMERATED user space controls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziqing Chen <chenziqing@xiaomi.com>
> ---
>  sound/core/control.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/core/control.c b/sound/core/control.c
> index 0ddade871b52..6ceb5f977fcd 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -1574,6 +1574,10 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
>         /* check that there are enough valid names */
>         p = names;
>         for (i = 0; i < ue->info.value.enumerated.items; ++i) {
> +               if (buf_len == 0) {
> +                       kvfree(names);
> +                       return -EINVAL;
> +               }
>                 name_len = strnlen(p, buf_len);
>                 if (name_len == 0 || name_len >= 64 || name_len == buf_len) {
>                         kvfree(names);

Having a zero buf_len check is good, per se, but it doesn't have to be
at this late place.  It can be checked at the very beginning even
before the allocation (where we have already an upper bound check),
instead.

Could you test it and resubmit if that works?


thanks,

Takashi

