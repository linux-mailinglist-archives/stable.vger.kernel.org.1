Return-Path: <stable+bounces-200990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FCFCBC301
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 02:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68C1D30084E3
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 01:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91B41E5734;
	Mon, 15 Dec 2025 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/c4WPQy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1518C2C;
	Mon, 15 Dec 2025 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765762668; cv=none; b=H8m6wdz4rHP31t6oZAcboWMnDXCWaAlKRitqdAlS9hifGwwhwgSIG5ZLNu4fTHqqalzTolIMa050R3dAJHJ5DyUgJWs0r069MCRQZmZo556MVzj0fFngp3CRerARsZxKWJI3rsYNwqL4intvaAcYO4vuyyaPWhDhv8NiZ6C5bzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765762668; c=relaxed/simple;
	bh=VMTzxX4LV4+kntIq0KAZJETbrGlW2LowFvECT/2jQrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uH7MzRIKL6YcxDX1BsIZ9tLFoFBOllazq3hRVzgpT5OaeU34Z7OtyuBBnEMpZiqw+b31j/aBvHC+4+RwgeRYI+30x0lN5zscfsnU8nJy6H4cgTAb8C0sgrdlRmeHqD71gYHvyHwYzc/TWSsORyKaWZEYuWkAO9K0g0ovAQcCGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/c4WPQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECA1C4CEF1;
	Mon, 15 Dec 2025 01:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765762668;
	bh=VMTzxX4LV4+kntIq0KAZJETbrGlW2LowFvECT/2jQrY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e/c4WPQyk+XD+q/h9oJwY3JauTdeRFSx5t2QvLfjPxMgA8oA9mLl9aonnBzODuujW
	 ZahF9eo9fByWV4LyXOZGcSPqjI8+FhgVzEwxlL+66PU9YVhZ158Zr2KxNePvFscujW
	 7Ths6M90aey2X5oQn+0kNPo4Nem71hW9DZN4H0anSzAQ44An9VTrtJBGZ/aJwepUbR
	 aDZoWar80Nuzqg3GUFIqTDoDq1cuYf8h0gNj+qsOPUDpdV1gV1GeanqMoQgAkVQ1Rm
	 jnboc1hP1N8mvkG+we1uoBLR8pRyMakP/9EIeXK7ULv429hDSWOs+GvCE5EMIYCkdw
	 pc0LFtb175wFw==
Message-ID: <fd96d5f4-4e64-4c27-ace0-a12dc5111c7b@kernel.org>
Date: Mon, 15 Dec 2025 10:37:46 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "block: fix cached zone reports on devices with native zone
 append" has been added to the 6.18-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 johannes.thumshirn@wdc.com, Jens Axboe <axboe@kernel.dk>
References: <20251215003707.2750979-1-sashal@kernel.org>
 <c49b5b4c-a3b2-40f6-8d8a-fb20448eb5ed@kernel.org> <aT9lJjG3Lhz-Z3jq@laps>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aT9lJjG3Lhz-Z3jq@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 10:32, Sasha Levin wrote:
> On Mon, Dec 15, 2025 at 10:20:44AM +0900, Damien Le Moal wrote:
>> On 12/15/25 09:37, Sasha Levin wrote:
>>> This is a note to let you know that I've just added the patch titled
>>>
>>>     block: fix cached zone reports on devices with native zone append
>>>
>>> to the 6.18-stable tree which can be found at:
>>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>>
>>> The filename of the patch is:
>>>      block-fix-cached-zone-reports-on-devices-with-native.patch
>>> and it can be found in the queue-6.18 subdirectory.
>>>
>>> If you, or anyone else, feels it should not be added to the stable tree,
>>> please let <stable@vger.kernel.org> know about it.
>>
>> Sasha,
>>
>> This is a fix for a new feature that was queued for and is now added to 6.19. So
>> backporting this to stable and LTS kernels is not advisable.
> 
> I can drop it. It was picked up because the Fixes tag pointed to an older commit:
> 
> Fixes: a6aa36e957a1 ("block: Remove zone write plugs when handling native zone append writes")

Understood. This backport will not cause any issue even if you keep it. But it
is not necessary either.


-- 
Damien Le Moal
Western Digital Research

