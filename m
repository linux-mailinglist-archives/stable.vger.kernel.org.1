Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769C176AFB4
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjHAJty (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjHAJt2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AFE4206
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68FBA61502
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A07C433C8;
        Tue,  1 Aug 2023 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883287;
        bh=M+b1jCgVMAsbX2LvexOKncnj3LdgGBaYCFl5fvTNCTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yvKcHZ2B0m+uEpB9rqimb6g0i0i2AjqOvETIXhtLBV+wX/Aa6qLPFCmj2wH3pL3yZ
         +iCr7g5e0FmVEOHhh14jWuk3K2v+IlnrxWf3JXo/swX76Q6nN9bb8mln6XdTps1N+o
         ky14YoUGz+wnAAIy6qTyDFdAJrZ7vnVaZIgCbxY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.4 182/239] hwmon: (pmbus_core) Fix pmbus_is_enabled()
Date:   Tue,  1 Aug 2023 11:20:46 +0200
Message-ID: <20230801091932.234193253@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

commit 55aab08f1856894d7d47d0ee23abbb4bc4854345 upstream.

Refactor pmbus_is_enabled() to return the status without any additional
processing as it is already done in _pmbus_is_enabled().

Fixes: df5f6b6af01c ("hwmon: (pmbus/core) Generalise pmbus get status")
Cc: stable@vger.kernel.org # v6.4
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
Link: https://lore.kernel.org/r/20230725125428.3966803-1-Naresh.Solanki@9elements.com
[groeck: Rephrased commit message]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index fa06325f5a7c..42fb7286805b 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2768,7 +2768,7 @@ static int __maybe_unused pmbus_is_enabled(struct device *dev, u8 page)
 	ret = _pmbus_is_enabled(dev, page);
 	mutex_unlock(&data->update_lock);
 
-	return !!(ret & PB_OPERATION_CONTROL_ON);
+	return ret;
 }
 
 #define to_dev_attr(_dev_attr) \
-- 
2.41.0



