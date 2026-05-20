Return-Path: <stable+bounces-249921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPOLHXi1DWrC2QUAu9opvQ
	(envelope-from <stable+bounces-249921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:22:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD8C58EB0F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 15:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C75933003ECA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA6936F901;
	Wed, 20 May 2026 13:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtFKd/RU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811033A5422;
	Wed, 20 May 2026 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282885; cv=none; b=fn+7WAU0EUlD0d62JZTptWsnyEw973a6O9uZ2ceeHc+3ABZVsqW5gCyBM3RGgBCybT1Qg3Kg31J8UZGKgGewjoKnGJukyug2OiUFwvIh9Rou4zD6q+P/5FCUEKks/xbOcs/5k80oc5zkvKAdkXUzbTA3xTssklNy5Mt1VJiuuPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282885; c=relaxed/simple;
	bh=oCX6LzuHEIZ80SfFpRg85U8MqMeSIwOu5BKVOPaWPa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjAOPfHuHr1KKnkaXpRKea3lX5O8v9u6+YYei3cmLp4Fr2AG2hXB154bXhm+BAfyBTdaapX8atGhbBMev9x93IhwaOdtre6i7vjUXwMn0lDyCEKBdZlCqUXBkWrggEc8PzDI3rUPgOGc57VPkgiDeV9gnVpVOImBasZPTN9j2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtFKd/RU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB741F000E9;
	Wed, 20 May 2026 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779282884;
	bh=l61V1ePK9sHn8zK/nyVF01xCrG/hivVTbasBGpfgkw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DtFKd/RUIPItLf4gpuOm3HWcKU/PTmroifXHUuLxoG70/aGDn/BMeQrB2QqNukF6F
	 bUGpfLKoIwAT5eh1c49OyEV4OjGApVaf2ulIqKD6+PO+8kN0r/CulxUhT2dbuUwIZt
	 Gb1SJL1KcoEnPUMas1hQw1z/gfAOCXoED1kZJMjquq72Y33ifvkkAsZAx1cDTD6IFU
	 vJs710X8uTMIpigJU/GVTwqd/shgYu7lUweFwhGSW0FaYpJimt8RUCvkLyVSn5lFMV
	 IklwB+OIea1Hh/z/2apPwKTF8pEJNXm7ATKqPl92VcLI3mwJKARrYYX8aQvniyJcFZ
	 kctjIHTa51NRg==
Message-ID: <eb93d563-7042-458e-a5c0-b5389343d41b@kernel.org>
Date: Wed, 20 May 2026 15:14:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: define __LITTLE_ENDIAN and __BIG_ENDIAN for
 math-emu
To: David Laight <david.laight.linux@gmail.com>,
 Mingcong Bai <jeffbai@aosc.io>
Cc: linux-kernel@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>,
 Kexy Biscuit <kexybiscuit@aosc.io>, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20260517041423.71243-1-jeffbai@aosc.io>
 <20260517145421.2d1ac77c@pumpkin>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260517145421.2d1ac77c@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249921-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,aosc.io];
	FREEMAIL_CC(0.00)[vger.kernel.org,xry111.site,aosc.io,intel.com,linux.ibm.com,ellerman.id.au,gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,aosc.io:email]
X-Rspamd-Queue-Id: CCD8C58EB0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 17/05/2026 à 15:54, David Laight a écrit :
> On Sun, 17 May 2026 12:14:21 +0800
> Mingcong Bai <jeffbai@aosc.io> wrote:
> 
>> Similar to commit b929926f01f2 ("sh: define __BIG_ENDIAN for math-emu"),
>> define __LITTLE_ENDIAN and __BIG_ENDIAN as 0 to mitigate build-time
>> warnings:
>>
>>    ./include/math-emu/double.h:59:21: error: ‘__BIG_ENDIAN’ is not defined, evaluates to ‘0’ [-Werror=undef]
>>       59 | #if __BYTE_ORDER == __BIG_ENDIAN
>>          |
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 13da9e200fe4 ("Revert "endian: #define __BYTE_ORDER"")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Foe-kbuild-all%2F202507301656.7FEX6J5W-lkp%40intel.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C08977974fb1c495e9bd508deb41bd275%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639146228768693730%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=4qGulR%2BL7i7inksEbEH9jNGZS8HG80uvm3I9IyYzZww%3D&reserved=0
>> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
>> ---
>>   arch/powerpc/include/asm/sfp-machine.h | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
>> index 8b957aabb826d..db8525605c026 100644
>> --- a/arch/powerpc/include/asm/sfp-machine.h
>> +++ b/arch/powerpc/include/asm/sfp-machine.h
>> @@ -319,10 +319,12 @@
>>   #define abort()								\
>>   	return 0
>>   
>> -#ifdef __BIG_ENDIAN
>> +#ifdef __BIG_ENDIAN__
>>   #define __BYTE_ORDER __BIG_ENDIAN
>> +#define __LITTLE_ENDIAN 0
>>   #else
>>   #define __BYTE_ORDER __LITTLE_ENDIAN
>> +#define __BIG_ENDIAN 0
>>   #endif
> 
> I thought the expected/correct value for __BYTE_ORDER__ was either 1234 or 4321.
> (apart from pdp11's 2143).

That's the case, in include/linux/kconfig.h we have:

#ifdef CONFIG_CPU_BIG_ENDIAN
#define __BIG_ENDIAN 4321
#else
#define __LITTLE_ENDIAN 1234
#endif

But as far as I understand the problem is that math-emu expects 
__BIG_ENDIAN to be defined at all time as it has tests like:

#if __BYTE_ORDER == __BIG_ENDIAN

Christophe


