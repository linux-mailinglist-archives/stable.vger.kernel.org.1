Return-Path: <stable+bounces-73029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F374896BABE
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F70E1C245F3
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623061D2204;
	Wed,  4 Sep 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k9FTY3Pk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE51D048F;
	Wed,  4 Sep 2024 11:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725449477; cv=none; b=kzmMkKJh7P4qe0dzrD6mgk9UxKl9pxLp5Gk6r+Ccx4ed82ed5ctLnjTJSLY3MpRAZR9pWUtu6Om8Mb5j8J1DmDHFLKo1tSCMFqQWH9Vg0JKAEmftoDHQmk8uc7vTp+yEcE8d5sOphzl49p6bl2lVoUd0thkx6SbbiQF3oAr5y94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725449477; c=relaxed/simple;
	bh=/LfWuIAG+i7Ur49GNG0o1hwe+SrTsWIePqk2P6TPaPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JM0d9DQAIDSIZEind0QsDFKIff2LMDjE/6sdXZolVlQotvBTrYxGBUnsZ6QmW3uEVU/gMV6j7jwAxV4VwzrsrR6Y4SJX47A8W9mgZNpctWYQqfPyEB8U7jC+DGczZzcmb0nFurtJ8Yf9m6zb2wZLo9La3izl862LnVFCstHhpNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k9FTY3Pk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2FEC4CEC2;
	Wed,  4 Sep 2024 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725449476;
	bh=/LfWuIAG+i7Ur49GNG0o1hwe+SrTsWIePqk2P6TPaPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9FTY3PkXNFmB0vP/IlGGGc5UtElKP+kn+3yGB65uvIsxy27gnDBdaQ3cG1HIIgpM
	 PSH46xen5H14P+oV2cbHfmqSwPW1s4vRwTQRNXeTykdydpet960VCve+dy6Db6RWKQ
	 uMmTILwvNCkxtwsxnpwbxvPWq2KDuq9F0HKlfDOU=
Date: Wed, 4 Sep 2024 13:31:13 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "edumazet@google.com" <edumazet@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in
 udp_lib_get_port().
Message-ID: <2024090401-underuse-resale-3eef@gregkh>
References: <2024072924-CVE-2024-41041-ae0c@gregkh>
 <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
 <2024090305-starfish-hardship-dadc@gregkh>
 <CANn89iK5UMzkVaw2ed_WrOFZ4c=kSpGkKens2B-_cLhqk41yCg@mail.gmail.com>
 <2024090344-repave-clench-3d61@gregkh>
 <64688590d5cf73d0fd7b536723e399457d23aa8e.camel@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64688590d5cf73d0fd7b536723e399457d23aa8e.camel@oracle.com>

On Wed, Sep 04, 2024 at 11:26:36AM +0000, Siddh Raman Pant wrote:
> On Tue, Sep 03 2024 at 18:28:14 +0530, gregkh@linuxfoundation.org
> wrote:
> > On Tue, Sep 03, 2024 at 02:53:57PM +0200, Eric Dumazet wrote:
> > > On Tue, Sep 3, 2024 at 2:07 PM gregkh@linuxfoundation.org
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > On Tue, Sep 03, 2024 at 11:56:17AM +0000, Siddh Raman Pant wrote:
> > > > > On Mon, 29 Jul 2024 16:32:36 +0200, Greg Kroah-Hartman wrote:
> > > > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > > > 
> > > > > > udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > We had the same bug in TCP and fixed it in commit 871019b22d1b ("net:
> > > > > > set SOCK_RCU_FREE before inserting socket into hashtable").
> > > > > > 
> > > > > > Let's apply the same fix for UDP.
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > The Linux kernel CVE team has assigned CVE-2024-41041 to this issue.
> > > > > > 
> > > > > > 
> > > > > > Affected and fixed versions
> > > > > > ===========================
> > > > > > 
> > > > > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.4.280 with commit 7a67c4e47626
> > > > > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.10.222 with commit 9f965684c57c
> > > > > 
> > > > > These versions don't have the TCP fix backported. Please do so.
> > > > 
> > > > What fix backported exactly to where?  Please be more specific.  Better
> > > > yet, please provide working, and tested, backports.
> > > 
> > > 
> > > commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99
> > > Author: Stanislav Fomichev <sdf@fomichev.me>
> > > Date:   Wed Nov 8 13:13:25 2023 -0800
> > > 
> > >     net: set SOCK_RCU_FREE before inserting socket into hashtable
> > > ...
> > >     Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
> > > 
> > > It seems 871019b22d1bcc9fab2d1feba1b9a564acbb6e99 has not been pushed
> > > to 5.10 or 5.4 lts
> > > 
> > > Stanislav mentioned a WARN_ONCE() being hit, I presume we could push
> > > the patch to 5.10 and 5.4.
> > > 
> > > I guess this was skipped because of a merge conflict.
> > 
> > Yes, the commit does not apply, we need someone to send a working
> > backport for us to be able to take it.
> > 
> > Siddh, can you please do this?
> 
> Sure.
> 
> I see there are Stable-dep commits too, but the seem unrelated and
> require some commits from another feature patchset. Do I need to
> backport them too?

Do what you think you need to do :)

