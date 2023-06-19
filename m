Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08507353C5
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjFSKsj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjFSKsQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DF01733
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:47:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 171F760B4B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8C7C433C8;
        Mon, 19 Jun 2023 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171671;
        bh=xUIZ23c+3tN02lO0oTMrtSf2owuRlG5/4NrqvimrJLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sf/bqOiug+Qlp44tmApUdlY5RDwoMfDaesz0mz0oFNpptnsUgoD9wTjtbt7F6CQSu
         Tdmia8Ix91SSPEYCZTalYQOBjb2HkzW0dXdkIadgtf2F0IIdZfFx7A0scT7f2aVm6O
         x9hw9eTdY7hFrhDg+4HaQgH6vNDiP6yk8uClBvH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pengfei Xu <pengfei.xu@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.1 078/166] thunderbolt: dma_test: Use correct value for absent rings when creating paths
Date:   Mon, 19 Jun 2023 12:29:15 +0200
Message-ID: <20230619102158.581101567@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 70c2e03e9aaf17496c63f6e42333c012f5ae5307 upstream.

Both tb_xdomain_enable_paths() and tb_xdomain_disable_paths() expect -1,
not 0, if the corresponding ring is not needed. For this reason change
the driver to use correct value for the rings that are not needed.

Fixes: 180b0689425c ("thunderbolt: Allow multiple DMA tunnels over a single XDomain connection")
Cc: stable@vger.kernel.org
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/dma_test.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/thunderbolt/dma_test.c
+++ b/drivers/thunderbolt/dma_test.c
@@ -192,9 +192,9 @@ static int dma_test_start_rings(struct d
 	}
 
 	ret = tb_xdomain_enable_paths(dt->xd, dt->tx_hopid,
-				      dt->tx_ring ? dt->tx_ring->hop : 0,
+				      dt->tx_ring ? dt->tx_ring->hop : -1,
 				      dt->rx_hopid,
-				      dt->rx_ring ? dt->rx_ring->hop : 0);
+				      dt->rx_ring ? dt->rx_ring->hop : -1);
 	if (ret) {
 		dma_test_free_rings(dt);
 		return ret;
@@ -218,9 +218,9 @@ static void dma_test_stop_rings(struct d
 		tb_ring_stop(dt->tx_ring);
 
 	ret = tb_xdomain_disable_paths(dt->xd, dt->tx_hopid,
-				       dt->tx_ring ? dt->tx_ring->hop : 0,
+				       dt->tx_ring ? dt->tx_ring->hop : -1,
 				       dt->rx_hopid,
-				       dt->rx_ring ? dt->rx_ring->hop : 0);
+				       dt->rx_ring ? dt->rx_ring->hop : -1);
 	if (ret)
 		dev_warn(&dt->svc->dev, "failed to disable DMA paths\n");
 


