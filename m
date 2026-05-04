Return-Path: <stable+bounces-243867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HYrLCPC+Gkg0gIAu9opvQ
	(envelope-from <stable+bounces-243867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:58:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB7B4C1094
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E604D30205CE
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EAE17BA6;
	Mon,  4 May 2026 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="soyjsrXJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3t9vCdtm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="soyjsrXJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3t9vCdtm"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012B3E1204
	for <stable@vger.kernel.org>; Mon,  4 May 2026 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910110; cv=none; b=Kh1SAasGByR/o/pFkOpo8yhHCqZ3kpnjriWJnNsG5gVrPUyS9NZRNe9Tc0hiqa9zJ3n8IH6Od9VFYP6JyDjFwZdaYFQA+fFfIYv8fzceFfolC8q+khEIGbHxrXOzCq7VRuZCzJhPavLJ0mO2QLhDaTk3mCYP21d0l9u3kbNpGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910110; c=relaxed/simple;
	bh=4Cij6UvjBctrAn6MIaUDWxmR8Kty2o5FaqSd37tgLWs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwDVcjI4tdXR4lBFte/7ES7k50RaHxNnkWPsEvCjW3gZidMby6g/ABXcGLzTzAsS9rdin5L9uDiFv2c4lILtE2HnPgspW2ygiI/gUecX+eETaF8//wjcgfAD19olt4ERzduWR08uHECZ8wSitMNHeNbbSN+yRAhe8NKKSoLeyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=soyjsrXJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3t9vCdtm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=soyjsrXJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3t9vCdtm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 098515C7B8;
	Mon,  4 May 2026 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777910106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGYNHxZt72ahQKpNqZH45LxLeLEF8xCD1wZf+t3JQrY=;
	b=soyjsrXJ5N59dJWt3izn4Djk9n+vwuwR93Nt/98V29A9jGZIQ+sxdbD+6cvzBseC6+X3LZ
	rEpaIOhogAK2/8fevADUoL7Jpk8Hu8i2e8JqF027Oe0HAJjszGdk1FFz/dyg1nkcCBBgK6
	CAVeIfdXaIru5a0q6KSf3A3ply1lDAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777910106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGYNHxZt72ahQKpNqZH45LxLeLEF8xCD1wZf+t3JQrY=;
	b=3t9vCdtmpnWOpp9ZuWySFI/Tn/MHjH8gmGHDNXCI+SH2UrXFQoWR0ttcAx7WyYTFdHdCqW
	N9qHmOo+BwVZ30Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=soyjsrXJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3t9vCdtm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777910106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGYNHxZt72ahQKpNqZH45LxLeLEF8xCD1wZf+t3JQrY=;
	b=soyjsrXJ5N59dJWt3izn4Djk9n+vwuwR93Nt/98V29A9jGZIQ+sxdbD+6cvzBseC6+X3LZ
	rEpaIOhogAK2/8fevADUoL7Jpk8Hu8i2e8JqF027Oe0HAJjszGdk1FFz/dyg1nkcCBBgK6
	CAVeIfdXaIru5a0q6KSf3A3ply1lDAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777910106;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGYNHxZt72ahQKpNqZH45LxLeLEF8xCD1wZf+t3JQrY=;
	b=3t9vCdtmpnWOpp9ZuWySFI/Tn/MHjH8gmGHDNXCI+SH2UrXFQoWR0ttcAx7WyYTFdHdCqW
	N9qHmOo+BwVZ30Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF9C4593A3;
	Mon,  4 May 2026 15:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id J5p9MFnB+GkmMQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 May 2026 15:55:05 +0000
Date: Mon, 04 May 2026 17:55:05 +0200
Message-ID: <87pl3bw4o6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: midi2: Restart output URBs on resume
In-Reply-To: <20260504-usb-midi2-output-resume-v1-1-c089cc8ad3c6@gmail.com>
References: <20260504-usb-midi2-output-resume-v1-1-c089cc8ad3c6@gmail.com>
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
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 4CB7B4C1094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243867-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 04 May 2026 16:08:45 +0200,
Cássio Gabriel wrote:
> 
> USB MIDI 2.0 suspend saves the endpoint running state, clears it and
> kills all endpoint URBs. Resume restores the running state, but only
> restarts input endpoints.
> 
> For a running output endpoint, this leaves the endpoint marked running
> with an empty URB queue. Output transfer progress depends on either the
> rawmidi trigger path starting the queue or an output completion refilling
> it. After suspend there is no completion left, and output data that
> remains queued in the raw UMP or legacy rawmidi buffer can stay stalled
> until userspace happens to trigger the stream again.
> 
> Restore the saved state with atomic accessors, keep input endpoints
> restarted as before, and restart output endpoints that were running before
> suspend. Clear the saved suspend state after restoring it.
> 
> Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Thanks, applied now.


Takashi

