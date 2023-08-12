Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0D77A1BB
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjHLSax (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjHLSax (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:30:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756AFE77
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C95C61D80
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180C0C433C7;
        Sat, 12 Aug 2023 18:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865055;
        bh=vnL5OEPN1Y9yu3vAuv5I9m8shMQK/vaElHNeXKMt8hY=;
        h=Subject:To:Cc:From:Date:From;
        b=0IceRVm4SxvJH/mUqbYu7vZ358VXv7XBEHrGytHsXr8zuPdUXfZ8ndjmeALizLn8E
         0JFoiejySbWR33Xz/tBRVmzfLy5lTpUFz0QG1dWshc60l2al+7IMsGpcMe4LcQNfEI
         fgeiXpvbGpmCvQWqvVM7u0GjOpnf5Xshuzz481LQ=
Subject: FAILED: patch "[PATCH] RDMA/bnxt_re: Fix error handling in probe failure path" failed to apply to 6.1-stable tree
To:     kalesh-anakkur.purayil@broadcom.com, jgg@nvidia.com,
        selvin.xavier@broadcom.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:30:52 +0200
Message-ID: <2023081252-worrisome-dirtiness-2fc8@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5ac8480ae4d01f0ca5dfd561884424046df2478a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081252-worrisome-dirtiness-2fc8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5ac8480ae4d0 ("RDMA/bnxt_re: Fix error handling in probe failure path")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5ac8480ae4d01f0ca5dfd561884424046df2478a Mon Sep 17 00:00:00 2001
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Date: Wed, 9 Aug 2023 21:44:36 -0700
Subject: [PATCH] RDMA/bnxt_re: Fix error handling in probe failure path

During bnxt_re_dev_init(), when bnxt_re_setup_chip_ctx() fails unregister
with L2 first before bailing out probe.

Fixes: ae8637e13185 ("RDMA/bnxt_re: Add chip context to identify 57500 series")
Link: https://lore.kernel.org/r/1691642677-21369-3-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1c7646057893..63e98e2d3596 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1253,6 +1253,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 wqe_mode)
 
 	rc = bnxt_re_setup_chip_ctx(rdev, wqe_mode);
 	if (rc) {
+		bnxt_unregister_dev(rdev->en_dev);
+		clear_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
 		return -EINVAL;
 	}

