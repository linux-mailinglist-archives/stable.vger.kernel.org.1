Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12157A7F54
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjITM0U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbjITM0T (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:26:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D738193
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:26:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B9BC433C7;
        Wed, 20 Sep 2023 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212772;
        bh=BbLVtigG1+zqD6T0J4lm7wXk8IKhNHEmNULyNI0yNGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHil8gNW5HEhhcTPuzQ+zpSVAVyRSfrix9ZNcShei57W/8VQ+wMj89vAc5RoP4Uh1
         fd6ScG9OBCGvJ8f/5gPMF2Q5+rQZYeSR4Ixf6p2FoVR0jf2ihnJVId2bXT5i+suiWr
         yFVHrmzPtJ1iwDzZRK55AdtSyU2DBNPDtnBjK94U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Ming <machel@vivo.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.4 013/367] firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
Date:   Wed, 20 Sep 2023 13:26:30 +0200
Message-ID: <20230920112858.850334306@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -616,7 +616,7 @@ svc_create_memory_pool(struct platform_d
 	paddr = begin;
 	size = end - begin;
 	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
-	if (!va) {
+	if (IS_ERR(va)) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
 	}


