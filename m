Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266E4726B48
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjFGUYR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjFGUXz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:23:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C452717
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DD5964414
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD2AC433D2;
        Wed,  7 Jun 2023 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169402;
        bh=sxGsx+LLLvO38eLEOLnZoCurYd7hgROwcq06d6K0R6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O40ZVmDqqnITldAF0Y+cKGwQJlhnFNNY93EWL41eBwsTCTEpZ+ThNi37/UV37KS+X
         8jQyX+sFEvwgm1LAy6v0X3mI+I5leB54erXhzUvyqsh2UZQflSLfrT+5YmGY4AWxf6
         yjv1tdxsQcGfCFKHyeJHRmOGjYr6EtEDfKsg2PtA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Fang <wei.fang@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 036/286] net: stmmac: fix call trace when stmmac_xdp_xmit() is invoked
Date:   Wed,  7 Jun 2023 22:12:15 +0200
Message-ID: <20230607200924.210471512@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit ffb3322181d9e8db880202e4f00991764a35d812 ]

We encountered a kernel call trace issue which was related to
ndo_xdp_xmit callback on our i.MX8MP platform. The reproduce
steps show as follows.
1. The FEC port (eth0) connects to a PC port, and the PC uses
pktgen_sample03_burst_single_flow.sh to generate packets and
send these packets to the FEC port. Notice that the script must
be executed before step 2.
2. Run the "./xdp_redirect eth0 eth1" command on i.MX8MP, the
eth1 interface is the dwmac. Then there will be a call trace
issue soon. Please see the log for more details.
The root cause is that the NETDEV_XDP_ACT_NDO_XMIT feature is
enabled by default, so when the step 2 command is exexcuted
and packets have already been sent to eth0, the stmmac_xdp_xmit()
starts running before the stmmac_xdp_set_prog() finishes. To
resolve this issue, we disable the NETDEV_XDP_ACT_NDO_XMIT
feature by default and turn on/off this feature when the bpf
program is installed/uninstalled which just like the other
ethernet drivers.

Call Trace log:
[  306.311271] ------------[ cut here ]------------
[  306.315910] WARNING: CPU: 0 PID: 15 at lib/timerqueue.c:55 timerqueue_del+0x68/0x70
[  306.323590] Modules linked in:
[  306.326654] CPU: 0 PID: 15 Comm: ksoftirqd/0 Not tainted 6.4.0-rc1+ #37
[  306.333277] Hardware name: NXP i.MX8MPlus EVK board (DT)
[  306.338591] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  306.345561] pc : timerqueue_del+0x68/0x70
[  306.349577] lr : __remove_hrtimer+0x5c/0xa0
[  306.353777] sp : ffff80000b7c3920
[  306.357094] x29: ffff80000b7c3920 x28: 0000000000000000 x27: 0000000000000001
[  306.364244] x26: ffff80000a763a40 x25: ffff0000d0285a00 x24: 0000000000000001
[  306.371390] x23: 0000000000000001 x22: ffff000179389a40 x21: 0000000000000000
[  306.378537] x20: ffff000179389aa0 x19: ffff0000d2951308 x18: 0000000000001000
[  306.385686] x17: f1d3000000000000 x16: 00000000c39c1000 x15: 55e99bbe00001a00
[  306.392835] x14: 09000900120aa8c0 x13: e49af1d300000000 x12: 000000000000c39c
[  306.399987] x11: 100055e99bbe0000 x10: ffff8000090b1048 x9 : ffff8000081603fc
[  306.407133] x8 : 000000000000003c x7 : 000000000000003c x6 : 0000000000000001
[  306.414284] x5 : ffff0000d2950980 x4 : 0000000000000000 x3 : 0000000000000000
[  306.421432] x2 : 0000000000000001 x1 : ffff0000d2951308 x0 : ffff0000d2951308
[  306.428585] Call trace:
[  306.431035]  timerqueue_del+0x68/0x70
[  306.434706]  __remove_hrtimer+0x5c/0xa0
[  306.438549]  hrtimer_start_range_ns+0x2bc/0x370
[  306.443089]  stmmac_xdp_xmit+0x174/0x1b0
[  306.447021]  bq_xmit_all+0x194/0x4b0
[  306.450612]  __dev_flush+0x4c/0x98
[  306.454024]  xdp_do_flush+0x18/0x38
[  306.457522]  fec_enet_rx_napi+0x6c8/0xc68
[  306.461539]  __napi_poll+0x40/0x220
[  306.465038]  net_rx_action+0xf8/0x240
[  306.468707]  __do_softirq+0x128/0x3a8
[  306.472378]  run_ksoftirqd+0x40/0x58
[  306.475961]  smpboot_thread_fn+0x1c4/0x288
[  306.480068]  kthread+0x124/0x138
[  306.483305]  ret_from_fork+0x10/0x20
[  306.486889] ---[ end trace 0000000000000000 ]---

Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230524125714.357337-1-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f9cd063f1fe30..71f8f78ce0090 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7176,8 +7176,7 @@ int stmmac_dvr_probe(struct device *device,
 	ndev->hw_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
 			    NETIF_F_RXCSUM;
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-			     NETDEV_XDP_ACT_XSK_ZEROCOPY |
-			     NETDEV_XDP_ACT_NDO_XMIT;
+			     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
 	ret = stmmac_tc_init(priv, priv);
 	if (!ret) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index 9d4d8c3dad0a3..aa6f16d3df649 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -117,6 +117,9 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}
 
+	if (!prog)
+		xdp_features_clear_redirect_target(dev);
+
 	need_update = !!priv->xdp_prog != !!prog;
 	if (if_running && need_update)
 		stmmac_xdp_release(dev);
@@ -131,5 +134,8 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 	if (if_running && need_update)
 		stmmac_xdp_open(dev);
 
+	if (prog)
+		xdp_features_set_redirect_target(dev, false);
+
 	return 0;
 }
-- 
2.39.2



