Return-Path: <stable+bounces-241295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHTrK8RN72kEAAEAu9opvQ
	(envelope-from <stable+bounces-241295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:51:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7424720BD
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49B41304F32D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521B23B4E9C;
	Mon, 27 Apr 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1PJi6v3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cSTD+rLL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1PJi6v3Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cSTD+rLL"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698B3803C5
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290479; cv=none; b=VjAJ99jyCClcq97zg5xcs6x3qmmWx3YvToN+5QBRDuoD4kRrL6ODrO2svo0VHHU0v+rZulUKnJb1E1wudHsuN8IALTLfbZ49mf5dAx/ml0NvLLP6eIv7YT8/J7uEiuPo/21HC7CDZyDPmC3BfSTHSDqLmMmdtQnUvL4p/e4YeKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290479; c=relaxed/simple;
	bh=lcsTz/kxOp+OXij0GHTFhC5eaogvP5+haKJjjriiWeM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppCDmMpZVlo+yRqpl8AxBrRG7sRxwSx7TnaylU9YqZnGMh1n+vKbdGvZb8DGN2nB71EfgUh/mRP+ru4yFl9yj+oTjruF6alm7o3OLVO9yUoqUsVjxlM/XZNrbn/5MS40zXgxgjBelIKbm4egbhgnSUBGnTdHj/t0ySZ9NcB2z0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1PJi6v3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cSTD+rLL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1PJi6v3Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cSTD+rLL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 470386A8FE;
	Mon, 27 Apr 2026 11:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777290476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JPwDoYh5TXZUuC3n7SbSbkKFH7AMwZhzsBKFitOM+k=;
	b=1PJi6v3QDxsBBR0wlXNBkuk8R7zIrzFraEKldqY728L04mxWgoQ1rO0KEWGFcRvoA+iV3G
	2Er2haUClSUtNynRpd2i0aUJHzLdn/nRAF/2SG6GlVPofrNt14mjIRWctXFnIihp2vrFG7
	TBBW1or/rCQPRKhc54gOjsQzhNEVIM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777290476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JPwDoYh5TXZUuC3n7SbSbkKFH7AMwZhzsBKFitOM+k=;
	b=cSTD+rLLQXjRIrNJFSLIdJj7oot2szEldtxMaf04A2P2hAMqE/LQq8qxxS6HuhVVC04a5J
	Yf9JvGYneLKTkTDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777290476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JPwDoYh5TXZUuC3n7SbSbkKFH7AMwZhzsBKFitOM+k=;
	b=1PJi6v3QDxsBBR0wlXNBkuk8R7zIrzFraEKldqY728L04mxWgoQ1rO0KEWGFcRvoA+iV3G
	2Er2haUClSUtNynRpd2i0aUJHzLdn/nRAF/2SG6GlVPofrNt14mjIRWctXFnIihp2vrFG7
	TBBW1or/rCQPRKhc54gOjsQzhNEVIM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777290476;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JPwDoYh5TXZUuC3n7SbSbkKFH7AMwZhzsBKFitOM+k=;
	b=cSTD+rLLQXjRIrNJFSLIdJj7oot2szEldtxMaf04A2P2hAMqE/LQq8qxxS6HuhVVC04a5J
	Yf9JvGYneLKTkTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E7BB593B0;
	Mon, 27 Apr 2026 11:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NHwyAuxM72l0bgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 27 Apr 2026 11:47:56 +0000
Date: Mon, 27 Apr 2026 13:47:55 +0200
Message-ID: <87pl3kzkt0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Chris J Arges <chris.j.arges@canonical.com>,
	Detlef Urban <onkel@paraair.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/4] usb-audio: fix mixer write failure handling
In-Reply-To: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
References: <20260419-usb-write-error-propagation-v1-0-5a3bd4a673ae@gmail.com>
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
X-Rspamd-Queue-Id: 3A7424720BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-241295-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]

On Sun, 19 Apr 2026 22:30:28 +0200,
Cássio Gabriel wrote:
> 
> This series fixes usb-audio mixer put() paths that currently report
> success even when the underlying device write fails.
> 
> The issue exists in the generic mixer core callbacks, the Scarlett
> Gen1 enum path, and several Tascam US-16x08 put() callbacks.
> 
> The US-16x08 EQ and compressor callbacks have an additional bug: they
> update their software shadow state before sending the USB write, so a
> failed transfer can leave later get() results out of sync with the
> hardware state.
> 
> The series is split into four patches:
> - propagate write failures in the generic mixer core callbacks
> - fix the Scarlett Gen1 enum callback
> - propagate write failures in the simple US-16x08 put() callbacks
> - commit the US-16x08 EQ and compressor shadow state only after a
> successful write
> 
> Successful writes are unchanged. Failed writes are now reported
> correctly, and the US-16x08 shadow state remains coherent with the
> hardware after write errors.
> 
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
> Cássio Gabriel (4):
>       ALSA: usb-audio: Propagate write errors in generic mixer put callbacks
>       ALSA: usb-audio: Propagate errors in scarlett_ctl_enum_put()
>       ALSA: usb-audio: Propagate US-16x08 write errors in route/mix EQ-switch put callbacks
>       ALSA: usb-audio: Update US-16x08 EQ/comp shadow state after successful writes

Applied all to for-next branch.  Thanks.


Takashi

