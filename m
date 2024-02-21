Return-Path: <stable+bounces-23183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D7885E020
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5559F1F23D21
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E007FBBC;
	Wed, 21 Feb 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh+r5COi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EAA35;
	Wed, 21 Feb 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526599; cv=none; b=EvHjHYumj/hBpNJGN45smsg5gM+pNAWNh81TRCzaKaBKoxYcQRco9TGykoZTPPRQ0dB1X5VOebCn5YjhHVLizKvfysr2Um1Fjz749ROkJTdq8tOGBVIyeAJXvw5LHCM/GklxxpjpGDiYmcqVKzr6ZNEncXyJk8yjN9wtkNLKwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526599; c=relaxed/simple;
	bh=g208PeeCjQUWdSouRHCJy7e/n13eV/bEbILTkdMsC/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rknCaXbKmmO7KPcKsRwbahqZ9SAK70V8DCFqzsgqPdR4qLArVY5NODJDbAhapaQfdT2VDn5IwWU/GIqaM3mkPQI1SRWFBvKHA31PxtW2/T1u2MCHcKWgxrgXu6DWfEN5tS37bzDiwFlicL2lT6WUOiRYnzVInB2iX4yjHkjDR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh+r5COi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C1CC433C7;
	Wed, 21 Feb 2024 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708526599;
	bh=g208PeeCjQUWdSouRHCJy7e/n13eV/bEbILTkdMsC/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rh+r5COiXiaZ9Iekc6LC3gHFLFBKC1QJ3rAQqRz6ONSqWQA9MOLhwj/y5s3Q9wiaN
	 7f3B/2r2Mj4y23i/Mx5gHNK1EqORnkFR1qYRl3oXr9ssXFDlxR5BJsmuE2bVD+eXDr
	 ZiokHNwKTPOxP/4Wd64aCvZkOaWxu1FszTI5jEEPJAsBMbglO1D0HObG47VdcmPUr/
	 RAoaq54aWhHeqInoPutDmld/VNpRUORUs19PvxqQrhtkwoutI869XarNwZZha6rZUW
	 ZOvzla4wlgb0Sce10X6uetYMnGCZs3EHXzrr7cflnmgi93/fq9l0dUnEmH2ndHyxrW
	 KVr1bLKYNgUaw==
Date: Wed, 21 Feb 2024 14:43:16 +0000
From: Simon Horman <horms@kernel.org>
To: Tom Parkin <tparkin@katalix.com>
Cc: netdev@vger.kernel.org, David Howells <dhowells@redhat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] l2tp: pass correct message length to ip6_append_data
Message-ID: <20240221144316.GA722610@kernel.org>
References: <20240220122156.43131-1-tparkin@katalix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220122156.43131-1-tparkin@katalix.com>

On Tue, Feb 20, 2024 at 12:21:56PM +0000, Tom Parkin wrote:
> l2tp_ip6_sendmsg needs to avoid accounting for the transport header
> twice when splicing more data into an already partially-occupied skbuff.
> 
> To manage this, we check whether the skbuff contains data using
> skb_queue_empty when deciding how much data to append using
> ip6_append_data.
> 
> However, the code which performed the calculation was incorrect:
> 
>      ulen = len + skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0;
> 
> ...due to C operator precedence, this ends up setting ulen to
> transhdrlen for messages with a non-zero length, which results in
> corrupted packets on the wire.
> 
> Add parentheses to correct the calculation in line with the original
> intent.
> 
> Fixes: 9d4c75800f61 ("ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()")
> Cc: David Howells <dhowells@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Tom Parkin <tparkin@katalix.com>

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> This issue was uncovered by Debian build-testing for the
> golang-github-katalix-go-l2tp package[1].
> 
> It seems 9d4c75800f61 has been backported to the linux-6.1.y stable
> kernel (and possibly others), so I think this fix will also need
> backporting.
> 
> The bug is currently seen on at least Debian Bookworm, Ubuntu Jammy, and 
> Debian testing/unstable.

In that case perhaps this is appropriate - citing the patch that 9d4c75800f61
tried to fix?

	Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support for IPv6")


> 
> Unfortunately tests using "ip l2tp" and which focus on dataplane
> transport will not uncover this bug: it's necessary to send a packet
> using an L2TPIP6 socket opened by userspace, and to verify the packet on
> the wire.  The l2tp-ktest[2] test suite has been extended to cover this.
> 
> [1]. https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1063746
> [2]. https://github.com/katalix/l2tp-ktest

...

