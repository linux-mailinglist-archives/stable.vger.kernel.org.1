Return-Path: <stable+bounces-244555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FTfCExx/GmkQAAAu9opvQ
	(envelope-from <stable+bounces-244555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:02:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A10F4E72BC
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 13:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C67E03041227
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 11:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5DB3F6614;
	Thu,  7 May 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cJCkODeY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O8B4j+GU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cJCkODeY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="O8B4j+GU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E677E3EF64C
	for <stable@vger.kernel.org>; Thu,  7 May 2026 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151534; cv=none; b=HtzX9ZG1FQqefrcaQHvSh3r1l8tPywiHwJRO3T2m6SVkFp8ljPIQWDsWiZmewA3QQ1397Yq7YX7KRnP7K1PkQLugpt4ap58cHlYkUSwz94Jx35/uknQKfeh/gB3n659lcAp6HY6bMB/fU4sb3wjuJC+59It/S73aiYhw+6qmiXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151534; c=relaxed/simple;
	bh=94GIgPLVNbC3YpkEVnY5qCFadYOOCK1fuM+W3U1HOC0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UDwAxb7g8G3WtjZuMbEWs5S60p4RfvoDAvyzvdTd3dJpuH7uF20V8E5sG9YsE7iLA438UOL0ON0pmStUy7Xye5vKg2WZ1plwrq77bF4Lx6YTf+dK28RSLk0UkvIuNYtJnsTRlBSb4ewIaFZVXaeG+Bt94huKx+UUqZ8xx8PK5vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cJCkODeY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O8B4j+GU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cJCkODeY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=O8B4j+GU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C42515CF56;
	Thu,  7 May 2026 10:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778151518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isgrf4sX1UHWOdSDWyIsiTPPD7AvnFI5MzA7mzOGjKI=;
	b=cJCkODeYyZEwqQ/8Hm1snzoUiVaQb1xBNuBdO9KOvR9c1x4MxqXS2/lQHYF0gR3gV7QLT3
	XQ4LzP0W1XwH1LMpacEBpIEoPCddCJCjT9+0lTXzaSaE92AmaxirHoCG/WE7AlJOWTlJ9A
	9JOg90txRKYXJOvbkdNansjY4lItFg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778151518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isgrf4sX1UHWOdSDWyIsiTPPD7AvnFI5MzA7mzOGjKI=;
	b=O8B4j+GU0UMn+jjKKVzzEpCdtvlqbZzIntJaoeTXG1r7tShuDSAXDq77HM660o0sEQ9S/8
	JCLCO9XXphppBmDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cJCkODeY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O8B4j+GU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778151518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isgrf4sX1UHWOdSDWyIsiTPPD7AvnFI5MzA7mzOGjKI=;
	b=cJCkODeYyZEwqQ/8Hm1snzoUiVaQb1xBNuBdO9KOvR9c1x4MxqXS2/lQHYF0gR3gV7QLT3
	XQ4LzP0W1XwH1LMpacEBpIEoPCddCJCjT9+0lTXzaSaE92AmaxirHoCG/WE7AlJOWTlJ9A
	9JOg90txRKYXJOvbkdNansjY4lItFg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778151518;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=isgrf4sX1UHWOdSDWyIsiTPPD7AvnFI5MzA7mzOGjKI=;
	b=O8B4j+GU0UMn+jjKKVzzEpCdtvlqbZzIntJaoeTXG1r7tShuDSAXDq77HM660o0sEQ9S/8
	JCLCO9XXphppBmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ABD2593A7;
	Thu,  7 May 2026 10:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X6JuIF5w/GlWXgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 07 May 2026 10:58:38 +0000
Date: Thu, 07 May 2026 12:58:38 +0200
Message-ID: <874ikjqye9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Andreas Steinmetz <ast@domdv.de>,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] ALSA: usb-audio: Fix endpoint-extra bounds checks in USB MIDI parsers
In-Reply-To: <20260507-usb-midi-endpoint-scan-bounds-v1-0-329d7348160e@gmail.com>
References: <20260507-usb-midi-endpoint-scan-bounds-v1-0-329d7348160e@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 1A10F4E72BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244555-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action

On Thu, 07 May 2026 05:40:50 +0200,
Cássio Gabriel wrote:
> 
> Both the legacy USB MIDI and USB MIDI 2.0 endpoint descriptor
> walkers can return a class-specific endpoint descriptor without
> first checking that bLength fits in the remaining endpoint-extra
> scan.
> 
> The later parsers validate the internal flexible-array sizes
> before reading baAssocJackID[] or baAssoGrpTrmBlkID[], but they
> still trust the descriptor returned by the walker. A malformed
> device can therefore make the parser consume bytes past
> the walked descriptor span.
> 
> - Patch 1 bounds the legacy MIDI endpoint descriptor walk.
> - Patch 2 applies the same fix to the MIDI 2.0 endpoint descriptor walk.
> 
> No behavior changes for valid devices; malformed endpoint-extra descriptors
> are now rejected during parsing instead.
> 
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
> Cássio Gabriel (2):
>       ALSA: usb-audio: Bound MIDI endpoint descriptor scans
>       ALSA: usb-audio: Bound MIDI 2.0 endpoint descriptor scans

Applied both to for-linus branch now.  Thanks.


Takashi

