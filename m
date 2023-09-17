Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EC97A3A2C
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbjIQT7c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240360AbjIQT7M (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:59:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4448212F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:59:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400F5C433C8;
        Sun, 17 Sep 2023 19:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980746;
        bh=1AwLyyZ858qT6wDXCblBypdsmm60Wk900LzRgYrDGZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyypw2bolvl/X2cOZcd2VPSlXRiYSWiyZ9ofU62x1czfbRDQw6dmZzdZpSheqhcF7
         mhtDqMQgVzNu9RKfwRtVY9tgma8oTL4a2wFJfpLRPu+V5MjEhYXQR0R11C5Pyugq6h
         dyxycKcf6Oqejsg3nCRkemBubjZ16I1mgH38KdMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Corinna Vinschen <vinschen@redhat.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 281/285] igb: clean up in all error paths when enabling SR-IOV
Date:   Sun, 17 Sep 2023 21:14:41 +0200
Message-ID: <20230917191100.860718960@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corinna Vinschen <vinschen@redhat.com>

[ Upstream commit bc6ed2fa24b14e40e1005488bbe11268ce7108fa ]

After commit 50f303496d92 ("igb: Enable SR-IOV after reinit"), removing
the igb module could hang or crash (depending on the machine) when the
module has been loaded with the max_vfs parameter set to some value != 0.

In case of one test machine with a dual port 82580, this hang occurred:

[  232.480687] igb 0000:41:00.1: removed PHC on enp65s0f1
[  233.093257] igb 0000:41:00.1: IOV Disabled
[  233.329969] pcieport 0000:40:01.0: AER: Multiple Uncorrected (Non-Fatal) err0
[  233.340302] igb 0000:41:00.0: PCIe Bus Error: severity=Uncorrected (Non-Fata)
[  233.352248] igb 0000:41:00.0:   device [8086:1516] error status/mask=00100000
[  233.361088] igb 0000:41:00.0:    [20] UnsupReq               (First)
[  233.368183] igb 0000:41:00.0: AER:   TLP Header: 40000001 0000040f cdbfc00c c
[  233.376846] igb 0000:41:00.1: PCIe Bus Error: severity=Uncorrected (Non-Fata)
[  233.388779] igb 0000:41:00.1:   device [8086:1516] error status/mask=00100000
[  233.397629] igb 0000:41:00.1:    [20] UnsupReq               (First)
[  233.404736] igb 0000:41:00.1: AER:   TLP Header: 40000001 0000040f cdbfc00c c
[  233.538214] pci 0000:41:00.1: AER: can't recover (no error_detected callback)
[  233.538401] igb 0000:41:00.0: removed PHC on enp65s0f0
[  233.546197] pcieport 0000:40:01.0: AER: device recovery failed
[  234.157244] igb 0000:41:00.0: IOV Disabled
[  371.619705] INFO: task irq/35-aerdrv:257 blocked for more than 122 seconds.
[  371.627489]       Not tainted 6.4.0-dirty #2
[  371.632257] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this.
[  371.641000] task:irq/35-aerdrv   state:D stack:0     pid:257   ppid:2      f0
[  371.650330] Call Trace:
[  371.653061]  <TASK>
[  371.655407]  __schedule+0x20e/0x660
[  371.659313]  schedule+0x5a/0xd0
[  371.662824]  schedule_preempt_disabled+0x11/0x20
[  371.667983]  __mutex_lock.constprop.0+0x372/0x6c0
[  371.673237]  ? __pfx_aer_root_reset+0x10/0x10
[  371.678105]  report_error_detected+0x25/0x1c0
[  371.682974]  ? __pfx_report_normal_detected+0x10/0x10
[  371.688618]  pci_walk_bus+0x72/0x90
[  371.692519]  pcie_do_recovery+0xb2/0x330
[  371.696899]  aer_process_err_devices+0x117/0x170
[  371.702055]  aer_isr+0x1c0/0x1e0
[  371.705661]  ? __set_cpus_allowed_ptr+0x54/0xa0
[  371.710723]  ? __pfx_irq_thread_fn+0x10/0x10
[  371.715496]  irq_thread_fn+0x20/0x60
[  371.719491]  irq_thread+0xe6/0x1b0
[  371.723291]  ? __pfx_irq_thread_dtor+0x10/0x10
[  371.728255]  ? __pfx_irq_thread+0x10/0x10
[  371.732731]  kthread+0xe2/0x110
[  371.736243]  ? __pfx_kthread+0x10/0x10
[  371.740430]  ret_from_fork+0x2c/0x50
[  371.744428]  </TASK>

The reproducer was a simple script:

  #!/bin/sh
  for i in `seq 1 5`; do
    modprobe -rv igb
    modprobe -v igb max_vfs=1
    sleep 1
    modprobe -rv igb
  done

It turned out that this could only be reproduce on 82580 (quad and
dual-port), but not on 82576, i350 and i210.  Further debugging showed
that igb_enable_sriov()'s call to pci_enable_sriov() is failing, because
dev->is_physfn is 0 on 82580.

Prior to commit 50f303496d92 ("igb: Enable SR-IOV after reinit"),
igb_enable_sriov() jumped into the "err_out" cleanup branch.  After this
commit it only returned the error code.

So the cleanup didn't take place, and the incorrect VF setup in the
igb_adapter structure fooled the igb driver into assuming that VFs have
been set up where no VF actually existed.

Fix this problem by cleaning up again if pci_enable_sriov() fails.

Fixes: 50f303496d92 ("igb: Enable SR-IOV after reinit")
Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ac19730e8db91..12f106b3a878b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3827,8 +3827,11 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 	}
 
 	/* only call pci_enable_sriov() if no VFs are allocated already */
-	if (!old_vfs)
+	if (!old_vfs) {
 		err = pci_enable_sriov(pdev, adapter->vfs_allocated_count);
+		if (err)
+			goto err_out;
+	}
 
 	goto out;
 
-- 
2.40.1



