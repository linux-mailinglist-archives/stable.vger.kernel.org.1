Return-Path: <stable+bounces-206346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73333D02FF0
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 14:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E444B3009224
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B55461C39;
	Thu,  8 Jan 2026 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="kg228EDs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NHnivJmx"
X-Original-To: stable@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021D4AACD6
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767877933; cv=none; b=ZEDzmWNGYiyOK0qUKfB2XVyRU8TOfHyb5kMvlEX6N1WAG4u4T9kQVOVI2k1ovUXPZl9uUB061nLKRDCKYDDnJjRH9BG7t/JAUIxZPUVKuyPu8zrfJTpJaXP+xSs5ROHejaxiDCoC0SXgVyB9eGZYQzCU8SZJQOM5BYQFwTc34Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767877933; c=relaxed/simple;
	bh=5BqUftiAInC6z8yK4F8kYOne6hBI9rAc20f0Jqo4TXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilvA5eRXiwSogPqXFu+2yRhPdqlhuCF8rYrcNYWmW2F7XcxTZVzCMNryrYqBG1sfGhWAkYzSY1G5ipOXA3sa8tSHT02xEBKVsy27pgiPIwfONQJAu2jxQqPRF9uD1PuDzNOPeRmeHEGeKOETfmuVUXnDY186sQxAKU03nUKK7ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=kg228EDs; dkim=fail (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NHnivJmx reason="key not found in DNS"; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 72C961D0007E;
	Thu,  8 Jan 2026 08:12:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 08:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767877930; x=1767964330; bh=053wYUswXJ
	WdwaRJ430RX3TD5tb2+oTK16L1R8ckTBU=; b=kg228EDs2iVjDOl5AwimkdZttD
	NIyOJAHx0uBxOAas3nQHXQ/PPMG7IQCnpMkrFTi5+LlWnwR58/5T40pjjKmtTS65
	5PtLkyBTYJSA7MJNXWbw5wpTXBb9PC3ulAkbUvanJwFMkOB9V+y5jGMYVINPRjPv
	uMtCgXUgwr2yvf80ZD/AXSogfc6ZOWVlqOP0vb3Smo/FJHZJPppn442V2g/VGDT5
	SyYZMhJ4mB7p9kO/T4KGx6xti53/pl15JZefJ9f95UnnLVTVjQ9Ij0QsrxRwdT4D
	JDBlhwBc+0YhEoEKF7QcN0Xtr/XicX5XLLfcAphWRXc7p5k8SXWrRIp1YdiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767877930; x=1767964330; bh=053wYUswXJWdwaRJ430RX3TD5tb2+oTK16L
	1R8ckTBU=; b=NHnivJmxpbSiRHNDtn3+ZnKcuifAtfVIQu0umaWyUBgAUOVqv9o
	kAi3uyle3UZ/C/cLK1h1OKpUCxD2yt71+VSR1DK9FQ0f196FjsCxftDJ3gszctNf
	UbowZcVJJ5AUzsmSMW7TK9q2a01IgQWzL7CmI2lHHtq35HFrHSEx9wjd1Rmc1HaG
	jJiB4qc4ILnHih88JrSFNEGrme1p8WZBAyO5/BPd1+vz20P4+t8+R6Z8wSmtIBlI
	tLpe3ObF9CMpLS2BT9dGb/yIc3M87fE0x7Yzp8XhsKMERqZGMNH56UHc1GqOlSqO
	TTBzziOdckqnRGdA/bqWPY6ZuOe74qxGp1g==
X-ME-Sender: <xms:Ka1faW_OSFZtlUTc8hzoCtOBRDTPTTiQ8VEh-YZp3vgNm84CXtlDDA>
    <xme:Ka1faZR_f-mYduygoP_lvKSfGt95gLcyjllKTGqOylJepfzRwSLKUqJgwvqsjSv0S
    sj5EVgd8qb8sHNTq-FgvsS4EL6SXvHQDIY8o-wgndOF64bL>
X-ME-Received: <xmr:Ka1fafoednMKrN4eStaPSZ88MNWz1uL3JzA3o1uFsrpE6ZxncpsLUqa-UqbpTMBMARkwsoD1Q43pG8Zxhvx0BPQ92YfrOItb9JEJUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhdrsghfrhiisehmrghntghhmhgrlhdrihhnqdhulhhmrd
    guvgdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtfigvvghksehtfigvvghkrdgukhdprhgtphhtthhopehmrghsrghhihhroh
    ihsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Ka1faemBJLF3vwJOu97sCUUfUUJFJ_8Tv09so3WyHctQvi2R4s_kCA>
    <xmx:Ka1faQfWjos_bNvIomJGWXD6AzcA1HC4QC7BZHA8D2ObpQfa3zlemw>
    <xmx:Ka1faSohMTKSxKo5hV65SQqdN2gB3rbisKUo8nx2K1g-Ocm3PQZVJw>
    <xmx:Ka1faSPXdUqTIdIJeizEGlm_PFvXnZK1iCcZs5vQ816ExWaJogyX8A>
    <xmx:Kq1faXOF4jyUckvWBEbPjcPrHcDX39zNMV1e91Go3GM5vrs5fL1GWrk->
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 08:12:09 -0500 (EST)
Date: Thu, 8 Jan 2026 14:12:06 +0100
From: Greg KH <greg@kroah.com>
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc: stable@vger.kernel.org, Martin Nybo Andersen <tweek@tweek.dk>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: 6.1 Backport request: fbf5892df21a ("kbuild: Use CRC32 and a
 1MiB dictionary for XZ compressed modules")
Message-ID: <2026010853-possible-guzzler-62d5@gregkh>
References: <1766658651@msgid.manchmal.in-ulm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766658651@msgid.manchmal.in-ulm.de>

On Thu, Dec 25, 2025 at 11:48:03AM +0100, Christoph Biedl wrote:
> Hello,
> 
> please backport
> 
> commit fbf5892df21a8ccfcb2fda0fd65bc3169c89ed28
> Author: Martin Nybo Andersen <tweek@tweek.dk>
> Date:   Fri Sep 15 12:15:39 2023 +0200
> 
>     kbuild: Use CRC32 and a 1MiB dictionary for XZ compressed modules
> 
>     Kmod is now (since kmod commit 09c9f8c5df04 ("libkmod: Use kernel
>     decompression when available")) using the kernel decompressor, when
>     loading compressed modules.
> 
>     However, the kernel XZ decompressor is XZ Embedded, which doesn't
>     handle CRC64 and dictionaries larger than 1MiB.
> 
>     Use CRC32 and 1MiB dictionary when XZ compressing and installing
>     kernel modules.
> 
> to the 6.1 stable kernel, and possibly older ones as well.
> 
> The commit message actually has it all, so just my story: There's a
> hardware that has or had issues with never kernels (no time to check),
> my kernel for this board is usually static. But after building a kernel
> with xz-compressed modules, they wouldn't load but trigger
> "decompression failed with status 6". Investigation led to a CRC64 check
> for these files, and eventually to the above commit.
> 
> The commit applies (with an offset), the resulting modules work as
> expected.
> 
> Kernel 6.6 and newer already have that commit. Older kernels could
> possibly benefit from this as well, I haven't checked.

Now queued up, thanks.

greg k-h

