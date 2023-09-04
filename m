Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E6E791CEA
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbjIDSdI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244882AbjIDSdC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:33:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD98CCB
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BADBFCE0F94
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB28FC433C8;
        Mon,  4 Sep 2023 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852376;
        bh=ZkM+f0mn0Su4YdaeoyekGGTY6zkDYTIQKt+4yvBHR70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqwZlGlj0WDMLwxUTQc/7REgPHKO2MYeJTYf54Mt0A3U4lGDQMa4GcQuhNRzoJGbI
         iB3j0oNGqTBtsznHLpyybG+SpkfmGXIhWjD9VhGZL7LFYMLeo9LMF5mhlfhtxhOSqB
         4bN4Iu4zY8ILwnx9NzFj4csOX54Vq3TY5t/M4t6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.4 10/32] modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules
Date:   Mon,  4 Sep 2023 19:30:08 +0100
Message-ID: <20230904182948.362545276@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
References: <20230904182947.899158313@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
 kernel/module/main.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1302,12 +1302,20 @@ void *__symbol_get(const char *symbol)
 	};
 
 	preempt_disable();
-	if (!find_symbol(&fsa) || strong_try_module_get(fsa.owner)) {
-		preempt_enable();
-		return NULL;
+	if (!find_symbol(&fsa))
+		goto fail;
+	if (fsa.license != GPL_ONLY) {
+		pr_warn("failing symbol_get of non-GPLONLY symbol %s.\n",
+			symbol);
+		goto fail;
 	}
+	if (strong_try_module_get(fsa.owner))
+		goto fail;
 	preempt_enable();
 	return (void *)kernel_symbol_value(fsa.sym);
+fail:
+	preempt_enable();
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(__symbol_get);
 


