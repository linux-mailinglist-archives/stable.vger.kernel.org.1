Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79D67A7CF4
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbjITMFk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjITMFk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:05:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2836DA3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:05:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F100C433C9;
        Wed, 20 Sep 2023 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211533;
        bh=4pNnzIrVamKs+pqyH8fCqXBWCLE8wDKuK6ULszKy8+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpHvQb0sgrkeg8BGF6f9ifvWG3ca6H39tn5Fp1T5lYPnlUtbrljWMG33nA9XDK4t1
         V/DYf+93v+UNWwadd3oXJrnZiMI1FEt7yXPZ8ak5RF2eKy3pQl2MbvLvbHkJwS03Wg
         R5ShdBQx+ymratnIqUCpLFcDNKHCZyo4AmDFnH6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 128/186] x86/virt: Drop unnecessary check on extended CPUID level in cpu_has_svm()
Date:   Wed, 20 Sep 2023 13:30:31 +0200
Message-ID: <20230920112841.649192336@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 5df8ecfe3632d5879d1f154f7aa8de441b5d1c89 ]

Drop the explicit check on the extended CPUID level in cpu_has_svm(), the
kernel's cached CPUID info will leave the entire SVM leaf unset if said
leaf is not supported by hardware.  Prior to using cached information,
the check was needed to avoid false positives due to Intel's rather crazy
CPUID behavior of returning the values of the maximum supported leaf if
the specified leaf is unsupported.

Fixes: 682a8108872f ("x86/kvm/svm: Simplify cpu_has_svm()")
Link: https://lore.kernel.org/r/20230721201859.2307736-13-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/virtext.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 4699acd602af4..62810550024d3 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -89,12 +89,6 @@ static inline int cpu_has_svm(const char **msg)
 		return 0;
 	}
 
-	if (boot_cpu_data.extended_cpuid_level < SVM_CPUID_FUNC) {
-		if (msg)
-			*msg = "can't execute cpuid_8000000a";
-		return 0;
-	}
-
 	if (!boot_cpu_has(X86_FEATURE_SVM)) {
 		if (msg)
 			*msg = "svm not available";
-- 
2.40.1



