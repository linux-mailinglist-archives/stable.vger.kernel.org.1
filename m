Return-Path: <stable+bounces-167114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD79B2220D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F927A6A30
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 08:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0349D1388;
	Tue, 12 Aug 2025 08:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dED4kvv1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBE2E611B;
	Tue, 12 Aug 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988955; cv=none; b=i7/C3tTY7tI7Gd7WuLR9UFp2S5gqWA7/IkxGm3DLTvTjo5D241opzqDiEZ/phu54cL/mEoAI0BxGByDTUeqiOlFIg9bslxCW4614lDogRpgN6MT0LjGeM12JlciUj6Zcgn8DQAt1WFkfGSeMQPGJ5TY5kZYkenjwk1Efl3N14PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988955; c=relaxed/simple;
	bh=yejeqnIcY0afKkvBfa59g0oUr+7FhSjBJOb0ih+bN1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIOy0bdSwXlR43RU2PJmTEl6IcsHiiGQ/DCrBn2+GZTMQ3HRvdSGmt9Y4ybp0P4/Gs8XOyLCEPbgkxWLoFTKahR7MaVtmrsQnapHXI+0k39JDNw3ZRoB6mvvQ2Z6Q1mTjpMbh4SIBu3JarO5yK2dTmV7Rf/2dGNLSvxcYyIxGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dED4kvv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B14C4CEF0;
	Tue, 12 Aug 2025 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754988955;
	bh=yejeqnIcY0afKkvBfa59g0oUr+7FhSjBJOb0ih+bN1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dED4kvv1wVrMYi+ZldtTResyuxRJpuSAWBBbtD5x7upQNfUVGc26mTofL9+zM8Chs
	 gZswRuYVp9N34ZAKOAWHEDgE3MACySIJNg24HMissfd2FKwyhC0PRTe43OPszmlMI/
	 e72TfQwCQc1tEJ8p58ElnYqCgN+6+mP33eVyPLvE=
Date: Tue, 12 Aug 2025 10:55:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	stable-commits@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Patch "sched: Do not call __put_task_struct() on rt if
 pi_blocked_on is set" has been added to the 6.16-stable tree
Message-ID: <2025081238-tiring-prelaunch-3338@gregkh>
References: <20250808232726.1423484-1-sashal@kernel.org>
 <aJlFVnuKwSyDTXOq@uudg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJlFVnuKwSyDTXOq@uudg.org>

On Sun, Aug 10, 2025 at 10:20:22PM -0300, Luis Claudio R. Goncalves wrote:
> On Fri, Aug 08, 2025 at 07:27:26PM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     sched: Do not call __put_task_struct() on rt if pi_blocked_on is set
> > 
> > to the 6.16-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      sched-do-not-call-__put_task_struct-on-rt-if-pi_bloc.patch
> > and it can be found in the queue-6.16 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hi Sasha!
> 
> I am the author of that patch and I sent a follow-up patch that fixes a
> mistake I made on the original patch:
> 
>     [RESEND PATCH] sched: restore the behavior of put_task_struct() for non-rt
>     https://lore.kernel.org/all/aJOwe_ZS5rHXMrsO@uudg.org/
> 
> The patch you have does not match what is in the description. I unfortunately
> sent the wrong version of the patch on the verge of leaving for a long vacation
> and only noticed that when I returned. The code is correct, but does not
> match the commit description and is a change that I would like to propose
> later as an RFC, not the simpler bugfix originally intended.
> 
> I suggest waiting for the follow-up patch mentioned above to include both on
> stable kernels.

Ok, I'll go drop this now but please let us know when both patches
shoudl be added.

thanks,

greg k-h

