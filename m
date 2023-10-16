Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D57CAC31
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbjJPOu4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjJPOuz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:50:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADD6EB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:50:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5A9C433C7;
        Mon, 16 Oct 2023 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467853;
        bh=4ZbaiS0xxa8vL9yw/WUOq6857V6vdSeC0KCzNkNFf9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUVWw1LA3mXrXyhQ7Wtbr9CJTt+hUssgxk5eCP5wPHiwbAMaPyiMkZnBjQMk4G774
         eYg5A8u+Xs5pXywX5V3Ucjx7xVE8dkABtNjxdXkHj36D8VbVXM6IPENyDd3z6s/5PT
         l0+IksBPmOySoCWMgkpV0g4eWWRpbZ3xod0nSBHs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Machek <pavel@denx.de>,
        Xiaolei Wang <xiaolei.wang@windriver.com>,
        Roger Quadros <rogerq@kernel.org>,
        Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.5 105/191] usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled
Date:   Mon, 16 Oct 2023 10:41:30 +0200
Message-ID: <20231016084017.842602099@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaolei Wang <xiaolei.wang@windriver.com>

commit 9f35d612da5592f1bf1cae44ec1e023df37bea12 upstream.

The return type of cdns_set_active () is inconsistent
depending on whether CONFIG_PM_SLEEP is enabled, so the
return value is modified to void type.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/all/ZP7lIKUzD68XA91j@duo.ucw.cz/
Fixes: 2319b9c87fe2 ("usb: cdns3: Put the cdns set active part outside the spin lock")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20230926075333.1791011-1-xiaolei.wang@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/core.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -131,8 +131,7 @@ void cdns_set_active(struct cdns *cdns,
 #else /* CONFIG_PM_SLEEP */
 static inline int cdns_resume(struct cdns *cdns)
 { return 0; }
-static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
-{ return 0; }
+static inline void cdns_set_active(struct cdns *cdns, u8 set_active) { }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
 #endif /* CONFIG_PM_SLEEP */


