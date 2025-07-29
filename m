Return-Path: <stable+bounces-165107-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AACB1520A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6F418A44F2
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1529293462;
	Tue, 29 Jul 2025 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnKalwO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC5145FE8;
	Tue, 29 Jul 2025 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809820; cv=none; b=MsYRh8CZnKZfVzjrS89pzAjBV+/nCPrCWv0PySubR+8D7mIYtxrcwaYIQ871RypeQADgFPa7S8DcZ6Xp0m/l7tvWkh1f5aWfGry5f3U9IXePm4KQt81kbxNN26Gjrsdd/W24NkSGbHehaMQjK9VWbYokQZ0ajKS1w5sfKc5TKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809820; c=relaxed/simple;
	bh=RdnueLexH2FWGlzkqJvbcyOP3kHmcNSYoqI5v55wuyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cl8U1J3VaV5K/cIxp+2///RPbhMb8grgNKirr6qYuTFT/UFWkx8tgAteY4bgTl/KVFqvSofgadarQvkT8RbKZvxFk02h9mRniQFmNy4th30GPDQldvSVMCFs1wmtqI+ZPISzL8HTbaI7yb4Ur/zGGz8nYY3dkRpgd4jAcjJBfFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnKalwO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3D7C4CEEF;
	Tue, 29 Jul 2025 17:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753809820;
	bh=RdnueLexH2FWGlzkqJvbcyOP3kHmcNSYoqI5v55wuyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tnKalwO0SpNZbZBasQ61Bes2ZbgrwjUOOmNKBnwL6re1RB+l7utnbA4Pi03si3Xtn
	 yE8Ae8wySL+UHVDoyJt809XYOBIS2zIMXPh603uCA4TnxojANbEtdRelf4/3+tSQG9
	 Yg47ku1oLjujLNpnol2kWxNDC2o7vE431Tdhr7yzJP/R4zhifh3ehCk/lUiyczI6zS
	 utEE9U8Nkjpx9tyt9+s/OPP/PfOn6Z3fARGCY+2yUEPFWgdA2m8kwL7u/lcSv1t3sY
	 H7aJOfvxcixRnHLhJku0qgkvFLTFuGhRl4VA5+2AVhOyOCTQjUK7cUzlcVFcHR3o+r
	 kZXxL77nV5N3A==
Message-ID: <1e8439d3-1467-4029-a808-731e11b29c7a@kernel.org>
Date: Tue, 29 Jul 2025 11:23:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sasha Levin is halucinating, non human entity, has no ethics and
 no memory
To: Pavel Machek <pavel@ucw.cz>, Shuah <shuah@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org,
 kernel list <linux-kernel@vger.kernel.org>, conduct@kernel.org,
 ebiederm@xmission.com
References: <aG2B6UDvk2WB7RWx@duo.ucw.cz>
 <46f581c6-bb61-4163-91a5-27b90838dca8@kernel.org>
 <aIXsgI1n68Dy3l7+@duo.ucw.cz>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <aIXsgI1n68Dy3l7+@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/27/25 03:08, Pavel Machek wrote:
> Hi!
> 
> On Wed 2025-07-09 15:14:38, Shuah wrote:
>> On 7/8/25 14:39, Pavel Machek wrote:
>>> Hi!
>>>
>>> So... I'm afraid subject is pretty accurate. I assume there's actual
>>> human being called "Sasha Levin" somewhere, but I interact with him
>>> via email, and while some interactions may be by human, some are
>>> written by LLM but not clearly marked as such.
>>>
>>> And that's not okay -- because LLMs lie, have no ethics, and no
>>> memory, so there's no point arguing with them. Its just wasting
>>> everyone's time. People are not very thrilled by 'Markus Elfring' on
>>> the lists, as he seems to ignore feedback, but at least that's actual
>>> human, not a damn LLM that interacts as human but then ignores
>>> everything.
>>>
>>
>> You aren't talking to an LLM - My understanding is that Sasha is sending
>> these patches (generated with LLM assist) and discussing them on mailing
>> lists.
> 

> At this point, I'd like to know (a) what steps (if any) were taken to
> prevent LLM hallucinations from reaching the lists, and (b) what steps
> (if any) were taken to make sure patches Signed-off by developer were
> actually reviewed by said developer, and not applied simply due to
> said hallucinations.

> 
> Confusion caused LLM hallucinations can be seen for example in thread
> "[PATCH AUTOSEL 6.15 6/8] PM: Restrict swap use to later in the
> suspend sequence", it includes as great stuff as fake http links.
> 
> I have seen solution proposed for (a), but have not seen any solution
> proposed for (b) and that's actually more serious problem.
> 
> One solution would be to use separate email address "Autosel bot <>"
> for both From and Signed-off, so there's no confusion between content
> generated by developer and content generated by LLM.

I am going to repeat what I said in my response to the conversation
about the code of conduct violation.

https://lore.kernel.org/lkml/f145b475-5b61-4565-8406-98894e706077@linuxfoundation.org/

The use of LLMs in the development process and rules about such use
including how to clearly state if LLMs are used in the process is a
timely and important topic. It can be confusing when a developer
doesn't clearly state the LLM use.

However, as you acknowledged here that you couldn't tell if these
patches originated from the developer or not. In which case, there
are several constructive ways to move forward to clear up the confusion.

1. Send response to the patch and hold a constructive discussion about
    the confusion.
      
2. Start a separate thread to talk to the developer privately or publicly
    in a respectful and constructive way.

3. Start a Tech board conversation with the TAB.

You didn't take any of the above constructive approaches. Instead your
responses included personal attacks which are visible to community and
others to see.

The Code of Conduct Committee has determined these are personal attacks.
These are a clear violation of the agreed upon code of conduct which can
be easily remedied with an apology.

- https://docs.kernel.org/process/code-of-conduct.html
- https://docs.kernel.org/process/code-of-conduct-interpretation.html#code-of-conduct-interpretation

Assume you are speaking to a fellow developer and ask them to give details
on the nature of LLM use in the patch. It will result in a constructive
conversation for these important topics at hand.

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

