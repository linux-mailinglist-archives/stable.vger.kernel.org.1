Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6378ACE2
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjH1Knl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjH1Kn3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:43:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C85EA
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:43:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C60864121
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF1CC433C9;
        Mon, 28 Aug 2023 10:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219370;
        bh=xmdYiA4fJ/w5mB2HlLsl7k7YmlCXyd1O/1peE8502Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDvPxAM1k2ptOoPgEok9FZpaLL7R+vqmAkgo/fZqzUb4AtzzB9U/n+zqZNkWVPPCm
         zjX/mAfV01TjNVNxXjnUfzcnaYtoJpK9BTN/yMh3zFz29cmc/50DK4yQtw3VC7ZZDj
         E9hs6BLJbcLx0xODfNbevmAKEBLk9zyL1XVMdOqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 12/89] MIPS: cpu-features: Enable octeon_cache by cpu_type
Date:   Mon, 28 Aug 2023 12:13:13 +0200
Message-ID: <20230828101150.585108273@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit f641519409a73403ee6612b8648b95a688ab85c2 ]

cpu_has_octeon_cache was tied to 0 for generic cpu-features,
whith this generic kernel built for octeon CPU won't boot.

Just enable this flag by cpu_type. It won't hurt orther platforms
because compiler will eliminate the code path on other processors.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Stable-dep-of: 5487a7b60695 ("MIPS: cpu-features: Use boot_cpu_type for CPU type based features")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/cpu-features.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 3d71081afc55f..133385fe03c69 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -124,7 +124,24 @@
 #define cpu_has_tx39_cache	__opt(MIPS_CPU_TX39_CACHE)
 #endif
 #ifndef cpu_has_octeon_cache
-#define cpu_has_octeon_cache	0
+#define cpu_has_octeon_cache						\
+({									\
+	int __res;							\
+									\
+	switch (current_cpu_type()) {					\
+	case CPU_CAVIUM_OCTEON:						\
+	case CPU_CAVIUM_OCTEON_PLUS:					\
+	case CPU_CAVIUM_OCTEON2:					\
+	case CPU_CAVIUM_OCTEON3:					\
+		__res = 1;						\
+		break;							\
+									\
+	default:							\
+		__res = 0;						\
+	}								\
+									\
+	__res;								\
+})
 #endif
 /* Don't override `cpu_has_fpu' to 1 or the "nofpu" option won't work.  */
 #ifndef cpu_has_fpu
-- 
2.40.1



