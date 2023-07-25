Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D17476170E
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbjGYLop (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbjGYLoa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C033F3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:44:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F01616A4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3372DC433C7;
        Tue, 25 Jul 2023 11:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285462;
        bh=B8No4OUOrcyOZObiQixiHbspa5vYCKqzOqocO+lQRro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Agsp9+ZXgia+E/2aKH9FQvxTx1iS08cnlZ3dQGXUpO1Pmt3027JAEnngKuxGHWH8M
         SDLivjkbzVDgmEkd4qsRTgKG1NYfvBDbCq3V51i4a4SVzNjZCYS6KL3QgvOq6Cxqjf
         o2N9bgOUvpf8deIFuQElX59Dmf5h2ru53veadUdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 213/313] NTB: ntb_transport: fix possible memory leak while device_register() fails
Date:   Tue, 25 Jul 2023 12:46:06 +0200
Message-ID: <20230725104530.253359060@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 00a5d5764993c..3cc0e8ebcdd5c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -412,7 +412,7 @@ int ntb_transport_register_client_dev(char *device_name)
 
 		rc = device_register(dev);
 		if (rc) {
-			kfree(client_dev);
+			put_device(dev);
 			goto err;
 		}
 
-- 
2.39.2



