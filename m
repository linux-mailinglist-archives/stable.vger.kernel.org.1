Return-Path: <stable+bounces-73588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A28896D592
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 12:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4645028740D
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3D6198A0B;
	Thu,  5 Sep 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PewQUfC1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A67198827;
	Thu,  5 Sep 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531185; cv=none; b=j/sKUc0m83zku/s+8RQrmlsqjkX6oSClq+vCLQDWXjrjJ0BYaoEB+wI4y8YqOaHYJJWH0jVVCCKfIaD/7nqTJ8yeOg/AtoWndkSgAcuRBKb11ztXYOgrzajRXR2UOdMTjPTZCkRClpDejkhAbrpQEG+pfi1ZwVvL+2mfs1wnMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531185; c=relaxed/simple;
	bh=ApcMkVCcR2IMh0BFcmnBem72d6KRMxjUw8crmrO1m74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqfK5BpW8+/1fcHNkmI5fNiB+c1inAyKoGN2AHaFZsKJoZyRomBNjYASZMesiq04NXKrVsvnz2IOexjxGUWVtbMNo83uAj+qn4cppkilp43EW6bkEduxGZSicsXoHgeDiAYxDyXYsBiQ7KJQUpuTQUOQJef8JxH2/kFfcb4OeN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PewQUfC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCABC4CEC3;
	Thu,  5 Sep 2024 10:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725531185;
	bh=ApcMkVCcR2IMh0BFcmnBem72d6KRMxjUw8crmrO1m74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PewQUfC1mrH4+TpzoOCsckuE9j0sbTuZmSwsIbe65aZjABMqOI6qSeArXBy6JqDmp
	 Hk+kwdFVWfam/tZVMX6xUJvmAQzp69P8tu0CGsKxPlTKhsD/HIpnx0KOlm8dhiMZ1c
	 NgjNVVDb+LPjIkM3u2L+gj1Arsqc9QqafIz4r7nuqL0geKqktfmZbwjWYIt2hdjarC
	 7uHfzbTyOKVGAPLQV1QHT84FfBXVp5d6aWCWQIHjOEo3FZfCTzrs8TYCONVHcJdZji
	 gXxm40TBSZt0B2jDg045otu5SaEx7Qr12Tg0DamnjSVHAgjZd8aP5xpL6qFRl9e2Sk
	 s09nxxXRlbjug==
Message-ID: <220913e1-603f-4399-a595-bb602942161a@kernel.org>
Date: Thu, 5 Sep 2024 12:13:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.1.y] selftests: mptcp: join: validate event numbers
Content-Language: en-GB
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
 Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sasha Levin <sashal@kernel.org>
References: <2024083026-attire-hassle-e670@gregkh>
 <20240904111338.4095848-2-matttbe@kernel.org>
 <2024090420-passivism-garage-f753@gregkh>
 <fc21db4a-508d-41db-aa45-e3bc06d18ce7@kernel.org>
 <2024090556-skewed-factoid-250c@gregkh>
 <2024090541-bride-marbled-f248@gregkh>
 <23b49a68-476d-4c3d-b2c8-9e0dc4514c74@kernel.org>
 <2024090523-antler-errant-b403@gregkh>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <2024090523-antler-errant-b403@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 12:10, Greg KH wrote:
> On Thu, Sep 05, 2024 at 11:42:21AM +0200, Matthieu Baerts wrote:
>> On 05/09/2024 11:36, Greg KH wrote:
>>> On Thu, Sep 05, 2024 at 11:33:46AM +0200, Greg KH wrote:
>>>> On Wed, Sep 04, 2024 at 05:20:59PM +0200, Matthieu Baerts wrote:
>>>>> Hi Greg,
>>>>>
>>>>> On 04/09/2024 16:38, Greg KH wrote:
>>>>>> On Wed, Sep 04, 2024 at 01:13:39PM +0200, Matthieu Baerts (NGI0) wrote:
>>>>>>> commit 20ccc7c5f7a3aa48092441a4b182f9f40418392e upstream.
>>>>>>>
>>>>>>
>>>>>> This did not apply either.
>>>>>>
>>>>>> I think I've gone through all of the 6.1 patches now.  If I've missed
>>>>>> anything, please let me know.
>>>>> It looks like there are some conflicts with the patches Sasha recently
>>>>> added:
>>>>>
>>>>> queue-6.1/selftests-mptcp-add-explicit-test-case-for-remove-re.patch
>>>>> queue-6.1/selftests-mptcp-join-check-re-adding-init-endp-with-.patch
>>>>> queue-6.1/selftests-mptcp-join-check-re-using-id-of-unused-add.patch
>>>>>
>>>>> >From commit 0d8d8d5bcef1 ("Fixes for 6.1") from the stable-queue tree:
>>>>>
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=0d8d8d5bcef1
>>>>>
>>>>> I have also added these patches -- we can see patches with almost the
>>>>> same name -- but I adapted them to the v6.1 kernel: it was possible to
>>>>> apply them without conflicts, but they were causing issues because they
>>>>> were calling functions that are not available in v6.1, or taking
>>>>> different parameters.
>>>>>
>>>>> Do you mind removing the ones from Sasha please? I hope that will not
>>>>> cause any issues. After that, the two patches you had errors with should
>>>>> apply without conflicts:
>>>>
>>>> Ok, I've now dropped them, that actually fixes an error I was seeing
>>>> where we had duplicated patches in the tree.
>>>>
>>>>>  - selftests: mptcp: join: validate event numbers
>>>>>  - selftests: mptcp: join: check re-re-adding ID 0 signal
>>>>
>>>> I'll go add these now, thanks!
>>>
>>> I just tried, and they still fail to apply.  How about we wait for this
>>> next 6.1.y release to happen and then you rebase and see what I messed
>>> up and send me the remaining ones as this is getting confusing on my
>>> end...
>>
>> Thank you for having tried!
>>
>> Sure, no problem, I can wait.
>>
>> I just hope the previous patches I sent have been applied properly. I
>> mean: I don't know how quilt handled the duplicated patches with
>> different content.
>>
>> If you prefer, we can also drop all the MPTCP related patches -- or only
>> the ones related to the selftests -- and I send the whole series I have
>> on my side: it is still on top of the v6.1.108-rc1, so without the
>> patches Sasha backported yesterday.
> 
> Let's see how this -rc release looks, if it's broken or messed up, I can
> easily drop patches as needed.
Sounds good to me. I will check this RC before looking at the remaining
failed backports.

Thank you for your support!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


