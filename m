Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8CC7ECDC0
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjKOTiM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjKOTiM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A609E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01CBC433C9;
        Wed, 15 Nov 2023 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077088;
        bh=uLOnQByyzyyesfYzyKeUM4Ez5lKEROsVMGrkVAZE1Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFJu8Lws6/VP6lhqAicENeD+oX7wbROJWUkHsamvvOJFfaAuaWUlGLRwTmTKnHPAk
         Ia/hnq7XGskR5aZyGiN/ZgApWNu9zgUURxZqF0Kes5VjpHzcrKNbRTGi0j2E9QpA6G
         12lNEmorZamuDw8Bpa0Zi4B46o3J/as7BGv2Mx7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 107/603] selftests/bpf: Define SYS_PREFIX for riscv
Date:   Wed, 15 Nov 2023 14:10:52 -0500
Message-ID: <20231115191620.613275241@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit 0f2692ee4324679df6c80ccbb75660564009d187 ]

SYS_PREFIX was missing for a RISC-V, which made a couple of kprobe
tests fail.

Add missing SYS_PREFIX for RISC-V.

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/bpf/20231004110905.49024-3-bjorn@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 38a57a2e70dbe..799fff4995d87 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -99,6 +99,9 @@
 #elif defined(__TARGET_ARCH_arm64)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__arm64_"
+#elif defined(__TARGET_ARCH_riscv)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX "__riscv_"
 #else
 #define SYSCALL_WRAPPER 0
 #define SYS_PREFIX "__se_"
-- 
2.42.0



