Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328157BE096
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377364AbjJINlp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377359AbjJINlo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:41:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14AC9D
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:41:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D21BC433C9;
        Mon,  9 Oct 2023 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858902;
        bh=fYBUdu+weEcWuuLlxuatkuYVnvz4mfeu3d1Xuolck00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjPUosFUFlpoTJ7v96brDIqsdpY95+ksSr5TFM+SthpYTXontMAdCuJEtKS4YRT7a
         l872qqSybtUWnLlwRenvM0YX10sFsFjR8FTEMyentHOOlN1irSqvlxMvoRWHOTNc4J
         jly4eS2Ko2jJbVcXfp+mIAfRe/9SrKAXGUQUxsAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pratyush Yadav <ptyadav@amazon.de>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 136/226] nvme-pci: do not set the NUMA node of device if it has none
Date:   Mon,  9 Oct 2023 15:01:37 +0200
Message-ID: <20231009130130.303193008@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index c329f73dbbf38..7bb42d0e087af 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2866,9 +2866,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
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



