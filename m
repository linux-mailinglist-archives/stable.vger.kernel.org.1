Return-Path: <stable+bounces-26697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5EE87143F
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 04:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E781C21382
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 03:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBE229D08;
	Tue,  5 Mar 2024 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HFUrb4Ms"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189E3FE47
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609291; cv=none; b=IZdYFuvx7vUisYejOKPm4mpd0vOvPcti0ko7BOZS/L0cIoYoMYyRFYFNRm6+pUYFR3y/bFL3Cin3nJirGj+sht8fE85DHLiGDR9LESKFC2chARvYYFkkUn/HlBsZ+H9x90UdWKWWhjnuNlgSVlxXpIIy1D8O/Oq3IiLCd2eJl3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609291; c=relaxed/simple;
	bh=WamC2udXV+suNnmADkzTuVlaBpdRhCTM/8Q7q9WbMeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWPycMlFmSclyFhEqlEoPi/rLXUfvn6l2kvbAe1r9TjPoT89cZlzgRTRldi1NmYtvEnTMxvYIPTnwV60uwLGyMi8cZaukQzbJuYwcDKdJub+kLZn92b8O4pjAPx/QHVc/pcUWbUY5b2de75FJ8scYxdBQK/Rv5OrmyNhbQOPqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HFUrb4Ms; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c1f55ba3ecso616241b6e.3
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 19:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709609288; x=1710214088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQEHwzYRYJKhL3B500sQ7f4LkRj9XfhmOot1cZDRXYg=;
        b=HFUrb4MsO4JcvsLa78buDYFti0el0zflpT8y0/yZvHmk4tsrKqCPEDPep5GyIBmq8f
         gt29h8fZpYaDURK2kK02q0drJ8P5MruXjB4Icfq6z01T7JIkLhiTHvnw2z6qBM95WZTR
         w8MlMAXvFknnf3dERTi+RT/y6KYJjAaxnTPoQtg+Q6hZJLuUqgp+SuKqaL956bxShrM2
         Mb3qM0vJdctCYq732vDGpApkrWslT/8sHL6Lw2DsustveT6d23xGnlJ28u5aGr4zlYi8
         EMLd4cPN7MwODCtARphsqbJH10UBwaG9ip+HaaslSdXopYhNFcTJUvWvQTRdRV1gxpFW
         0WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709609288; x=1710214088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oQEHwzYRYJKhL3B500sQ7f4LkRj9XfhmOot1cZDRXYg=;
        b=CfZ4z2gVFH2ilN8cOllaiQZ8pjgSSOlBUykC3rWrNQYeyBMN9QUQOHYcYDCQpFpruc
         7/ke6GDUhqe+L/EB2M1uk//RKUTKycTkpHnyc6s96wozoeFXDnod5ZWUA1/TRZNN00eh
         GoBEk+yyncSbquNwJL6sAzJ4xNLS/NqvWz0WoFc9akQ+kSIEBaWGlwnPm2GbVzNvZgms
         Exu1ClhOxdReiiRCskYT6U3wvGIpZ4F7LDdeNKL4qDhlG/StGJ+waqt+NWRC6ZhB/k07
         /EuwTmHRsgCdiyqiLnHIgqSLAt15aLApYAHLItWg4ou8WLvJveaGG+y9OrrHsDk8ppr8
         hq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWamcvsU9+FaRdckkkDcjYXROQKN7KrxsEvcVWorgwIFUA24AzjFC+iDJPpa4D2qFm7SrLOO1PpQXVh4VViovNnR5tJJE3n
X-Gm-Message-State: AOJu0Yzj4IWBaM/c+mloZjn3qZ2fNHLQ8uPMXhX4T3aJTO1/a9AzhpWG
	yJsYZDuTyTQDTWO7wClKDfFsCIQPK9Qznmc/ou9dqniWXz+/3Y2ix5Sj0CV786w=
X-Google-Smtp-Source: AGHT+IH2bQSMUzSN0S02zlOvSm/FNREnSgBFsEIuRGxZZenpRGxcP7zX2plnTQLrROGRE+fJmgepIw==
X-Received: by 2002:a05:6808:1524:b0:3c1:ed50:7c2b with SMTP id u36-20020a056808152400b003c1ed507c2bmr807224oiw.47.1709609288317;
        Mon, 04 Mar 2024 19:28:08 -0800 (PST)
Received: from ?IPV6:fdbd:ff1:ce00:1d7c:876:e31b:5d3a:49d6? ([2001:c10:ff04:0:1000:0:1:6])
        by smtp.gmail.com with ESMTPSA id b128-20020a62cf86000000b006e510c61d49sm8335459pfg.183.2024.03.04.19.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 19:28:07 -0800 (PST)
Message-ID: <c98aa910-7b14-401d-a257-274682bb7486@bytedance.com>
Date: Tue, 5 Mar 2024 11:28:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2 0/3] Support intra-function call
 validation
To: Greg KH <gregkh@linuxfoundation.org>
Cc: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
 stable@vger.kernel.org, alexandre.chartre@oracle.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, yuanzhu@bytedance.com
References: <20240228024535.79980-1-qirui.001@bytedance.com>
 <2024030438-dropout-satisfy-b4c4@gregkh>
 <2024030404-conjoined-unlined-05c0@gregkh>
From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <2024030404-conjoined-unlined-05c0@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Greg,
I checked out commit e133c1ee6d7271007fdba3dbe78818afd88943f9 (Linux 5.4.270), applied my patche set on top, enabled CONFIG_LIVEPATCH based on x86 defconfig, compiled without any issues. I couldn't even grep unwind_hint_empty in the codebase, so I'm quite puzzled about how this phenomenon occurred. Can you tell me how to reproduce this compilation error?

In addition, my patchset only applies to the LTS branch of 5.4, not to other branches. Please be careful not to merge it into other branches.Other stable branches do not have the problem of such kernel livepatch issue.

On 3/4/24 6:55 PM, Greg KH wrote:
> On Mon, Mar 04, 2024 at 11:41:46AM +0100, Greg KH wrote:
>> On Wed, Feb 28, 2024 at 10:45:32AM +0800, Rui Qi wrote:
>>> Since kernel version 5.4.217 LTS, there has been an issue with the kernel live patching feature becoming unavailable.
>>> When compiling the sample code for kernel live patching, the following message is displayed when enabled:
>>>
>>> livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
>>>
>>> Reproduction steps:
>>> 1.git checkout v5.4.269 -b v5.4.269
>>> 2.make defconfig
>>> 3. Set CONFIG_LIVEPATCH=y、CONFIG_SAMPLE_LIVEPATCH=m
>>> 4. make -j bzImage
>>> 5. make samples/livepatch/livepatch-sample.ko
>>> 6. qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage -nographic -append "console=ttyS0" -initrd initrd.img -m 1024M
>>> 7. insmod livepatch-sample.ko
>>>
>>> Kernel live patch cannot complete successfully.
>>>
>>> After some debugging, the immediate cause of the patch failure is an error in stack checking. The logs are as follows:
>>> [ 340.974853] livepatch: klp_check_stack: kworker/u256:0:23486 has an unreliable stack
>>> [ 340.974858] livepatch: klp_check_stack: kworker/u256:1:23487 has an unreliable stack
>>> [ 340.974863] livepatch: klp_check_stack: kworker/u256:2:23488 has an unreliable stack
>>> [ 340.974868] livepatch: klp_check_stack: kworker/u256:5:23489 has an unreliable stack
>>> [ 340.974872] livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
>>> ......
>>>
>>> BTW,if you use the v5.4.217 tag for testing, make sure to set CONFIG_RETPOLINE = y and CONFIG_LIVEPATCH = y, and other steps are consistent with v5.4.269
>>>
>>> After investigation, The problem is strongly related to the commit 8afd1c7da2b0 ("x86/speculation: Change FILL_RETURN_BUFFER to work with objtool"),
>>> which would cause incorrect ORC entries to be generated, and the v5.4.217 version can undo this commit to make kernel livepatch work normally.
>>> It is a back-ported upstream patch with some code adjustments,from the git log, the author also mentioned no intra-function call validation support.
>>>
>>> Based on commit 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b (Linux 5.4.269), This patchset adds stack validation support for intra-function calls,
>>> allowing the kernel live patching feature to work correctly.
>>>
>>> Alexandre Chartre (2):
>>>    objtool: is_fentry_call() crashes if call has no destination
>>>    objtool: Add support for intra-function calls
>>>
>>> Rui Qi (1):
>>>    x86/speculation: Support intra-function call validation
>>>
>>>   arch/x86/include/asm/nospec-branch.h          |  7 ++
>>>   include/linux/frame.h                         | 11 ++++
>>>   .../Documentation/stack-validation.txt        |  8 +++
>>>   tools/objtool/arch/x86/decode.c               |  6 ++
>>>   tools/objtool/check.c                         | 64 +++++++++++++++++--
>>>   5 files changed, 91 insertions(+), 5 deletions(-)
>>
>> All now queued up, thanks!
> 
> Nope, these break the build:
> 
> ../arch/x86/include/asm/nospec-branch.h:313: Error: no such instruction: `unwind_hint_empty'
> ../arch/x86/include/asm/nospec-branch.h:313: Error: no such instruction: `unwind_hint_empty'
> 
> How did you test them?  I'll go drop them from the queue now, sorry.
> Please fix them up and resend when you have something that works.
> 
> greg k-h

