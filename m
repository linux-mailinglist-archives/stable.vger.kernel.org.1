Return-Path: <stable+bounces-210227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD28D39835
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 18:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E95DD3009486
	for <lists+stable@lfdr.de>; Sun, 18 Jan 2026 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA002236F3;
	Sun, 18 Jan 2026 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AqtYKp4K"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0431D5CFB
	for <stable@vger.kernel.org>; Sun, 18 Jan 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755777; cv=none; b=h0SmQN7HrMeJINzJ7W40zH6dwsoSL1b6veZUO6NjwAp7ikKRykIsS3rQ/DdMHpq5wONLtin4Hl2FLLcrlymecLZdRdKXyGHZ8Bw+eExDpk/XDZNpYIdpgu5KY6mKCWTOD1rx2e+FLZqNHILc840+HY9B0k9PGU9g+uvKrNOzzgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755777; c=relaxed/simple;
	bh=++Np939W0w+9LTtwQN5ddj4LNlIg4JvuTfXCCRly/kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEaYo51DINUwJBb9zBNOmBDi0NE/vjBRu7z7ARRQ9cb0RnPqvf4dS85RA0wFZrUY3N4Gy/hy7ElEWIsJDCqmcHH6fLcPEvUhWC+ahlmecQBdHruOPdarnWP5CIGroIW4QqKmMG3Sgna/nlB2Fj953gxdGBdnL8d0cN0Xi0pnTbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AqtYKp4K; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f5f4a18-82b4-4f67-ae98-cdf5b7f8012b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768755773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHMiTnX6Q49LBdFrwHo07sttVUw6bSThK4YGNL15ubo=;
	b=AqtYKp4Kai+NPIKDqHmhHcf104LiGy3h4QMvSTQB+3aOI/E3tDOOnCCDsspehpbgy5AwSz
	OsWKsTWTZQ16BO/AkAleStAw0AM8yiVQyPuEqR9DlD+0USj4+h9nUAmjmszxiiLoJ+uXDn
	FyuskXH5ZpH2q7F3MetUsrjU8Kksflc=
Date: Mon, 19 Jan 2026 01:02:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.6 0/3] net: Backlog NAPI threading for PREEMPT_RT
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1768751557.git.wen.yang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <cover.1768751557.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



Sorry, we accidentally wrote 'PATCH 6.1' as' PATCH 6.6 ', please ignore 
this series.
We will resend the correct one, thanks.

--
Best wishes,
Wen


On 1/19/26 00:15, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> 
> Backport three upstream commits to fix a warning on PREEMPT_RT kernels
> where raising SOFTIRQ from smp_call_functio triggers WARN_ON_ONCE()
> in do_softirq_post_smp_call_flush().
> 
> The issue occurs when RPS sends IPIs for backlog NAPI, causing softirqs
> from irq context on PREEMPT_RT. The solution implements backlog
> NAPI threads to avoid IPI-triggered softirqs, which is required for
> PREEMPT_RT kernels.
> 
> commit 8fcb76b934da ("net: napi_schedule_rps() cleanup") and
> commit 56364c910691 ("net: Remove conditional threaded-NAPI wakeup based on task state.")
> are prerequisites.
> 
> The remaining dependencies have not been backported, as they modify
> structure definitions in header files and represent optimizations
> rather than bug fixes, including:
> c59647c0dc67 net: add softnet_data.in_net_rx_action
> a1aaee7f8f79 net: make napi_threaded_poll() aware of sd->defer_list
> 87eff2ec57b6 net: optimize napi_threaded_poll() vs RPS/RFS
> 2b0cfa6e4956 net: add generic percpu page_pool allocator
> ...
> 
> Eric Dumazet (1):
>    net: napi_schedule_rps() cleanup
> 
> Sebastian Andrzej Siewior (2):
>    net: Remove conditional threaded-NAPI wakeup based on task state.
>    net: Allow to use SMP threads for backlog NAPI.
> 
>   net/core/dev.c | 162 +++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 118 insertions(+), 44 deletions(-)
> 

