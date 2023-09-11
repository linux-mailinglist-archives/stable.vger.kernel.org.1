Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FCA79B8F2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbjIKU65 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjIKOio (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:38:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6752F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:38:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D5DC433C8;
        Mon, 11 Sep 2023 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443119;
        bh=0wUp5NXJg/U5Tqf1sqPElWqWo2bGZifKvuwE9KXna7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1u7AQmIhO3MJf6XBLOy2LXTuy7iWFLDs1Nrt7GTB4iVYhKlXbVjEeV3iVU8OVK2BY
         /Gc2bzDORYVvAK3JMsC8zdAfx4hbvRIT6CEiDBB2IBntrTTQYSk/6DR9qkLxnJlKjs
         AEhJ+cpQN/Hcdca4uMKLwxnSn1yaENsix7LtQv/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 264/737] pds_core: check for work queue before use
Date:   Mon, 11 Sep 2023 15:42:03 +0200
Message-ID: <20230911134657.961329804@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit 969cfd4c8ca50c32901342cdd3d677c3ffe61371 ]

Add a check that the wq exists before queuing up work for a
failed devcmd, as the PF is responsible for health and the VF
doesn't have a wq.

Fixes: c2dbb0904310 ("pds_core: health timer and workqueue")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230824161754.34264-5-shannon.nelson@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index debe5216fe29e..524f422ee7ace 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -183,7 +183,7 @@ int pdsc_devcmd_locked(struct pdsc *pdsc, union pds_core_dev_cmd *cmd,
 	err = pdsc_devcmd_wait(pdsc, max_seconds);
 	memcpy_fromio(comp, &pdsc->cmd_regs->comp, sizeof(*comp));
 
-	if (err == -ENXIO || err == -ETIMEDOUT)
+	if ((err == -ENXIO || err == -ETIMEDOUT) && pdsc->wq)
 		queue_work(pdsc->wq, &pdsc->health_work);
 
 	return err;
-- 
2.40.1



