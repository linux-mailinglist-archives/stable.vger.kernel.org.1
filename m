Return-Path: <stable+bounces-233746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBLZEpq+1Wlx9QcAu9opvQ
	(envelope-from <stable+bounces-233746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 04:34:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A30ED3B63F0
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 04:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 583B53014BE0
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7D72E8B71;
	Wed,  8 Apr 2026 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FKsyqy/6"
X-Original-To: Stable@vger.kernel.org
Received: from mail-m155115.qiye.163.com (mail-m155115.qiye.163.com [101.71.155.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BB71D5174;
	Wed,  8 Apr 2026 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775615634; cv=none; b=fo+Su366m/KboGGYPz3cbFtv9hXepYbPnuo7irB1CdB5qim+Ff+03t0LQf1YPbHOFmzTYs8pSsQ9M8ccumRaNYRU2BIGqqabdGSuKFHXtpIhiO5PrPXhqdGB//8M89vAfHFZ22vnz5SwOxFJy6W4QBx97/3CKC6mNK8fawwrZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775615634; c=relaxed/simple;
	bh=1T2VQPhRrwq3pZS7Xarc9rX/f3Yh7tEc/Nkc4KciLSU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s0rT9/dbg/rd9lSgv54gxxZ7s5L0wnFN4BZlniiuSgVxA/B6tOc+3lOxVrorecCXj8b4l1LVF4HkvCUQ+diTyGRoAXG/aHpN9/tuTHXdm5UcbyuHBrpWD+NO9ymudMSoLAgyTTP6SCqeYDs/i1AZk3xvhFm2Xl8X/q//PKcv33w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FKsyqy/6; arc=none smtp.client-ip=101.71.155.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39e07af53;
	Wed, 8 Apr 2026 10:18:22 +0800 (GMT+08:00)
Message-ID: <a9c5d50f-b09d-2aa6-56e8-788675a7a8d6@rock-chips.com>
Date: Wed, 8 Apr 2026 10:18:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Stable@vger.kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Disable clock before DLL
 configuration
To: Adrian Hunter <adrian.hunter@intel.com>
References: <1775014742-233407-1-git-send-email-shawn.lin@rock-chips.com>
 <da3b1b9c-fb92-4408-bb5a-485c050f7c60@intel.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <da3b1b9c-fb92-4408-bb5a-485c050f7c60@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d6ae233bd09cckunm716af1033867a7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0wYTlYaH0xOSRgaGR4aGU5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FKsyqy/62+sHoo2FL0sSgh8xxj55P4Ewb4Y+von8U2CRsa+A9Uh1KSkdbjBulBb7sF9hSlWtZSewAtlyT9MXzNoRliKWu3vTMayDYrDZMkpo+goKEeJ0CpTQlGJC9ZoY16p9MmowWcqX21rgE5qCLuczqBBwq6U5gORdKiV41w0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=bbP7HTNju4eJzMipoRDaCHo6KbSQ6RtCL471+qLrxWk=;
	h=date:mime-version:subject:message-id:from;
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233746-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shawn.lin@rock-chips.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:dkim,rock-chips.com:email,rock-chips.com:mid]
X-Rspamd-Queue-Id: A30ED3B63F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/04/07 星期二 14:38, Adrian Hunter 写道:
> On 01/04/2026 06:39, Shawn Lin wrote:
>> According to the ASIC design recommendations, the clock must be
>> disabled before operating the DLL to prevent glitches that could
>> affect the internal digital logic. In extreme cases, failing to
>> do so may cause the controller to malfunction completely.
>>
>> Adds a step to disable the clock before DLL configuration and
>> re-enables it at the end.
>>
>> Fixes: 08f3dff799d4 ("mmc: sdhci-of-dwcmshc: add rockchip platform support")
>> Cc: <Stable@vger.kernel.org>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>> This is bascially a code sync with the downstream vendor kernel which was been
>> done this way and tested for some years to confirm it could fix the issues in
>> all corner cases.
>>
>>   drivers/mmc/host/sdhci-of-dwcmshc.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> index 6139516..e3ae334 100644
>> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
>> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
>> @@ -783,12 +783,15 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>   	extra |= BIT(4);
>>   	sdhci_writel(host, extra, reg);
>>   
>> +	/* Disable clock while config DLL */
>> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>> +
>>   	if (clock <= 52000000) {
>>   		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200 ||
>>   		    host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
>>   			dev_err(mmc_dev(host->mmc),
>>   				"Can't reduce the clock below 52MHz in HS200/HS400 mode");
>> -			return;
>> +			goto enable_clk;
>>   		}
>>   
>>   		/*
>> @@ -808,7 +811,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>   			DLL_STRBIN_DELAY_NUM_SEL |
>>   			DLL_STRBIN_DELAY_NUM_DEFAULT << DLL_STRBIN_DELAY_NUM_OFFSET;
>>   		sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>> -		return;
>> +		goto enable_clk;
>>   	}
>>   
>>   	/* Reset DLL */
>> @@ -835,7 +838,7 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>   				 500 * USEC_PER_MSEC);
>>   	if (err) {
>>   		dev_err(mmc_dev(host->mmc), "DLL lock timeout!\n");
>> -		return;
>> +		goto enable_clk;
>>   	}
>>   
>>   	extra = 0x1 << 16 | /* tune clock stop en */
>> @@ -868,6 +871,9 @@ static void dwcmshc_rk3568_set_clock(struct sdhci_host *host, unsigned int clock
>>   		DLL_STRBIN_TAPNUM_DEFAULT |
>>   		DLL_STRBIN_TAPNUM_FROM_SW;
>>   	sdhci_writel(host, extra, DWCMSHC_EMMC_DLL_STRBIN);
>> +
>> +enable_clk:
>> +	sdhci_enable_clk(host, 0);
> 
> Should this be 0?  If so, needs some explanation.

Yes, passing 0 is intentional for the Rockchip platform.
This controller on Rockchip has SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
set, indicating that the base clock capability reporting is unreliable.
More importantly, the sdclk frequency select bits in the
SDHCI_CLOCK_CONTROL register are actually non-functional on this 
hardware. The sdclk frequency is instead set via clk_set_rate()for all
modes. From this point, all of the sdhci_set_clock() calls and in
dwcmshc_rk3568_set_clock() are also served as enabling and disabling
clk only.

Therefore, sdhci_enable_clk(host, 0) is simply re-enabling the
clock without modifying the frequency selection bits, which aligns with
the hardware's actual behavior.

Technically speaking, we could save the previously calculated sdclk
value and pass it to sdhci_enable_clk(). However, since the frequency
select bits are ignored by the hardware, passing 0 is safe and
functionally equivalent. I could add a comment for just this line change
or would you like me to add a comment for the whole sdclk stuff in
dwcmshc_rk3568_set_clock()?


> 
>>   }
>>   
>>   static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> 
> 

