Return-Path: <stable+bounces-35-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFABD7F5E23
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 12:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DC61F207C1
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD52375F;
	Thu, 23 Nov 2023 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pFS7VoaA"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C791A5
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 03:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GNgjeWbyLFQk/G/r5S5rkunrrjHURbTvd/4xVmqaNHs=; b=pFS7VoaAutSRNvCbt7eLRQv51A
	SrAUifA+9uE7Nahu/FzKw09Z2vuxMkWIo0Yw2D0UTQorzfW+OgvixjNAU+hDx4v7/HlZkPdeMKSZv
	rKOSxKba9FPkTFR+wqSkVHs6yBIFm/w0ASkk/fs8a5UTXTrAFIt1aDTgI8X+a6jIrR4nBgkWuF3Ni
	vHPPKbC0UYVazw3NZMN7nKL0180dft9wIK9c2NFMZH4Kz7jyNXCGsGCFLWHms/97LK/oUk5OHgAMM
	9rvSwby8MzGXMlEdGql8jvGjxSaFIg2T8xorA2i4T5yX7STkAC7Sl4yFvBGjcdzwk1MJetLT36WWG
	+vsZZ+cg==;
Received: from [177.34.168.16] (helo=[192.168.0.8])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1r688e-006KhC-C8; Thu, 23 Nov 2023 12:44:56 +0100
Message-ID: <f3db22c3-a0c8-0f7f-0d57-07a013941d3c@igalia.com>
Date: Thu, 23 Nov 2023 08:44:51 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: FAILED: patch "[PATCH] pmdomain: bcm: bcm2835-power: check if the
 ASB register is" failed to apply to 6.5-stable tree
To: Stefan Wahren <wahrenst@gmx.net>, gregkh@linuxfoundation.org,
 florian.fainelli@broadcom.com, ulf.hansson@linaro.org
Cc: stable@vger.kernel.org
References: <2023112257-putdown-prozac-affa@gregkh>
 <ab40f12c-47bf-4915-bdd4-587561563382@gmx.net>
Content-Language: en-US
From: Maira Canal <mcanal@igalia.com>
In-Reply-To: <ab40f12c-47bf-4915-bdd4-587561563382@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefan,

On 11/23/23 06:30, Stefan Wahren wrote:
> Hi,
> 
> Am 22.11.23 um 19:52 schrieb gregkh@linuxfoundation.org:
>>
>> The patch below does not apply to the 6.5-stable tree.
>> If someone wants it applied there, or to any other stable or longterm
>> tree, then please email the backport, including the original git commit
>> id to <stable@vger.kernel.org>.
>>
>> To reproduce the conflict and resubmit, you may use the following 
>> commands:
>>
>> git fetch 
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ 
>> linux-6.5.y
>> git checkout FETCH_HEAD
>> git cherry-pick -x 2e75396f1df61e1f1d26d0d703fc7292c4ae4371
>> # <resolve conflicts, build, test, etc.>
>> git commit -s
>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to 
>> '2023112257-putdown-prozac-affa@gregkh' --subject-prefix 'PATCH 6.5.y' 
>> HEAD^..
>>
>> Possible dependencies:
>>
>> 2e75396f1df6 ("pmdomain: bcm: bcm2835-power: check if the ASB register 
>> is equal to enable")
> 
> the reason why this doesn't apply is that the driver has been moved
> recently from soc/bcm/ to pmdomain/bcm/ . In this tree the directory
> pmdomain doesn't exist.
> 
> @Maíra Do you want to send the adapted patch to linux-stable?

Yeah, I will work on that.

Best Regards,
- Maíra

> 
> https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rst
> 
> Best regards
> 
>>
>> thanks,
>>
>> greg k-h
>>
>> ------------------ original commit in Linus's tree ------------------
>>
>>  From 2e75396f1df61e1f1d26d0d703fc7292c4ae4371 Mon Sep 17 00:00:00 2001
>> From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
>> Date: Tue, 24 Oct 2023 07:10:40 -0300
>> Subject: [PATCH] pmdomain: bcm: bcm2835-power: check if the ASB 
>> register is
>>   equal to enable
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=UTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
>> refactored the ASB control by using a general function to handle both
>> the enable and disable. But this patch introduced a subtle regression:
>> we need to check if !!(readl(base + reg) & ASB_ACK) == enable, not just
>> check if (readl(base + reg) & ASB_ACK) == true.
>>
>> Currently, this is causing an invalid register state in V3D when
>> unloading and loading the driver, because `bcm2835_asb_disable()` will
>> return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
>> ASB slave for V3D.
>>
>> Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> Reviewed-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Cc: stable@vger.kernel.org
>> Link: https://lore.kernel.org/r/20231024101251.6357-2-mcanal@igalia.com
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c 
>> b/drivers/pmdomain/bcm/bcm2835-power.c
>> index 1a179d4e011c..d2f0233cb620 100644
>> --- a/drivers/pmdomain/bcm/bcm2835-power.c
>> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
>> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct 
>> bcm2835_power *power, u32 reg, bool enable
>>       }
>>       writel(PM_PASSWORD | val, base + reg);
>>
>> -    while (readl(base + reg) & ASB_ACK) {
>> +    while (!!(readl(base + reg) & ASB_ACK) == enable) {
>>           cpu_relax();
>>           if (ktime_get_ns() - start >= 1000)
>>               return -ETIMEDOUT;
>>

