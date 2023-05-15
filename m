Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF4703904
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbjEORiE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242397AbjEORhj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:37:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441B1B0AC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA8D62D81
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9356C433D2;
        Mon, 15 May 2023 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172083;
        bh=5lgoWjr6u1HjwgKvn1QmygnDtV1Wjk204QbyvoihS+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+C3jH1DENN204+hElvVUHB6CSVkskm3yNo8Xeb/E9bVBq+bLIq9kYCtNRnRqM03f
         B0fOByWkl7SAQa+745jTTFcLpQ+EhMvqW10H3lmwM6h5HzdYbU0v/GdnigAda24Je8
         RedrmM8RWKj3xXPNcxJKVGiXdlyPgSXN8f9ngrNo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Brian Norris <briannorris@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH 5.10 009/381] driver core: Dont require dynamic_debug for initcall_debug probe timing
Date:   Mon, 15 May 2023 18:24:20 +0200
Message-Id: <20230515161737.186518673@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
@@ -677,7 +677,12 @@ static int really_probe_debug(struct dev
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


