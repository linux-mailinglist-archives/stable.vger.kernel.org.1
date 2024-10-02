Return-Path: <stable+bounces-80575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C5498DFB6
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 17:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787472862EC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858621D0E2B;
	Wed,  2 Oct 2024 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SMdD3r6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B81D0DC4
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883959; cv=none; b=k9Qpt2ocZsNw4Iddt2at1N7mY4gvkPaHH0oIxveaej0BcQFqLej80cADQThuH9nTaUAQX0SpQsjwLAZu8oyGu2gEzG+ejt5XGzul+xhHIwB5iC/IM3klTpeiXdxSHZ91CZ36qUGDcn0IfNDQPhl9gRidL9Km3GBTYggizjDtJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883959; c=relaxed/simple;
	bh=R5czBERfHNaBc8RPo+yVHjjXNzxGAMq+XPDsoTF+++s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGuI1Rj3oFFMuP/vTLDhw7VtVjbpycaJmbA1022m9YjKlmpFSD0yFBYbBKIYeVB0ZuVXev4s8F0yS30+ohENGUQNh8X4bonlIjDx4Ex0rSiOR9/fr0Zxq2NO04V1Znlybj01FUxgGRY5Ngl6U7DRj1VKxGFshvZBG0q+9SYvWQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SMdD3r6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740A2C4CEC2;
	Wed,  2 Oct 2024 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727883958;
	bh=R5czBERfHNaBc8RPo+yVHjjXNzxGAMq+XPDsoTF+++s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SMdD3r6BrzWSXt5D2WBHY90BPGChBXp0vacP11Jw8cJh2m5+xDGTk6ZtjffMFjD4V
	 LRD+E44MJjUxmG9cgpw97lDHZrDBTOYtdEMqMLRNJ+B6jDycmLDrSHcnJznrYV8aux
	 Tzkx0HMxTtfxETXEtWbwPlHT9wcH/MAvvR+C+sBE=
Date: Wed, 2 Oct 2024 17:45:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: Missing 6.11-stable patch
Message-ID: <2024100208-tubby-reappoint-bf25@gregkh>
References: <4cdd1f7f-a753-40af-bde5-11bb584a052b@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cdd1f7f-a753-40af-bde5-11bb584a052b@kernel.dk>

On Wed, Oct 02, 2024 at 09:35:42AM -0600, Jens Axboe wrote:
> Hi,
> 
> Arguably the most important block stable patch I don't see in the
> most recent review series sent out, which is odd because it's
> certainly marked with fixes and a stable tag. It's this one:
> 
> commit e3accac1a976e65491a9b9fba82ce8ddbd3d2389
> Author: Damien Le Moal <dlemoal@kernel.org>
> Date:   Tue Sep 17 22:32:31 2024 +0900
> 
>     block: Fix elv_iosched_local_module handling of "none" scheduler
> 
> and it really must go into -stable asap as it's fixing a real issue
> that I've had multiple users email me about. Can we get this added
> to the current 6.11-stable series so we don't miss another release?
> 
> It's also quite possible that I'm blind and it is indeed in the queue
> or already there, but for the life of me I can't see it.

Nope, not there yet, I have over 150 pending patches that I didn't get
to for this round of releases.  I thought I gave a quick glance to see
if I missed anything "major" as usually anything coming in for -rc1
really isn't that important, but I missed this one.

I'll go queue it up now, thanks.

greg k-h

