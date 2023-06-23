Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7793573B37D
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 11:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFWJ0O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 23 Jun 2023 05:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFWJ0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Jun 2023 05:26:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298E81BFC
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 02:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2859619E4
        for <stable@vger.kernel.org>; Fri, 23 Jun 2023 09:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35AEC433C8;
        Fri, 23 Jun 2023 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687512372;
        bh=QdeOnINdpKq0NVSk3REtPr87nPdpv+I2+veAxSu5dZ4=;
        h=Subject:To:Cc:From:Date:From;
        b=YYxV0jbdMMH2OH2jWuLTH366IyRy6L3YW7ARGoiLiu8GlZ4ygx64tPwHG5UrbnYFL
         bVN8kcUye22s7/LvK/vlR/QVvrC1k02GJc9tlAJ7A2sFswSwLbBt4a9WLnyngK3cYX
         JlC3BmVL6w0qA7GKcvNTJJACLiGmlTV3PCxoS/Do=
Subject: FAILED: patch "[PATCH] Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc()" failed to apply to 5.10-stable tree
To:     decui@microsoft.com, mikelley@microsoft.com, wei.liu@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 23 Jun 2023 11:26:09 +0200
Message-ID: <2023062309-wilder-grading-8bc3@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ec97e112985c2581ee61854a4b74f080f6cdfc2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023062309-wilder-grading-8bc3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ec97e112985c2581ee61854a4b74f080f6cdfc2c Mon Sep 17 00:00:00 2001
From: Dexuan Cui <decui@microsoft.com>
Date: Thu, 4 May 2023 15:41:55 -0700
Subject: [PATCH] Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc()
 fails

Commit 572086325ce9 ("Drivers: hv: vmbus: Cleanup synic memory free path")
says "Any memory allocations that succeeded will be freed when the caller
cleans up by calling hv_synic_free()", but if the get_zeroed_page() in
hv_synic_alloc() fails, currently hv_synic_free() is not really called
in vmbus_bus_init(), consequently there will be a memory leak, e.g.
hv_context.hv_numa_map is not freed in the error path. Fix this by
updating the goto labels.

Cc: stable@kernel.org
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Fixes: 4df4cb9e99f8 ("x86/hyperv: Initialize clockevents earlier in CPU onlining")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20230504224155.10484-1-decui@microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1c65a6dfb9fa..67f95a29aeca 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1372,7 +1372,7 @@ static int vmbus_bus_init(void)
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
 				hv_synic_init, hv_synic_cleanup);
 	if (ret < 0)
-		goto err_cpuhp;
+		goto err_alloc;
 	hyperv_cpuhp_online = ret;
 
 	ret = vmbus_connect();
@@ -1392,9 +1392,8 @@ static int vmbus_bus_init(void)
 
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
-err_cpuhp:
-	hv_synic_free();
 err_alloc:
+	hv_synic_free();
 	if (vmbus_irq == -1) {
 		hv_remove_vmbus_handler();
 	} else {

