Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC80677AB59
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjHMVUx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHMVUx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:20:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CA910E5
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:20:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02544617CE
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167DAC433C7;
        Sun, 13 Aug 2023 21:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961654;
        bh=DexnU5Frb6lBjtPhStp0F+tjFQPdAtgwzaD7fXUpvE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIdQZPYherTs4Fvs47CzJqzumQna99c3O/BVrj6WJ02hqcSVf6RV0ke6MFUBJOOKP
         tMKpnSBTbbPlnvVz6tdmFSuaPLJu139mu53KXJyyyDxQ2TL+vWuDMb8PM0ZZvUOqfG
         OEMjjdeE/QPtiEvBppvtWSv9CEEbs1qpBnCr/7hg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        stable@kernel.org
Subject: [PATCH 4.14 12/26] x86: Move gds_ucode_mitigated() declaration to header
Date:   Sun, 13 Aug 2023 23:19:05 +0200
Message-ID: <20230813211703.450901345@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
References: <20230813211702.980427106@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit eb3515dc99c7c85f4170b50838136b2a193f8012 upstream.

The declaration got placed in the .c file of the caller, but that
causes a warning for the definition:

arch/x86/kernel/cpu/bugs.c:682:6: error: no previous prototype for 'gds_ucode_mitigated' [-Werror=missing-prototypes]

Move it to a header where both sides can observe it instead.

Fixes: 81ac7e5d74174 ("KVM: Add GDS_NO support to KVM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/all/20230809130530.1913368-2-arnd%40kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/processor.h |    2 ++
 arch/x86/kvm/x86.c               |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -992,4 +992,6 @@ enum taa_mitigations {
 	TAA_MITIGATION_TSX_DISABLED,
 };
 
+extern bool gds_ucode_mitigated(void);
+
 #endif /* _ASM_X86_PROCESSOR_H */
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -201,8 +201,6 @@ struct kvm_stats_debugfs_item debugfs_en
 
 u64 __read_mostly host_xcr0;
 
-extern bool gds_ucode_mitigated(void);
-
 static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt);
 
 static inline void kvm_async_pf_hash_reset(struct kvm_vcpu *vcpu)


