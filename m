Return-Path: <stable+bounces-217428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDyXDMLzlmndrQIAu9opvQ
	(envelope-from <stable+bounces-217428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 12:28:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7715E45A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 12:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CF2730137AB
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1B233E36A;
	Thu, 19 Feb 2026 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xcT25WD3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69539334C05;
	Thu, 19 Feb 2026 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771500434; cv=none; b=I3pPX+poWFwZXiCwXhBMw9upR+deRGFP2Pl5HqcAYhNjz3nsvYGy1nZ6WBwZRZBOAWJS6fEtSlcuqwz5gsv1n3xd0tLwJEF20wDkLah/fM+VB40I713cXScrDgoafqyTKkpoVHe5hMIpNK3/zBzE4QSVl2w4ztH9SK1ifo9fGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771500434; c=relaxed/simple;
	bh=xp7Nhv12KAdXXfp+Ld+eGXOH79HOhc/ThXlKFzHRK94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcU4KKL/9rn10qsM9rme0MLy88dEw9+Z4F8zIt2FTaWLzcBWhxAVN0E5dW+b/KoN8qtUgrZfQDV1RYx1AwjJkVo9bbrS5AFbADAS2Mag4PbmqwY8LtCbohF+IQdfS/NTbCVwTcv5m/F82EdJ+80xxlQG4U2Aer/et/hW8juWqmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xcT25WD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D480C4CEF7;
	Thu, 19 Feb 2026 11:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771500434;
	bh=xp7Nhv12KAdXXfp+Ld+eGXOH79HOhc/ThXlKFzHRK94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xcT25WD3Yb3DqoQ9SmcTfrBxrZ1JOJ4kMjcnkEUI9YM9HXgPS83snFAGV0Yx4Vea8
	 gnmD65gXPatcFx1SHTpVNCe/p8s3ZzKXFhak+obNUUpeEDEEal6NfTePiv56Mim+58
	 sOe+qV2UIE4lk8b6WH2u/H2iUh/K6e6fd6d09ZPA=
Date: Thu, 19 Feb 2026 12:27:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: stable@vger.kernel.org, kevin.brodsky@arm.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6.12.y 00/14] Address pkey self test failures.
Message-ID: <2026021904-unclothed-flavored-cdf7@gregkh>
References: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219101318.2442406-1-harshit.m.mogalapalli@oracle.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217428-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7F7715E45A
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 02:13:04AM -0800, Harshit Mogalapalli wrote:
> Hi stable maintainers,
> 
> When pkey_sighandler_tests_64 is run on machines with CPUs that don't
> support pkeys, instead of skipping the tests return SIGILL(illegal
> instruction).
> 
> # gdb  ./pkey_sighandler_tests_64
> 
> (gdb) info registers rip
> rip            0x402779            0x402779 <thread_segv_with_pkey0_disabled+9>
> (gdb) disassemble /r $rip-8,$rip+8
> Dump of assembler code from 0x402771 to 0x402781:
>    0x0000000000402771 <thread_segv_with_pkey0_disabled+1>:	c9                 	leave
>    0x0000000000402772 <thread_segv_with_pkey0_disabled+2>:	b8 55 55 55 55     	mov    $0x55555555,%eax
>    0x0000000000402777 <thread_segv_with_pkey0_disabled+7>:	89 ca              	mov    %ecx,%edx
> => 0x0000000000402779 <thread_segv_with_pkey0_disabled+9>:	0f 01 ef           	wrpkru
>    0x000000000040277c <thread_segv_with_pkey0_disabled+12>:	0f 01 ee           	rdpkru
>    0x000000000040277f <thread_segv_with_pkey0_disabled+15>:	3d 55 55 55 55     	cmp
> 
> Tests result in:
> 
> ./pkey_sighandler_tests_64
> TAP version 13
> 1..5
> Illegal instruction (core dumped)
> 
> This is because 6.12.y commit: 1c6b1d4889d7 ("selftests/mm: skip
> pkey_sighandler_tests if support is missing") like upstream and
> backporting that needed few prerequsites, during this process I have
> seen a few build warnings, so also included patches that help fix these
> build warnings in the selftests.
> 
> All are clean cherry-picks. After patching the selftests the test is
> correctly skipped. These additional backports cleansup the code and
> avoids the need for conflict resolution and might help future backports.

Shouldn't you be always running the latest selftests on older kernels?
We don't always keep selftests up to date at all, as you can see here,
but newer selftests should ALWAYS work with older kernels.

I think trying to keep these all up to date is going to be "a lot", are
you sure it is going to be worth it?

thanks,

greg k-h

