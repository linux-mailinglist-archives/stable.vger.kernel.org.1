Return-Path: <stable+bounces-200989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E6CBC2F2
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 02:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60BAF3007964
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 01:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B9194A76;
	Mon, 15 Dec 2025 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inKPIeGt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC818C2C;
	Mon, 15 Dec 2025 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765762346; cv=none; b=D4fr/O6OfRMwkHvVkKYAGUoM12QgWtU95SOlxSQUMDEqsZybFqvVd+Jx6n08Bm+DoABLOlS9aUvAnGTeZMfqwd1jJo9/GkWCPSerEpRRFkakdpyxkWZbNTJK1PtcwjzGVoqMIAF2Xf3uHyxInNhtJjCmdHFroFVhy22sdLOAIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765762346; c=relaxed/simple;
	bh=UY8ok3oQOijvGGl0QdVrF6A7n2L18UcpexQPS6NMHR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpdUmrPmjkVYuwtlu7nOPVXBJO9KlXo+LUAElVWwj+h9GgnwOe6I85LfmUDLfhDJo03ARemFRZ/86ODAfgp5CyY+kJypo5yETVxKJluPvyl6riXLAFdWZNS0bAEQ8LZl7bGrsSXISjAdQzEJshj2ioOX3ceq0newroN0NuNnbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inKPIeGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A3FC4CEF1;
	Mon, 15 Dec 2025 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765762345;
	bh=UY8ok3oQOijvGGl0QdVrF6A7n2L18UcpexQPS6NMHR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inKPIeGtLHVORFdoxPFJVxsAZ48F4biAAqvqzQVI+UYsKFT45iSwbyK+se6tAwlta
	 VcLbTzEUN80Gy0qE10cFcktBaFeOA0jxzkVd715r0aaF8Z26tfDXlRd1XFVhRef0Rk
	 du+oUYehlaSg2WX7qkkiRcP+nYH0y1bLFPSqXBWVMY9A3r4Nlgq+lhN24+X58oL1+c
	 CgoVmEdn9aGxpNqqoXTZFVIlYFy6yVCKsboLCVGcYLD6HdET+f4zqed5IxRwXJ9X3m
	 TXdf2rEcW4stCHi6SrQCbfEct7LjEBKuKKCKXQ5vO8zu2X1Qra/2ats0hLl74rzGFf
	 o3Tx3ydSQ+FFQ==
Date: Sun, 14 Dec 2025 20:32:22 -0500
From: Sasha Levin <sashal@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	johannes.thumshirn@wdc.com, Jens Axboe <axboe@kernel.dk>
Subject: Re: Patch "block: fix cached zone reports on devices with native
 zone append" has been added to the 6.18-stable tree
Message-ID: <aT9lJjG3Lhz-Z3jq@laps>
References: <20251215003707.2750979-1-sashal@kernel.org>
 <c49b5b4c-a3b2-40f6-8d8a-fb20448eb5ed@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c49b5b4c-a3b2-40f6-8d8a-fb20448eb5ed@kernel.org>

On Mon, Dec 15, 2025 at 10:20:44AM +0900, Damien Le Moal wrote:
>On 12/15/25 09:37, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     block: fix cached zone reports on devices with native zone append
>>
>> to the 6.18-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      block-fix-cached-zone-reports-on-devices-with-native.patch
>> and it can be found in the queue-6.18 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>Sasha,
>
>This is a fix for a new feature that was queued for and is now added to 6.19. So
>backporting this to stable and LTS kernels is not advisable.

I can drop it. It was picked up because the Fixes tag pointed to an older commit:

Fixes: a6aa36e957a1 ("block: Remove zone write plugs when handling native zone append writes")

-- 
Thanks,
Sasha

