Return-Path: <stable+bounces-146444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F3AAC513C
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F20B16E379
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D6F27A471;
	Tue, 27 May 2025 14:46:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA427A463;
	Tue, 27 May 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748357195; cv=none; b=toVqPhw7e59+9L5g0TQyhPdkhy7c/zwgmCoqKQdAFuDqrMKg1bIhwVIXwyKMgUmDD0vD9lM9j2ReS4NhYzdDM8PS8s6XC408oQEPzzYcd2rdTDfCSgmsGJ/Z9zf+Aa9rERXsSojBDCxBtEIxbLh0pPhVU/B5hTEqOiacv+gGOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748357195; c=relaxed/simple;
	bh=seleYDxgE1umOn/0JRERNNOYBgsMY4pZhxEpoY2e0pY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uofwjebXIzFgmlTAl1qaoEB+N5NzRaWcLu2cBx2Agi08POm79956SH8nQwkXu9fsS51LEVB8PztL6MYBCyZ/SGIeChzIFctlmKsDqCcuchc6vw/bnPQxgEIsLZHyboVs7iV+bGfrbbsT9gyRMmeZG/i/mACWph8ixOTPEsOOwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7C27061E6478F;
	Tue, 27 May 2025 16:45:54 +0200 (CEST)
Message-ID: <f9d9774b-c566-43c1-90a0-f982826c1667@molgen.mpg.de>
Date: Tue, 27 May 2025 16:45:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] e1000e: fix heap overflow in
 e1000_set_eeprom()
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Mikael Wessel <post@mikaelkw.online>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 torvalds@linuxfoundation.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, security@kernel.org, stable@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org
References: <20250527085612.11354-1-post@mikaelkw.online>
 <20250527085612.11354-2-post@mikaelkw.online>
 <7eed2cf1-5d54-4669-9e31-96707a116f01@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <7eed2cf1-5d54-4669-9e31-96707a116f01@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[one addition]

Am 27.05.25 um 16:43 schrieb Paul Menzel:
> Dear Mikael,
> 
> 
> Thank you for your patch.
> 
> Am 27.05.25 um 10:56 schrieb Mikael Wessel:
>> The ETHTOOL_SETEEPROM ioctl copies user data into a kmalloc'ed buffer
>> without validating eeprom->len and eeprom->offset.  A CAP_NET_ADMIN
>> user can overflow the heap and crash the kernel or gain code execution.
>>
>> Validate length and offset before memcpy().
>>
>> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver 
>> (currently for ICH9 devices only)")
>> Reported-by: Mikael Wessel <post@mikaelkw.online>
>> Signed-off-by: Mikael Wessel <post@mikaelkw.online>
>> Cc: stable@vger.kernel.org
>> ---
>>   drivers/net/ethernet/intel/e1000e/ethtool.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/ 
>> net/ethernet/intel/e1000e/ethtool.c
>> index 9364bc2b4eb1..98e541e39730 100644
>> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
>> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
>> @@ -596,6 +596,9 @@ static int e1000_set_eeprom(struct net_device 
>> *netdev,
>>       for (i = 0; i < last_word - first_word + 1; i++)
>>           le16_to_cpus(&eeprom_buff[i]);
>> +        if (eeprom->len > max_len ||
>> +            eeprom->offset > max_len - eeprom->len)
>> +                return -EINVAL;
> 
> I think you used spaces instead of tabs for indentation. It’d be great 
> if you could fix this, and send v3 tomorrow. Running `scripts/ 
> checkpatch.pl` with the patch as an argument, should catch these things.

Should a warning/error be logged if the condition is true?

>>       memcpy(ptr, bytes, eeprom->len);
>>       for (i = 0; i < last_word - first_word + 1; i++)
> 
> 
> Kind regards,
> 
> Paul

