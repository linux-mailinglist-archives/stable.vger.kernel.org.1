Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F077A1D2
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHLSfw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLSfv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:35:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451010C2
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D7C561E40
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD191C433C7;
        Sat, 12 Aug 2023 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865354;
        bh=D52lGVX2e6Gwfyvte34eQTZ+aLv2wVGzG0Eq2+eDo9Q=;
        h=Subject:To:Cc:From:Date:From;
        b=meNvG1ezqggLez7MNfvLVAlYkPnp8u4Gx8qmSfT9/rDo8tnib0IGCc4MIVBfi/D2k
         rR/zneuGG++W8GAFxsvpIeS3PvnZNfPdEuYUYgwfwAV+yWmwABwowxQ2XfwrzViEEv
         ZDoqJDBxPJjkVPt449Ib+4cY7tHJ5+TPTRYk3jE4=
Subject: FAILED: patch "[PATCH] net/mlx5: Skip clock update work when device is in error" failed to apply to 4.19-stable tree
To:     moshe@nvidia.com, ayal@nvidia.com, ganeshgr@linux.ibm.com,
        saeedm@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:35:47 +0200
Message-ID: <2023081247-enrich-coliseum-0e9d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x d006207625657322ba8251b6e7e829f9659755dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081247-enrich-coliseum-0e9d@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

d00620762565 ("net/mlx5: Skip clock update work when device is in error state")
d6f3dc8f509c ("net/mlx5: Move all internal timer metadata into a dedicated struct")
1436de0b9915 ("net/mlx5: Refactor init clock function")
fb609b5112bd ("net/mlx5: Always use container_of to find mdev pointer from clock struct")
ed56d749c366 ("net/mlx5: Query PPS pin operational status before registering it")
88c8cf92db48 ("net/mlx5: Fix a bug of using ptp channel index as pin index")
ddcdc368b103 ("RDMA/mlx5: Use get_zeroed_page() for clock_info")
4a0475d57ad1 ("mlx5: extend PTP gettime function to read system clock")
5d8678365c90 ("mlx5: update timecounter at least twice per counter overflow")
41069256e930 ("net/mlx5: Clock, Use async events chain")
a52a7d01fde1 ("net/mlx5: FPGA, Use async events chain")
da19a102ce87 ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d006207625657322ba8251b6e7e829f9659755dc Mon Sep 17 00:00:00 2001
From: Moshe Shemesh <moshe@nvidia.com>
Date: Wed, 19 Jul 2023 11:33:44 +0300
Subject: [PATCH] net/mlx5: Skip clock update work when device is in error
 state

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

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 973babfaff25..377372f0578a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -227,10 +227,15 @@ static void mlx5_timestamp_overflow(struct work_struct *work)
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
 

