Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A415735296
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjFSKgj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjFSKgN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391D11700
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:36:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89AFD60B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E996C433C8;
        Mon, 19 Jun 2023 10:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170961;
        bh=YF1xQhfrnl8CC8P3iBmlze25nXyF9xs9d+IBRnfdqhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jb9UExi8zutRdF+Lyu9MNio9Zgv4/UP0VOtBYNFNFZ33HxeN4PVvnJnLIBdtVPVTW
         UhGfr4FxcLsQ4zTwUy27N7juf4qUqwV90gj4zN9PotF32qO7sXQfInVVn9RHy764ap
         jNKl4q8U0fkiI/5qAL9o/DLXI1p0igHRnOUHqD7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Niklas Schnelle <schnelle@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.3 072/187] s390/ism: Fix trying to free already-freed IRQ by repeated ism_dev_exit()
Date:   Mon, 19 Jun 2023 12:28:10 +0200
Message-ID: <20230619102201.128807609@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Julian Ruess <julianr@linux.ibm.com>

commit 78d0f94902afce8ec2c7a60f600cc0e3729d7412 upstream.

This patch prevents the system from crashing when unloading the ISM module.

How to reproduce: Attach an ISM device and execute 'rmmod ism'.

Error-Log:
- Trying to free already-free IRQ 0
- WARNING: CPU: 1 PID: 966 at kernel/irq/manage.c:1890 free_irq+0x140/0x540

After calling ism_dev_exit() for each ISM device in the exit routine,
pci_unregister_driver() will execute ism_remove() for each ISM device.
Because ism_remove() also calls ism_dev_exit(),
free_irq(pci_irq_vector(pdev, 0), ism) is called twice for each ISM
device. This results in a crash with the error
'Trying to free already-free IRQ'.

In the exit routine, it is enough to call pci_unregister_driver()
because it ensures that ism_dev_exit() is called once per
ISM device.

Cc: <stable@vger.kernel.org> # 6.3+
Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/net/ism_drv.c |    8 --------
 1 file changed, 8 deletions(-)

--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -774,14 +774,6 @@ static int __init ism_init(void)
 
 static void __exit ism_exit(void)
 {
-	struct ism_dev *ism;
-
-	mutex_lock(&ism_dev_list.mutex);
-	list_for_each_entry(ism, &ism_dev_list.list, list) {
-		ism_dev_exit(ism);
-	}
-	mutex_unlock(&ism_dev_list.mutex);
-
 	pci_unregister_driver(&ism_driver);
 	debug_unregister(ism_debug_info);
 }


