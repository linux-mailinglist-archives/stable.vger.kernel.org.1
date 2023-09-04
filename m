Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC45791D44
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347179AbjIDSg5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjIDSgz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:36:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69969E
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87895B80EF4
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:36:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E11C433C8;
        Mon,  4 Sep 2023 18:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852610;
        bh=8ptofNUWLkErs0orxWI2bRH4Cndt2V+p2Sg5QVUh+Tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkCvTmRwenblOttXM/A+l9qnAxP0liRuhOb5iFACmb1EWFYNtziSKfP63z3BCHE6v
         h6C16bb03eOHkTP9tzBe36Ri4hBQM98lFzFts3D3+myM0E+eFnx7pz02ywuTwSC4kE
         5UhVIHFOYQouGtbDL0PwVaQnARim9BfXLSpz/XlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5.15 08/28] modules: only allow symbol_get of EXPORT_SYMBOL_GPL modules
Date:   Mon,  4 Sep 2023 19:30:39 +0100
Message-ID: <20230904182945.570534362@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
References: <20230904182945.178705038@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
 kernel/module.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2220,12 +2220,20 @@ void *__symbol_get(const char *symbol)
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
 


