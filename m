Return-Path: <stable+bounces-20889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEE685C606
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E742836E9
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA98D14AD15;
	Tue, 20 Feb 2024 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KodssoMO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0CB612D7
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462008; cv=none; b=CAHMZCp9W+e0JDpWH0U9d/+UwjVxvTxOGwmmISFOQ2dqshxynpOXXjqMZBzu1wFVGT1jqDKnZXllGxZp2goQWaaUDw6qT7LtXzTBuM2g/oujVxuNz/E4LQbb/s39gXWZlH6EnPe1C64JeDuFshzSJnDG9J2v48aYa0i+yGUcucI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462008; c=relaxed/simple;
	bh=IE3SP3hYmk+Ev3timzreFgILantI88p0p0fUqYj1OsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVAvFZbbYIzApxgO/FCDU6ZC5kSxdMGfWTFxkb68817ZWCd5FpLP9cVzBVnNKIMS7jc3WLANvfbuyaS+l+iF8gwlhwbdQtYZc8Mz4Z2eZeHygBeCXFShd8OPYMI1w8ULCgJFxXnBsQ6H/9OgzJCZ4rh5MZuLnvp/bqjYZMVBJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KodssoMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECCEC433F1;
	Tue, 20 Feb 2024 20:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708462007;
	bh=IE3SP3hYmk+Ev3timzreFgILantI88p0p0fUqYj1OsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KodssoMOfo1kce2gPMKplvisyJ2jkHp6SVco8yWfqw5V1N7M3l65GbCam1lANXCPv
	 0L9K7vYU6/ILhDmv1j2+arMiYQB6OslfgMAGgq4DT77qUTcsxWPt2X9bBk+l16+EBL
	 xdjDOqafqbCRBQRnKuwOW9oXabMlZsIELGR61JnE=
Date: Tue, 20 Feb 2024 21:46:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org, Wang Kefeng <wangkefeng.wang@huawei.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 1/2] ARM: 9328/1: mm: try VMA lock-based page fault
 handling first
Message-ID: <2024022018-bulb-reabsorb-359b@gregkh>
References: <2024021921-bleak-sputter-5ecf@gregkh>
 <20240220190351.39815-1-surenb@google.com>
 <2024022058-huskiness-previous-c334@gregkh>
 <CAJuCfpEzRNG-aZWskphrUFCC6wr8nbsbpCxwG9tyfxA=CyWCoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEzRNG-aZWskphrUFCC6wr8nbsbpCxwG9tyfxA=CyWCoQ@mail.gmail.com>

On Tue, Feb 20, 2024 at 12:23:01PM -0800, Suren Baghdasaryan wrote:
> On Tue, Feb 20, 2024 at 12:20 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Feb 20, 2024 at 11:03:50AM -0800, Suren Baghdasaryan wrote:
> > > From: Wang Kefeng <wangkefeng.wang@huawei.com>
> > >
> > > Attempt VMA lock-based page fault handling first, and fall back to the
> > > existing mmap_lock-based handling if that fails, the ebizzy benchmark
> > > shows 25% improvement on qemu with 2 cpus.
> > >
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  arch/arm/Kconfig    |  1 +
> > >  arch/arm/mm/fault.c | 30 ++++++++++++++++++++++++++++++
> > >  2 files changed, 31 insertions(+)
> >
> > No git id?
> >
> > What kernel branch(s) does this go to?
> >
> > confused,
> 
> Sorry, I used the command from your earlier email about the merge conflict:
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to
> '2024021921-bleak-sputter-5ecf@gregkh' --subject-prefix 'PATCH 6.7.y'
> HEAD^..
> but it didn't send both patches, so I formatted the patches I wanted
> to send and sent it with the same command replacing "HEAD^.." with
> "*.patch". What should I have done instead?

You forgot the "git cherry-pick -x " portion of the instructions :(


And the subject prefix didn't work here, right?

thanks,

greg k-h

