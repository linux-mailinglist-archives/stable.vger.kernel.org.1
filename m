Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FCC6FA8D8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjEHKpv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjEHKpZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28572A871
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:44:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2AA062886
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B67C433D2;
        Mon,  8 May 2023 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542678;
        bh=5FQnNizxAeg/D9Je3T6aRDxQAIyYUeU5KxvGIAY73nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dEPgTglboU9rPr3IKX8YAqv/1S0yIASSKTwDPPCdGRNiDOcwCbiMPtdzk8EpRwncx
         gCe1YC5VvrSvyK9Ac6LZE6RzezPvi3aJmVm7w05vCyZAA5gU8rKEPXLL//YpXLJren
         pOtVlxCO1bGhNGsykpXjgnE4Of7dYxTPhEFR3Xp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 512/663] Revert "objtool: Support addition to set CFA base"
Date:   Mon,  8 May 2023 11:45:38 +0200
Message-Id: <20230508094445.346420850@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit e18398e80c73e3cc7d9c3d2e0bc06a4af8f4f1cb ]

Commit 468af56a7bba ("objtool: Support addition to set CFA base") was
added as a preparatory patch for arm64 support, but that support never
came.  It triggers a false positive warning on x86, so just revert it
for now.

Fixes the following warning:

  vmlinux.o: warning: objtool: cdce925_regmap_i2c_write+0xdb: stack state mismatch: cfa1=4+120 cfa2=5+40

Fixes: 468af56a7bba ("objtool: Support addition to set CFA base")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/oe-kbuild-all/202304080538.j5G6h1AB-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ea1e7cdeb1b34..3b1e19894b21a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2913,17 +2913,6 @@ static int update_cfi_state(struct instruction *insn,
 				break;
 			}
 
-			if (!cfi->drap && op->src.reg == CFI_SP &&
-			    op->dest.reg == CFI_BP && cfa->base == CFI_SP &&
-			    check_reg_frame_pos(&regs[CFI_BP], -cfa->offset + op->src.offset)) {
-
-				/* lea disp(%rsp), %rbp */
-				cfa->base = CFI_BP;
-				cfa->offset -= op->src.offset;
-				cfi->bp_scratch = false;
-				break;
-			}
-
 			if (op->src.reg == CFI_SP && cfa->base == CFI_SP) {
 
 				/* drap: lea disp(%rsp), %drap */
-- 
2.39.2



