Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F6B7BE05B
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377300AbjJINjc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377647AbjJINjW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:39:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9C91
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:39:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02991C433C7;
        Mon,  9 Oct 2023 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858760;
        bh=N5U8dpJ660GfjtMjZtzTexX+rzcQyUwrRC3fCDtF00Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FWdFrVHBj15CL2NBJ3Aay77UD2BJfKLSL5DacjchvgJf1HksnzDveDv/7MHhPSMZh
         LlIezAB3EiU/tOr8pWbcwMssI43hVHa9rmKXwaVelDcwwAgvedcajGMDTe3Mv5wZwq
         MBu5LmieAuYJhOW+wSkO2NjrUL1VfPlGP0r4wX6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 064/226] Input: i8042 - rename i8042-x86ia64io.h to i8042-acpipnpio.h
Date:   Mon,  9 Oct 2023 15:00:25 +0200
Message-ID: <20231009130128.457172897@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 8761b9b580d53162cca7868385069c0d4354c9e0 ]

Now i8042-x86ia64io.h is shared by X86 and IA64, but it can be shared
by more platforms (such as LoongArch) with ACPI firmware on which PNP
typed keyboard and mouse is configured in DSDT. So rename it to i8042-
acpipnpio.h.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Link: https://lore.kernel.org/r/20220917064020.1639709-1-chenhuacai@loongson.cn
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: eb09074bdb05 ("Input: i8042 - add quirk for TUXEDO Gemini 17 Gen1/Clevo PD70PN")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../input/serio/{i8042-x86ia64io.h => i8042-acpipnpio.h}    | 6 +++---
 drivers/input/serio/i8042.h                                 | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/input/serio/{i8042-x86ia64io.h => i8042-acpipnpio.h} (99%)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-acpipnpio.h
similarity index 99%
rename from drivers/input/serio/i8042-x86ia64io.h
rename to drivers/input/serio/i8042-acpipnpio.h
index 9dcdf21c50bdc..ced72b45aedc8 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _I8042_X86IA64IO_H
-#define _I8042_X86IA64IO_H
+#ifndef _I8042_ACPIPNPIO_H
+#define _I8042_ACPIPNPIO_H
 
 
 #ifdef CONFIG_X86
@@ -1587,4 +1587,4 @@ static inline void i8042_platform_exit(void)
 	i8042_pnp_exit();
 }
 
-#endif /* _I8042_X86IA64IO_H */
+#endif /* _I8042_ACPIPNPIO_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index 55381783dc82d..bf2592fa9a783 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -20,7 +20,7 @@
 #elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
-#include "i8042-x86ia64io.h"
+#include "i8042-acpipnpio.h"
 #else
 #include "i8042-io.h"
 #endif
-- 
2.40.1



