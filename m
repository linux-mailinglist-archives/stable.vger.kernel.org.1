Return-Path: <stable+bounces-233352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHgcE0xe02kEhwcAu9opvQ
	(envelope-from <stable+bounces-233352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 09:18:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB533A1F7E
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE2C730055D0
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 07:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2523126D0;
	Mon,  6 Apr 2026 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CF2nd6Bm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83F217F27;
	Mon,  6 Apr 2026 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459905; cv=none; b=i8Tn5hOAbWlwxI4yJ/kFGzwzDtCSoU8X2C4v+EFdtrqgcsnmV4C/QpeZgptnC3xkyZ9ds8W12OxwyRtjxdBBTCNRAxzv5xseA+LQhxQk6ED7JQh3mLAQyF+REaELTGt8tRvi0IXH1JYx8XwyRS5a9/mzt6eSTZsrU/1dpX9bGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459905; c=relaxed/simple;
	bh=7dgGJ8RI6fSNZ21R1wns5wz9AIxAzgf8aTq4pJ3CelY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbfBTvDgXv8qlM2c8GeLB2xkpknJDkKOdrTqyHmUB98vIxYjigGU63hsFn0g27Eab3tvpJXNE52akws8W8ViYu0SgEFRJD/208XD6RJb9JusTn2fL4yKOzvd0f+I1LVuSHctdVU94DpPCQSoqGDVQ0eE8MV2U5T4TYTt6YoN3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CF2nd6Bm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FDBC4CEF7;
	Mon,  6 Apr 2026 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775459904;
	bh=7dgGJ8RI6fSNZ21R1wns5wz9AIxAzgf8aTq4pJ3CelY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CF2nd6Bmvt52gQc17RI4UL/aMmb99A5zGf5gqQ/fWp7b3yqze4qtpuyHVIz3yR6fX
	 8VQkBviLVQrGBYho01dk/lohZXdeYt7U62ySar6WQpcdTBtxEILOYpCJ8lZl7AyBrO
	 wb+OZ/IJP+zZySHZikREXNOfTBdxvXsxdE+z+noI=
Date: Mon, 6 Apr 2026 09:18:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Tomasz Kramkowski <tomasz@kramkow.ski>, stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6.6.y v2 0/2] Fix `fremovexattr` missing `fdput`
Message-ID: <2026040647-vindicate-unlearned-7ab8@gregkh>
References: <20260405114505.568530-1-tomasz@kramkow.ski>
 <7ab3b184-8d9f-465d-b678-4def48cc2a9f@pobox.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ab3b184-8d9f-465d-b678-4def48cc2a9f@pobox.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233352-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,x.com:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6CB533A1F7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 10:05:35AM -0700, Barry K. Nathan wrote:
> On 4/5/26 04:45, Tomasz Kramkowski wrote:
> > As discussed, a v2 which includes the revert from the previous version
> > [0] and a new attempt at backporiting the upstream change which doesn't
> > cause the regression introduced in the first attempt[1].
> > 
> > In total, this fixes the missing `fdput` in the `fremovexattr`
> > `copy_from_user` error path that the backport was intended for.
> > 
> > I tested both the error case and the happy case in qemu.
> > 
> > [0]: https://lore.kernel.org/stable/20260404112219.389495-1-tomasz@kramkow.ski/
> > [1]: https://lore.kernel.org/stable/tencent_72B5370E2D4C4AC319ED4F0DCB479CA4B406@qq.com/
> > 
> > Al Viro (1):
> >    xattr: switch to CLASS(fd)
> > 
> > Tomasz Kramkowski (1):
> >    Revert "xattr: switch to CLASS(fd)"
> > 
> >   fs/xattr.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> 
> I tested the following two (groups of) proof-of-concept exploits
> against 6.6.130, 6.6.132, and 6.6.132 + this patch series:
> 
> 
> 1. "CVE-2024-14027 - SlopSploit" proof-of-concept exploit for the bug
> fixed by the original mainline commit. This only works on i386 kernels,
> so I tested with i386 kernels on amd64 hardware.
> 
> https://github.com/lcfr-eth/CVE-2024-14027_slop
> 
> (I used exploit.c. For me, the exploit never reached its intended goal
> of allowing a normal user to read /etc/shadow, but as far as I can tell
> it still causes a parade of oopses on vulnerable i386 kernels but no
> oopses on invulnerable i386 kernels. So it's still a good test of whether
> this patch series works.)
> 
> 
> 2. Brad Spengler's proof-of-concept exploits for the 6.6.132 regression,
> posted on Twitter (I tested on i386 and amd64 kernels, on amd64 hardware):
> 
> https://x.com/spendergrsec/status/2040049852793450561
> 
> (Note that one of these has a missing parameter, but it's easy enough
> to fix.)
> 
> 
> Test results:
> 6.6.130: #1 causes oopses (but not #2)
> 6.6.132: #2 causes oopses (but not #1)
> 6.6.132 + this patch series: Neither #1 nor #2 cause oopses
> 
> So, at least in my testing, this patch series successfully fixes both
> the old and new bugs (both CVE-2024-14027 and the 6.6.132 regression).
> 
> Tested-by: Barry K. Nathan <barryn@pobox.com>
> 

Thanks for the testing, and thanks Tomasz for the revert and the
backport, I'll go do a release right now with these in it as this is
pretty big.

greg k-h

