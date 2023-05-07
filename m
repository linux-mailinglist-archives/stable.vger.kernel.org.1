Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54B16F9856
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 12:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjEGKz3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 06:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjEGKzS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 06:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA612096
        for <stable@vger.kernel.org>; Sun,  7 May 2023 03:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B5BA61B38
        for <stable@vger.kernel.org>; Sun,  7 May 2023 10:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592D8C433EF;
        Sun,  7 May 2023 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683456915;
        bh=2TORy+9vggZBDFKuaknUTZzKT4c5O70mT45uc3S84DE=;
        h=Subject:To:Cc:From:Date:From;
        b=ZluPhAZJs24PvHcxsXCrKlODlVdu69O6T9wFQ+CBBiwwCbUtsO1i6Fdk0zIOBJRFM
         K6LzC3BpOP/xt9Cq6zQ7G8Ddzz2SPsmF7dRaRB43u/dwPpdav/Un4xpOyWHwBV+hF9
         8MxhaOdzYOYxlXeyfWbttJVHh4cQwEFrU9PfhfSk=
Subject: FAILED: patch "[PATCH] mailbox: zynqmp: Fix counts of child nodes" failed to apply to 5.4-stable tree
To:     tanmay.shah@amd.com, mathieu.poirier@linaro.org,
        michal.simek@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 12:55:05 +0200
Message-ID: <2023050705-endorphin-manger-226f@gregkh>
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


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f72f805e72882c361e2a612c64a6e549f3da7152
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050705-endorphin-manger-226f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f72f805e7288 ("mailbox: zynqmp: Fix counts of child nodes")
043f85ce81cb ("mailbox: zynq: Switch to flexible array to simplify code")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f72f805e72882c361e2a612c64a6e549f3da7152 Mon Sep 17 00:00:00 2001
From: Tanmay Shah <tanmay.shah@amd.com>
Date: Fri, 10 Mar 2023 17:24:04 -0800
Subject: [PATCH] mailbox: zynqmp: Fix counts of child nodes

If child mailbox node status is disabled it causes
crash in interrupt handler. Fix this by assigning
only available child node during driver probe.

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230311012407.1292118-2-tanmay.shah@amd.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index a4c8d23c76e2..ae47fbac38d2 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -634,7 +634,12 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
 
-	num_mboxes = of_get_child_count(np);
+	num_mboxes = of_get_available_child_count(np);
+	if (num_mboxes == 0) {
+		dev_err(dev, "mailbox nodes not available\n");
+		return -EINVAL;
+	}
+
 	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
 			     GFP_KERNEL);
 	if (!pdata)

