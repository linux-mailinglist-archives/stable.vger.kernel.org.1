Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364B37ECD9C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbjKOThZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjKOThZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:37:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02AD1A7
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:37:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5082FC433C7;
        Wed, 15 Nov 2023 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077041;
        bh=vSZlFiJSZHT+Mm41hL/Rb3Lp03hQrPWKzBEltiykEok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lbRZgbRd1kbM3sOWd2EgmFzqPxDQ0Dh3qGHQry2xK9Wpopvw90EGplTH5olHD4z0h
         q25j6jlEOnZlynm4LULaCjJZikvMsuHLfz7gP2fDYoh0ZcD5ITG2LgAKh2NC6PIglY
         d3ocGpCd+tR5Z6/MmeHotkW61ELflItngL5NZY+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 106/603] libbpf: Fix syscall access arguments on riscv
Date:   Wed, 15 Nov 2023 14:10:51 -0500
Message-ID: <20231115191620.541731067@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Ghiti <alexghiti@rivosinc.com>

[ Upstream commit 8a412c5c1cd6cc6c55e8b9b84fbb789fc395fe78 ]

Since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers"), riscv
selects ARCH_HAS_SYSCALL_WRAPPER so let's use the generic implementation
of PT_REGS_SYSCALL_REGS().

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/bpf/20231004110905.49024-2-bjorn@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 3803479dbe106..1c13f8e88833b 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -362,8 +362,6 @@ struct pt_regs___arm64 {
 #define __PT_PARM7_REG a6
 #define __PT_PARM8_REG a7
 
-/* riscv does not select ARCH_HAS_SYSCALL_WRAPPER. */
-#define PT_REGS_SYSCALL_REGS(ctx) ctx
 #define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
 #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
 #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
-- 
2.42.0



