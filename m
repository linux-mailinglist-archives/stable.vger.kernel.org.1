Return-Path: <stable+bounces-106847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B179A026A1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 14:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E42E163D6A
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2526D1D619D;
	Mon,  6 Jan 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ze6cRWKY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E21DB34C;
	Mon,  6 Jan 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170454; cv=none; b=ZVoACvJ9WieOM0SssvTZdGn6r4nuLcH4LSLkCWVoetKrCc7qmEAo0w4JppU8ADy+0yRJIrs2kzN9b6ph44fdCTYsWlwo83yrE058TylV1q1XUi7pMk5ZEj2cjjV/VXO0niV7+1eU9c1OMg0Lj6pB99OpmSzKIFFFv6wWZF5p2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170454; c=relaxed/simple;
	bh=LiTPLnS/YPgeqhZkXlGdg/xWbx23NQMG4G7t3gGgjW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejfNfJW771dFKwKabW4qwL3XRw4069Yo6bEPeRiiJNF0j3stiFSfof/zSAkFcbUb+F0eZEwAqEySrMGEJKpktPLPiOX/cTPuxZyoV7jnEvZ+pK+s8uZxdx1hsJkvfU0DoUwXf+QrDXuy15NwPwRAAc48HEPsZFoaLTvuTcnKxLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ze6cRWKY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FBFC4CED2;
	Mon,  6 Jan 2025 13:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736170454;
	bh=LiTPLnS/YPgeqhZkXlGdg/xWbx23NQMG4G7t3gGgjW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ze6cRWKYFg5BzmdlU27+A3I0Ipxpxc9mxFUfvluJU89gmE5fnB3A2Ijfb8+NYrCbG
	 HK2elDqsuq5AtMZieY/7Epa72reKixNZvIFNXeR1FrF04ODQU2Lrp42t+gYCxepe+U
	 A71cnc0UcR+oaP1wVej5+QQNzlPnOYmRsVAO85KY=
Date: Mon, 6 Jan 2025 14:34:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Koichiro Den <koichiro.den@canonical.com>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org,
	bigeasy@linutronix.de, stable-commits@vger.kernel.org
Subject: Re: Patch "vmstat: disable vmstat_work on vmstat_cpu_down_prep()"
 has been added to the 6.12-stable tree
Message-ID: <2025010603-tabasco-laziness-db0e@gregkh>
References: <2025010620-glazing-parakeet-e197@gregkh>
 <x4sqfvmoj2d42ovg5ebn2ytoi3w54sxgrbn5mes3wz3nzenyk7@3eabarxtsiht>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x4sqfvmoj2d42ovg5ebn2ytoi3w54sxgrbn5mes3wz3nzenyk7@3eabarxtsiht>

On Mon, Jan 06, 2025 at 09:02:59PM +0900, Koichiro Den wrote:
> On Mon, Jan 06, 2025 at 11:41:20AM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     vmstat: disable vmstat_work on vmstat_cpu_down_prep()
> > 
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      vmstat-disable-vmstat_work-on-vmstat_cpu_down_prep.patch
> > and it can be found in the queue-6.12 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hi, could you hold off on adding this for now? It's broken [1] and needs to
> be fixed. Once a follow-up fix is ready, I'll make sure to notify you.
> 
> [1] https://lore.kernel.org/linux-mm/7ed97096-859e-46d0-8f27-16a2298a8914@lucifer.local/T/#m758eb53a012a4348c256ee8a723a6a29f86906df

Now dropped, thanks.

greg k-h

