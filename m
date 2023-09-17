Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B527A3756
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjIQTRv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbjIQTRb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:17:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6485DFA
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:17:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911E8C433C7;
        Sun, 17 Sep 2023 19:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978246;
        bh=JWs0LBhpwwIUS7LntikmAzFCPNAkZpkFGORHMHIL6Cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0sC+M8JtevOTr2ZrScnF50KtAkv6IJpexripD3eIUY8IiU05DRqUvaP8jZfFHP77
         AE3Ll2x2JWSHb5WHh+SYU7GHoZ1k3bWUZrSubyPXRGknG/MBbVpLG9rGkCba3Wz7rD
         APJ3dxpEqZ6qr3ZWRcReH6lSDjmLaKxPpVPB8/OQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5.10 006/406] modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules
Date:   Sun, 17 Sep 2023 21:07:40 +0200
Message-ID: <20230917191101.257176910@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

commit 9011e49d54dcc7653ebb8a1e05b5badb5ecfa9f9 upstream.

It has recently come to my attention that nvidia is circumventing the
protection added in 262e6ae7081d ("modules: inherit
TAINT_PROPRIETARY_MODULE") by importing exports from their proprietary
modules into an allegedly GPL licensed module and then rexporting them.

Given that symbol_get was only ever intended for tightly cooperating
modules using very internal symbols it is logical to restrict it to
being used on EXPORT_SYMBOL_GPL and prevent nvidia from costly DMCA
Circumvention of Access Controls law suites.

All symbols except for four used through symbol_get were already exported
as EXPORT_SYMBOL_GPL, and the remaining four ones were switched over in
the preparation patches.

Fixes: 262e6ae7081d ("modules: inherit TAINT_PROPRIETARY_MODULE")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/module.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2268,15 +2268,26 @@ static void free_module(struct module *m
 void *__symbol_get(const char *symbol)
 {
 	struct module *owner;
+	enum mod_license license;
 	const struct kernel_symbol *sym;
 
 	preempt_disable();
-	sym = find_symbol(symbol, &owner, NULL, NULL, true, true);
-	if (sym && strong_try_module_get(owner))
+	sym = find_symbol(symbol, &owner, NULL, &license, true, true);
+	if (!sym)
+		goto fail;
+	if (license != GPL_ONLY) {
+		pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
+			symbol);
+		goto fail;
+	}
+	if (strong_try_module_get(owner))
 		sym = NULL;
 	preempt_enable();
 
 	return sym ? (void *)kernel_symbol_value(sym) : NULL;
+fail:
+	preempt_enable();
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 


