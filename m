Return-Path: <stable+bounces-262880-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y9qlLR68K2r9DwQAu9opvQ
	(envelope-from <stable+bounces-262880-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:58:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9A6778D6
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:58:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yT3burFH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YKjLqlgu;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yT3burFH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YKjLqlgu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262880-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262880-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BCAA3058085
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 07:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEF938E8BC;
	Fri, 12 Jun 2026 07:55:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F13D524C
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:55:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250927; cv=none; b=FJ2XXd8k5A8VgYjXOD77hReCZEaPHu1vhvERdHcdnko7Z7+p7htXVUv+YGEd4XHtOcexU16F+PxuDqUIr0/AcdNvWncfFI4U+Wyc6VadBeEWYCofg4Tviycq6oyIYEZyj88caZd6V1/pYoLr+vhYfHmeCycojaME2lt1jH4eljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250927; c=relaxed/simple;
	bh=inujiCA5hvuaz3CgdB2gtr+lHjATxCGlyFZzEYPmi7w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfNwZ+hlduEClcHo5WcYRUCYSs7wE7oAYbrbY/uBccsp33k2rcBs2Q54UKk2detiN60mJQr8Xc4yhDEKuC8Kd1sqecg53wnEhGrMnxOe/cICgWiE9dlYSXvW/R4NlDm4SkTuhUBmv4NQjv5mFtyDD7WsBBXCdhRnEA0tfPWC1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yT3burFH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YKjLqlgu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yT3burFH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YKjLqlgu; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B265875B21;
	Fri, 12 Jun 2026 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781250921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qba5IcKrzlixBbsatu0TxnPcO9fOzTi1MgdskkLYKTQ=;
	b=yT3burFHSworYcZeRKQHynFhTvSYTrb9IW/EhhyhJ/og3rsABM5Pa3Hl6Bno0Zekq7Rcxw
	0ozLH6KGQsD6OE7o9SKDy0sleGrgjhkQWG0eSbYDUVKUXVf3juBEbTI6Rh1xD/hwvOJoaH
	NEeU5rfW12J51c07YkBeCenKiMnB1t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781250921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qba5IcKrzlixBbsatu0TxnPcO9fOzTi1MgdskkLYKTQ=;
	b=YKjLqlgunLiz2GebZaBUC4uat91vLpsszJqk8BLlSPmtR0/E1KCUsyjA7l5+oZbBj6hbVp
	WitLDFlPG4kPzaDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781250921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qba5IcKrzlixBbsatu0TxnPcO9fOzTi1MgdskkLYKTQ=;
	b=yT3burFHSworYcZeRKQHynFhTvSYTrb9IW/EhhyhJ/og3rsABM5Pa3Hl6Bno0Zekq7Rcxw
	0ozLH6KGQsD6OE7o9SKDy0sleGrgjhkQWG0eSbYDUVKUXVf3juBEbTI6Rh1xD/hwvOJoaH
	NEeU5rfW12J51c07YkBeCenKiMnB1t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781250921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qba5IcKrzlixBbsatu0TxnPcO9fOzTi1MgdskkLYKTQ=;
	b=YKjLqlgunLiz2GebZaBUC4uat91vLpsszJqk8BLlSPmtR0/E1KCUsyjA7l5+oZbBj6hbVp
	WitLDFlPG4kPzaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 692F6779A7;
	Fri, 12 Jun 2026 07:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1dBgGGm7K2qmJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Jun 2026 07:55:21 +0000
Date: Fri, 12 Jun 2026 09:55:21 +0200
Message-ID: <87wlw4i45y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	chenziqing@xiaomi.com,
	broonie@kernel.org,
	cezary.rojewski@intel.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: Fix power refcount leak in snd_ctl_elem_read_user
In-Reply-To: <20260612022702.15371-1-vulab@iscas.ac.cn>
References: <20260612022702.15371-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30
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
	TAGGED_FROM(0.00)[bounces-262880-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:perex@perex.cz,m:tiwai@suse.com,m:chenziqing@xiaomi.com,m:broonie@kernel.org,m:cezary.rojewski@intel.com,m:kees@kernel.org,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:dkim,suse.de:mid,suse.de:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16F9A6778D6

On Fri, 12 Jun 2026 04:27:02 +0200,
WenTao Liang wrote:
> 
> snd_power_ref_and_wait() increments the power refcount before waiting.
> When it returns an error (e.g., -ENODEV due to card shutdown), the
> refcount is still held, as documented in its comment:
> 
>   "The caller needs to pull down the refcount via snd_power_unref()
>    later no matter whether the error is returned from this function
>    or not."
> 
> snd_ctl_elem_read_user() fails to release this refcount on the error
> path, leaking a reference. This can impede proper card resource
> cleanup during shutdown sequences.
> 
> Fix by calling snd_power_unref() before returning the error.
> 
> Cc: stable@vger.kernel.org
> Fixes: fcc62b19104a ("ALSA: control: Take power_ref lock primarily")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Your all other patches for sound/core/* look like similar fixes, and
should be better put in a single fix patch.  If need to split to
multiple patches, though, please send a series of patches in a thread,
instead, at the next time.


thanks,

Takashi

