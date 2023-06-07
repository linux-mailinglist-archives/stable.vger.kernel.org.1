Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E07726CD8
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjFGUg7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjFGUgz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:36:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854972683
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:36:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2378464599
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38276C433EF;
        Wed,  7 Jun 2023 20:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170185;
        bh=gaIF6HVHoZMppC3ESfbj9bGDzS5MIjuoCPWqnkgNDtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7FOJb9YiOjPcEKqxMAShO8fE2updqIW79+FqSIJaglN64huxZNiSI9Nkv5bT/fAs
         lIHb0pzOZagZX1Hs0zvsZOkhU/oPy1KG9U1JU+EqsJzcLFih7+t98HKnkK3j4BBQIS
         HlqE0WED2d6Pyl/6HH9f11nd11N/gI54LanEMwKc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 77/88] hwmon: (scmi) Remove redundant pointer check
Date:   Wed,  7 Jun 2023 22:16:34 +0200
Message-ID: <20230607200901.638070403@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
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

From: Nathan Chancellor <natechancellor@gmail.com>

commit a31796c30e423f58d266df30a9bbf321fc071b30 upstream.

Clang warns when the address of a pointer is used in a boolean context
as it will always return true.

drivers/hwmon/scmi-hwmon.c:59:24: warning: address of array
'sensor->name' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (sensor && sensor->name)
                   ~~ ~~~~~~~~^~~~
1 warning generated.

Remove the check as it isn't doing anything currently; if validation
of the contents of the data structure was intended by the original
author (since this line has been present from the first version of
this driver), it can be added in a follow-up patch.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/scmi-hwmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -56,7 +56,7 @@ scmi_hwmon_is_visible(const void *drvdat
 	const struct scmi_sensors *scmi_sensors = drvdata;
 
 	sensor = *(scmi_sensors->info[type] + channel);
-	if (sensor && sensor->name)
+	if (sensor)
 		return S_IRUGO;
 
 	return 0;


