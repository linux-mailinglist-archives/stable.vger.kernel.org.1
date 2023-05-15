Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254FE703958
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbjEORl1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244407AbjEORlH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:41:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FD15525
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:38:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6BD60ABF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ED6C433D2;
        Mon, 15 May 2023 17:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172309;
        bh=KwVfrzlbyY5ajKYbW5tVXtxkgv2sPILb28d72PKKTVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sduCYmHwNhtnJ6gFqvK14Krxj0qRrFzi7HUdOjxsFmHrnYzMtXhOTtax9GJ5eqoOK
         wrssSOzWrnfdubYT0jYv7lzFJ4n8xHUh8J62/irRNgNCOzJGRShrGOhagtIy4sp3W8
         8ookxbqunJgIc2BTYDAvv/gtqrKWem6jx8K9H6HU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tang Bin <tangbin@cmss.chinamobile.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 112/381] media: rcar_fdp1: Fix the correct variable assignments
Date:   Mon, 15 May 2023 18:26:03 +0200
Message-Id: <20230515161741.876774135@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tang Bin <tangbin@cmss.chinamobile.com>

[ Upstream commit af88c2adbb72a09ab1bb5c37ba388c98fecca69b ]

In the function fdp1_probe(), when get irq failed, the
function platform_get_irq() log an error message, so
remove redundant message here. And the variable type
of "ret" is int, the "fdp1->irq" is unsigned int, when
irq failed, this place maybe wrong, thus fix it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: c766c90faf93 ("media: rcar_fdp1: Fix refcount leak in probe and remove function")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar_fdp1.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/rcar_fdp1.c b/drivers/media/platform/rcar_fdp1.c
index 782e805b85da2..1dd8bebb66f53 100644
--- a/drivers/media/platform/rcar_fdp1.c
+++ b/drivers/media/platform/rcar_fdp1.c
@@ -2291,11 +2291,10 @@ static int fdp1_probe(struct platform_device *pdev)
 		return PTR_ERR(fdp1->regs);
 
 	/* Interrupt service routine registration */
-	fdp1->irq = ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot find IRQ\n");
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
 		return ret;
-	}
+	fdp1->irq = ret;
 
 	ret = devm_request_irq(&pdev->dev, fdp1->irq, fdp1_irq_handler, 0,
 			       dev_name(&pdev->dev), fdp1);
-- 
2.39.2



