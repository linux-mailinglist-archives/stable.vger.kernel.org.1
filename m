Return-Path: <stable+bounces-111771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E8A23A63
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 09:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E7E3A8B5E
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26670156F4A;
	Fri, 31 Jan 2025 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V66Pmoxa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ieb4/CiB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V66Pmoxa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ieb4/CiB"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1462211C;
	Fri, 31 Jan 2025 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310475; cv=none; b=IW7IaIMvyTzWfyZCkjHTB6iBX1gmZtdsvkvqawnEWgjlYm2boRGtcMfBijTDCc/vc3S0GSMRqNpr/h6gvyJSH44UFCTCesgFOBxdbzAhdpnMumCNJWtD22xVopnkRpRo9KE+91cl+cHYhURPJGytrx8HYe9MNS6UraMEa5HQ5Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310475; c=relaxed/simple;
	bh=hcg/k9+PWPYHKHwEuqdo5k2rAK+EDi00z4R+d4PLmD8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdqS3wfMdShcdKf1uFE5lSSzxVqgY6rVCGxlGwkooIuLpZNjaWKOpI25Xd8RT+ljailzVXaPtXFOoI/XmODubaMhty+RvDQluMve32EpISkZDqeRbmLpZpr4C81738X/7LGYjwwgRfV4u+aazr6Wl9YlYuYQbAyvUesDajsH8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V66Pmoxa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ieb4/CiB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V66Pmoxa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ieb4/CiB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 963881F38E;
	Fri, 31 Jan 2025 08:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738310471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZMFGGkGBzRdZDlaRSV4HeKOOsY3L5kamaHpfXEmfQ8=;
	b=V66Pmoxa/NWGShmrOtZYzgMgoMTc64J0NmRfgeXdgLTzbkE0wLzaP3oZqQYRfFk0UKcqOP
	FuE72HOGG9ZqgJSFmF1rAnW66Q2bqGYqT2Yw+SmBUIGs8KL6KafMo9EGHL+7n5F5iaCLhx
	cbNjHfUUVJciU/bZO3ggb7HNvirETOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738310471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZMFGGkGBzRdZDlaRSV4HeKOOsY3L5kamaHpfXEmfQ8=;
	b=Ieb4/CiBEHQlM2QL67wdfzqYQMQ4oeGcT7S+rHzgENaPhOj6O+dmO+xxIeh5I+Q7olU3gI
	9hi2aqS/LdniNWAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738310471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZMFGGkGBzRdZDlaRSV4HeKOOsY3L5kamaHpfXEmfQ8=;
	b=V66Pmoxa/NWGShmrOtZYzgMgoMTc64J0NmRfgeXdgLTzbkE0wLzaP3oZqQYRfFk0UKcqOP
	FuE72HOGG9ZqgJSFmF1rAnW66Q2bqGYqT2Yw+SmBUIGs8KL6KafMo9EGHL+7n5F5iaCLhx
	cbNjHfUUVJciU/bZO3ggb7HNvirETOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738310471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aZMFGGkGBzRdZDlaRSV4HeKOOsY3L5kamaHpfXEmfQ8=;
	b=Ieb4/CiBEHQlM2QL67wdfzqYQMQ4oeGcT7S+rHzgENaPhOj6O+dmO+xxIeh5I+Q7olU3gI
	9hi2aqS/LdniNWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34831133A6;
	Fri, 31 Jan 2025 08:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iYJSCkeDnGcqAwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 31 Jan 2025 08:01:11 +0000
Date: Fri, 31 Jan 2025 09:01:10 +0100
Message-ID: <87tt9f4dkp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: John Keeping <jkeeping@inmusicbrands.com>
Cc: linux-usb@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Abdul Rahim <abdul.rahim@myyahoo.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Daniel Mack <zonque@gmail.com>,
	Felipe Balbi <balbi@ti.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
In-Reply-To: <20250130195035.3883857-1-jkeeping@inmusicbrands.com>
References: <20250130195035.3883857-1-jkeeping@inmusicbrands.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,linuxfoundation.org,kernel.org,myyahoo.com,quicinc.com,pengutronix.de,gmail.com,ti.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 30 Jan 2025 20:50:34 +0100,
John Keeping wrote:
> 
> While the MIDI jacks are configured correctly, and the MIDIStreaming
> endpoint descriptors are filled with the correct information,
> bNumEmbMIDIJack and bLength are set incorrectly in these descriptors.
> 
> This does not matter when the numbers of in and out ports are equal, but
> when they differ the host will receive broken descriptors with
> uninitialized stack memory leaking into the descriptor for whichever
> value is smaller.
> 
> The precise meaning of "in" and "out" in the port counts is not clearly
> defined and can be confusing.  But elsewhere the driver consistently
> uses this to match the USB meaning of IN and OUT viewed from the host,
> so that "in" ports send data to the host and "out" ports receive data
> from it.
> 
> Cc: stable@vger.kernel.org
> Fixes: c8933c3f79568 ("USB: gadget: f_midi: allow a dynamic number of input and output ports")
> Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>

Reviewed-by: Takashi Iwai <tiwai@suse.de>


Thanks!

Takashi

