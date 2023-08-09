Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E967757B6
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjHIKtM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjHIKtM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87B31702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:49:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4985C63123
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B207C433C8;
        Wed,  9 Aug 2023 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578150;
        bh=B1JbXKcGI7cr6P6giT4nARUL76oNhIvPlJYyBMp1dn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qR7Zsywjfu7NEV4Bllx1sXGMuxACuVcshuRlMzFnZlIlQuzRSNeDlyab2Qi+qCp1l
         BYIozcTAxmOICJ43lY4khN5+gMmYCNMucRaFAGfotUa5wePgv8kyOpSGITNhbZk36B
         j293tfb2H8xvaN8lf84hoh2M+Uvg9HSflcX4W6io=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Spickett <David.Spickett@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.4 123/165] arm64/fpsimd: Clear SME state in the target task when setting the VL
Date:   Wed,  9 Aug 2023 12:40:54 +0200
Message-ID: <20230809103646.826769550@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit c9bb40b7f786662e33d71afe236442b0b61f0446 upstream.

When setting SME vector lengths we clear TIF_SME to reenable SME traps,
doing a reallocation of the backing storage on next use. We do this using
clear_thread_flag() which operates on the current thread, meaning that when
setting the vector length via ptrace we may both not force traps for the
target task and force a spurious flush of any SME state that the tracing
task may have.

Clear the flag in the target task.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Reported-by: David Spickett <David.Spickett@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230803-arm64-fix-ptrace-tif-sme-v1-1-88312fd6fbfd@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/fpsimd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -910,7 +910,7 @@ int vec_set_vector_length(struct task_st
 			 */
 			task->thread.svcr &= ~(SVCR_SM_MASK |
 					       SVCR_ZA_MASK);
-			clear_thread_flag(TIF_SME);
+			clear_tsk_thread_flag(task, TIF_SME);
 			free_sme = true;
 		}
 	}


