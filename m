Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E72D7932C9
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 02:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbjIFACu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 5 Sep 2023 20:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbjIFACt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 5 Sep 2023 20:02:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE141B4
        for <stable@vger.kernel.org>; Tue,  5 Sep 2023 17:02:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7ea5814674so2547431276.1
        for <stable@vger.kernel.org>; Tue, 05 Sep 2023 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693958565; x=1694563365; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIUEFg7vD08wxmgl3izNQVqICu2lU7UYRLCAx1NQE8Q=;
        b=fOo/TjaLMM5XbLP0762MRcPtplFqx1PUXxkzQJXelpdKeonXFhb2MfywMDT/6VoE85
         DmiGHv3Qjfqe9y74PYij7Dop2AfAXh4aKnBAZAf3Y0pXaQZNZUIl0wfDBu8tXlZkQGbk
         58KJZGhbHlTtt66/oKcsdznFBspsTh2hTczCQV2mwXSTSINeHkYkhRoidDIsg3cndxv7
         n9/hYpSyvcgb78SFHqcV5QFrZxOQjZ/T2tmudPWelwrJGewGnHjYwNlkqSYW6nV2YvQ6
         BmrTL2zTp6qCXJO522lfh6g3chGzlgnuhdJNBp2u3z2WNFlFQgP3+bRTh014o511mATt
         7gEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693958565; x=1694563365;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIUEFg7vD08wxmgl3izNQVqICu2lU7UYRLCAx1NQE8Q=;
        b=QwE4JuWEuQfqWmo1n1bXwwgnE/zTXJE9oRTDTp9iFGN6C/GD9wKYmjcd44S2aWKSwa
         kJO0Hs8Cbv/5z+BYMfheh6Fuvd5uaS8VD2iF9nBWM3amr6DAaG+t0633pvsbuX/rF2IF
         /3AicAEiv1XUvV9jtXie4h0CcBEiyXXHVS8u4u1crSIG4WGCsmq8HSkwFN89hmEbpyrC
         Er0i3+ToHvMGA1K/lC3lb6nVYWUUZq/9C+gA5U+WPgQQPwRJbv9XaWfmFDtanqpy3eoa
         t3m866uhattwrqI+2NH3QHQ0r/apfYX2Z8cpRJZ0fcZ9XeDDOu0uZltRPz0EXDCQ7lej
         RiMA==
X-Gm-Message-State: AOJu0YxzS51HFyZ2gQUR4qyC3jroqV6LyWtqgvfAvxFdlb5dBPslv0nk
        GjVaTzcOH0xayKh4tC7La1WX1xcjsPQ=
X-Google-Smtp-Source: AGHT+IGHZwc5YvElSKZ1/lxZ3lO05AfC4SuejlVNwgQ6TeM9uKIEHxC+3OZIBDEusNAV1iJfvEelHRrZXcA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:2c2:0:b0:d77:ff06:b58b with SMTP id
 h2-20020a5b02c2000000b00d77ff06b58bmr121549ybp.10.1693958565472; Tue, 05 Sep
 2023 17:02:45 -0700 (PDT)
Date:   Tue, 5 Sep 2023 17:02:43 -0700
In-Reply-To: <896dfcaf899a30ddf187ba3eccc1c8d47365b973.1693593288.git.luizcap@amazon.com>
Mime-Version: 1.0
References: <cover.1693593288.git.luizcap@amazon.com> <896dfcaf899a30ddf187ba3eccc1c8d47365b973.1693593288.git.luizcap@amazon.com>
Message-ID: <ZPfBoxgiQvbWias3@google.com>
Subject: Re: [PATH 6.1.y 2/2] KVM: x86/mmu: Add "never" option to allow sticky
 disabling of nx_huge_pages
From:   Sean Christopherson <seanjc@google.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     stable@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        lcapitulino@gmail.com, Li RongQing <lirongqing@baidu.com>,
        Yong He <zhuangel570@gmail.com>,
        Robert Hoo <robert.hoo.linux@gmail.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 01, 2023, Luiz Capitulino wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> Commit 0b210faf337314e4bc88e796218bc70c72a51209 upstream.
> 
> [ Resolved a small conflict in arch/x86/kvm/mmu/mmu.c::kvm_mmu_post_init_vm()
>   which is due kvm_nx_lpage_recovery_worker() being renamed in upstream
>   commit 55c510e26ab6181c132327a8b90c864e6193ce27 ]
> 
> Add a "never" option to the nx_huge_pages module param to allow userspace
> to do a one-way hard disabling of the mitigation, and don't create the
> per-VM recovery threads when the mitigation is hard disabled.  Letting
> userspace pinky swear that userspace doesn't want to enable NX mitigation
> (without reloading KVM) allows certain use cases to avoid the latency
> problems associated with spawning a kthread for each VM.
> 
> E.g. in FaaS use cases, the guest kernel is trusted and the host may
> create 100+ VMs per logical CPU, which can result in 100ms+ latencies when
> a burst of VMs is created.
> 
> Reported-by: Li RongQing <lirongqing@baidu.com>
> Closes: https://lore.kernel.org/all/1679555884-32544-1-git-send-email-lirongqing@baidu.com
> Cc: Yong He <zhuangel570@gmail.com>
> Cc: Robert Hoo <robert.hoo.linux@gmail.com>
> Cc: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Robert Hoo <robert.hoo.linux@gmail.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Luiz Capitulino <luizcap@amazon.com>
> Reviewed-by: Li RongQing <lirongqing@baidu.com>
> Link: https://lore.kernel.org/r/20230602005859.784190-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>
