Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DD270090D
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 15:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbjELNUn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbjELNUl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 09:20:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C732A102
        for <stable@vger.kernel.org>; Fri, 12 May 2023 06:20:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96aadfb19d7so114371666b.2
        for <stable@vger.kernel.org>; Fri, 12 May 2023 06:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683897638; x=1686489638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ivGgNo+Kv70D2+OV4ww0qpxdSF3H1fxkMi8RKMA2vtI=;
        b=DC84w+FmygwWeMoR2trh0UyticHHI/2Hq/nHRo/f6gPWXJcQQTPJ/v23mXlFcBWXUB
         VEpLBBZi9BsK8WvGRGnOOO0fj9BjbPNMebNBS53e4RmXRpKXaX5atM9ge8mqQ4M3XgLC
         V4j0s0YKagm+36XqTwr+vMm3mHCPwmFXdtAMOqqn5fqP3Hn/HjmWs4h/Z668f6cPERaL
         CErX8zC7jfvnjxnmnd4VQOipTowlc1nHpkxVlXeYGE9FmGROl9zaFZWRLwkfnV/PCaOx
         TMTNjO+oR2KK//ckC6LQBjnq0+MovjRsWJLUC3EYPFqOyB2GZYNmF3ZYrKm2wtgM/R+U
         taNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683897638; x=1686489638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivGgNo+Kv70D2+OV4ww0qpxdSF3H1fxkMi8RKMA2vtI=;
        b=kdezhscB4zYDMnNApbVkB7N7rOQk1pZImbGQLvHyB//PdVu0E/UHST6ACHSGwVAvek
         lnllys/ixmnyGPue0+i8uz0k4O2xZ3Ma+OkkTa8awIthFT5SKpX0d7/jdurHWGcekyEc
         1Ix5n6yucLp3MpxcMkjoY/CUKHNPyqhusSR3V0MJFWVVY/wiCQD5+OK/Pt4v8A+zjxpL
         KF8jgZ6cp/NXEtEX2KXHb0uCrnPGFAug8ElHS4I/VYyfEs3VJ8jv3KgPjaTreajtwugX
         Ck0uCZ9txQZ6anI3/rmy4DRddiNdDbl74NFU51YoFo4lIoUvuEGHD65Q+r6Qk+DGfZ2A
         4wVQ==
X-Gm-Message-State: AC+VfDwdBCv8FvmTS0bxm56lSavo5ra2TunT0qIQDKx5FuzGaxgFqxca
        JNYlDZBYKKZC+oemb2l3YrG/RtgYmJ7yoUphwb8=
X-Google-Smtp-Source: ACHHUZ4cd0CDxcac29SN/S0MUCGNSr44iFyhkilCZYS+Qip+XEHLXOEULWORc6BvjluDMqt72RvwTA==
X-Received: by 2002:a17:906:da87:b0:966:3c82:4a97 with SMTP id xh7-20020a170906da8700b009663c824a97mr18170917ejb.35.1683897638111;
        Fri, 12 May 2023 06:20:38 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6af43a100a78da3f586d44204.dip0.t-ipconnect.de. [2003:f6:af43:a100:a78d:a3f5:86d4:4204])
        by smtp.gmail.com with ESMTPSA id w21-20020a170907271500b00969dfd160aesm5077981ejk.109.2023.05.12.06.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 06:20:37 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 6.3 0/5] KVM CR0.WP series backport
Date:   Fri, 12 May 2023 15:20:19 +0200
Message-Id: <20230512132024.4029-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a backport of the CR0.WP KVM series[1] to Linux v6.3.

As the original series is based on v6.3-rc1, it's mostly a verbatim
port. Only the last patch needed adaption, as it was a fix based on
v6.4-rc1. However, as for the v6.2 backport, I simply changed the code
to make use of the older kvm_is_cr0_bit_set() helper.

I used 'ssdd 10 50000' from rt-tests[2] as a micro-benchmark, running on
a grsecurity L1 VM. Below table shows the results (runtime in seconds,
lower is better):

                       legacy     TDP
    Linux v6.3.1        7.60s    8.29s
    + patches           3.39s    3.39s

    Linux v6.3.2        7.82s    7.81s
    + patches           3.38s    3.38s

I left out the shadow MMU tests this time, as they're not impacted
anyways, only take a lot of time to run. I did, however, include
separate tests for v6.3.{1,2} -- not because I had an outdated
linux-stable git tree lying around *cough, cough* but because the later
includes commit 2ec1fe292d6e ("KVM: x86: Preserve TDP MMU roots until
they are explicitly invalidated"), the commit I wanted to benchmark
against anyways. Apparently, it has only a minor impact for our use
case, so this series is still wanted, imho.

Please consider applying.

Thanks,
Mathias

[1] https://lore.kernel.org/kvm/20230322013731.102955-1-minipli@grsecurity.net/
[2] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git


Mathias Krause (3):
  KVM: x86: Do not unload MMU roots when only toggling CR0.WP with TDP
    enabled
  KVM: x86: Make use of kvm_read_cr*_bits() when testing bits
  KVM: VMX: Make CR0.WP a guest owned bit

Paolo Bonzini (1):
  KVM: x86/mmu: Avoid indirect call for get_cr3

Sean Christopherson (1):
  KVM: x86/mmu: Refresh CR0.WP prior to checking for emulated permission
    faults

 arch/x86/kvm/kvm_cache_regs.h  |  2 +-
 arch/x86/kvm/mmu.h             | 26 ++++++++++++++++++-
 arch/x86/kvm/mmu/mmu.c         | 46 ++++++++++++++++++++++++++--------
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/pmu.c             |  4 +--
 arch/x86/kvm/vmx/nested.c      |  4 +--
 arch/x86/kvm/vmx/vmx.c         |  6 ++---
 arch/x86/kvm/vmx/vmx.h         | 18 +++++++++++++
 arch/x86/kvm/x86.c             | 12 +++++++++
 9 files changed, 99 insertions(+), 21 deletions(-)

-- 
2.39.2

