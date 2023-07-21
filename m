Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06A75D3F3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjGUTQO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbjGUTQN (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EA41BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA44361D76
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C889FC433C9;
        Fri, 21 Jul 2023 19:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966972;
        bh=fmv0643ko+EClKdwiKENopOTvYCTwpTIGx8A3KHE9PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/q2klRXuCSJcVIFWQoA61fbD+n5T7maOXGakYku8IeL2UD6Zr1cE/lHHLe48eDac
         6Y3YfoT0jhNz/ZefSQwpgeWMZPQHJywQc2soCJkw/us7g2BeqBziDZNf+Lw2lxN2PQ
         KLo+UbR/UNFBofZiKWUG7kYLZVCIZbR+HJZQl09s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5.15 531/532] MIPS: kvm: Fix build error with KVM_MIPS_DEBUG_COP0_COUNTERS enabled
Date:   Fri, 21 Jul 2023 18:07:15 +0200
Message-ID: <20230721160643.416461142@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

commit 3a6dbb691782e88e07e5c70b327495dbd58a2e7f upstream.

Commit e4de20576986 ("MIPS: KVM: Fix NULL pointer dereference") missed
converting one place accessing cop0 registers, which results in a build
error, if KVM_MIPS_DEBUG_COP0_COUNTERS is enabled.

Fixes: e4de20576986 ("MIPS: KVM: Fix NULL pointer dereference")
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kvm/stats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/stats.c b/arch/mips/kvm/stats.c
index 53f851a61554..3e6682018fbe 100644
--- a/arch/mips/kvm/stats.c
+++ b/arch/mips/kvm/stats.c
@@ -54,9 +54,9 @@ void kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
 	kvm_info("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
 	for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
 		for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
-			if (vcpu->arch.cop0->stat[i][j])
+			if (vcpu->arch.cop0.stat[i][j])
 				kvm_info("%s[%d]: %lu\n", kvm_cop0_str[i], j,
-					 vcpu->arch.cop0->stat[i][j]);
+					 vcpu->arch.cop0.stat[i][j]);
 		}
 	}
 #endif
-- 
2.41.0



