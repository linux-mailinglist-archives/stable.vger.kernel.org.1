Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C939C7616B7
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjGYLlm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjGYLlY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:41:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E0D1FCC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5825461655
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C383C433C7;
        Tue, 25 Jul 2023 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285260;
        bh=VyFStyMnQdG47vupCKZyR4Q6LFqyBIHqOnlzFufy+DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOuw1nllIGLyJvKq/2jT+VeL9nkgcphinAIHV88EE0r7V94eM9GC6DcMjuEi/pcid
         8fO2taP4gr7vhd8jAAcx7KpHyo7o+jxCoaov4AI0RVt66CAVbhQrTzvr/sYP7ycebT
         bOxuUbu2bn8h9TfpofpXkQtuMOPmqPzg78cik8Fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pierre Morel <pmorel@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 141/313] KVM: s390: vsie: fix the length of APCB bitmap
Date:   Tue, 25 Jul 2023 12:44:54 +0200
Message-ID: <20230725104527.101012248@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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
index 2021946176de8..596b2a2cd837d 100644
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



