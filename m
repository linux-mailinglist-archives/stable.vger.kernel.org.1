Return-Path: <stable+bounces-231025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG/COqIoymnX5gUAu9opvQ
	(envelope-from <stable+bounces-231025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:39:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA263568C9
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB42F30268AB
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB263A4F26;
	Mon, 30 Mar 2026 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2YkWa7ta";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oCbPaxCI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q9ylU2Ra";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HHYrvATc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB43A3815
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856187; cv=none; b=Aym5/F82046A4Z+XM/h6VhtHiYu0D+YWcMMO8A5WCk7xx5H+YwGHQLk18txLb2FoYmAvFIsS4vsI0lEmh5KTc5yX4kbulL9+ijziESYp8awgLsG1UWtwNV5NfDMVB+Yee93oRHkZQte3DYCcdJPBAJlTXJAASguyM3rzv/dWl0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856187; c=relaxed/simple;
	bh=Ke/o+Q9bQvtNMDDALbbIFWFvrpI8D41nq6zTfuieJ6w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXxbn6imAqQc2RU9/yTz1NdSFgTHc9KK3kSFWW4NqdjGBseBRLaHApaNgeQdd3akZS5pi8rHvIKrNEaCf/Rm7o6GFestKzbRRWNOlsWCAlbSI1+OMlWWzaq/uLHhvcJVeFpa8bqodZs3pvmXFWwgSIRWX00cz+5LGVKQGV/0dVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2YkWa7ta; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oCbPaxCI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q9ylU2Ra; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HHYrvATc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 210045BE85;
	Mon, 30 Mar 2026 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774856181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	b=2YkWa7taW/14fNONVbgTmYca2TdvpOZ180cJXbSoIaxUAjVQulC4+kWOuBkysTuKHnnzIe
	jRXYjT5XNBjbrZ6CV/jqOYgaOdRMiH+H+iBHhiS+jwI0m7tcgCo4uFnawdM0smBy2KbrFD
	QIFBMTG+LrRqP12P9/LiDbbp0ZMXfaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774856181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	b=oCbPaxCI3NKXEjbd0F0HX/af3nAlPk/DSi+3U7m/dT3iQHe8V1iVKDqLkJsmjo6c2G8ppf
	gnX/vp8aOAvU/2Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774856180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	b=Q9ylU2RaADVGsYJiaCg792mXhv89cIQ2IpVUq3AmUz8QUXYwHkRinvWpdjS5agJoV8Mvyu
	zGXZZhc1g/I3dSx1AtP7Jbu3yebggLzZJ2si5lgWD4BB6aKu1u+aE4lYE53snqNuMhUpeV
	dpG8cP6GO5sFYZ0592P4VfIBDfXcD4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774856180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrMnCznqNgri+NjrieBtsBBOPjrP13zJo0LHVEjqXgg=;
	b=HHYrvATcnDzLbS8y7ZaPV0MbM9VOHpc9c18J2RyXPXbx0PogjR7JlAM3ea0KaoiHbdzT3G
	6E4NFSpnRMu6kpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5F6B4A0A2;
	Mon, 30 Mar 2026 07:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /I33MvMnymkaKAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 30 Mar 2026 07:36:19 +0000
Date: Mon, 30 Mar 2026 09:36:19 +0200
Message-ID: <87o6k5u5u4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: i2sbus: fix OF node lifetime handling
In-Reply-To: <20260330-aoa-i2sbus-ofnode-lifetime-v1-1-51c309f4ff06@gmail.com>
References: <20260330-aoa-i2sbus-ofnode-lifetime-v1-1-51c309f4ff06@gmail.com>
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
X-Spam-Score: -7.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-231025-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6AA263568C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 06:00:34 +0200,
Cássio Gabriel wrote:
> 
> i2sbus_add_dev() keeps the matched "sound" child pointer after
> for_each_child_of_node() has dropped the iterator reference. Take an
> extra reference before saving that node and drop it after the
> layout-id/device-id lookup is complete.
> 
> The function also stores np in dev->sound.ofdev.dev.of_node without
> taking a reference for the embedded soundbus device. Since i2sbus
> overrides the embedded platform device release callback, balance that
> reference explicitly in the local error path and in i2sbus_release_dev().
> 
> Fixes: f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi

