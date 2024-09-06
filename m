Return-Path: <stable+bounces-73805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3EF96F9E0
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 19:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273461C221A8
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4711D31B9;
	Fri,  6 Sep 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X63qNjdo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D007847F46
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643433; cv=none; b=NqoKL2v6AWa+ilk0LTA7jWgZkDxFyETVxMRCb09u3GFtyPncyZ6t/tG4KOgCGvnU/fTjXKOaFt0+U2zWW5FR7Sx/PoJOnjCm+IjzvA2vNYzSSZPdHaF35RqaXsca8WB8ZHzsjWIEsXMBFyC0CM/KR0dZZs8OJdOr1rhQcP1biAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643433; c=relaxed/simple;
	bh=RX9uIZwVZJJP/WGKfAAKVhe5AzIJQTQ/Ya5/+khh6I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufA75F9U4zQLsAFeFTz/ENaFBMWl50l7stWtsFDSBcNOgAFYm3tuO81TzRSW/L608829YD1Y27KJvzN1I/KLw/SyqS0ELmkFKMU+FJnvY2iyf4aVe2KOLlyKcbBaAGIhXxzh/b89sSEfJlyaxJEUg6phHj0d9ujonCbWOh+mlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X63qNjdo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBD1C4CEC4;
	Fri,  6 Sep 2024 17:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725643433;
	bh=RX9uIZwVZJJP/WGKfAAKVhe5AzIJQTQ/Ya5/+khh6I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X63qNjdoANhz260BhZKEfgzC/2I9QTY7auf+ffW0EnEs+pJtbDPhgpSboKMdj0tp9
	 IfXvNsgoa8GJAHVRceAL9g7vCu8mue+KXjIBY6cyFeodECAHvy37nVgA1pQOpw+x1I
	 kzUpyRHXrcQhuAwmD8yDU4irA1r5yRM8XyWvoYZ0=
Date: Fri, 6 Sep 2024 19:23:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: sashal@kernel.org, dvyukov@google.com, stable@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: Missing fix backports detected by syzbot
Message-ID: <2024090627-diocese-reemerge-44c3@gregkh>
References: <20240904102455.911642-1-nogikh@google.com>
 <2024090546-decorator-sublet-8a26@gregkh>
 <CANp29Y6oy=cHWKpnM1+EBfZV24i3ZFUDWLzxvrD6HSyhnw_8JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y6oy=cHWKpnM1+EBfZV24i3ZFUDWLzxvrD6HSyhnw_8JA@mail.gmail.com>

On Fri, Sep 06, 2024 at 04:55:07PM +0200, Aleksandr Nogikh wrote:
> Hi Greg,
> 
> Thank you very much for your comments!
> 
> On Thu, Sep 5, 2024 at 10:04 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Note, for kvm, and for:
> >
> > > 4b827b3f305d1fcf837265f1e12acc22ee84327c "xfs: remove WARN when dquot cache insertion fails"
> >
> > xfs patches, we need explicit approval from the subsystem maintainers to
> > take them into stable as they were not marked for such.
> 
> Is it specific only to some subsystems (like kvm and xfs), or is it
> due to some general rule like "if the commit was not initially marked
> as a stable backport candidate, you need an approval from the
> subsystem maintainer"?

We have a list, see this file:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list

> > > A number of commits were identified[1] by syzbot as non-backported
> > > fixes for the fuzzer-detected findings in various Linux LTS trees.
> > >
> > > [1] https://syzkaller.appspot.com/upstream/backports
> > >
> > > Please consider backporting the following commits to LTS v6.1:
> > > 9a8ec9e8ebb5a7c0cfbce2d6b4a6b67b2b78e8f3 "Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm"
> > > (fixes 9a8ec9e) 3dcaa192ac2159193bc6ab57bc5369dcb84edd8e "Bluetooth: SCO: fix sco_conn related locking and validity issues"
> > > 3f5424790d4377839093b68c12b130077a4e4510 "ext4: fix inode tree inconsistency caused by ENOMEM"
> > > 7b0151caf73a656b75b550e361648430233455a0 "KVM: x86: Remove WARN sanity check on hypervisor timer vs. UNINITIALIZED vCPU"
> > > c2efd13a2ed4f29bf9ef14ac2fbb7474084655f8 "udf: Limit file size to 4TB"
> > > 4b827b3f305d1fcf837265f1e12acc22ee84327c "xfs: remove WARN when dquot cache insertion fails"
> > >
> > > These were verified to apply cleanly on top of v6.1.107 and to
> > > build/boot.
> > >
> > > The following commits to LTS v5.15:
> > > 8216776ccff6fcd40e3fdaa109aa4150ebe760b3 "ext4: reject casefold inode flag without casefold feature"
> >
> > Wait, what about 6.1 for this?  We can't move to a new kernel and have a
> > regression.
> 
> Indeed!
> Syzbot currently constructs missing backports lists independently for
> each fuzzed LTS, so the page [1] does have some holes. But in any
> case, it's totally reasonable that if we backport a commit to an older
> kernel, newer ones should also get it.

It's actually a requirement, and I am pretty sure, is documented
somewhere...

> > > c2efd13a2ed4f29bf9ef14ac2fbb7474084655f8 "udf: Limit file size to 4TB"
> > >
> > > These were verified to apply cleanly on top of v5.15.165 and to
> > > build/boot.
> > >
> > > The following commits to LTS v5.10:
> > > 04e568a3b31cfbd545c04c8bfc35c20e5ccfce0f "ext4: handle redirtying in ext4_bio_write_page()"
> >
> > Same here, what about 5.15.y?
> >
> > > 2a1fc7dc36260fbe74b6ca29dc6d9088194a2115 "KVM: x86: Suppress MMIO that is triggered during task switch emulation"
> > > 2454ad83b90afbc6ed2c22ec1310b624c40bf0d3 "fs: Restrict lock_two_nondirectories() to non-directory inodes"
> > > (fixes 2454ad) 33ab231f83cc12d0157711bbf84e180c3be7d7bc "fs: don't assume arguments are non-NULL"
> >
> > Why are these last two needed?
> 
> The last two address the "WARNING: bad unlock balance in
> unlock_two_nondirectories" bug on a Linux 5.10-based kernel.
> The crash report is very similar to
> https://syzkaller.appspot.com/bug?id=32c54626e170a6b327ca2c8ae4c1aea666a8c20b

As the changelog does not show that, I'd prefer to get an ack from the
developers involved before accepting core vfs changes that are not
obviously a bugfix and no one has run into before in the wild.

Also, just lockdep fixes to add markings aren't always needed to be
backported, UNLESS someone is reporting that this is annoying their
system tests, as sometimes happens.

> > Can you provide full lists of what needs to go to what tree, and better
> > yet, tested patch series for this type of thing in the future?
> 
> Sure!
> Could you please clarify a bit what should be the criteria for the
> full lists and what exact kinds of tests you mean?

A full list of the git ids, for each branch, you didn't do that here as
a bunch were missed for newer kernels.

> If the list only contains the patches that apply cleanly, it is
> unfortunately not very big anyway since the vast majority of the
> detected missing backports just cannot be cherry-picked automatically.
> I guess, otherwise most of them would have already been backported :)

Sometimes, but if they are not explicitly marked to be backported with a
 cc: stable line, there is no guarantee at all that they will be.

> I plan to try to manually adjust and resend some of them to better
> understand how much manual effort it actually requires.
> 
> For the commits I listed so far, I checked that they apply without
> problems, whether there are fix commits for them and whether the
> kernel builds and boots fine. It should be easy to also verify whether
> syzbot is able to reproduce the bug after the fix is cherry-picked.
> What are some other tests that would be great to have run?

That's all a great start, try doing that first and we can go from there.

thanks,

greg k-h

