Return-Path: <stable+bounces-139650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4253AA8F70
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 11:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53283A45B8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47271F470E;
	Mon,  5 May 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rUsnr1I0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9117B425
	for <stable@vger.kernel.org>; Mon,  5 May 2025 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437095; cv=none; b=NBhcYbBT3cIv2w8xR0oTiqYsJmWoNPyh2qCKKPDwqsAMgZzs/Ws2NqX+nk/o5llHKbX3mlUhk/IKnDCuV7tcWY6fEEL7RDMOnxMbql6JEBIW3Gqp2RwVT2tAp8+wVAXSeMQ2jmHJN/ifBB2VGpgRCbYiQ7d1/6Ver33RxXUXQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437095; c=relaxed/simple;
	bh=6Opez/iZHCucZM99gAUlt6srU13quzUWuqQbGHohVB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1UalZLv4LL34jUZ9OVIX3wdoVuGqSSwiOR6WrgIfgBpJCby7jEzwTQUbGhshet2F8JXJLDvUunufcHo4uUtb0C2P2c2Vr3+dFUzD7qN2FRbEtmXRLaLzKgFTJYlDbFXx3/8AjUeOyiz/k2duCg3sD+9QIS3YuvyKqTPGinADRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rUsnr1I0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DD7C4CEE4;
	Mon,  5 May 2025 09:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746437094;
	bh=6Opez/iZHCucZM99gAUlt6srU13quzUWuqQbGHohVB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rUsnr1I0Y1LpicAk5bJJVgVjhmGWKyW+mpsbg8U050cQrR9ZCUEG+KaBzCkDg+4Zz
	 3X67E95iWWUOiU1cljVEdYFdEhg9yNVrNj/fqLnDqXZSkKa5WxwpBhp9cdh2PZfRdU
	 ZqmyJwAeGWTl2z+Am5Qy6D7rA3wr3Cj3u2RjHk54=
Date: Mon, 5 May 2025 11:24:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: stable@vger.kernel.org
Subject: Re: [6.12.y] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90
 blk_mq_map_hw_queues+0xcf/0xe0
Message-ID: <2025050500-unchain-tricking-a90e@gregkh>
References: <20250503091422.0389.409509F4@e16-tech.com>
 <20250503100528.C7F9.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250503100528.C7F9.409509F4@e16-tech.com>

On Sat, May 03, 2025 at 10:05:29AM +0800, Wang Yugui wrote:
> Hi,
> Cc: Greg Kroah-Hartman
> 
> > Hi,
> > 
> > I noticed a WARNING in recent 6.12.y kernel.
> > 
> > This WARNING happen on 6.12.26/6.12.25, but not happen on 6.12.20.
> > 
> > More bisect job need to be done, but reporti it firstly.
> > 
> > [   13.288365] ------------[ cut here ]------------
> > [   13.288366] WARNING: CPU: 0 PID: 681 at block/blk-mq-cpumap.c:90 blk_mq_map_hw_queues+0xcf/0xe0
> > void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
> >               struct device *dev, unsigned int offset)
> > {
> > ...
> > ...
> > fallback:
> > L90：    WARN_ON_ONCE(qmap->nr_queues > 1);
> >     blk_mq_clear_mq_map(qmap);
> > }
> > 
> 
> The following patch fixed this WARNING.
> 
> From a9ae6fe1c319c4776c2b11e85e15109cd3f04076 Mon Sep 17 00:00:00 2001
> From: Daniel Wagner <wagi@kernel.org>
> Date: Thu, 23 Jan 2025 14:08:29 +0100
> Subject: [PATCH] blk-mq: create correct map for fallback case
> 
> please pull it to 6.12.y.

But the commit that this one says it fixes is NOT in the 6.12.y tree.
So why would this commit fix the issue?

And why haven't you cc:ed the authors involved in these changes?

confused,

greg k-h

