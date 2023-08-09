Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1CD7757B9
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjHIKtV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjHIKtU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:49:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2051B1702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:49:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC4ED630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF9CC433C9;
        Wed,  9 Aug 2023 10:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578159;
        bh=xvYD1dep1YWhzvTQn6m/GySYPcIrno23nZcZoGGRNKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2khPX9V7JG/PekarjiqJUXHaL2lfSAz8ReB9salUDyWVa9lO8vIfOWS0afRgjGgO
         39TBer2/zhuGOEiqSQ+ZQqArfbUKBKDgji8MBidE11QQ46IiFb0ahRp2zjfU1Dkbp/
         IE4tFEkNtlAIZGtlcrVmca1px3MQEA8Ng7uSHNco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.4 125/165] arm64/ptrace: Flush FP state when setting ZT0
Date:   Wed,  9 Aug 2023 12:40:56 +0200
Message-ID: <20230809103646.889060040@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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

commit 89a65c3f170e5c3b05a626046c68354e2afd7912 upstream.

When setting ZT0 via ptrace we do not currently force a reload of the
floating point register state from memory, do that to ensure that the newly
set value gets loaded into the registers on next task execution.

The function was templated off the function for FPSIMD which due to our
providing the option of embedding a FPSIMD regset within the SVE regset
does not directly include the flush.

Fixes: f90b529bcbe5 ("arm64/sme: Implement ZT0 ptrace support")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230803-arm64-fix-ptrace-zt0-flush-v1-1-72e854eaf96e@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/ptrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d7f4f0d1ae12..740e81e9db04 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1180,6 +1180,8 @@ static int zt_set(struct task_struct *target,
 	if (ret == 0)
 		target->thread.svcr |= SVCR_ZA_MASK;
 
+	fpsimd_flush_task_state(target);
+
 	return ret;
 }
 
-- 
2.41.0



