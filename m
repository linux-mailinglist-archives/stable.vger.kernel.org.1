Return-Path: <stable+bounces-23827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFB868A04
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C96428416C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 07:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FF654BF1;
	Tue, 27 Feb 2024 07:40:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7F54BD4
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 07:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019632; cv=none; b=YggDVJzQVgasBRJ1Q28hQ8vudtE8+2W/8qgAZyuISZhluUb5lslVGh7u10/n8M+VU27UfSkWy74r9UrE5IBaypwF92kAhkCFu+abkNZyoW1yu1R25Yp9bx4tg1/+89qVVFPL4HEzjsfzD0UoKbzJwrg6u2IgwuqJkbyb74d1/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019632; c=relaxed/simple;
	bh=IbZRrApKvVBTqa6t9bu3YUlECuTVkrYMA+TzfrKR0Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkbeYqKA+tHcjsvIg76FIe6XfdtznFoXmyVNtZtmS2nHp6WrCicQ5M97TBahVZpT81Uoc0F1lWhP5LhaOG+Lr0bisXzt1u6ac0ko6EhA71gBpbetNUClc2ccMHnUoudEC8m3cI5BeCbwggbpAw5lFRAjqNGdgCtY/xkQCcoPM8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d26227d508so44649241fa.2
        for <stable@vger.kernel.org>; Mon, 26 Feb 2024 23:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709019629; x=1709624429;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmnmq95VpVjDDghP0aqnJnXM8+laf042268HXPoa1JU=;
        b=UkwWXgNt+opA1OlSJ9gGAr8px+64J0F/a5uiyBt58rWZFrC1yvA5L1sB/vFthdKKcL
         ag6wpx51sUmA7vLiByCV/ts6anhIBhMlEKjwE4bSqcKOxBAKho7lVj6w4pT0nHucAhAN
         15QEACLzLpsvf3MgMXxzf8oOnXrez/ool550UC030VFAaQrcF4LSOb7dbN+Ak/8Zplv9
         W9xL/0qbG6c1IleFsJT0RDxGOdpF/zzQozP+QmlOShAWzqxVSMynpc9ruaEhO7Fc8WWg
         jUdHWHL3lsq4cPnodfXtTCs+TmFCrApPo+RVRIdKlx+HdBFNGpyJgAy3jAtiGQR9iXf4
         gF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVFLsXF9WK2nNj7pLRQ1cdZ9Uzqo+ng5o4yBWYqt3yzZLFrQHubU18q1Ym+4RhQLo0492cKLICafsZH9C4LqKTxb1YGQSt
X-Gm-Message-State: AOJu0YwKkiSAh8zdrJV0iyjiXDTJO6oSTNmVM+q+JSeqpdPbQPo1TP1W
	hRIVqG1ogVgLiH9jk96r+czvZjLSKMP31rqfhaprdOqvUZwWJZsOVpadHffr
X-Google-Smtp-Source: AGHT+IFPvxp9IAU65gsmu3PZNLdbZnRQenZH+Sb17gPmbyB7kCFCRBPYOhAMC/4ZO5Y+LBP/rq28oQ==
X-Received: by 2002:a05:651c:226:b0:2d2:2cb4:f80d with SMTP id z6-20020a05651c022600b002d22cb4f80dmr5079079ljn.10.1709019628374;
        Mon, 26 Feb 2024 23:40:28 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c358b00b00412a813e4cfsm3780986wmq.34.2024.02.26.23.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 23:40:27 -0800 (PST)
Message-ID: <c9ede8e2-5066-435b-bd1d-1971a8072952@kernel.org>
Date: Tue, 27 Feb 2024 08:40:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7.y 1/6] x86/bugs: Add asm helpers for executing VERW
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org
Cc: Alyssa Milburn <alyssa.milburn@intel.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20240226-delay-verw-backport-6-7-y-v1-0-ab25f643173b@linux.intel.com>
 <20240226-delay-verw-backport-6-7-y-v1-1-ab25f643173b@linux.intel.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240226-delay-verw-backport-6-7-y-v1-1-ab25f643173b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27. 02. 24, 6:00, Pawan Gupta wrote:
> commit baf8361e54550a48a7087b603313ad013cc13386 upstream.
> 
> MDS mitigation requires clearing the CPU buffers before returning to
> user. This needs to be done late in the exit-to-user path. Current
> location of VERW leaves a possibility of kernel data ending up in CPU
> buffers for memory accesses done after VERW such as:
> 
>    1. Kernel data accessed by an NMI between VERW and return-to-user can
>       remain in CPU buffers since NMI returning to kernel does not
>       execute VERW to clear CPU buffers.
>    2. Alyssa reported that after VERW is executed,
>       CONFIG_GCC_PLUGIN_STACKLEAK=y scrubs the stack used by a system
>       call. Memory accesses during stack scrubbing can move kernel stack
>       contents into CPU buffers.
>    3. When caller saved registers are restored after a return from
>       function executing VERW, the kernel stack accesses can remain in
>       CPU buffers(since they occur after VERW).
> 
> To fix this VERW needs to be moved very late in exit-to-user path.
> 
> In preparation for moving VERW to entry/exit asm code, create macros
> that can be used in asm. Also make VERW patching depend on a new feature
> flag X86_FEATURE_CLEAR_CPU_BUF.
...
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -315,6 +315,17 @@
>   #endif
>   .endm
>   
> +/*
> + * Macro to execute VERW instruction that mitigate transient data sampling
> + * attacks such as MDS. On affected systems a microcode update overloaded VERW
> + * instruction to also clear the CPU buffers. VERW clobbers CFLAGS.ZF.
> + *
> + * Note: Only the memory operand variant of VERW clears the CPU buffers.
> + */
> +.macro CLEAR_CPU_BUFFERS
> +	ALTERNATIVE "", __stringify(verw mds_verw_sel), X86_FEATURE_CLEAR_CPU_BUF

Why is not rip-relative preserved here? Will this work at all (it looks 
like verw would now touch random memory)?

In any way, should you do any changes during the backport, you shall 
document that.


-- 
js
suse labs


