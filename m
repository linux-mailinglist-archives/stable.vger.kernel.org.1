Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC62578322A
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjHUUCA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjHUUB7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:01:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAB4E6
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB7B647D9
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15980C433C8;
        Mon, 21 Aug 2023 20:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648116;
        bh=1WjMXYBbxot3DQ5l3G6gon/5Qa5TtW1QuZRDolFZMFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLfGr3oiY6Gu05PhQS2PHTQguT2HA0vt17r49RJsjyJXcArftAPrndsNaWXX+cbfo
         sAUKa3zBo4WMYNWg4IQY+M3HTORHfyy8b0EF+SpoDLswki4cWiCe/3XxTkecNFZlKF
         iylTDLRTONqxrC2w9FXtq9mEHcHK008I/L17priU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Armin Wolf <W_Armin@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 059/234] pcmcia: rsrc_nonstatic: Fix memory leak in nonstatic_release_resource_db()
Date:   Mon, 21 Aug 2023 21:40:22 +0200
Message-ID: <20230821194131.374892264@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit c85fd9422fe0f5d667305efb27f56d09eab120b0 ]

When nonstatic_release_resource_db() frees all resources associated
with an PCMCIA socket, it forgets to free socket_data too, causing
a memory leak observable with kmemleak:

unreferenced object 0xc28d1000 (size 64):
  comm "systemd-udevd", pid 297, jiffies 4294898478 (age 194.484s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 f0 85 0e c3 00 00 00 00  ................
    00 00 00 00 0c 10 8d c2 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffda4245>] __kmem_cache_alloc_node+0x2d7/0x4a0
    [<7e51f0c8>] kmalloc_trace+0x31/0xa4
    [<d52b4ca0>] nonstatic_init+0x24/0x1a4 [pcmcia_rsrc]
    [<a2f13e08>] pcmcia_register_socket+0x200/0x35c [pcmcia_core]
    [<a728be1b>] yenta_probe+0x4d8/0xa70 [yenta_socket]
    [<c48fac39>] pci_device_probe+0x99/0x194
    [<84b7c690>] really_probe+0x181/0x45c
    [<8060fe6e>] __driver_probe_device+0x75/0x1f4
    [<b9b76f43>] driver_probe_device+0x28/0xac
    [<648b766f>] __driver_attach+0xeb/0x1e4
    [<6e9659eb>] bus_for_each_dev+0x61/0xb4
    [<25a669f3>] driver_attach+0x1e/0x28
    [<d8671d6b>] bus_add_driver+0x102/0x20c
    [<df0d323c>] driver_register+0x5b/0x120
    [<942cd8a4>] __pci_register_driver+0x44/0x4c
    [<e536027e>] __UNIQUE_ID___addressable_cleanup_module188+0x1c/0xfffff000 [iTCO_vendor_support]

Fix this by freeing socket_data too.

Tested on a Acer Travelmate 4002WLMi by manually binding/unbinding
the yenta_cardbus driver (yenta_socket).

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Message-ID: <20230512184529.5094-1-W_Armin@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pcmcia/rsrc_nonstatic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 471e0c5815f39..bf9d070a44966 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1053,6 +1053,8 @@ static void nonstatic_release_resource_db(struct pcmcia_socket *s)
 		q = p->next;
 		kfree(p);
 	}
+
+	kfree(data);
 }
 
 
-- 
2.40.1



