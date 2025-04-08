Return-Path: <stable+bounces-128846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE947A7F8FC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C462D1676BC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6244326462D;
	Tue,  8 Apr 2025 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CAXM18RF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181E026159C
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744103276; cv=none; b=RI/cVNGEiSRt3IOfB3wBElm+zkWSA6Y6pd4MdWQvFDeG637I7lEuIsQbXD8LiiM18oVIpigwsqZkcmGEK68AghIccpFexXPuENgjN9PPJ3exUtrgP/vT5J6PHMsEnT/mUDM0kEq7Zg8XpgqsSG6YGB10W71KJj1zLrWDV6e0xbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744103276; c=relaxed/simple;
	bh=21yDSWrTWmTmYJcf09cV8sZWJscX7IffFCn4r+16gLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIMWLfXFe/Isp9ls6LixeIE6iq33vyGhKPZUO5OHJPTEyA0blwzQynf20WdFvvE/o50CEovxpNb/ZANi8mUl1EYpJNrQbFfRbUSkByVb27xxzpl8KFr3b6k1YVDIzoQeRneBi0MGdF1LOZWdA7IAzyKmdJq9VTIB7LJCO6EJhgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CAXM18RF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB534C4CEE5;
	Tue,  8 Apr 2025 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744103274;
	bh=21yDSWrTWmTmYJcf09cV8sZWJscX7IffFCn4r+16gLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAXM18RFGAcwMtIY5JMqcOhjJ3sI4iWQZmVVahlv82RB9RHNT0RAxtVp6cxr4eVI+
	 eKnV5Fx8Xnnl34BaPlGIdPLuUX+/i6HzFmB0pCg6tGUMoPM4y2ke1NfEAds9Ayv/sx
	 r7BN1dxZl2wgAPF2MsHeQkVQ+jaL+PuBCEZrCTT4=
Date: Tue, 8 Apr 2025 11:06:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kang Wenlin <wenlin.kang@windriver.com>
Cc: stable@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	ebiederm@xmission.com, keescook@chromium.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH 6.6.y 0/6] Backported patches to fix selftest tpdir2
Message-ID: <2025040819-unabashed-maximum-8fc8@gregkh>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
 <2025040344-coma-strict-4e8f@gregkh>
 <17b170ac-aa20-4c36-a045-25d2f82e66d0@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17b170ac-aa20-4c36-a045-25d2f82e66d0@windriver.com>

On Fri, Apr 04, 2025 at 03:58:36PM +0800, Kang Wenlin wrote:
> Hi Greg
> 
> Thanks for your response.
> 
> 
> On 4/3/2025 22:52, Greg KH wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Wed, Apr 02, 2025 at 04:26:50PM +0800, Kang Wenlin wrote:
> > > From: Wenlin Kang <wenlin.kang@windriver.com>
> > > 
> > > The selftest tpdir2 terminated with a 'Segmentation fault' during loading.
> > > 
> > > root@localhost:~# cd linux-kenel/tools/testing/selftests/arm64/abi && make
> > > root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
> > > Segmentation fault
> > > 
> > > The cause of this is the __arch_clear_user() failure.
> > > 
> > > load_elf_binary() [fs/binfmt_elf.c]
> > >    -> if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bes)))
> > >      -> padzero()
> > >        -> clear_user() [arch/arm64/include/asm/uaccess.h]
> > >          -> __arch_clear_user() [arch/arm64/lib/clear_user.S]
> > > 
> > > For more details, please see:
> > > https://lore.kernel.org/lkml/1d0342f3-0474-482b-b6db-81ca7820a462@t-8ch.de/T/
> > This is just a userspace issue (i.e. don't do that, and if you do want
> > to do that, use a new kernel!)
> > 
> > Why do these changes need to be backported, do you have real users that
> > are crashing in this way to require these changes?
> 
> 
> This issue was identified during our internal testing, and I found
> similar cases discussed in the link above. Upon reviewing the kernel
> code, I noticed that a patch series already accepted into mainline
> addresses this problem. Since these patches are already upstream
> and effectively resolve the issue, I decided to backport them.
> We believe this provides a more robust and maintainable solution
> compared to relying on users to avoid the triggering behavior.

Fixing something just to get the selftests to pass is fine, but do you
actually know of a real-world case where this is a problem that needs to
be resolved?  That's what I'm asking here, do you have users that have
run into this issue?  I ask as it's not a regression from what I can
determine, but rather a new "feature".

thanks,

greg k-h

