Return-Path: <stable+bounces-73937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78B970A70
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 00:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9EB1C211B1
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C4413A242;
	Sun,  8 Sep 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgLNOFQM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D0EACD;
	Sun,  8 Sep 2024 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725834068; cv=none; b=f0P3RgpyK2gXn3Q6KKNJtDJ5OpQm9IVxiolGhMB/yKtR+AdO01KnS0T19t/jTahLDo2FQYgzLFaTvOsPfuEv0D8DhWZmm1/1WqZuyujbR+qKDt6jE1o7zfAMiiJRWlpYVig++PgPVu9tuT3wFmzM7gnqvRfJbyl0+Y6VaQHBPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725834068; c=relaxed/simple;
	bh=Fholx4yweIgYFoVnAh+LMNBR4MTnOQQ8qMq9nrw36yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ/wu7OhFwN+6OWCsBaRvHYMvhKsZVbYqRYqQugvFGYf5cXvbVBe8cnHcgOXf+FgvzSpJRkKinIsgqYSZ3e41RpUZh1K/ZntDlHvkmht8FIbjZiLhABFm+b3JXWlBkzzBCLNEYD1lJyoWNvyizgwmZQSfHnDHZ6/HoR7TvqxnCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgLNOFQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B99C4CEC3;
	Sun,  8 Sep 2024 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725834068;
	bh=Fholx4yweIgYFoVnAh+LMNBR4MTnOQQ8qMq9nrw36yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgLNOFQMfcYXb60py5vffkAAG6JKrvh6ywHW0b7hQNCAep96hDAx2FnmSmcVvhQ/d
	 OOrcymHhKsyf0oPGWm9+/PjRcP8cDeTzGOpAaWp8aIHnqx4OVexxsbb8HSIC1hoYSw
	 rFiY+trXvmzBN0XTurWpuk41dr0iJEyX6HJAsYLlSZRImxpVEeLxqWjndmK+8fmFOg
	 lfeaDOY8wGLplus/5VHecL2/3eeCFmO4zfDNfbNaZ37p35AoqoHffMyrP8iQF3gjiZ
	 YONYgvBklYvgUhtBjkCDc2GLQfw9wqdzUiHM7Phi6ZkxoijMIBzN5gnXMUi8RoCFxu
	 D8NmZ10+UY5gQ==
Date: Sun, 8 Sep 2024 18:21:06 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	tahbertschinger@gmail.com
Subject: Re: Patch "bcachefs: Add error code to defer option parsing" has
 been added to the 6.10-stable tree
Message-ID: <Zt4jUpxxTzIdWYlp@sashalap>
References: <20240908132559.1643581-1-sashal@kernel.org>
 <nhhb74exmbeut37exka6s3sfajnn544x2lnz6xzbspntdchgmq@hxfe3b76e4p6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nhhb74exmbeut37exka6s3sfajnn544x2lnz6xzbspntdchgmq@hxfe3b76e4p6>

On Sun, Sep 08, 2024 at 10:43:55AM -0400, Kent Overstreet wrote:
>On Sun, Sep 08, 2024 at 09:25:58AM GMT, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     bcachefs: Add error code to defer option parsing
>
>???
>
>Sasha, this and the other patch aren't bugfixes at all, they're prep
>work for the new mount API, i.e. feature work.
>
>Please just drop the bcachefs patches from stable entirely; the lockless
>IO patch revert is a fix but I'll be sending that with a couple other
>fixes in a day or so.

I've already replied to these, sent directly to you: they've all been
dropped minutes after this mail went out. Human error on my side.

-- 
Thanks,
Sasha

