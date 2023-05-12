Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2378B700EC0
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 20:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbjELS0r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbjELS0b (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 14:26:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7996FE727
        for <stable@vger.kernel.org>; Fri, 12 May 2023 11:25:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b922aa3725fso19415012276.0
        for <stable@vger.kernel.org>; Fri, 12 May 2023 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683915862; x=1686507862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDrV2J0MuuejNQd3OGtRf3MzD9HRU7n/LydIQyUlwvg=;
        b=zw6GGWrdg/akBW0/1von3NObbXtRBBOuyUSn34fyswphLXKBMGuEiTieRoktg+xkTD
         cyEu36o2hawoXKwiRXfZWInEIWtfOxuWV5IN5v0Y3PsfIiyiEJqHqE3l30WVDfVJ6DXQ
         /1TSBhhgXIndcbS/UhjcJK95KyYpIrnu3TnouhsnGQZKI2/a6Ilgc+eHTt3Dc4ajgId9
         s8bc1jm86Zr3PjaKTnpsQP7nSQoRDn6rrw8ceM6EjNia9CLcZ+5C5HHoJNuUy6ukxd3N
         cws0BMRk9L8ihi/UZ+k8nGAJGdYxJzeouP+VAwFe10dNvU7m36TF2c/fFBVJS3WWScUF
         6yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683915862; x=1686507862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDrV2J0MuuejNQd3OGtRf3MzD9HRU7n/LydIQyUlwvg=;
        b=kPDFh94UG6p5ePcaHOL0q0kvDkpa5IUwG4rNYv0a60+mgPO+4o//gEEe9+lhNaiaQI
         6KRf6DLw+FNZ9z3OoRqXI71fX6nRYINdwqJWS5QweJnZ16WvovDTu5rNPs1HqmrvZm8x
         rmgQQf1ZCiC1pTLXFwFOvwKEX5INqh3yCtPJRiYGePxgLDrYYC9ONo5AhW7eFVQnLwzF
         d0hFHasDEfzocWYuCojuVVFi7dK2byrb+f2fOX1/7dc28eo6TahmFod/3wCZ68DKw1/i
         0BYzbzcm4IyRlNXAmkzHkkurfPg7j/dMLmiV/sR+opvhBX5EOLSA9+3J5Fv0GMTRkH2G
         nWDg==
X-Gm-Message-State: AC+VfDyRcP6cNSuVbBekAYtB4GKOE2Zt9/c17JBKTgZXqji/aSgog+Rx
        d1ob1JFBoxTwIW6XIYnPHVx8d6GkcKo=
X-Google-Smtp-Source: ACHHUZ5uvd72NRqqoexH340797LsKFik/QG6/fCm2C8egdLMSawkfKAhgV0Dq7wIwps3f6uSSFyLvUHR1cI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c50e:0:b0:ba7:42a6:bced with SMTP id
 v14-20020a25c50e000000b00ba742a6bcedmr547334ybe.5.1683915862729; Fri, 12 May
 2023 11:24:22 -0700 (PDT)
Date:   Fri, 12 May 2023 11:24:21 -0700
In-Reply-To: <20230512132024.4029-1-minipli@grsecurity.net>
Mime-Version: 1.0
References: <20230512132024.4029-1-minipli@grsecurity.net>
Message-ID: <ZF6EVeXU+RNVHIb+@google.com>
Subject: Re: [PATCH 6.3 0/5] KVM CR0.WP series backport
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 12, 2023, Mathias Krause wrote:
> This is a backport of the CR0.WP KVM series[1] to Linux v6.3.
> 
> As the original series is based on v6.3-rc1, it's mostly a verbatim
> port. Only the last patch needed adaption, as it was a fix based on
> v6.4-rc1. However, as for the v6.2 backport, I simply changed the code
> to make use of the older kvm_is_cr0_bit_set() helper.
> 
> I used 'ssdd 10 50000' from rt-tests[2] as a micro-benchmark, running on
> a grsecurity L1 VM. Below table shows the results (runtime in seconds,
> lower is better):
> 
>                        legacy     TDP
>     Linux v6.3.1        7.60s    8.29s
>     + patches           3.39s    3.39s
> 
>     Linux v6.3.2        7.82s    7.81s
>     + patches           3.38s    3.38s
> 
> I left out the shadow MMU tests this time, as they're not impacted
> anyways, only take a lot of time to run. I did, however, include
> separate tests for v6.3.{1,2} -- not because I had an outdated
> linux-stable git tree lying around *cough, cough* but because the later
> includes commit 2ec1fe292d6e ("KVM: x86: Preserve TDP MMU roots until
> they are explicitly invalidated"), the commit I wanted to benchmark
> against anyways. Apparently, it has only a minor impact for our use
> case, so this series is still wanted, imho.
> 
> Please consider applying.
> 
> Thanks,
> Mathias
> 
> [1] https://lore.kernel.org/kvm/20230322013731.102955-1-minipli@grsecurity.net/
> [2] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
> 
> 
> Mathias Krause (3):
>   KVM: x86: Do not unload MMU roots when only toggling CR0.WP with TDP
>     enabled
>   KVM: x86: Make use of kvm_read_cr*_bits() when testing bits
>   KVM: VMX: Make CR0.WP a guest owned bit
> 
> Paolo Bonzini (1):
>   KVM: x86/mmu: Avoid indirect call for get_cr3
> 
> Sean Christopherson (1):
>   KVM: x86/mmu: Refresh CR0.WP prior to checking for emulated permission
>     faults

Acked-by: Sean Christopherson <seanjc@google.com>
