Return-Path: <stable+bounces-64774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5FB943123
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7BE1C217CA
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E2D1B29AA;
	Wed, 31 Jul 2024 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SYHqC2Ww"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737C16C86F;
	Wed, 31 Jul 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433267; cv=none; b=kKXMoicYO5J/5eHB4fOLbVaM8K9Hj3sXI0oGo8/VXyloH0PJxJU6O2AjNxhs/3K86H5Uvtil10IMGRVizjmGTJ1J/RoA4uSO1aqnVDukxjPIqzAi3gv5S1TJMUWldAbWhNHWmnyxlX7Z8gl/YJ0wSFNiXQQtHBqPgI4RSpQPakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433267; c=relaxed/simple;
	bh=JyXIamiKWny/0n0henYkJEDGIBxvTwJExYomK7HjifU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO1WD/xtdDGSUmjlOdCJf3Z9V1eJF/W95R2yRzpCiAgjTb92EQgb6fyTPCyIu52V2GNCO+a6GfXt6t5GTTEemkRxo2wpVZzewQyjAuk6g5XYASHrROJcN0NCQwBiVDxChWo6r1Hp3XMfw/vLo38iFJuxilQE+sSc9D+oEuRa0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SYHqC2Ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0418C116B1;
	Wed, 31 Jul 2024 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722433266;
	bh=JyXIamiKWny/0n0henYkJEDGIBxvTwJExYomK7HjifU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SYHqC2Ww1rz1a9lNNnDzdwscOh5+2B3xhCYWoOd7G+Rxvg6YvXUKy1oA/IHfpQDNh
	 koRFdtciYHnWEcd75mgzzCmB9c+RbHiqU3i++gk+kY4agh1FyO4dBAU6jJYc8DlM26
	 lcoOFuexKViC2590X2jmj7bzYiShJpHq615Xzz1k=
Date: Wed, 31 Jul 2024 15:41:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	matoro <matoro_mailinglist_kernel@matoro.tk>,
	John David Anglin <dave.anglin@bell.net>,
	Linux Parisc <linux-parisc@vger.kernel.org>, Deller <deller@gmx.de>,
	John David Anglin <dave@parisc-linux.org>, stable@vger.kernel.org
Subject: Re: Crash on boot with CONFIG_JUMP_LABEL in 6.10
Message-ID: <2024073133-attentive-important-d419@gregkh>
References: <096cad5aada514255cd7b0b9dbafc768@matoro.tk>
 <bebe64f6-b1e1-4134-901c-f911c4a6d2e6@bell.net>
 <11e13a9d-3942-43a5-b265-c75b10519a19@bell.net>
 <cb2c656129d3a4100af56c74e2ae3060@matoro.tk>
 <20240731110617.GZ33588@noisy.programming.kicks-ass.net>
 <877cd1bsc4.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cd1bsc4.fsf@gentoo.org>

On Wed, Jul 31, 2024 at 02:31:55PM +0100, Sam James wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Tue, Jul 30, 2024 at 08:36:13PM -0400, matoro wrote:
> >> On 2024-07-30 09:50, John David Anglin wrote:
> >> > On 2024-07-30 9:41 a.m., John David Anglin wrote:
> >> > > On 2024-07-29 7:11 p.m., matoro wrote:
> >> > > > Hi all, just bumped to the newest mainline starting with 6.10.2
> >> > > > and immediately ran into a crash on boot. Fully reproducible,
> >> > > > reverting back to last known good (6.9.8) resolves the issue. 
> >> > > > Any clue what's going on here?
> >> > > > I can provide full boot logs, start bisecting, etc if needed...
> >> > > 6.10.2 built and booted okay on my c8000 with the attached config.
> >> > > You could start
> >> > > with it and incrementally add features to try to identify the one
> >> > > that causes boot failure.
> >> > Oh, I have an experimental clocksource patch installed.  You will need
> >> > to regenerate config
> >> > with "make oldconfig" to use the current timer code.  Probably, this
> >> > would happen automatically.
> >> > > 
> >> > > Your config would be needed to duplicate.    Full boot log would also help.
> >> > 
> >> > Dave
> >> 
> >> Hi Dave, bisecting quickly revealed the cause here.
> >
> > https://lkml.kernel.org/r/20240731105557.GY33588@noisy.programming.kicks-ass.net
> 
> Greg, I see tglx's jump_label fix is queued for 6.10.3 but this one
> isn't as it came too late. Is there any chance of chucking it in? It's
> pretty nasty.

What is the git id of this in Linus's tree?

thanks,

greg k-h

