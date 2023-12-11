Return-Path: <stable+bounces-5238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1BB80C056
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 05:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F83B208A6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 04:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D5C18058;
	Mon, 11 Dec 2023 04:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeBgNvZ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3B168B5;
	Mon, 11 Dec 2023 04:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95783C433C8;
	Mon, 11 Dec 2023 04:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702268191;
	bh=ReCrERUD50uu8LVUvETQ+sPC28c7ctlOLp5FcoBUuYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HeBgNvZ9f9Ii3onGIhafCKESMWC1w5Md9DtZBH9hQuUjADqCWn6hwIJBczqS/m2sV
	 O6561BhQtmHwTuKp9B64o01YHzowYZxOGAmqq3fRBimOpYeaAH8uJ7517/zs9TCdzJ
	 EKH2GsJp7QcZZzcZEc/oTGtILQ/2oO1dZjpHUI3Bi6chJTEqIwXIMVZCQemyJWV4qO
	 PcpX4IFx0GAXyC37Oz2CDkP45BH0ytNQMM9jtTguwbDT8Tcvmi2WwuPEnoY8tkOPGg
	 hzM6vMvVM1sjr0fHHjX9+se7D7VG7WlvT36dQhaN9o9SrfI23bWrSbLXwF+qqeCUJq
	 INtHdlOmRqJHQ==
Date: Sun, 10 Dec 2023 23:16:30 -0500
From: Sasha Levin <sashal@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable-commits@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
	Hu Haowen <src.res.211@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Patch "Kbuild: move to -std=gnu11" has been added to the
 5.15-stable tree
Message-ID: <ZXaNHiqpN2lfEHQO@sashalap>
References: <20231209024607.11701-1-sashal@kernel.org>
 <da3b2875-3f1d-4a96-a4ab-7aab3a695701@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <da3b2875-3f1d-4a96-a4ab-7aab3a695701@app.fastmail.com>

On Sat, Dec 09, 2023 at 11:47:49AM +0100, Arnd Bergmann wrote:
>On Sat, Dec 9, 2023, at 03:46, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     Kbuild: move to -std=gnu11
>>
>> to the 5.15-stable tree which can be found at:
>>
>> http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      kbuild-move-to-std-gnu11.patch
>> and it can be found in the queue-5.15 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>I think the patch initially caused a few regressions, so
>I'm not sure if backporting this is the best idea. Is this
>needed for some other backport?

Hey Arnd,

I spent some time over the weeked trying to figure it out. Initially it
looked like there's something wrong with my local toolchain, but what I
found out is the following:

There is now kernel code relying on code constructs that are illegal
without c99/gnu11/etc. The example in this case is WMI code which even
in upstream [1] does:

	list_for_each_entry(wblock, &wmi_block_list, list) {
	/* skip warning and register if we know the driver will use struct wmi_driver */
	for (int i = 0; allow_duplicates[i] != NULL; i++) {
	    ^^^^^^^^^^^
		if (guid_parse_and_compare(allow_duplicates[i], guid))
			return false;

The decleration of a variable there doesn't work unless you're using a
newer standard, which is why the dependency bot ended up pulling this
commit in.

At this point, not taking this change means that we can't take some
commits without doing custom changes to backport them, which in turn
means that we'll keep diverging from upstream.

Agreeing with you that this isn't a trivial change, but it seems that we
need to take it to make even not-that-old trees (<=5.15) accept some
fixes.

With the commit in question applied I see no new errors or warnings, so
I'll keep it in 5.15, and we can see how it survives the -rc tests.

I haven't seen any fixes pointing to that commit besides a documentation
fix, so if I've missed anything please let me know.

[1]: https://elixir.bootlin.com/linux/v6.7-rc5/source/drivers/platform/x86/wmi.c#L1289

-- 
Thanks,
Sasha

