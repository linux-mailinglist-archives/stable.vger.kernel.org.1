Return-Path: <stable+bounces-156224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36669AE4EB1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A228517C81F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F5270838;
	Mon, 23 Jun 2025 21:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USOT2cUm"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75E1ACEDA;
	Mon, 23 Jun 2025 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712887; cv=none; b=uGs5cv+u4WFvmfzHT0FuDLY9k/599N1pSnbYUrV371B8zDVC0rGXOTQIe1ku8snwn0kKLre+1shtE/wTageIcPLxC52B+oMEdqDZpzgbGRokEYy3H39fa31xnWPoUViWT+sDnKNMywOydm6yrhEcrd4Tj+Mu7dQS/9QtiNPU1mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712887; c=relaxed/simple;
	bh=9SEX81/ylUn0qfNAFFdpR6eIuqkOvq2GMYGbijhsiwo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AjDJYWF8SiU+folfkMLqp+cSGbQy353Npw/cbqa7pNeNDcDTKYrd0MHoOTrkcquEQbZKUUeE5Q7LnLWDnHn1jQYseigemwU1IoExnlfD2jPcnqmbuxbXAJIn2fxpd2of+LimJxqldGCWQAzH/8IO79hxetVhqBdApcmW89vGB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USOT2cUm; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3dda399db09so45012855ab.3;
        Mon, 23 Jun 2025 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750712885; x=1751317685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvIGbgnG8gqohHLn+bw11uzo7U+PqrhPy5zMTSxuqJ4=;
        b=USOT2cUmty+C5RYFostSgy5OWHD4yuWqeJhxhSMUjy0difSCigqAGCAVoaU+Gjo88v
         L4ee++u7NH7Zggw/MirDg1iBlgS3AcqVHxk61nb1j/+ZZSyGG7viRLp4t5iHPtD85cYT
         7Dxzx4SnUiMc1Xjq/Bexu+a2qN+QXDO4+pCtILLYuHsItmxGlKRdg5OaL3UgG9U8QY5h
         8Cz32ToaHy7wAIwYOz84GJH5SsVVwgJvxqBvzrEjs/QOELSCIAnRCKlid4O9HH05WDHh
         qJXBJMjdrvj4pCx+auKFEVfiTW51YqTOlpAkRwVdCr1i0RiylFGZIglpR8eknZWw3u5M
         oTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750712885; x=1751317685;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvIGbgnG8gqohHLn+bw11uzo7U+PqrhPy5zMTSxuqJ4=;
        b=jXSUZXFdJwm/hQm+SngHw8vH1yKvPTDldDoWzmf8hGCepxeVe+tUQleBYx4r8asn6q
         4A0XH2lYM8IjVjkB2NX9sbU/R0kCEZwvHC6JZDhRZccnNIDmGhgFMo4LiJbjOmITsM4p
         FebMG3pNNtsjbN0oBZkg/TkxxVJLG4pt9kinT4VVBjy/DaCzIQMxhLFeoxvfVC8tj229
         +sveiyVoBdvqIzwfYtA/bwf4hp2QnF1mOgFjh5tC+NBVI3RgCMlB0jU/xQPyk4StJrSU
         KcTFDLPA/4sXG7VthgnLjZwdBgIVwL3NjkGSr5Gbdj7xuGbMiehp9IPhr0BjrwdNPe9s
         brag==
X-Forwarded-Encrypted: i=1; AJvYcCUUBhrxBFec0i6KYXu5GJeROUmrSpBge7nl1+n0p6CIB/cwpECP6NGMFqhfihyafeZO5Dj/fyfE@vger.kernel.org, AJvYcCXtucwqdyNp5Q0xNOrYrj1fjcJ8JB0bT/UuKSb1zmVfR3D+Bt97pstb419lcZ7ewRTRFAt0gO7Yd18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6L3qaYYZa5Ow0K80wAk5s+IpXLL7qFFVJ4FCnXVK5j6TxmS1g
	/+8jAnuM6Hu2rbLDA2SU09IFApa9MKqAIpzuuY/huu7MUu9SU3bfzn3M
X-Gm-Gg: ASbGnctgtLMb7GtOflSzfQbxPPGUmQ6VYaTLP8cXNB8gE/1LjMeJ7lY9w+/KMfHXWqS
	FR3dbZ9ZXY34loYpH2LYaEUfpX+qRp0+CJ6oRzM1y1Je8nDzqesc7pofpR9P5IKFIKx/7WmIEcy
	EWM+Ne5VypMWi5SOBA2snl+WdSW4yakxfssUz7TQoUeUflsshEEwekcLlVKDHklvqhphSJGvpXh
	RW6mlSKHjrEg1tryZ3zWjhIadHH4MDalv4vv3BzY/J9NDnPcc7xxyk6qka3jeEtji/N2Mq3cS55
	hu58DTfp6feutoyaeH3hHcdc8JAKmrWBf2/jxmBug0fBfxs9ABaEEU+YTO1n6wM=
X-Google-Smtp-Source: AGHT+IGRBdyLzCtH0If0pGKqpe67dK6rtKBkWqYMo6tX7Tr29R+4oTCD4GFcLwpwfjNnogH+REegBw==
X-Received: by 2002:a05:6e02:2705:b0:3de:25cb:42cc with SMTP id e9e14a558f8ab-3de38ca4f27mr142485925ab.10.1750712885171;
        Mon, 23 Jun 2025 14:08:05 -0700 (PDT)
Received: from ?IPV6:2601:282:d00:94b1::174? ([2601:282:d00:94b1::174])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de376271e0sm32486005ab.21.2025.06.23.14.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 14:08:04 -0700 (PDT)
Message-ID: <8f8671c5-fefb-494a-9cb6-0f6412566164@gmail.com>
Date: Mon, 23 Jun 2025 15:08:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jeremy Lincicome <w0jrl1@gmail.com>
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, regressions@lists.linux.dev,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 1108065@bugs.debian.org, stable@vger.kernel.org, net147@gmail.com
References: <aFW0ia8Jj4PQtFkS@eldamar.lan> <aFXCv50hth-mafOR@eldamar.lan>
 <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
 <aFmPQL3mzTag5OxY@eldamar.lan>
 <35be0df5-b769-43ce-a9c4-7df4d4683dab@gmail.com>
 <aFml-1X0-vItR2Au@eldamar.lan>
Content-Language: en-US
In-Reply-To: <aFml-1X0-vItR2Au@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 6/23/25 13:07, Salvatore Bonaccorso wrote:
> Hi,
>
> On Mon, Jun 23, 2025 at 12:58:43PM -0600, Jeremy Lincicome wrote:
>> On 6/23/25 11:30, Salvatore Bonaccorso wrote:
>>> On Mon, Jun 23, 2025 at 05:13:38PM +0800, Shawn Lin wrote:
>>>> + Jonathan Liu
>>>>
>>>> 在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
>>>>> On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
>>>>>> Hi
>>>>>>
>>>>>> In Debian we got a regression report booting on a Lenovo IdeaPad 1
>>>>>> 15ADA7 dropping finally into the initramfs shell after updating from
>>>>>> 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
>>>>>> shell:
>>>>>>
>>>>>> mmc1: mmc_select_hs400 failed, error -110
>>>>>> mmc1: error -110 whilst initialising MMC card
>>>>>>
>>>>>> The original report is athttps://bugs.debian.org/1107979 and the
>>>>>> reporter tested as well kernel up to 6.15.3 which still fails to boot.
>>>>>>
>>>>>> Another similar report landed with after the same version update as
>>>>>> https://bugs.debian.org/1107979 .
>>>>>>
>>>>>> I only see three commits touching drivers/mmc between
>>>>>> 6.12.30..6.12.32:
>>>>>>
>>>>>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
>>>>>> 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
>>>>>> 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
>>>>>>
>>>>>> I have found a potential similar issue reported in ArchLinux at
>>>>>> https://bbs.archlinux.org/viewtopic.php?id=306024
>>>>>>
>>>>>> I have asked if we can get more information out of the boot, but maybe
>>>>>> this regression report already rings  bell for you?
>>>> Jonathan reported a similar failure regarding to hs400 on RK3399
>>>> platform.
>>>> https://lkml.org/lkml/2025/6/19/145
>>>>
>>>> Maybe you could try to revert :
>>>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing
>>>> parameters")
>>> Thanks.
>>>
>>> Jeremy, could you test the (unofficial!) packages at
>>> https://people.debian.org/~carnil/tmp/linux/1108065/ which consist of
>>> 6.12.33-1 with the revert patch applied on top?
>>>
>>> I have put a sha256sum file and signed it with my key in the Debian
>>> keyring for verification.
>> Do I need all those packages?
> Just the linux-image-6.12+unreleased-amd64-unsigned package to test
> the patched kernel image and modules.

I installed the package, and this is as far as I got.
<https://share.bemyeyes.com/chat/oJcrv3N22q>
for anyone who doesn't know, the above link is from Be My Eyes, an app 
that allows me to read information not available with a screen reader 
like Orca.
I'm blind, and unable to read the Grub menu independently.
I ran a bash script to extract the menu number for that kernel, then ran 
grub-reboot to try and boot it on the next reboot.
As far as I can tell, the system is trying to boot,but fails and returns 
to Grub. Am I doing something wrong?

-- 
Sincerely,
Jeremy Lincicome W0JRL
JL Applied Technologies:
https://jlappliedtechnologies.com
SkyHubLink System:
https://skyhublink.com


