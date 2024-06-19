Return-Path: <stable+bounces-53808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346090E736
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E94E2824B4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A78063C;
	Wed, 19 Jun 2024 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="XqtK8gPp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LQwdXP83"
X-Original-To: stable@vger.kernel.org
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999D7E0E8
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790238; cv=none; b=m49BdFmrC4slRoZXxRchNYz74JXs9U8Ik0+HbQO9+B0eWsiNqKsGHPf+T0b78JtttwhZSDPjq/DX+rc68FNYXhTGozI9cebKd5IEvPlhLeY3RxVwaz3Ajom4n0tbKS63dTq8fcVRgHo7oJNBmO+vUvl0YHbAfItFrlZsLRBugWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790238; c=relaxed/simple;
	bh=ArXVnnasQ+2Rt91WA1W4dA4BmsgwSMw6g9Ln2VUbnAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJCj0DL3ii0vZ3OUteCLnYmYq3ZEklFIoH7WLGahdNAZoHua9Dq/r+WYsSY3ZZTu6VogTGQwvskxqVycTo6osO0deAHlEJ1eaFe4Oty3ViY7B90xUzApbFLO04iA6WQsfZeu0mtsTbBzFyLm4K+eh8VYiRWrfFVMiiLmRkx8lI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=XqtK8gPp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LQwdXP83; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id B313713804C9;
	Wed, 19 Jun 2024 05:43:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 19 Jun 2024 05:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1718790235; x=1718876635; bh=8nNXYs5XO7
	2zvd5OFgFQ1LBGlAMoYG76Bzpe1kA6wwc=; b=XqtK8gPpM1l63Wg2zju2+mJtxz
	jY7EWtCZrXgtrOooWJzfWlPFxRz8/fbVe3Fc1lbsU7dqAHM7keT1gcq90yqyYn0B
	rNuNyWXe/HGk65XrmOc1AEhZ8piOBDhygHu+inPVGxkTQcqDS4wOZToe15FgoisF
	hS5HDY/GUWmBzCWJ9v+dOmaWTvaoEDtJHzOJP/zYzCqFu5tQtjuhy1aBC6JaEFyG
	MIV10lMDprpiNu6LG8pw/KmADLefoDhkz1xqgN7gJZRPRoRWZ2N7DSLNfazNjNcF
	4cd9CLs7CMLq5XHsSwrHbqAmE/AKuRS5T75Cg37mDOS1+UZ/x/FP0ex5H9ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1718790235; x=1718876635; bh=8nNXYs5XO72zvd5OFgFQ1LBGlAMo
	YG76Bzpe1kA6wwc=; b=LQwdXP83w0otg/o/UjUbf3cHDdixfKj6twJOZnMGJkbZ
	FLOjoo/PsT6okyly9rK9l1FyjkO2Rq6N/kXi84kvsmg4qv4q0RcjLcKWYGxNfz4L
	/b2rfYFiqKqUYqqDEBrEODQ6JllXpbWTPp4H+CS2n+Y3Wts0/h2hWPtAZNt6vNtv
	j/5mL5PJaqopg3FtuBSgg8V6qPbHOiJZOMYKrmaedEwuYBku+Tak/ev5RJjogfKz
	XmlE9tyHILH0hpihdg9Kc6zVLIa2IRyyjOR3hMqrlP1515uyw61nG5XqTaQSIWdh
	Wp8LupoVQtvH73G+R9AhePbE0DkR+/9yOofHNxLVzg==
X-ME-Sender: <xms:W6hyZkVmRrZitszPlsScJuweJSHA46pPIwQXNFEdPoP7lfTxg8ymRg>
    <xme:W6hyZomlbUGkHHKUC8GhL5wQ63OBVYB7cjC3w3LVChC1Bw1Pp_tDU6HAD4k6CB4uv
    8EZODLaDNmq4w>
X-ME-Received: <xmr:W6hyZobpFL6_0JZy6bskWpIlqdErBZkgD2RjIHsEpT27Aea7M781EtRXnjDmLPbpwm_LyD5L5qu6Ll8GA-BFbnfPiytOj8AMXI3CUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeftddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:W6hyZjU-IXnuyiEKU9bDNCCPvLxy_RXPXBg78j8TowKutXHUUzdCEQ>
    <xmx:W6hyZuneKvxAcv7EnJOQkMjTwzPQ0tn2a5E0dRcPH8qVuS6COxyCRQ>
    <xmx:W6hyZofbOPCzbt-wV6QyVqiV6DKxJZIp0KnajOtTdUlBZdc5FJQ3CA>
    <xmx:W6hyZgFUgkKpLGywLiDhy6V67xT0EXMYSQR41AEAoHqY2cbsclZLZA>
    <xmx:W6hyZj-hAHiHlnMDyN_2wuQpXEpFR1A_8VL0G1uiEzAHC1ly2K-Wgz8R>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Jun 2024 05:43:54 -0400 (EDT)
Date: Wed, 19 Jun 2024 11:43:53 +0200
From: Greg KH <greg@kroah.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: stable@vger.kernel.org, Matthias Goergens <matthias.goergens@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4.19.y] hugetlb_encode.h: fix undefined behaviour (34 <<
 26)
Message-ID: <2024061946-gallon-equinox-ff9b@gregkh>
References: <20240618173028.1115998-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618173028.1115998-1-cmllamas@google.com>

On Tue, Jun 18, 2024 at 05:30:28PM +0000, Carlos Llamas wrote:
> From: Matthias Goergens <matthias.goergens@gmail.com>
> 
> commit 710bb68c2e3a24512e2d2bae470960d7488e97b1 upstream.
> 
> Left-shifting past the size of your datatype is undefined behaviour in C.
> The literal 34 gets the type `int`, and that one is not big enough to be
> left shifted by 26 bits.
> 
> An `unsigned` is long enough (on any machine that has at least 32 bits for
> their ints.)
> 
> For uniformity, we mark all the literals as unsigned.  But it's only
> really needed for HUGETLB_FLAG_ENCODE_16GB.
> 
> Thanks to Randy Dunlap for an initial review and suggestion.
> 
> Link: https://lkml.kernel.org/r/20220905031904.150925-1-matthias.goergens@gmail.com
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [cmllamas: fix trivial conflict due to missing page encondigs]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  include/uapi/asm-generic/hugetlb_encode.h  | 24 +++++++++++-----------
>  tools/include/asm-generic/hugetlb_encode.h | 20 +++++++++---------
>  2 files changed, 22 insertions(+), 22 deletions(-)

All now queued up, thanks.

greg k-h

