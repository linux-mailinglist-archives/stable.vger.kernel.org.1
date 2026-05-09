Return-Path: <stable+bounces-244917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Wd1tLFHf/mkEyAAAu9opvQ
	(envelope-from <stable+bounces-244917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:16:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B894FE6A4
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 09:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 426B63018AEF
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6086378838;
	Sat,  9 May 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kByIDJMf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3A2BE026;
	Sat,  9 May 2026 07:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778310986; cv=none; b=p+mIarHEm1duw7TBFMnu7syiIJB4n10oZwfEPgCH7QdgaGgUh0xPosqL1VNN9YTpnsngK31LhPHGt65PeK2OmHVpImuqxNbCBFVvF/7la2AWADlKotiPgfYQ8R8nhni+hWIuz+Rf7f3U5szhWb/VHJx8xWiH3tD//L8UgLWDdH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778310986; c=relaxed/simple;
	bh=us9zglXm13Bzva4VItyM2Ni9UKJkn+unCCt4z3Dctsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFkI/jn81S35/918eAihpsRqWK8KHj89Xr3zoQC9VQWj7cPtFGrQ71TH1LTf7qVnM7al/qpd3T2XnW5VelyH5NzuzSXRnsF60jBHC4s1SSjz/xEs/olNmE2vRvF39S39kX0jfMhjshdPVBoMBU9f861hU65MGRbj/sbeEezcYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kByIDJMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA01C2BCB2;
	Sat,  9 May 2026 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778310986;
	bh=us9zglXm13Bzva4VItyM2Ni9UKJkn+unCCt4z3Dctsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kByIDJMfXDz3zSruqvz2QPpsSgy7QtK/TumsXmtUVCCsTzNsGxikkhK8tqcs+16yI
	 GsHf5jpBLfFAHOaVhRm1CRPj5BWtKeXtEoJVzwjwrtHW2ZLm/MY/DUa9um7GPQ2oeu
	 COLL1hiXilM2RZKB1wO3SRoP0lrgzESzazl0iFYM=
Date: Sat, 9 May 2026 09:15:42 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: =?utf-8?B?5pyo5Y+j55KD6Z+z?= <kiguchi.r.sec@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] staging: vme_user: validate slave window size against
 buffer size
Message-ID: <2026050931-brewing-suffice-fa3f@gregkh>
References: <CAKs+XO1WXrv4jvNuEyMxu-iP9E-fifJLwOZ1nJynDjpvfn2n=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKs+XO1WXrv4jvNuEyMxu-iP9E-fifJLwOZ1nJynDjpvfn2n=g@mail.gmail.com>
X-Rspamd-Queue-Id: 00B894FE6A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-244917-lists,stable=lfdr.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 03:58:45PM +0900, 木口璃音 wrote:
> This patch addresses the OOB read/write reported earlier
> in the security@kernel.org thread (now handled publicly per
> Greg's and Willy's guidance).
> 
> Tested on Linux 7.1.0-rc2 with KASAN; all three reproducers
> fail with -EINVAL after applying this patch and produce no
> KASAN splat.
> 
> >From 506ecfc9b8608fb3a56477b8fd205238a1bf66ff Mon Sep 17 00:00:00 2001
> From: Rion Kiguchi <kiguchi.r.sec@gmail.com>
> Date: Sat, 9 May 2026 15:38:33 +0900
> Subject: [PATCH] staging: vme_user: validate slave window size against buffer
>  size

This all doesn't belong in the body of the email, please just use git
send-email to send the patch.

> 
> The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
> a user-controlled slave.size and forwards it to vme_slave_set() without
> comparing it against image[minor].size_buf. The slave-image kernel
> buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
> (0x20000 / 128 KiB), but the configured VME window size can be made
> much larger via the ioctl.
> 
> The subsequent read() / write() handlers (vme_user_read /
> vme_user_write) clamp the I/O range against vme_get_size() (the
> configured window size, attacker-controlled) but never consult
> size_buf. The slave I/O paths buffer_to_user() and buffer_from_user()
> then index image[minor].kern_buf with *ppos values up to
> image_size - 1, well beyond the actual allocation.
> 
> Result: a local user with read/write access to /dev/bus/vme/s* can
> trigger out-of-bounds read and write of the kernel slab adjacent to
> the slave-image buffer.
> 
> Fix: reject slave.size > size_buf in the VME_SET_SLAVE handler. Also
> add defensive bounds checks against size_buf in buffer_to_user() and
> buffer_from_user() so that the I/O paths cannot exceed the
> allocation even if a future ioctl path forgets to validate.
> 
> Reported-by: Pochix1103 <kiguchi.r.sec@gmail.com>

Ok, but:

> Cc: stable@vger.kernel.org
> Signed-off-by: Rion Kiguchi <kiguchi.r.sec@gmail.com>

You don't have a reported-by and a signed-off-by for the same thing, if
you author and sign off, it's implied you are reporting the issue :)

Also, you have to document the AI tool you used to find and fix this as
per out documentation.

thanks,

greg k-h

