Return-Path: <stable+bounces-124430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7459BA61103
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 13:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3562588265A
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 12:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC88D1FECD8;
	Fri, 14 Mar 2025 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZnrJKue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4D1F4275;
	Fri, 14 Mar 2025 12:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955052; cv=none; b=b2EZgH/jXpxKMUAWeYBoG9x6b1/wklLlZzfRmSxm33GzzcZxt+0TUyFO1J6I+/1ZiWiSIVgqBf1SKlhoP02h7VnNkn1fkw5iMJDjEs+V0ePryKuiju8EfZXVUHULi2djjcYqOzn5KPBnReVGFVdl0PbtwJXuyHIsDiGNGdmVXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955052; c=relaxed/simple;
	bh=QU/f6QNim1oZ51+YIfXMC0J65MqIURFbBG7KtZ3GEps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejJsg4FASzT6MINPRC4msWLliw3Du/r678JNrviEbZco+NDBbuE/ph47az0CQ1kb0zdJt6aNAgSEZ63z69v/5wuvgcvp1ZCvU7rzU0LtTKxdLCGZfss36ju7yd3l/cdUmgUeWxv7VsELk7IIqvCatHrX3qoSsTi57joT2QYI6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZnrJKue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DE4C4CEE3;
	Fri, 14 Mar 2025 12:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741955051;
	bh=QU/f6QNim1oZ51+YIfXMC0J65MqIURFbBG7KtZ3GEps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZnrJKuee5/qLe/c1WhsnFriWTajqpNll4GgDCi6B71dgU/t7hI6k0k0lApYEeHuR
	 07kQruX2xtgblkvLA+igIeEaJLfOox7YFSP2olMKl3H4rV54m35znA4CcWgBsrzdvB
	 bPMDwTAsMOFg/vZkNz5OXE6f2FCR3b9y4habsOIE=
Date: Fri, 14 Mar 2025 13:24:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: stable@vger.kernel.org, ncardwell@google.com, edumazet@google.com,
	kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	pabeni@redhat.com, horms@kernel.org, guo88.liu@samsung.com,
	yiwang.cai@samsung.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, joonki.min@samsung.com,
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com,
	dujeong.lee@samsung.com, ycheng@google.com, yyd@google.com,
	kuro@kuroa.me, cmllamas@google.com, willdeacon@google.com,
	maennich@google.com, gregkh@google.com
Subject: Re: [PATCH 1/2] tcp: fix races in tcp_abort()
Message-ID: <2025031453-underpay-gigahertz-9ba4@gregkh>
References: <CGME20250314092125epcas2p418cd0caeffc32b05fba4fdd2e4ffb9fa@epcas2p4.samsung.com>
 <20250314092446.852230-1-youngmin.nam@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314092446.852230-1-youngmin.nam@samsung.com>

On Fri, Mar 14, 2025 at 06:24:45PM +0900, Youngmin Nam wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> tcp_abort() has the same issue than the one fixed in the prior patch
> in tcp_write_err().
> 
> commit 5ce4645c23cf5f048eb8e9ce49e514bababdee85 upstream.
> 
> To apply commit bac76cf89816bff06c4ec2f3df97dc34e150a1c4,
> this patch must be applied first.
> 
> In order to get consistent results from tcp_poll(), we must call
> sk_error_report() after tcp_done().
> 
> We can use tcp_done_with_error() to centralize this logic.
> 
> Fixes: c1e64e298b8c ("net: diag: Support destroying TCP sockets.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Neal Cardwell <ncardwell@google.com>
> Link: https://lore.kernel.org/r/20240528125253.1966136-4-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Cc: <stable@vger.kernel.org> # v5.10+

Did not apply to 5.10.y, what did you want this added to?

thanks,

greg k-h

