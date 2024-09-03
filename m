Return-Path: <stable+bounces-72838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9C969E82
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 14:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A941E281D77
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51FD1A42CB;
	Tue,  3 Sep 2024 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qk9Hv9bs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F61CA6A7;
	Tue,  3 Sep 2024 12:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368299; cv=none; b=TPBiesr0Z8lWWnDh4eTiYmWWmjOnYQV3WqY7LKAYmaPYno4a1pCJhNB3CGZZVTySnpI2l3eyolcM7/nMpB/Egp/H85M4w/PFkMhnSi2ZxrcZE3+vo1vwnc8zgmhgybq8vuOHyGVGx7somMSMPvBxr8nWHGk622IQZMb6PtalQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368299; c=relaxed/simple;
	bh=4T5S9DDic3SFOWYTFLHIzBWd3daU2H4dW6Ld0NcAHwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGIKNZzfvtN2e9QemURkBhRFvpu/6LGgWvjmH4OtvGDOY4l8SOZXVIQ3vwgBrbzFyfVPWe8oa4T/S/YWxJiAziMJ4y0AmsHg3fChJ3A8bgK/oDRBJAotmmkJ5E94YY1K1X6SrXR7n27F5o4EjZPK7Q50UjtTf1D0deubphCyXpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qk9Hv9bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FB8C4CEC4;
	Tue,  3 Sep 2024 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725368297;
	bh=4T5S9DDic3SFOWYTFLHIzBWd3daU2H4dW6Ld0NcAHwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qk9Hv9bsuU0L98pUA2ilfqa5nh5zWcbyv3CnfdwyXywgF8PoxaKcUaccfIbaMOaDb
	 lOZcyEwG899CJrITRGBPX0WSWEtrPAarVHZ/6ajYm2kr1+NXphjnMF9NMRktgI/myN
	 D9aLW5Pw6DqACUjazsDAQfMLjBYR/RSPxQJtC/uQ=
Date: Tue, 3 Sep 2024 14:58:14 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in
 udp_lib_get_port().
Message-ID: <2024090344-repave-clench-3d61@gregkh>
References: <2024072924-CVE-2024-41041-ae0c@gregkh>
 <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
 <2024090305-starfish-hardship-dadc@gregkh>
 <CANn89iK5UMzkVaw2ed_WrOFZ4c=kSpGkKens2B-_cLhqk41yCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iK5UMzkVaw2ed_WrOFZ4c=kSpGkKens2B-_cLhqk41yCg@mail.gmail.com>

On Tue, Sep 03, 2024 at 02:53:57PM +0200, Eric Dumazet wrote:
> On Tue, Sep 3, 2024 at 2:07 PM gregkh@linuxfoundation.org
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Sep 03, 2024 at 11:56:17AM +0000, Siddh Raman Pant wrote:
> > > On Mon, 29 Jul 2024 16:32:36 +0200, Greg Kroah-Hartman wrote:
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > >
> > > > udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
> > > >
> > > > [...]
> > > >
> > > > We had the same bug in TCP and fixed it in commit 871019b22d1b ("net:
> > > > set SOCK_RCU_FREE before inserting socket into hashtable").
> > > >
> > > > Let's apply the same fix for UDP.
> > > >
> > > > [...]
> > > >
> > > > The Linux kernel CVE team has assigned CVE-2024-41041 to this issue.
> > > >
> > > >
> > > > Affected and fixed versions
> > > > ===========================
> > > >
> > > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.4.280 with commit 7a67c4e47626
> > > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.10.222 with commit 9f965684c57c
> > >
> > > These versions don't have the TCP fix backported. Please do so.
> >
> > What fix backported exactly to where?  Please be more specific.  Better
> > yet, please provide working, and tested, backports.
> 
> 
> commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99
> Author: Stanislav Fomichev <sdf@fomichev.me>
> Date:   Wed Nov 8 13:13:25 2023 -0800
> 
>     net: set SOCK_RCU_FREE before inserting socket into hashtable
> ...
>     Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> 
> It seems 871019b22d1bcc9fab2d1feba1b9a564acbb6e99 has not been pushed
> to 5.10 or 5.4 lts
> 
> Stanislav mentioned a WARN_ONCE() being hit, I presume we could push
> the patch to 5.10 and 5.4.
> 
> I guess this was skipped because of a merge conflict.

Yes, the commit does not apply, we need someone to send a working
backport for us to be able to take it.

Siddh, can you please do this?

thanks,

greg k-h

