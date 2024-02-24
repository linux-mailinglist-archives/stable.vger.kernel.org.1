Return-Path: <stable+bounces-23554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5018622B3
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 06:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21D31F21263
	for <lists+stable@lfdr.de>; Sat, 24 Feb 2024 05:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BDA14AA1;
	Sat, 24 Feb 2024 05:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xL2fmeJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346AF2563;
	Sat, 24 Feb 2024 05:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708751784; cv=none; b=Utexi2hmqy5d3UdxtLdkPfRMW6IjfRUnTA+dh+liB2qmE3q1fSkvcqjfNrJMn3rnjL+3CkthK5WKvR60QuHEQHnksuGpum6Zz/oIBcFoMmzXe5LiHWPoyWSIUQK6T79AuOl7aPGq8Np49muneUZJbADPUx2ac1yKtBRPTRXGTrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708751784; c=relaxed/simple;
	bh=qJQALefOKH14wsuu3PAv+A5odVp628cpkHWR7VQUk2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6U/C3x87usBbnCKM3eAYen/XzGhlDqfOlQncjLF7YmwreAcLiTJbk2mQHKoZ77KMJssXNvXVphJdd79QbM7vSSDgSQXFg8F6x2lmJ+d3OIUnmyURSdyTb77YkHfgNsrMPGXaaId7+MGiwGhd1Ew+Ou3W90s3MB3t6DkQ+c3KKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xL2fmeJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102EAC433F1;
	Sat, 24 Feb 2024 05:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708751783;
	bh=qJQALefOKH14wsuu3PAv+A5odVp628cpkHWR7VQUk2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xL2fmeJaNR2AMiJkHPL18g6nK42RhXLSw+MSmGAVNw9QRTJivv3mXstdQLpYR9WQ2
	 SYwlX0b5VLkQYkRjlHtVbcEjn5alUn2x/ixQeONtEnKEt17mUbI9AwNee1x272NwtV
	 blLh7lNrm4DWrKt9uVcHC9YN6vvl44DxC1zTfPk8=
Date: Sat, 24 Feb 2024 06:16:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, joel@joelfernandes.org,
	chenzhongjin@huawei.com, rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] linux-4.19/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
Message-ID: <2024022430-uninsured-zoom-f78c@gregkh>
References: <20240207110846.25168-1-qiang.zhang1211@gmail.com>
 <2024022323-profile-dreaded-3ac7@gregkh>
 <ec2482a6-a19b-4152-b51d-13c812eacf64@paulmck-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec2482a6-a19b-4152-b51d-13c812eacf64@paulmck-laptop>

On Fri, Feb 23, 2024 at 11:48:49AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 23, 2024 at 02:15:30PM +0100, Greg KH wrote:
> > On Wed, Feb 07, 2024 at 07:08:46PM +0800, Zqiang wrote:
> > > From: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.
> > 
> > Again, not a valid commit id :(
> 
> Apologies!  With luck, there will be a valid ID next merge window.
> This one does not backport cleanly, so we were trying to get ahead of
> the game.  Also, some of the people testing needed the backport due
> to the usual issues.  :-/
> 
> Any advice to handle this better next time around?  (Aside from us
> avoiding CCing stable too soon...)

You can just wait until it hits Linus's tree, otherwise we do get
confused :)

Or if you don't want to wait, put it in the notes section below the ---
line and say "this isn't in Linus's tree yet, the git id mentioned is a
lie!" or something like that.  Give us a chance to figure it out
please...

thanks,

greg k-h

