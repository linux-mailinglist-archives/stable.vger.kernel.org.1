Return-Path: <stable+bounces-108190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 202DFA0910E
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6CC3AB211
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1120B20E034;
	Fri, 10 Jan 2025 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="spIvR6bs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA44A1A;
	Fri, 10 Jan 2025 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513002; cv=none; b=LFR4iLrTAHc+9zwATuajI4KeVZ6vS4KonC0Oo4dnlH1dJYF3e1VfLYhXuFmFc9Lpo1bKVlMZL3HHfgwzRT8bZvRox0d+XbIsAKec2qUAY3YRLDlK8D1PwVIyST4WhKBJtUNL7NYtNEFCTABxDqSuRjFpFEGyK1+HndzAqOPg7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513002; c=relaxed/simple;
	bh=vI232R9Mr5mNxDTFJQKZ7qrGgt6K77lRKFXQH1uqJ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL7RBGNmFmyABZPNtWZaaqRTv4ulAzvrAMYatZTIEEdJdrNzx9IMjSbbjOPJlBCnDbtVfHiGceQa7S60rhfo9ONwwdr6QketMJZNZ9rLcMPqldM6KTUQuwJNSmnLCd+GGEMbMSWmdN2L6NGx53RU/c1FC8eo+d3XFSDcrXMImj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=spIvR6bs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EF9C4CED6;
	Fri, 10 Jan 2025 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736513002;
	bh=vI232R9Mr5mNxDTFJQKZ7qrGgt6K77lRKFXQH1uqJ7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=spIvR6bskZ+j4BRSUwCDsWTjc3+YVzb36eLIK3Z5Vr/ahE0TzEgLRFC1+NFyKlr4m
	 /xjllVRBHP+vkTzx96wwL8UEs03aC6j3E6kDDhG4E2loftGJsYUDTYIVWV31OJfQVK
	 mlTenBEqqSBI/TPXljgwJy1Xu4EqIJ/LDgVoxqco=
Date: Fri, 10 Jan 2025 13:43:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Clayton <chris2553@googlemail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.6.70
Message-ID: <2025011058-mortify-decimal-96f6@gregkh>
References: <2025010957-discourse-riverside-b734@gregkh>
 <10c7be00-b1f8-4389-801b-fb2d0b22468d@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10c7be00-b1f8-4389-801b-fb2d0b22468d@googlemail.com>

On Fri, Jan 10, 2025 at 08:51:33AM +0000, Chris Clayton wrote:
> On 09/01/2025 12:56, Greg Kroah-Hartman wrote:
> > I'm announcing the release of the 6.6.70 kernel.
> > 
> > All users of the 6.6 kernel series must upgrade.
> > 
> > The updated 6.6.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------
> The build of stable 6.6.70 is failing on my config.
> 
> The error messages are:
> ld.bfd: kernel/kexec_core.o: in function `__crash_kexec':
> kexec_core.c:(.text+0x257): undefined reference to `machine_crash_shutdown'
> ld.bfd: kernel/kexec.o: in function `do_kexec_load':
> kexec.c:(.text+0x13e): undefined reference to `arch_kexec_protect_crashkres'
> ld.bfd: kexec.c:(.text+0x178): undefined reference to `arch_kexec_unprotect_crashkres'
> 
> My config file for building 6.6.x kernels is attached.
> 
> Happy to test a fix but please CC me because I'm not subscribed to LKML.

I think I have this fixed up now and will do a new release in a few
minutes with just this resolved.

thanks!

greg k-h

