Return-Path: <stable+bounces-219646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP6LOT0On2neYgQAu9opvQ
	(envelope-from <stable+bounces-219646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:59:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B6199180
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3907307E0A5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6383D333D;
	Wed, 25 Feb 2026 14:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZSfGsxES";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rJd+1z2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZSfGsxES";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rJd+1z2"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1B3B52F8
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031523; cv=none; b=d40OF3tXzfF9GHsXboXXvzi7tvVUFr4rgSuBlFPkpwflceN9YEr4HGI5oNihG0PuvaClBZxVj3Mf4CnJjSHcAjS8Ffgk5Ujpypl3qroGacfgmoraXAsYflCInOILfAkf8tvBfn+ObZfwRzftmh8VnL+elnX1zG8tykz2XzserNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031523; c=relaxed/simple;
	bh=TOXolt1ZEZ55MOem9gzZADQa0H5pkMHgdanhH7VrG+Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TxYsJu3snDUnBVHEZl/tcsrGsTKZxIomgy9Oq2WDtvUGVrFKNNoPoxUt/6O8/48Ifl5osFMAsfjOPl7iKLMyynnsFk94CM1fZK+m7L6FbBCV3SEPzJwgKrYwCCHGXMdeet9k7aX+7GiAVoqSGjbSOh1PXn6Shbvv0zkikY9ZNX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZSfGsxES; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rJd+1z2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZSfGsxES; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rJd+1z2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C1764DE40;
	Wed, 25 Feb 2026 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772031520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHEqX9xxCeI9WxLOmOpXmMPtTruZUUNG8IqYcX0fsoo=;
	b=ZSfGsxESg+oqDKl3/CGhvfLoRlI2D+52Odac7lsWB8B2shCflEFhE9fs+vLwYSv6ayFRSy
	2e+F+id61uopy6lxYN3mtAMDPQvy3Zs3ILRIdxBee7rYdBUOyHUxknshf6mMZoy4hRTVmQ
	CmdLfTr1XAypzG1J5r2w8uZDj8Cky0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772031520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHEqX9xxCeI9WxLOmOpXmMPtTruZUUNG8IqYcX0fsoo=;
	b=+rJd+1z2TLwcpM8jKMeCgIdlfNRv2a5NXmKJZ6ZLWAja9Vhc4D2l7mxPnDOecOkZzi7Prh
	cX7wVt9+VXHFHOBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZSfGsxES;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+rJd+1z2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772031520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHEqX9xxCeI9WxLOmOpXmMPtTruZUUNG8IqYcX0fsoo=;
	b=ZSfGsxESg+oqDKl3/CGhvfLoRlI2D+52Odac7lsWB8B2shCflEFhE9fs+vLwYSv6ayFRSy
	2e+F+id61uopy6lxYN3mtAMDPQvy3Zs3ILRIdxBee7rYdBUOyHUxknshf6mMZoy4hRTVmQ
	CmdLfTr1XAypzG1J5r2w8uZDj8Cky0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772031520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHEqX9xxCeI9WxLOmOpXmMPtTruZUUNG8IqYcX0fsoo=;
	b=+rJd+1z2TLwcpM8jKMeCgIdlfNRv2a5NXmKJZ6ZLWAja9Vhc4D2l7mxPnDOecOkZzi7Prh
	cX7wVt9+VXHFHOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7CE53EA65;
	Wed, 25 Feb 2026 14:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zCiDMx8On2kLeAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 25 Feb 2026 14:58:39 +0000
Date: Wed, 25 Feb 2026 15:58:39 +0100
Message-ID: <87v7fkdg4g.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Panagiotis Foliadis <pfoliadis@posteo.net>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Charalampos Mitrodimas <charmitro@posteo.net>
Subject: Re: [PATCH] ALSA: hda/intel: increase default bdl_pos_adj for Nvidia controllers
In-Reply-To: <20260225-nvidia-audio-fix-v1-1-b1383c37ec49@posteo.net>
References: <20260225-nvidia-audio-fix-v1-1-b1383c37ec49@posteo.net>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219646-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,posteo.net:email]
X-Rspamd-Queue-Id: 506B6199180
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 15:53:43 +0100,
Panagiotis Foliadis wrote:
> 
> The default bdl_pos_adj of 32 for Nvidia HDA controllers is
> insufficient on GA102 (and likely other recent Nvidia GPUs) after S3
> suspend/resume. The controller's DMA timing degrades after resume,
> causing premature IRQ detection in azx_position_ok() which results in
> silent HDMI/DP audio output despite userspace reporting a valid
> playback state and correct ELD data.
> 
> Increase bdl_pos_adj to 64 for AZX_DRIVER_NVIDIA, matching the value
> already used by Intel Apollo Lake for the same class of timing issue.
> 
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221069
> Suggested-by: Charalampos Mitrodimas <charmitro@posteo.net>
> Signed-off-by: Panagiotis Foliadis <pfoliadis@posteo.net>

Thanks, applied now.


Takashi

