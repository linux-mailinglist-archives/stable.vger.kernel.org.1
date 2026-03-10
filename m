Return-Path: <stable+bounces-224527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOgLIxlTsGmBiAIAu9opvQ
	(envelope-from <stable+bounces-224527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:21:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C97255740
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 18:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28EF53059807
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8E2D3739;
	Tue, 10 Mar 2026 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uLi3m8uE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lmZvTPXk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uLi3m8uE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lmZvTPXk"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865653D0901
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163267; cv=none; b=nOCTYYQ2HDEozvgfh8CGZme7X+YmjIgeun8vIqiLnrBLh5YaqPVcVtfyrBNmXe2/vI+KsUs6uji10TPZ7G1isc4qsJkzu48pNDb3gtrU63VpCv4Qp4+KNVM4vjDVX2pznc2RE6tqDjvYxQ3TjCOtZhU8wycBE+llg7VB/Sl6gbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163267; c=relaxed/simple;
	bh=K0ZRzDvM8SkxEsbysp9oFli6kLPgNyFze32bPnUgZnE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksi0x6YXGZUF/yVvruzFQ5isZ9wM/j6q8IRC7WBDP/WpPfF1mNCdpqCxzNKjLnVjWyJnd/i5vvAkCtCIJBR1Q0sUupk9ymxhcb8/VxjyYgJXCQNPy6DVus3oim8vIWDhoncDt4KxQqfasKdDIXbaD3vC5CoTPA/dzQuAAUxBaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uLi3m8uE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lmZvTPXk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uLi3m8uE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lmZvTPXk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65F5A4D284;
	Tue, 10 Mar 2026 17:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773163263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	b=uLi3m8uEruaUUhwUyaLTSMGbRT4y3yBVsIWYMeiUXG5iLKKyBtxDKlTGkBXSSkFY1XkcTE
	VP+ZO50LbDnrpU0DtlfZbMuwnfD+v4wNZSsL6k4cicAHf1VFzfaASUX7lckHb+xs1F7PN+
	UrG/XLFceNkWGRl+aZ2z4C1PeC/190g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773163263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	b=lmZvTPXkWQgzHmoANvB8p+i3TUbr1VU54OrAinVMc2iQhNQzbdOOiL1VKu5naHMb9OiAFZ
	CHe0+EAbtKdLx0Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uLi3m8uE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lmZvTPXk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773163263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	b=uLi3m8uEruaUUhwUyaLTSMGbRT4y3yBVsIWYMeiUXG5iLKKyBtxDKlTGkBXSSkFY1XkcTE
	VP+ZO50LbDnrpU0DtlfZbMuwnfD+v4wNZSsL6k4cicAHf1VFzfaASUX7lckHb+xs1F7PN+
	UrG/XLFceNkWGRl+aZ2z4C1PeC/190g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773163263;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd4HCw16AO/h0kHzWXcAUQ225vWTAP/sWpAzSj5/tKk=;
	b=lmZvTPXkWQgzHmoANvB8p+i3TUbr1VU54OrAinVMc2iQhNQzbdOOiL1VKu5naHMb9OiAFZ
	CHe0+EAbtKdLx0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAFAE3F581;
	Tue, 10 Mar 2026 17:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t8XWN/xSsGmyTAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Mar 2026 17:21:00 +0000
Date: Tue, 10 Mar 2026 18:21:00 +0100
Message-ID: <87y0jzppmr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Takashi Iwai <tiwai@suse.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: aoa: Skip devices with no codecs in i2sbus_resume()
In-Reply-To: <933E291B-23F2-4144-80F0-EC5730F65B75@linux.dev>
References: <20260310102921.210109-3-thorsten.blum@linux.dev>
	<878qbzradt.wl-tiwai@suse.de>
	<933E291B-23F2-4144-80F0-EC5730F65B75@linux.dev>
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
X-Rspamd-Queue-Id: 14C97255740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224527-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 17:30:01 +0100,
Thorsten Blum wrote:
> 
> On 10. Mar 2026, at 16:07, Takashi Iwai wrote:
> > On Tue, 10 Mar 2026 11:29:20 +0100, Thorsten Blum wrote:
> >> --- a/sound/aoa/soundbus/i2sbus/core.c
> >> +++ b/sound/aoa/soundbus/i2sbus/core.c
> >> @@ -405,6 +405,9 @@ static int i2sbus_resume(struct macio_dev* dev)
> >> 	int err, ret = 0;
> >> 
> >> 	list_for_each_entry(i2sdev, &control->list, item) {
> >> +		if (list_empty(&i2sdev->sound.codec_list))
> >> +			continue;
> > 
> > This can be even outside the loop and immediately return 0, as the
> > remaining part is also the loop of codec_list.
> 
> The i2sdev pointer is only assigned by the outer list_for_each_entry(),
> which iterates the controller's device list. Since each device has its
> own codec list, list_empty(&i2sdev->sound.codec_list) must be checked
> inside the loop; before the loop i2sdev is uninitialized.

Ah indeed.  Now I applied to for-next branch.


thanks,

Takashi

