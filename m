Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F04751663
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 04:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjGMCiW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 12 Jul 2023 22:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjGMCiV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 12 Jul 2023 22:38:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EDB2690
        for <stable@vger.kernel.org>; Wed, 12 Jul 2023 19:38:09 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R1dy92npbzLnhj;
        Thu, 13 Jul 2023 10:35:45 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 10:38:05 +0800
Subject: Re: [PATCH] KVM: arm64: vgic-v4: Consistently request doorbell irq
 for blocking vCPU
To:     Zenghui Yu <zenghui.yu@linux.dev>, Marc Zyngier <maz@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20230710175553.1477762-1-oliver.upton@linux.dev>
 <86jzv6x66q.wl-maz@kernel.org> <ZK0EPhvLzhaFepGk@linux.dev>
 <14acf0fd-e5eb-8a14-986a-b8fe4a44cec9@huawei.com>
 <86zg41utno.wl-maz@kernel.org>
 <c1b2e321-be93-0082-2724-f0e36ff9872a@linux.dev>
CC:     Oliver Upton <oliver.upton@linux.dev>, <kvmarm@lists.linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <stable@vger.kernel.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <55ae58b1-6513-5789-b0a6-8e23bf4b2148@hisilicon.com>
Date:   Thu, 13 Jul 2023 10:38:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <c1b2e321-be93-0082-2724-f0e36ff9872a@linux.dev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org



在 2023/7/12 星期三 23:56, Zenghui Yu 写道:
> On 2023/7/12 21:49, Marc Zyngier wrote:
>> On Wed, 12 Jul 2023 13:09:45 +0100,
>> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>>
>>> On 2023/7/11 15:26, Oliver Upton wrote:
>>>> On Tue, Jul 11, 2023 at 08:23:25AM +0100, Marc Zyngier wrote:
>>>>> On Mon, 10 Jul 2023 18:55:53 +0100,
>>>>> Oliver Upton <oliver.upton@linux.dev> wrote:
>>>>>>
>>>>>> Xiang reports that VMs occasionally fail to boot on GICv4.1 
>>>>>> systems when
>>>>>> running a preemptible kernel, as it is possible that a vCPU is 
>>>>>> blocked
>>>>>> without requesting a doorbell interrupt.
>>>>>>
>>>>>> The issue is that any preemption that occurs between 
>>>>>> vgic_v4_put() and
>>>>>> schedule() on the block path will mark the vPE as nonresident and 
>>>>>> *not*
>>>>>> request a doorbell irq.
>>>>>
>>>>> It'd be worth spelling out. You need to go via *three* schedule()
>>>>> calls: one to be preempted (with DB set), one to be made resident
>>>>> again, and then the final one in kvm_vcpu_halt(), clearing the DB on
>>>>> vcpu_put() due to the bug.
>>>>
>>>> Yeah, a bit lazy in the wording. What I had meant to imply was
>>>> preemption happening after the doorbell is set up and before the 
>>>> thread
>>>> has an opportunity to explicitly schedule out. Perhaps I should 
>>>> just say
>>>> that.
>>>>
>>>>>>
>>>>>> Fix it by consistently requesting a doorbell irq in the vcpu put 
>>>>>> path if
>>>>>> the vCPU is blocking.
>>>
>>> Yup. Agreed!
>>>
>>>>>> While this technically means we could drop the
>>>>>> early doorbell irq request in kvm_vcpu_wfi(), deliberately leave it
>>>>>> intact such that vCPU halt polling can properly detect the wakeup
>>>>>> condition before actually scheduling out a vCPU.
>>>
>>> Yeah, just like what we did in commit 07ab0f8d9a12 ("KVM: Call
>>> kvm_arch_vcpu_blocking early into the blocking sequence").
>>>
>>> My only concern is that if the preemption happens before halt polling,
>>> we would enter the polling loop with VPE already resident on the RD and
>>> can't recognize any firing GICv4.x virtual interrupts (targeting this
>>> VPE) in polling. [1]
>>
>> The status of the pending bit is recorded in pending_last, so we don't
>> lose what was snapshot at the point of hitting WFI. But we indeed
>> don't have any idea for something firing during the polling loop.
>>
>>> Given that making VPE resident on the vcpu block path (i.e., in
>>> kvm_vcpu_halt()) makes little sense (right?) and leads to this sort of
>>> problem, a crude idea is that we can probably keep track of the
>>> "nested" vgic_v4_{put,load} calls (instead of a single vpe->resident
>>> flag) and keep VPE *not resident* on the whole block path (like what we
>>> had before commit 8e01d9a396e6). And we then rely on
>>> kvm_vcpu_wfi/vgic_v4_load to actually schedule the VPE on...
>>
>> I'm not sure about the nested tracking part, but it's easy enough to
>> have a vcpu flag indicating that we're in WFI. So an *alternative* to
>> the current fix would be something like this:
>>
>> diff --git a/arch/arm64/include/asm/kvm_host.h 
>> b/arch/arm64/include/asm/kvm_host.h
>> index f54ba0a63669..417a0e85456b 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -817,6 +817,8 @@ struct kvm_vcpu_arch {
>>  #define DBG_SS_ACTIVE_PENDING    __vcpu_single_flag(sflags, BIT(5))
>>  /* PMUSERENR for the guest EL0 is on physical CPU */
>>  #define PMUSERENR_ON_CPU    __vcpu_single_flag(sflags, BIT(6))
>> +/* WFI instruction trapped */
>> +#define IN_WFI            __vcpu_single_flag(sflags, BIT(7))
>
> Ah, trust me that I was thinking about exactly the same vcpu flag
> when writing the last email. ;-) So here is my Ack for this
> alternative, thanks Marc for your quick reply!
>
>>
>>  /* vcpu entered with HCR_EL2.E2H set */
>>  #define VCPU_HCR_E2H        __vcpu_single_flag(oflags, BIT(0))
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index 236c5f1c9090..cf208d30a9ea 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -725,13 +725,15 @@ void kvm_vcpu_wfi(struct kvm_vcpu *vcpu)
>>       */
>>      preempt_disable();
>>      kvm_vgic_vmcr_sync(vcpu);
>> -    vgic_v4_put(vcpu, true);
>> +    vcpu_set_flag(vcpu, IN_WFI);
>> +    vgic_v4_put(vcpu);
>>      preempt_enable();
>>
>>      kvm_vcpu_halt(vcpu);
>>      vcpu_clear_flag(vcpu, IN_WFIT);
>>
>>      preempt_disable();
>> +    vcpu_clear_flag(vcpu, IN_WFI);
>>      vgic_v4_load(vcpu);
>>      preempt_enable();
>>  }
>> @@ -799,7 +801,7 @@ static int check_vcpu_requests(struct kvm_vcpu 
>> *vcpu)
>>          if (kvm_check_request(KVM_REQ_RELOAD_GICv4, vcpu)) {
>>              /* The distributor enable bits were changed */
>>              preempt_disable();
>> -            vgic_v4_put(vcpu, false);
>> +            vgic_v4_put(vcpu);
>>              vgic_v4_load(vcpu);
>>              preempt_enable();
>>          }
>> diff --git a/arch/arm64/kvm/vgic/vgic-v3.c 
>> b/arch/arm64/kvm/vgic/vgic-v3.c
>> index 49d35618d576..df61ead7c757 100644
>> --- a/arch/arm64/kvm/vgic/vgic-v3.c
>> +++ b/arch/arm64/kvm/vgic/vgic-v3.c
>> @@ -780,7 +780,7 @@ void vgic_v3_put(struct kvm_vcpu *vcpu)
>>       * done a vgic_v4_put) and when running a nested guest (the
>>       * vPE was never resident in order to generate a doorbell).
>>       */
>> -    WARN_ON(vgic_v4_put(vcpu, false));
>> +    WARN_ON(vgic_v4_put(vcpu));
>>
>>      vgic_v3_vmcr_sync(vcpu);
>>
>> diff --git a/arch/arm64/kvm/vgic/vgic-v4.c 
>> b/arch/arm64/kvm/vgic/vgic-v4.c
>> index c1c28fe680ba..339a55194b2c 100644
>> --- a/arch/arm64/kvm/vgic/vgic-v4.c
>> +++ b/arch/arm64/kvm/vgic/vgic-v4.c
>> @@ -336,14 +336,14 @@ void vgic_v4_teardown(struct kvm *kvm)
>>      its_vm->vpes = NULL;
>>  }
>>
>> -int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db)
>> +int vgic_v4_put(struct kvm_vcpu *vcpu)
>>  {
>>      struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
>>
>>      if (!vgic_supports_direct_msis(vcpu->kvm) || !vpe->resident)
>>          return 0;
>>
>> -    return its_make_vpe_non_resident(vpe, need_db);
>> +    return its_make_vpe_non_resident(vpe, !!vcpu_get_flag(vcpu, 
>> IN_WFI));
>>  }
>>
>>  int vgic_v4_load(struct kvm_vcpu *vcpu)
>> @@ -354,6 +354,9 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
>>      if (!vgic_supports_direct_msis(vcpu->kvm) || vpe->resident)
>>          return 0;
>>
>> +    if (vcpu_get_flag(vcpu, IN_WFI))
>> +        return 0;
>> +
>>      /*
>>       * Before making the VPE resident, make sure the redistributor
>>       * corresponding to our current CPU expects us here. See the
>> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
>> index 9b91a8135dac..765d801d1ddc 100644
>> --- a/include/kvm/arm_vgic.h
>> +++ b/include/kvm/arm_vgic.h
>> @@ -446,7 +446,7 @@ int kvm_vgic_v4_unset_forwarding(struct kvm *kvm, 
>> int irq,
>>
>>  int vgic_v4_load(struct kvm_vcpu *vcpu);
>>  void vgic_v4_commit(struct kvm_vcpu *vcpu);
>> -int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db);
>> +int vgic_v4_put(struct kvm_vcpu *vcpu);
>>
>>  bool vgic_state_is_nested(struct kvm_vcpu *vcpu);
>>
>>
>> Of course, it is totally untested... ;-) But I like that the doorbell
>> request is solely driven by the WFI state, and we avoid leaking the
>> knowledge outside of the vgic code.
>
> I'm happy with this approach and will have another look tomorrow. It'd
> also be great if Xiang can give this one a go on the appropriate HW.

Ok, I will test this approach and feedback the result when finished.

>
> Thanks,
> Zenghui
> .
>

