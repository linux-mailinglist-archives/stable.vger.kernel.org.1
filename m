Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB97353EE
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjFSKu1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjFSKt3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:49:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C83819C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB3560B88
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD83FC433C0;
        Mon, 19 Jun 2023 10:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171765;
        bh=Z82NHA9vZFWFVhuwHyBxbmdMZ0DxI0UjLkKG4RC6T/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZUcBWwSwxlkQXSJGUtH0GShmldUG2x4j3HXqkht45lkPNxUzp+/iIzYnfyi5OUjk
         B3FWiwGcTQi60B4P6PiRHLOY8KEUULEggh1kjlDjaMLX5hL4oalx4jeDS+CM19shp3
         qvDovMQoo/d181VcFDFqZPwjrQMIMVlBJ9W8Qmd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yanghang Liu <yanghliu@redhat.com>,
        =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 149/166] sfc: fix XDP queues mode with legacy IRQ
Date:   Mon, 19 Jun 2023 12:30:26 +0200
Message-ID: <20230619102201.937292221@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Íñigo Huguet <ihuguet@redhat.com>

[ Upstream commit e84a1e1e683f3558e30f437d7c99df35afb8b52c ]

In systems without MSI-X capabilities, xdp_txq_queues_mode is calculated
in efx_allocate_msix_channels, but when enabling MSI-X fails, it was not
changed to a proper default value. This was leading to the driver
thinking that it has dedicated XDP queues, when it didn't.

Fix it by setting xdp_txq_queues_mode to the correct value if the driver
fallbacks to MSI or legacy IRQ mode. The correct value is
EFX_XDP_TX_QUEUES_BORROWED because there are no XDP dedicated queues.

The issue can be easily visible if the kernel is started with pci=nomsi,
then a call trace is shown. It is not shown only with sfc's modparam
interrupt_mode=2. Call trace example:
 WARNING: CPU: 2 PID: 663 at drivers/net/ethernet/sfc/efx_channels.c:828 efx_set_xdp_channels+0x124/0x260 [sfc]
 [...skip...]
 Call Trace:
  <TASK>
  efx_set_channels+0x5c/0xc0 [sfc]
  efx_probe_nic+0x9b/0x15a [sfc]
  efx_probe_all+0x10/0x1a2 [sfc]
  efx_pci_probe_main+0x12/0x156 [sfc]
  efx_pci_probe_post_io+0x18/0x103 [sfc]
  efx_pci_probe.cold+0x154/0x257 [sfc]
  local_pci_probe+0x42/0x80

Fixes: 6215b608a8c4 ("sfc: last resort fallback for lack of xdp tx queues")
Reported-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Íñigo Huguet <ihuguet@redhat.com>
Acked-by: Martin Habets <habetsm.xilinx@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sfc/efx_channels.c       | 2 ++
 drivers/net/ethernet/sfc/siena/efx_channels.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
index aaa381743bca3..27d00ffac68f4 100644
--- a/drivers/net/ethernet/sfc/efx_channels.c
+++ b/drivers/net/ethernet/sfc/efx_channels.c
@@ -301,6 +301,7 @@ int efx_probe_interrupts(struct efx_nic *efx)
 		efx->tx_channel_offset = 0;
 		efx->n_xdp_channels = 0;
 		efx->xdp_channel_offset = efx->n_channels;
+		efx->xdp_txq_queues_mode = EFX_XDP_TX_QUEUES_BORROWED;
 		rc = pci_enable_msi(efx->pci_dev);
 		if (rc == 0) {
 			efx_get_channel(efx, 0)->irq = efx->pci_dev->irq;
@@ -322,6 +323,7 @@ int efx_probe_interrupts(struct efx_nic *efx)
 		efx->tx_channel_offset = efx_separate_tx_channels ? 1 : 0;
 		efx->n_xdp_channels = 0;
 		efx->xdp_channel_offset = efx->n_channels;
+		efx->xdp_txq_queues_mode = EFX_XDP_TX_QUEUES_BORROWED;
 		efx->legacy_irq = efx->pci_dev->irq;
 	}
 
diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
index 06ed74994e366..1776f7f8a7a90 100644
--- a/drivers/net/ethernet/sfc/siena/efx_channels.c
+++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
@@ -302,6 +302,7 @@ int efx_siena_probe_interrupts(struct efx_nic *efx)
 		efx->tx_channel_offset = 0;
 		efx->n_xdp_channels = 0;
 		efx->xdp_channel_offset = efx->n_channels;
+		efx->xdp_txq_queues_mode = EFX_XDP_TX_QUEUES_BORROWED;
 		rc = pci_enable_msi(efx->pci_dev);
 		if (rc == 0) {
 			efx_get_channel(efx, 0)->irq = efx->pci_dev->irq;
@@ -323,6 +324,7 @@ int efx_siena_probe_interrupts(struct efx_nic *efx)
 		efx->tx_channel_offset = efx_siena_separate_tx_channels ? 1 : 0;
 		efx->n_xdp_channels = 0;
 		efx->xdp_channel_offset = efx->n_channels;
+		efx->xdp_txq_queues_mode = EFX_XDP_TX_QUEUES_BORROWED;
 		efx->legacy_irq = efx->pci_dev->irq;
 	}
 
-- 
2.39.2



