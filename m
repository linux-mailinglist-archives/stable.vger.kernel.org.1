Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54236700681
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 13:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbjELLRK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 07:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbjELLRJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 07:17:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB941725
        for <stable@vger.kernel.org>; Fri, 12 May 2023 04:17:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so1617706066b.2
        for <stable@vger.kernel.org>; Fri, 12 May 2023 04:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683890226; x=1686482226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zX83G+HWjSh7ntCyH77Wv+4FjrcukJO0fyqlvxTR/Ac=;
        b=Duq7YSV6uhwK2VmCshwQ25dfA2MZXPcDAR9QUV/QMeICmyQqvTyOyzKTqfigArFYnb
         hJJksuoLZRdHXR29kWnOe3Me5c1Eanb+UnlmhgsT3/BgmmLmtfp8J27gPLFKVip9jqgY
         DU44xHj00J2SyOBg5g/fLPE5BHiH5asbO352KlptSpGDrY5b5n1m9TKyBzdlHM6NG45L
         EypY7vVLNu8KYLoSJtmJHiAEf7CqB7VeZqIkU5hCzgRKVN0i17a3631JQYdHa2yxB3k5
         eoQCsipXoWrKETyTGh4gTTKfn8Fgq/7Uvs2BC6BIyut6Uw48fv7pji1YlDaLEebL7RTu
         C+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683890226; x=1686482226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zX83G+HWjSh7ntCyH77Wv+4FjrcukJO0fyqlvxTR/Ac=;
        b=QWUc2VmKfT5atj5QwE94DMWjX9sIQj660MXRosCMkL26hHUTX8yjZ7K5OT2d5B3U0x
         dBi57QQWL0HzsNAdYltldNn/nAizklQI2huAp1guHDwhiSz4byPoqNv4uKUBWp/12NwY
         IVkrIgsx+DFTDmF4AhS2Bz8icqZ8+5RF8V9zDXfSIsEwEpYAUmMoWyiBm8ruLeY8NkB2
         9NXng5o44NFukT3b/B574c8F/QukT21PP7uVR1MJvSEq9/93x1Y6Vm7PNTBt57XpQz+U
         PktEVdJ6EHzB+BlPpnKFARAlB8xqPqhmdOCvrbu/cCE16S5kpuidcXa8Hvg8BcQmoQgL
         8Fmg==
X-Gm-Message-State: AC+VfDwdi18+v9QfAy+S2yHfZCRNb0I5x92K8XvRObJN6GPnCqh94BBs
        QpBHqyPkw0uJumscAxQ2wfBMrJoK4PF7f16cyaI=
X-Google-Smtp-Source: ACHHUZ6jgEOX6C/vJN7qTPlQjDx5Ga+X9Zl/SRGAi41deqw0HhH9COUuSvEKOzoUzYzfbET9JH2VZA==
X-Received: by 2002:a17:907:36c6:b0:94f:562b:2979 with SMTP id bj6-20020a17090736c600b0094f562b2979mr21789642ejc.31.1683890226201;
        Fri, 12 May 2023 04:17:06 -0700 (PDT)
Received: from ?IPV6:2003:f6:af43:a100:a423:a323:7bdd:1c3e? (p200300f6af43a100a423a3237bdd1c3e.dip0.t-ipconnect.de. [2003:f6:af43:a100:a423:a323:7bdd:1c3e])
        by smtp.gmail.com with ESMTPSA id gt20-20020a170906f21400b0094f7744d135sm5278332ejb.78.2023.05.12.04.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 04:17:05 -0700 (PDT)
Message-ID: <260bafef-d735-85f9-2dae-26f1b8c6a8d0@grsecurity.net>
Date:   Fri, 12 May 2023 13:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.2 0/5] KVM CR0.WP series backport
Content-Language: en-US, de-DE
To:     Sean Christopherson <seanjc@google.com>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org
References: <20230508154457.29956-1-minipli@grsecurity.net>
 <ZF1bJgJSepCwE02l@google.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <ZF1bJgJSepCwE02l@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 11.05.23 23:16, Sean Christopherson wrote:
> On Mon, May 08, 2023, Mathias Krause wrote:
>> [...]
>>
>> Mathias Krause (3):
>>   KVM: x86: Do not unload MMU roots when only toggling CR0.WP with TDP
>>     enabled
>>   KVM: x86: Make use of kvm_read_cr*_bits() when testing bits
>>   KVM: VMX: Make CR0.WP a guest owned bit
>>
>> Paolo Bonzini (1):
>>   KVM: x86/mmu: Avoid indirect call for get_cr3
>>
>> Sean Christopherson (1):
>>   KVM: x86/mmu: Refresh CR0.WP prior to checking for emulated permission
>>     faults
> 
> Acked-by: Sean Christopherson <seanjc@google.com>

Thanks, Sean!

I just realized, I missed to send a backport for 6.3, will do that in a
moment (already running tests, but as the initial series was based on
v6.3-rc1, I don't expect any surprises).

Thanks,
Mathias
