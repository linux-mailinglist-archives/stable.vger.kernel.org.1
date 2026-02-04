Return-Path: <stable+bounces-213380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH+eGuJFg2nqkgMAu9opvQ
	(envelope-from <stable+bounces-213380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 14:13:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5488E63DD
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 14:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA68B3011A7A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 13:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB5940759F;
	Wed,  4 Feb 2026 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ekVFIDrW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC57A3939C2
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210765; cv=none; b=QVxaTuWPdebzbEgRhzot7kctCUTiCQwFflHiVv1KpsLms+J08EIoCoPF7h/rqwdSjAysGb2fIDwsQgKNmy1q/dt4JejrJ8GiKtiaAADrUrGzC1+Rz+4DBTxeFm0Su2aouxqbVpJdLSgwHSLSEuXsG5dwhmoahmePMtOaDD9VZmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210765; c=relaxed/simple;
	bh=TLRFIotEPox30sIyZi2p+PHia6hsMyzCCFBGsmeuTuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBMHp7KysE3POWW4yGmWYZNwAq5O71DBnNceHtFcS2UPRuUxeCl1Uc7gt9Z+rgFRQeabvuR1r2pddgIWyROfIiMt1N6TMg92N7X+/1ScoZ0QkugOCqpklfkUYK1Y/GHbXQnckSODxGgg8Yr4nuf7lSOiYhD2Iryq/EciOVXxjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ekVFIDrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0829BC4CEF7;
	Wed,  4 Feb 2026 13:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770210764;
	bh=TLRFIotEPox30sIyZi2p+PHia6hsMyzCCFBGsmeuTuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekVFIDrWIFZ+kXo1jfh16uKi07ehpmowwPi1uLIBY4pH4/AOa3teqcqiF57Kb+1hR
	 dhmjmz4Zu1EhnPNbCKvziog5le3Zljyc+f9TiyzXP9SqmsdILubBzi6UJDPqLNzza+
	 8gc8VxzNvfVgvkuufNe5OG3rF+Hd3V0/S2wre/k4=
Date: Wed, 4 Feb 2026 14:12:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pimyn Girgis <pimyn@google.com>
Cc: stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/kfence: randomize the freelist on
 initialization
Message-ID: <2026020417-pessimism-unharmed-b5cf@gregkh>
References: <2026020339-trickery-vegan-e9c3@gregkh>
 <20260204125653.1415809-1-pimyn@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204125653.1415809-1-pimyn@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213380-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D5488E63DD
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 01:56:53PM +0100, Pimyn Girgis wrote:
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
> 
> # Conflicts:
> #	mm/kfence/core.c
> ---

What are these # lines for?  Please don't do that in the future as I
have to manually edit them out :(

thanks,

greg k-h

