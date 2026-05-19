Return-Path: <stable+bounces-249468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPuaL6z+C2pcTQUAu9opvQ
	(envelope-from <stable+bounces-249468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:09:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D18577C12
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 08:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF96D3018D7A
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569EF37BE67;
	Tue, 19 May 2026 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Oyyxf4A1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xbwnMJ/x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Oyyxf4A1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xbwnMJ/x"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BEA37B03F
	for <stable@vger.kernel.org>; Tue, 19 May 2026 06:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779170954; cv=none; b=EkFRCPtUjQSbyBBhoouPm509wcAtuLW17JLi6uOz4N9YURsrh3normanKTj6UTfar1+dmFBdP0oDmKtuFr2CyWPJ9N5b6KILa+Kd1Owp9wFGocZcdGLkctIkTimtuvUnmaBTXsCg0jZRZsHbD+VKg6CTeQ4ErNmEDnJGt5Jqeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779170954; c=relaxed/simple;
	bh=42bLt/4w1Vyrh9qcN64dnigEoDlU6NXImzpR5ht3DGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Llv9Ic0WIl2FnPrz0IyPgrBb8RsgHNx8dhjwBdU94+z152pQXJIpB0zb03Vre/moGVNFLrGMaV6Mz9/UazP2swHkeirFrYdhWJbsudArKqWP7iTLHn4Fx+lqy+KN4rsQZQ9UA9n9Bbij8QKGHq1YP1sHhXt13ZnLCPKlup1pNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Oyyxf4A1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xbwnMJ/x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Oyyxf4A1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xbwnMJ/x; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17B0967E00;
	Tue, 19 May 2026 06:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779170951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzNR1W8aDaVr7CzyGthmaTAnT2xaA071LYejUT61tKA=;
	b=Oyyxf4A1zSSr+rtiCzIyESYoI3vPiMUjaF4lb7vf+JPpdiiXzFmTXAEbog7YStbGmFXWEA
	R/uYqSJV/2HpEE3U0ixdaUj//R1JCT722WVwCdHfA4jeFdGFK/O+8qRrrFb9t+2S+pv8GR
	V8pNL0UfQ8BpciSxMphi4TZS/XdTjbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779170951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzNR1W8aDaVr7CzyGthmaTAnT2xaA071LYejUT61tKA=;
	b=xbwnMJ/xb4uB/KvXVy030QWhfn5CCFN/A7vz7FAmq00m5T9lDdpYpesS+h6qN1EF0vzYtf
	i1lhSpju4zgj4hDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Oyyxf4A1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="xbwnMJ/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779170951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzNR1W8aDaVr7CzyGthmaTAnT2xaA071LYejUT61tKA=;
	b=Oyyxf4A1zSSr+rtiCzIyESYoI3vPiMUjaF4lb7vf+JPpdiiXzFmTXAEbog7YStbGmFXWEA
	R/uYqSJV/2HpEE3U0ixdaUj//R1JCT722WVwCdHfA4jeFdGFK/O+8qRrrFb9t+2S+pv8GR
	V8pNL0UfQ8BpciSxMphi4TZS/XdTjbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779170951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dzNR1W8aDaVr7CzyGthmaTAnT2xaA071LYejUT61tKA=;
	b=xbwnMJ/xb4uB/KvXVy030QWhfn5CCFN/A7vz7FAmq00m5T9lDdpYpesS+h6qN1EF0vzYtf
	i1lhSpju4zgj4hDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E941A593A8;
	Tue, 19 May 2026 06:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kZsqOIb+C2oBAgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 19 May 2026 06:09:10 +0000
Date: Tue, 19 May 2026 08:09:10 +0200
Message-ID: <875x4k3p89.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: ua101: Reject too-short USB descriptors
In-Reply-To: <20260519-alsa-ua101-desc-len-v1-1-4307d1a5e054@gmail.com>
References: <20260519-alsa-ua101-desc-len-v1-1-4307d1a5e054@gmail.com>
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
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249468-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 14D18577C12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 05:32:15 +0200,
Cássio Gabriel wrote:
> 
> find_format_descriptor() walks the class-specific interface extras by
> advancing with bLength. It rejects descriptors that extend past the
> remaining buffer, but it does not reject descriptor lengths smaller than
> a USB descriptor header.
> 
> Reject too-short descriptors before using bLength to advance the local
> scan. This keeps the UA-101 parser robust against malformed descriptor
> data and matches the usual USB descriptor walking rules.
> 
> Fixes: 63978ab3e3e9 ("sound: add Edirol UA-101 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied now.  Thanks.


Takashi

