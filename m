Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1A7B87CB
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243869AbjJDSJ1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243874AbjJDSJZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD4A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:09:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC065C433C7;
        Wed,  4 Oct 2023 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442961;
        bh=pFMhO7DTS2A3Cm/0/l5hAh6womCS9Lt8jjCkj5nbqxw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szqX+Mj1Ux2JZlAwiGAabjhmFHen0ublKj5PNib41tqFEv1nieO0uZM2zpQWb4+OE
         +9zr9rlAfAqCVqxfSQeM5fg//12KG1p+V2VySVWriuXyuCZqyffypWKYvjrNFfCkAc
         8s8hovsysyTage5M+zJiMw2laTAxVmnMfhYO3d24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Irvin Cote <irvin.cote@insa-lyon.fr>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 153/183] nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev
Date:   Wed,  4 Oct 2023 19:56:24 +0200
Message-ID: <20231004175210.427857493@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index e5980df2094ad..65172a654a198 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2977,7 +2977,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	mutex_init(&dev->shutdown_lock);
@@ -3022,8 +3022,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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



