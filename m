Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7F175CD44
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjGUQJi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjGUQJg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EDC30CB
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:09:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEE2561D25
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC440C433C9;
        Fri, 21 Jul 2023 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955770;
        bh=mfkvkEB2v9VF4QmD6LOQdHRTcU23ew7qYAJdIOR6xgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s1EhuFdgqf+StRxxUe/EyDOImg4jxkEwAoIJ6TZiePzMDxPMdHADCAiorjtgQ4kkY
         +T6xCAWhvy7peSMeiKCAZMcfhrdyRuH9w3PK+2w6TDKAa8pGLcai0/+z42TwH6wAhq
         CjJU1YLPAPWBCEX24JgVC0CqNqpml3AMZkKdko0E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Pavlu <petr.pavlu@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 016/292] xen/virtio: Fix NULL deref when a bridge of PCI root bus has no parent
Date:   Fri, 21 Jul 2023 18:02:05 +0200
Message-ID: <20230721160529.508294376@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Petr Pavlu <petr.pavlu@suse.com>

[ Upstream commit 21a235bce12361e64adfc2ef97e4ae2e51ad63d4 ]

When attempting to run Xen on a QEMU/KVM virtual machine with virtio
devices (all x86_64), function xen_dt_get_node() crashes on accessing
bus->bridge->parent->of_node because a bridge of the PCI root bus has no
parent set:

[    1.694192][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000288
[    1.695688][    T1] #PF: supervisor read access in kernel mode
[    1.696297][    T1] #PF: error_code(0x0000) - not-present page
[    1.696297][    T1] PGD 0 P4D 0
[    1.696297][    T1] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    1.696297][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.7-1-default #1 openSUSE Tumbleweed a577eae57964bb7e83477b5a5645a1781df990f0
[    1.696297][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
[    1.696297][    T1] RIP: e030:xen_virtio_restricted_mem_acc+0xd9/0x1c0
[    1.696297][    T1] Code: 45 0c 83 e8 c9 a3 ea ff 31 c0 eb d7 48 8b 87 40 ff ff ff 48 89 c2 48 8b 40 10 48 85 c0 75 f4 48 8b 82 10 01 00 00 48 8b 40 40 <48> 83 b8 88 02 00 00 00 0f 84 45 ff ff ff 66 90 31 c0 eb a5 48 89
[    1.696297][    T1] RSP: e02b:ffffc90040013cc8 EFLAGS: 00010246
[    1.696297][    T1] RAX: 0000000000000000 RBX: ffff888006c75000 RCX: 0000000000000029
[    1.696297][    T1] RDX: ffff888005ed1000 RSI: ffffc900400f100c RDI: ffff888005ee30d0
[    1.696297][    T1] RBP: ffff888006c75010 R08: 0000000000000001 R09: 0000000330000006
[    1.696297][    T1] R10: ffff888005850028 R11: 0000000000000002 R12: ffffffff830439a0
[    1.696297][    T1] R13: 0000000000000000 R14: ffff888005657900 R15: ffff888006e3e1e8
[    1.696297][    T1] FS:  0000000000000000(0000) GS:ffff88804a000000(0000) knlGS:0000000000000000
[    1.696297][    T1] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.696297][    T1] CR2: 0000000000000288 CR3: 0000000002e36000 CR4: 0000000000050660
[    1.696297][    T1] Call Trace:
[    1.696297][    T1]  <TASK>
[    1.696297][    T1]  virtio_features_ok+0x1b/0xd0
[    1.696297][    T1]  virtio_dev_probe+0x19c/0x270
[    1.696297][    T1]  really_probe+0x19b/0x3e0
[    1.696297][    T1]  __driver_probe_device+0x78/0x160
[    1.696297][    T1]  driver_probe_device+0x1f/0x90
[    1.696297][    T1]  __driver_attach+0xd2/0x1c0
[    1.696297][    T1]  bus_for_each_dev+0x74/0xc0
[    1.696297][    T1]  bus_add_driver+0x116/0x220
[    1.696297][    T1]  driver_register+0x59/0x100
[    1.696297][    T1]  virtio_console_init+0x7f/0x110
[    1.696297][    T1]  do_one_initcall+0x47/0x220
[    1.696297][    T1]  kernel_init_freeable+0x328/0x480
[    1.696297][    T1]  kernel_init+0x1a/0x1c0
[    1.696297][    T1]  ret_from_fork+0x29/0x50
[    1.696297][    T1]  </TASK>
[    1.696297][    T1] Modules linked in:
[    1.696297][    T1] CR2: 0000000000000288
[    1.696297][    T1] ---[ end trace 0000000000000000 ]---

The PCI root bus is in this case created from ACPI description via
acpi_pci_root_add() -> pci_acpi_scan_root() -> acpi_pci_root_create() ->
pci_create_root_bus() where the last function is called with
parent=NULL. It indicates that no parent is present and then
bus->bridge->parent is NULL too.

Fix the problem by checking bus->bridge->parent in xen_dt_get_node() for
NULL first.

Fixes: ef8ae384b4c9 ("xen/virtio: Handle PCI devices which Host controller is described in DT")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20230621131214.9398-2-petr.pavlu@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/grant-dma-ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
index 9784a77fa3c99..76f6f26265a3b 100644
--- a/drivers/xen/grant-dma-ops.c
+++ b/drivers/xen/grant-dma-ops.c
@@ -303,6 +303,8 @@ static struct device_node *xen_dt_get_node(struct device *dev)
 		while (!pci_is_root_bus(bus))
 			bus = bus->parent;
 
+		if (!bus->bridge->parent)
+			return NULL;
 		return of_node_get(bus->bridge->parent->of_node);
 	}
 
-- 
2.39.2



