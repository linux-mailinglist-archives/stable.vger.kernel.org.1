Return-Path: <stable+bounces-23354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D45385FC73
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DE1C23B3C
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0A1482F7;
	Thu, 22 Feb 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PR5td7qa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9F614AD33
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615958; cv=none; b=cOgF+v9X03Kjhf2DHArsW1Ql0pSuafKeUpBNKQECR55MuLePBvXphja4Kb8YhsPYYOl5LXaEVuH+AbgWWJZMh6M0m8mgdUrcBbUg0i/erjPtl5ofSN7OSFijZABYE0U+kjn5e7gtgaCY7/wNJ+eyOQxobnivr0KFf4iLHpCF2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615958; c=relaxed/simple;
	bh=w96ql97wonmBKLP1gLDPFfxtUcu+lN52pcusY5FiHBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvhRaJRSi04G7YETQM8kQAm9n32lwK2sYWQfnMUBEHG1Z61A1pzUZcnWOMB19I66+hazwXbNZVYthX7xRTZTJoxaOw7Yl/1nzoO1O7bIO9zV/2EUXodhUqNbOGN81fpKkQxfHSpNwOd0bO1DjVv7pUFAU13eWwXHX4HhLMz1J74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PR5td7qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAC5C433F1;
	Thu, 22 Feb 2024 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708615957;
	bh=w96ql97wonmBKLP1gLDPFfxtUcu+lN52pcusY5FiHBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PR5td7qaM1opyx5jNnQW9rSehhLGHjT52bKGMfcw+h6bELxT4VK7H9bL6AtxGqHBP
	 BzupOpqxchUeauw4O07DpCa5sf3H8mHVM34aIZFP+IrcCpOhrsZLmTocC5/tKPc4Xw
	 KYub0CQvBk519IRPDJDnqtVH3qZDqIUi5Nw8iEdI=
Date: Thu, 22 Feb 2024 16:32:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Vorel <pvorel@suse.cz>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Cyril Hrubis <chrubis@suse.cz>, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] sched/rt fixes for 4.19
Message-ID: <2024022218-fabric-fineness-0996@gregkh>
References: <20240222151333.1364818-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222151333.1364818-1-pvorel@suse.cz>

On Thu, Feb 22, 2024 at 04:13:21PM +0100, Petr Vorel wrote:
> Hi,
> 
> maybe you will not like introducing 'static int int_max = INT_MAX;' for
> this old kernel which EOL in 10 months.

That's fine, not a big deal :)

> 
> Cyril Hrubis (3):
>   sched/rt: Fix sysctl_sched_rr_timeslice intial value
>   sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset
>   sched/rt: Disallow writing invalid values to sched_rt_period_us
> 
>  kernel/sched/rt.c | 10 +++++-----
>  kernel/sysctl.c   |  5 +++++
>  2 files changed, 10 insertions(+), 5 deletions(-)

Thanks for the patches, but they all got connected into the same thread,
making it impossible to detect which ones are for what branches :(

Can you put the version in the [PATCH X/Y] section like [PATCH 4.14 X/Y]
or just make separate threads so we have a chance?

thanks,

greg k-h

