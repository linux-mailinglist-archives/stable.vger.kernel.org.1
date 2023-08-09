Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3252D7759BB
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjHILDE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjHILDC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:03:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F582710
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8A8262BD5
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD238C433C7;
        Wed,  9 Aug 2023 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578530;
        bh=VuwI9w1OwwQmh7q/FoCkV/Wy/gKyNzdpNprREe6yMzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AKN2mgFXRYapn0tqLv9y5x5qWbZ3eQAQTH1HKVupJhU0W23As90xF23jscVpUlwq3
         73j0Sx4MfYvXaFIX3ARH07LJKZhH4f8llwMrLjr9VIN3Mz8CCgUjxVPwhrAXoQAUM6
         5nja9QWbToSBpxUXJDLir7LQ6wAMfvsPfVML8Yo0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1 092/127] arm64/fpsimd: Sync FPSIMD state with SVE for SME only systems
Date:   Wed,  9 Aug 2023 12:41:19 +0200
Message-ID: <20230809103639.686518142@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
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
@@ -634,7 +634,7 @@ static void fpsimd_to_sve(struct task_st
 	void *sst = task->thread.sve_state;
 	struct user_fpsimd_state const *fst = &task->thread.uw.fpsimd_state;
 
-	if (!system_supports_sve())
+	if (!system_supports_sve() && !system_supports_sme())
 		return;
 
 	vq = sve_vq_from_vl(thread_get_cur_vl(&task->thread));
@@ -660,7 +660,7 @@ static void sve_to_fpsimd(struct task_st
 	unsigned int i;
 	__uint128_t const *p;
 
-	if (!system_supports_sve())
+	if (!system_supports_sve() && !system_supports_sme())
 		return;
 
 	vl = thread_get_cur_vl(&task->thread);


