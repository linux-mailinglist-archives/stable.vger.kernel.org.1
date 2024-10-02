Return-Path: <stable+bounces-80600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7D98E3AB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 21:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F542848EB
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED141D0BA2;
	Wed,  2 Oct 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MNAkppkA"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C918AE4
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898362; cv=none; b=qWOgOhWpXk97y8FxIQ0u2jtUe+qcjWsKM74HTxKb37b/zpCl4FOlsGk0otavzhfwKT7ky6ns3eq5Zl48HA9sT+jPLibQ6r2O1IYB0GCKxtMIwQjOQ95Hafqz9XwdgQXw+V84bU2yIBkzYeP9NXTj4UInTpEFpYCc9huSUqaa2RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898362; c=relaxed/simple;
	bh=cRy6jUTHGIqyTJ6tmms42qDfb2ub0/qaTt1OIafEcv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVlxgLrXk1Q/eDjZcP5ELetNlwo84tyDYQ8O3d5j9NWnDs0BskEpyUKkrNnI9ojCJTK1gXW0TyTCixMWil7wQjCRbIhz+oxtWqStFd1C3K6/bCEvNlV8/+uXT+xBmDy0bsKw6b353OIVK75M4SU6i+lf3eiG+ueRRpkgyFCMDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MNAkppkA; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3636ddad6so644305ab.2
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727898359; x=1728503159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwLgYtxh+Kn2aN/eI5e2e9/HtYb4uITXTH+F7OK04HQ=;
        b=MNAkppkAjF3laY4Xoj1W2cn5VKdZfDOuWwGA2XZzDtqKjfCmyFDI6VKT3hR4uGaHab
         o9X9m/vCC2i4D796tLwQF4qhjrRcht4RNCMTs+HqxIHeOiI20zzNPHNDbj3MSBL++b4j
         OrWbbE+0axYPTBag6JgrG5gsjQaDTg//7DwfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898359; x=1728503159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwLgYtxh+Kn2aN/eI5e2e9/HtYb4uITXTH+F7OK04HQ=;
        b=gXQeqUoRCtTr5gizVXJ5CXIW/PS8uDMjuz2L7cloqN75JHbBwJFOpIYBFeYFEJJsKh
         7Mq32lZodOtd52eYY4ZXaIiaS5u7qQHMR15jh7U/zc7+qhvM7Q27Ix36as3oJdUh8koN
         xEDpX89ogPeedLNK23BB9TyOR4XWtflRbRKKKe3qNjAHsLmODp4wiMA26BrEFgbdfe6D
         tzpDABoZu/JVW6GYMtB20csfqQuRcAk4VtpFSO28xCq2v3J9ng9Q3jedKWfuma32ekrj
         saSrOtJCWccoJe7+K7JtnvbNyAkf5DgjdIGYJHgDGM7vMv23KvyJSYEBBcyzzuIh2K2i
         fLYQ==
X-Gm-Message-State: AOJu0YxKAoayUWW3qd7EWlxF2CdbrTz5BqgUTS/+HQQovbigbRlk6ap7
	gQ+2rUYKf252rwQFqOxmjz2ppaXlxIvD58eKJuWBR2eMBPK00OvzcpBIIl7AMu0=
X-Google-Smtp-Source: AGHT+IFzV6ickpCkUKBV0nWtnQ7s/FBrDnKiE5xxcNbDA3OzvGatIAgSZ2VmJukO3ZUBt3sQfDJCEg==
X-Received: by 2002:a05:6e02:190a:b0:3a0:8c83:91fb with SMTP id e9e14a558f8ab-3a365964b22mr34205045ab.20.1727898358783;
        Wed, 02 Oct 2024 12:45:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d888835039sm3235216173.28.2024.10.02.12.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 12:45:58 -0700 (PDT)
Message-ID: <7657fb39-da01-4db9-b4b2-5801c38733e4@linuxfoundation.org>
Date: Wed, 2 Oct 2024 13:45:57 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
 stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
 <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
 <ZvwPTngjm_OEPZjt@zx2c4.com>
 <2db8ba9e-853c-4733-be39-4b4207da2367@linuxfoundation.org>
 <ZvzIeenvKYaG_B1y@zx2c4.com> <2024100227-zesty-procreate-1d48@gregkh>
 <Zv18ICE_3-ASLGp_@zx2c4.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Zv18ICE_3-ASLGp_@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 11:00, Jason A. Donenfeld wrote:
> On Wed, Oct 02, 2024 at 08:21:36AM +0200, Greg KH wrote:
>> On Wed, Oct 02, 2024 at 06:13:45AM +0200, Jason A. Donenfeld wrote:
>>> On Tue, Oct 01, 2024 at 09:29:45AM -0600, Shuah Khan wrote:
>>>> On 10/1/24 09:03, Jason A. Donenfeld wrote:
>>>>> On Tue, Oct 01, 2024 at 08:56:43AM -0600, Shuah Khan wrote:
>>>>>> On 10/1/24 08:45, Jason A. Donenfeld wrote:
>>>>>>> On Tue, Oct 01, 2024 at 08:43:05AM -0600, Shuah Khan wrote:
>>>>>>>> On 9/30/24 21:56, Jason A. Donenfeld wrote:
>>>>>>>>> This is not stable material and I didn't mark it as such. Do not backport.
>>>>>>>>
>>>>>>>> The way selftest work is they just skip if a feature isn't supported.
>>>>>>>> As such this test should run gracefully on stable releases.
>>>>>>>>
>>>>>>>> I would say backport unless and skip if the feature isn't supported.
>>>>>>>
>>>>>>> Nonsense. 6.11 never returns ENOSYS from vDSO. This doesn't make sense.
>>>>>>
>>>>>> Not sure what you mean by Nonsense. ENOSYS can be used to skip??
>>>>>
>>>>> The branch that this patch adds will never be reached in 6.11 because
>>>>> the kernel does not have the corresponding code.
>>>>
>>>> What should/would happen if this test is run on a kernel that doesn't
>>>> support the feature?
>>>
>>> The build system doesn't compile it for kernels without the feature.
>>>
>>
>> That's not how the kselftests should be working.
> 
> If you'd like to get involved in the development of these, by all means
> send patches. As you can see, for 6.12, these were intensely improved in
> all manner of ways:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/tools/testing/selftests/vDSO
> 
> Just look at that flurry of activity. Things are getting better! And
> things were in pretty bad shape before. If you think there's an
> interesting subset of that for backporting, by all means go for it, but
> do it thoughtfully and don't pick patches willy-nilly.
> 

This is not different from other kernel APIs and enhancements and
correspo0nding updates to the existing selftests.

The
vdso_test_getrandom test a user-space program exists in 6.11.

Use should be able to run vdso_test_getrandom compiled on 6.12
repo on a 6.11 kernel.

>> They can run on any
>> kernel image (build is separate from running on many test systems), and
>> so they should just fail with whatever the "feature not present" error
>> is if the feature isn't present in the system-that-is-being-tested.
> 

vdso_test_getrandom test a user-space program exists in 6.11.
Users should be able to run vdso_test_getrandom compiled on 6.12
repo on a 6.11 kernel. This is what several CIs do.

> So, it's actually not that clear what the best thing is. Firstly, for
> vdso_test_chacha.c, it can't even compile without the symlink and a
> resolving tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S symlink, which
> is on a per-arch basis. You might say that in this case, it's best to
> condition the Makefile on `ifneq ($(wildcard tools/arch/$(SRCARCH)/vdso/
> vgetrandom-chacha.S),)` instead of on $(ARCH), but there's this ugly
> wrinkle where some of the code that's being compiled is 64-bit only, and
> x86_64 and x86 share a $(SRCARCH) path. (That Makefile makes use of
> $(CONFIG_X86_32), which is pretty gross and might not work; I'm not yet
> sure how to fix that.) Christophe experimented with having the compiler
> decide, and then there being a runtime result, but it added a lot of
> complexity that didn't seem necessary. There's more experimentation to
> be done here.
> 
> Meanwhile, part of vdso_test_getrandom.c's purpose is to test whether
> __kernel_getrandom() or __vdso_getrandom() is actually being properly
> exported from the vDSO. This is also interesting on powerpc, where it's
> implemented on both 32-bit and 64-bit, so there's the compat case to
> worry about. That in turn means that this test has in it:
> 
> 	vgrnd.fn = (__typeof__(vgrnd.fn))vdso_sym(version, name);
> 	if (!vgrnd.fn) {
> 		printf("%s is missing!\n", name);
> 		exit(KSFT_FAIL);
> 	}
> 

x86 selftest handles 32 vs 64-bit related scenarios now. You can take
a look at the Makefile. You can also split the test specific to 32 vs
64 and compile it for native and cross-compile cases.

> And not exit(KSFT_SKIP), since that would hide the failure to export the
> symbol. Now, you could say that since development on the fundamental
> part is mostly concluded, we could move to a KSFT_SKIP, in order to
> simplify the build choice and such. I'm not sure where I stand on that.

If I am understanding this correctly, KSFT_FAIL is used during development
and as of today, KSFT_SKIP is the correct exit code??

> At the very least, there's still RISC-V coming down the pipeline for
> this feature, so it probably would change after that comes out.
> 

This can be handled as part RISC-V.

> Anyway, that is all to say that this stuff has been thoroughly
> considered, not haphazardly glued together or something. Maybe that
> consideration has reached wrong conclusions -- that's an entirely
> possible of an outcome -- but it wouldn't be for lack of caring. If
> you'd like to contribute to it, I'd certainly welcome a hand. But please
> don't do the arm-chair coding thing.
> 

Probably. We don't know what we don't know. selftest use-cases are the
ones we are discussing here.

You can check the kselftest use-cases and contribution guidelines
in kselftest.rst

> Meanwhile, this ENOSYS thing has nothing to do with what either of you
> assumed it does. This is to handle obscure/exotic arm64 hardware, which
> might not exist in the Linux world, that doesn't have NEON support. But
> since arm64 support for this function didn't even come to Linux 6.11,
> there's no point in discussing it as a backport.

#define ENOSYS          78      /* Function not implemented */

user-space understands ENOSYS as feature/function not implemented.

If ENOSYS is the right choice for this obscure/exotic arm64 hardware?

The user-space vdso_test_getrandom test has to run on all architectures
if can be compiled (unless Makefile restricts the compile) and older
releases and handle not finding the feature and fail gracefully.

thanks,
-- Shuah

