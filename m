Return-Path: <stable+bounces-250000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANsYKvTPDWr53QUAu9opvQ
	(envelope-from <stable+bounces-250000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:15:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2295909AE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEBE0315AC14
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A0F3E95B8;
	Wed, 20 May 2026 14:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="EDaVVcZ6"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646113EAC9B;
	Wed, 20 May 2026 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289192; cv=none; b=PJwMMEMAEr9uDXzJLXz2JfbcS1S7yxJUlADh0hkWJIwPlW9wubjLzylgURyts47Q6qVH820GL1nEgWVzRYcg6UAv+PXm9v+PfJzKX/GCjdfys8sVnuUqrZNZxGkYMRPny6phXhVJoubwpltmhqeGcbYyMYetxvAFupAXXRUHjn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289192; c=relaxed/simple;
	bh=ypBjmOVm5vHNCf+6GISN3A0oT7mj+I8N6CiOqdI6Lnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uITEi7Hwhpgu+U/h77fcOyxEZyRLDJQG2rV2aaKjvjSUBguYof1hAEWCkqdOsEWCfCyQHdeUp2bSQ5tbTQ+LtOKp8lvEtt5DC+3o4q3YqpZHKOUk9nSU/Tkx2Nnd/WfsJIWeMX+yLayEz01k8BftfON/sVu+D6pwlXn+G2L8jSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=EDaVVcZ6; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id AADA96000856;
	Wed, 20 May 2026 15:59:47 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id MuwmUhcZzJ2N; Wed, 20 May 2026 15:59:45 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 006C860020D6;
	Wed, 20 May 2026 15:59:44 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1779289185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vXXFiH/32G5y4COiAZEvw5lUcYcub90AvE+UlXejzyY=;
	b=EDaVVcZ6G9W2YTZjaC4LVDWvrWA1PYtb3bfA6PFQURGFaOCR/QNCUrXzhczyFHstya2gbv
	hBlkKI4YKYu9lgdKqEWxiTHIGiso/5MbPGEbUc7tgxho2YZHEjNx13naIH/RooHYQAJIss
	Fcvnw13udtoW2zY0IZFeXEdvpGG6sger5bFllJnLt4Zkt34WUJNO91cRyaSTm7LCMMuH5T
	FzBeLXKQTFucj8edmDVBjhckGofiB1lIV7xejmc9K9fk9QNpSo13lDJKHC+bCGvUtKmfBV
	Ulh3jxSQHMxn3L7SpKsAJtHyNsDqHlGxQtwOO/G03rpEYnAqcMMHfNkarMJxDA==
Received: from [IPV6:2a04:cec2:a:9912:685c:7af9:be7c:958f] (unknown [IPv6:2a04:cec2:a:9912:685c:7af9:be7c:958f])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 3F1AF3601F8;
	Wed, 20 May 2026 15:59:44 +0100 (WEST)
Message-ID: <38f5201a-6b52-4f18-bbbe-775171a3f147@tecnico.ulisboa.pt>
Date: Wed, 20 May 2026 16:59:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
To: Dmitry Osipenko <digetx@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
 <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tecnico.ulisboa.pt,quarantine];
	R_DKIM_ALLOW(-0.20)[tecnico.ulisboa.pt:s=mail2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250000-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,tecnico.ulisboa.pt:mid,tecnico.ulisboa.pt:dkim,ulisboa.pt:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tecnico.ulisboa.pt:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[diogo.ivo@tecnico.ulisboa.pt,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9B2295909AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 16:42, Dmitry Osipenko wrote:
> 20.05.2026 17:28, Diogo Ivo пишет:
>> max77620_pm_power_off() is called via the sys-off framework as a
>> SYS_OFF_MODE_POWER_OFF handler, which runs in an atomic notifier chain
>> with IRQs disabled after smp_send_stop(). regmap_update_bits() acquires
>> the regmap mutex in this path; if another CPU held that mutex when it
>> was stopped, the power-off sequence deadlocks.
>>
>> Replace regmap_update_bits() with i2c_smbus_write_byte_data(), which
>> bypasses the regmap lock entirely. The I2C core detects the atomic
>> context via i2c_in_atomic_xfer_mode() and uses i2c_trylock_bus() rather
>> than a blocking acquisition, avoiding the deadlock.
>>
>> Tested on Pixel C, powers off correctly.
>>
>> Assisted-by: Claude:claude-sonnet-4-6
>> Fixes: 744b13107d0d ("mfd: max77620: Provide system power-off functionality")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
>> ---
>> This patch was tested on a local branch that sets pm_power_off =
>> max77620_pm_power_off() unconditionally so that the function runs.
>> I haven't checked whether the other bits in ONOFFCNFG1 are safe to
>> discard at power-off time as I don't have access to the datasheet.
>> If someone with access to the datasheet confirms they're not I'll
>> respin the patch taking that into account.
>> ---
>>   drivers/mfd/max77620.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
>> index 3af2974b3023..8c768968a317 100644
>> --- a/drivers/mfd/max77620.c
>> +++ b/drivers/mfd/max77620.c
>> @@ -487,10 +487,14 @@ static int max77620_read_es_version(struct max77620_chip *chip)
>>   static void max77620_pm_power_off(void)
>>   {
>>   	struct max77620_chip *chip = max77620_scratch;
>> +	struct i2c_client *client = to_i2c_client(chip->dev);
>>   
>> -	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
>> -			   MAX77620_ONOFFCNFG1_SFT_RST,
>> -			   MAX77620_ONOFFCNFG1_SFT_RST);
>> +	/*
>> +	 * Atomic context: IRQs disabled. Use raw I2C write, bypassing
>> +	 * regmap locking entirely.
>> +	 */
>> +	i2c_smbus_write_byte_data(client, MAX77620_REG_ONOFFCNFG1,
>> +				  MAX77620_ONOFFCNFG1_SFT_RST);
>>   }
>>   
>>   static int max77620_probe(struct i2c_client *client)
>>
>> ---
>> base-commit: 27fa82620cbaa89a7fc11ac3057701d598813e87
>> change-id: 20260520-max77620_poweroff-08e39429835f
>>
>> Best regards,
>> --
>> Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> 
> Kernel parks secondary CPUs before powering off system, hence there
> shouldn't be a locking contention.

This patch was motivated by the Sashiko review I got in [1]. Its point
here is that there is a possibility for a deadlock scenario in which
a secondary CPU obtains the mutex for the regmap and then smp_send_stop()
is called before this secondary CPU gets a chance to release the mutex,
making it so that when the primary CPU tries to acquire it to issue the
write it hangs. Is there something that I am misunderstanding here?

> Have you checked whether regmap_write_bits() works?

Now, in case this is all true this problem is still not something that
will usually happen, only when this specific situation holds so
generally even regmap_update_bits() was working, and in [1] I sent it
out exactly like that. Changing it to regmap_write_bits() would not make
any difference.

[1]: 
https://lore.kernel.org/linux-tegra/20260514-smaug-poweroff-v1-0-30f9a4688966@tecnico.ulisboa.pt/

