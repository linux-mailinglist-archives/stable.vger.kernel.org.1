Return-Path: <stable+bounces-214493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMydEDi4hGnG4wMAu9opvQ
	(envelope-from <stable+bounces-214493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:33:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C45F4A77
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 16:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF9663034301
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB29423A8E;
	Thu,  5 Feb 2026 15:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="libPGa7j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B56423A99
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770305554; cv=none; b=JBRfXY/GjOFFaU0+oj9NAQwbBADlzxQ4AYodD/rULKDI+ikhE1uLABVMxU0uekDxOkIjqT7Rj9/IymvmelmisZRGzLyHl7vh68WtE0KF3KnCXC0LzrQT686aRolv/L2BgR0hLwOsltcmmYhM033rK67FAju1VRUpYzVWjzdaxAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770305554; c=relaxed/simple;
	bh=NkSRuhIkbLPVZrxTQaZV1VAjFjjIRy3T5AMSUuV3gbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTtEIAIhBwU40hlFT9Ma4FZBt55qAbnnxCMe0mdnEXvRo93XzT6YZYawnTf1yerHc2m/+pABG/k3X7PgzbgS9cUcrFs06wwjczYim/5+2s9aA6iCCSUQ9c4drrQRQ15k4StWGF8JeBRKfge/n9k3ZrYvlIZf4DJiwD4xOaNZQqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=libPGa7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF49CC4CEF7;
	Thu,  5 Feb 2026 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770305553;
	bh=NkSRuhIkbLPVZrxTQaZV1VAjFjjIRy3T5AMSUuV3gbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=libPGa7juMyiJuct+dPnMDaonyPMoOO6L9UDJ+iQF9SzTg1osafQabUOo/bfrtAMb
	 pLksSyPUy+k9LbDAWTE3Q4aUl18T8jjTwjKUDvnNh5yTZIigy3NZW4NXvLobA6OgAx
	 3rrrMcaJ6OaqVT21RwGo6PynUnKyamic7+hK8fhA=
Date: Thu, 5 Feb 2026 16:32:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pimyn Girgis <pimyn@google.com>
Cc: stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y v3] mm/kfence: randomize the freelist on
 initialization
Message-ID: <2026020508-rabid-heaviness-d146@gregkh>
References: <2026020339-trickery-vegan-e9c3@gregkh>
 <20260205145055.3333340-1-pimyn@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205145055.3333340-1-pimyn@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214493-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tugraz.at:email,linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4C45F4A77
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:50:55PM +0100, Pimyn Girgis wrote:
> Randomize the KFENCE freelist during pool initialization to make
> allocation patterns less predictable.  This is achieved by shuffling the
> order in which metadata objects are added to the freelist using
> get_random_u32_below().
> 
> Additionally, ensure the error path correctly calculates the address range
> to be reset if initialization fails, as the address increment logic has
> been moved to a separate loop.
> 
> Link: https://lkml.kernel.org/r/20260120161510.3289089-1-pimyn@google.com
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Signed-off-by: Pimyn Girgis <pimyn@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> (cherry picked from commit 870ff19251bf3910dda7a7245da826924045fedd)
> Signed-off-by: Pimyn Girgis <pimyn@google.com>
> ---
> v2: handle addr calculation for error path  within appropriate loop

What changed in v3?

Yes, it's a nit, but please, we have a process :)

thanks,

greg k-h

