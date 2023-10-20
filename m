Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763E57D1461
	for <lists+stable@lfdr.de>; Fri, 20 Oct 2023 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjJTQub (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 20 Oct 2023 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjJTQua (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Oct 2023 12:50:30 -0400
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF4CA
        for <stable@vger.kernel.org>; Fri, 20 Oct 2023 09:50:25 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1qtshC-0008I3-Ay; Fri, 20 Oct 2023 18:49:58 +0200
Message-ID: <19934aff-0662-4130-8b60-93f7c1e407e2@maciej.szmigiero.name>
Date:   Fri, 20 Oct 2023 18:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 02/68] x86/CPU/AMD: Disable XSAVES on AMD family 0x17
Content-Language: en-US, pl-PL
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, patches@lists.linux.dev,
        Tavis Ormandy <taviso@gmail.com>, stable@kernel.org,
        stable@vger.kernel.org
References: <20230315115726.103942885@linuxfoundation.org>
 <20230315115726.197012029@linuxfoundation.org>
 <d0029d6b-2ddf-4723-ba93-3c7bb9580abc@maciej.szmigiero.name>
 <2023102025-buffer-sneak-b784@gregkh>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <2023102025-buffer-sneak-b784@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 20.10.2023 15:17, Greg Kroah-Hartman wrote:
> On Fri, Oct 20, 2023 at 11:41:13AM +0200, Maciej S. Szmigiero wrote:
>> On 15.03.2023 13:11, Greg Kroah-Hartman wrote:
>>> From: Andrew Cooper <andrew.cooper3@citrix.com>
>>>
>>> commit b0563468eeac88ebc70559d52a0b66efc37e4e9d upstream.
>>>
>>> AMD Erratum 1386 is summarised as:
>>>
>>>     XSAVES Instruction May Fail to Save XMM Registers to the Provided
>>>     State Save Area
>>>
>>> This piece of accidental chronomancy causes the %xmm registers to
>>> occasionally reset back to an older value.
>>>
>>> Ignore the XSAVES feature on all AMD Zen1/2 hardware.  The XSAVEC
>>> instruction (which works fine) is equivalent on affected parts.
>>>
>>>     [ bp: Typos, move it into the F17h-specific function. ]
>>>
>>> Reported-by: Tavis Ormandy <taviso@gmail.com>
>>> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
>>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>>> Cc: <stable@kernel.org>
>>> Link: https://lore.kernel.org/r/20230307174643.1240184-1-andrew.cooper3@citrix.com
>>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>    arch/x86/kernel/cpu/amd.c |    9 +++++++++
>>>    1 file changed, 9 insertions(+)
>>>
>>> --- a/arch/x86/kernel/cpu/amd.c
>>> +++ b/arch/x86/kernel/cpu/amd.c
>>> @@ -205,6 +205,15 @@ static void init_amd_k6(struct cpuinfo_x
>>>    		return;
>>>    	}
>>>    #endif
>>> +	/*
>>> +	 * Work around Erratum 1386.  The XSAVES instruction malfunctions in
>>> +	 * certain circumstances on Zen1/2 uarch, and not all parts have had
>>> +	 * updated microcode at the time of writing (March 2023).
>>> +	 *
>>> +	 * Affected parts all have no supervisor XSAVE states, meaning that
>>> +	 * the XSAVEC instruction (which works fine) is equivalent.
>>> +	 */
>>> +	clear_cpu_cap(c, X86_FEATURE_XSAVES);
>>>    }
>>
>> This is essentially a well-intended NOP since K6 well predates XSAVES,
>> and init_amd_k6() is *not* called for Zen CPUs.
>>
>> This workaround should have been added to init_amd_zn() function
>> instead.
>>
>> 4.19 and 4.14 backports of this patch have the same problem.
> 
> Ick, good catch!  Can you send a set of patches to fix this up?

I can add this to my TODO list, but unfortunately can't promise
a short ETA at this point.

> thanks,
> 
> greg k-h

Thanks,
Maciej

