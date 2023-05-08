Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4CE6FB42F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 17:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjEHPro (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjEHPrm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 11:47:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C7B7EE4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 08:47:21 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9659c5b14d8so756594066b.3
        for <stable@vger.kernel.org>; Mon, 08 May 2023 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1683560839; x=1686152839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvMBpYGUUFbOhtoeU6tZl9mcm8XZOcaQ6enJN2RpEHs=;
        b=ecsq9ypdG7ZRARLjZW8Emx2S8hbt9VVx7CQmTQQ5bVRbcTQ1XQOMmJei2JhIfYngbI
         sdJ/uk2mG9tpr7zXZ88/TwbUM1FuHhh8r9xWA03phExNboobCL46/QEFH76PQlrPtvV4
         mmJDDDpxsfWxgadvfLHS3rHbt5hu8u57XThNC6fWYDaTsyDcWSiubYw/aaLR0ei+eIu/
         T/7OMQ65d0aaxy3TVWLl69GFETfPh+Y/pWyrWUgWLhDWT8i9FoHQCJ36calMSBWzBvtG
         lJYp6h54kd32+XcKED7g/VCJH2hy8Cu3aMVx1eMdEiETmvNerPrnm1qLZcN9bcop0C/a
         8MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560839; x=1686152839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvMBpYGUUFbOhtoeU6tZl9mcm8XZOcaQ6enJN2RpEHs=;
        b=Jm7JnMv+GodP88sYo6PpOZYV456O4espDZYceT96wz8FqLw+Js9CZ6G5XRoBY27QXC
         J21EWugf4X/hbZDZENszi6o44T9NKmpV8O3C25D5lAoFmHtpfLLp/j5E++c6OitY4EzZ
         AguCd3mvLkcCELlLPBQkudABXo32R0TaVHvhztZWKbmXH6XRFczj7sMRZsoOkq/ovuV8
         jWsiFFOZnAS/Djol8+tvyB3s/Slf4IRGY60pOoZEpPlhsh8ltkDsbmAee/QxYj7MGZr9
         KIs4mxr71sYk5wTWutyj648AnBWPaH6UxFRyyAPDTVPSUMirkFWsfoCF57wZRkd07vSt
         So5A==
X-Gm-Message-State: AC+VfDxx3FOagtKKfx7joEp4WU6i4JC0unlmVeBamyV7ueC3hQHbR5RL
        xMwHvK0nR3hEYENyUBVIIwZXM/6XcICibI34pWTQMw==
X-Google-Smtp-Source: ACHHUZ5/u4SgZ1Df3Vxq+zvKFE+Zqa3Bu3zrMmOOg0tv1QZinxH5syijLyX11+GoDI+9NhhiGWsMtw==
X-Received: by 2002:a17:907:ea6:b0:951:f54c:208b with SMTP id ho38-20020a1709070ea600b00951f54c208bmr9167633ejc.24.1683560839338;
        Mon, 08 May 2023 08:47:19 -0700 (PDT)
Received: from localhost.localdomain (p549211c7.dip0.t-ipconnect.de. [84.146.17.199])
        by smtp.gmail.com with ESMTPSA id md1-20020a170906ae8100b0094b5ce9d43dsm121822ejb.85.2023.05.08.08.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:47:18 -0700 (PDT)
From:   Mathias Krause <minipli@grsecurity.net>
To:     stable@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        Mathias Krause <minipli@grsecurity.net>
Subject: [PATCH 5.15 2/8] KVM: x86: Do not unload MMU roots when only toggling CR0.WP with TDP enabled
Date:   Mon,  8 May 2023 17:47:03 +0200
Message-Id: <20230508154709.30043-3-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508154709.30043-1-minipli@grsecurity.net>
References: <20230508154709.30043-1-minipli@grsecurity.net>
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

[ Upstream commit 01b31714bd90be2784f7145bf93b7f78f3d081e1 ]

There is no need to unload the MMU roots with TDP enabled when only
CR0.WP has changed -- the paging structures are still valid, only the
permission bitmap needs to be updated.

One heavy user of toggling CR0.WP is grsecurity's KERNEXEC feature to
implement kernel W^X.

The optimization brings a huge performance gain for this case as the
following micro-benchmark running 'ssdd 10 50000' from rt-tests[1] on a
grsecurity L1 VM shows (runtime in seconds, lower is better):

                       legacy     TDP    shadow
kvm-x86/next@d8708b     8.43s    9.45s    70.3s
             +patch     5.39s    5.63s    70.2s

For legacy MMU this is ~36% faster, for TDP MMU even ~40% faster. Also
TDP and legacy MMU now both have a similar runtime which vanishes the
need to disable TDP MMU for grsecurity.

Shadow MMU sees no measurable difference and is still slow, as expected.

[1] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git

Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Link: https://lore.kernel.org/r/20230322013731.102955-3-minipli@grsecurity.net
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
 arch/x86/kvm/x86.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 018f6a394d44..27900d4017a7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -878,6 +878,18 @@ EXPORT_SYMBOL_GPL(load_pdptrs);
 
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
+	/*
+	 * CR0.WP is incorporated into the MMU role, but only for non-nested,
+	 * indirect shadow MMUs.  If TDP is enabled, the MMU's metadata needs
+	 * to be updated, e.g. so that emulating guest translations does the
+	 * right thing, but there's no need to unload the root as CR0.WP
+	 * doesn't affect SPTEs.
+	 */
+	if (tdp_enabled && (cr0 ^ old_cr0) == X86_CR0_WP) {
+		kvm_init_mmu(vcpu);
+		return;
+	}
+
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
 		kvm_clear_async_pf_completion_queue(vcpu);
 		kvm_async_pf_hash_reset(vcpu);
-- 
2.39.2

