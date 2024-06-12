Return-Path: <stable+bounces-50274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC99905560
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558DD1F218AE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD29817E47B;
	Wed, 12 Jun 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ctqzzTB1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238517E478
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203236; cv=none; b=QYqhELps90vH6+IO2TQ/52RHKBlOST9+QvDtmOZt5z8EsNcUBgY+l2UdMXfoiQMlmKBcD6kEwfCXUXrd0tqvglpSQriGpGIX3RRVDJijMs7+T5yTZEO+7L4xkuTPW/QVrt2GJOsJOVdgBzRtAfTZnptEcMzC+YrmhsFX8vQEZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203236; c=relaxed/simple;
	bh=tdS+cDL2l5tg2svl/PPKcCKym2uliKY5+ykfdmfrwPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVFDMaXz40y3ay8pid0lQiEnOZ7IChDx8uAuGL+wqYtoeW/S4Vva16EnHoDSHIoPuP494h6VHEdy7eQaUKc1hzw+NBly2B6eXpmcpgEMfoPi2SD3SnB7sntbDg+PRtKqybA4P6xqENrMVEn/2FMtleuChzqaxUYr82qICCJ6N+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ctqzzTB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F974C4AF1A;
	Wed, 12 Jun 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718203236;
	bh=tdS+cDL2l5tg2svl/PPKcCKym2uliKY5+ykfdmfrwPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctqzzTB1hQJKH7O5fQZxcaGcN+EIS1m6rSfaomMjq1T6aIl428bK9ESjR3C65L3RL
	 XPY0d9Xeu4Nv62LLISauP0qnxYdrpcfxR2BrFdtx6+7hpCAS8Kc66hvFcXBBOWn+Y1
	 R+KfES9M1NzCLEYCtraJP5PKMlAL/ywL9JSWY8WA=
Date: Wed, 12 Jun 2024 16:40:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH stable 4.19] xsk: validate user input for
 XDP_{UMEM|COMPLETION}_FILL_RING
Message-ID: <2024061258-research-tractor-159b@gregkh>
References: <20240606034835.19936-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606034835.19936-1-shung-hsi.yu@suse.com>

On Thu, Jun 06, 2024 at 11:48:33AM +0800, Shung-Hsi Yu wrote:
> Two additional changes not present in the original patch:
> 1. Check optlen in the XDP_UMEM_REG case as well. It was added in commit
>    c05cd36458147 ("xsk: add support to allow unaligned chunk placement")
>    but seems like too big of a change for stable
> 2. copy_from_sockptr() in the context was replace copy_from_usr()
>    because commit a7b75c5a8c414 ("net: pass a sockptr_t into
>    ->setsockopt") was not present
> 
> [ Upstream commit 237f3cf13b20db183d3706d997eedc3c49eacd44 ]

What about 5.4.y?  We can't take a patch in an older stable tree and
have a regression when someone moves to a new one, right?

I'll drop this for now and wait for a backport for both trees before
applying it.

thanks,

greg k-h

