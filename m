Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906F573E9AA
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjFZSiv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbjFZSiq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:38:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C311702
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E50BA60E8D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA8C433CA;
        Mon, 26 Jun 2023 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804713;
        bh=Lr/RuTIW21kZyq5fm83S7pA+NR7Y9Rrc+5feaS+UKzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdPohJhDUbBDA/Nmp/RRut30ruz0tUpCPrWH4fF0km5ueE1jJ+Z6wD9djkPYccJKI
         Gc1K8o/8FCDOsV2InnJoJcMk07DENrH5P5Hx6/X24x382Abp0wLU3ENgdCN5H+YSni
         zdVLEawbcSU8MnneUJBSVYfhh+ws463uM+/Aqao4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: [PATCH 5.15 17/96] Drivers: hv: vmbus: Call hv_synic_free() if hv_synic_alloc() fails
Date:   Mon, 26 Jun 2023 20:11:32 +0200
Message-ID: <20230626180747.648332387@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
References: <20230626180746.943455203@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

commit ec97e112985c2581ee61854a4b74f080f6cdfc2c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/vmbus_drv.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1538,7 +1538,7 @@ static int vmbus_bus_init(void)
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
 				hv_synic_init, hv_synic_cleanup);
 	if (ret < 0)
-		goto err_cpuhp;
+		goto err_alloc;
 	hyperv_cpuhp_online = ret;
 
 	ret = vmbus_connect();
@@ -1589,9 +1589,8 @@ static int vmbus_bus_init(void)
 
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
-err_cpuhp:
-	hv_synic_free();
 err_alloc:
+	hv_synic_free();
 	if (vmbus_irq == -1) {
 		hv_remove_vmbus_handler();
 	} else {


