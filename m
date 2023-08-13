Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF3E77AD43
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHMVsS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjHMVpg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5282D61
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E1460B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B735EC433C8;
        Sun, 13 Aug 2023 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963135;
        bh=CoKHGRGzilooxH2zKSZSKs2c3F9n7IFcksP9FV/HbFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2MCUxemLZczA+Z1Wq5HRomQVNfMQgLJwLV8aRdd906aSNM72CTQLgmcE/qu3ypbn0
         bwMDwvHXfOvL/YTMAVKgfp3KrvTGi+Iu44Q0XjBGUW5fOpSpTS11hHkNbFvEutYBpj
         /qhf9ZqIRD7jte0ymXhMVP17NyrxIlvGzBzZardE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moshe Shemesh <moshe@nvidia.com>,
        Aya Levin <ayal@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ganesh G R <ganeshgr@linux.ibm.com>
Subject: [PATCH 5.15 66/89] net/mlx5: Skip clock update work when device is in error state
Date:   Sun, 13 Aug 2023 23:19:57 +0200
Message-ID: <20230813211712.761559739@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

commit d006207625657322ba8251b6e7e829f9659755dc upstream.

When device is in error state, marked by the flag
MLX5_DEVICE_STATE_INTERNAL_ERROR, the HW and PCI may not be accessible
and so clock update work should be skipped. Furthermore, such access
through PCI in error state, after calling mlx5_pci_disable_device() can
result in failing to recover from pci errors.

Fixes: ef9814deafd0 ("net/mlx5e: Add HW timestamping (TS) support")
Reported-and-tested-by: Ganesh G R <ganeshgr@linux.ibm.com>
Closes: https://lore.kernel.org/netdev/9bdb9b9d-140a-7a28-f0de-2e64e873c068@nvidia.com
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -189,10 +189,15 @@ static void mlx5_timestamp_overflow(stru
 	clock = container_of(timer, struct mlx5_clock, timer);
 	mdev = container_of(clock, struct mlx5_core_dev, clock);
 
+	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		goto out;
+
 	write_seqlock_irqsave(&clock->lock, flags);
 	timecounter_read(&timer->tc);
 	mlx5_update_clock_info_page(mdev);
 	write_sequnlock_irqrestore(&clock->lock, flags);
+
+out:
 	schedule_delayed_work(&timer->overflow_work, timer->overflow_period);
 }
 


