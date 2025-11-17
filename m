Return-Path: <stable+bounces-195010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE66C65DCE
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 20:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E830A4E6956
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3E32AAC3;
	Mon, 17 Nov 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIazuP7Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9C2550A4
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405982; cv=none; b=cSRkpybZ4m2P4INo8XHOAmgKZh9zdYKhY0+0ok4nSGQ3jfMJjQzYjMhr3vqrTDLMo7BMdTlFJOMWoAdD2X/+lUppOlYW8SRmuuigytq55N2veozINsUhdXej9j2EVCrMelZkuBIqQNMbz4fcb4lHVl2HB9LBfbQm6AvWpN9Q0S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405982; c=relaxed/simple;
	bh=ovGHTyh6FEdilTLhYvIvmWX52Bd8hxRE8L/+VkjnO5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU71Ou0nu9nRwkdNS9IWT63xVwQEjwL/yY6hm8VR7mksdITTvZXViqtsuibblap4Ioh+uvFJ1E4e1onIy1GoC+S+eCVoja+hV9uOGJYoesvNaRoPZNuD3x/LEAxru9FPQdjQTyXLN04cSXVtv/BxSU+F4qLVIk5sMlOUMY2HTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIazuP7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F6BC2BCB7;
	Mon, 17 Nov 2025 18:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763405980;
	bh=ovGHTyh6FEdilTLhYvIvmWX52Bd8hxRE8L/+VkjnO5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIazuP7ZsZRYAztL4gmDFxwm0cR/iH0dd5BnElpFkRmK1o+T6zO0q65vo3e/MrRKz
	 SYD54sZwHPsXdn8qy3ZTxh9R0EfxA87utFdxkA3hkbcLBHQye/3ABdbdpp/M97ItTW
	 kdKilB1oLTkUdUde16CD8N+yY6mHE8kqeEQNOUIhvTit2v+bsrLqWHhcSYQRsHsYjj
	 uZplI5TYylpFEXCVoH82cGgcgcYaShbYH/wVCb7PNyKoaVYVKWdFiZ2ae1zCEn98lg
	 T2WFkjtK7aIZpSMEIdbkSj3jNu5geqFvpqPdis/QA6x/gB20WQin1bQdwTyhKkKydN
	 tzpFAJL3cV0VA==
Date: Mon, 17 Nov 2025 13:59:38 -0500
From: Sasha Levin <sashal@kernel.org>
To: Max Krummenacher <max.oss.09@gmail.com>
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
	Ian Rogers <irogers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: 6.1.159-rc1 regression on building perf
Message-ID: <aRtwmoEYSF7XA8eF@laps>
References: <CAEHkU3Vr4RVG1Up1_cnoV70QRaYrRXW8ONCMOBB88F+Cu7WRuw@mail.gmail.com>
 <aRtM1qdOprtHrw4n@laps>
 <CAEHkU3VOr0NYzmxhRM0eJtcVYdhy8F+zxmqebg5UVV4KYGpzeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEHkU3VOr0NYzmxhRM0eJtcVYdhy8F+zxmqebg5UVV4KYGpzeg@mail.gmail.com>

On Mon, Nov 17, 2025 at 06:00:55PM +0100, Max Krummenacher wrote:
>Hi Sasha
>
>On Mon, Nov 17, 2025 at 5:27 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> On Mon, Nov 17, 2025 at 05:00:39PM +0100, Max Krummenacher wrote:
>> >Hi
>> >
>> >Our CI found a regression when cross-compiling perf from the 6.1.159-rc1
>> >sources in a yocto setup for a arm64 based machine.
>> >
>> >In file included from .../tools/include/linux/bitmap.h:6,
>> >                 from util/pmu.h:5,
>> >                 from builtin-list.c:14:
>> >.../tools/include/asm-generic/bitsperlong.h:14:2: error: #error
>> >Inconsistent word size. Check asm/bitsperlong.h
>> >   14 | #error Inconsistent word size. Check asm/bitsperlong.h
>> >      |  ^~~~~
>> >
>> >
>> >I could reproduce this as follows in a simpler setup:
>> >
>> >git clone -b linux-6.1.y
>> >https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> >cd linux-stable-rc/
>> >export ARCH=arm64
>> >export CROSS_COMPILE=aarch64-none-linux-gnu-
>> >make defconfig
>> >make -j$(nproc)
>> >cd tools/perf
>> >make
>> >
>> >Reverting commit 4d99bf5f8f74 ("tools bitmap: Add missing
>> >asm-generic/bitsperlong.h include") fixed the build in my setup however
>> >I think that the issue the commit addresses would then reappear, so I
>> >don't know what would be a good way forward.
>>
>> Thanks for the report! I could reproduce this issue localy.
>>
>> Could you please try cherry-picking commit 8386f58f8deda on top and seeing if
>> it solves the issue and your CI passes?
>
>Cherry-picking commit 8386f58f8deda makes both my local build in the linux
>source tree and the CI setup work as expected.
>
>Thanks for the pointer and fix.

Great, I'll queue it up.

Thanks for reporting and testing!

-- 
Thanks,
Sasha

