Return-Path: <stable+bounces-180828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B824B8E182
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 19:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585F3176AD4
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D808F25C83A;
	Sun, 21 Sep 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtmBmtt1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0A25A2CD
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758475040; cv=none; b=Yu05PQr41nD9arOvXY8ytTIwWagQL2DwFl+Ltc6qcyO6PAn0DVxBzci+iEqM5d0TUiFhh+en6kXDLq3+fd+aj86zJRSr3QG2aMQbjuYi/9BnClgJpZNfNutORRqDG5vj5623S9+s3cvurcO6X+LfLLhntNot86jq7F9M7tIIDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758475040; c=relaxed/simple;
	bh=ouv6InRrp8mYfYW1mXwTk0wu2UATkrefzpWzVxqJ/IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA4jdkuPSu1ECkHqvDJ5EaoVxhlRwv+LZDVRKwr9lLJmLdieO79Wjmo+PK+/5JV/oJXnZ10CTbjotiZQgKGM3u92gTdAA/o5vibCEtmmaiea5tgMQYOTurKoTPomPEINLZv/pwB0coIyTUCqCtOR0hUYXoXNLj+g3CToqFKjqIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CtmBmtt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2CDC4CEE7;
	Sun, 21 Sep 2025 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758475040;
	bh=ouv6InRrp8mYfYW1mXwTk0wu2UATkrefzpWzVxqJ/IU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CtmBmtt11KtG8TSDlSTK1mw9LQn1yGkKby+1Xgd5w6GQ6AHAtwUkwGJ507KZ8tDF5
	 dfzUShivQZQAd3q4XFMd9WshOjXUxl6swvisUxEPGaCjl4+3sA+J3yM79/ukTbJ4Pr
	 2E1hd3lzglNJASMrOi3T4vsU/awcrBDgqAlYTu0c=
Date: Sun, 21 Sep 2025 19:17:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Eric Hagberg <ehagberg@janestreet.com>, stable@vger.kernel.org
Subject: Re: "loop: Avoid updating block size under exclusive owner" breaks
 on 6.6.103
Message-ID: <2025092102-passing-saxophone-d397@gregkh>
References: <CAAH4uRA=wJ1W65PUYpv=bdGFdfvXp7BFEg+=F1g3w-JFRrbpBw@mail.gmail.com>
 <oqe6w7pmfwzzxaqyaebdzrfi63atoudeaayvebmnemngum4vmi@dwd6d4cs3blx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oqe6w7pmfwzzxaqyaebdzrfi63atoudeaayvebmnemngum4vmi@dwd6d4cs3blx>

On Wed, Sep 17, 2025 at 05:47:16PM +0200, Jan Kara wrote:
> On Wed 17-09-25 11:18:50, Eric Hagberg wrote:
> > I stumbled across a problem where the 6.6.103 kernel will fail when
> > running the ioctl_loop06 test from the LTP test suite... and worse
> > than failing the test, it leaves the system in a state where you can't
> > run "losetup -a" again because the /dev/loopN device that the test
> > created and failed the test on... hangs in a LOOP_GET_STATUS64 ioctl.
> > 
> > It also leaves the system in a state where you can't re-kexec into a
> > copy of the kernel as it gets completely hung at the point where it
> > says "starting Reboot via kexec"...
> 
> Thanks for the report! Please report issues with stable kernels to
> stable@vger.kernel.org (CCed now) because they can act on them.
> 
> > If I revert just that patch from 6.6.103 (or newer) kernels, then the
> > test succeeds and doesn't leave the host in a bad state. The patch
> > applied to 6.12 doesn't cause this problem, but I also see that there
> > are quite a few other changes to the loop subsystem in 6.12 that never
> > made it to 6.6.
> > 
> > For now, I'll probably just revert your patch in my 6.6 kernel builds,
> > but I wouldn't be surprised if others stumble across this issue as
> > well, so maybe it should be reverted or fixed some other way.
> 
> Yes, I think revert from 6.6 stable kernel is warranted (unless somebody
> has time to figure out what else is missing to make the patch work with
> that stable branch).

Great, can someone send me the revert?

thanks,

greg k-h

