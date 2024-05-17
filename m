Return-Path: <stable+bounces-45403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB328C8CA8
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 21:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6B42813D1
	for <lists+stable@lfdr.de>; Fri, 17 May 2024 19:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E2813FD88;
	Fri, 17 May 2024 19:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhcfD82G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B4F13E88B;
	Fri, 17 May 2024 19:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715973288; cv=none; b=AodruRP32Z2Q+ErsuDJz0HnamVcKkoqCo5ef0W+yCQ4gnMKLNRbvKnoaPyG/pYs4L5wiF94aGsGZF40D02f0e3/sPnMmksw5/3uAOm1+TZx1xvQvLi4SV8bqa6io2AkzfSJA89KdyYuXXPmdhiq9gB5VnQ+6h+A3YMl7d+pyWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715973288; c=relaxed/simple;
	bh=hLpMPC+/AppxDcAV2ufGcWfezjmaBBhECN+D8I44Deo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDuBAok0cOA8KSVlWggMV2o/5B7RwXuuU3bOnhS4HlS0zGanFTJYqTg4a8XZVsnbt4dg+0LvhzmjG39bI7mUJQcWsiYyd25m96ebSBZ4OYzBb0jol7bAAMsWo6sty9TiKiMRmu1k5qFgMlRtS1GgDkDq/mtDTokkAKNPfLv9ztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhcfD82G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521FCC32781;
	Fri, 17 May 2024 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715973288;
	bh=hLpMPC+/AppxDcAV2ufGcWfezjmaBBhECN+D8I44Deo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HhcfD82Gk3Wtxgx+VlyJV/rSrpV/exhOuCj90yeoOf8VzcONakHmH45Dpx/qxv9xJ
	 M3qHNRnFxpmTmNcEkUewuU3CPo///EOr0JN9euO3kiDirr4EZph9pU2tbke45zFvW3
	 KFcOs4X+Xy+zWVyJLNmZcc7y1dT7Ph5iL8h5PoMatpzF0Jte+NEyIqt4RU65xhfkXF
	 ob7iMioJ8gct4aSfpLtT96VyKPJpXUReDhvqKj0RV46xBi5G5899nUDaP/TIw2g3XC
	 GOM6me//sqTVBgIYOjAQhEZhjW6S0B9e5g1mov2w0PwDcEppyoX3Fse5/YyIyANa7b
	 CEE43RPUsjveQ==
Date: Fri, 17 May 2024 12:14:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: ks8851: Fix another TX stall caused by wrong ISR
 flag handling
Message-ID: <20240517121447.4fb122d8@kernel.org>
In-Reply-To: <20240513143922.1330122-1-rwahl@gmx.de>
References: <20240513143922.1330122-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 16:39:22 +0200 Ronald Wahl wrote:
> Under some circumstances it may happen that the ks8851 Ethernet driver
> stops sending data.
> 
> Currently the interrupt handler resets the interrupt status flags in the
> hardware after handling TX. With this approach we may lose interrupts in
> the time window between handling the TX interrupt and resetting the TX
> interrupt status bit.

Thanks! This is commit 317a215d4932 ("net: ks8851: Fix another TX stall
caused by wrong ISR flag handling") in net. Looks like bot didn't respond.

