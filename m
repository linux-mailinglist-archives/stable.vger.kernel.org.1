Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186E27612E1
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjGYLGU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233973AbjGYLF7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9934220
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:04:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EFF5615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D74DC433C8;
        Tue, 25 Jul 2023 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283046;
        bh=uzOJC1j3ggcTbUjNpsQPiVr08ojGRzXTA9na/+HdOfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jERp663Q6IYjrbSxjZpO6ug4kBC5OW23KAszKjsWqrMf/+UZF7X+09VGPOboHM3EV
         6cn0EK3RrZ8GnNlZqysUj/Ori3+Vqf7hig4/E0VtOe7OfWBWNUg1BMpFRJcVYsV4qX
         1sl4NDQ0Bk1V1dYrKhk2ah0g/KdUzmQ2cYWA68WE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ding Hui <dinghui@sangfor.com.cn>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Huang Cun <huangcun@sangfor.com.cn>,
        Leon Romanovsky <leonro@nvidia.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 119/183] iavf: Fix out-of-bounds when setting channels on remove
Date:   Tue, 25 Jul 2023 12:45:47 +0200
Message-ID: <20230725104512.241862366@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
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

From: Ding Hui <dinghui@sangfor.com.cn>

[ Upstream commit 7c4bced3caa749ce468b0c5de711c98476b23a52 ]

If we set channels greater during iavf_remove(), and waiting reset done
would be timeout, then returned with error but changed num_active_queues
directly, that will lead to OOB like the following logs. Because the
num_active_queues is greater than tx/rx_rings[] allocated actually.

Reproducer:

  [root@host ~]# cat repro.sh
  #!/bin/bash

  pf_dbsf="0000:41:00.0"
  vf0_dbsf="0000:41:02.0"
  g_pids=()

  function do_set_numvf()
  {
      echo 2 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
      sleep $((RANDOM%3+1))
      echo 0 >/sys/bus/pci/devices/${pf_dbsf}/sriov_numvfs
      sleep $((RANDOM%3+1))
  }

  function do_set_channel()
  {
      local nic=$(ls -1 --indicator-style=none /sys/bus/pci/devices/${vf0_dbsf}/net/)
      [ -z "$nic" ] && { sleep $((RANDOM%3)) ; return 1; }
      ifconfig $nic 192.168.18.5 netmask 255.255.255.0
      ifconfig $nic up
      ethtool -L $nic combined 1
      ethtool -L $nic combined 4
      sleep $((RANDOM%3))
  }

  function on_exit()
  {
      local pid
      for pid in "${g_pids[@]}"; do
          kill -0 "$pid" &>/dev/null && kill "$pid" &>/dev/null
      done
      g_pids=()
  }

  trap "on_exit; exit" EXIT

  while :; do do_set_numvf ; done &
  g_pids+=($!)
  while :; do do_set_channel ; done &
  g_pids+=($!)

  wait

Result:

[ 3506.152887] iavf 0000:41:02.0: Removing device
[ 3510.400799] ==================================================================
[ 3510.400820] BUG: KASAN: slab-out-of-bounds in iavf_free_all_tx_resources+0x156/0x160 [iavf]
[ 3510.400823] Read of size 8 at addr ffff88b6f9311008 by task repro.sh/55536
[ 3510.400823]
[ 3510.400830] CPU: 101 PID: 55536 Comm: repro.sh Kdump: loaded Tainted: G           O     --------- -t - 4.18.0 #1
[ 3510.400832] Hardware name: Powerleader PR2008AL/H12DSi-N6, BIOS 2.0 04/09/2021
[ 3510.400835] Call Trace:
[ 3510.400851]  dump_stack+0x71/0xab
[ 3510.400860]  print_address_description+0x6b/0x290
[ 3510.400865]  ? iavf_free_all_tx_resources+0x156/0x160 [iavf]
[ 3510.400868]  kasan_report+0x14a/0x2b0
[ 3510.400873]  iavf_free_all_tx_resources+0x156/0x160 [iavf]
[ 3510.400880]  iavf_remove+0x2b6/0xc70 [iavf]
[ 3510.400884]  ? iavf_free_all_rx_resources+0x160/0x160 [iavf]
[ 3510.400891]  ? wait_woken+0x1d0/0x1d0
[ 3510.400895]  ? notifier_call_chain+0xc1/0x130
[ 3510.400903]  pci_device_remove+0xa8/0x1f0
[ 3510.400910]  device_release_driver_internal+0x1c6/0x460
[ 3510.400916]  pci_stop_bus_device+0x101/0x150
[ 3510.400919]  pci_stop_and_remove_bus_device+0xe/0x20
[ 3510.400924]  pci_iov_remove_virtfn+0x187/0x420
[ 3510.400927]  ? pci_iov_add_virtfn+0xe10/0xe10
[ 3510.400929]  ? pci_get_subsys+0x90/0x90
[ 3510.400932]  sriov_disable+0xed/0x3e0
[ 3510.400936]  ? bus_find_device+0x12d/0x1a0
[ 3510.400953]  i40e_free_vfs+0x754/0x1210 [i40e]
[ 3510.400966]  ? i40e_reset_all_vfs+0x880/0x880 [i40e]
[ 3510.400968]  ? pci_get_device+0x7c/0x90
[ 3510.400970]  ? pci_get_subsys+0x90/0x90
[ 3510.400982]  ? pci_vfs_assigned.part.7+0x144/0x210
[ 3510.400987]  ? __mutex_lock_slowpath+0x10/0x10
[ 3510.400996]  i40e_pci_sriov_configure+0x1fa/0x2e0 [i40e]
[ 3510.401001]  sriov_numvfs_store+0x214/0x290
[ 3510.401005]  ? sriov_totalvfs_show+0x30/0x30
[ 3510.401007]  ? __mutex_lock_slowpath+0x10/0x10
[ 3510.401011]  ? __check_object_size+0x15a/0x350
[ 3510.401018]  kernfs_fop_write+0x280/0x3f0
[ 3510.401022]  vfs_write+0x145/0x440
[ 3510.401025]  ksys_write+0xab/0x160
[ 3510.401028]  ? __ia32_sys_read+0xb0/0xb0
[ 3510.401031]  ? fput_many+0x1a/0x120
[ 3510.401032]  ? filp_close+0xf0/0x130
[ 3510.401038]  do_syscall_64+0xa0/0x370
[ 3510.401041]  ? page_fault+0x8/0x30
[ 3510.401043]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 3510.401073] RIP: 0033:0x7f3a9bb842c0
[ 3510.401079] Code: 73 01 c3 48 8b 0d d8 cb 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 89 24 2d 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 fe dd 01 00 48 89 04 24
[ 3510.401080] RSP: 002b:00007ffc05f1fe18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 3510.401083] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f3a9bb842c0
[ 3510.401085] RDX: 0000000000000002 RSI: 0000000002327408 RDI: 0000000000000001
[ 3510.401086] RBP: 0000000002327408 R08: 00007f3a9be53780 R09: 00007f3a9c8a4700
[ 3510.401086] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[ 3510.401087] R13: 0000000000000001 R14: 00007f3a9be52620 R15: 0000000000000001
[ 3510.401090]
[ 3510.401093] Allocated by task 76795:
[ 3510.401098]  kasan_kmalloc+0xa6/0xd0
[ 3510.401099]  __kmalloc+0xfb/0x200
[ 3510.401104]  iavf_init_interrupt_scheme+0x26f/0x1310 [iavf]
[ 3510.401108]  iavf_watchdog_task+0x1d58/0x4050 [iavf]
[ 3510.401114]  process_one_work+0x56a/0x11f0
[ 3510.401115]  worker_thread+0x8f/0xf40
[ 3510.401117]  kthread+0x2a0/0x390
[ 3510.401119]  ret_from_fork+0x1f/0x40
[ 3510.401122]  0xffffffffffffffff
[ 3510.401123]

In timeout handling, we should keep the original num_active_queues
and reset num_req_queues to 0.

Fixes: 4e5e6b5d9d13 ("iavf: Fix return of set the new channel count")
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Cc: Donglin Peng <pengdonglin@sangfor.com.cn>
Cc: Huang Cun <huangcun@sangfor.com.cn>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 83cfc54a47062..4746ee517c75a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1863,7 +1863,7 @@ static int iavf_set_channels(struct net_device *netdev,
 	}
 	if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
 		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
-		adapter->num_active_queues = num_req;
+		adapter->num_req_queues = 0;
 		return -EOPNOTSUPP;
 	}
 
-- 
2.39.2



