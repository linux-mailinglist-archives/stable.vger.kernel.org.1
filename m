Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FC27ECD23
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbjKOTef (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjKOTee (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A9712C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABB7C433C9;
        Wed, 15 Nov 2023 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076871;
        bh=MXQAuCpBRpD7QpaXiLUnxCtVjcZDJPfCseEOQIeMX1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCySZsIgVoBwr/7kg6EEwX5FZOeXxJksGPY+WkLujlnvrXmL8d0YFNRlTz5tyzAOF
         KFo2c+DXY0LeOBnMUEMfhrDHFLGCBhDO0y7dSrwYWXWQx5bsCqi0dShW/DKZ5waTZA
         xTjCpz08y1gm1ylEkTBHs0MuWQS8PaVJjmVyq2KQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 449/550] i3c: Fix potential refcount leak in i3c_master_register_new_i3c_devs
Date:   Wed, 15 Nov 2023 14:17:13 -0500
Message-ID: <20231115191631.936261545@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit cab63f64887616e3c4e31cfd8103320be6ebc8d3 ]

put_device() needs to be called on failure of device_register()
to give up the reference initialized in it to avoid refcount leak.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/r/20230921082410.25548-1-dinghao.liu@zju.edu.cn
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 08aeb69a78003..19071ff9eb753 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1521,9 +1521,11 @@ i3c_master_register_new_i3c_devs(struct i3c_master_controller *master)
 			desc->dev->dev.of_node = desc->boardinfo->of_node;
 
 		ret = device_register(&desc->dev->dev);
-		if (ret)
+		if (ret) {
 			dev_err(&master->dev,
 				"Failed to add I3C device (err = %d)\n", ret);
+			put_device(&desc->dev->dev);
+		}
 	}
 }
 
-- 
2.42.0



