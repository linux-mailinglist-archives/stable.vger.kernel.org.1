Return-Path: <stable+bounces-156155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC20AAE4D37
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 20:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B23F17BB0B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 18:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A7A2D3A91;
	Mon, 23 Jun 2025 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrjamc8q"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769C275B18;
	Mon, 23 Jun 2025 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705130; cv=none; b=uGgnJ3doXW0WynFiKdB06txLjqPv3NXZwmbNKl6tfKH3tuSuSa7zk2aa02J4UbbOyvH3tIV3+yW1Dj2i1nn6JRznkp5hl2HzWB5gAJ4g7v2/WYGgGVjTLgJ0L+JwVlyu9TbClAJWYE6ezqB2jtSW8TDzXkZML4kP2/s0wzlUfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705130; c=relaxed/simple;
	bh=rhADofRa7O4H0skYApDvI203y7IyE8m8fYDqZM8dcGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFcU4BPksdCinOY1F3i8C4ExTGJmwvAvMtIxUJNN03cOa/aulmT5BFsdt+0gbkBbVstom4jSHYBO1FRAUzrI/vBI/VMdM6iCSOrn8RHDZATwXq7ya3U2KWI01TFrhhBdSv8OGp6FpPVwHtlVBnfVT4A6m23KINQPtfA3Nwi34c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrjamc8q; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dc9e7d10bdso14728745ab.2;
        Mon, 23 Jun 2025 11:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750705128; x=1751309928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MP4/EwOfYKCDCUoXktdSHMft9I2G71yNGwbmuuIqBcU=;
        b=hrjamc8qImkKC9/SJKdrpoufP3JHjOrF00ASNz9R6QhNKZPdGPOPAOb0jzYwrA3i3R
         m48NRgfntCkhmYtptPdnY3wz/N5d6ZNer5NAmWZFSQlvelLyszhtdMaF/4Doa0Ye4qm1
         PCK2AkKEfiDHM4jS1xUqHe+MgSW3ncab0YrIe+0mC3CpzYi4VZ0EZ0qr90dcXE9xmSup
         2Vnu0tfPRE3Iw79W/XCE9V3ot4pJNyqz+lqUQeh8w6Lqt6ri3NB4rYkqO2MJrshPJXUC
         zmvsyx5gby+a44IOs02sHDaLprrX+n02Csv/Ys+g5OE6LPEMKp/1pW/WsDo77Xl6O/Rf
         IA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750705128; x=1751309928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MP4/EwOfYKCDCUoXktdSHMft9I2G71yNGwbmuuIqBcU=;
        b=cGPCbntqxCFDSoQt5fpFGrjkcpnPXndYuRQxWmgtoT7r+D3ySsIX//hCUAYEJyhe0W
         xFkGEgiuTlyCWV9CwwXVBYTIwX2k2OISXOYhyqSxUIE2SXrOAr5NImMJD6o0cv3oN8h9
         HWNQeKS4JZUQMHwItiFSPkFNW7A5wgoTsxYrKj90iBitKUZCmIyPe+FmaSkjs6oElMs2
         BxfbpnQRUK+aI1ntbClSukOGwPWJaR4i/rdqSAVn2JH1ZxRQXCMjXScHWbqnQ5bJq9ua
         Pc9zQWNvQcSuu0GLcu02GloE+uOsOxv774XhBXAEJQCYflx8JWc4t1MO8WXlwaxE+Ipe
         Tbyg==
X-Forwarded-Encrypted: i=1; AJvYcCXLJPWf/Uia9vJmT39UzPZqGV8sMcXkl3L6NO7whrt0M0xs6xWIKlVJmoVpbiPIhLWncmoTKY/N9a0=@vger.kernel.org, AJvYcCXORj5BEeFiBzwxSeigJMGPxaUGnNXkIcAXDiY6av2YOof4sIVwHdPhP2mSOLyz0K0SumdVzJ63@vger.kernel.org
X-Gm-Message-State: AOJu0YwB+HQLzLIPH4x5ibEoEm0+mLAGyMGbW234lGM+4ijPt/CvmFAf
	9OU8GBdigbttWrihjfjYl5ujPu6acmLIkhieR2jGA+hvaupM2nxgy7py
X-Gm-Gg: ASbGnctZ6rdhicmE2O9K+7EfL09plJgHGQvwYOYvnb8oEE8fOFIrMuSXQ0zd4mxRauF
	VBognYUBR1lPZvkD8hUu3pFiQB5WgqXbChPWd14Mr9fzxPhkX09ojAtMwIVTIeWPkq2O9VgJhev
	P/WBV8yOfdrPVqqnCCJkKei4pZkO1r63HpO95UrYXF3QweewEa6oP9dCgKUV/dIF3ZZDyl+i0Bp
	Ki5FHrLevN+tbjyBdxUo568eU4iFfIEXMQqbpeerK4LnP5WvfLRFC86Ch6iptTz+HKgV3Z3rx30
	xuDQMdJVVkCL3dxA8/DyDA/9TuKghK878UYrFkqQ1gyFyzaJCZstI0G6p9nnBOU=
X-Google-Smtp-Source: AGHT+IGq7SQj5SmZz8Hpl6EooXTFSR/8w2FZsjF+64YhQ7iJGzlMjuOg5izaDG7IguL2UhJYems0CA==
X-Received: by 2002:a05:6e02:318f:b0:3dd:892d:b25e with SMTP id e9e14a558f8ab-3de38cc300cmr153205025ab.22.1750705127477;
        Mon, 23 Jun 2025 11:58:47 -0700 (PDT)
Received: from ?IPV6:2601:282:d00:94b1::174? ([2601:282:d00:94b1::174])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3df103bf07esm19200985ab.62.2025.06.23.11.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 11:58:46 -0700 (PDT)
Message-ID: <35be0df5-b769-43ce-a9c4-7df4d4683dab@gmail.com>
Date: Mon, 23 Jun 2025 12:58:43 -0600
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
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: regressions@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-mmc@vger.kernel.org, 1108065@bugs.debian.org, stable@vger.kernel.org,
 net147@gmail.com
References: <aFW0ia8Jj4PQtFkS@eldamar.lan> <aFXCv50hth-mafOR@eldamar.lan>
 <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
 <aFmPQL3mzTag5OxY@eldamar.lan>
Content-Language: en-US
From: Jeremy Lincicome <w0jrl1@gmail.com>
In-Reply-To: <aFmPQL3mzTag5OxY@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/25 11:30, Salvatore Bonaccorso wrote:
> On Mon, Jun 23, 2025 at 05:13:38PM +0800, Shawn Lin wrote:
>> + Jonathan Liu
>>
>> 在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
>>> On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
>>>> Hi
>>>>
>>>> In Debian we got a regression report booting on a Lenovo IdeaPad 1
>>>> 15ADA7 dropping finally into the initramfs shell after updating from
>>>> 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
>>>> shell:
>>>>
>>>> mmc1: mmc_select_hs400 failed, error -110
>>>> mmc1: error -110 whilst initialising MMC card
>>>>
>>>> The original report is at https://bugs.debian.org/1107979 and the
>>>> reporter tested as well kernel up to 6.15.3 which still fails to boot.
>>>>
>>>> Another similar report landed with after the same version update as
>>>> https://bugs.debian.org/1107979 .
>>>>
>>>> I only see three commits touching drivers/mmc between
>>>> 6.12.30..6.12.32:
>>>>
>>>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
>>>> 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
>>>> 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
>>>>
>>>> I have found a potential similar issue reported in ArchLinux at
>>>> https://bbs.archlinux.org/viewtopic.php?id=306024
>>>>
>>>> I have asked if we can get more information out of the boot, but maybe
>>>> this regression report already rings  bell for you?
>> Jonathan reported a similar failure regarding to hs400 on RK3399
>> platform.
>> https://lkml.org/lkml/2025/6/19/145
>>
>> Maybe you could try to revert :
>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing
>> parameters")
> Thanks.
>
> Jeremy, could you test the (unofficial!) packages at
> https://people.debian.org/~carnil/tmp/linux/1108065/ which consist of
> 6.12.33-1 with the revert patch applied on top?
>
> I have put a sha256sum file and signed it with my key in the Debian
> keyring for verification.

Do I need all those packages?

-- 
Sincerely,
Jeremy Lincicome W0JRL
JL Applied Technologies:
https://jlappliedtechnologies.com
SkyHubLink System:
https://skyhublink.com


