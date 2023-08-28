Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570B478A68D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 09:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjH1Hdv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 03:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjH1Hdj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 03:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04718CC
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 00:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9801C632A8
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 07:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B851C433C7;
        Mon, 28 Aug 2023 07:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693208016;
        bh=2x7wfLGdG/cy0yQreIw0wJQ8AHnpk1QQQps/j1TDoDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fF+E0EHKIuBLI1Gu9OAi6eufpBkb1Q7VleibBR5avZPur/MNW/wjOlWmB8h3ZL0ot
         bDtgfI2TX1CVNqxlvbkFm1sr+GQA4E2QsKaa/rpc8CIJArvrU2X+0o+w9FYVlF6u2u
         rXUK4lWOGroTMR6+RGQdFBGrTSILxeSLrUAWVkrL8azGF43AOelPRgFT2HoxhKgrRm
         +n9Uyfo71FDHHs+Zspjw/qjcI9c4jlg3r/t2adl+GTRsbHM5dUrU1FBKP/nHK5imly
         gPyS6s8+AN6xpvpEQfv8/3hx/HjAhkTGp3iyq7v8R14zwQ0QQmRfk65nSn3ojMJ/xZ
         jltYta23rWOEg==
Date:   Mon, 28 Aug 2023 10:33:03 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     riel@surriel.com, robh@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm,ima,kexec,of: use memblock_free_late
 from" failed to apply to 5.15-stable tree
Message-ID: <20230828073303.GA3223@kernel.org>
References: <2023082642-catfight-gallantly-8b84@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023082642-catfight-gallantly-8b84@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

On Sat, Aug 26, 2023 at 07:43:42PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This version applies to 5.15-stable:

From 582bd7a69533d8b3b5ad3e1df93cb382d25407d8 Mon Sep 17 00:00:00 2001
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
(cherry picked from commit f0362a253606e2031f8d61c74195d4d6556e12a4)
Signed-off-by: Mike Rappoport (IBM) <rppt@kernel.org>
---
 drivers/of/kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 52bb68fb2216..3a07cc58e7d7 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -187,8 +187,8 @@ int ima_free_kexec_buffer(void)
 	if (ret)
 		return ret;
 
-	return memblock_free(addr, size);
-
+	memblock_free_late(addr, size);
+	return 0;
 }
 
 /**
-- 
2.39.2

 
