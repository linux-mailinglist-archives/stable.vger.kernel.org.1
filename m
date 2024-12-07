Return-Path: <stable+bounces-100051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE93E9E824F
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F9B165ED1
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 21:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF214F9CC;
	Sat,  7 Dec 2024 21:34:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435D0D27E;
	Sat,  7 Dec 2024 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733607281; cv=none; b=W8pBJGDLUkqooUnyKxSGRzCBSQf0clStBget8RfXyffx5RIgDHWjqFMyGMQTi3nLQme7r88fLbWTkpCU/DrEZmtewKBQOsHA8fP5WwScMInkbKw73g34dIeIC2zsXp5k+qVWp48rd/xOegK3M+aAVuZoRnKrCMGo5OXT3HSzjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733607281; c=relaxed/simple;
	bh=Glg67YFBv7gXpUn7D881The/wTomsWbvNSc6lIBii4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sow9wPcgDpf/SCSWgLGcfmhu0PNKEfqwLf8UyFInRM5xOsnUid/NS4Y1tTrEYYWWIJ+xtodWfETwUkRoU5W2um0Cj3cs78qXqvKhGCmdOM163PLrsT+DH0Smdy8M2TlXckvPYA0u7HkzKvdxtBTSkeATPYlF4z7U3+Hg1Ctkx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BD8D113E;
	Sat,  7 Dec 2024 13:34:59 -0800 (PST)
Received: from [192.168.0.54] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E07B3F58B;
	Sat,  7 Dec 2024 13:34:29 -0800 (PST)
Message-ID: <e34a5b25-95c8-4111-baf1-c5ac4ad66cff@arm.com>
Date: Sat, 7 Dec 2024 21:34:27 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.12 15/36] mfd: axp20x: Allow multiple regulators
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
 Chris Morgan <macroalpha82@gmail.com>
References: <20241204154626.2211476-1-sashal@kernel.org>
 <20241204154626.2211476-15-sashal@kernel.org>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20241204154626.2211476-15-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sasha,


On 04/12/2024 15:45, Sasha Levin wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> 
> [ Upstream commit e37ec32188701efa01455b9be42a392adab06ce4 ]

can you hold back those backports, please? Chris reported a regression
in mainline[1]. He is working on a fix, but it doesn't look like to be
trivial. In fact we only really need this patch for an upcoming board
support, so there isn't an immediate need in stable kernels anyway.

Cheers,
Andre

[1] https://lore.kernel.org/linux-sunxi/675489c1.050a0220.8d73f.6e90@mx.google.com/T/#u


> At the moment trying to register a second AXP chip makes the probe fail,
> as some sysfs registration fails due to a duplicate name:
> 
> ...
> [    3.688215] axp20x-i2c 0-0035: AXP20X driver loaded
> [    3.695610] axp20x-i2c 0-0036: AXP20x variant AXP323 found
> [    3.706151] sysfs: cannot create duplicate filename '/bus/platform/devices/axp20x-regulator'
> [    3.714718] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-00026-g50bf2e2c079d-dirty #192
> [    3.724020] Hardware name: Avaota A1 (DT)
> [    3.728029] Call trace:
> [    3.730477]  dump_backtrace+0x94/0xec
> [    3.734146]  show_stack+0x18/0x24
> [    3.737462]  dump_stack_lvl+0x80/0xf4
> [    3.741128]  dump_stack+0x18/0x24
> [    3.744444]  sysfs_warn_dup+0x64/0x80
> [    3.748109]  sysfs_do_create_link_sd+0xf0/0xf8
> [    3.752553]  sysfs_create_link+0x20/0x40
> [    3.756476]  bus_add_device+0x64/0x104
> [    3.760229]  device_add+0x310/0x760
> [    3.763717]  platform_device_add+0x10c/0x238
> [    3.767990]  mfd_add_device+0x4ec/0x5c8
> [    3.771829]  mfd_add_devices+0x88/0x11c
> [    3.775666]  axp20x_device_probe+0x70/0x184
> [    3.779851]  axp20x_i2c_probe+0x9c/0xd8
> ...
> 
> This is because we use PLATFORM_DEVID_NONE for the mfd_add_devices()
> call, which would number the child devices in the same 0-based way, even
> for the second (or any other) instance.
> 
> Use PLATFORM_DEVID_AUTO instead, which automatically assigns
> non-conflicting device numbers.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Link: https://lore.kernel.org/r/20241007001408.27249-4-andre.przywara@arm.com
> Signed-off-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/mfd/axp20x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 4051551757f2d..f438c5cb694ad 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -1419,7 +1419,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>   		}
>   	}
>   
> -	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
> +	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x->cells,
>   			      axp20x->nr_cells, NULL, 0, NULL);
>   
>   	if (ret) {

