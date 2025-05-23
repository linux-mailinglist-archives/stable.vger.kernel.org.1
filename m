Return-Path: <stable+bounces-146152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7951AC1AC8
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 05:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321C31B68446
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 03:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42EF22129A;
	Fri, 23 May 2025 03:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KsvorOcf"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E8519ADBF;
	Fri, 23 May 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747972166; cv=none; b=q7tY1Jxh73GqjMuwRT430GCtbXAhgK5c6nTb3JcS5RbFpxQbbtVtZlIruBy1Z1wCt0L3usqqXDp3Tc/vJX/Wws/RramYu5ANR6c3V/5plRJzVHUnEBcFnAGXgnZVR1KOBQ7tEvi7HtAQX1X0YwfxFVC7eCE+2su5IH+cvPaQG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747972166; c=relaxed/simple;
	bh=DpSrGOdy7vLavJphaFDZF+lJ+ZUz8BU9EXeH3ZXqCNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZniTkMhIvoXFkKyOrYS0oJS2wRR2eO90/gjlsg2ubUpIK6GXvJeQY+gVvzM7FrsfXkVoFaAEvHYgWf6Qu7Ir8HzzTZreBphF8YqTso+Hr9HdjvF60nxddqo6e4oc92jRV/MYVSmMRQ967yUYXPZVG76BempN/NtwJIe6O37qV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KsvorOcf; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9485:40c5:16f6:92c4:44cf] ([IPv6:2601:646:8081:9485:40c5:16f6:92c4:44cf])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54N3mnmB3287516
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 May 2025 20:48:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54N3mnmB3287516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747972131;
	bh=0+y2JN5llR4Gfib/fV4eg/92zfayiIPRRtSpX9qWiZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KsvorOcfwMjV5DhjJYlk6PqGAVVBpdo0Ay1mKoNEc4uDj+UAZiqUPyoqsmCWbxXBt
	 5AozE/rs2TmbAPrLdB12URBcs+Vcnv5nz3AmXmCznoSOCmSYQNwGRQdolL6KivCIEN
	 TKMLmne7KOEZIffr+Q0zBIqTAVIiTOgxDdNR0X6Q5vONA9ugMDa+3ZiXmsaF3dg4GQ
	 UhGlekNxErudGxzw7RhnGfX3WYh/DQogo2GKhQnIS9hJ21mDzZGjHVjV7EK9NfrI/Z
	 qsGxMXEdA6qTSFht5d+dKN/MKJp+OIJTxX6KPMfh8Z+1IepQhAqHj25oMSi807WIlZ
	 j/ZI9lBARF8JA==
Message-ID: <ec1af0a2-d07a-4963-bae7-8a7f559798bd@zytor.com>
Date: Thu, 22 May 2025 20:48:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/fred/signal: Prevent single-step upon ERETU
 completion
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@intel.com>, "Xin Li (Intel)" <xin@zytor.com>,
        linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        stable@vger.kernel.org
References: <20250522171754.3082061-1-xin@zytor.com>
 <e4f1120b-0bff-4f01-8fe7-5e394a254020@intel.com>
 <ad8d3a12-25f3-4d57-8f34-950b7967f92b@citrix.com>
 <3D4D48D6-D6E7-4391-8DCF-6B9D307FE2E2@zytor.com>
 <0a4db439-e402-4b6a-8aba-79a3c0398d9a@citrix.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <0a4db439-e402-4b6a-8aba-79a3c0398d9a@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/22/25 17:10, Andrew Cooper wrote:
>>>
>>> ~Andrew
>> SIGTRAP → sigreturn. Basically, we have to uplevel the suppression behavior to the kernel (where it belongs) instead of doing it at the ISA level. 
> 
> So the problem is specifically that we're in a SYSCALL context (from
> FRED's point of view), and we rewrite state in the FRED FRAME to be
> another context which happened to have eflags.TF set.
> 
> And the combination of these two triggers a new singlestep to be pending
> immediately.
> 
> I have to admit that I didn't like the implication from the SYSCALL bit,
> and argued to have it handled differently, but alas.  I think the real
> bug here is trying to ERETU with a splice of two different contexts
> worth of FRED state.
> 

To some degree it is, yes. And it is sigreturn that does that splicing.

But it is desirable to be able to single-step across sigreturn if one is
debugging from inside the signal handler, hence we should not clearing
TF if it is set on sigreturn entry.

This is in fact exactly analogous to ERETU ignoring the syscall bit if
TF is set before ERETU is executed, just one abstraction level higher up
in the stack.

	-hpa


