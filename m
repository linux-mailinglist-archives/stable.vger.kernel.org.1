Return-Path: <stable+bounces-59175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20A92F35E
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 03:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12ECB2827D5
	for <lists+stable@lfdr.de>; Fri, 12 Jul 2024 01:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F01A1FBA;
	Fri, 12 Jul 2024 01:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZoEkDXda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A02E7464;
	Fri, 12 Jul 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747162; cv=none; b=hClprfV+zqLtsXQ2yw5PUWkdrYTC0H1dD+6eikC+uOyOKGhVHKdBs+eRjr9awfYpHe4Zn/W1yfLpvAi3/V4AcRCl52ahfE1ET4vtahXOpNEPbdvIlunyomlfgoXYmWPduMae2Yjz0l53q/6Je7c9WfgxwsTfoACz7Xsgt5BhQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747162; c=relaxed/simple;
	bh=xCtxqJghhw5YD87EUrCkZRHwwZcBzY+3OJ4srPuHFko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e3l4CMoVpz2qERO3CgCWOxQTQMztt7YJsWa9ftXdU8rmaurmpeubj5UZGoEu6u46dicgAHOYqXnV9cC2xAXtyk2Kau15kDDvLUS2lvRQyi2746bPomddRPMarw0k/J90ERh4uCuZ8s3KulNZfjrHKnjo7k93FZXajbRF80BzcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZoEkDXda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E78C116B1;
	Fri, 12 Jul 2024 01:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720747161;
	bh=xCtxqJghhw5YD87EUrCkZRHwwZcBzY+3OJ4srPuHFko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZoEkDXdaD21NrJf4gmOGRINokYKiCjpIeqS0sC61St0Qoti7gcZftC7Lau/kwWLIU
	 8ahKkgMo+bltBuknD0DV6722cE0H4t+lyI8Q756Zuucar6lZ9AvyNdGIET3S4Uu8XG
	 Lf7FLf/5gF625C7cvSCG8cRJGOCZNwRrKP0xH+TzQuCRpK3NMudE97RsCO/aCvbcwr
	 bxfy9Qc5fUzL+cPAsGgugUalXWXAhoOnkqo0/oI6W/ks9JZg7LlZRxMVZXH8kjlPXF
	 dpUsuVJzzn1Ve9z1/UfAX8ElMQB0r4v/kfu5XeKgK2j0tCmjO/P/WMTaDHCdRwXXhZ
	 sql2EcZQZ6S5A==
Date: Thu, 11 Jul 2024 18:19:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: ks8851: Fix potential TX stall after interface
 reopen
Message-ID: <20240711181920.75d86fca@kernel.org>
In-Reply-To: <20240709195845.9089-1-rwahl@gmx.de>
References: <20240709195845.9089-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jul 2024 21:58:45 +0200 Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> The amount of TX space in the hardware buffer is tracked in the tx_space
> variable. The initial value is currently only set during driver probing.
> 
> After closing the interface and reopening it the tx_space variable has
> the last value it had before close. If it is smaller than the size of
> the first send packet after reopeing the interface the queue will be
> stopped. The queue is woken up after receiving a TX interrupt but this
> will never happen since we did not send anything.
> 
> This commit moves the initialization of the tx_space variable to the
> ks8851_net_open function right before starting the TX queue. Also query
> the value from the hardware instead of using a hard coded value.
> 
> Only the SPI chip variant is affected by this issue because only this
> driver variant actually depends on the tx_space variable in the xmit
> function.

The patchwork bot is taking long siestas in Konstantin's absence, 
FWIW this patch was applied by Paolo on Tue. Thank you!
-- 
pw-bot: accept

