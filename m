Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE657614EB
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjGYLX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjGYLX5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E67519A0
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EDE76166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D958C433C8;
        Tue, 25 Jul 2023 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284232;
        bh=XI6M1w5VTDzPH3F6KzFd7It1qhsg/ujnH8pfIcWkUwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0S/e/z5dQ2tkcuPKsH+yATLbLiF+ktR5/+CmSoYsEMccdyW01N5h+el2fleEeWiPT
         9GUckceaiUruSWrMV6wguUG3A3xm8m1agVCy+n2IYspgyfT/97YyPbZMVGngOOOlA+
         w+1UHCoj2cqCRxS8FgNmyWLGjjFijuNSubF9wJ4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pierre Morel <pmorel@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 253/509] KVM: s390: vsie: fix the length of APCB bitmap
Date:   Tue, 25 Jul 2023 12:43:12 +0200
Message-ID: <20230725104605.321382563@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pierre Morel <pmorel@linux.ibm.com>

[ Upstream commit 246be7d2720ea9a795b576067ecc5e5c7a1e7848 ]

bit_and() uses the count of bits as the woking length.
Fix the previous implementation and effectively use
the right bitmap size.

Fixes: 19fd83a64718 ("KVM: s390: vsie: allow CRYCB FORMAT-1")
Fixes: 56019f9aca22 ("KVM: s390: vsie: Allow CRYCB FORMAT-2")

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Link: https://lore.kernel.org/kvm/20230511094719.9691-1-pmorel@linux.ibm.com/
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/vsie.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index ff58decfef5e8..192eacc8fbb7a 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -168,7 +168,8 @@ static int setup_apcb00(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
 			    sizeof(struct kvm_s390_apcb0)))
 		return -EFAULT;
 
-	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb0));
+	bitmap_and(apcb_s, apcb_s, apcb_h,
+		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb0));
 
 	return 0;
 }
@@ -190,7 +191,8 @@ static int setup_apcb11(struct kvm_vcpu *vcpu, unsigned long *apcb_s,
 			    sizeof(struct kvm_s390_apcb1)))
 		return -EFAULT;
 
-	bitmap_and(apcb_s, apcb_s, apcb_h, sizeof(struct kvm_s390_apcb1));
+	bitmap_and(apcb_s, apcb_s, apcb_h,
+		   BITS_PER_BYTE * sizeof(struct kvm_s390_apcb1));
 
 	return 0;
 }
-- 
2.39.2



