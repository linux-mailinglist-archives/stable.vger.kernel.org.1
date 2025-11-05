Return-Path: <stable+bounces-192539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C041CC372EB
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 18:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69D2D4F3588
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 17:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7E337BB2;
	Wed,  5 Nov 2025 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THaIUP98"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF6131D37A;
	Wed,  5 Nov 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364580; cv=none; b=NRw+rSoZL+Wodq/pesBvicclR/jU8CfNGSXZk2cCdJ575mSGjNDzYrpREDnGvETKJaQBJyErOMHZBxtbSva/K6kR/9hcdCjlpuGgBU9X/1EJtzovflIoGFvP8rusj45APjxlxXogUqBYHZrJfsUU4Kq/CD6uM3TK2Y48EBAo9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364580; c=relaxed/simple;
	bh=R+xiDn8SGOD7PRSbG4HoLo+gb9SEfBMklxt+Av61vms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mkn06tfZNlX1R4c4vyp8glQXtarofEl9KaQ4RcdHCc5/+P59xaHC9VtPh9Aqjb5neAUyY4wIpWAXWBtikJ2BqLyso8N6bfRO6S1safLBAAMA1tAL1hYn4fQFisTuUIAX0tTLg63/uzI3yinF83xZD4p6CRzEZ160WCKfDcON6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THaIUP98; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B09C116C6;
	Wed,  5 Nov 2025 17:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762364579;
	bh=R+xiDn8SGOD7PRSbG4HoLo+gb9SEfBMklxt+Av61vms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=THaIUP98huAQFvcdFdPxHaB0IarfwDfdglj0ecst4n+yCz5fI7c6viQLMMCWfvWNn
	 AGj7XxeMEwJEwGqPAvl7EZXkdltEsZsUbkMOOdBc3ibvuWcqkWACIZ+fLL1m57tWtW
	 xVZd5UeQV7aV78CSxtE2PNsyGD6NB8aO90wZfF/vxhsjypgtTyWOx84cT7RQv7LllD
	 gEbJ3sqvFxpMnZH6nUh2v07wIOY7QdR9N+UhfzCM3DuWVwaCjstHNJmgCRZpChm89F
	 HbnkRViIuNzjy1KdjJJGsmdcD0ibtcxV5UwPsmKcs9d+8oA1sLjth0pJWEQJaT2Vs7
	 mkavN57BKtdkw==
Date: Wed, 5 Nov 2025 12:42:58 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: Patch "iio: light: isl29125: Use iio_push_to_buffers_with_ts()
 to allow source size runtime check" has been added to the 6.17-stable tree
Message-ID: <aQuMosXxq-F-_A_L@laps>
References: <20251104233644.350147-1-sashal@kernel.org>
 <20251105105311.000045bb@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251105105311.000045bb@huawei.com>

On Wed, Nov 05, 2025 at 10:53:11AM +0000, Jonathan Cameron wrote:
>On Tue,  4 Nov 2025 18:36:44 -0500
>Sasha Levin <sashal@kernel.org> wrote:
>
>> This is a note to let you know that I've just added the patch titled
>>
>>     iio: light: isl29125: Use iio_push_to_buffers_with_ts() to allow source size runtime check
>>
>> to the 6.17-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      iio-light-isl29125-use-iio_push_to_buffers_with_ts-t.patch
>> and it can be found in the queue-6.17 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>
>This isn't a fix.  Harmless if another fix needs it for context but
>in of itself not otherwise appropriate for stable.
>
>The hardening is against code bugs and there isn't one here - longer
>term we want to deprecate and remove the old interface.

Now dropped, thanks!

-- 
Thanks,
Sasha

