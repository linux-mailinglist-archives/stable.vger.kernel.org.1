Return-Path: <stable+bounces-152869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BAFADCF8B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEF63BBD52
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080F02E2666;
	Tue, 17 Jun 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iT94hm67"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AEA1E1C3A;
	Tue, 17 Jun 2025 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169391; cv=none; b=QffD1xJDoIZNtb8Tb0dJdPhgRINX1EZctWhrVji+GsM60YylWy5Nl8yE4y/0aBcACQQOzvf3vdMQGBITtpXJwVp6XMjZrMttd583BarfYTLknzq2wDxD2dS5CYo+dH3YtzApK/GZlefZy/ibat/S1wHpvL9Y1aaT/p1F3v4mmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169391; c=relaxed/simple;
	bh=s1lebSj6HyDeI0ZWpJeryVPPQTF5uoEiHwsvZBOfwDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZY4reOxkEZFCwkqt8UZaEXcLEw4wLX9RBEzJQfmQ3xuVlHcyJy2LB4EmQsd10hP/M+QCozPRLyE5Sk5tqGU5YvmqDNapTYrjUFwOhTo03FnB7LO0/vqYQ7uutscI1yftd+jrZJY7I42JlQPC4RupV/omjmwTAfU5m8mQicNUH2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iT94hm67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E63C4CEE3;
	Tue, 17 Jun 2025 14:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750169391;
	bh=s1lebSj6HyDeI0ZWpJeryVPPQTF5uoEiHwsvZBOfwDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iT94hm67bhpEfKJzk66U2CgfGtHOaKbXjIamLcuZAtNRjlC5rvB8DLTZoO5nWiNwT
	 a7vRa58DE1WqydE/UwDzh2WXWdkl49N4wK7703ZWtUS1mP5rdmAONh3WKHdDYeTWHA
	 mix00YrOq7MZj7f4RUHNIRvWjRvQlLhE5SesANTU=
Date: Tue, 17 Jun 2025 16:09:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: Backports of d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca for 6.6
 and older
Message-ID: <2025061727-greyhound-lurch-d1f6@gregkh>
References: <20250523211710.GA873401@ax162>
 <2025052722-stainable-remodeler-d7f7@gregkh>
 <20250604235159.GA4185199@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604235159.GA4185199@ax162>

On Wed, Jun 04, 2025 at 04:51:59PM -0700, Nathan Chancellor wrote:
> Hi Greg,
> 
> On Tue, May 27, 2025 at 05:19:34PM +0200, Greg Kroah-Hartman wrote:
> > On Fri, May 23, 2025 at 02:17:10PM -0700, Nathan Chancellor wrote:
> > > Hi Greg and Sasha,
> > > 
> > > Please find attached backports of commit d0afcfeb9e38 ("kbuild: Disable
> > > -Wdefault-const-init-unsafe") for 6.6 and older, which is needed for tip
> > > of tree versions of LLVM. Please let me know if there are any questions.
> > 
> > All now queued up, thanks!
> 
> It looks like the 6.6 backport got lost?
> 
>   $ rg d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca
>   releases/6.1.141/kbuild-disable-wdefault-const-init-unsafe.patch:commit d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca upstream.
>   releases/5.4.294/kbuild-disable-wdefault-const-init-unsafe.patch:commit d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca upstream.
>   releases/5.15.185/kbuild-disable-wdefault-const-init-unsafe.patch:commit d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca upstream.
>   releases/5.10.238/kbuild-disable-wdefault-const-init-unsafe.patch:commit d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca upstream.
>   releases/6.14.8/kbuild-disable-wdefault-const-init-unsafe.patch:From d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca Mon Sep 17 00:00:00 2001
>   releases/6.14.8/kbuild-disable-wdefault-const-init-unsafe.patch:commit d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca upstream.
>   releases/6.12.30/kbuild-disable-wdefault-const-init-unsafe.patch:From d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca Mon Sep 17 00:00:00 2001
>   releases/6.12.30/kbuild-disable-wdefault-const-init-unsafe.patch:commit d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca upstream.
> 
> Are you able to pull it from the original message? It still applies
> cleanly for me.

Odd, it did not apply cleanly at all for me.  I've hand-applied it now,
thanks for catching this.

greg k-h

