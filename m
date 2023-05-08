Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4A6FB442
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbjEHPtL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjEHPsz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 11:48:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74AD9010
        for <stable@vger.kernel.org>; Mon,  8 May 2023 08:48:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94a34a14a54so939921766b.1
        for <stable@vger.kernel.org>; Mon, 08 May 2023 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683560896; x=1686152896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EeMdCNOmkDu2qccxn7GUEiAmqEy+l/fyQVsmJEYniyA=;
        b=h1ORxUH45nfHHlDti9N0qDPfDpXQJQ2ylfqmhkyucZoDZ1+A3U5onX3KaoDG+/rcya
         a7Kcs9d31mox0IdoSYvg5FqF+PNOsa/G5ssDB8sdc0RYpSQocPFLJCFtdsT4OYfo+7g9
         ULUnS61NfmUgti5Z3o9yVWt4vT3sARwGWYPdT22uhpOz8wFxt5wZJqTZhgVnRuUZO0za
         FfUh2oVcWSzLaZPBsejAmpSR4ymPZcT2elAsLPcn/l0LbBFuUeamjGxViNfcqlaCAMg3
         WOpgq4E6OoOSAq2TePA6z4bChazbaAcUUfd1MdkKRk9O+9v8ebGQKl1AlJD9adjnw7jT
         ItxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560896; x=1686152896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EeMdCNOmkDu2qccxn7GUEiAmqEy+l/fyQVsmJEYniyA=;
        b=HX2GXtAiAwXXPO8kBj7C5CONzRQrILPNVf5UTnqMdM47pj5HlZRULD59mAT4/3Zmas
         YyY4ge3l5O/QrXEF9SB5Dq9q+x8KWQBww5wClqIRA/uRLC540KRvceIffxxvCqu0E4cb
         jV/5pSyksPutASvcM987aW5gQ9RgXzsq5DEts5bhSYOFjHqy/wuCPFNCl99qAP7NBzKx
         sZyGkVGSnhb/lyKTGCYcL8+kN4/95bUV8klk29lnaUfHWkYETtLTRB5RJ0j2hYnoqxW5
         E3rPMY+vVqA9cBLKpmSXVRu38EsCjtbU+qRPMFH6fUi/6gjxZIMaIFiShDuusK2rE8MW
         WAHA==
X-Gm-Message-State: AC+VfDx4A/gSwvO0H7Nc1xiQmrkx3F4FYaDNFCFvPM47aJgg7hv/cPhr
        YHUn5JbqBycVheOLqx0feTWU3zq7frvyy0fYjXB0xg==
X-Google-Smtp-Source: ACHHUZ5h599RdNMrq4NmzKJlTNveFytDyeyBfVmZhHLUAK1le8J6CdeQHnmQNj0UGXjyyTghYpFoCA==
X-Received: by 2002:a17:907:a41e:b0:94a:4b7a:9886 with SMTP id sg30-20020a170907a41e00b0094a4b7a9886mr10252137ejc.12.1683560896285;
        Mon, 08 May 2023 08:48:16 -0700 (PDT)
Received: from localhost.localdomain (p549211c7.dip0.t-ipconnect.de. [84.146.17.199])
        by smtp.gmail.com with ESMTPSA id k21-20020a170906055500b009584c5bcbc7sm126316eja.49.2023.05.08.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:48:15 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 5.10 00/10] KVM CR0.WP series backport
Date:   Mon,  8 May 2023 17:47:54 +0200
Message-Id: <20230508154804.30078-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is a backport of the CR0.WP KVM series[1] to Linux v5.10. It
further extends the v5.15 backport by two patches, namely patch 5 (which
is the prerequisite for Lai's patches) and patch 8 which was already
part of the v5.15.27 stable update but didn't made it to v5.10.

I used 'ssdd 10 50000' from rt-tests[2] as a micro-benchmark, running on
a grsecurity L1 VM. Below table shows the results (runtime in seconds,
lower is better):

                          legacy     TDP    shadow
    Linux v5.10.177       10.37s    88.7s    69.7s
    + patches              4.88s     4.92s   70.1s

TDP MMU is, as for v5.15, slower than shadow paging on a vanilla kernel.
Fortunately it's disabled by default.

The KVM unit test suite showed no regressions.

Please consider applying.

Thanks,
Mathias

[1] https://lore.kernel.org/kvm/20230322013731.102955-1-minipli@grsecurity.net/
[2] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git


Lai Jiangshan (4):
  KVM: X86: Don't reset mmu context when X86_CR4_PCIDE 1->0
  KVM: X86: Don't reset mmu context when toggling X86_CR4_PGE
  KVM: X86: Ensure that dirty PDPTRs are loaded
  KVM: x86/mmu: Reconstruct shadow page root if the guest PDPTEs is
    changed

Mathias Krause (3):
  KVM: x86: Do not unload MMU roots when only toggling CR0.WP with TDP
    enabled
  KVM: x86: Make use of kvm_read_cr*_bits() when testing bits
  KVM: VMX: Make CR0.WP a guest owned bit

Paolo Bonzini (1):
  KVM: x86/mmu: Avoid indirect call for get_cr3

Sean Christopherson (2):
  KVM: x86: Read and pass all CR0/CR4 role bits to shadow MMU helper
  KVM: x86/mmu: Refresh CR0.WP prior to checking for emulated permission
    faults

 arch/x86/kvm/kvm_cache_regs.h  |  2 +-
 arch/x86/kvm/mmu.h             | 42 +++++++++++++++++++++++++++++++++-
 arch/x86/kvm/mmu/mmu.c         | 32 +++++++++++++++++++-------
 arch/x86/kvm/mmu/paging_tmpl.h |  2 +-
 arch/x86/kvm/pmu.c             |  4 ++--
 arch/x86/kvm/vmx/nested.c      |  4 ++--
 arch/x86/kvm/vmx/vmx.c         |  6 ++---
 arch/x86/kvm/vmx/vmx.h         | 18 +++++++++++++++
 arch/x86/kvm/x86.c             | 32 +++++++++++++++++++++-----
 9 files changed, 118 insertions(+), 24 deletions(-)

-- 
2.39.2

