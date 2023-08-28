Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A3978AB7D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjH1KbV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjH1KbF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:31:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA56198
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:30:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C74D63CDF
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:30:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576E7C433C8;
        Mon, 28 Aug 2023 10:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218645;
        bh=Tb4kBzfwXYRTk7kCFnDWF1VMJBBY2r/adVXqaqfQ3Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvCuyiwFkVcBJXXNjV5n6fJPQQOAsXEfIfCbG4U3rOdRH7KwQkj3O7BCpg+c2zoWg
         HXlmPLJd0blOMIDvRtN8P7cL9bO015J1UeqstcrsuxK4TEPqeF/fC/tUyxl82TOpK4
         /7edBxI/YygiPuMk//lzZ2rLcKD209xukc6sYoSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danielle Ratson <danieller@nvidia.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/122] mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC
Date:   Mon, 28 Aug 2023 12:12:28 +0200
Message-ID: <20230828101157.520650722@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
References: <20230828101156.480754469@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danielle Ratson <danieller@nvidia.com>

[ Upstream commit bc2de151ab6ad0762a04563527ec42e54dde572a ]

Currently, in Spectrum-2 and above, time stamps are extracted from the CQE
into the time stamp fields in 'struct mlxsw_skb_cb', only when the CQE
time stamp type is UTC. The time stamps are read directly from the CQE and
software can get the time stamp in UTC format using CQEv2.

>From Spectrum-4, the time stamps that are read from the CQE are allowed
to be also from MIRROR_UTC type.

Therefore, we get a warning [1] from the driver that the time stamp fields
were not set, when LLDP control packet is sent.

Allow the time stamp type to be MIRROR_UTC and set the time stamp in this
case as well.

[1]
 WARNING: CPU: 11 PID: 0 at drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c:1409 mlxsw_sp2_ptp_hwtstamp_fill+0x1f/0x70 [mlxsw_spectrum]
[...]
 Call Trace:
  <IRQ>
  mlxsw_sp2_ptp_receive+0x3c/0x80 [mlxsw_spectrum]
  mlxsw_core_skb_receive+0x119/0x190 [mlxsw_core]
  mlxsw_pci_cq_tasklet+0x3c9/0x780 [mlxsw_pci]
  tasklet_action_common.constprop.0+0x9f/0x110
  __do_softirq+0xbb/0x296
  irq_exit_rcu+0x79/0xa0
  common_interrupt+0x86/0xa0
  </IRQ>
  <TASK>

Fixes: 4735402173e6 ("mlxsw: spectrum: Extend to support Spectrum-4 ASIC")
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/bcef4d044ef608a4e258d33a7ec0ecd91f480db5.1692268427.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index c968309657dd1..51eea1f0529c8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -517,11 +517,15 @@ static void mlxsw_pci_skb_cb_ts_set(struct mlxsw_pci *mlxsw_pci,
 				    struct sk_buff *skb,
 				    enum mlxsw_pci_cqe_v cqe_v, char *cqe)
 {
+	u8 ts_type;
+
 	if (cqe_v != MLXSW_PCI_CQE_V2)
 		return;
 
-	if (mlxsw_pci_cqe2_time_stamp_type_get(cqe) !=
-	    MLXSW_PCI_CQE_TIME_STAMP_TYPE_UTC)
+	ts_type = mlxsw_pci_cqe2_time_stamp_type_get(cqe);
+
+	if (ts_type != MLXSW_PCI_CQE_TIME_STAMP_TYPE_UTC &&
+	    ts_type != MLXSW_PCI_CQE_TIME_STAMP_TYPE_MIRROR_UTC)
 		return;
 
 	mlxsw_skb_cb(skb)->cqe_ts.sec = mlxsw_pci_cqe2_time_stamp_sec_get(cqe);
-- 
2.40.1



