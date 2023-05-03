Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163A66F5CC5
	for <lists+stable@lfdr.de>; Wed,  3 May 2023 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjECRLf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 3 May 2023 13:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjECRLP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 3 May 2023 13:11:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABDB7D9F
        for <stable@vger.kernel.org>; Wed,  3 May 2023 10:10:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso3938371b3a.2
        for <stable@vger.kernel.org>; Wed, 03 May 2023 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683133846; x=1685725846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lFb3HVbAEiN+niK4olIrnviY/M5SvpH6wmRmxbtAKpA=;
        b=p8+XTLUjsVuI4Lj0PneY4tAW8TByIVGvJjAa67AxqvYINkmWpnAFQhP3xgTVOKTvFb
         rVVssVjY2xcSSp9zZcCiWtViO183EOIgB9+4cpTHOXwAj18Zgkcc6WGzCd4BIZVJyx0E
         icKIUU0RHHt5YLKsoDMbBTNWOrtYEM4+4BiFHagG74ygxlZ2SJoi0gnE4+hwmHVlSGbO
         LTR9GdKX10VPAJxiRNeCrD9OtXRlHH6tbaZPrcmJnRnOPufbxIOWsHZMf/VJ3W8OP+9J
         ie7aZeSXuuPKZKXWr2ZjdWga9LtMFGPCoieTgpH7JIReMjHGjKqQqoDLlZrUL6xsCPmQ
         LlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683133846; x=1685725846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFb3HVbAEiN+niK4olIrnviY/M5SvpH6wmRmxbtAKpA=;
        b=Ov5DCiSWU9PgTTKvtpaTY6cRwo2yFzJ+PzKDOoByzt1qRbSeLZ50Jg4yRjVd4T7cGj
         Zlb2GsSDsWkXgBZ9Lw9EH4qS0nZuDrS1eBMgRQANIedJhXujKGypevAoo3U0IbSh1lPs
         KyA0sic7j+lNaLkB1nTUGuDPLyFlG8gksj4Qs3vNnvvjSBV2aQhmmWxHC5tJb2/JgKtg
         2MF6tBWChRbop4HutAI04Q6T+3Kqyc89dUieefpwxc1GyY4MtyskrVYWD/TdotjwiIdc
         fTSfAJvjuUtFohIVogBd5ARWWpsnCF6goeZZWdIX9aCM6o8TjUwtFKP0S8xNaPrLJdNz
         bkpA==
X-Gm-Message-State: AC+VfDy1/stnVzN4s/sVOYUfMPiQh3rXr30dKMo7oFT2j6pggVgeIdDf
        5eWPYegmcKkbKplDnnCpfs8Jrnyn9HMiOrZ3KKc=
X-Google-Smtp-Source: ACHHUZ6nrmqmCeMLN4BcMH86lWker9DeUFtge/dYag8rqWTc8bqC0ujEsCExrFCUcUSUQgu9OKJ1khK7m2vrxGw8Kjg=
X-Received: by 2002:a05:6a00:1797:b0:63b:6b43:78c with SMTP id
 s23-20020a056a00179700b0063b6b43078cmr31698095pfg.29.1683133846623; Wed, 03
 May 2023 10:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220909185557.21255-1-risbhat@amazon.com>
In-Reply-To: <20220909185557.21255-1-risbhat@amazon.com>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 3 May 2023 10:10:35 -0700
Message-ID: <CAJq+SaDpASRc43MiX0=N0VUh4HMWrbqtUvcR14JdFGPMmqZ4dg@mail.gmail.com>
Subject: Re: [PATCH 0/9] KVM backports to 5.10
To:     Rishabh Bhatnagar <risbhat@amazon.com>
Cc:     stable@vger.kernel.org, gregkh@linuxfoundation.org,
        surajjs@amazon.com, mbacco@amazon.com, bp@alien8.de,
        mingo@redhat.com, tglx@linutronix.de, pbonzini@redhat.com,
        seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

> This patch series backports a few VM preemption_status, steal_time and
> PV TLB flushing fixes to 5.10 stable kernel.
>
> Most of the changes backport cleanly except i had to work around a few
> becauseof missing support/APIs in 5.10 kernel. I have captured those in
> the changelog as well in the individual patches.
>
> Changelog
> - Use mark_page_dirty_in_slot api without kvm argument (KVM: x86: Fix
>   recording of guest steal time / preempted status)
> - Avoid checking for xen_msr and SEV-ES conditions (KVM: x86:
>   do not set st->preempted when going back to user space)
> - Use VCPU_STAT macro to expose preemption_reported and
>   preemption_other fields (KVM: x86: do not report a vCPU as preempted
>   outside instruction boundaries)
>
> David Woodhouse (2):
>   KVM: x86: Fix recording of guest steal time / preempted status
>   KVM: Fix steal time asm constraints
>
> Lai Jiangshan (1):
>   KVM: x86: Ensure PV TLB flush tracepoint reflects KVM behavior
>
> Paolo Bonzini (5):
>   KVM: x86: do not set st->preempted when going back to user space
>   KVM: x86: do not report a vCPU as preempted outside instruction
>     boundaries
>   KVM: x86: revalidate steal time cache if MSR value changes
>   KVM: x86: do not report preemption if the steal time cache is stale
>   KVM: x86: move guest_pv_has out of user_access section
>
> Sean Christopherson (1):
>   KVM: x86: Remove obsolete disabling of page faults in
>     kvm_arch_vcpu_put()

 Thanks Rishabh for the back-ports.

 Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

>
>  arch/x86/include/asm/kvm_host.h |   5 +-
>  arch/x86/kvm/svm/svm.c          |   2 +
>  arch/x86/kvm/vmx/vmx.c          |   1 +
>  arch/x86/kvm/x86.c              | 164 ++++++++++++++++++++++----------
>  4 files changed, 122 insertions(+), 50 deletions(-)
>
> --
> 2.37.1
>
