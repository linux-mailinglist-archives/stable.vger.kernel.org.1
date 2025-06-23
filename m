Return-Path: <stable+bounces-156715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F97AE50D3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D691B62E23
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41842222CA;
	Mon, 23 Jun 2025 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI3RtqmW"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABC51EDA0F;
	Mon, 23 Jun 2025 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714091; cv=none; b=DLWqOtzi47QGhoqeiGO02jKFiky9eWDgBzr4rJW47ckRMgwPGItcMJeYW9AMHHTAlfUwaefuiJ9hBHRKg4FFSbt1mUmu14ATiC2hOLNILExN9SEZ3ycyft3b5P0D2/4FL5BNJ/c7UD35didu+mGptkV7LBPGSs4dn1bGDeb0jrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714091; c=relaxed/simple;
	bh=q+6mZDY66m9z8HN3uJ1Y6m6Uw15FIGzox4xTgErCUEE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PvZa1c1HogquEWSY3gkJKgkrstIVuA1vZtbvTl23Dyds9DXbT0yPLLQjRx6kzzGkczrp97MIE4cVWMSDpC/IEEJo4RuBoOrsuWMEhG/QFiw32fkEdAHtJzXde1q4+dQ3v/OF43o4VwDAcvAslaQ6bnMLGzyAByxfm0DLHMNdK4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NI3RtqmW; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3da73df6b6bso17432625ab.3;
        Mon, 23 Jun 2025 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750714089; x=1751318889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mmg3QjE2BdxChGIIWWePaatjao0EfwLXqcZXwwKYC+A=;
        b=NI3RtqmWCFS/rQ8cHZina+/+8zjnKKoX8HyMtImhqXiO8pMlSW8co96hK9rs6+Dhb2
         xyVfIftF1QZLFcHf6EuYzUzD9xpUE5cC5YcCQ/wxAd51TsTfhdqrrMCm1Ngze7raxvkf
         0rhJ7K5+1ly5QD/zOoXhQdC30hnCpP44Fy5pGk+KZaetSWuHODJngsUrAiif1dzM7Z/G
         4HzZqaNR81wEJ7ir5clZ1vYO+zKA2aF700EAY9Qzg5a4iMPJQm/QdkbUjFW9WqdZlZGj
         NAfHg3YcYqH+cmemHCj8aPTYU1sr2WcgoZFLF54HEy4gbEi9usYwmfLyuf8FTjpXrJvM
         cBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750714089; x=1751318889;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmg3QjE2BdxChGIIWWePaatjao0EfwLXqcZXwwKYC+A=;
        b=krZqM+pTd7gFlBkGFN4VjYGuLEiIsWDg09mTPFyqS5nDTI2OaL5/uH/CNunsOqpN1g
         45PlmOGo2VC7uU96XsCV4Ze4K31qXTs4kCPq6HwUnw0C4M694h9PGZli9Apsu21WAvOI
         125UVbXCsp7vDoFUmNxmYrm+CBlNJezt0bHM3yMQxXLCeaP4A083hAXGvvArgP1eqZrr
         ddmpkArJNwGRIYBw+iVscykQYLRh9O8OI+3iPxFxNucmXus+BDqykzF1NRIkbQIPoUao
         i3SLqRjzYjJ7VWcFR37VgGn769fjZ7KpxzS3teudVLooONFac+5U9LymYks9LsFu8gB2
         SeLg==
X-Forwarded-Encrypted: i=1; AJvYcCWEFEZPuWlpZY8yKYKHAP1EOAH0ABILEivjpBdTO6KLz0ubBnwObcKi1xRdr8JFG1XsoZ/qlhEF120=@vger.kernel.org, AJvYcCXo2efMQJUL05yW2aFsCKIHAFsaQfzDWeiRo5DBestI1uRbrJkwAViSb2YdIvTFk7wkU6PaVpld@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtfJbZh+OEIe/gOXFmvN953UMHxyQuOk0OljcPcplyxS/FQ5k
	l9RsFFM9dZMoadPMBIHTn5wzshJTOtx5HEG3YY4mzgRZCXe3vd9GtAJ4
X-Gm-Gg: ASbGncvJ+hlGnxYzv+lML5LnM0yJa42i5QDVifSnZuW4eSM6L2CnT8FHNIw8I2rHTx3
	xEBzrzK5x6saMRUgaERkcIRHJhSkk23kx54FeHPfZQtzZ7NgjLFPcR3omCtcA1l2uI4EcYIpgQ4
	cBaIZcJHG9bwSrcnMvtPcURShiTG/JEE2kI/4Xppc7J1WKcAbpBDI6Xg1oAhsIOyGvKI7GQkbpi
	M8OjbIKg6QUVndx4NIl5zPP7bJB9pwNdtGXP7S9g8u+keqrxBPJCOZGkzIRwlo9uqD/jPQwa0DG
	gS7W/Wi/n8Ur261yj4DvBWVMip+/XKWGkn6Js3Qwiy11W/riFNW11wmehINQ7Vo=
X-Google-Smtp-Source: AGHT+IGMp2D173TTSTMU8VIk4VqmO6g0lVUpD7nUPuZHAAmYTIqx3KZhAsGTNzEPrXH7ly3mDyftVQ==
X-Received: by 2002:a05:6e02:3b85:b0:3de:128d:15c4 with SMTP id e9e14a558f8ab-3de38609a32mr161505805ab.0.1750714088955;
        Mon, 23 Jun 2025 14:28:08 -0700 (PDT)
Received: from ?IPV6:2601:282:d00:94b1::174? ([2601:282:d00:94b1::174])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de37747762sm31687575ab.58.2025.06.23.14.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 14:28:08 -0700 (PDT)
Message-ID: <ef467aa9-6ec5-4917-966c-596640852c9a@gmail.com>
Date: Mon, 23 Jun 2025 15:28:05 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
From: Jeremy Lincicome <w0jrl1@gmail.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, regressions@lists.linux.dev,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 1108065@bugs.debian.org, stable@vger.kernel.org, net147@gmail.com
References: <aFW0ia8Jj4PQtFkS@eldamar.lan> <aFXCv50hth-mafOR@eldamar.lan>
 <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
 <aFmPQL3mzTag5OxY@eldamar.lan>
 <35be0df5-b769-43ce-a9c4-7df4d4683dab@gmail.com>
 <aFml-1X0-vItR2Au@eldamar.lan>
 <8f8671c5-fefb-494a-9cb6-0f6412566164@gmail.com>
Content-Language: en-US
In-Reply-To: <8f8671c5-fefb-494a-9cb6-0f6412566164@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/25 15:08, Jeremy Lincicome wrote:
> Hi,
>
> On 6/23/25 13:07, Salvatore Bonaccorso wrote:
>> Hi,
>>
>> On Mon, Jun 23, 2025 at 12:58:43PM -0600, Jeremy Lincicome wrote:
>>> On 6/23/25 11:30, Salvatore Bonaccorso wrote:
>>>> On Mon, Jun 23, 2025 at 05:13:38PM +0800, Shawn Lin wrote:
>>>>> + Jonathan Liu
>>>>>
>>>>> 在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
>>>>>> On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso 
>>>>>> wrote:
>>>>>>> Hi
>>>>>>>
>>>>>>> In Debian we got a regression report booting on a Lenovo IdeaPad 1
>>>>>>> 15ADA7 dropping finally into the initramfs shell after updating 
>>>>>>> from
>>>>>>> 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
>>>>>>> shell:
>>>>>>>
>>>>>>> mmc1: mmc_select_hs400 failed, error -110
>>>>>>> mmc1: error -110 whilst initialising MMC card
>>>>>>>
>>>>>>> The original report is athttps://bugs.debian.org/1107979 and the
>>>>>>> reporter tested as well kernel up to 6.15.3 which still fails to 
>>>>>>> boot.
>>>>>>>
>>>>>>> Another similar report landed with after the same version update as
>>>>>>> https://bugs.debian.org/1107979 .
>>>>>>>
>>>>>>> I only see three commits touching drivers/mmc between
>>>>>>> 6.12.30..6.12.32:
>>>>>>>
>>>>>>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing 
>>>>>>> parameters")
>>>>>>> 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
>>>>>>> 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power 
>>>>>>> off")
>>>>>>>
>>>>>>> I have found a potential similar issue reported in ArchLinux at
>>>>>>> https://bbs.archlinux.org/viewtopic.php?id=306024
>>>>>>>
>>>>>>> I have asked if we can get more information out of the boot, but 
>>>>>>> maybe
>>>>>>> this regression report already rings  bell for you?
>>>>> Jonathan reported a similar failure regarding to hs400 on RK3399
>>>>> platform.
>>>>> https://lkml.org/lkml/2025/6/19/145
>>>>>
>>>>> Maybe you could try to revert :
>>>>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing
>>>>> parameters")
>>>> Thanks.
>>>>
>>>> Jeremy, could you test the (unofficial!) packages at
>>>> https://people.debian.org/~carnil/tmp/linux/1108065/ which consist of
>>>> 6.12.33-1 with the revert patch applied on top?
>>>>
>>>> I have put a sha256sum file and signed it with my key in the Debian
>>>> keyring for verification.
>>> Do I need all those packages?
>> Just the linux-image-6.12+unreleased-amd64-unsigned package to test
>> the patched kernel image and modules.
>
> I installed the package, and this is as far as I got.
> <https://share.bemyeyes.com/chat/oJcrv3N22q>
> for anyone who doesn't know, the above link is from Be My Eyes, an app 
> that allows me to read information not available with a screen reader 
> like Orca.
> I'm blind, and unable to read the Grub menu independently.
> I ran a bash script to extract the menu number for that kernel, then 
> ran grub-reboot to try and boot it on the next reboot.
> As far as I can tell, the system is trying to boot,but fails and 
> returns to Grub. Am I doing something wrong?

For those of you who got my last message twice, I apologize. Some of the 
lists rejected it for having html.

-- 
Sincerely,
Jeremy Lincicome W0JRL
JL Applied Technologies:
https://jlappliedtechnologies.com
SkyHubLink System:
https://skyhublink.com


