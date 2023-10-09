Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB057BE09B
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376910AbjJINmD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377386AbjJINmB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:42:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB287CF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:41:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020CEC433C9;
        Mon,  9 Oct 2023 13:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858918;
        bh=L92vWIw7RMY336w4OqoWJsF7PpqF/1oPFTzm09x3dpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4IiIUTRcQhO14HcEAimG4o96Ka91BBklmLqLadeN+qTc1KMTNteEjxhh5sjAsyYY
         6YecBsF2Vp5mgFuDSd4NkzhAi4H1PHLOvMiY08fmTQCzd2HtKJJ2EHChRGJkpC4AF1
         pUX57e64Wsy8TBrwSqVy6IfTAfbE6Bzp0u17GI/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Irvin Cote <irvin.cote@insa-lyon.fr>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 141/226] nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev
Date:   Mon,  9 Oct 2023 15:01:42 +0200
Message-ID: <20231009130130.420530709@linuxfoundation.org>
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

From: Irvin Cote <irvin.cote@insa-lyon.fr>

[ Upstream commit dc785d69d753a3894c93afc23b91404652382ead ]

Don't mix NULL and ERR_PTR returns.

Fixes: 2e87570be9d2 ("nvme-pci: factor out a nvme_pci_alloc_dev helper")
Signed-off-by: Irvin Cote <irvin.cote@insa-lyon.fr>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7bb42d0e087af..9c67ebd4eac38 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2868,7 +2868,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	mutex_init(&dev->shutdown_lock);
@@ -2913,8 +2913,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int result = -ENOMEM;
 
 	dev = nvme_pci_alloc_dev(pdev, id);
-	if (!dev)
-		return -ENOMEM;
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
 
 	result = nvme_dev_map(dev);
 	if (result)
-- 
2.40.1



