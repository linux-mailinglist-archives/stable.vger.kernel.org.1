Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A70703B6D
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242699AbjEOSC5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242683AbjEOSCd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4918A80
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:00:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9BB263026
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:00:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEE2C433D2;
        Mon, 15 May 2023 18:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173605;
        bh=rXPXTWtHLYvU2XpLzFMcOBp8VgMEHEEio+KPfLQlD10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k0Sj7CjgMphYgSqf8K3AsiBOYyizJMqT0uLh7Rh04rdlpBsFARgXosZD8Y1uXAuMt
         I0oKdeBkHIcQHFh7MeSfPGWbEgjjR1Ej2MCKSCxJS5iiDqanMLXffGm9glVmn0Vrp6
         Oxlsb8AQeSA+wYwGtmNTdRZ+Q9iwRw++CyOONvyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 149/282] firmware: stratix10-svc: Fix an NULL vs IS_ERR() bug in probe
Date:   Mon, 15 May 2023 18:28:47 +0200
Message-Id: <20230515161726.684380510@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e1d6ca042e62c2a69513235f8629eb6e62ca79c5 ]

The svc_create_memory_pool() function returns error pointers.  It never
returns NULL.  Fix the check.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/5f9a8cb4-5a4f-460b-9cdc-2fae6c5b7922@kili.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/stratix10-svc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 08c422380a00d..7122bc6ea796b 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -981,8 +981,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 		return ret;
 
 	genpool = svc_create_memory_pool(pdev, sh_memory);
-	if (!genpool)
-		return -ENOMEM;
+	if (IS_ERR(genpool))
+		return PTR_ERR(genpool);
 
 	/* allocate service controller and supporting channel */
 	controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
-- 
2.39.2



