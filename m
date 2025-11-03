Return-Path: <stable+bounces-192226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 500A8C2D09C
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB90C1884E65
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FE631579B;
	Mon,  3 Nov 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J67R47cw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Ki0RdvF"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54040314D34;
	Mon,  3 Nov 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186378; cv=none; b=ZkRjCINMzHCIMIJBraLq8hcjLiRY79hTOu9lhJoiEVQmfs4Li/Fj9+qvFtrD5dRpZbsHZ5FOEopIoNHiXisbucotqaduhEvBY+7nf6rM9+njk7rX1Eb1dJmqT6F5ZD62YZdX//CaUgFAYDqNoKfZHJADd3Mu5yYzraJxUxLxKDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186378; c=relaxed/simple;
	bh=oc90fEdM5Sak359pU8Gkz9mTWuX0+8Esz9enp4sqwq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbB93KkFgiM+wxk5NWOyEFQwn3fxMdXcS3grdf32JmdfYTIbGlMVLKfxamJS0gmTR8qRQsUmE7x8kndUXf2zQzJ5iJDs+hlj5jxo6YEovyzy2svoWdYVWaiTmIHMF7KM3R3zcXbNvSDAw5mRxY/nlubcjdISQOhXfF7pE2pQjQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J67R47cw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Ki0RdvF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762186375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBHLn6tvAwx686O8GxZfsUgcS5/YK8VNBPdnsSAmQ6o=;
	b=J67R47cwNSrF1uJUuWP+Te/nOY/l2yooxtkOBpxpo3nlgyWUEO/LLdeb0nEdvCsxFBI15I
	pnjBz0NLaklbAuug4oMhsTU4fgPhC6viXsVxQxYRYE/qEzDK3kncdSgFem395JnfEtehtI
	taaGsmjHpHpQ70CuHurauQavLSNLdt028nG5PQQb39EZySt2Dql6nZkZkUoi8xgwi+jwOq
	xxTokAuajEgQOfSQaaYmPh9qCjk8Q6chdazh/GK83gq7Dz6Q4HySHrMPZ3xlI9qOck8JnZ
	6bZhlnJ0hsmb086V3XDkk9O75NygEb0xzuAFtMpFejBIqsWN7iEIqnvKBT74Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762186375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBHLn6tvAwx686O8GxZfsUgcS5/YK8VNBPdnsSAmQ6o=;
	b=9Ki0RdvFD9IT0eEZRX0PiYKm4Rb93LiQZD4UUwqi++Q9QvZnIrb+PF89SYWXfwGWaueIKi
	yTx6XqNDbqJGzbCA==
To: Peter Jung <ptr1337@cachyos.org>, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org
Cc: stable@vger.kernel.org, Gregory Price <gourry@gourry.net>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/CPU/AMD: Add RDSEED fix for Zen5
In-Reply-To: <9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org>
References: <176165291198.2601451.3074910014537130674.tip-bot2@tip-bot2>
 <9a27f2e6-4f62-45a6-a527-c09983b8dce4@cachyos.org>
Date: Mon, 03 Nov 2025 17:12:54 +0100
Message-ID: <878qgnw0vt.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 03 2025 at 14:59, Peter Jung wrote:
>>   static void init_amd_zen5(struct cpuinfo_x86 *c)
>>   {
>> +	if (!x86_match_min_microcode_rev(zen5_rdseed_microcode)) {
>> +		clear_cpu_cap(c, X86_FEATURE_RDSEED);
>> +		msr_clear_bit(MSR_AMD64_CPUID_FN_7, 18);
>> +		pr_emerg_once("RDSEED32 is broken. Disabling the corresponding CPUID bit.\n");
>> +	}
>>   }
>>   
>>   static void init_amd(struct cpuinfo_x86 *c)
>
> This fix seems to break quite a bunch of users in CachyOS. There has 
> been now several users reporting that there system can not get properly 
> into the graphical interface.
>
> CachyOS is compiling the packages with -march=znver5 and the GCC 
> compiler currently does pass RDSEED.

You get what you ask for. You build a binary for a CPU which does
not provide a functional correct RDSEED16/32 instruction.

> This patch results into that also Client CPUs (Strix Point, Granite 
> Ridge), can not execute this. There has been a microcode fix deployed in 
> linux-firmware for Turin, but no other microcode changes seen yet.
>
> I think it would be possible to exclude clients or providing a fix for this.

There are only two fixes:

      1) New microcode

      2) Fix all source code to either use the 64bit variant of RDSEED
         or check the result for 0 and treat it like RDSEED with CF=0
         (fail) or make it check the CPUID bit....

New microcode will come around soon and fixing all source code is not
possible.

Excluding clients is not an option because that leaves anything crypto
related which relies on randomness with a big hole. Clients require
functional crypto as much as any other system, no?

So the only workaround for now is to use a build which does not emit
RDSEED or checks CPUID for availability before blindly using it.

Thanks,

        tglx

