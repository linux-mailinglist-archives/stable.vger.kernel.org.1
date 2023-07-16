Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36817556BC
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjGPUxf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjGPUxe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F281E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97AA460DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B77C433C7;
        Sun, 16 Jul 2023 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540813;
        bh=Ucb5BUBDnq3iN6NGj3A3kYKifBDtWdqXd9hdkBkQgfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8b3q/qAYjLclUilIi0vHqX4wIzLffQWNWm+/+Ouhrv3qCh9upPch2UhhN+vpWWu5
         KpRhpfOeDIjkx9oCn0Md5/gRUZmjSQKEZ5aND9hJutiz5hS1Jom2bFO+sEODYjrOX2
         3EAUzgxEQhNonVWeLteQHi8gsPIvD6O4WkZaHTSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 459/591] pwm: ab8500: Fix error code in probe()
Date:   Sun, 16 Jul 2023 21:49:58 +0200
Message-ID: <20230716194935.779294320@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit cdcffafc4d845cc0c6392cba168c7a942734cce7 ]

This code accidentally return positive EINVAL instead of negative
-EINVAL.

Fixes: eb41f334589d ("pwm: ab8500: Fix register offset calculation to not depend on probe order")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pwm/pwm-ab8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index ad37bc46f2721..5fa91f4cda7ac 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -96,7 +96,7 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	int err;
 
 	if (pdev->id < 1 || pdev->id > 31)
-		return dev_err_probe(&pdev->dev, EINVAL, "Invalid device id %d\n", pdev->id);
+		return dev_err_probe(&pdev->dev, -EINVAL, "Invalid device id %d\n", pdev->id);
 
 	/*
 	 * Nothing to be done in probe, this is required to get the
-- 
2.39.2



