Return-Path: <stable+bounces-47753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26EF8D56B6
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 02:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35609B20E7D
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 00:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B2CA3D;
	Fri, 31 May 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="do5mSmCy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC02360;
	Fri, 31 May 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717113706; cv=none; b=P5+EHL6k8yHg+htMO4tSzi27kxSepAvYkxZdzh2V3l1UQiqruL70iPHFIz/vUv+AguDBlvQuFS3um8ID/XadVj9yGu0+sdX/4W8m5WVVOKtJrJRVj0xGZmj7S/sc/YUziq5GmxSWap13EXgK1D0Nbxh6xnHqL8Kh7ximbPWKDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717113706; c=relaxed/simple;
	bh=fYs9TXgb1lc0/2W2e+eE1fJ4XjREy+v/mo4OiH5BzDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4C0aojN5rHqln5KsbBUsHlF8IuI/qic9f3u9Xh0gCJTrVcXLTrIUzG0Xs2fRXNJzbXCUQINZqsWWHbnmrtJzNHl5RKpPxUwj3ed8sqxu+9GH01jYglrdtK5SLLbDtXH4K0ahQ4AjD6T4ZX+906sHW/+6PlYxg1ngsJwJsPBQH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=do5mSmCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F00C2BBFC;
	Fri, 31 May 2024 00:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717113706;
	bh=fYs9TXgb1lc0/2W2e+eE1fJ4XjREy+v/mo4OiH5BzDk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=do5mSmCyMpNp7G/LxbWP96NRACBZOcVijnNXTf/CukzF6ybfMKHBm/DQUzT2o7tLF
	 Tc4Z+5pb/wf+gp4QWaVfV8UWUIgiC/lMPGEqR82k/E2wGuJjOwxneRaGJwOz20UYmC
	 P4wdGPVUCCQWCVDIj02UC0fQPwWZYXUzQVPV4xfNFNbe7Eh5oaJEzgsNVkEebwgpyl
	 ER9qCZEuUiRZ2hF0/QmoyjsSfAXGBHY+gRd0A/wREyfdmknQqv/cjPkwzjqeobhy30
	 V+qV6quUdPBPcl3E9KVdpNEn93fDVLYjobes461S2o6iwNbBqWg1TN4OYGYzHdNwsd
	 CJsEJB4/ZjmqA==
Message-ID: <cc8eb41a-ad73-40c8-a56d-7f4ad1ce97ac@kernel.org>
Date: Fri, 31 May 2024 09:01:44 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340
To: Niklas Cassel <cassel@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Jian-Hong Pan <jhp@endlessos.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org, Tim Teichmann <teichmanntim@outlook.de>,
 linux-ide@vger.kernel.org
References: <20240530212703.561517-2-cassel@kernel.org>
 <Zlj1uc9FcLaSPoOX@ryzen.lan>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zlj1uc9FcLaSPoOX@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/31/24 6:55 AM, Niklas Cassel wrote:
> On Thu, May 30, 2024 at 11:27:04PM +0200, Niklas Cassel wrote:
>> Commit 7627a0edef54 ("ata: ahci: Drop low power policy board type")
>> dropped the board_ahci_low_power board type, and instead enables LPM if:
>> -The AHCI controller reports that it supports LPM (Partial/Slumber), and
>> -CONFIG_SATA_MOBILE_LPM_POLICY != 0, and
>> -The port is not defined as external in the per port PxCMD register, and
>> -The port is not defined as hotplug capable in the per port PxCMD
>>  register.
>>
>> Partial and Slumber LPM states can either be initiated by HIPM or DIPM.
>>
>> For HIPM (host initiated power management) to get enabled, both the AHCI
>> controller and the drive have to report that they support HIPM.
>>
>> For DIPM (device initiated power management) to get enabled, only the
>> drive has to report that it supports DIPM. However, the HBA will reject
>> device requests to enter LPM states which the HBA does not support.
>>
>> The problem is that Apacer AS340 drives do not handle low power modes
>> correctly. The problem was most likely not seen before because no one
>> had used this drive with a AHCI controller with LPM enabled.
>>
>> Add a quirk so that we do not enable LPM for this drive, since we see
>> command timeouts if we do (even though the drive claims to support DIPM).
>>
>> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
>> Cc: stable@vger.kernel.org
>> Reported-by: Tim Teichmann <teichmanntim@outlook.de>
>> Closes: https://lore.kernel.org/linux-ide/87bk4pbve8.ffs@tglx/
>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>> ---
>> On the system reporting this issue, the HBA supports SALP (HIPM) and
>> LPM states Partial and Slumber.
>>
>> This drive only supports DIPM but not HIPM, however, that should not
>> matter, as a DIPM request from the device still has to be acked by the
>> HBA, and according to AHCI 1.3.1, section 5.3.2.11 P:Idle, if the link
>> layer has negotiated to low power state based on device power management
>> request, the HBA will jump to state PM:LowPower.
>>
>> In PM:LowPower, the HBA will automatically request to wake the link
>> (exit from Partial/Slumber) when a new command is queued (by writing to
>> PxCI). Thus, there should be no need for host software to request an
>> explicit wakeup (by writing PxCMD.ICC to 1).
>>
>> Therefore, even with only DIPM supported/enabled, we shouldn't see command
>> timeouts with the current code. Also, only enabling only DIPM (by
>> modifying the AHCI driver) with another drive (which support both DIPM
>> and HIPM), shows no errors. Thus, it seems like the drive is the problem.
>>
>>  drivers/ata/libata-core.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 4f35aab81a0a..25b400f1c3de 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -4155,6 +4155,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>>  						ATA_HORKAGE_ZERO_AFTER_TRIM |
>>  						ATA_HORKAGE_NOLPM },
>>  
>> +	/* Apacer models with LPM issues */
>> +	{ "Apacer AS340*",		NULL,	ATA_HORKAGE_NOLPM },
>> +
>>  	/* These specific Samsung models/firmware-revs do not handle LPM well */
>>  	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
>>  	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },
>> -- 
>> 2.45.1
>>
> 
> One interesting fact which:
> Apacer AS340, CT240BX500SSD1, and R3SL240G all have in common:
> their SSD controller is made by Silicon Motion:
> https://smarthdd.com/database/Apacer-AS340-120GB/U1014A0/
> https://smarthdd.com/database/CT240BX500SSD1/M6CR013/
> https://smarthdd.com/database/R3SL240G/P0422C/
> 
> Not sure if that is relevant or not...

Well, I guess that probably explains why they all have the same issue with LPM.

-- 
Damien Le Moal
Western Digital Research


