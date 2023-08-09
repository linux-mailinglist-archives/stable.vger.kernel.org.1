Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A737775912
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjHIK5a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjHIK5A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:57:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F582106
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06E5362E4A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109A8C433C8;
        Wed,  9 Aug 2023 10:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578616;
        bh=KG2uNkAEqoDSoAwq4eQnzbpCe5wkgpvQvAStaEeR5Xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqZBYcvpuhZXXe9oCMEfUa/cUTFfLpO8cfJGqef1sGAS3ZsLIWKiDHxm/SB0NXjnL
         HlAlJfVe0gMPLmgaZM4L2fzikXexiLcIeDNF78GPRil+KxIqn9yVLWZxJXaa1hsJf9
         2eK7T+Pa7NQXuBqIFr9uUNCe95kAJKZhBURIiHtM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1 123/127] arm64/ptrace: Dont enable SVE when setting streaming SVE
Date:   Wed,  9 Aug 2023 12:41:50 +0200
Message-ID: <20230809103640.671527167@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 045aecdfcb2e060db142d83a0f4082380c465d2c upstream.

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
[Fix up backport -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/ptrace.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -937,11 +937,13 @@ static int sve_set_common(struct task_st
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


