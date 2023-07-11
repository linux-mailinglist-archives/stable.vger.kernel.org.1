Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E2474EBCE
	for <lists+stable@lfdr.de>; Tue, 11 Jul 2023 12:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjGKKgE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 11 Jul 2023 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjGKKgB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 11 Jul 2023 06:36:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9063010E7
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 03:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689071706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C44gRJnvKK81y1lA/2BMOESkp91eyGlQDqSpbuXrUhI=;
        b=KbEiKk88PnmXn8P9zqstnKw4YfDOzEL8EMZXcmbztA9ZiypK25196LizYqe9EKhkqde1rX
        9zdFpDgxUJxobjH7MCuRzsf6ASRforqJ+/4kITnfTrPKCGycKPcsMzbq9zUP9lK9faqO39
        oDMc/AJOlsqafpTeN78rZFHQAMDWbcE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-R8lkJ5OvOwucXb2Q6UuOQw-1; Tue, 11 Jul 2023 06:35:05 -0400
X-MC-Unique: R8lkJ5OvOwucXb2Q6UuOQw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-767564705f5so619456385a.1
        for <stable@vger.kernel.org>; Tue, 11 Jul 2023 03:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689071705; x=1691663705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C44gRJnvKK81y1lA/2BMOESkp91eyGlQDqSpbuXrUhI=;
        b=caVCm8OSz286m6O8pCJAaFrySSyzvKGuUQKSuz0Lz2z9NJsCYc9I3Do08MvI/nO7sg
         qBOoHXRtUEqa3RHVqcFPPbOWIgLQ7PUtsn+MG5ccJY+dMu/iA7LQhvU2dSWE4pw8jwhm
         yqkFdQxhZ5vmEx6z9be0bGBVVxd89xBC9h/j2ZCb7on5XLJfqu94VfgWeEk4ax/kX6bl
         qIV+knuDnnGodYjcSKpcqu2hxHU/6tMQ2cvyVcBQpEAcvTTpGdQWhhLlSM3OEY9BcV9t
         P7AAEB5l+YxPj8+tKqrE+WyvEHZ6W6By1A6hKi/TFB9MC1DAMD1vQMYqDIFsdw1wGr9g
         CYWA==
X-Gm-Message-State: ABy/qLaJx1ytSoqw/3FkkCc7uIJPil7fXfZ5OqxqGqMPsOb8gdxpHfZo
        08yZy7sgMHEA9BwfgQXnMLLaDX4iw8eKNE5N/KAmxT46gCDUVt7wG2PzheyFyfVlnUP7RThPWss
        I/V28XPkNV54XLrqV
X-Received: by 2002:a37:9341:0:b0:75e:6837:19f8 with SMTP id v62-20020a379341000000b0075e683719f8mr13771835qkd.54.1689071705001;
        Tue, 11 Jul 2023 03:35:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxlq/7A4GdGaqnzBhicpMrwD0GAvJBt2eUgALa1GF781GEgnyNumTSHDI13TYvBhLFGWjlpA==
X-Received: by 2002:a37:9341:0:b0:75e:6837:19f8 with SMTP id v62-20020a379341000000b0075e683719f8mr13771821qkd.54.1689071704760;
        Tue, 11 Jul 2023 03:35:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d13-20020a05620a140d00b00767e62bcf0csm167613qkj.65.2023.07.11.03.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:35:04 -0700 (PDT)
Message-ID: <d49225cb-3240-ea8e-11e6-b8ed30ce2fc8@redhat.com>
Date:   Tue, 11 Jul 2023 12:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] KVM: arm64: timers: Use CNTHCTL_EL2 when setting
 non-CNTKCTL_EL1 bits
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org
References: <20230627140557.544885-1-maz@kernel.org>
From:   Eric Auger <eauger@redhat.com>
In-Reply-To: <20230627140557.544885-1-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Marc,
On 6/27/23 16:05, Marc Zyngier wrote:
> It recently appeared that, whien running VHE, there is a notable
when
> difference between using CNTKCTL_EL1 and CNTHCTL_EL2, despite what
> the architecture documents:
> 
> - When accessed from EL2, bits [19:18] and [16:10] same bits have
s/same bits/of CNTKCTL_EL1/ ?
>   the same assignment as CNTHCTL_EL2
> - When accessed from EL1, bits [19:18] and [16:10] are RES0
s/bits/the same bits/
> 
> It is all OK, until you factor in NV, where the EL2 guest runs at EL1.
> In this configuration, CNTKCTL_EL11 doesn't trap, nor ends up in
s/CNTKCTL_EL11/CNTKCTL_EL1
> the VNCR page. This means that any write from the guest affecting
> CNTHCTL_EL2 using CNTKCTL_EL1 ends up losing some state. Not good.
> 
> The fix it obvious: don't use CNTKCTL_EL1 if you want to change bits
> that are not part of the EL1 definition of CNTKCTL_EL1, and use
> CNTHCTL_EL2 instead. This doesn't change anything for a bare-metal OS,
> and fixes it when running under NV. The NV hypervisor will itself
> have to work harder to merge the two accessors.
> 
> Note that there is a pending update to the architecture to address
> this issue by making the affected bits UNKNOWN when CNTKCTL_EL1 is
> user from EL2 with VHE enabled.
used
> 
> Fixes: c605ee245097 ("KVM: arm64: timers: Allow physical offset without CNTPOFF_EL2")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org # v6.4
> ---
>  arch/arm64/kvm/arch_timer.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/arch_timer.c b/arch/arm64/kvm/arch_timer.c
> index 0696732fa38c..6dcdae4d38cb 100644
> --- a/arch/arm64/kvm/arch_timer.c
> +++ b/arch/arm64/kvm/arch_timer.c
> @@ -827,8 +827,8 @@ static void timer_set_traps(struct kvm_vcpu *vcpu, struct timer_map *map)
>  	assign_clear_set_bit(tpt, CNTHCTL_EL1PCEN << 10, set, clr);
>  	assign_clear_set_bit(tpc, CNTHCTL_EL1PCTEN << 10, set, clr);
>  
> -	/* This only happens on VHE, so use the CNTKCTL_EL1 accessor */
> -	sysreg_clear_set(cntkctl_el1, clr, set);
> +	/* This only happens on VHE, so use the CNTHCTL_EL2 accessor. */
> +	sysreg_clear_set(cnthctl_el2, clr, set);
>  }
>  
>  void kvm_timer_vcpu_load(struct kvm_vcpu *vcpu)
> @@ -1563,7 +1563,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
>  void kvm_timer_init_vhe(void)
>  {
>  	if (cpus_have_final_cap(ARM64_HAS_ECV_CNTPOFF))
> -		sysreg_clear_set(cntkctl_el1, 0, CNTHCTL_ECV);
> +		sysreg_clear_set(cnthctl_el2, 0, CNTHCTL_ECV);
>  }
>  
>  int kvm_arm_timer_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

