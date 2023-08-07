Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB22D772FFF
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 21:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjHGT5B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjHGT4z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 15:56:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51884E7F
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 12:56:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E05B4621BC
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 19:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA33C433C8;
        Mon,  7 Aug 2023 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438209;
        bh=fJyD+AAHIJnBBhADt8x6I9YY9Z0rlG4FmX11nos9t58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrI4zXjIbVnWciWgqRxLuRz+kL13Vvu6zaMwx3yNg5c17LEXJjh1nqhXc5Q8GHDbN
         sy1T2j9q2t3/agOLjzMbzWlNetA2cVYoMlhWbB/qVLoOCnbCgdPJTED0B2BIGze4kQ
         kSxHh4OINRM3N7ZXJz/lzKdmflVx4gXukpTh/ieXTxneHFTXnuOiIyp6Y7GGOjTvi+
         guGFJ4+gqzhAf8iXJZdDlNsW4l6GQgCbJEUhuk1AA1lYDsKcA6SUBh2T4mhLO/+tZn
         eEYNSXGD1Of+9HCVsxKs/32wOLcC88EC8TztK4f2nD6IfFjnXs5EXCUB5wTuvMWK/M
         qbui2F8aQWgoQ==
From:   Mark Brown <broonie@kernel.org>
To:     stable@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1.y] arm64/ptrace: Don't enable SVE when setting streaming SVE
Date:   Mon,  7 Aug 2023 20:56:33 +0100
Message-Id: <20230807195634.309031-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2023080713-schedule-tuition-b3a5@gregkh>
References: <2023080713-schedule-tuition-b3a5@gregkh>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; i=broonie@kernel.org; h=from:subject; bh=fJyD+AAHIJnBBhADt8x6I9YY9Z0rlG4FmX11nos9t58=; b=owGbwMvMwMWocq27KDak/QLjabUkhpSLPoUVL6aycThs1w7mTI58fL//gYRvgFw4x8Yzxm1vQ/tX HzbtZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAuIsH+P2zX3E2LTvzZ+jTT8qTrs7 6MwlY3v4WFxW+TOMSr767LTLRIOc9w4C4rW7j/jto2l1Nlj/dXbCtPnnhwyoxI9tcCF0/vTV21+o3O npClsh8b9T3U5llqiNsG3OTqCuMWPJfFf3hy1JP3m9hLZtWHFpxdLLH5V8JaZqO4HZbvK2YYBpQq9v c23i3daHDI1lU92nEeb7C6kkpzlu9Sx2weH71/8hPWv+bP03uyTvV4soxL1YT/Uf4s3R3cglPk+zvO bwnIN1+y5/Elp4stb9sZJdPs1Ss/sNza/0zrGZsov7p98xNVi79vUi4Y35adWzNTc8/lb+mZD/gKdH 4L7XpyvOTbN6akKzliUhEcJacB
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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

Systems which implement SME without also implementing SVE are
architecturally valid but were not initially supported by the kernel,
unfortunately we missed one issue in the ptrace code.

The SVE register setting code is shared between SVE and streaming mode
SVE. When we set full SVE register state we currently enable TIF_SVE
unconditionally, in the case where streaming SVE is being configured on a
system that supports vanilla SVE this is not an issue since we always
initialise enough state for both vector lengths but on a system which only
support SME it will result in us attempting to restore the SVE vector
length after having set streaming SVE registers.

Fix this by making the enabling of SVE conditional on setting SVE vector
state. If we set streaming SVE state and SVE was not already enabled this
will result in a SVE access trap on next use of normal SVE, this will cause
us to flush our register state but this is fine since the only way to
trigger a SVE access trap would be to exit streaming mode which will cause
the in register state to be flushed anyway.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230803-arm64-fix-ptrace-ssve-no-sve-v1-1-49df214bfb3e@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
(cherry picked from commit 045aecdfcb2e060db142d83a0f4082380c465d2c)
[Fix up backport -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kernel/ptrace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 92bc9a2d702c..f19f020ccff9 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -937,11 +937,13 @@ static int sve_set_common(struct task_struct *target,
 	/*
 	 * Ensure target->thread.sve_state is up to date with target's
 	 * FPSIMD regs, so that a short copyin leaves trailing
-	 * registers unmodified.  Always enable SVE even if going into
-	 * streaming mode.
+	 * registers unmodified.  Only enable SVE if we are
+	 * configuring normal SVE, a system with streaming SVE may not
+	 * have normal SVE.
 	 */
 	fpsimd_sync_to_sve(target);
-	set_tsk_thread_flag(target, TIF_SVE);
+	if (type == ARM64_VEC_SVE)
+		set_tsk_thread_flag(target, TIF_SVE);
 
 	BUILD_BUG_ON(SVE_PT_SVE_OFFSET != sizeof(header));
 	start = SVE_PT_SVE_OFFSET;
-- 
2.30.2

