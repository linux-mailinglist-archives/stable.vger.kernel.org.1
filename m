Return-Path: <stable+bounces-183454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E9BBED3A
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 19:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCA514E41AB
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 17:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC87623BCEE;
	Mon,  6 Oct 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4RTes0k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA87221F1A
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772252; cv=none; b=UJdW+q/4jsjKCugSYQ5/FCZtt73POg9RdCqxjbrf3fHk376Ddv0b8+ur85hWoWGWVYsqe6P6rZ4FrD+fiS2Aglzbdt9rkzRds7Eu5QKUB+T5LJvo/e7vNxydv2dPDM+0Olhnqyvr36KGJ+CBJjdScqvwr2Nt9fwFhof5ehVhyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772252; c=relaxed/simple;
	bh=ncz8RhYscOCngkqyOgAbgdOtYQZsXrm3AqpBi677JSw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oAp1P+sf9t0DRE8tYtFTMgU1X/MXakKMeW3+lkPQLl5KTHU6y6HEQOfB+ktPrZ4jourlb9rEweKWoz0O7hkWByTasWT/qKKJpIctaHPD06kxRWhHuufHyGH6KD6VBJq6/Vx7XW+YrKMSbHbDyT0kcDTVw5J+/w2ZNo4PigMAk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4RTes0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E9FC4CEF5;
	Mon,  6 Oct 2025 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759772252;
	bh=ncz8RhYscOCngkqyOgAbgdOtYQZsXrm3AqpBi677JSw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=G4RTes0kMLAX7NxW+WzbstsJCu7zfFQFqmtRzSjw9wL3C02mqm2vVURUUuuQBapmv
	 3GS28DOc1Gpsi5nuteGTXOnG5p3l8II/su1hGQrLXKWH3edSecoOfoxk/+BVPApXZO
	 qTXqfoNnDKTIzdBWRthlUFgr6TUAuw+9wj6KAhTnxH26GwpiC3up5B0lF8kgJqjfiu
	 nmXSkVO5OTxdSxBe8MSnCQlELgLQF7YR07u/BX/DTJJOcDBfHtoj4jOUmWUff8C0Gc
	 1/bMWThGHR1PESa8MYkwNO+KR0ECsPwYpjUTdc19Czrp9/l2ErE56QXWNpUFky8O/h
	 bbeSbHWqvQ/Dw==
Message-ID: <7bf4b055-d751-4a84-bfd0-a7df78c2a6d8@kernel.org>
Date: Mon, 6 Oct 2025 12:37:30 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LR compute WA
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <3c147f99-0911-420b-812b-a41a26b4a723@kernel.org>
 <2025100627-landfill-helium-d99a@gregkh>
 <f2d82fa5-7eb3-4717-89ba-6568658e1bf4@kernel.org>
Content-Language: en-US
In-Reply-To: <f2d82fa5-7eb3-4717-89ba-6568658e1bf4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/6/2025 8:56 AM, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 10/6/2025 5:04 AM, Greg KH wrote:
>> On Sat, Oct 04, 2025 at 01:41:29PM -0500, Mario Limonciello (AMD) 
>> (kernel.org) wrote:
>>> Hi,
>>>
>>> We have some reports of long compute jobs on APUs hanging the system. 
>>> This
>>> has been root caused and a workaround has been introduced in the 
>>> mainline
>>> kernel.  I didn't CC stable on the original W/A because I wanted to make
>>> sure we've had enough time to test it didn't have unintended side 
>>> effects.
>>>
>>> I feel comfortable with the testing at this point and I think it's worth
>>> bringing back to any stable kernels it will apply to 6.12.y and 
>>> newer. The
>>> commit is:
>>>
>>> 1fb710793ce2619223adffaf981b1ff13cd48f17
>>
>> It did not apply to 6.12.y, so if you want it there, can you provide a
>> working backport?
>>
>> thanks,
>>
>> greg k-h
> 
> Thanks, I see 6.16 and 6.17 had no problem.  I'll find the contextually 
> missing patches and send out 6.12.y separately.

OK - here's the 3 patches needed for 6.12.y to cleanly cherry-pick:

ce4971388c79d36b3f50f607c3278dbfae6c789b
1c687c0da9efb7c627793483a8927554764e7a55
15d8c92f107c17c2e585cb4888c67873538f9722

Thanks!

