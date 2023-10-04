Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2047B88CE
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243881AbjJDSTm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243882AbjJDSTl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8FFAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:19:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62287C433C9;
        Wed,  4 Oct 2023 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443576;
        bh=B/0j9mIX42mBnzZyT4rOUdoUXeiD6SuhIzzBG3YHMT0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLO/1YAUewvoGf7onazhFWsiZgteWdFT/lo1fhe2oTbUBUrWLl1kOfZ48IrRmM/LJ
         tNXStc/VieDJn7kVMNXxy8og4OM0nSgw2eDDtrgooC40B3jPUpwJ7abBHfwaCcXuz0
         lOsSPSF469PGKty/WPE8tmcN7ePEcY7B+CKZTUM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Irvin Cote <irvin.cote@insa-lyon.fr>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 205/259] nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev
Date:   Wed,  4 Oct 2023 19:56:18 +0200
Message-ID: <20231004175226.684722858@linuxfoundation.org>
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
index f28f50ea273a9..64990a2cfd0a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3117,7 +3117,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	mutex_init(&dev->shutdown_lock);
@@ -3162,8 +3162,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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



