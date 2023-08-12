Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D577A1BC
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 20:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjHLSbC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHLSbC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 14:31:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F37D19A4
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 11:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8B0961D84
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 18:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60E0C433C7;
        Sat, 12 Aug 2023 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691865064;
        bh=GnLGEJdVYP/9cKPfAonlx9Icp+vWrl1S5R7S0bnLmQU=;
        h=Subject:To:Cc:From:Date:From;
        b=d6N+HYem74Yc63zH5l/8MeaUN3PWWJI4E4gBf1OQdmYIrURrSuzGThZe5V8ffo3xo
         qhm61gcKOBTnAAV4kVOL4ZlZ74+GBFDqG4u2i03ezCSWHPwcnVqXLy/v4YSGfkagHL
         2rU0+09bP05k9YSxi+JLEiHorP34R9pCzdCSqIPE=
Subject: FAILED: patch "[PATCH] RDMA/bnxt_re: Fix error handling in probe failure path" failed to apply to 5.10-stable tree
To:     kalesh-anakkur.purayil@broadcom.com, jgg@nvidia.com,
        selvin.xavier@broadcom.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 12 Aug 2023 20:30:53 +0200
Message-ID: <2023081253-unsavory-uncheck-72dd@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5ac8480ae4d01f0ca5dfd561884424046df2478a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023081253-unsavory-uncheck-72dd@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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

