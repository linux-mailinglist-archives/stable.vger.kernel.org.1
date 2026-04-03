Return-Path: <stable+bounces-233177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KTdIiypz2lxywYAu9opvQ
	(envelope-from <stable+bounces-233177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:49:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC45F393CE5
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 13:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 931B7300F960
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 11:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C59B3BBA14;
	Fri,  3 Apr 2026 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kS5apHkq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C8331D375
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775216937; cv=none; b=F6GT7z9VCxUpIJfRG0yJWNNSBj/kqO/HHy7+qUMttAuZcIm51xnp70LvW4KARPNOiXhXiBPmAkq9wF/zn4W8NRDCtsusVzNrhyj5lXVHdp3mduzwNSV9OQZlkFPPpaiK17Oi4WtZ7utkjD+BlzMgGHijY5hNandGDXX9J8E9LXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775216937; c=relaxed/simple;
	bh=0FpQwrCCaWIdORVAY8nVCjTi4hvUa92JWLp8NxvzEtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbRgeq+Lu1mzs1g8Oxc82C8foJvzIl3/SWCBOMOTpxZjHhBwt+fR7mU8IUrdJ0UtEXg/4fSOoRrsiGQPqIwy7FzefK/MKxJa8M9KFyIw73xFEFxamBvAk32fJsRqWddGPTaITjioiKrEzaZ5I3H6WwL0NUCv7DLTcPXYueDX9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kS5apHkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A632C4CEF7;
	Fri,  3 Apr 2026 11:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775216936;
	bh=0FpQwrCCaWIdORVAY8nVCjTi4hvUa92JWLp8NxvzEtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kS5apHkqv5fAzq88mFx/CGt2dhYKj2QVRGO1RHOUttqAFyvMa9HtnxchnEuSUNGXM
	 lFTNQn8Hd6JmuKXgPUcKgUNRZXrqIc7nkJ6420hEXWjFFBMx7dfnQOr9kxjG/lCbWn
	 4pEbLdPvrEaRkoVTovSDhs63dZEHKIu5JR6X0OzA=
Date: Fri, 3 Apr 2026 13:47:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 6.12-stable series inclusion
Message-ID: <2026040344-payee-uncut-9696@gregkh>
References: <493b91ff-32f2-48fc-88e4-0e9f7dd645d8@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <493b91ff-32f2-48fc-88e4-0e9f7dd645d8@kernel.dk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-233177-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC45F393CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 05:28:01AM -0600, Jens Axboe wrote:
> Hi,
> 
> 6.18 change how ring selected buffers are handled for io_uring, in an
> attempt to harden that feature. It'd be nice to have this in 6.12 as
> well, as it's a long term release. The actual hardening series isn't
> that large, 12 patches, but it depends on a previous smaller series as
> well. On top of these two series are a few kbuf related fixes that
> either ended up in mainline as fixes the former two series, or just
> fixes that haven't been backported to 6.12-stable yet.
> 
> Apologize for the big series, but it's always better to keep the stable
> bases closer to current upstream than it is to diverge them and end up
> with different bugs in -stable than in upstream.
> 
> On top of that, this actually kills a lot more code than it adds, which
> is always a good thing!
> 
>  8 files changed, 290 insertions(+), 379 deletions(-)
> 
> Please apply, thanks.

All now queued up, thanks!

greg k-h

