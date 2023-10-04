Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959DA7B88CA
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243691AbjJDST3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbjJDST2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FA298
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:19:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDC5C433C7;
        Wed,  4 Oct 2023 18:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443565;
        bh=ONvQbaegzO+f6hTgrVsRbLp0mOwm4lbuCy+6+JcqIIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CX74sgtpCVKVu+up8Gs8z7KL05tYBLtkYfGd9J+DZUNQ+ufxk25o/07IZFOZvyS8H
         BAyr/YSlH61efXTq5u78D9uzhS2UxNJtAAKzYor8FuZ/mG/vd68khZBmC5SLmZE4Sq
         zCgzIJPL/6tzfT2ad3wHss7emQ1POMRtC1ka0w5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pratyush Yadav <ptyadav@amazon.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 202/259] nvme-pci: do not set the NUMA node of device if it has none
Date:   Wed,  4 Oct 2023 19:56:15 +0200
Message-ID: <20231004175226.541149057@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pratyush Yadav <ptyadav@amazon.de>

[ Upstream commit dad651b2a44eb6b201738f810254279dca29d30d ]

If a device has no NUMA node information associated with it, the driver
puts the device in node first_memory_node (say node 0). Not having a
NUMA node and being associated with node 0 are completely different
things and it makes little sense to mix the two.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 42e85b1bf6591..f28f50ea273a9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3115,9 +3115,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
-
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return NULL;
-- 
2.40.1



