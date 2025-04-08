Return-Path: <stable+bounces-128887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D98A7FB0F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB623BB9EA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228A5268C5F;
	Tue,  8 Apr 2025 09:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oZyjmqdO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B44268C42
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106240; cv=none; b=Euxdsw8uRByCNvlQjZBLY/MWtew54RrVi/vTKVzAAA4BoVbyEHaiCpzutr2GX3Wz7Y6UzMN8cpNJg4ngfbuOw9yb+x/30pR5uw1bp/Yn8dsmZ9uK+tLH+gmbi8TxYNebtFRLAh3fWR94n+dNxmiOHYpkhl1AHCt4W+s2/hqortw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106240; c=relaxed/simple;
	bh=htAzhVy3UuH4SEdoqyrRu0lZ9I6ny2sWoQ0N5rSGc+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQMWiWyWoj5Pv3LBpEoEWZt0VsjJ3/qOdHc84txAvrsXSbHiGxXvafLaTFbo4zMbJ5IHk2R4+82NCyYut+vzPCWieiVO5jEJWT6R52tZ/DEAeLmI2jeyvVqwkHB6nt9OaK+um3dLIH8J87thPpq0BHVkNJJyFWYa6f4UjIYDHvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oZyjmqdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EABC4CEE5;
	Tue,  8 Apr 2025 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744106240;
	bh=htAzhVy3UuH4SEdoqyrRu0lZ9I6ny2sWoQ0N5rSGc+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZyjmqdOmrmXYGM+dTxhPaQnECdQQeR3t2TFkMlPXbR+lR5pgBJBSW5eBqI/lY+gh
	 5bu+nQX2Jc6GjA7motSI4JocRvbGWRYFXcIc5JV+Qf4tqPVbeX82X+PVitiFcfU6xX
	 T32OVq4xOFNkMH5xakinSsuDVfZ0hxDuQpn0fuVw=
Date: Tue, 8 Apr 2025 11:55:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wenlin Kang <wenlin.kang@windriver.com>
Cc: stable@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	ebiederm@xmission.com, keescook@chromium.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH 6.6.y 0/6] Backported patches to fix selftest tpdir2
Message-ID: <2025040832-replay-trout-b9aa@gregkh>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
 <2025040344-coma-strict-4e8f@gregkh>
 <17b170ac-aa20-4c36-a045-25d2f82e66d0@windriver.com>
 <2025040819-unabashed-maximum-8fc8@gregkh>
 <b1b8807d-f699-4108-94c1-aa89df62aadb@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1b8807d-f699-4108-94c1-aa89df62aadb@windriver.com>

On Tue, Apr 08, 2025 at 05:50:06PM +0800, Wenlin Kang wrote:
> 
> On 4/8/25 17:06, Greg KH wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Fri, Apr 04, 2025 at 03:58:36PM +0800, Kang Wenlin wrote:
> > > Hi Greg
> > > 
> > > Thanks for your response.
> > > 
> > > 
> > > On 4/3/2025 22:52, Greg KH wrote:
> > > > CAUTION: This email comes from a non Wind River email account!
> > > > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > > > 
> > > > On Wed, Apr 02, 2025 at 04:26:50PM +0800, Kang Wenlin wrote:
> > > > > From: Wenlin Kang <wenlin.kang@windriver.com>
> > > > > 
> > > > > The selftest tpdir2 terminated with a 'Segmentation fault' during loading.
> > > > > 
> > > > > root@localhost:~# cd linux-kenel/tools/testing/selftests/arm64/abi && make
> > > > > root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
> > > > > Segmentation fault
> > > > > 
> > > > > The cause of this is the __arch_clear_user() failure.
> > > > > 
> > > > > load_elf_binary() [fs/binfmt_elf.c]
> > > > >     -> if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bes)))
> > > > >       -> padzero()
> > > > >         -> clear_user() [arch/arm64/include/asm/uaccess.h]
> > > > >           -> __arch_clear_user() [arch/arm64/lib/clear_user.S]
> > > > > 
> > > > > For more details, please see:
> > > > > https://lore.kernel.org/lkml/1d0342f3-0474-482b-b6db-81ca7820a462@t-8ch.de/T/
> > > > This is just a userspace issue (i.e. don't do that, and if you do want
> > > > to do that, use a new kernel!)
> > > > 
> > > > Why do these changes need to be backported, do you have real users that
> > > > are crashing in this way to require these changes?
> > > 
> > > This issue was identified during our internal testing, and I found
> > > similar cases discussed in the link above. Upon reviewing the kernel
> > > code, I noticed that a patch series already accepted into mainline
> > > addresses this problem. Since these patches are already upstream
> > > and effectively resolve the issue, I decided to backport them.
> > > We believe this provides a more robust and maintainable solution
> > > compared to relying on users to avoid the triggering behavior.
> > Fixing something just to get the selftests to pass is fine, but do you
> > actually know of a real-world case where this is a problem that needs to
> > be resolved?  That's what I'm asking here, do you have users that have
> > run into this issue?  I ask as it's not a regression from what I can
> > determine, but rather a new "feature".
> 
> 
> Thanks for your explanation.
> I’m not aware of any real-world cases. As of now, apart from our
> internal testing, we haven’t had any users report this issue.

Ok, I'll drop this from the review queue.

thanks,

greg k-h

