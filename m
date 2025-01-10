Return-Path: <stable+bounces-108196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B281A09284
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27C9188DDA0
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B74A20E6F3;
	Fri, 10 Jan 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SwDA4dgy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED54400;
	Fri, 10 Jan 2025 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517085; cv=none; b=AueQeTaeSU4JldsPO6soxjcODWvQfPiXeLnjlFk5BjwF/Q1qagOzWf+cuyQRpkkAuY27UG1nfo3UHD2SrJ5nWpR/09FsNHIDXC0Tex8JMnBZf07ElRhs6mbPvn9t5iyLOSlaXHNPRXHhN3g0j2ZGfCg7pi80xK20TSONYfxtP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517085; c=relaxed/simple;
	bh=lJVekVfftiMh9/rKXfvUXbfjAZUgNdCS0DlDv6D4Lbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIcY2dy3hwzUhGndyTc4gdmpcCSJItp2l05fitNiVjS3KL/SB+1QTBqP1LgXwqKtWSnjy5VSt7puDbTHXfJFl7pBCjfIpujAYJNDKY2OBLH6CDOhTnmzjeH5ZLNKYIBLpSH9jIctTYfUZ3i2ugk5y64P72b7BJ3mmzqdTy4W2Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SwDA4dgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9D5C4CED6;
	Fri, 10 Jan 2025 13:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736517084;
	bh=lJVekVfftiMh9/rKXfvUXbfjAZUgNdCS0DlDv6D4Lbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SwDA4dgyKQy2uDCsGbxmCqo82dsGRHU5nZb5EYqgycwNcz7wC7qzh6MVFYt5IPZ6+
	 JAz3K38zwnKTlzz3vK3sEl4jkhxXayr97SZUI2X3h+T0z/jExAxNzT4rUEDXL9KzXT
	 lkcybFFWY+XPH1tJQhAXQf2AeX6B1zHWchDqm3MQ=
Date: Fri, 10 Jan 2025 14:51:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Clayton <chris2553@googlemail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.6.70
Message-ID: <2025011008-exporter-support-0ad7@gregkh>
References: <2025010957-discourse-riverside-b734@gregkh>
 <10c7be00-b1f8-4389-801b-fb2d0b22468d@googlemail.com>
 <2025011058-mortify-decimal-96f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025011058-mortify-decimal-96f6@gregkh>

On Fri, Jan 10, 2025 at 01:43:17PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Jan 10, 2025 at 08:51:33AM +0000, Chris Clayton wrote:
> > On 09/01/2025 12:56, Greg Kroah-Hartman wrote:
> > > I'm announcing the release of the 6.6.70 kernel.
> > > 
> > > All users of the 6.6 kernel series must upgrade.
> > > 
> > > The updated 6.6.y git tree can be found at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
> > > and can be browsed at the normal kernel.org git web browser:
> > > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > > ------------
> > The build of stable 6.6.70 is failing on my config.
> > 
> > The error messages are:
> > ld.bfd: kernel/kexec_core.o: in function `__crash_kexec':
> > kexec_core.c:(.text+0x257): undefined reference to `machine_crash_shutdown'
> > ld.bfd: kernel/kexec.o: in function `do_kexec_load':
> > kexec.c:(.text+0x13e): undefined reference to `arch_kexec_protect_crashkres'
> > ld.bfd: kexec.c:(.text+0x178): undefined reference to `arch_kexec_unprotect_crashkres'
> > 
> > My config file for building 6.6.x kernels is attached.
> > 
> > Happy to test a fix but please CC me because I'm not subscribed to LKML.
> 
> I think I have this fixed up now and will do a new release in a few
> minutes with just this resolved.

Ok, 6.6.71 is out and should have this resolved now, thanks.

greg k-h

