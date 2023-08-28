Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403D78AB5D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjH1KaR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjH1K3s (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:29:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CF1AB
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5F6263C13
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85F8C433C8;
        Mon, 28 Aug 2023 10:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218585;
        bh=JbkJefR4ZOLPspLlD47Dsuq4yZrA/8CmfARt6lkxlEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qpkefqbAol0Dr2bOS6ZKshJvhxZfR0aYyMoPij/MGghDBpz8/NW22JXGh68pbPhIU
         DsW/daoJnhUcv08BHZCiF7wty8Tq2nJoCTexmrVYwq3HdRW1x+TiMq1A3aWWji8joR
         7pnDEyiXIGowtrZX4uMpsLLgd/T/oYww7StMCMYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 011/122] MIPS: cpu-features: Enable octeon_cache by cpu_type
Date:   Mon, 28 Aug 2023 12:12:06 +0200
Message-ID: <20230828101156.842993300@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index c0983130a44c9..53c8551ec89bc 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -121,7 +121,24 @@
 #define cpu_has_4k_cache	__isa_ge_or_opt(1, MIPS_CPU_4K_CACHE)
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



