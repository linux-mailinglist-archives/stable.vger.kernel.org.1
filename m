Return-Path: <stable+bounces-233013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHAHC35qzmmpngYAu9opvQ
	(envelope-from <stable+bounces-233013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:09:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A873896EA
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBD4930976FF
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6909285CA8;
	Thu,  2 Apr 2026 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQndLyTG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E723DEFF6;
	Thu,  2 Apr 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135226; cv=none; b=XZfIn7BX5XNQWIOReaXpV+errLoJJGlCvQLeNoXI0e7m9fmx7nJ/haONqfioerP0ZTRo3HhzNyFOalFNyBcI0mr3CuR6yRy5IEHy0/tewmkDmymKvxU6UBEGEjsTkyIc4BiP3NZwrUGw7sPO2ILn5la1NUfmhYUHGc8M0NuYEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135226; c=relaxed/simple;
	bh=k+0dZOnb12HoN5mR1FhT0OHMt3gIDwOg0ZxH5di9Xmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx5nNJdI0FOTMMsJOUjGmGqFqp8HgloXGitGSc1aLZMtxJaGh299bxWvYblnegY25KbalwLIywi7cpZr1KZqjKZxOtvtGy6HNwsbHRfKp1O173rmQBsXRiLapsH4ZUDFKoe8r4DOMj9yua6ybhM9Yx+bwdZDl+Cy2zNZCakIPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQndLyTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75351C116C6;
	Thu,  2 Apr 2026 13:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775135226;
	bh=k+0dZOnb12HoN5mR1FhT0OHMt3gIDwOg0ZxH5di9Xmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQndLyTGt9Ve/91U+VeP0bdrjryf6VtIlBn4QZPo7bmX/dj0SiiUSlH4XxBrvrY0X
	 AuI1UB1n3t7NECxI57xX7aiuuUKEbfj7CN70NKxXtqioB7kZYgoWn5vZ81I15ZaP+T
	 xBkJybgRkFJItj8hqjLR4XmqlGIfTPJe4OxfDnTLOHmaox/t8D/dlD8ptf/WuSUI+h
	 9BTR2VXnDNFxEmRlMo0hmigxlgL7EWOjUjadKmV2Yw/gdePqcCM+QSWfbI3QMcoFLs
	 pxmHvgTOibjNyM8B0IXg0AG2xA5BY/tB/sePHM8bE4RsFZEkuBKsSVG3hudm0luNV3
	 MImgd185Hdf0w==
Date: Thu, 2 Apr 2026 14:07:02 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Qi Tang <tpluszz77@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Cyrill Gorcunov <gorcunov@openvz.org>, 
	David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for
 PR_SET_MM_MAP
Message-ID: <d7b6907c-5fe3-414b-bcbc-c670099db787@lucifer.local>
References: <20260402111332.55957-1-tpluszz77@gmail.com>
 <ac5nzyCMJSkwuhRh@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac5nzyCMJSkwuhRh@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233013-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,openvz.org,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lucifer.local:mid,openvz.org:email]
X-Rspamd-Queue-Id: E6A873896EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 02:57:51PM +0200, Oleg Nesterov wrote:
> On 04/02, Qi Tang wrote:
> >
> > The original commit f606b77f1a9e ("prctl: PR_SET_MM -- introduce
> > PR_SET_MM_MAP operation") states "we require the caller to be at least
> > user-namespace root user", but this was never enforced in the code.
> >
> > Add a checkpoint_restore_ns_capable() check at the top of
> > prctl_set_mm_map(), after the PR_SET_MM_MAP_SIZE early return.  This
> > requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN in the caller's
> > user namespace, matching the stated design intent and the existing
> > check for exe_fd changes.
>
> Can't really comment... but if you add this check at the start, then you
> should also remove the same checkpoint_restore_ns_capable() check below?
> In the "if (prctl_map.exe_fd != (u32)-1)" block.

Ah yeah we noticed the same thing :)

But also as per sub-thread, I question this patch in general... :)

>
> Oleg.
>
>
> > Fixes: f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
> > Cc: stable@vger.kernel.org
> > Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> > Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> > ---
> >  kernel/sys.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/sys.c b/kernel/sys.c
> > index c86eba9aa7e9..2b8c57f23a35 100644
> > --- a/kernel/sys.c
> > +++ b/kernel/sys.c
> > @@ -2071,6 +2071,9 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
> >  		return put_user((unsigned int)sizeof(prctl_map),
> >  				(unsigned int __user *)addr);
> >
> > +	if (!checkpoint_restore_ns_capable(current_user_ns()))
> > +		return -EPERM;
> > +
> >  	if (data_size != sizeof(prctl_map))
> >  		return -EINVAL;
> >
> > --
> > 2.43.0
> >
>

Cheers, Lorenzo

