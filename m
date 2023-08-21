Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144C87831E3
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjHUUJC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjHUUJB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB9FDF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E190C64A5D
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF98BC433C8;
        Mon, 21 Aug 2023 20:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648539;
        bh=+1HAN5myfBu/T1grATkD4KwhI3E6gBZVNKZdlFTtLv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=odCRWvv8bTKOTNELtnw5qDcdCNLc2lA0OnkDkKzdxM4mjUS2DgdS0L7v16jzVmVyA
         Lywzen2wNum96fj628NQoW6axleJkAfhDbfa93RQJuyDg0+yyaQDx7xr78/IBG90iE
         7Lquh8evOK+5ibmtLOsU19XnK+eCFEnLgjTRsEhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.4 211/234] arm64/ptrace: Ensure that the task sees ZT writes on first use
Date:   Mon, 21 Aug 2023 21:42:54 +0200
Message-ID: <20230821194138.191055135@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 2f43f549cd0b3164ea0345e59aa3958c0d243383 upstream.

When the value of ZT is set via ptrace we don't disable traps for SME.
This means that when a the task has never used SME before then the value
set via ptrace will never be seen by the target task since it will
trigger a SME access trap which will flush the register state.

Disable SME traps when setting ZT, this means we also need to allocate
storage for SVE if it is not already allocated, for the benefit of
streaming SVE.

Fixes: f90b529bcbe5 ("arm64/sme: Implement ZT0 ptrace support")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org> # 6.3.x
Link: https://lore.kernel.org/r/20230816-arm64-zt-ptrace-first-use-v2-1-00aa82847e28@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/ptrace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index a31af7a1abe3..187aa2b175b4 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1177,6 +1177,11 @@ static int zt_set(struct task_struct *target,
 	if (!system_supports_sme2())
 		return -EINVAL;
 
+	/* Ensure SVE storage in case this is first use of SME */
+	sve_alloc(target, false);
+	if (!target->thread.sve_state)
+		return -ENOMEM;
+
 	if (!thread_za_enabled(&target->thread)) {
 		sme_alloc(target, true);
 		if (!target->thread.sme_state)
@@ -1186,8 +1191,10 @@ static int zt_set(struct task_struct *target,
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 thread_zt_state(&target->thread),
 				 0, ZT_SIG_REG_BYTES);
-	if (ret == 0)
+	if (ret == 0) {
 		target->thread.svcr |= SVCR_ZA_MASK;
+		set_tsk_thread_flag(target, TIF_SME);
+	}
 
 	fpsimd_flush_task_state(target);
 
-- 
2.41.0



