Return-Path: <stable+bounces-253489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGeqMM/PDmrOCQYAu9opvQ
	(envelope-from <stable+bounces-253489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:26:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3C65A24E0
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18FEB3115EFF
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 09:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81D347537;
	Thu, 21 May 2026 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="Ymi90PlR"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676D3242B8;
	Thu, 21 May 2026 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355170; cv=none; b=LAgs0LAseTBYldgdWG05Sj5wLL7jsJ3k7OkKtYIHriE7+zh1W3RSDyEKSnbl/FlMP8PWpnuJpR/0YUyMSOtrSpq3qRouos6Ib5605nEFNu0Jzkaog0q8g9t1HI55Jt2lRftqo++msqKLJbJ+NjwVFOitU+PIf55UpvN8CuxOieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355170; c=relaxed/simple;
	bh=0Fop6pdEHlaNj/Ioj1uT606dQopGP0f64ONTomchtsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqUnqMcG4pkh0NrUav8YY7BtgG9uY39RIvNL8oNVK24R1P65L7P/PTpvio6GjBgFqE7M7z4PORsW3qS8/SeWDUHCooi2mAAAyZ9JRZD8p3tvVk/FP+aATVlemJ0/9CFN3To0vHx+f7MUJEbmfGHLCt0IT3smoqZw6d9lpPyc2lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=Ymi90PlR; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id C99D7600301C;
	Thu, 21 May 2026 10:19:25 +0100 (WEST)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id Gys94a911rnR; Thu, 21 May 2026 10:19:23 +0100 (WEST)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id D158E6000868;
	Thu, 21 May 2026 10:19:23 +0100 (WEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1779355163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GyVEo0ZjWkmOPOuDAXYY2bk1EAkxSnd7MZ1VWjeAy6Y=;
	b=Ymi90PlR6871rdwYagULPVIEmpc9lTTvcgOcs+rH5H8kAanOCfOYiX3t70gznDzkhNhQ8Y
	YdL+uzsTGu7Xew1MXrXqYygLdK4Pw/16KWB3OGyu9pAzY0NPQWlE/kGlRcN0UnA3II4Dqm
	08rgd6sJf3uUh522I+VWlWAePcSuy2TiRUJy0HImHCkFd4OD0ywm4eNcGW8Gyn+6TMBb2X
	ViFBJ5nS+ER9uCjqBj7xzBaio2+0S14Es8rcrkbOgIGoVlMScCW6YEAbzUugnN9Uw73oeD
	u1H+/4yt2Cz7HzNr0g35GZrWIYyr+rBjWlUWySsjUT5r2CRvB6DePnZdGKdIwA==
Received: from [192.168.96.1] (unknown [89.214.153.114])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 8718D360257;
	Thu, 21 May 2026 10:19:22 +0100 (WEST)
Message-ID: <6017863a-6587-4b6d-8c10-ade27fbafc2c@tecnico.ulisboa.pt>
Date: Thu, 21 May 2026 11:19:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: max77620: Avoid regmap mutex deadlock in power-off
 handler
To: Dmitry Osipenko <digetx@gmail.com>, Mark Brown <broonie@kernel.org>,
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260520-max77620_poweroff-v1-1-9186a3bcbe9e@tecnico.ulisboa.pt>
 <c8d16352-63a3-4512-b90c-a79e7e96dd3c@gmail.com>
 <38f5201a-6b52-4f18-bbbe-775171a3f147@tecnico.ulisboa.pt>
 <20260520161900.GM2767592@google.com>
 <3b2b25f9-3ab5-4811-9945-f317b8788484@sirena.org.uk>
 <286ebc23-944a-4374-8128-3511c68cd1bf@gmail.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <286ebc23-944a-4374-8128-3511c68cd1bf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tecnico.ulisboa.pt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[tecnico.ulisboa.pt:s=mail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253489-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[diogo.ivo@tecnico.ulisboa.pt,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[tecnico.ulisboa.pt:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3C3C65A24E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/20/26 18:44, Dmitry Osipenko wrote:
> 20.05.2026 19:23, Mark Brown пишет:
>> On Wed, May 20, 2026 at 05:19:00PM +0100, Lee Jones wrote:
>>> On Wed, 20 May 2026, Diogo Ivo wrote:
>>
>>>> This patch was motivated by the Sashiko review I got in [1]. Its point
>>>> here is that there is a possibility for a deadlock scenario in which
>>>> a secondary CPU obtains the mutex for the regmap and then smp_send_stop()
>>>> is called before this secondary CPU gets a chance to release the mutex,
>>>> making it so that when the primary CPU tries to acquire it to issue the
>>>> write it hangs. Is there something that I am misunderstanding here?
>>>>
>>
>>> It's my understanding that using the Regmap wrappers _prevents_ locking
>>> issues, rather than causes them.
>>
>> In the case where the CPU is being powered off during a regmap write
>> there is a potential issue - as Diogo says if we're in the middle of
>> holding the lock and we power off the CPU that owns the lock then it
>> will never be able to release the lock.  I would expect the same issue
>> to apply to a bus like I2C or SPI though, they'll hold a lock while
>> they're in the middle of doing bus I/O unless you use some special API.
> 
> Sounds bad
> 
> Diogo, check if shutdown works with added nosmp to kernel's cmdline.

So to be clear shutdown already works with regmap_update_bits() and I
have never encountered this deadlock in my testing as the write to power
off the PMIC needs to happen at a very specific timing. I imagine adding
nosmp will just guarantee that the deadlock can never happen.

> BTW, you can use i2c_smbus_read_byte_data+i2c_smbus_write_byte_data to
> keep the old regmap_update_bits behaviour.

My question here is more if this is actually needed or we can skip the
read. In any case the patch that Lee merged is with regmap_update_bits()
so for the time being this is not a problem.

Best regards,
Diogo

