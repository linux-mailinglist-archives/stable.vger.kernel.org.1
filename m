Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290906F16AB
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjD1L3V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbjD1L3U (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D153A59CA
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D7F4642F0
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BC5C433D2;
        Fri, 28 Apr 2023 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681358;
        bh=4cfFJ7sb4McT8g3qXWpfk7aWMkzr8XGX+lpqZ6JRo5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/ydTUTKBZwZ7oSqCqwXFAaCbXrrLzD35KAewqvKgA/ZyBrtufsIulktMFnc9wszP
         Clp6QBTLbywmcznSBMjdDUHyb+Uz/E2YozvPhGIWaGXU/iUz0qQ3yiQokDb6fEhymv
         jmNZWyuh59NYGSh7i5Kbxviql7PjQTLmjC9kIkQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Brian Norris <briannorris@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 6.1 13/16] driver core: Dont require dynamic_debug for initcall_debug probe timing
Date:   Fri, 28 Apr 2023 13:28:05 +0200
Message-Id: <20230428112040.500628629@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112040.063291126@linuxfoundation.org>
References: <20230428112040.063291126@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>

commit e2f06aa885081e1391916367f53bad984714b4db upstream.

Don't require the use of dynamic debug (or modification of the kernel to
add a #define DEBUG to the top of this file) to get the printk message
about driver probe timing. This printk is only emitted when
initcall_debug is enabled on the kernel commandline, and it isn't
immediately obvious that you have to do something else to debug boot
timing issues related to driver probe. Add a comment too so it doesn't
get converted back to pr_debug().

Fixes: eb7fbc9fb118 ("driver core: Add missing '\n' in log messages")
Cc: stable <stable@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20230412225842.3196599-1-swboyd@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/dd.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -718,7 +718,12 @@ static int really_probe_debug(struct dev
 	calltime = ktime_get();
 	ret = really_probe(dev, drv);
 	rettime = ktime_get();
-	pr_debug("probe of %s returned %d after %lld usecs\n",
+	/*
+	 * Don't change this to pr_debug() because that requires
+	 * CONFIG_DYNAMIC_DEBUG and we want a simple 'initcall_debug' on the
+	 * kernel commandline to print this all the time at the debug level.
+	 */
+	printk(KERN_DEBUG "probe of %s returned %d after %lld usecs\n",
 		 dev_name(dev), ret, ktime_us_delta(rettime, calltime));
 	return ret;
 }


