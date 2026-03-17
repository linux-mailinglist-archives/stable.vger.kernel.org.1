Return-Path: <stable+bounces-226039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG6wJ+9ouWmZDwIAu9opvQ
	(envelope-from <stable+bounces-226039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:45:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D212AC395
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D0663030DB8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F7A3E7146;
	Tue, 17 Mar 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kPkW309+"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936B27FB0E;
	Tue, 17 Mar 2026 14:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758689; cv=none; b=QtGaEuzhln6I7kWPflBbsj7fS8K2rWGKg/A8N350WCQVramrg4GvaOelIV+/1JFZmgB0xb16N8K01CNqswrg0pBTOc4+HgQtkPF+z3ZH4m8d1b3mnNJF0WVcnSeopiLsqfNBx1By3uSTBGu/fTabyYC/dWhyY/+NBruXZnH/QTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758689; c=relaxed/simple;
	bh=ig/EMNX8avDH9Wkq0jW9ZCq98ghPv+RlnlihJXI4x1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RkzQTd/70CR99r/6Wr2vjeuguPW891jJtc0IqerFk7CfRnF/rli5wANOQuBSyfrRu3jWeNhQsAopGbnYCRYHE69PJO5GLICip1Di/0m3zgTVI8EbRY3MyGXvOlfpOawY8FI50yjo2W1U2RLwhKH/3o/xSrKyLipMhCNyb0uY434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kPkW309+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9nzDO8JHBjMy9LqMyHLjdL/DanHBIGqFXpaJScTCJtQ=; b=kPkW309+RbGupOYzxYbz0CwI8B
	jEeGsg5RfC93jrywAcCL34e1cun4dqZs3klL8EDztT2qCwquFn+lHGmIREkefKmcP8GUQZgL2mXG4
	djbLGdEgQAheNnsKH+o5Q67B+F3bb0E4ocgxAPTs9/E0K+QaauyLMxrdd82Jj2Lyq0HdghUhSIcXa
	5/aGP8YOr1JW/ivrCAbCMC59PwxSkF/i4FaVUFNmMTIjee1alVMKzxM+j5VbJevf8UpK8WUFbDm1y
	qMpwaOfwiRfpasKIvS4VYtxK58ZuDzYCM1iHkDEMhWQnCRM3bL4Jv6UpARZkODTX9vQasW7n8DnUe
	MH37YmVA==;
Received: from gwsc.sc.usp.br ([143.107.225.16] helo=[172.24.4.78])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w2Vet-002Joh-2k; Tue, 17 Mar 2026 15:44:35 +0100
Message-ID: <14ad62c7-7046-4df6-8267-c868a9fde982@igalia.com>
Date: Tue, 17 Mar 2026 11:44:25 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] pmdomain: bcm: bcm2835-power: Increase ASB control
 timeout
To: Stefan Wahren <wahrenst@gmx.net>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Maxime Ripard <mripard@kernel.org>, Melissa Wen <mwen@igalia.com>,
 Iago Toral Quiroga <itoral@igalia.com>,
 Chema Casanova <jmcasanova@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, kernel-dev@igalia.com,
 stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 linux-pm@vger.kernel.org
References: <20260312-v3d-power-management-v7-0-9f006a1d4c55@igalia.com>
 <20260312-v3d-power-management-v7-2-9f006a1d4c55@igalia.com>
 <bdae424d-f4b5-4181-9421-4393fe3ac8fb@gmx.net>
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
In-Reply-To: <bdae424d-f4b5-4181-9421-4393fe3ac8fb@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.net,baylibre.com,kernel.org,broadcom.com,igalia.com,raspberrypi.com,pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226039-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	FROM_NEQ_ENVFROM(0.00)[mcanal@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,igalia.com:mid,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89D212AC395
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Stefan,

On 15/03/26 20:07, Stefan Wahren wrote:
> Hi Maíra,
> 
> Am 12.03.26 um 22:34 schrieb Maíra Canal:
>> The bcm2835_asb_control() function uses a tight polling loop to wait
>> for the ASB bridge to acknowledge a request. During intensive workloads,
>> this handshake intermittently fails for V3D's master ASB on BCM2711,
>> resulting in "Failed to disable ASB master for v3d" errors during
>> runtime PM suspend. As a consequence, the failed power-off leaves V3D in
>> a broken state, leading to bus faults or system hangs on later accesses.
>>
>> As the timeout is insufficient in some scenarios, increase the polling
>> timeout from 1us to 5us, which is still negligible in the context of a
>> power domain transition. Also, move the start timestamp to after the
>> MMIO write, as the write latency is counted against the timeout,
>> reducing the effective wait time for the hardware to respond.
>>
>> Cc: stable@vger.kernel.org
> I think, a Fixes tag would be helpful here. Also this fix should be the 
> first patch of the series or separate.

I'll send it separately with the Fixes tag. Thanks!

>> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>>
>> ---
>> To: Ulf Hansson <ulf.hansson@linaro.org>
>> To: Ray Jui <rjui@broadcom.com>
>> To: Scott Branden <sbranden@broadcom.com>
>> Cc: linux-pm@vger.kernel.org
> This looks unusual. Is this intended?

As b4 doesn't support it natively, I used this strategy to send only
this patch to the linux-pm mailing list and not the whole series.

Best regards,
- Maíra

> 
> Best regards
>> ---
>>   drivers/pmdomain/bcm/bcm2835-power.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/ 
>> bcm/bcm2835-power.c
>> index 
>> 0450202bbee2513c9116a36abaa839b460550935..1815eb4ee69b9b672b5e314402f1cc9897c57dcb 100644
>> --- a/drivers/pmdomain/bcm/bcm2835-power.c
>> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
>> @@ -166,8 +166,6 @@ static int bcm2835_asb_control(struct 
>> bcm2835_power *power, u32 reg, bool enable
>>           break;
>>       }
>> -    start = ktime_get_ns();
>> -
>>       /* Enable the module's async AXI bridges. */
>>       if (enable) {
>>           val = readl(base + reg) & ~ASB_REQ_STOP;
>> @@ -176,9 +174,10 @@ static int bcm2835_asb_control(struct 
>> bcm2835_power *power, u32 reg, bool enable
>>       }
>>       writel(PM_PASSWORD | val, base + reg);
>> +    start = ktime_get_ns();
>>       while (!!(readl(base + reg) & ASB_ACK) == enable) {
>>           cpu_relax();
>> -        if (ktime_get_ns() - start >= 1000)
>> +        if (ktime_get_ns() - start >= 5000)
>>               return -ETIMEDOUT;
>>       }
>>
> 


