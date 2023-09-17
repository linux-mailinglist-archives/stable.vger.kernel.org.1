Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9007A374D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjIQTRU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbjIQTRL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:17:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B6FA
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:17:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CD2C433C8;
        Sun, 17 Sep 2023 19:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978225;
        bh=diILsxcSAqwylo+1LbUu3UjTp6nKKz+//uK2NeimGJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqlSadDSAWYFNieaoh9MjK1bF/2CRkedtvxju7LodtDSBTN9WwAvBNju88YCgARxm
         9uTrwXB2dEALOP/IfmXYmlvCk1IMegDe4we8nFmNKp8IN7kc6XiivNACM3ZDu5/nmx
         p3xvtMlRQbZ4lm2aCBOtZYDOJWeF7jcCrpPd76gM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.10 018/406] firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
Date:   Sun, 17 Sep 2023 21:07:52 +0200
Message-ID: <20230917191101.629298840@linuxfoundation.org>
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

From: Wang Ming <machel@vivo.com>

commit dd218433f2b635d97e8fda3eed047151fd528ce4 upstream.

The devm_memremap() function returns error pointers.
It never returns NULL. Fix the check.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wang Ming <machel@vivo.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Link: https://lore.kernel.org/r/20230727193750.983795-1-dinguyen@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/stratix10-svc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -623,7 +623,7 @@ svc_create_memory_pool(struct platform_d
 	paddr = begin;
 	size = end - begin;
 	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
-	if (!va) {
+	if (IS_ERR(va)) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
 	}


