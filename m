Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E877ECCA1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjKOTbl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjKOTbk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:31:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C61A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:31:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFB9C433C7;
        Wed, 15 Nov 2023 19:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076697;
        bh=Eho3B012aL8xGKlLzJz+n9xUlnxtbhchHKG0NSDdc6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1R7zFJNB5yabjBEtRg3YD34VOZA0JX9QShtmQWQEIGFVlHpY8B/Zzu/46gXkMGTAL
         L5Rxoz8dkJ2oZIFVwbAdCa0Ot+1Sr2myd+wSeR8BzEm89ElAgGlnvviVPH3Kl6D15S
         tkYMbf/z+wRyfrp5VLSpg1kq+rySyOtGvAmW4AV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Yejian <zhengyejian1@huawei.com>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 392/550] livepatch: Fix missing newline character in klp_resolve_symbols()
Date:   Wed, 15 Nov 2023 14:16:16 -0500
Message-ID: <20231115191628.017083795@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit 67e18e132f0fd738f8c8cac3aa1420312073f795 ]

Without the newline character, the log may not be printed immediately
after the error occurs.

Fixes: ca376a937486 ("livepatch: Prevent module-specific KLP rela sections from referencing vmlinux symbols")
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230914072644.4098857-1-zhengyejian1@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/livepatch/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 61328328c474c..ecbc9b6aba3a1 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -243,7 +243,7 @@ static int klp_resolve_symbols(Elf_Shdr *sechdrs, const char *strtab,
 		 * symbols are exported and normal relas can be used instead.
 		 */
 		if (!sec_vmlinux && sym_vmlinux) {
-			pr_err("invalid access to vmlinux symbol '%s' from module-specific livepatch relocation section",
+			pr_err("invalid access to vmlinux symbol '%s' from module-specific livepatch relocation section\n",
 			       sym_name);
 			return -EINVAL;
 		}
-- 
2.42.0



