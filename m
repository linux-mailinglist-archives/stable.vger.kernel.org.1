Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349A775D421
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjGUTSV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjGUTSS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6430E7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4A0161D89
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6446C433C7;
        Fri, 21 Jul 2023 19:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967087;
        bh=WobzbKCo3HNo/CQqTM7PQ6upSAaCKLi2CbsS297v0Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zwmd9JoFK+rbTiROm6kqRCtudJtk/wFDCB9VfcTUpqL4rEwNIN9kQwj/3oV+RbceF
         BjGySd6bUI5t7GPVLrFCX/oYPJQBU6wvc6RB9CBYeHXR9cfK/iYkCln4eGV3Nn0NmH
         VHLwDGdb4+e27waIV/DMl5Fk39JULq81GZa0O6C0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 039/223] NTB: ntb_transport: fix possible memory leak while device_register() fails
Date:   Fri, 21 Jul 2023 18:04:52 +0200
Message-ID: <20230721160522.528991972@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 8623ccbfc55d962e19a3537652803676ad7acb90 ]

If device_register() returns error, the name allocated by
dev_set_name() need be freed. As comment of device_register()
says, it should use put_device() to give up the reference in
the error path. So fix this by calling put_device(), then the
name can be freed in kobject_cleanup(), and client_dev is freed
in ntb_transport_client_release().

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a9b97ebc71ac5..2abd2235bbcab 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -410,7 +410,7 @@ int ntb_transport_register_client_dev(char *device_name)
 
 		rc = device_register(dev);
 		if (rc) {
-			kfree(client_dev);
+			put_device(dev);
 			goto err;
 		}
 
-- 
2.39.2



