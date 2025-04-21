Return-Path: <stable+bounces-134879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D1A956C4
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 21:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3231742A9
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 19:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C071E6DC5;
	Mon, 21 Apr 2025 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="blZ2b7+m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B0155A25
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 19:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745263966; cv=none; b=Rch40ETWMFlCyyy1TrgeEq3Nlq0VtyNNmqyUNKeDlNNB/JVqPWYt45CUVuw7KE7MR5QyJ5Xy8yTOTIyh6X9QPYLYFoxiwc/BU56IKW53rNuNTJKJbSoDmbp43NkCSWKy1nHSC297sl361vpt43jrac0Hx92vE5Dbt0TQp6MxWIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745263966; c=relaxed/simple;
	bh=qIbxaMpRyRPS338Tm5o730kOGM0Ig0vZeilxlqEAma0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hA2rDSISFlhiNvQje9tlvINw4K+7K/2VnV1gj9TUqFyXcIr829F7SIg+61KbSToMmp3VXjX1ZIyfacN/J00/n2vaOR3I7FlsRT2AmWo8zX9qWLmYfhdMoQdW8kkHTd1vArQ5iItPjOPNcXLqjHOnz65oEl133HW5Yq/EYuGuOdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=blZ2b7+m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-440685d6afcso41039505e9.0
        for <stable@vger.kernel.org>; Mon, 21 Apr 2025 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1745263963; x=1745868763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/kacNZ/6skUjkEZrrtvXbll6b4DFBykRT2FZt/z4qKo=;
        b=blZ2b7+mv0UAqRQM8qnE2g8A+lgugqxPttrid4l57affSJ/ohmBKel3ld+QJoTPgK9
         nnu9vfB96dGKC4TtfPxX6YYCfLzo+aKwUdbuyPNzZ7j+Foxsnvz0hvs+i8n8f+2LbX0R
         saWvsWWsrCYNcbFvwsd5s9j4xpKSo+vRFkruA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745263963; x=1745868763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kacNZ/6skUjkEZrrtvXbll6b4DFBykRT2FZt/z4qKo=;
        b=IpXiDZRMxBLkLrHMBdUAkVySb9sjzkBPsBtB4/d8IED3YR8fk6SbfqkukEuqFSifWk
         a5diZXgixKx3LzjekQhuvWjpNTFjkFQablICjKI2doRHOm3lwG526Kwv2cSt6nnMLZjl
         Fm2SPqxZt9R8MHH6Wm8y+UBaPWemVIgEC82lT+y4smvKMk4cQerwEq9sqWm3d2nPBohv
         rR3MFTvEgXWcTBqg63R1nHILETet2IOkYp42StLQT98Ve5VFmrZGPX3hBmGkxkmbXvUy
         OEa6snLsaPud2OLP1KfCeYxsmbETTwZrzTm5zDj6cgDkxvNftuZMv6DFYXncnt3YqtlM
         3KeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpm4qbZrCHGS3zCOLjpbKn9RY2lMPEc/e5WJvLnj5gfZER0eqAfdhMSfOhx+m6yvmNJs3hMNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZgYn79R92bQlR7J4lsGd3rBqDDa8vsATzpe4XFyl1HfgUyhK
	87v5JvEpWrsbIUUiZJRq0Cm1xAfR4f8gGAUigZ0bRNsGoyvvkphOha/gLpzjqsE=
X-Gm-Gg: ASbGncshek5mGq19w+NT1qckpVp1YECHmUwdD+6i56iaWpy4o1TinxcRYtBOWF/vN34
	Eb1+6/UocdrC0e9cvIi9WC3miJ/VDLl2dOPC5CQBA7zg1aPgxG6TS3+q0g/fOcrd8573I5N0FXg
	7EsufVsonJT2R7/VIdM9f4y0CJcjAlvcBzMPuRchX56bf9AexCGC9Jr68XGloBJ/U7FLNwDgbhU
	kuZhVe6DAWhLwFeS5Ge/AJ1w0Jtq/rcGxSAJnQCS3B8RrMWRYWo7scnFlBdVMeso4XcpX4zIsau
	PmRudjQ29KOKklSK7JyqCTbH7ZB909YmjLQAxxhR5AULd+gH6nSoRQ==
X-Google-Smtp-Source: AGHT+IEWF27e2Lk3TsGhhPtp8i9MuVYFTgyYsjytcbKCN2ZLg9KCqINVbRgQ08dNGo3HiHLFyWP2HA==
X-Received: by 2002:a05:6000:40dc:b0:39c:30cd:352c with SMTP id ffacd0b85a97d-39efba383bbmr9041307f8f.8.1745263962782;
        Mon, 21 Apr 2025 12:32:42 -0700 (PDT)
Received: from [192.168.86.29] ([83.104.178.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43319csm12972645f8f.38.2025.04.21.12.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 12:32:42 -0700 (PDT)
Message-ID: <6142d360-889d-44bb-9a94-b5d2084f90e9@citrix.com>
Date: Mon, 21 Apr 2025 20:32:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Handle Ice Lake MONITOR erratum
To: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Len Brown <len.brown@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 stable@vger.kernel.org, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Frediano Ziglio <frediano.ziglio@cloud.com>
References: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <20250421192205.7CC1A7D9@davehans-spike.ostc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/04/2025 8:22 pm, Dave Hansen wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> Andrew Cooper reported some boot issues on Ice Lake servers when
> running Xen that he tracked down to MWAIT not waking up. Do the safe
> thing and consider them buggy since there's a published erratum.
> Note: I've seen no reports of this occurring on Linux.
>
> Add Ice Lake servers to the list of shaky MONITOR implementations with
> no workaround available. Also, before the if() gets too unwieldy, move
> it over to a x86_cpu_id array. Additionally, add a comment to the
> X86_BUG_MONITOR consumption site to make it clear how and why affected
> CPUs get IPIs to wake them up.
>
> There is no equivalent erratum for the "Xeon D" Ice Lakes so
> INTEL_ICELAKE_D is not affected.
>
> The erratum is called ICX143 in the "3rd Gen Intel Xeon Scalable
> Processors, Codename Ice Lake Specification Update". It is Intel
> document 637780, currently available here:
>
> 	https://cdrdv2.intel.com/v1/dl/getContent/637780
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: stable@vger.kernel.org

CC Roger/Frediano, who did most of the work here.  (I mostly just talked
to people).

https://lore.kernel.org/xen-devel/20250417161913.14661-1-roger.pau@citrix.com/T/#u

~Andrew

>
> ---
>
>  b/arch/x86/include/asm/mwait.h |    3 +++
>  b/arch/x86/kernel/cpu/intel.c  |   17 ++++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff -puN arch/x86/kernel/cpu/intel.c~ICX-MONITOR-bug arch/x86/kernel/cpu/intel.c
> --- a/arch/x86/kernel/cpu/intel.c~ICX-MONITOR-bug	2025-04-18 13:54:46.022590596 -0700
> +++ b/arch/x86/kernel/cpu/intel.c	2025-04-18 15:15:19.374365069 -0700
> @@ -513,6 +513,19 @@ static void init_intel_misc_features(str
>  }
>  
>  /*
> + * These CPUs have buggy MWAIT/MONITOR implementations that
> + * usually manifest as hangs or stalls at boot.
> + */
> +#define MWAIT_VFM(_vfm)	\
> +	X86_MATCH_VFM_FEATURE(_vfm, X86_FEATURE_MWAIT, 0)
> +static const struct x86_cpu_id monitor_bug_list[] = {
> +	MWAIT_VFM(INTEL_ATOM_GOLDMONT),
> +	MWAIT_VFM(INTEL_LUNARLAKE_M),
> +	MWAIT_VFM(INTEL_ICELAKE_X),	/* Erratum ICX143 */
> +	{},
> +};
> +
> +/*
>   * This is a list of Intel CPUs that are known to suffer from downclocking when
>   * ZMM registers (512-bit vectors) are used.  On these CPUs, when the kernel
>   * executes SIMD-optimized code such as cryptography functions or CRCs, it
> @@ -565,9 +578,7 @@ static void init_intel(struct cpuinfo_x8
>  	     c->x86_vfm == INTEL_WESTMERE_EX))
>  		set_cpu_bug(c, X86_BUG_CLFLUSH_MONITOR);
>  
> -	if (boot_cpu_has(X86_FEATURE_MWAIT) &&
> -	    (c->x86_vfm == INTEL_ATOM_GOLDMONT ||
> -	     c->x86_vfm == INTEL_LUNARLAKE_M))
> +	if (x86_match_cpu(monitor_bug_list))
>  		set_cpu_bug(c, X86_BUG_MONITOR);
>  
>  #ifdef CONFIG_X86_64
> diff -puN arch/x86/include/asm/mwait.h~ICX-MONITOR-bug arch/x86/include/asm/mwait.h
> --- a/arch/x86/include/asm/mwait.h~ICX-MONITOR-bug	2025-04-18 15:17:18.353749634 -0700
> +++ b/arch/x86/include/asm/mwait.h	2025-04-18 15:20:06.037927656 -0700
> @@ -110,6 +110,9 @@ static __always_inline void __sti_mwait(
>   * through MWAIT. Whenever someone changes need_resched, we would be woken
>   * up from MWAIT (without an IPI).
>   *
> + * Buggy (X86_BUG_MONITOR) CPUs will never set the polling bit and will
> + * always be sent IPIs.
> + *
>   * New with Core Duo processors, MWAIT can take some hints based on CPU
>   * capability.
>   */
> _


