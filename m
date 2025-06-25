Return-Path: <stable+bounces-158480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AADAE758D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 05:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2231BC074C
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 03:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE901DF246;
	Wed, 25 Jun 2025 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKhe1bji"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE71DB122;
	Wed, 25 Jun 2025 03:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750823751; cv=none; b=CB+DxeqT1pJ2CDBcLE2YZhwoonVQsh1IdF+OkNoLlpsdphD7uI5WjVIMOjS5wTeIA/7J9zFEZQDOXuJmpRObyWfyRFbJpqjkbLVCfjkoFwiCMTjXeviWF1y7CpJjZj3SSV4iQrpvcfSp6dX4gYXv6MjYazU8o/SfnBqC9ROB/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750823751; c=relaxed/simple;
	bh=M8HH45Sj8ttJXgcpCkJO8qkeo5a7N+Cjw/sh54F3uK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TccliQNQR8r4upjxgl/xxAZsDSN1S7fyHTV9XR45INVBFA177ukDa4KntQdvdaDbsnX1VpV+MCmYRafbQfZrQyY15+IpRyYYAkS+Jv3UGQYz7TW5YhTRgHQfxcMgCSl8BpOuKKE5B+lW75LoA5GHoqoWPNdCLHfo/myBJNg/9Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKhe1bji; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-86cdb330b48so95511839f.0;
        Tue, 24 Jun 2025 20:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750823749; x=1751428549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M8HH45Sj8ttJXgcpCkJO8qkeo5a7N+Cjw/sh54F3uK0=;
        b=XKhe1bjil62/ESIlF1NuKvPD6hP4AZjO+HmWP5+37n5Q1y1pFmpmwybeZ0FmVTVswH
         bYGzfHI71oUeLAEgYetZ0CAnBztVpCmOgyzt+DydQZ4O0ZEz3Ai8G6AueQgtV4/4LPXs
         sY3xMn2RSE1kys32JlZ17aeluRlQfrzLBms24y48rD5tToIYSXrH0E7gZOvvopO7YdqT
         jzczDLGjD7O8L2s89w7Zn7zlcbJnT6jpeYqwOjPopIihgBLr+0Sd5IP8Qs0ElyZKl24W
         g0I8fn/wf6NydTwy9Eyo86TDJZ5eI8vf8OW6CYbDkc0CdsnE3XhVi6LUqgo5yzlTFwzJ
         jXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750823749; x=1751428549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8HH45Sj8ttJXgcpCkJO8qkeo5a7N+Cjw/sh54F3uK0=;
        b=tGS/msGHuwMMoY5eBQkFFyU+TaNVmPpexFQNzONIu4xBc/vuIB3mPcu3VkMXJa/cA6
         /gP1cxQoy3/N2aglMYiE7C6/RfhNU8Xf2Nh4u/YRYx/rHTEQ6DTgeSrzSckNKc1RT28R
         SL4vwfu6muqwCbhGaIuUBppw+f7/39wg9deU4vNY5Y+uBftwydi1XeVw6dDmJEcqrkUz
         R5d6yOE8/R9ViSQwGNXISfDKXnGD2TxM3qG42pcEKciJr9emZtuYhOG+OyGOC2W8nEWL
         qWN+m4kzaU+B3u+iuewvCdUz8Z8VmrW6CAA+54Doi7uMmOeHZ29sKbi1AaH8IKM95NzH
         jdMw==
X-Forwarded-Encrypted: i=1; AJvYcCU+3Sze96DG8qrwt65YZTfsb0vw16w0m9edDnZK0u9rj8nEgeSI008jKqgl9gQuDvcCWg8ACAub@vger.kernel.org, AJvYcCVyfB730IHePUxioXWwPI522Omg4RKyKCk6v8t++3xqPScLvlhj23JyTtfkHKiAkCLyL6G5YI8eVA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4bW/nT8anCiBZjUyuk9ckydzH0SceI5pG5i++tjXB6QMS4cG
	szkHbJdfelOzN3v+MeakpL4zJ+wmVmjmAIyp/KT5s784+zAcSHqXySh5
X-Gm-Gg: ASbGncvyWoi7O56amM+NgbYGi44YCb17eZ2mWipce4h8jVmeXROvrDdwDTr355MXaFk
	6dYzxsh8VIPC4HDP8Ik0WXJwQRkfycylHM2fBocgA5/OYMQg/S9j2iaT4Bpzrxs6xTD6GPsl0BS
	R5inUdQaeROtOS1Nkx1yalJy/0hty5jrRgX266wqrXkZX7c4MNPo/b/I7VfCE8iru8WhVjKb8Du
	+57XXpqq0kiwyVXPGwFOINIw61so+JP7qQB4P8VUT0xZoIEAJ13F6VtQDgzkhdLNAHmwPSUA9Zj
	ATc/GlD3sDaaHV0v0rFotzUDXdQ5LZeVtt/NHbru9zJKpTcQDoQ9HumJjxVhYRE=
X-Google-Smtp-Source: AGHT+IH+z2bfJeFldTfIUQ1vbcD2anaS+bwA1NXDCxlSwUwYi4lfwisL9U5rWue8kaIlIPsq3gse7w==
X-Received: by 2002:a6b:4415:0:b0:867:17a6:9fd2 with SMTP id ca18e2360f4ac-8766c0ce0ebmr200635539f.9.1750823748666;
        Tue, 24 Jun 2025 20:55:48 -0700 (PDT)
Received: from ?IPV6:2601:282:d00:94b1::174? ([2601:282:d00:94b1::174])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8762b5ee941sm342550139f.16.2025.06.24.20.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 20:55:47 -0700 (PDT)
Message-ID: <13d0d076-b234-4778-98a6-aa439a351788@gmail.com>
Date: Tue, 24 Jun 2025 21:55:44 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
To: Salvatore Bonaccorso <carnil@debian.org>,
 Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, regressions@lists.linux.dev,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 1108065@bugs.debian.org, stable@vger.kernel.org, net147@gmail.com
References: <aFW0ia8Jj4PQtFkS@eldamar.lan> <aFXCv50hth-mafOR@eldamar.lan>
 <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
 <65400f7d-0bfc-4b0c-8edc-c00d3527c12b@intel.com>
 <aFtvlqPxO6eZkhfF@eldamar.lan>
Content-Language: en-US
From: Jeremy Lincicome <w0jrl1@gmail.com>
In-Reply-To: <aFtvlqPxO6eZkhfF@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/25 21:40, Salvatore Bonaccorso wrote:
> Hi,
>
> On Tue, Jun 24, 2025 at 11:26:41AM +0300, Adrian Hunter wrote:
>> On 23/06/2025 12:13, Shawn Lin wrote:
>>> + Jonathan Liu
>>>
>>> 在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
>>>> On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
>>>>> Hi
>>>>>
>>>>> In Debian we got a regression report booting on a Lenovo IdeaPad 1
>>>>> 15ADA7 dropping finally into the initramfs shell after updating from
>>>>> 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
>>>>> shell:
>>>>>
>>>>> mmc1: mmc_select_hs400 failed, error -110
>>>>> mmc1: error -110 whilst initialising MMC card
>>>>>
>>>>> The original report is at https://bugs.debian.org/1107979 and the
>>>>> reporter tested as well kernel up to 6.15.3 which still fails to boot.
>>>>>
>>>>> Another similar report landed with after the same version update as
>>>>> https://bugs.debian.org/1107979 .
>>>>>
>>>>> I only see three commits touching drivers/mmc between
>>>>> 6.12.30..6.12.32:
>>>>>
>>>>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
>>>>> 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
>>>>> 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
>>>>>
>>>>> I have found a potential similar issue reported in ArchLinux at
>>>>> https://bbs.archlinux.org/viewtopic.php?id=306024
>>>>>
>>>>> I have asked if we can get more information out of the boot, but maybe
>>>>> this regression report already rings  bell for you?
>>> Jonathan reported a similar failure regarding to hs400 on RK3399
>>> platform.
>>> https://lkml.org/lkml/2025/6/19/145
>>>
>>> Maybe you could try to revert :
>>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
>> Given the number of other reports, probably best to revert
>> anyway.
> FTR, Jeremy Lincicome confirmed that reverting the commit fixes the
> issue for him as reported in Debian bug #1108065.

I confirm that reverting the commit fixes

Debian bug #1108065.

Tested-by: Jeremy Lincicome<w0jrl1@gmail.com>


