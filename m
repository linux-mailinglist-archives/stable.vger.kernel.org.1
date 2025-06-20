Return-Path: <stable+bounces-155169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB37AE1F6B
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943EE1662DF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309352DFF17;
	Fri, 20 Jun 2025 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yGtyMaEx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE02DFA35;
	Fri, 20 Jun 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434581; cv=none; b=AD5KJNH2/Lf1EZzljJtW6fLAFjka1uBje+Kb0nZg7sFTDaLIN5qM8qt+uyJQIwGxbOFCwKqrReE6S5Ho7t2PUIba3ZZiUUbo8ERtRVNMyzOp2C3HOWwvDFUKFyJUfMo9+78cTXtRV/BOjonYzNB/42b7GMHK6l1OxR/9ZboB5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434581; c=relaxed/simple;
	bh=XfXkucsg/DgkxxhnsFLFgIC3Gy5yrS/ZkvxsM/xfDaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUW4Ra8UXunMITiTLBEE8F2h+B6QLNQiGnRdKeWV1HZKkAK3599GamGW2HMTOkOwb3oQFzYWnQ5fqwE0H5B1foHvetUd29KUH6bN1Y5igdx7xZ8EwCu3JTRPUPGCA67RRgRS9Cpz6y8+NdySZPoAOY7I1u4VEiZiCldEo0AfiAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yGtyMaEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DAFC4CEE3;
	Fri, 20 Jun 2025 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750434580;
	bh=XfXkucsg/DgkxxhnsFLFgIC3Gy5yrS/ZkvxsM/xfDaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yGtyMaExFRNZYmeKa5SDJ0Q0LHOalj4quyrApCF/rWMTO7v6kSsNIAyKp/SnymfAI
	 CWfw7XAXDozdJpTAg/rYrfVj5EvaXvtXMxNg5jtpxnSQdwD1hB5dknb//vRXkl0NXR
	 cG+41Ga2X48lJRAlJTRgexGqy3mMJ2dSrjs48Ikk=
Date: Fri, 20 Jun 2025 17:49:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	thomas.weissschuh@linutronix.de, Willy Tarreau <w@1wt.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Patch "tools/nolibc: use intmax definitions from compiler" has
 been added to the 6.15-stable tree
Message-ID: <2025062008-unwrapped-overdrive-0e82@gregkh>
References: <20250620022618.2600341-1-sashal@kernel.org>
 <a7045756-cd82-4241-a5b0-d8f6fad87b1c@t-8ch.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7045756-cd82-4241-a5b0-d8f6fad87b1c@t-8ch.de>

On Fri, Jun 20, 2025 at 06:46:24AM +0200, Thomas Weißschuh wrote:
> Hi stable team,
> 
> On 2025-06-19 22:26:18-0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     tools/nolibc: use intmax definitions from compiler
> > 
> > to the 6.15-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      tools-nolibc-use-intmax-definitions-from-compiler.patch
> > and it can be found in the queue-6.15 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> As discussed in [0] and its ancestors, please only backport nolibc
> patches are were explicitly tagged for stable@.
> 
> [0] https://lore.kernel.org/lkml/2025061907-finance-dodgy-b0ae@gregkh/

I don't think Sasha had time to sync up here...

I'll drop this one, and the other nolibc patch that he added to the
queues as well.

thanks,

greg k-h


