Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B9270C7ED
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbjEVTdy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjEVTdx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EFE10CA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:33:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B830E62949
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA05C433D2;
        Mon, 22 May 2023 19:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783963;
        bh=3IN/3BNRp4AN4gC0w/+NH+j/FFM3Rbe+QvxnUwuZK7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0Y9e9P7e9u2BeN3hrGkFAIrSzSce/JBHh18zHRe+JvxmvVNypMt2F/jXVltBq2bD
         uH0LBSU2QStsqVLM9tP6V4jX8MuRdDlf/Yvkl7v6nYTQ6a2Y85L6pNCC1pnGKTcGco
         3Xaeiegrxaf8vufO7Ig765n/kkf8Z+EVoxjota2Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Samuel Wein PhD <sam@samwein.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 220/292] net: wwan: iosm: fix NULL pointer dereference when removing device
Date:   Mon, 22 May 2023 20:09:37 +0100
Message-Id: <20230522190411.455996122@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: M Chetan Kumar <m.chetan.kumar@linux.intel.com>

[ Upstream commit 60829145f1e2650b31ebe6a0ec70a9725b38fa2c ]

In suspend and resume cycle, the removal and rescan of device ends
up in NULL pointer dereference.

During driver initialization, if the ipc_imem_wwan_channel_init()
fails to get the valid device capabilities it returns an error and
further no resource (wwan struct) will be allocated. Now in this
situation if driver removal procedure is initiated it would result
in NULL pointer exception since unallocated wwan struct is dereferenced
inside ipc_wwan_deinit().

ipc_imem_run_state_worker() to handle the called functions return value
and to release the resource in failure case. It also reports the link
down event in failure cases. The user space application can handle this
event to do a device reset for restoring the device communication.

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Reported-by: Samuel Wein PhD <sam@samwein.com>
Closes: https://lore.kernel.org/netdev/20230427140819.1310f4bd@kernel.org/T/
Signed-off-by: M Chetan Kumar <m.chetan.kumar@linux.intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wwan/iosm/iosm_ipc_imem.c     | 27 ++++++++++++++++++-----
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.c | 12 ++++++----
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.h |  6 +++--
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 1e6a479766429..8ccd4d26b9060 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -565,24 +565,32 @@ static void ipc_imem_run_state_worker(struct work_struct *instance)
 	struct ipc_mux_config mux_cfg;
 	struct iosm_imem *ipc_imem;
 	u8 ctrl_chl_idx = 0;
+	int ret;
 
 	ipc_imem = container_of(instance, struct iosm_imem, run_state_worker);
 
 	if (ipc_imem->phase != IPC_P_RUN) {
 		dev_err(ipc_imem->dev,
 			"Modem link down. Exit run state worker.");
-		return;
+		goto err_out;
 	}
 
 	if (test_and_clear_bit(IOSM_DEVLINK_INIT, &ipc_imem->flag))
 		ipc_devlink_deinit(ipc_imem->ipc_devlink);
 
-	if (!ipc_imem_setup_cp_mux_cap_init(ipc_imem, &mux_cfg))
-		ipc_imem->mux = ipc_mux_init(&mux_cfg, ipc_imem);
+	ret = ipc_imem_setup_cp_mux_cap_init(ipc_imem, &mux_cfg);
+	if (ret < 0)
+		goto err_out;
+
+	ipc_imem->mux = ipc_mux_init(&mux_cfg, ipc_imem);
+	if (!ipc_imem->mux)
+		goto err_out;
+
+	ret = ipc_imem_wwan_channel_init(ipc_imem, mux_cfg.protocol);
+	if (ret < 0)
+		goto err_ipc_mux_deinit;
 
-	ipc_imem_wwan_channel_init(ipc_imem, mux_cfg.protocol);
-	if (ipc_imem->mux)
-		ipc_imem->mux->wwan = ipc_imem->wwan;
+	ipc_imem->mux->wwan = ipc_imem->wwan;
 
 	while (ctrl_chl_idx < IPC_MEM_MAX_CHANNELS) {
 		if (!ipc_chnl_cfg_get(&chnl_cfg_port, ctrl_chl_idx)) {
@@ -615,6 +623,13 @@ static void ipc_imem_run_state_worker(struct work_struct *instance)
 
 	/* Complete all memory stores after setting bit */
 	smp_mb__after_atomic();
+
+	return;
+
+err_ipc_mux_deinit:
+	ipc_mux_deinit(ipc_imem->mux);
+err_out:
+	ipc_uevent_send(ipc_imem->dev, UEVENT_CD_READY_LINK_DOWN);
 }
 
 static void ipc_imem_handle_irq(struct iosm_imem *ipc_imem, int irq)
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
index 66b90cc4c3460..109cf89304888 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
@@ -77,8 +77,8 @@ int ipc_imem_sys_wwan_transmit(struct iosm_imem *ipc_imem,
 }
 
 /* Initialize wwan channel */
-void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
-				enum ipc_mux_protocol mux_type)
+int ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
+			       enum ipc_mux_protocol mux_type)
 {
 	struct ipc_chnl_cfg chnl_cfg = { 0 };
 
@@ -87,7 +87,7 @@ void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
 	/* If modem version is invalid (0xffffffff), do not initialize WWAN. */
 	if (ipc_imem->cp_version == -1) {
 		dev_err(ipc_imem->dev, "invalid CP version");
-		return;
+		return -EIO;
 	}
 
 	ipc_chnl_cfg_get(&chnl_cfg, ipc_imem->nr_of_channels);
@@ -104,9 +104,13 @@ void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
 
 	/* WWAN registration. */
 	ipc_imem->wwan = ipc_wwan_init(ipc_imem, ipc_imem->dev);
-	if (!ipc_imem->wwan)
+	if (!ipc_imem->wwan) {
 		dev_err(ipc_imem->dev,
 			"failed to register the ipc_wwan interfaces");
+		return -ENOMEM;
+	}
+
+	return 0;
 }
 
 /* Map SKB to DMA for transfer */
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
index f8afb217d9e2f..026c5bd0f9992 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.h
@@ -91,9 +91,11 @@ int ipc_imem_sys_wwan_transmit(struct iosm_imem *ipc_imem, int if_id,
  *				MUX.
  * @ipc_imem:		Pointer to iosm_imem struct.
  * @mux_type:		Type of mux protocol.
+ *
+ * Return: 0 on success and failure value on error
  */
-void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
-				enum ipc_mux_protocol mux_type);
+int ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
+			       enum ipc_mux_protocol mux_type);
 
 /**
  * ipc_imem_sys_devlink_open - Open a Flash/CD Channel link to CP
-- 
2.39.2



