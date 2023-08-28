Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEEC78ABAB
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjH1Kd2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjH1Kc6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903B318B
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:32:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 693B063D57
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A072C433C8;
        Mon, 28 Aug 2023 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218744;
        bh=vJW8WipR9n+9EYEUzxEOpcVIibnM8IomNqA+EqzBgfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mfv/WBK5fxj0WVlerTHeOMGWWgls2vnNlXlgQeAu3Ss1vMjynQSTRKcNIs8CdjBuc
         Q3raxNw9dzhM7QBTpjN98iuW+SUUEj3OyibISsrooNyd9ffzouwQUCdIGhM+BrtBRf
         9tmURyB53wvRM1vk/1C/D4DHNu+2Wfg2JwwrgvME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mike Rappoport <rppt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [PATCH 6.1 068/122] mm,ima,kexec,of: use memblock_free_late from ima_free_kexec_buffer
Date:   Mon, 28 Aug 2023 12:13:03 +0200
Message-ID: <20230828101158.711325423@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rik van Riel <riel@surriel.com>

commit f0362a253606e2031f8d61c74195d4d6556e12a4 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/kexec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
 


