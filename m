Return-Path: <stable+bounces-227068-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BXSKQKnumk6aQIAu9opvQ
	(envelope-from <stable+bounces-227068-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:22:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B22BC144
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438953027113
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E63D647C;
	Wed, 18 Mar 2026 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZXREdaq5"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E732135D7;
	Wed, 18 Mar 2026 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840123; cv=none; b=DGWPycRNLwgf142WEDlYHJy35GU+TtKOXLJhoKDQapOiDS4nd++j2TO8ROwz4bcoa3oKymQ3TSnFmFPzQmSSXkSfHMFsahfrCjvSFaZ9OS/jybzgnqFq6+BsEKWZX9xLYOfGl67iYEorBUmasBaxQNCN9Hbtd55BlPr6gREZmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840123; c=relaxed/simple;
	bh=5r7ijceUOHXY8fKVWgfvjk7WZDjpTEEW5WgLZe2l3L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD9LP/xxa0Fs0zvA0OVNNV4e4UjMy1LQHSTYJhCxCb99sg/nZ4lp4WEwuNz65HWqCZ8pbeq5kh2fxP3uBKJCvnPdlUGnDoNlWtlCqU69jx6Crjpi/skVV3QCg6GOuk922SK3/+wbCzLc0mU2gzb2z/8kY6iOI4wMcclrp23NWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZXREdaq5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yzqcnl/zvt0EBa0YX4d6s+M1CBNs1lPaqKw1XiykpH8=; b=ZXREdaq5zuN6bOhowRFcwcEVyo
	R02VpxHX8fZpb8HI57O9wC0deWdcTxk4NPA97r5p5vT3SnJZa+UYDYtizwllrAigkyLRYcYJuqacS
	rwW5E9TgxIXnYcpAFwhRaWqvotCUZCS9Y8/4pjNZdI0EGtKXNit3VK/Q1CZw/iDhMfVLEJEPjQVMz
	vRtURzxEQMU+q/cLf+XJRIEdvauJgP2gUiZ4cGsB7HXOcqygL9zA539hYoxEH9c99fSQVmjVluSq1
	L6Po2KctGc0f4wD1rjxsC/QrPVKDM7ucyASSdIa85L37Y27Pmfo+4AyS4bmdJGrcRJbKG4AGzzddv
	gtOn7anA==;
Received: from [189.7.87.203] (helo=[192.168.0.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w2qqO-002nl8-Pi; Wed, 18 Mar 2026 14:21:53 +0100
Message-ID: <455b46d5-435a-40ae-991f-6735ff041849@igalia.com>
Date: Wed, 18 Mar 2026 10:21:47 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pmdomain: bcm: bcm2835-power: Increase ASB control
 timeout
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stefan Wahren <wahrenst@gmx.net>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>,
 kernel-dev@igalia.com, linux-pm@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org
References: <20260317-bcm2835-power-timeout-v1-0-19db323c51f9@igalia.com>
 <20260317-bcm2835-power-timeout-v1-1-19db323c51f9@igalia.com>
 <c803299f-709b-4b57-b7fc-46ef3bb4c9ee@gmx.net>
 <5fe9332f-fbce-469e-8f19-dd3d7ef54c5f@igalia.com>
 <CAPDyKFoooZbU9W_Y1aSx+HuCfjHZGn9XR4_CB8YgDmCBWTB-Tg@mail.gmail.com>
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Content-Language: en-US
Autocrypt: addr=mcanal@igalia.com; keydata=
 xsBNBGcCwywBCADgTji02Sv9zjHo26LXKdCaumcSWglfnJ93rwOCNkHfPIBll85LL9G0J7H8
 /PmEL9y0LPo9/B3fhIpbD8VhSy9Sqz8qVl1oeqSe/rh3M+GceZbFUPpMSk5pNY9wr5raZ63d
 gJc1cs8XBhuj1EzeE8qbP6JAmsL+NMEmtkkNPfjhX14yqzHDVSqmAFEsh4Vmw6oaTMXvwQ40
 SkFjtl3sr20y07cJMDe++tFet2fsfKqQNxwiGBZJsjEMO2T+mW7DuV2pKHr9aifWjABY5EPw
 G7qbrh+hXgfT+njAVg5+BcLz7w9Ju/7iwDMiIY1hx64Ogrpwykj9bXav35GKobicCAwHABEB
 AAHNIE1hw61yYSBDYW5hbCA8bWNhbmFsQGlnYWxpYS5jb20+wsCRBBMBCAA7FiEE+ORdfQEW
 dwcppnfRP/MOinaI+qoFAmcCwywCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQ
 P/MOinaI+qoUBQgAqz2gzUP7K3EBI24+a5FwFlruQGtim85GAJZXToBtzsfGLLVUSCL3aF/5
 O335Bh6ViSBgxmowIwVJlS/e+L95CkTGzIIMHgyUZfNefR2L3aZA6cgc9z8cfow62Wu8eXnq
 GM/+WWvrFQb/dBKKuohfBlpThqDWXxhozazCcJYYHradIuOM8zyMtCLDYwPW7Vqmewa+w994
 7Lo4CgOhUXVI2jJSBq3sgHEPxiUBOGxvOt1YBg7H9C37BeZYZxFmU8vh7fbOsvhx7Aqu5xV7
 FG+1ZMfDkv+PixCuGtR5yPPaqU2XdjDC/9mlRWWQTPzg74RLEw5sz/tIHQPPm6ROCACFls7A
 TQRnAsMsAQgAxTU8dnqzK6vgODTCW2A6SAzcvKztxae4YjRwN1SuGhJR2isJgQHoOH6oCItW
 Xc1CGAWnci6doh1DJvbbB7uvkQlbeNxeIz0OzHSiB+pb1ssuT31Hz6QZFbX4q+crregPIhr+
 0xeDi6Mtu+paYprI7USGFFjDUvJUf36kK0yuF2XUOBlF0beCQ7Jhc+UoI9Akmvl4sHUrZJzX
 LMeajARnSBXTcig6h6/NFVkr1mi1uuZfIRNCkxCE8QRYebZLSWxBVr3h7dtOUkq2CzL2kRCK
 T2rKkmYrvBJTqSvfK3Ba7QrDg3szEe+fENpL3gHtH6h/XQF92EOulm5S5o0I+ceREwARAQAB
 wsB2BBgBCAAgFiEE+ORdfQEWdwcppnfRP/MOinaI+qoFAmcCwywCGwwACgkQP/MOinaI+qpI
 zQf+NAcNDBXWHGA3lgvYvOU31+ik9bb30xZ7IqK9MIi6TpZqL7cxNwZ+FAK2GbUWhy+/gPkX
 it2gCAJsjo/QEKJi7Zh8IgHN+jfim942QZOkU+p/YEcvqBvXa0zqW0sYfyAxkrf/OZfTnNNE
 Tr+uBKNaQGO2vkn5AX5l8zMl9LCH3/Ieaboni35qEhoD/aM0Kpf93PhCvJGbD4n1DnRhrxm1
 uEdQ6HUjWghEjC+Jh9xUvJco2tUTepw4OwuPxOvtuPTUa1kgixYyG1Jck/67reJzMigeuYFt
 raV3P8t/6cmtawVjurhnCDuURyhUrjpRhgFp+lW8OGr6pepHol/WFIOQEg==
In-Reply-To: <CAPDyKFoooZbU9W_Y1aSx+HuCfjHZGn9XR4_CB8YgDmCBWTB-Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227068-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmx.net,broadcom.com,kernel.org,igalia.com,vger.kernel.org,lists.infradead.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.874];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 152B22BC144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ulf,

On 18/03/26 10:06, Ulf Hansson wrote:
> On Wed, 18 Mar 2026 at 13:54, Maíra Canal <mcanal@igalia.com> wrote:
>>
>> Hi Stefan,
>>
>> On 18/03/26 08:51, Stefan Wahren wrote:
>>> Hi Maíra,
>>>
>>> Am 17.03.26 um 23:41 schrieb Maíra Canal:
>>>> The bcm2835_asb_control() function uses a tight polling loop to wait
>>>> for the ASB bridge to acknowledge a request. During intensive workloads,
>>>> this handshake intermittently fails for V3D's master ASB on BCM2711,
>>>> resulting in "Failed to disable ASB master for v3d" errors during
>>>> runtime PM suspend. As a consequence, the failed power-off leaves V3D in
>>>> a broken state, leading to bus faults or system hangs on later accesses.
>>>>
>>>> As the timeout is insufficient in some scenarios, increase the polling
>>>> timeout from 1us to 5us, which is still negligible in the context of a
>>>> power domain transition. Also, replace the open-coded ktime_get_ns()/
>>>> cpu_relax() polling loop with readl_poll_timeout_atomic().
>>> personally I would have moved all readl_poll_timeout_atomic changes in
>>> the second patch, to avoid possible conflicts in stable. But no strong
>>> opinion about this.
>>>
>>
>> TBH personally, I also agree. But, as I don't have a strong opinion
>> about it, I prioritized addressing Ulf's feedback in the last version
>> [1].
> 
> The first version of the patch moved the call to ktime_get_ns(), so I
> thought we might as well use readl_poll_timeout_atomic() directly,
> instead of fixing up the open-coded loop.
> 

Yeah, it makes sense. I'm okay with both options, so if Stefan agrees
with it, I'm fine in moving forward with this approach.

Best regards,
- Maíra

> Kind regards
> Uffe
> 
>>
>> [1]
>> https://lore.kernel.org/dri-devel/20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com/T/#mf96146960ec7ffeea32e732c95ccf9548af21748
>>
>> Best regards,
>> - Maíra
>>
>>> Best regards
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 670c672608a1 ("soc: bcm: bcm2835-pm: Add support for power
>>>> domains under a new binding.")
>>>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>>> ---
>>>>    drivers/pmdomain/bcm/bcm2835-power.c | 12 ++++--------
>>>>    1 file changed, 4 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/
>>>> bcm/bcm2835-power.c
>>>> index
>>>> 0450202bbee2513c9116a36abaa839b460550935..eee87a3005325848547ce1f5fd729b168a641460 100644
>>>> --- a/drivers/pmdomain/bcm/bcm2835-power.c
>>>> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
>>>> @@ -9,6 +9,7 @@
>>>>    #include <linux/clk.h>
>>>>    #include <linux/delay.h>
>>>>    #include <linux/io.h>
>>>> +#include <linux/iopoll.h>
>>>>    #include <linux/mfd/bcm2835-pm.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/platform_device.h>
>>>> @@ -153,7 +154,6 @@ struct bcm2835_power {
>>>>    static int bcm2835_asb_control(struct bcm2835_power *power, u32 reg,
>>>> bool enable)
>>>>    {
>>>>        void __iomem *base = power->asb;
>>>> -    u64 start;
>>>>        u32 val;
>>>>        switch (reg) {
>>>> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct
>>>> bcm2835_power *power, u32 reg, bool enable
>>>>            break;
>>>>        }
>>>> -    start = ktime_get_ns();
>>>> -
>>>>        /* Enable the module's async AXI bridges. */
>>>>        if (enable) {
>>>>            val = readl(base + reg) & ~ASB_REQ_STOP;
>>>> @@ -176,11 +174,9 @@ static int bcm2835_asb_control(struct
>>>> bcm2835_power *power, u32 reg, bool enable
>>>>        }
>>>>        writel(PM_PASSWORD | val, base + reg);
>>>> -    while (!!(readl(base + reg) & ASB_ACK) == enable) {
>>>> -        cpu_relax();
>>>> -        if (ktime_get_ns() - start >= 1000)
>>>> -            return -ETIMEDOUT;
>>>> -    }
>>>> +    if (readl_poll_timeout_atomic(base + reg, val,
>>>> +                      !!(val & ASB_ACK) != enable, 0, 5))
>>>> +        return -ETIMEDOUT;
>>>>        return 0;
>>>>    }
>>>>
>>>
>>


