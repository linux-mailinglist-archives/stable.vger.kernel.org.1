Return-Path: <stable+bounces-210464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E961D3C3A1
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 10:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A25706A4168
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196093C1FF4;
	Tue, 20 Jan 2026 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bcCKGA9D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B860E3A7DF1;
	Tue, 20 Jan 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900921; cv=none; b=O+RK+CwTu8VpFIPZ+BSEWJSmPUzZCfQlhYuRe+mfs9wbX/9AVPdTVwiBFBApP+f6w+NZUM/DRbqyDulXgluz9+FmpsEfYG2ZnGDPXU92iAtyxyAS/anWCKsFJw+Qn/lp4OjXxR6CVFRehg5iKbN7NGv/q+5iZE4lL6PizxBuYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900921; c=relaxed/simple;
	bh=iAPNhBYIJLjx2YruUVpL11H29gOTfYcqJyhaw35nnAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThRZBqJR8fZ8IS9tcM+bMelb52BU0l1KOBjdTgj/SLVnoFsRRzBkkfyxOC4aXdXmQknKAYuCsgQg0awayqSTskrrwlxUaforlxVuHu/0T7KN5fFG0/VSOlS4xzud6SsLXBR1KnDMZzHOkDUkCfoJH6Xn8D9ula91ZPzfi9FM+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bcCKGA9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182EFC19424;
	Tue, 20 Jan 2026 09:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768900921;
	bh=iAPNhBYIJLjx2YruUVpL11H29gOTfYcqJyhaw35nnAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bcCKGA9DnHkK+CmpE5wssc9BlGWJBwiJ0vW3cJzeDYwLzfoG4UW9yQ4BgLlkakq9H
	 ZV4DQ8H/YO54QHkFTtbmw5YSeJ2kzJvxkhkQaswgQlNX7c2PJvpsYhG6Aa4JdQH4Kg
	 a5k851d0DyCu10L6rNwVRM9key34uHR28Bf+K/HI=
Date: Tue, 20 Jan 2026 10:21:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, wen.yang@linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: Allow to use SMP threads for backlog NAPI.
Message-ID: <2026012039-shuffle-apple-43ec@gregkh>
References: <cover.1768751557.git.wen.yang@linux.dev>
 <997bc0de4746100bb69e1bd2ccfb25315d8f62e4.1768751557.git.wen.yang@linux.dev>
 <20260119082534.1f705011@kernel.org>
 <20260119163026.aA1PeSmP@linutronix.de>
 <2026012040-unmolded-dreaded-6e06@gregkh>
 <20260120080104.0yYtfQR7@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120080104.0yYtfQR7@linutronix.de>

On Tue, Jan 20, 2026 at 09:01:04AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-01-20 07:03:58 [+0100], Greg Kroah-Hartman wrote:
> > On Mon, Jan 19, 2026 at 05:30:26PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-01-19 08:25:34 [-0800], Jakub Kicinski wrote:
> > > > On Mon, 19 Jan 2026 00:15:46 +0800 wen.yang@linux.dev wrote:
> > > > > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > > > 
> > > > > commit dad6b97702639fba27a2bd3e986982ad6f0db3a7 upstream.
> > > > > 
> > > > > Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
> > > > > used by drivers which don't do NAPI them self, RPS and parts of the
> > > > > stack which need to avoid recursive deadlocks while processing a packet.
> > > > 
> > > > This is a rather large change to backport into LTS.
> > > 
> > > I agree. While I saw these patches flying by, I don't remember a mail
> > > where it was justified why it was needed. Did I miss it?
> > 
> > Please see patch 0/3 in this series:
> > 	https://lore.kernel.org/all/cover.1768751557.git.wen.yang@linux.dev/
> 
> The reasoning why this is needed is due to PREEMPT_RT. This targets v6.6
> and PREEMPT_RT is officially supported upstream since v6.12. For v6.6
> you still need the out-of-tree patch. This means not only select the
> Kconfig symbol but also a bit futex, ptrace or printk. This queue does
> not include the three patches here but has another workaround having
> more or less the same effect.
> 
> If this is needed only for PREEMPT_RT's sake I would suggest to route it
> via the stable-rt instead and replace what is currently there.

It's already merged, should this be reverted?  I forgot RT was only for
6.12 and newer, sorry.

greg k-h

