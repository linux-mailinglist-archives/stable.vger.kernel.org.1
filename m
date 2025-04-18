Return-Path: <stable+bounces-134553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC494A9362B
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68FD447730
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E973270EAB;
	Fri, 18 Apr 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MfAiuKDS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0F2566E3;
	Fri, 18 Apr 2025 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973565; cv=none; b=ON/EIeiYUfzI8mrcmIdTZy1e+75zS6CmhSBqSPJ0FvEZxJBb5KFKiA/qvZ9dOV3V5C7l9V1vHyZHh7pEqWka/zQYctXoHJKXXxkcQP1yUcN7r2jrPL9wjFOjXFLfXLMhuxVZozgMepCU2dFa3xKM4DK0sxXsSsnIafA7qGJIppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973565; c=relaxed/simple;
	bh=dG/cOy8J1uvKJSSw4shxPSJ8HCh+NUqjRqOOKf3sbpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gePtdPAdUug0CaGNQhzZMV3d/uYg7ch3nfkoCuUieB6UMyRZIB3iRwQJ1qarjxk9nMY5chC2dz/oVy0y1tf4Gqjg5U/LT3G1rSW+tQyJZm4hBY9bY8mEsbNp8kRHyVHr5WJF9HVJq08kfqgsULbbnbA71w/NSRec0CdOKeYhA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MfAiuKDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26DFC4CEE2;
	Fri, 18 Apr 2025 10:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744973564;
	bh=dG/cOy8J1uvKJSSw4shxPSJ8HCh+NUqjRqOOKf3sbpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfAiuKDSGMK8K+GWYUtgYFfppePKVpOlT+l75KAP6vrNJWj0uu8W3P51EybXB8qvm
	 74W1SJjEn0kxtaHOt1bpN5Wch0LPyabDOuRhC+YYo2EjA+nDjAw4oBeuGPgB9uBEPt
	 Hlrg21thk6sTbt5awCO7iPiR98L1pEnjUzRW+5nY=
Date: Fri, 18 Apr 2025 12:52:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org, kuba@kernel.org,
	liucong2@kylinos.cn, tanggeliang@kylinos.cn,
	MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: Patch "selftests: mptcp: close fd_in before returning in
 main_loop" has been added to the 5.15-stable tree
Message-ID: <2025041827-fling-importer-e363@gregkh>
References: <2025041702-shrouded-subwoofer-25f9@gregkh>
 <9681ac5a-b37d-421c-873a-44860a7dbbe4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9681ac5a-b37d-421c-873a-44860a7dbbe4@kernel.org>

On Fri, Apr 18, 2025 at 11:44:15AM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 17/04/2025 15:57, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     selftests: mptcp: close fd_in before returning in main_loop
> > 
> > to the 5.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      selftests-mptcp-close-fd_in-before-returning-in-main_loop.patch
> > and it can be found in the queue-5.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Thank you for having backported this patch to stable, but can it be
> dropped from the v5.15 queue please (see below)?
> 
> > From c183165f87a486d5879f782c05a23c179c3794ab Mon Sep 17 00:00:00 2001
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > Date: Fri, 28 Mar 2025 15:27:18 +0100
> > Subject: selftests: mptcp: close fd_in before returning in main_loop
> > 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > commit c183165f87a486d5879f782c05a23c179c3794ab upstream.
> > 
> > The file descriptor 'fd_in' is opened when cfg_input is configured, but
> > not closed in main_loop(), this patch fixes it.
> > 
> > Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
> 
> This "Fixes" commit has been introduced in v5.17. From what I see, it
> has not been backported to v5.15.

Oops, my fault, now dropped, thanks for catching this.

greg k-h

