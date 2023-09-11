Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F08279B53C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbjIKUyG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbjIKOUB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:20:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7918EDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:19:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE853C433C8;
        Mon, 11 Sep 2023 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441997;
        bh=hyRSMd1kWblmFE1tYwnE8aSsDOtdUr3GAW8z0SPOUg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1HSKG6Ri/LY9X55VbT1A28UipAPt0l1UxmACsrs4U0U+9oLEqeWWrmZba15jq8RFc
         zKaiQCOtrtWj+ULArioNm2mTZGc/JzmzEhWkYl2hp4ZUImgyxIc+iwH26Zu1Ag4g4x
         Vr61/ao2siUbhVX9bOxrM6lxJlMR5Vu9oBdxVJE4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 583/739] riscv: Require FRAME_POINTER for some configurations
Date:   Mon, 11 Sep 2023 15:46:22 +0200
Message-ID: <20230911134707.389497222@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 9f944d2e0ab39296bfadb29167dc333815ba9f48 ]

Some V configurations implicitly turn on '-fno-omit-frame-pointer',
but leaving FRAME_POINTER disabled. This makes it hard to reason about
the FRAME_POINTER config, and also triggers build failures introduced
in by the commit in the Fixes: tag.

Select FRAME_POINTER explicitly for these configurations.

Fixes: ebc9cb03b21e ("riscv: stack: Fixup independent softirq stack for CONFIG_FRAME_POINTER=n")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230823082845.354839-1-bjorn@kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/Kconfig  | 1 +
 arch/riscv/Makefile | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bea7b73e895dd..ab099679f808c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -62,6 +62,7 @@ config RISCV
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
+	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6ec6d52a41804..1329e060c5482 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -87,9 +87,6 @@ endif
 ifeq ($(CONFIG_CMODEL_MEDANY),y)
 	KBUILD_CFLAGS += -mcmodel=medany
 endif
-ifeq ($(CONFIG_PERF_EVENTS),y)
-        KBUILD_CFLAGS += -fno-omit-frame-pointer
-endif
 
 # Avoid generating .eh_frame sections.
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables -fno-unwind-tables
-- 
2.40.1



