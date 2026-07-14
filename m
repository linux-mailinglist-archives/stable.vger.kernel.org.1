Return-Path: <stable+bounces-274172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lj3gGGzoVWrXvQAAu9opvQ
	(envelope-from <stable+bounces-274172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 09:42:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC6752020
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 09:42:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SktocTuN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZtMRnGOv;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SktocTuN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZtMRnGOv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274172-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274172-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6936E303DD20
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664482F8E94;
	Tue, 14 Jul 2026 07:42:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC433DA7C8
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 07:42:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014942; cv=none; b=FVNgFmVgDGYndFYfGn3rZP+c7U9w41ro6WMv1NNvaZ+R3oHPEAkTKXEAFCc8hwieArYf0h2i4B/J5f7NuSDqB/aDYxmeP/BD45Wlcriqewy1PNYLiGOUb2TI1Mnuuie7Km5muxGKW93JQbmaRa3iflOGwfmiwCl4RBGdGx5DSDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014942; c=relaxed/simple;
	bh=1UVCl5SzEx8F5RS38zfiQUEwERndu9AN2P0HJOWQERE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0XBmi/gZ346tBjS1Bh7tkDNJowDDsy98wXMppD6xWHX54d84TS/3jDoo+ZLe5BJJV8rD7pG2RratUdB+m1i/upDoi868f9JCz9u2Z9lagnpKmHgcsFYHQev7IIp5fT8tbBzXk/7buV3U/KBhWzum2t/SJiKOljAnlgNhoF4tEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SktocTuN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZtMRnGOv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SktocTuN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZtMRnGOv; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDEF877D43;
	Tue, 14 Jul 2026 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784014937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTbA7GhlPQM6AhqTPDoE4nGiTmzPf2D9WJB8lE7ePg=;
	b=SktocTuN9M6l6MFa29iT9xyXn0fMCI9RYcUoolxwTaKbLYLbCv/jVCzPlJrhahoLwJtyGx
	Ja+FIuh8jE4pE7w3WjdP5YrC9wRXYlxyyyxfkQxta9qn0bmrJxzqniO2TE0aD5iqIyL7gF
	1Mz49SHRpXlurzaegsIB4QrrRPc4kVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784014937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTbA7GhlPQM6AhqTPDoE4nGiTmzPf2D9WJB8lE7ePg=;
	b=ZtMRnGOv7ndcQQYTp+U9dE8F65vk49Qq4zA883sSaP43f2w3gW+eSHS16pqLgfifZ0+s+E
	4VkA/aSDmNv9mZCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784014937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTbA7GhlPQM6AhqTPDoE4nGiTmzPf2D9WJB8lE7ePg=;
	b=SktocTuN9M6l6MFa29iT9xyXn0fMCI9RYcUoolxwTaKbLYLbCv/jVCzPlJrhahoLwJtyGx
	Ja+FIuh8jE4pE7w3WjdP5YrC9wRXYlxyyyxfkQxta9qn0bmrJxzqniO2TE0aD5iqIyL7gF
	1Mz49SHRpXlurzaegsIB4QrrRPc4kVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784014937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTbA7GhlPQM6AhqTPDoE4nGiTmzPf2D9WJB8lE7ePg=;
	b=ZtMRnGOv7ndcQQYTp+U9dE8F65vk49Qq4zA883sSaP43f2w3gW+eSHS16pqLgfifZ0+s+E
	4VkA/aSDmNv9mZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D5B3779AE;
	Tue, 14 Jul 2026 07:42:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NFVAJVnoVWpgfwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 14 Jul 2026 07:42:17 +0000
Date: Tue, 14 Jul 2026 09:42:17 +0200
Message-ID: <87se5myq3q.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: cancel pending IN work before freeing the midi object
In-Reply-To: <20260709150717.399083-1-fanwu01@zju.edu.cn>
References: <20260709150717.399083-1-fanwu01@zju.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274172-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:linux-usb@vger.kernel.org,m:gregkh@linuxfoundation.org,m:tiwai@suse.de,m:linux-kernel@vger.kernel.org,m:linux-sound@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:from_mime,suse.de:dkim,suse.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,zju.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0FC6752020

On Thu, 09 Jul 2026 17:07:17 +0200,
Fan Wu wrote:
> 
> The f_midi driver embeds a work item (midi->work) whose handler,
> f_midi_in_work(), dereferences the enclosing struct f_midi through
> container_of().  This work is armed from two sites: f_midi_complete(),
> on a normal IN-endpoint completion, and f_midi_in_trigger(), on an ALSA
> rawmidi output-stream start.
> 
> Neither f_midi_disable() nor f_midi_unbind() cancels midi->work.
> f_midi_disable() only disables the endpoints and drains the in_req_fifo;
> it does not synchronize the work item, and the sound card is released
> asynchronously to the final free of the midi object.
> 
> The midi object is reference-counted (midi->free_ref) and is freed in
> f_midi_free() only once both the usb_function reference and the rawmidi
> private_data reference have been dropped.  In f_midi_unbind(),
> f_midi_disable() runs before the sound card is released, so while the
> USB endpoints are already disabled the rawmidi device is still usable by
> an open substream.  A concurrent userspace write on such a substream can
> reach f_midi_in_trigger() and queue midi->work again after
> f_midi_disable() has returned.  A work item armed this way may still be
> pending when the last reference drops and f_midi_free() proceeds to
> kfree(midi), letting f_midi_in_work() dereference the struct after it
> has been freed, a use-after-free.
> 
> For this reason cancelling midi->work in f_midi_disable() would not be
> sufficient: the ALSA trigger path can rearm the work after disable()
> returns.  Cancelling at the refcount-zero free site is the boundary
> after which neither arming source can survive, because by then both
> references that keep the midi object alive have been dropped: the USB
> endpoints are already disabled and the rawmidi device has been released.
> 
> Fix this by calling cancel_work_sync(&midi->work) in the refcount-zero
> block of f_midi_free(), before the embedded work_struct is freed along
> with the rest of the structure.  opts->lock is a sleeping mutex, so
> calling cancel_work_sync() under it is permitted, and the handler takes
> midi->transmit_lock rather than opts->lock, so no self-deadlock can
> occur while it waits for a running instance of the work to finish.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: 8653d71ce3763 ("usb/gadget: f_midi: Replace tasklet with work")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
>  drivers/usb/gadget/function/f_midi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
> index 4d9e4bd70..fba8cf787 100644
> --- a/drivers/usb/gadget/function/f_midi.c
> +++ b/drivers/usb/gadget/function/f_midi.c
> @@ -1309,6 +1309,7 @@ static void f_midi_free(struct usb_function *f)
>  	opts = container_of(f->fi, struct f_midi_opts, func_inst);
>  	mutex_lock(&opts->lock);
>  	if (!--midi->free_ref) {
> +		cancel_work_sync(&midi->work);
>  		kfree(midi->id);
>  		kfifo_free(&midi->in_req_fifo);
>  		kfree(midi);

I guess disable_work_sync() would be even safer in this case.


thanks,

Takashi

