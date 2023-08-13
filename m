Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6F977AC51
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjHMVcL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjHMVcK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D721BE7
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:31:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 044A862B49
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9A8C433C8;
        Sun, 13 Aug 2023 21:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962305;
        bh=b4IPiS6o5lHjzNYLNZcgvpuRvgyOawN94vatG/qa3wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRmtugFSJ2s3To7ESVv5AHLpj+TjC9F6h8BTjK+KZgpgy+qsFOFr830fUX6S+0Lxf
         4RCA2wfJogi33NfOh0y2J52f6I/D2/Ywp5+bpx8TLqbTkoRBfNyzzjGb7lDRnUONfp
         By19CEj+AKxL27guftX0aYGTHfjn8ZEwnQhQRZs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yonglong Liu <liuyonglong@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 158/206] net: hns3: fix deadlock issue when externel_lb and reset are executed together
Date:   Sun, 13 Aug 2023 23:18:48 +0200
Message-ID: <20230813211729.549519199@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

commit ac6257a3ae5db5193b1f19c268e4f72d274ddb88 upstream.

When externel_lb and reset are executed together, a deadlock may
occur:
[ 3147.217009] INFO: task kworker/u321:0:7 blocked for more than 120 seconds.
[ 3147.230483] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3147.238999] task:kworker/u321:0  state:D stack:    0 pid:    7 ppid:     2 flags:0x00000008
[ 3147.248045] Workqueue: hclge hclge_service_task [hclge]
[ 3147.253957] Call trace:
[ 3147.257093]  __switch_to+0x7c/0xbc
[ 3147.261183]  __schedule+0x338/0x6f0
[ 3147.265357]  schedule+0x50/0xe0
[ 3147.269185]  schedule_preempt_disabled+0x18/0x24
[ 3147.274488]  __mutex_lock.constprop.0+0x1d4/0x5dc
[ 3147.279880]  __mutex_lock_slowpath+0x1c/0x30
[ 3147.284839]  mutex_lock+0x50/0x60
[ 3147.288841]  rtnl_lock+0x20/0x2c
[ 3147.292759]  hclge_reset_prepare+0x68/0x90 [hclge]
[ 3147.298239]  hclge_reset_subtask+0x88/0xe0 [hclge]
[ 3147.303718]  hclge_reset_service_task+0x84/0x120 [hclge]
[ 3147.309718]  hclge_service_task+0x2c/0x70 [hclge]
[ 3147.315109]  process_one_work+0x1d0/0x490
[ 3147.319805]  worker_thread+0x158/0x3d0
[ 3147.324240]  kthread+0x108/0x13c
[ 3147.328154]  ret_from_fork+0x10/0x18

In externel_lb process, the hns3 driver call napi_disable()
first, then the reset happen, then the restore process of the
externel_lb will fail, and will not call napi_enable(). When
doing externel_lb again, napi_disable() will be double call,
cause a deadlock of rtnl_lock().

This patch use the HNS3_NIC_STATE_DOWN state to protect the
calling of napi_disable() and napi_enable() in externel_lb
process, just as the usage in ndo_stop() and ndo_start().

Fixes: 04b6ba143521 ("net: hns3: add support for external loopback test")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/20230807113452.474224-5-shaojijie@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -5854,6 +5854,9 @@ void hns3_external_lb_prepare(struct net
 	if (!if_running)
 		return;
 
+	if (test_and_set_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		return;
+
 	netif_carrier_off(ndev);
 	netif_tx_disable(ndev);
 
@@ -5882,7 +5885,16 @@ void hns3_external_lb_restore(struct net
 	if (!if_running)
 		return;
 
-	hns3_nic_reset_all_ring(priv->ae_handle);
+	if (hns3_nic_resetting(ndev))
+		return;
+
+	if (!test_bit(HNS3_NIC_STATE_DOWN, &priv->state))
+		return;
+
+	if (hns3_nic_reset_all_ring(priv->ae_handle))
+		return;
+
+	clear_bit(HNS3_NIC_STATE_DOWN, &priv->state);
 
 	for (i = 0; i < priv->vector_num; i++)
 		hns3_vector_enable(&priv->tqp_vector[i]);


