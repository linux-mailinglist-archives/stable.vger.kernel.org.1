Return-Path: <stable+bounces-188973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB69EBFB9CC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 13:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E4B19C1051
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E92334C26;
	Wed, 22 Oct 2025 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DFeyeUwZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4M2WQhvG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s5mVy2cG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kGFccDIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1CA33372C
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132092; cv=none; b=flpIs7oe+0qn0Irhu3AMx9bjGFh+WMcG1QRGvPMtYvbbptO5ftlRybtz5SVs8edegnZ9xET6FtYu22qthlqb4QguWJEVw1RBzXuvGV8CIq9rXbP/83OKUgbwbfc1yPkjnpJrIT1LsI0FFJO3fvnrjI0v9LeBO8RDAPK5kJRi94k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132092; c=relaxed/simple;
	bh=+TJrs6jIt9jGlepgnbM7MN/AOTJRSFWRSpI90Ph/9AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMu+JSiW7fdVb5d1qser6e3mhd3zSL0jD+XK0Qn/cGzxuw8jBw6HUNiL8S+2GpeoxXFXKq+ho+GZ0LEm1KYrjsaHF5JGRxJ7UrIVr6PoxGv4ryZYeZAxo2VuTvyBCvYc3h0UErZVxwrH6a0dik57UM8tVrzt41jPuK5HlJfmvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DFeyeUwZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4M2WQhvG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s5mVy2cG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kGFccDIj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EF6C21197;
	Wed, 22 Oct 2025 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761132083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TJrs6jIt9jGlepgnbM7MN/AOTJRSFWRSpI90Ph/9AE=;
	b=DFeyeUwZhpBkcOY35s3ZdDRRlmoMerjZuq0sQiV7fEi3z5NPrjqA6Vny2CLit0+pjkxpMl
	vmRMorFnasy9P+xW/4MfFUVakoUGRAZ80ftye/mlDn6ZXIJVHAaj/+ZaQCovWBbhG3jS4b
	C3ZRJENWdv9A6U8qhSzgDekMSGT/XDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761132083;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TJrs6jIt9jGlepgnbM7MN/AOTJRSFWRSpI90Ph/9AE=;
	b=4M2WQhvGDWpdYfelzDfZdpJZ1uTPM68ZjFxuSQhloxNkFssGG8IXfsQSJXPZ91/qVkCoGs
	ZVZl3fNFirwcoBBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761132079;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TJrs6jIt9jGlepgnbM7MN/AOTJRSFWRSpI90Ph/9AE=;
	b=s5mVy2cGBF2Myg/9l+as3ze+Dv/ei+jR2qJTACTI5h15eCrg/9fA/k5C17WvcyrjKRNB1q
	cRQeKrP/d8hvSGpdXwmKAFX7CyZw56ibcZLOuDIEmj4WH5IZZk9Apt4iHjoWd9SzyYcN/H
	LudJ+/Ci1BglhdAy9j/Ern7wE6xTfXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761132079;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TJrs6jIt9jGlepgnbM7MN/AOTJRSFWRSpI90Ph/9AE=;
	b=kGFccDIjZ7WGo1sWCYKH9HyaxCo4B60ga2MDHRA7NXGP9Rf+3XPQ8pchTIJgVipOnWlAWj
	fBCoGMxujVKnOZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 460A91339F;
	Wed, 22 Oct 2025 11:21:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7OwPEC+++GhsbgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 22 Oct 2025 11:21:19 +0000
Date: Wed, 22 Oct 2025 13:21:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/i915/dmc: Clear HRR EVT_CTL/HTP to zero on ADL-S
Message-ID: <20251022112113.GA476500@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20251022100718.24803-1-ville.syrjala@linux.intel.com>
 <20251022100718.24803-2-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022100718.24803-2-ville.syrjala@linux.intel.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -3.50

Hi Ville,

> On ADL-S the main DMC HRR event DMC_EVT_CTL/HTP are never
> restored to their previous values during DC6 exit. This
> angers assert_dmc_loaded(), and basically makes the HRR
> handler unusable because we don't rewrite EVT_HTP when
> enabling DMC events.

> Let's just clear the HRR EVT_CTL/HTP to zero from the
> beginnning so that the expected value matches the post-DC6
> reality.

> I suppose if we ever had actual use for HRR we'd have to both,
> reject HRR+PSR, and reprogram EVT_HTP when enabling the event.
> But for now we don't care about HRR so keeping both registers
> zeroed is fine.
...

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

