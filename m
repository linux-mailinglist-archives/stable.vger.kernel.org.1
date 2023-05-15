Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B66703AFB
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjEOR6c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbjEOR5x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340331996D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D6E062FE2
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFC4C433D2;
        Mon, 15 May 2023 17:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173327;
        bh=rKN8FchKCnzGab1wEBlR+lkjrdbK84rIZCbqKmfAAZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yqaQXdiWJWdNq1c5fJR58zVil/14EbP+2frbR/MN3yK+Pz8NQ7OJlgoRZYht64rez
         S/aH2zK5v8U3ZYGNmSjXcrKg7qse7ai873toI1qnDmUAEwvyVa3xVvGD0fGmmPzv7b
         sy4Ej46ua4RbAwnna43aepUkxho8O4b0IzN6kTcY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 058/282] media: rcar_fdp1: simplify error check logic at fdp_open()
Date:   Mon, 15 May 2023 18:27:16 +0200
Message-Id: <20230515161723.986317840@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

[ Upstream commit fa9f443f7c962d072d150472e2bb77de39817a9a ]

Avoid some code duplication by moving the common error path
logic at fdp_open().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: c766c90faf93 ("media: rcar_fdp1: Fix refcount leak in probe and remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_fdp1.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index 97bed45360f08..d6eee66c8dd49 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -2121,9 +2121,7 @@ static int fdp1_open(struct file *file)
 
 	if (ctx->hdl.error) {
 		ret = ctx->hdl.error;
-		v4l2_ctrl_handler_free(&ctx->hdl);
-		kfree(ctx);
-		goto done;
+		goto error_ctx;
 	}
 
 	ctx->fh.ctrl_handler = &ctx->hdl;
@@ -2137,10 +2135,7 @@ static int fdp1_open(struct file *file)
 
 	if (IS_ERR(ctx->fh.m2m_ctx)) {
 		ret = PTR_ERR(ctx->fh.m2m_ctx);
-
-		v4l2_ctrl_handler_free(&ctx->hdl);
-		kfree(ctx);
-		goto done;
+		goto error_ctx;
 	}
 
 	/* Perform any power management required */
@@ -2151,6 +2146,12 @@ static int fdp1_open(struct file *file)
 	dprintk(fdp1, "Created instance: %p, m2m_ctx: %p\n",
 		ctx, ctx->fh.m2m_ctx);
 
+	mutex_unlock(&fdp1->dev_mutex);
+	return 0;
+
+error_ctx:
+	v4l2_ctrl_handler_free(&ctx->hdl);
+	kfree(ctx);
 done:
 	mutex_unlock(&fdp1->dev_mutex);
 	return ret;
-- 
2.39.2



