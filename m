Return-Path: <stable+bounces-20883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20FE85C5C1
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69C71C20E1E
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0F414AD10;
	Tue, 20 Feb 2024 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sSFSv7VF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0235214AD0E
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460811; cv=none; b=sm3/xK6iUR8JdCXRHlk4BKjyq+4NpSYcSBr4p6eEZr+Bz/b2yBmRNnYdwgibTBWFueSPiDyQ5jNXiYkYqvFeqLnr5XJSY9EIKXGDNvGm8R7ntUGasI3TtlkZIgHPo1wsGu+msrnKuofhAiU9elhmULC7BFVAFrMkYk7kOYbvqsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460811; c=relaxed/simple;
	bh=axE8KFZLbeL+cybr2uvkDHnE2j3mR+qRrc9vvfIRhpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWeqXLTnBIvHprnPgwW661fIB7gqQ9SzmMRdWs2QBe/PiVq9B54VUHXB42KMmBQ9BrYaJuu6WhZO0fphVsBgSSEwy7uorfq68F/uKzGA1ZhzpGUOAZ9qAhWcozdo9Ya7j8AVUVrCKYfSaUVHk8qH/DGsW+ifOnzFhD4MLkgffNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sSFSv7VF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0788DC433C7;
	Tue, 20 Feb 2024 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708460810;
	bh=axE8KFZLbeL+cybr2uvkDHnE2j3mR+qRrc9vvfIRhpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSFSv7VFwbjIFM3BAI2kk1QXuvGoZc8nXi18Kn0K8ju94oIT1DK80aMoL9S0CnWpc
	 5U7X4kNHI7B53f86GVVIhPrlJgVp5sDKBIV7iveXlaTutftRxNOejzZblMHn3W8y1l
	 k7kgJxkc1Mhec+BnTgOpn73exEOAWxmQ106PA+2E=
Date: Tue, 20 Feb 2024 21:26:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: ZhaoLong Wang <wangzhaolong1@huawei.com>, stable@vger.kernel.org,
	sfrench@samba.org, kovalev@altlinux.org,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	Darren Kenny <darren.kenny@oracle.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 5.10 0/1] cifs: Fix stack-out-of-bounds in
 smb2_set_next_command()
Message-ID: <2024022000-serpent-luckiness-5c27@gregkh>
References: <20240207115251.2209871-1-wangzhaolong1@huawei.com>
 <ZcOdnBHA0OIB956t@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcOdnBHA0OIB956t@eldamar.lan>

On Wed, Feb 07, 2024 at 04:11:24PM +0100, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Wed, Feb 07, 2024 at 07:52:50PM +0800, ZhaoLong Wang wrote:
> > Hello,
> > 
> > I am sending this patch for inclusion in the stable tree, as it fixes
> > a critical stack-out-of-bounds bug in the cifs module related to the
> > `smb2_set_next_command()` function.
> > 
> > Problem Summary:
> > A problem was observed in the `statfs` system call for cifs, where it
> > failed with a "Resource temporarily unavailable" message. Further
> > investigation with KASAN revealed a stack-out-of-bounds error. The
> > root cause was a miscalculation of the size of the `smb2_query_info_req`
> > structure in the `SMB2_query_info_init()` function.
> > 
> > This situation arose due to a dependency on a prior commit
> > (`eb3e28c1e89b`) that replaced a 1-element array with a flexible
> > array member in the `smb2_query_info_req` structure. This commit was
> > not backported to the 5.10.y and 5.15.y stable branch, leading to an
> > incorrect size calculation after the backport of commit `33eae65c6f49`.
> > 
> > Fix Details:
> > The patch corrects the size calculation to ensure the correct length
> > is used when initializing the `smb2_query_info_req` structure. It has
> > been tested and confirmed to resolve the issue without introducing
> > any regressions.
> > 
> > Maybe the prior commit eb3e28c1e89b ("smb3: Replace smb2pdu 1-element
> > arrays with flex-arrays") should be backported to solve this problem
> > directly. The patch does not seem to conflict.
> 
> It looks there are several people working on the very same problem
> addint patches right now on top.
> 
> See as well https://lore.kernel.org/stable/c4c2f990-20cf-4126-95bd-d14c58e85042@oracle.com/
> 
> But this is already worked on and the proper solution is to only the
> eb3e28c1e89b backport included?
> 
> See as well
> https://lore.kernel.org/regressions/Zb5eL-AKcZpmvYSl@eldamar.lan/ and
> following.
> 
> And this needs to be done consistently for the 5.10.y and 5.15.y
> series.

And I'm totally confused here.

Can someone send me, on top of the patches that are in the current queue
(I'll push out a -rc series soon), for what needs to be done here?  Or,
should I just start reverting things?

lost,

greg k-h

