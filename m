Return-Path: <stable+bounces-43070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E98BC064
	for <lists+stable@lfdr.de>; Sun,  5 May 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54397281F4C
	for <lists+stable@lfdr.de>; Sun,  5 May 2024 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1148B14A84;
	Sun,  5 May 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH006p9c"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD7657C9A;
	Sun,  5 May 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714912632; cv=none; b=Hwa6xnEsH2puCgoqZb9nUZTSsDH3qKbYatoHJP41oEtEhFQokT7cMCUlEuxaakYWGwSZMxGgqKD2hOuGlBnC7QAq3QR1qtjPFemhO3FM7Nr+fiU7+inhrrG2yEO9h+Voy5OOD0LIjwyk5sWcis1U3f8ejmxEkXrbbWQFr2QZQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714912632; c=relaxed/simple;
	bh=zDpolQWfbcUK7TyiyiEtd0WxsaMTnXf/81eP72pe0Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXztAqRq1koD1t0HnEjE+QGQYAiNXfnxHvzeia73wvEnQ0R9S/8QsJ0XcMdygjmWkLQz+uc07haQCeuvwB2uaiLsExHP8UvAmWaYqX4n5rWqW2emgYVLn6eO4lP7RFQiSVcOfx68+2OAcgO4Gsxej9YBHcaQy5dmXfpDWVdwF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH006p9c; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6f04f01f29aso185999a34.0;
        Sun, 05 May 2024 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714912630; x=1715517430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7UNaT1dFoDbZk1Tb2yzB1trkO0W5vpyMHkgqY156n0=;
        b=JH006p9c7URMROm3EAHfDeQInPBK0lW6D1Vynbyeg3Kol1FQxkcN1zvGakcXJhHwSj
         FvD0C6yVT3gqTJcPPZvdMZQjE5nX6L0ETkm2Qu4/vGhuiDJtI8XWEwLTJ1dGE1T7qD7Z
         EdMQonnNOS7+ENi464Skhl3hJIoNfSqhY2Ig6027LsDGQNzadSYnRENp3zpg1YzDHPSj
         cVAVYkzziTGat/E0DkERbguD7sno8unnaDRs6Gq7EJsPTDu4MgUfB4jdpANWuBySIerF
         iTgW5pj1XxkLpZJDFVzhwfsObi1PxzUCUH/vlum3CZQsZLWqL8bf0npwJ/zG2X+voCDw
         v9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714912630; x=1715517430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7UNaT1dFoDbZk1Tb2yzB1trkO0W5vpyMHkgqY156n0=;
        b=nxJDa7TAjIrhIYKWd2m5U1/XhR5h7ElVeVqNh8aCAZa9M0Je1vWlTbhstNLit064eZ
         oD+9zWaDIRmSsvPS0NZ7isDRLX9NPBzk6LGGWhqiUwVm8MYjPbWO6eZ0ezeYy4UkK60R
         RiMuxI+kcHBztMipgKm3hiZNQF1V8Lan+SqcEBKtuojJxeJENojbEe+0nHJuAo7tzV9G
         QjMeVsG3m+dnAlgeVBZWn4lBp4SOmpzforLuyIKKU7cuCAEzIx6OdCB3i+ROgv27kptJ
         Fl7olu+/jTHwL8k+tVe4ytym+Gl0R/I9GicLsdOwHSMVtK/aDNQuk8b0L/5giXvuRu8B
         8lYw==
X-Forwarded-Encrypted: i=1; AJvYcCWKjUi0Y0I6KWLfXtLQxQogp6n4YfE7dJZ5FIfcfghyYs94yGwaqCPFELRNTK/7L4VmdkAkWcqyMLTqSY6G4homA3dZ2ex4HgCFp6da
X-Gm-Message-State: AOJu0YwgTUE0eqs4/7VXzP8innd1Wl1vzekJxHxdfvTc3ULvisbiBinr
	GlngXxn5C+xzp7otbhHolvnq3wU0S8G7QZpTpDZqaZ1ba7UMEpBF
X-Google-Smtp-Source: AGHT+IGmeBFls7M1T2mDkcdo593tJ529+B6AdsEDseoNn6Uj4zHGCr/ZveECxUPEZJG73iGmf+Ajag==
X-Received: by 2002:a05:6830:144a:b0:6ee:4ecc:3c39 with SMTP id w10-20020a056830144a00b006ee4ecc3c39mr8998993otp.25.1714912630187;
        Sun, 05 May 2024 05:37:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f700:3634:a35:99df:3386? ([2600:1700:70:f700:3634:a35:99df:3386])
        by smtp.gmail.com with ESMTPSA id cv7-20020a056830688700b006ee377bd3aesm1478999otb.44.2024.05.05.05.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 05:37:09 -0700 (PDT)
Message-ID: <1eb96465-0a81-4187-b8e7-607d85617d5f@gmail.com>
Date: Sun, 5 May 2024 07:37:09 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Micha Albert <kernel@micha.zone>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <wL3vtEh_zTQSCqS6d5YCJReErDDy_dw-dW5L9TSpp9VFDVHfkSN8lNo8i1ZVUD9NU-eIvF2M84nhfdt2O7spGu2Nv5-oz9FLohYO7SuJzWQ=@micha.zone>
 <3f1f55cb-d8df-4834-b22f-c195d161cab5@leemhuis.info>
Content-Language: en-US
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <3f1f55cb-d8df-4834-b22f-c195d161cab5@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/4/24 23:59, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing Mario, who asked for the two suspected commits to be backported]
> 
> On 05.05.24 03:12, Micha Albert wrote:
>>
>>      I have an AMD Radeon 6600 XT GPU in a cheap Thunderbolt eGPU board.
>> In 6.8.7, this works as expected, and my Plymouth screen (including the
>> LUKS password prompt) shows on my 2 monitors connected to the GPU as
>> well as my main laptop screen. Upon entering the password, I'm put into
>> userspace as expected. However, upon upgrading to 6.8.8, I will be
>> greeted with the regular password prompt, but after entering my password
>> and waiting for it to be accepted, my eGPU will reset and not function.
>> I can tell that it resets since I can hear the click of my ATX power
>> supply turning off and on again, and the status LED of the eGPU board
>> goes from green to blue and back to green, all in less than a second.
>>
>>     I talked to a friend, and we found out that the kernel parameter
>> thunderbolt.host_reset=false fixes the issue. He also thinks that
>> commits cc4c94 (59a54c upstream) and 11371c (ec8162 upstream) look
>> suspicious. I've attached the output of dmesg when the error was
>> occurring, since I'm still able to use my laptop normally when this
>> happens, just not with my eGPU and its connected displays.
> 
> Thx for the report. Could you please test if 6.9-rc6 (or a later
> snapshot; or -rc7, which should be out in about ~18 hours) is affected
> as well? That would be really important to know.
> 
> It would also be great if you could try reverting the two patches you
> mentioned and see if they are really what's causing this. There iirc are
> two more; maybe you might need to revert some or all of them in the
> order they were applied.

There are two other things that I think would be good to understand this 
issue.

1) Is it related to trusted devices handling?

You can try to apply it both to 6.8.y or to 6.9-rc.

https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=iommu/fixes&id=0f91d0795741c12cee200667648669a91b568735

2) Is it because you have amdgpu in your initramfs but not thunderbolt?

If so; there's very likely an ordering issue.

[    2.325788] [drm] GPU posting now...
[   30.360701] ACPI: bus type thunderbolt registered

Can you remove amdgpu from your initramfs and wait for it to startup 
after you pivot rootfs?  Does this still happen?

> 
> Ciao, Thorsten
> 
> P.s.: To be sure the issue doesn't fall through the cracks unnoticed,
> I'm adding it to regzbot, the Linux kernel regression tracking bot:
> 
> #regzbot ^introduced v6.8.7..v6.8.8
> #regzbot title thunderbolt: eGPU disconnected during boot
> 

