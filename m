Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECABA77A19A
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjHLSDu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLSDu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9A3CC
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:03:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFF8661D40
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED146C433C8;
        Sat, 12 Aug 2023 18:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691863432;
        bh=W9cjOBQ3KkfnqZVjTj0uhtDb/DC/f8+ilwSG01sZexg=;
        h=Subject:To:Cc:From:Date:From;
        b=zGaasV1M7YxmXjxCTYGygeyQQXfyu1CX9ddbsJfpPaWH7cTQpZceH2YRfwvOQ+w9M
         EA0WcCc/7bRV5HUEAMudmczr0Xf8KBOG32EGB1RXT/QOe0U01We/wa8PWlygPQUx84
         NVomrMwg3+WrEq/64QERjaKu9yz9x2nR4p34TMsk=
Subject: FAILED: patch "[PATCH] RDMA/bnxt_re: Fix error handling in probe failure path" failed to apply to 5.4-stable tree
To:     kalesh-anakkur.purayil@broadcom.com, jgg@nvidia.com,
        selvin.xavier@broadcom.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:03:45 +0200
Message-ID: <2023081245-reformer-contort-e4c5@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 5ac8480ae4d01f0ca5dfd561884424046df2478a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081245-reformer-contort-e4c5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

5ac8480ae4d0 ("RDMA/bnxt_re: Fix error handling in probe failure path")
6ccad8483b28 ("RDMA/bnxt_re: use ibdev based message printing functions")
8dae419f9ec7 ("RDMA/bnxt_re: Refactor queue pair creation code")
9a4467a6b282 ("RDMA/bnxt_re: Avoid freeing MR resources if dereg fails")

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

