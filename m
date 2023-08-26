Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69821789881
	for <lists+stable@lfdr.de>; Sat, 26 Aug 2023 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjHZRoM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 26 Aug 2023 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjHZRnt (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 26 Aug 2023 13:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A50103
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 10:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35B6D6204B
        for <stable@vger.kernel.org>; Sat, 26 Aug 2023 17:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46184C433C8;
        Sat, 26 Aug 2023 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693071825;
        bh=7ugB8SYMvdBLrYmeIvd26KP+X7b/kqiNd97LYtr7ZCg=;
        h=Subject:To:Cc:From:Date:From;
        b=MlmzkiQ+1BihET657TTJqwiFTGa4R/ZpgXUcOPsHbmPANIM00GzLu3cnvoS/yW2OM
         G0dxdsOTx5ACkxkwdXpGKDrxrLB4iOwfVHlnvIt/q407FHWdNhEhUZubvyHi860ikR
         esOp6brUdilQxHfzdOFvsJmiPnuU6T/Obw47Tcuk=
Subject: FAILED: patch "[PATCH] mm,ima,kexec,of: use memblock_free_late from" failed to apply to 5.15-stable tree
To:     riel@surriel.com, robh@kernel.org, rppt@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 26 Aug 2023 19:43:42 +0200
Message-ID: <2023082642-catfight-gallantly-8b84@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f0362a253606e2031f8d61c74195d4d6556e12a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082642-catfight-gallantly-8b84@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

f0362a253606 ("mm,ima,kexec,of: use memblock_free_late from ima_free_kexec_buffer")
3ecc68349bba ("memblock: rename memblock_free to memblock_phys_free")
fa27717110ae ("memblock: drop memblock_free_early_nid() and memblock_free_early()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0362a253606e2031f8d61c74195d4d6556e12a4 Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Thu, 17 Aug 2023 13:57:59 -0400
Subject: [PATCH] mm,ima,kexec,of: use memblock_free_late from
 ima_free_kexec_buffer

The code calling ima_free_kexec_buffer runs long after the memblock
allocator has already been torn down, potentially resulting in a use
after free in memblock_isolate_range.

With KASAN or KFENCE, this use after free will result in a BUG
from the idle task, and a subsequent kernel panic.

Switch ima_free_kexec_buffer over to memblock_free_late to avoid
that issue.

Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec functions to drivers/of/kexec.c")
Cc: stable@kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Suggested-by: Mike Rappoport <rppt@kernel.org>
Link: https://lore.kernel.org/r/20230817135759.0888e5ef@imladris.surriel.com
Signed-off-by: Rob Herring <robh@kernel.org>

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index f26d2ba8a371..68278340cecf 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -184,7 +184,8 @@ int __init ima_free_kexec_buffer(void)
 	if (ret)
 		return ret;
 
-	return memblock_phys_free(addr, size);
+	memblock_free_late(addr, size);
+	return 0;
 }
 #endif
 

