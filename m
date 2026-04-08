Return-Path: <stable+bounces-233871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PcfCcFF1mkFCwgAu9opvQ
	(envelope-from <stable+bounces-233871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:10:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7A3BBCC0
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E25D300902F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746103BD63B;
	Wed,  8 Apr 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y/GoaL0K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xLG8T2Xo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y/GoaL0K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xLG8T2Xo"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54B37F75C
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650151; cv=none; b=WE/XQL+UuNqM46ssq/7Ld4c5dgG6A126Dle2zs7qNiuW41ex0SGoytCuC/2YzZqQ5x3Og0KifGtfYP4AxNw0kl2DaNmYiU/4ScN6Q+mlnVK4jDO/g4dJzgK43tUsv5VbObs7nDuY+0xVVEmav7opn4kHhIbu0Yq5PKzc3X/OhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650151; c=relaxed/simple;
	bh=cJJPMECuR0b5SldMWykynCxfwS08Wa+d/fuyEbNF378=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uk7kd0jJSHOvJTChoQe3Jy4gHxvla7FCheRm6oTI2PZnylVagGZXRteaLQ051Mcnym09ahUyyDPHbyYeRbBmHo800JqaPPwPOOInAj4N2rSi7pkrBfZK4Kj+I+draN3sHVLofsbi/vLXcbrhKfob8Oqh9GONEgR0/5GeNEC+7gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y/GoaL0K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xLG8T2Xo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y/GoaL0K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xLG8T2Xo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A12A5BCD7;
	Wed,  8 Apr 2026 12:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775650148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWRUttLm7Y0cW7SkTFzyLmU51nuTrLWmw7PqGuB5GJU=;
	b=Y/GoaL0K0CkWD4iai5gQf1eMkxfh5P7w6eVFvEs1YQ8teWgUQXMUkCD/qJtZtgapB7fjaI
	wsOQvrf24yTMRw+NHTPFvfJ/fwH0xPpj4JzTIcIRKPR+0VPr2V9jGaOa80o1HhqfNaKIOM
	FHqqVUHTQLeAWRS1emHIcS3U+vX6Zac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775650148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWRUttLm7Y0cW7SkTFzyLmU51nuTrLWmw7PqGuB5GJU=;
	b=xLG8T2XotBksuc6H2mlAaUKKHH3CM5kcedxmCS71BgicxXhL1LfWMQoXy8+XuIigu1m1W7
	/WsLA5wlyrjy4xAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Y/GoaL0K";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xLG8T2Xo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775650148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWRUttLm7Y0cW7SkTFzyLmU51nuTrLWmw7PqGuB5GJU=;
	b=Y/GoaL0K0CkWD4iai5gQf1eMkxfh5P7w6eVFvEs1YQ8teWgUQXMUkCD/qJtZtgapB7fjaI
	wsOQvrf24yTMRw+NHTPFvfJ/fwH0xPpj4JzTIcIRKPR+0VPr2V9jGaOa80o1HhqfNaKIOM
	FHqqVUHTQLeAWRS1emHIcS3U+vX6Zac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775650148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWRUttLm7Y0cW7SkTFzyLmU51nuTrLWmw7PqGuB5GJU=;
	b=xLG8T2XotBksuc6H2mlAaUKKHH3CM5kcedxmCS71BgicxXhL1LfWMQoXy8+XuIigu1m1W7
	/WsLA5wlyrjy4xAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6ABC4A0B3;
	Wed,  8 Apr 2026 12:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B5gvM2NF1mkDVAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 Apr 2026 12:09:07 +0000
Date: Wed, 08 Apr 2026 14:09:07 +0200
Message-ID: <87h5pllkm4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	lgirdwood@gmail.com,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: Re: [PATCH for 7.0 0/2] ALSA/SOF Intel: Enforce stricter period size for NVL
In-Reply-To: <2d45e521-8ac7-4c4b-929c-f7d941dc3250@sirena.org.uk>
References: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
	<87jyuhllwd.wl-tiwai@suse.de>
	<2d45e521-8ac7-4c4b-929c-f7d941dc3250@sirena.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,linux.intel.com,vger.kernel.org,linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-233871-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BC7A3BBCC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 08 Apr 2026 14:05:59 +0200,
Mark Brown wrote:
> 
> On Wed, Apr 08, 2026 at 01:41:22PM +0200, Takashi Iwai wrote:
> > Peter Ujfalusi wrote:
> 
> > > NVL and NVL-S (ACE4) needs to use stricter period size constraint to
> > > meet the address alignment for each BDLE buffer (start of each period in
> > > the continuous ALSA buffer) set in the HDA specification.
> 
> > > It would be great if these can be sent for 7.0 as last minute if it is
> > > doable, I left out the Fixes tag from the first patch as that is
> > > introduced in 7.0.
> 
> > Mark, shall I pick up both patches to my tree for the next PR (planned
> > for tomorrow or on Friday)?
> > Basically both patches are independent, and I can apply the first one
> > in anyway.
> 
> I've already got the ASoC one in process for a final fixes PR today and
> was going to complain at Peter about combining patches for multiple
> trees into a single series when there's no dependencies.

OK, then I'll wait for your PR for the second patch, while I take the
first one on mine.


thanks,

Takashi

