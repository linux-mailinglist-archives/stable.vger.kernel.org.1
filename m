Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC036FD186
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjEIVh5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 17:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbjEIVh5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 17:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796947D8E
        for <stable@vger.kernel.org>; Tue,  9 May 2023 14:37:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7686B61375
        for <stable@vger.kernel.org>; Tue,  9 May 2023 21:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E884C433D2;
        Tue,  9 May 2023 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683668256;
        bh=/qMD6Gzx42SZa/kvnOtKImiPphXGirzLMrCTaV+CjKI=;
        h=From:To:Cc:Subject:Date:From;
        b=UToau5gobOlzya/rfKvuy8LmtsPuVdvnBk6T9UnDVFuvwCyNPN4DGbDHHnd5Ic3pr
         Dj5+TyXUS1/6THMaNiTEDUD2dm4AULnXwDpPbgcOwugZpKCrJDWvT17gEWHGal8DJF
         3WpoPDit/GorQ9Xm1Ok/35lfNtS73WTcKnEBI2T9Oxm/zb0NLz55SnvNk71oXIfTBJ
         KypMXAjPFRbWa7R13LN0tGpZVWKKZU93DB97EbQwr09BaIu10LZ0XelVx6z1U7yQl4
         67/FPFBRD6se9KfqYl4KCnZ5HGy3hvjOfQh/ac5XO5TxARRGvTPYKBD10ndswY26JB
         AFO7l8hePIPZg==
From:   Conor Dooley <conor@kernel.org>
To:     stable@vger.kernel.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        palmer@dabbelt.com, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.1 v1] RISC-V: fix lock splat in riscv_cpufeature_patch_func()
Date:   Tue,  9 May 2023 22:36:42 +0100
Message-Id: <20230509-suspend-labrador-3eb6f0a8ac77@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1402; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=cmpJvMcC7Z+LVB1dS1TVFP8k1KKVKAPgETqIEvmqKW8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClRe55vW3P6zboCn0tlpde53dzlpUUFWlxNNNeZaUew7 Z9S8Uyho5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNR2sLw3+farX8zy509pD1X sx30ZOLOymgvX+ggPsNFjdVFfekBLkaGGzfkKtT6ijfHyV8U4j/Mmscj1rxsc0HiOv/qqQ9kfx7 jBwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Guenter reported a lockdep splat that appears to have been present for a
while in v6.1.y & the backports of the riscv_patch_in_stop_machine dance
did nothing to help here, as the lock is not being taken when
patch_text_nosync() is called in riscv_cpufeature_patch_func().
Add the lock/unlock; elide the splat.

Fixes: c15ac4fd60d5 ("riscv/ftrace: Add dynamic function tracer support")
Reported-by: Guenter Roeck <linux@roeck-us.net>
cc: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpufeature.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 694267d1fe81..fd1238df6149 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <asm/alternative.h>
@@ -316,8 +317,11 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
 		}
 
 		tmp = (1U << alt->errata_id);
-		if (cpu_req_feature & tmp)
+		if (cpu_req_feature & tmp) {
+			mutex_lock(&text_mutex);
 			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+			mutex_unlock(&text_mutex);
+		}
 	}
 }
 #endif
-- 
2.39.2

