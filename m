Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEB96FA5AA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjEHKLz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjEHKLv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:11:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5D1FD8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:11:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD898623E5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5E0C433EF;
        Mon,  8 May 2023 10:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540705;
        bh=WxF2jrT1m3RssrfoI+V2gSKbCvoBy2n48F2UUahVRvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAIY1hWbnlQQ+epEQlX3yhxfYlb/N8zgmrlx5JU5GvZBuTyJchjrQUIMJvIOMtUMK
         3Opghzjvi2GjpfW4Eci+11geExEUvCeOu48UO8hYDdUt8fQCl9o6jWho9PEFJ2lqAb
         H9fDCnthgmvCAN2+n+ZTnSmsZ0O+OeN9ruhffWcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 467/611] Revert "objtool: Support addition to set CFA base"
Date:   Mon,  8 May 2023 11:45:09 +0200
Message-Id: <20230508094437.305459697@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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
index 730b49e255e44..c2c350933a237 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2757,17 +2757,6 @@ static int update_cfi_state(struct instruction *insn,
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



