Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1607BE074
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377346AbjJINkY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377333AbjJINkT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:40:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9081DB9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:40:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E5C433CA;
        Mon,  9 Oct 2023 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858813;
        bh=FNPIDqlqvwXf4WKGdrQdnzaSD+KBeZfP12p8Il5I9hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+FSX/3a6vFEij+kjiNspSH6hjPq83DCIjKUxmt5ZSx1DVFEkmOeGK2ke+PTOzc1u
         pQF1h4x1YV3SIqIFM/3CY6VeRPtEJ8CcW5PmUZS12dC8I3OtS6dbYRc3MNFsOA83/Z
         wNjCOQ2xOvp5yHVrGvs6ww8jBoz0tud7gjvuLmCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rob Clark <robdclark@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 108/226] dma-debug: dont call __dma_entry_alloc_check_leak() under free_entries_lock
Date:   Mon,  9 Oct 2023 15:01:09 +0200
Message-ID: <20231009130129.605033994@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit fb5a4315591dae307a65fc246ca80b5159d296e1 ]

__dma_entry_alloc_check_leak() calls into printk -> serial console
output (qcom geni) and grabs port->lock under free_entries_lock
spin lock, which is a reverse locking dependency chain as qcom_geni
IRQ handler can call into dma-debug code and grab free_entries_lock
under port->lock.

Move __dma_entry_alloc_check_leak() call out of free_entries_lock
scope so that we don't acquire serial console's port->lock under it.

Trimmed-down lockdep splat:

 The existing dependency chain (in reverse order) is:

               -> #2 (free_entries_lock){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x80
        dma_entry_alloc+0x38/0x110
        debug_dma_map_page+0x60/0xf8
        dma_map_page_attrs+0x1e0/0x230
        dma_map_single_attrs.constprop.0+0x6c/0xc8
        geni_se_rx_dma_prep+0x40/0xcc
        qcom_geni_serial_isr+0x310/0x510
        __handle_irq_event_percpu+0x110/0x244
        handle_irq_event_percpu+0x20/0x54
        handle_irq_event+0x50/0x88
        handle_fasteoi_irq+0xa4/0xcc
        handle_irq_desc+0x28/0x40
        generic_handle_domain_irq+0x24/0x30
        gic_handle_irq+0xc4/0x148
        do_interrupt_handler+0xa4/0xb0
        el1_interrupt+0x34/0x64
        el1h_64_irq_handler+0x18/0x24
        el1h_64_irq+0x64/0x68
        arch_local_irq_enable+0x4/0x8
        ____do_softirq+0x18/0x24
        ...

               -> #1 (&port_lock_key){-.-.}-{2:2}:
        _raw_spin_lock_irqsave+0x60/0x80
        qcom_geni_serial_console_write+0x184/0x1dc
        console_flush_all+0x344/0x454
        console_unlock+0x94/0xf0
        vprintk_emit+0x238/0x24c
        vprintk_default+0x3c/0x48
        vprintk+0xb4/0xbc
        _printk+0x68/0x90
        register_console+0x230/0x38c
        uart_add_one_port+0x338/0x494
        qcom_geni_serial_probe+0x390/0x424
        platform_probe+0x70/0xc0
        really_probe+0x148/0x280
        __driver_probe_device+0xfc/0x114
        driver_probe_device+0x44/0x100
        __device_attach_driver+0x64/0xdc
        bus_for_each_drv+0xb0/0xd8
        __device_attach+0xe4/0x140
        device_initial_probe+0x1c/0x28
        bus_probe_device+0x44/0xb0
        device_add+0x538/0x668
        of_device_add+0x44/0x50
        of_platform_device_create_pdata+0x94/0xc8
        of_platform_bus_create+0x270/0x304
        of_platform_populate+0xac/0xc4
        devm_of_platform_populate+0x60/0xac
        geni_se_probe+0x154/0x160
        platform_probe+0x70/0xc0
        ...

               -> #0 (console_owner){-...}-{0:0}:
        __lock_acquire+0xdf8/0x109c
        lock_acquire+0x234/0x284
        console_flush_all+0x330/0x454
        console_unlock+0x94/0xf0
        vprintk_emit+0x238/0x24c
        vprintk_default+0x3c/0x48
        vprintk+0xb4/0xbc
        _printk+0x68/0x90
        dma_entry_alloc+0xb4/0x110
        debug_dma_map_sg+0xdc/0x2f8
        __dma_map_sg_attrs+0xac/0xe4
        dma_map_sgtable+0x30/0x4c
        get_pages+0x1d4/0x1e4 [msm]
        msm_gem_pin_pages_locked+0x38/0xac [msm]
        msm_gem_pin_vma_locked+0x58/0x88 [msm]
        msm_ioctl_gem_submit+0xde4/0x13ac [msm]
        drm_ioctl_kernel+0xe0/0x15c
        drm_ioctl+0x2e8/0x3f4
        vfs_ioctl+0x30/0x50
        ...

 Chain exists of:
   console_owner --> &port_lock_key --> free_entries_lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(free_entries_lock);
                                lock(&port_lock_key);
                                lock(free_entries_lock);
   lock(console_owner);

                *** DEADLOCK ***

 Call trace:
  dump_backtrace+0xb4/0xf0
  show_stack+0x20/0x30
  dump_stack_lvl+0x60/0x84
  dump_stack+0x18/0x24
  print_circular_bug+0x1cc/0x234
  check_noncircular+0x78/0xac
  __lock_acquire+0xdf8/0x109c
  lock_acquire+0x234/0x284
  console_flush_all+0x330/0x454
  console_unlock+0x94/0xf0
  vprintk_emit+0x238/0x24c
  vprintk_default+0x3c/0x48
  vprintk+0xb4/0xbc
  _printk+0x68/0x90
  dma_entry_alloc+0xb4/0x110
  debug_dma_map_sg+0xdc/0x2f8
  __dma_map_sg_attrs+0xac/0xe4
  dma_map_sgtable+0x30/0x4c
  get_pages+0x1d4/0x1e4 [msm]
  msm_gem_pin_pages_locked+0x38/0xac [msm]
  msm_gem_pin_vma_locked+0x58/0x88 [msm]
  msm_ioctl_gem_submit+0xde4/0x13ac [msm]
  drm_ioctl_kernel+0xe0/0x15c
  drm_ioctl+0x2e8/0x3f4
  vfs_ioctl+0x30/0x50
  ...

Reported-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index ae9fc1ee6d206..0263983089097 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -606,15 +606,19 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
-static void __dma_entry_alloc_check_leak(void)
+/*
+ * This should be called outside of free_entries_lock scope to avoid potential
+ * deadlocks with serial consoles that use DMA.
+ */
+static void __dma_entry_alloc_check_leak(u32 nr_entries)
 {
-	u32 tmp = nr_total_entries % nr_prealloc_entries;
+	u32 tmp = nr_entries % nr_prealloc_entries;
 
 	/* Shout each time we tick over some multiple of the initial pool */
 	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
 		pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
-			nr_total_entries,
-			(nr_total_entries / nr_prealloc_entries));
+			nr_entries,
+			(nr_entries / nr_prealloc_entries));
 	}
 }
 
@@ -625,8 +629,10 @@ static void __dma_entry_alloc_check_leak(void)
  */
 static struct dma_debug_entry *dma_entry_alloc(void)
 {
+	bool alloc_check_leak = false;
 	struct dma_debug_entry *entry;
 	unsigned long flags;
+	u32 nr_entries;
 
 	spin_lock_irqsave(&free_entries_lock, flags);
 	if (num_free_entries == 0) {
@@ -636,13 +642,17 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 			pr_err("debugging out of memory - disabling\n");
 			return NULL;
 		}
-		__dma_entry_alloc_check_leak();
+		alloc_check_leak = true;
+		nr_entries = nr_total_entries;
 	}
 
 	entry = __dma_entry_alloc();
 
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
+	if (alloc_check_leak)
+		__dma_entry_alloc_check_leak(nr_entries);
+
 #ifdef CONFIG_STACKTRACE
 	entry->stack_len = stack_trace_save(entry->stack_entries,
 					    ARRAY_SIZE(entry->stack_entries),
-- 
2.40.1



