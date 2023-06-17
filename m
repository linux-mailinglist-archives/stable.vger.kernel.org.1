Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2D733F93
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbjFQIS3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346126AbjFQIS2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:18:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B7A173A
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E2B760DCA
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF84C433C0;
        Sat, 17 Jun 2023 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686989906;
        bh=hGZ8edJTaKv8yKyXRQ3OOeFDHQyuT5RwyLRfTZm0Z0I=;
        h=Subject:To:Cc:From:Date:From;
        b=wb7nRR4nKu4Tb9k1vqO/1xaP7E8xzMPPxL4G6M77xaoggAvJ8Uzu2h8Q8lh2a6OTc
         qCdyElsjes33dcwnEj8+vYODskQ1cLrP2gDSo+flVQd8Ao5/vyJSel05KuZvPcOtii
         EgKQgDJ0YmH2hTnmqpYoXKkWQS8lSrkWeDxWTDzY=
Subject: FAILED: patch "[PATCH] RDMA/uverbs: Restrict usage of privileged QKEYs" failed to apply to 4.14-stable tree
To:     edwards@nvidia.com, leon@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 17 Jun 2023 10:18:23 +0200
Message-ID: <2023061723-greedily-gorged-743b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x 0cadb4db79e1d9eea66711c4031e435c2191907e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061723-greedily-gorged-743b@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0cadb4db79e1d9eea66711c4031e435c2191907e Mon Sep 17 00:00:00 2001
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 5 Jun 2023 13:33:24 +0300
Subject: [PATCH] RDMA/uverbs: Restrict usage of privileged QKEYs

According to the IB specification rel-1.6, section 3.5.3:
"QKEYs with the most significant bit set are considered controlled
QKEYs, and a HCA does not allow a consumer to arbitrarily specify a
controlled QKEY."

Thus, block non-privileged users from setting such a QKEY.

Cc: stable@vger.kernel.org
Fixes: bc38a6abdd5a ("[PATCH] IB uverbs: core implementation")
Signed-off-by: Edward Srouji <edwards@nvidia.com>
Link: https://lore.kernel.org/r/c00c809ddafaaf87d6f6cb827978670989a511b3.1685960567.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4796f6a8828c..e836c9c477f6 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1850,8 +1850,13 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		attr->path_mtu = cmd->base.path_mtu;
 	if (cmd->base.attr_mask & IB_QP_PATH_MIG_STATE)
 		attr->path_mig_state = cmd->base.path_mig_state;
-	if (cmd->base.attr_mask & IB_QP_QKEY)
+	if (cmd->base.attr_mask & IB_QP_QKEY) {
+		if (cmd->base.qkey & IB_QP_SET_QKEY && !capable(CAP_NET_RAW)) {
+			ret = -EPERM;
+			goto release_qp;
+		}
 		attr->qkey = cmd->base.qkey;
+	}
 	if (cmd->base.attr_mask & IB_QP_RQ_PSN)
 		attr->rq_psn = cmd->base.rq_psn;
 	if (cmd->base.attr_mask & IB_QP_SQ_PSN)

