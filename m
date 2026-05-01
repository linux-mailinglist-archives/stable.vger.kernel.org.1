Return-Path: <stable+bounces-242261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Kv6MAwl89GkjBwIAu9opvQ
	(envelope-from <stable+bounces-242261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:10:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6A4AB821
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 12:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 469B1300B07C
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA1A3859D5;
	Fri,  1 May 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VHTxpmnT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B182FFF90;
	Fri,  1 May 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630211; cv=none; b=szkKV4W+JNTsfPqbG27toCM3RvkBYyl9IGQRvPUcxYUg9SD4Bh02L4mGZLMLYp/v8kcBi4o/O9CwLJ1CqZ/NaGKicUsiI3cPlbjH+OI6TJ84RwNqv8eqFNHYRcBhkKoc0CAfBGIE30G+Q2ahC0vr/7te4SzIMb/bkOG+Q/pGY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630211; c=relaxed/simple;
	bh=H4SZwWoZIueoZjS5ZxPIPHJnzpBtnvsO9aYrTrUvWJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBdgJb6LiS/hoyXaA4IFCfAI8d3lDkeUVOdqTXdLKBZLGTeuAAfG3Ei46M8a6g3UxjNZbozSumKJvKYhVyrxQF1ueVUh1z6Kq5fQ6QfY74RdLAOvVk4RtwyHfcDZ+IZMUXpa+95VOFHBcmUuSbq0ZEDEu1czJ6bQer/Omhs7HEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VHTxpmnT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B62DC2BCB4;
	Fri,  1 May 2026 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777630211;
	bh=H4SZwWoZIueoZjS5ZxPIPHJnzpBtnvsO9aYrTrUvWJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHTxpmnTodHUnUzXHQt9eWRPGi+zWusoeXA4C9eoqc0p+IfLcl1zQ0yH2CDcspzQk
	 f6997JybARdHn1OoND9VkHDKFGlprTbXx3X4r5NTZsL1nQfYo/kGB515p7bzRCAlTv
	 NrEutfh14lA9PPz34uq/4q5Xn41vi9AZP+K5/ydk=
Date: Fri, 1 May 2026 12:09:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Luna Jernberg <droidbittin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org, lwn@lwn.net, jslaby@suse.cz
Subject: Re: copy.fail and backport to LTS 6.12 and earlier (was: Linux 7.0.3)
Message-ID: <2026050114-supernova-angler-2de1@gregkh>
References: <2026043052-coasting-tinwork-27b5@gregkh>
 <CADo9pHjPzxmHNd8MAeWH=CCuVazxpb3OxdasEcUxoarvLwKzZg@mail.gmail.com>
 <2026043052-deflector-dodgy-93a6@gregkh>
 <07194e8a-c3b2-4cff-8690-8c0ac36a96e8@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07194e8a-c3b2-4cff-8690-8c0ac36a96e8@molgen.mpg.de>
X-Rspamd-Queue-Id: 56E6A4AB821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242261-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,vger.kernel.org,lwn.net,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,copy.fail:url,linuxfoundation.org:dkim]

On Fri, May 01, 2026 at 11:56:39AM +0200, Paul Menzel wrote:
> Dear Greg,
> 
> 
> Am 30.04.26 um 15:15 schrieb Greg Kroah-Hartman:
> > On Thu, Apr 30, 2026 at 03:09:05PM +0200, Luna Jernberg wrote:
> 
> > > Works fine
> > > 
> > > patching: https://copy.fail/ next ? ;)
> > 
> > That was fixed a while ago in older kernel releases that you should
> > already be running :)
> 
> Thank you for maintaining the stable and LTS series. Release from 6.12.y and
> older do not seem to have had the fix included upon public disclosure.
> 
> Commit a664bf3d603d (crypto: algif_aead - Revert to operating out-of-place)
> [1] fixing Copy Fail [2] went into v7.0-rc7, released on Sunday, April 5th,
> and the backport appeared in 6.18.22 and 6.19.12, both tagged and released
> on April 11th. For some reason, for older series, the backport appeared in
> 6.12.85, 6.6.137, and 6.1.170 and 5.15.204 yesterday on April 30th. Several
> Distributions like Debian stable did not have the fix included upon
> disclosure to my knowledge.
> 
> Do you know what happened? (Not that I have any demands or expectations, as
> most Linux kernel users use it for free and do not contribute to it
> financially or by active participation. Also, my institute infrastructure
> was also not affected, as we build Linux ourselves and do not have the
> module enabled.)

We have no control, or insight, into what anyone does with regards to
"disclosure", nor do you want us to.

No one had taken the time to do the backporting of these patches to
older kernels for various reasons, not the least being that probably no
one noticed or cared at the time.  If you look there are thousands of
unfixed CVEs in the older LTS kernels right now, and if distros or users
that rely on those older branches wish to see those resolved, they need
to provide working backports to us to apply, as our first attempt did
not work (which is why they are unfixed in those branches.)

thanks,

greg k-h

