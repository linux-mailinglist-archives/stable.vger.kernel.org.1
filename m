Return-Path: <stable+bounces-214329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM7dMnFxg2mFmwMAu9opvQ
	(envelope-from <stable+bounces-214329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:18:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC4BEA174
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7FAC3022563
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 16:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AC1426D1F;
	Wed,  4 Feb 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLWO7CHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262EE426D23;
	Wed,  4 Feb 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221887; cv=none; b=XhaC4t+Xv++SJDFrWlj8xNjiCqgq/JjqlOvRY8qOa1PkHigMO8ZuXANHcMQ5738IuWcfQiQgHXfT2ibBu7hOcA2VosdM3eRuV99RHjPoo56d6iRW6MQgx5yqV77U0irVLGxFHBw/7lrLs7e56hh7cET2utlyQ2pFhXBUz/5+sUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221887; c=relaxed/simple;
	bh=3Oj5oAAVMFdPkcJAMMb3HnFNFTZqnuXCs7TPEMinReU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOZojy1uWgmOd0QHsLuLE59gyBtJ0a3Gxn0Mr/ASDxvNQtyulH3k1qz8SUY5s42ViTPalIykH1dQK5aqLk+sudJgrQpCs2FbZMYdH535MKsXyTT6dYsSJ91qgQlSC0FdXMVEPjPTHOBe2F1lfhJnlwm9r+YVqGjJ4ZSliml3Y4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLWO7CHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92C3C4CEF7;
	Wed,  4 Feb 2026 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770221886;
	bh=3Oj5oAAVMFdPkcJAMMb3HnFNFTZqnuXCs7TPEMinReU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLWO7CHIJI3WoVmzkTQI2Uj0429WRZ34ntj9q+ffGkiYRtCvf9vlUYFF8CGFFvOs1
	 peI74R2GS1CgjfmJF4P0CEm+MdGKpLhtcMYHiIUyrrkV5yt+erd2d5y3wGUfmW+yKh
	 l5EKm95sKImY6RRkfwJRFM54CjxW20FFEu35SZ3jqtEiOSnqqCkAKjgSCwmFi8Grkm
	 vocMYcUkHZQnwn/9ZKkBJhmY3eonqyQ9m2UXLKRFYN+lG5o12DxG1CxpwMYfNjO7XV
	 ZL2abkXEQFE4avsBBTy1VzZ3JSrAKDk0aorTUzkf6Bx27iPEHhVBPEOqiakj4BObgN
	 T7HyH2ESFjO3A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vnfZo-000000007NM-0AKg;
	Wed, 04 Feb 2026 17:18:00 +0100
Date: Wed, 4 Feb 2026 17:18:00 +0100
From: Johan Hovold <johan@kernel.org>
To: Peter Rosin <peda@axentia.se>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andrew Davis <afd@ti.com>
Subject: Re: [PATCH] mux: mmio: fix regmap leak on probe failure
Message-ID: <aYNxOL6vqCm_UL0V@hovoldconsulting.com>
References: <20251127134702.1915-1-johan@kernel.org>
 <aXjgH6RCFq8y97-3@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXjgH6RCFq8y97-3@hovoldconsulting.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214329-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EC4BEA174
X-Rspamd-Action: no action

Hi Greg and Peter,

On Tue, Jan 27, 2026 at 04:56:15PM +0100, Johan Hovold wrote:
> On Thu, Nov 27, 2025 at 02:47:02PM +0100, Johan Hovold wrote:
> > The mmio regmap that may be allocated during probe is never freed.
> > 
> > Switch to using the device managed allocator so that the regmap is
> > released on probe failures (e.g. probe deferral) and on driver unbind.
> > 
> > Fixes: 61de83fd8256 ("mux: mmio: Do not use syscon helper to build regmap")
> > Cc: stable@vger.kernel.org	# 6.16
> > Cc: Andrew Davis <afd@ti.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> 
> Can this one be picked up for 6.20?

This one has been sitting on the list for over two months now without
any comment from Peter.

I know there have been some issues in the past which patches for this
subsystem not being picked up, so perhaps you could just take this one
directly, Greg?

It's been reviewed by Andrew.

Johan

