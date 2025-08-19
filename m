Return-Path: <stable+bounces-171717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A80B2B6A5
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F37D4E00E4
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082835947;
	Tue, 19 Aug 2025 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmgSKg7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31946287269;
	Tue, 19 Aug 2025 02:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755568992; cv=none; b=MSUI+O6J5psC3r8qbPTLoIMRMEhGlzVyadK1nexSDnGgPtEMoZCDU5vgPdF1bOpPFonn3XTr0Cv9Uq3SasRdG/tyAqzyll/uuZyyvsnlz8Yimr6nVrToG5R1NC6vs/ph8nitKp0RWjkGdrpEfecgDywcp1ke/C4r2qJvSwvGJt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755568992; c=relaxed/simple;
	bh=0ze/SUX4jqsWIpc73bDlq6/O03itjI6mdzwEwm0ilTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZa/DzWPowvKLcpvgVl/qDci7I6OkSWu+Bynh3XO3ph2Q9Ytl2bIy2ezk2Nmj0heX8lPQphOIvnaGcSWDtXpG5s1ucyoN6N3y8x6FILb6lcEVD0hZ6c3uZk0RlViBbQVjprgocHdXn1lBTr5vkfjlPDCCzBUKgMVwMQM5DK4CSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmgSKg7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECD4C4CEEB;
	Tue, 19 Aug 2025 02:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755568991;
	bh=0ze/SUX4jqsWIpc73bDlq6/O03itjI6mdzwEwm0ilTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kmgSKg7Kq7MQdQU1soCb7OEOmqVqJORR4LRWp8S4jqiLp4tcJRdH0KRDzp5Ct9tHl
	 YRA0FkiZgK4+WqULXUpWvKgvXOBj9nze0ryjCPWa2KyOX+1/zYXn+c9nUOBAbuEF+w
	 5cZBM/7x2gfgGYGqBPZtmCPIOSfgBug0wC+KWxXcOhxm3sfMUjt+J84taRTOYCsDLh
	 eV3r1Tv74WdEEtwfB5hgdZCKdFO+5L9bC7h+8PH4h3uW7Dh8aqlG30PllvEQsSwYUn
	 be9O91fJzjIDo/Ea9X+qg+I8QEMFTNDlDQKTRqqFfN6gEbHL6pj6lzpCqfUSDy3avA
	 kuAAlXC4GjgKQ==
Date: Mon, 18 Aug 2025 22:03:10 -0400
From: Sasha Levin <sashal@kernel.org>
To: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "rtc: ds1307: remove clear of oscillator stop flag (OSF)
 in probe" has been added to the 5.4-stable tree
Message-ID: <aKPbXqJ-ddx4Thqj@laps>
References: <20250817154824.2401461-1-sashal@kernel.org>
 <66d68e9a-bbf5-4212-8ca3-175064af545c@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <66d68e9a-bbf5-4212-8ca3-175064af545c@linux.microsoft.com>

On Mon, Aug 18, 2025 at 09:43:35AM -0700, Meagan Lloyd wrote:
>On 8/17/2025 8:48 AM, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     rtc: ds1307: remove clear of oscillator stop flag (OSF) in probe
>>
>> to the 5.4-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
>Hi Sasha,
>
>FYI, patch 2/2 of the series wasn't applied to 5.4, but was applied to all the other trees.
>
>"rtc: ds1307: handle oscillator stop flag (OSF) for ds1341"
>
>[PATCH 2/2] rtc: ds1307: handle oscillator stop flag (OSF) for ds1341 - Meagan Lloyd <https://lore.kernel.org/all/1749665656-30108-3-git-send-email-meaganlloyd@linux.microsoft.com/>
>
>(upstream commit 523923cfd5d622b8f4ba893fdaf29fa6adeb8c3e)

Looks like it failed to apply :(

Could you send a backport to 5.4 please? Or should I just patch 1/2 from 5.4?

-- 
Thanks,
Sasha

