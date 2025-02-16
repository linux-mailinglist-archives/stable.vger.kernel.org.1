Return-Path: <stable+bounces-116510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C1A37257
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 08:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8979F3A9AD9
	for <lists+stable@lfdr.de>; Sun, 16 Feb 2025 07:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99831149C4A;
	Sun, 16 Feb 2025 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xRaPUdvI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA212E1CD
	for <stable@vger.kernel.org>; Sun, 16 Feb 2025 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739689587; cv=none; b=uHRXTH+YcBmvPTF6v06QX8kbvQjJBYHGEqnfk1GpzCf4ucOqMz6xbK8O0LmV72iWjc+1iN9kLq2dXAvCJigTXNdlyRlHMK47XSw87cOzRoNCRiyPb6nM7JU0nPAh8Ypvyt7ky68GiSRiECtTS7Tm1qS9oNGhf2p0QUOp30vIWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739689587; c=relaxed/simple;
	bh=LmizFmJ4duQNQgZ+Mfqco2ZQ9gHHP4vhpiy2K+5eexU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cmo+NXi3nRxtvP4xIfa+TgQOcFow8JgyBErZjGgpwKBZHeWeTuR/56x+JwmijScpjo9FyssN5hsSlDUU+VGgbQSpUBufML7X2vo8TJc0rX9a47HJXu75KwRBqp2nPP405hc+ID/d4/MwFDRd92ZgES/wMx70vHZEBLMeALLfLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xRaPUdvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAF5C4CEDD;
	Sun, 16 Feb 2025 07:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739689586;
	bh=LmizFmJ4duQNQgZ+Mfqco2ZQ9gHHP4vhpiy2K+5eexU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xRaPUdvIrMQm6DzagP/Oqt4tVSQpX6MLiscQ6ANk5nXf+9QpW3MM4I3xc2ghS1dMB
	 z7TUkCeTaQABk0aO+JYamsiWilSuLQ6Zeexmm47Cv3WfXQFAFprr8mqAjs2y7KnIN7
	 LdrEhw9QwX7xtO8Fv/ZnoFaRAPwlZnrWVldvhEy8=
Date: Sun, 16 Feb 2025 08:05:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: Waiman Long <llong@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Phil Auld <pauld@redhat.com>,
	stable <stable@vger.kernel.org>
Subject: Re: Suspend failures (was [PATCH 6.13 000/443] 6.13.3-rc1 review)
Message-ID: <2025021657-cesspool-pantomime-4774@gregkh>
References: <20250213142440.609878115@linuxfoundation.org>
 <e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com>
 <2025021459-guise-graph-edb3@gregkh>
 <9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com>
 <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
 <012c4a3a-ead8-4bba-8ec9-5d5297bbd60c@redhat.com>
 <905eb8ab-2635-e030-b671-ab045b55f24c@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <905eb8ab-2635-e030-b671-ab045b55f24c@applied-asynchrony.com>

On Sat, Feb 15, 2025 at 08:57:56PM +0100, Holger Hoffstätte wrote:
> On 2025-02-15 02:35, Waiman Long wrote:
> <snip>
> 
> > Commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
> > earlier for hotplug") is the last patch of the 3 patch series.
> > 
> >   1) commit 41d4200b7103 ("sched/deadline: Restore dl_server bandwidth on non-destructive root domain changes")
> >   2) commit d4742f6ed7ea ("sched/deadline: Correctly account for allocated bandwidth during hotplug")
> >   3) commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > 
> > It looks like 6.13.3-rc1 has patches 2 and 3, but not patch 1. It is
> > possible that patch 3 has a dependency on patch 1. My suggestion is
> > to either take patch 1 as well or none of them.
> Now that we have 6.13.3-rc3 passing all tests I got curious and applied
> the whole series again. And voila: suspend works reliably (3 out of 3).
> Mystery solved.
> 
> So Greg, feel free to add the whole 3-part series in the next round.

Thanks for testing, I'll consider it then, after things have calmed down :)

greg k-h

