Return-Path: <stable+bounces-233188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGHXNxjSz2mY0wYAu9opvQ
	(envelope-from <stable+bounces-233188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:43:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE06395580
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBD7F30352AF
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C4392802;
	Fri,  3 Apr 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="OrdMA92W"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC634753B
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227333; cv=none; b=dWYmLtjziYywzzxMLbh3G5y7MdfxQwsIQ+BAYFBBs6udJoi1RQ5nthtAYFKnvxc0gFsp9hvI8BhhGFX5kgI5YPbT/yiL4IyAFJfkM25Tg1QjyFelaDiuWt2FMFrOkocyr67Cs9/wGIUGIjLTB3e8HRYVoVKya2ydDjYxStehoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227333; c=relaxed/simple;
	bh=3vVkIcNYIIdq5Dkb4dWOz1OUuravUKeK17twdeeJ21g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAuQfZRupKPA1iZptbmFpSQXEsmT44rbjYbzmpbQQqwA3zJJSVtpDA5d5JMeKKyP6oHGHIvHEwWPaek2c1QgSQzFqyzX+uTijhE5uyoWu14YDo1LtBjsoAtP8mGZNNUAtLBXfS/CNO8Mr2UcpC/sTAXIuHndDDR14tvApNhu0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=OrdMA92W; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso18575805e9.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1775227331; x=1775832131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWTR6rblr2fx5wm1rQ9MFyWeL459JHJEvbHasb5FYls=;
        b=OrdMA92Whdc4h/UpXzNfoRN2hywQJKhrLrECsCzJ+ROaAaNAAqizS7imk8S0Kd0bch
         1qKteftT5zcnYQN/BjsTvgGuWVaNrFpHja3qjbzQIEu5zsMbqCLeXYA58/JREdjO8oW5
         kVBv1z6V3nbsnj5RurqMUlI3lyyhk6Yvd89hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775227331; x=1775832131;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LWTR6rblr2fx5wm1rQ9MFyWeL459JHJEvbHasb5FYls=;
        b=ReZCQVGxPFwvmsaQG2Fu6zjvvAhP/xSTt4fS3j4of8CEaBF0k2PV1rHQzhwjH59Aym
         wexfZrw2pn2tfHyuXRwtMBWhan6ORcMC45yO6zTgJUCKpxZDaLlNpGzxeMjaNY2b6ODH
         n3wa/0nZaXznFAgrR4HmTAjLYL7YnXfJCd+jRsnv/ChhSJa0jy9hQUtMgoD1eCw1cP32
         rpatkjkqzx4e0CX5z8c4fz1+47QjC5Zp7OguJgsobvdXinolhR6mUx6BiT5eKTcd9YjM
         3s2bXyDXf5Ks8qhEWNsYRNd7Vbi6m7mg0rCXMc4YK3hawUOVsTuXqqRq/kdLobCtxpr7
         NZNw==
X-Forwarded-Encrypted: i=1; AJvYcCWPb2k1W8EdZlFMaFNPcj1Dzmwh4kXZyYJHnhmVYtKfaQczoUdVjgKpk2NRKXr33GtvNkRHnk8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WUjcbUI+fOTRhVx3AmAmWjfuAgFM5V83mtWSSG6tBWWx1170
	NEhcc3nx/O/wRqVpfJhrp5okzDBuTbMHyZnaZLt988uGZ0/cP8NcevurPS4mGZgekkQ=
X-Gm-Gg: ATEYQzzkYRFgHLFpt3RgLzwFupf9mvGxmlr0F8u6pCKjMkR0vPbxve05TdXEvYbT9gd
	iR5mCU6I4wCk4MH6Ikg0D/5gU2yHCT2LX/1bNxJRqTBihCnToMLzg0YwQfqfynSaPeyU4tpZVb7
	Vm3ha+m2ZqI+/OX9b3UsAGpsm1wnmAcwCe/zd5R/n6QrZxbovMgJX8phnKiUnL1GhsiDNoV8Gki
	8/AUvGhQr8k5M+ygfb0NUSuyn7lcCkjNaTKPPjiP4Lrf23nnQ9SktdsWsmlBUhxDPyVMWmLWxe7
	O/iraPruobwIXc+/XYSdRjMtZSRKgPjzdDVd+pb4Uml/6ZEldA/EFhEylOUyG3D+cfKEtqwu133
	dDPSpjcMIUezl51r/Hq3IRcqcb7OB4PgwLTzogZ56bzTNA6Sigt03c0FkmRgmAUlutGrd/Qwbpy
	/InQzEFkvXwIWsgsWwHNFMF1qIt2zGqjLTG2mbEV/Anawq07INz/h/aj/hQ3IqYGmTbyPCMGIop
	G1fZCKS8+dPt1WAD2rL3JSUsFElv3gzIyp5sAFY19P+VGxyeZmkfo33mXumXjdhFg==
X-Received: by 2002:a05:600c:4e14:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-488996afed9mr53212995e9.5.1775227330527;
        Fri, 03 Apr 2026 07:42:10 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:94a2:a200:2ad9:827a:59cb:148a? (2a01cb0594a2a2002ad9827a59cb148a.ipv6.abo.wanadoo.fr. [2a01:cb05:94a2:a200:2ad9:827a:59cb:148a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889cb46adcsm45021385e9.4.2026.04.03.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 07:42:10 -0700 (PDT)
Message-ID: <5725f03b-2750-428f-ae66-5f1a24dd0714@smile.fr>
Date: Fri, 3 Apr 2026 16:42:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update delay select values
 for MMC1/2 subsystems
To: Moteen Shah <m-shah@ti.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 kristo@kernel.org, vigneshr@ti.com, nm@ti.com, stable@vger.kernel.org
References: <20260218203823.1825554-1-romain.naour@smile.fr>
 <8d4a2839-5b1e-479e-a462-dbbc3d016020@ti.com>
From: Romain Naour <romain.naour@smile.fr>
Content-Language: fr, en-US
In-Reply-To: <8d4a2839-5b1e-479e-a462-dbbc3d016020@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[smile.fr,reject];
	R_DKIM_ALLOW(-0.20)[smile.fr:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[smile.fr:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233188-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[romain.naour@smile.fr,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,smile.fr:dkim,smile.fr:email,smile.fr:mid,4f98000:email,ti.com:email,ti.com:url]
X-Rspamd-Queue-Id: CCE06395580
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Moteen, All,

Le 31/03/2026 à 14:19, Moteen Shah a écrit :
> Hey Romain,
> 
> Thanks for the patch
> 
> On 19/02/26 02:08, Romain Naour wrote:
>> The previous SPRSP36J datasheet recommends to set ti,otap-del-sel-sd-hs
>> value to 0 for MMC1 and MMC2 interfaces. These values were updated in
>> kernel 6.5. As a result we have some occasional regression with ultra
>> high speed DDR50 SDXC cards while mounting the rootfs:
> 
> This error shouldn't be limited to just DDR50, were you seeing similar behavior
> with other speed modes?

I have a followup patch to enable back the SDR104 support with j721e SoC (SR 1.1
and 2.0) and I noticed the same behavior with some "specific" SDcards.

The J721e SR 1.0 doesn't support SDR104 due to an errata.
Nowadays, even the TI J721e EVM board revA (reference board) uses a SR1.1 SoC.

See the post on TI forum with further analysis:

https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1626659/dra829j-q1-mmcsd-ultra-high-speed-uhs-modes-issues

It turnout that the kernel is not able to detect UHS speed with some SDcards
vendors after uboot initialized them with UHS speed (SDR104). I'm not sure why.

Still, the datasheet was updated with a new set of timing values for HS and
legacy speed.

Maybe I should remove the part about SD card initialization issues, it may be
related to another issue.

>>
>>    mmc1: error -110 whilst initialising SD card
>>
>> A similar issue may occur with u-boot after a reboot while
>> initialising the SD card:
>>
>>    mmc_init: -110, time 67
>>
>> Update the delay values for legacy and high speed modes, based on
>> the latest revised datasheet SPRSP36K released in April 2024 [1].
>>
>>    (MMC1/2 - SD/SDIO Interface): Updated/Changed the
>>    "OTAPDLYENA, DELAY ENABLE" and "OTAPDLYSEL, DELAY VALUE" for the
>>    Default Speed and High Speed modes from "0x0" to "0x1"
>>
>> [1] Table 6-86. MMC1/2 DLL Delay Mapping for All Timing Modes, in
>> https://www.ti.com/lit/ds/symlink/tda4vm.pdf,
>> (SPRSP36K – SEPTEMBER 2021 – REVISED APRIL 2024)
>>
>> Cc: stable@vger.kernel.org # 6.5+
>> Fixes: af398252d68e ("arm64: dts: ti: k3-j721e-main: Update delay select
>> values for MMC subsystems")
>> Signed-off-by: Romain Naour <romain.naour@smile.fr>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/
>> ti/k3-j721e-main.dtsi
>> index d5fd30a01032..418e6010ef1f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -1643,8 +1643,8 @@ main_sdhci1: mmc@4fb0000 {
>>           clocks = <&k3_clks 92 5>, <&k3_clks 92 0>;
>>           assigned-clocks = <&k3_clks 92 0>;
>>           assigned-clock-parents = <&k3_clks 92 1>;
>> -        ti,otap-del-sel-legacy = <0x0>;
>> -        ti,otap-del-sel-sd-hs = <0x0>;
>> +        ti,otap-del-sel-legacy = <0x1>;
>> +        ti,otap-del-sel-sd-hs = <0x1>;
>>           ti,otap-del-sel-sdr12 = <0xf>;
>>           ti,otap-del-sel-sdr25 = <0xf>;
>>           ti,otap-del-sel-sdr50 = <0xc>;
>> @@ -1671,8 +1671,8 @@ main_sdhci2: mmc@4f98000 {
>>           clocks = <&k3_clks 93 5>, <&k3_clks 93 0>;
>>           assigned-clocks = <&k3_clks 93 0>;
>>           assigned-clock-parents = <&k3_clks 93 1>;
>> -        ti,otap-del-sel-legacy = <0x0>;
>> -        ti,otap-del-sel-sd-hs = <0x0>;
>> +        ti,otap-del-sel-legacy = <0x1>;
>> +        ti,otap-del-sel-sd-hs = <0x1>;
>>           ti,otap-del-sel-sdr12 = <0xf>;
>>           ti,otap-del-sel-sdr25 = <0xf>;
>>           ti,otap-del-sel-sdr50 = <0xc>;
> 
> 
> Reviewed-by: Moteen Shah <m-shah@ti.com>

Thanks!

Best regards,
Romain

> 
> Regards,
> Moteen
> 


