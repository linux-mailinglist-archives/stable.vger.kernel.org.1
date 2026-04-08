Return-Path: <stable+bounces-233847-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oElDDxU/1mm6CggAu9opvQ
	(envelope-from <stable+bounces-233847-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:42:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C432D3BB65E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 13:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DA0D303CA4E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39983B8D41;
	Wed,  8 Apr 2026 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NCkY18P1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wMmWrDDx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NCkY18P1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wMmWrDDx"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556363B774D
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648486; cv=none; b=EQAfhustmFxl6zk81hTOgvUdfEOFLNSjCe0jqffVyn8VwHClbLRYWKMvfwUIy3d+3MPTGLIT7903W8jwzkdBGY0j0F4i9WG02CtMtcQfCIz9CjqiZ7sZ5k8DrfafS8+VSyuGxWWD3jZadL3OEE1RsvSvD119Gkgr1heMIp0nyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648486; c=relaxed/simple;
	bh=TMG9/fNi9jRb+irbP1wQM+1VkWhxHPkaXZvja4WZakY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pzho/rxu1WS/4l/9YM5CHF9/8PJuW4SR/dTv8v6l9vFHThvm7RoxB0utk24dbMhP4Fceqar/VokvoyO0oJYGUnIUPditOFNG/+8tCfHN1d/bn0Wr7H1dKKXKA2eYQNKajpJ5Ee7YwYg+IixAsdWborlx8vCb6qDiRHjIHZu+oag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NCkY18P1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wMmWrDDx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NCkY18P1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wMmWrDDx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93CE45BCE1;
	Wed,  8 Apr 2026 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775648483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXSQNr91CVe40jvG7ZYNv7XzA/U7xJmaknCtWTFRIdQ=;
	b=NCkY18P12Vc4seAXTbhJPUXXn6Yu22Nc3aaVNBm39hRrKkI5KWBUP82SI95zFlRFos7ue8
	eD/tRZEwtGE1Z1yPCH3amFcmVqRBNfA/3TSa94mW6n32YBPzul4ggIP4DgRyuD9Aroyo9n
	67biJd6M0XWJtve98UD9DtBCiDCc0M8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775648483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXSQNr91CVe40jvG7ZYNv7XzA/U7xJmaknCtWTFRIdQ=;
	b=wMmWrDDxbi9hmf5ShoNy8vT39wtY0iqSrUHUualnLehlsyVtukGg4ncWIDx1ITq4X7tsLX
	bP3j+mI+E5FCHQAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NCkY18P1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wMmWrDDx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775648483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXSQNr91CVe40jvG7ZYNv7XzA/U7xJmaknCtWTFRIdQ=;
	b=NCkY18P12Vc4seAXTbhJPUXXn6Yu22Nc3aaVNBm39hRrKkI5KWBUP82SI95zFlRFos7ue8
	eD/tRZEwtGE1Z1yPCH3amFcmVqRBNfA/3TSa94mW6n32YBPzul4ggIP4DgRyuD9Aroyo9n
	67biJd6M0XWJtve98UD9DtBCiDCc0M8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775648483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXSQNr91CVe40jvG7ZYNv7XzA/U7xJmaknCtWTFRIdQ=;
	b=wMmWrDDxbi9hmf5ShoNy8vT39wtY0iqSrUHUualnLehlsyVtukGg4ncWIDx1ITq4X7tsLX
	bP3j+mI+E5FCHQAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3579D4A0B3;
	Wed,  8 Apr 2026 11:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T5G7C+M+1mmyOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 Apr 2026 11:41:23 +0000
Date: Wed, 08 Apr 2026 13:41:22 +0200
Message-ID: <87jyuhllwd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	tiwai@suse.de,
	linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: Re: [PATCH for 7.0 0/2] ALSA/SOF Intel: Enforce stricter period size for NVL
In-Reply-To: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
References: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,suse.de,vger.kernel.org,linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-233847-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]
X-Rspamd-Queue-Id: C432D3BB65E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 08 Apr 2026 10:45:12 +0200,
Peter Ujfalusi wrote:
> 
> Hi,
> 
> NVL and NVL-S (ACE4) needs to use stricter period size constraint to
> meet the address alignment for each BDLE buffer (start of each period in
> the continuous ALSA buffer) set in the HDA specification.
> 
> It would be great if these can be sent for 7.0 as last minute if it is
> doable, I left out the Fixes tag from the first patch as that is
> introduced in 7.0.

Mark, shall I pick up both patches to my tree for the next PR (planned
for tomorrow or on Friday)?
Basically both patches are independent, and I can apply the first one
in anyway.


thanks,

Takashi

> 
> Regards
> Peter
> ---
> Kai Vehmanen (2):
>   ALSA: hda/intel: enforce stricter period-size alignment for Intel NVL
>   ASoC: SOF: Intel: hda: modify period size constraints for ACE4
> 
>  sound/hda/controllers/intel.c |  7 +++++--
>  sound/soc/sof/intel/hda-pcm.c | 14 ++++++++++++--
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> -- 
> 2.53.0
> 

