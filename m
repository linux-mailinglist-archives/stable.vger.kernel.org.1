Return-Path: <stable+bounces-214470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLXEJ8ClhGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:14:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3944F3D6F
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F5463034E06
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFFB3D6694;
	Thu,  5 Feb 2026 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sgVRzhnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A6C275AE8
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300667; cv=none; b=koKdjXSUzKOPQdir3eBvHvwrkQsLOSFkvK6jCwGfnzeiRfvY3sqRuiqc97yEkZQTHGPaW9VEevCE3OWUn+eoy08itTSCkBP4mJSJWV19RPI9JdCjCChrVRU0ByaiOgmpYntGozZMUuMN1fKehgWZl+mcB7nOSmB+vxDnXAye0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300667; c=relaxed/simple;
	bh=GUa0E4UqVuY7CM9Ey97twGZD2MJQFqkeX74MMiFvY1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVXUt4vL++96aIOwsSkGSz9x+ju0pk4pyiU8QxWbwmbE/1fJ3AXMOw8++iZkxzoRZ1B8xGtFqX76XPLAyRo9t9s0IRkKuZaEWbCKkrGyeaKQ3VbmKzGvpv7+BXkmQsy8rvzLs6EWc7qd4Wo21/qEHGWWHznBCOPfNe33eDeLPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sgVRzhnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F70C4CEF7;
	Thu,  5 Feb 2026 14:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770300667;
	bh=GUa0E4UqVuY7CM9Ey97twGZD2MJQFqkeX74MMiFvY1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgVRzhnfU9RevwCnld5iGaDRdC2wjAf3FJnT5epGbUzxVly6dFxPhchepOR7wPE5V
	 ufTOBlLzZFKcJWnJdrV+661oPlVxW++pjXsUDzz5Sh7oUS5OHopz394wIp3gBIJ/+7
	 7Lw1FCrxunJb71M2dG3iSl3aZHlJ+SuLr1i81ZSk=
Date: Thu, 5 Feb 2026 15:11:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pimyn Girgis <pimyn@google.com>
Cc: stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Ernesto Martnez Garca <ernesto.martinezgarcia@tugraz.at>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y v2] mm/kfence: randomize the freelist on
 initialization
Message-ID: <2026020546-nimble-mower-1202@gregkh>
References: <2026020339-trickery-vegan-e9c3@gregkh>
 <20260205095323.3149138-1-pimyn@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205095323.3149138-1-pimyn@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214470-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,linuxfoundation.org:email,linuxfoundation.org:dkim,tugraz.at:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3944F3D6F
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 10:53:23AM +0100, Pimyn Girgis wrote:
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
>  mm/kfence/core.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

What changed from v1?  Always put that below the --- line, like any
other kernel patch.

thanks,

greg k-h

