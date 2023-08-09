Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7B775A30
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjHILGH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjHILGH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945C21702
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:06:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3392C63146
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45354C433C7;
        Wed,  9 Aug 2023 11:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579165;
        bh=C7wbw4ld1mLUGb/sr/ZejqoY62a8lzqk/jSj2qfiQpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LjrIwGr20iw1LjIQecWXj+nv8k2Jor2kX0EFBFzlfk7yVRVdqC3rN1+2t4HsnfMET
         wfdBISek/+LK8xu6TiM+DMcWvxnuu5nks/A4BFKt+dFZAztLGi0Pc9f3qKY9vGntha
         2GUX6cjnF8sL7S6l0Lz6BtTYNIrWrfo81hyZOn4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 098/204] NTB: ntb_transport: fix possible memory leak while device_register() fails
Date:   Wed,  9 Aug 2023 12:40:36 +0200
Message-ID: <20230809103645.913053731@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.552405807@linuxfoundation.org>
References: <20230809103642.552405807@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
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
index 18339b7e88a46..a58ced5d60433 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -395,7 +395,7 @@ int ntb_transport_register_client_dev(char *device_name)
 
 		rc = device_register(dev);
 		if (rc) {
-			kfree(client_dev);
+			put_device(dev);
 			goto err;
 		}
 
-- 
2.39.2



