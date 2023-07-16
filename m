Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD15755652
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjGPUtg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjGPUtb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24910D0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84CC760EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB4AC433C7;
        Sun, 16 Jul 2023 20:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540565;
        bh=D8ie1eqjMTmf9EzHLT3urpkwADiWirvrQkEpywxft1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOYLLYNWw/Bp+DqTzcHmG9WOUUNC0DmdkG1HYxJMnLRpUUjyxlJS+vBcc2KQx29oP
         0ESq7ngy6NhZELvr6C2XiYCy3+lFprsqRGU8pd6rE/tJwM99se0ad//xsJcu0xNCCX
         +tTKip+Gh9zNpV8cT6GaH5E5Np6dLM5in9py/xxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 401/591] media: hi846: fix usage of pm_runtime_get_if_in_use()
Date:   Sun, 16 Jul 2023 21:49:00 +0200
Message-ID: <20230716194934.294632536@linuxfoundation.org>
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

From: Martin Kepplinger <martin.kepplinger@puri.sm>

[ Upstream commit 04fc06f6dc1592ed5d675311ac50d8fba5db62ab ]

pm_runtime_get_if_in_use() does not only return nonzero values when
the device is in use, it can return a negative errno too.

And especially during resuming from system suspend, when runtime pm
is not yet up again, -EAGAIN is being returned, so the subsequent
pm_runtime_put() call results in a refcount underflow.

Fix system-resume by handling -EAGAIN of pm_runtime_get_if_in_use().

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/hi846.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index 306dc35e925fd..f8709cdf28b39 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1353,7 +1353,8 @@ static int hi846_set_ctrl(struct v4l2_ctrl *ctrl)
 					 exposure_max);
 	}
 
-	if (!pm_runtime_get_if_in_use(&client->dev))
+	ret = pm_runtime_get_if_in_use(&client->dev);
+	if (!ret || ret == -EAGAIN)
 		return 0;
 
 	switch (ctrl->id) {
-- 
2.39.2



