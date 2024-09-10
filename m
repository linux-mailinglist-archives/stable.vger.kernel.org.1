Return-Path: <stable+bounces-74125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9126972AE1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED89B21C2D
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09D517D36A;
	Tue, 10 Sep 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NYpjFeAj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E523282E2;
	Tue, 10 Sep 2024 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953726; cv=none; b=nSRG4+NqWoXDdqZxcKMrzjFUV3S9PKgmDgNLIYzZBy7E83q42WAVlq6zco8RMasUcHFenUpCIX43TWOq/qSiOO8WFUPogw+VnC0An7K0Opw3twQDxk+2qIL3NGAsaM3O60Edn5AhpFS+PgHeez1iMj5zdKPuiWD6hVGYBfVycoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953726; c=relaxed/simple;
	bh=jmuPBBDko1ACFWgPbOy808BcO+FQdwdlAD0birFTW8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCWKG0YMuwmwlltk18LRTWlXnhaWGelBI5l9y6Pi8CfMb+Ny+Iwbt9e9kpJiuCNtLViMz6S38Hcraz9v1k1oUNtp0BjqCaZooJJ25B+o/sZOhEzlHJ5JF6l1yvBZg8pGEw+6XUl9/T5L3v04Uwp3X9jYlHswfOyOcW+yOZDdk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NYpjFeAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B270CC4CEC3;
	Tue, 10 Sep 2024 07:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725953726;
	bh=jmuPBBDko1ACFWgPbOy808BcO+FQdwdlAD0birFTW8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYpjFeAjrPCkwZGbEKuSxbFLY2tgvWIv7H9pYXAEXz/cSDZD4V3Enj+396B4IAc0x
	 UO7N8DRT5qG3IwgZJv/gI4fNvwRzZT8SXunbM/apNNoiyXtATGKOqJtY88XdfJSbQt
	 8RJj04XaTDMTEGengK4W24Xpn1QV+wiDEtiVq/mA=
Date: Tue, 10 Sep 2024 09:35:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jamie Heilman <jamie@audible.transient.net>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	stable@vger.kernel.org
Subject: Re: regression in 6.6.46; arch/x86/mm/pti.c
Message-ID: <2024091014-crawling-copied-8034@gregkh>
References: <Zt6Bh2J5xMcCETbb@audible.transient.net>
 <87h6apcp9x.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6apcp9x.ffs@tglx>

On Mon, Sep 09, 2024 at 08:30:34AM +0200, Thomas Gleixner wrote:
> On Mon, Sep 09 2024 at 05:03, Jamie Heilman wrote:
> > 3db03fb4995e ("x86/mm: Fix pti_clone_entry_text() for i386") which got
> > landed in 6.6.46, has introduced two back to back warnings on boot on
> > my 32bit system (found on 6.6.50):
> 
> Right.
> 
> > Reverting that commit removes the warnings (tested against 6.6.50).
> > The follow-on commit of c48b5a4cf312 ("x86/mm: Fix PTI for i386 some
> > more") doesn't apply cleanly to 6.6.50, but I did try out a build of
> > 6.11-rc7 and that works fine too with no warnings on boot.
> 
> See backport below.
> 
> Thanks,

Now queued up, thanks!

greg k-h

