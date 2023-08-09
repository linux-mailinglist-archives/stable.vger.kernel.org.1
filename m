Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FCA7757B7
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjHIKtR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjHIKtP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:49:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804021BFF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:49:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17F18630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A55C433C7;
        Wed,  9 Aug 2023 10:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578153;
        bh=xbsLAV8IujelOUvYIZi8mZE4b77dSNYMERzBEQHt+JM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXGLB5hP13wijHxxSu+EPUxMIsAcvZYE7UbpObbMBH0Hn+qRwdSeDpcnOtUvMu2lX
         uRw2YXFsCFG3qFMgrKSWAfVLZ/p0RdXifI9o5S+Mq+JhK/lSZMWhF+Dan78/hXgaDZ
         OYrGjlswS/XvnV/hR9UqFaReSB/XTB+mSKlQ17E4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.4 124/165] arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems
Date:   Wed,  9 Aug 2023 12:40:55 +0200
Message-ID: <20230809103646.856394615@linuxfoundation.org>
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

commit 507ea5dd92d23fcf10e4d1a68a443c86a49753ed upstream.

Currently we guard FPSIMD/SVE state conversions with a check for the system
supporting SVE but SME only systems may need to sync streaming mode SVE
state so add a check for SME support too.  These functions are only used
by the ptrace code.

Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230803-arm64-fix-ptrace-ssve-no-sve-v1-2-49df214bfb3e@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/fpsimd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -679,7 +679,7 @@ static void fpsimd_to_sve(struct task_st
 	void *sst = task->thread.sve_state;
 	struct user_fpsimd_state const *fst = &task->thread.uw.fpsimd_state;
 
-	if (!system_supports_sve())
+	if (!system_supports_sve() && !system_supports_sme())
 		return;
 
 	vq = sve_vq_from_vl(thread_get_cur_vl(&task->thread));
@@ -705,7 +705,7 @@ static void sve_to_fpsimd(struct task_st
 	unsigned int i;
 	__uint128_t const *p;
 
-	if (!system_supports_sve())
+	if (!system_supports_sve() && !system_supports_sme())
 		return;
 
 	vl = thread_get_cur_vl(&task->thread);


