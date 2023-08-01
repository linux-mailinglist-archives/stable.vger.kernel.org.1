Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA2A76AFAE
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjHAJtv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjHAJta (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD044498
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5C00614EC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D660BC433C9;
        Tue,  1 Aug 2023 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883296;
        bh=6sQomdi6eHwR4kmmWt3b2KK9Mk7q06ATA9b9I1ITEKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrF+5McvPp7Uq2rACXo06KZ14XQuK6vBKEdLZ2DOhqyHsWfJpALEBSn3lbVtePJV5
         Y6Vp/aQxQDtSYjdX8doNZokxwxS6IjLo4FN6Ae97uzicULyiJGbPrSTVqSvOQIJABQ
         05I9cq4mYEw/OJP7E6HK34fAWMHm7D59kSvcfJ2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.4 184/239] hwmon: (pmbus_core) Fix Deadlock in pmbus_regulator_get_status
Date:   Tue,  1 Aug 2023 11:20:48 +0200
Message-ID: <20230801091932.309430238@linuxfoundation.org>
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

From: Guenter Roeck <linux@roeck-us.net>

commit b84000f2274520f73ac9dc59fd9403260b61c4e7 upstream.

pmbus_regulator_get_status() acquires update_lock.
pmbus_regulator_get_error_flags() acquires it again, resulting in an
immediate deadlock.

Call _pmbus_get_flags() from pmbus_regulator_get_status() directly
to avoid the problem.

Reported-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Closes: https://lore.kernel.org/linux-hwmon/b7a3ad85-aab4-4718-a001-1d8b1c0eef36@roeck-us.net/T/#u
Cc: Naresh Solanki <Naresh.Solanki@9elements.com>
Cc: stable@vger.kernel.org # v6.2+
Fixes: c05f477c4ba3 ("hwmon: (pmbus/core) Implement regulator get_status")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/pmbus_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2946,6 +2946,7 @@ static int pmbus_regulator_get_status(st
 	struct pmbus_data *data = i2c_get_clientdata(client);
 	u8 page = rdev_get_id(rdev);
 	int status, ret;
+	int event;
 
 	mutex_lock(&data->update_lock);
 	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
@@ -2965,7 +2966,7 @@ static int pmbus_regulator_get_status(st
 		goto unlock;
 	}
 
-	ret = pmbus_regulator_get_error_flags(rdev, &status);
+	ret = _pmbus_get_flags(data, rdev_get_id(rdev), &status, &event, false);
 	if (ret)
 		goto unlock;
 


