Return-Path: <stable+bounces-56032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0C091B58B
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 05:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AC81F224F5
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 03:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6BE1DA5F;
	Fri, 28 Jun 2024 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAc6ioRZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F811CD32;
	Fri, 28 Jun 2024 03:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719546287; cv=none; b=Y9nhnfzjEGbjqtB+UNMwOadwNFRQvmUM8D7NpAW17kO3jimk0rRkk6Ce0Z4pOHl7XnCaU4lHX3oAMMNkhQTRvQBwbivSbXez5xe3fl5DA2CO69UIzC1iP7ZjlwcQbMJYwhpx6dSw/b5s24gim4BTsWlMxBzI65WQ8JUKuhXCA7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719546287; c=relaxed/simple;
	bh=incWKKmZyowAMqcf56j8FOwILPp/7dyPp3aXpCaLNz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLP+Ihkh9Ja/V0r12XLMiJQlEQT2wfyqg3WRMyMysH29EUqsImJfcWrrKsXyKAWSAJf1z0/UVLnRLoi98ihYVIGHpGC+yg9Sa317XYQUQk+Mv6xQV62sQ5sXJrDjaN2WCAW3sTwMNvZtJ0VrVSfB82Y9aU7t5GQmvvRtDHlbdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAc6ioRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40824C116B1;
	Fri, 28 Jun 2024 03:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719546286;
	bh=incWKKmZyowAMqcf56j8FOwILPp/7dyPp3aXpCaLNz4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WAc6ioRZsAR4SVI457Ows1D0UCi7tZBZdRyWEWSNCOuQk0tFG4Aru5vsQllQMTfVS
	 dFAZab5hYzUJtF9TP66Pj2VyAhhFj3iLrdUQuGe7skGvbm95E2I9SaIdDbSFGtDTqI
	 J9X2gXAOT0WxfUBHLahtgXDgJFHCbvVjSCgXO5hf0QzURAE/QO436umidJejdABV+k
	 IAhcaVWOyexnhbuVcRCiloQzk13OKQzdhwWIZ4ZYkeF6xVLqWD20a/W3adQw+jGhaB
	 AGFk5lcfr+Hx5moIoE4MW2tbpxu//48e9b0fbUaA0K2sU2auVfT4b2zx1Mtd88JDEX
	 8/friCpV4BjZw==
Message-ID: <6408b923-d9e8-4a86-bd0d-7cbe050433e6@kernel.org>
Date: Fri, 28 Jun 2024 12:44:43 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5.10/5.15] ata: libata-scsi: check cdb length for
 VARIABLE_LENGTH_CMD commands
To: Sasha Levin <sashal@kernel.org>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jens Axboe
 <axboe@kernel.dk>, Niklas Cassel <cassel@kernel.org>,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pavel Koshutin <koshutin.pavel@yandex.ru>,
 lvc-project@linuxtesting.org
References: <20240626211358.148625-1-mish.uxin2012@yandex.ru>
 <ab75136a-cdf5-4eb1-a09a-bc59beb6b8df@kernel.org> <Zn3Gzc46q_gXoD59@sashalap>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zn3Gzc46q_gXoD59@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/24 5:08 AM, Sasha Levin wrote:
> On Thu, Jun 27, 2024 at 11:02:23AM +0900, Damien Le Moal wrote:
>> On 6/27/24 06:13, Mikhail Ukhin wrote:
>>> Fuzzing of 5.10 stable branch reports a slab-out-of-bounds error in
>>> ata_scsi_pass_thru.
>>>
>>> The error is fixed in 5.18 by commit ce70fd9a551a ("scsi: core: Remove the
>>> cmd field from struct scsi_request") upstream.
>>> Backporting this commit would require significant changes to the code so
>>> it is bettter to use a simple fix for that particular error.
>>
>> This sentence is not needed in the commit message. That is a discussion to have
>> when applying (or not) the patch.
> 
> It's good to have this reasoning in the commit message to, so that later
> when we look at the patch and try to understand why we needed something
> custom for the backport, the justification will be right there.

OK then, let's keep the commit message as it is.

Mikhail,

Please send a v5 patch with the correction I commented and the patch will be
good to go.

Thanks !

-- 
Damien Le Moal
Western Digital Research


