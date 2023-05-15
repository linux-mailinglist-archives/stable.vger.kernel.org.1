Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D411703614
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbjEORGN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbjEORFu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:05:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2D16A74
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E96262A71
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C48EC4339B;
        Mon, 15 May 2023 17:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170257;
        bh=tNeEEp2LzwwdK64OimRkCqQZ1myENsl9Yb4d5zpEyt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8zGloeYLxk/ZLSis62EH8X/xmWWS/9HHwl3L0u1eyr7bU1TP2eSsNWdLS9OOuzwq
         Ud3HF10yyscOgNRIgcqwj8qR2yP7m8Bw5Qhp8RsKba7GsROnYZcrWU4AUro/u1nG67
         bjf/6vZ9rzt8AJ1Qk03L69dtceO5hUjyFTU7c73Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ratheesh Kannoth <rkannoth@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Sai Krishna <saikrishnag@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 073/239] octeontx2-af: Skip PFs if not enabled
Date:   Mon, 15 May 2023 18:25:36 +0200
Message-Id: <20230515161723.878865935@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ratheesh Kannoth <rkannoth@marvell.com>

[ Upstream commit 5eb1b7220948a69298a436148a735f32ec325289 ]

Firmware enables PFs and allocate mbox resources for each of the PFs.
Currently PF driver configures mbox resources without checking whether
PF is enabled or not. This results in crash. This patch fixes this issue
by skipping disabled PF's mbox initialization.

Fixes: 9bdc47a6e328 ("octeontx2-af: Mbox communication support btw AF and it's VFs")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.c  |  5 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  3 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 49 +++++++++++++++----
 3 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
index 2898931d5260a..9690ac01f02c8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.c
@@ -157,7 +157,7 @@ EXPORT_SYMBOL(otx2_mbox_init);
  */
 int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
 			   struct pci_dev *pdev, void *reg_base,
-			   int direction, int ndevs)
+			   int direction, int ndevs, unsigned long *pf_bmap)
 {
 	struct otx2_mbox_dev *mdev;
 	int devid, err;
@@ -169,6 +169,9 @@ int otx2_mbox_regions_init(struct otx2_mbox *mbox, void **hwbase,
 	mbox->hwbase = hwbase[0];
 
 	for (devid = 0; devid < ndevs; devid++) {
+		if (!test_bit(devid, pf_bmap))
+			continue;
+
 		mdev = &mbox->dev[devid];
 		mdev->mbase = hwbase[devid];
 		mdev->hwbase = hwbase[devid];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 5921a78661e41..11eeb36cf9a54 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -96,9 +96,10 @@ void otx2_mbox_destroy(struct otx2_mbox *mbox);
 int otx2_mbox_init(struct otx2_mbox *mbox, void __force *hwbase,
 		   struct pci_dev *pdev, void __force *reg_base,
 		   int direction, int ndevs);
+
 int otx2_mbox_regions_init(struct otx2_mbox *mbox, void __force **hwbase,
 			   struct pci_dev *pdev, void __force *reg_base,
-			   int direction, int ndevs);
+			   int direction, int ndevs, unsigned long *bmap);
 void otx2_mbox_msg_send(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_wait_for_rsp(struct otx2_mbox *mbox, int devid);
 int otx2_mbox_busy_poll_for_rsp(struct otx2_mbox *mbox, int devid);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 3f5e09b77d4bd..873f081c030de 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2274,7 +2274,7 @@ static inline void rvu_afvf_mbox_up_handler(struct work_struct *work)
 }
 
 static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
-				int num, int type)
+				int num, int type, unsigned long *pf_bmap)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	int region;
@@ -2286,6 +2286,9 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	 */
 	if (type == TYPE_AFVF) {
 		for (region = 0; region < num; region++) {
+			if (!test_bit(region, pf_bmap))
+				continue;
+
 			if (hw->cap.per_pf_mbox_regs) {
 				bar4 = rvu_read64(rvu, BLKADDR_RVUM,
 						  RVU_AF_PFX_BAR4_ADDR(0)) +
@@ -2307,6 +2310,9 @@ static int rvu_get_mbox_regions(struct rvu *rvu, void **mbox_addr,
 	 * RVU_AF_PF_BAR4_ADDR register.
 	 */
 	for (region = 0; region < num; region++) {
+		if (!test_bit(region, pf_bmap))
+			continue;
+
 		if (hw->cap.per_pf_mbox_regs) {
 			bar4 = rvu_read64(rvu, BLKADDR_RVUM,
 					  RVU_AF_PFX_BAR4_ADDR(region));
@@ -2335,20 +2341,41 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	int err = -EINVAL, i, dir, dir_up;
 	void __iomem *reg_base;
 	struct rvu_work *mwork;
+	unsigned long *pf_bmap;
 	void **mbox_regions;
 	const char *name;
+	u64 cfg;
 
-	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
-	if (!mbox_regions)
+	pf_bmap = bitmap_zalloc(num, GFP_KERNEL);
+	if (!pf_bmap)
 		return -ENOMEM;
 
+	/* RVU VFs */
+	if (type == TYPE_AFVF)
+		bitmap_set(pf_bmap, 0, num);
+
+	if (type == TYPE_AFPF) {
+		/* Mark enabled PFs in bitmap */
+		for (i = 0; i < num; i++) {
+			cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(i));
+			if (cfg & BIT_ULL(20))
+				set_bit(i, pf_bmap);
+		}
+	}
+
+	mbox_regions = kcalloc(num, sizeof(void *), GFP_KERNEL);
+	if (!mbox_regions) {
+		err = -ENOMEM;
+		goto free_bitmap;
+	}
+
 	switch (type) {
 	case TYPE_AFPF:
 		name = "rvu_afpf_mailbox";
 		dir = MBOX_DIR_AFPF;
 		dir_up = MBOX_DIR_AFPF_UP;
 		reg_base = rvu->afreg_base;
-		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF);
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFPF, pf_bmap);
 		if (err)
 			goto free_regions;
 		break;
@@ -2357,7 +2384,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		dir = MBOX_DIR_PFVF;
 		dir_up = MBOX_DIR_PFVF_UP;
 		reg_base = rvu->pfreg_base;
-		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF);
+		err = rvu_get_mbox_regions(rvu, mbox_regions, num, TYPE_AFVF, pf_bmap);
 		if (err)
 			goto free_regions;
 		break;
@@ -2388,16 +2415,19 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 	}
 
 	err = otx2_mbox_regions_init(&mw->mbox, mbox_regions, rvu->pdev,
-				     reg_base, dir, num);
+				     reg_base, dir, num, pf_bmap);
 	if (err)
 		goto exit;
 
 	err = otx2_mbox_regions_init(&mw->mbox_up, mbox_regions, rvu->pdev,
-				     reg_base, dir_up, num);
+				     reg_base, dir_up, num, pf_bmap);
 	if (err)
 		goto exit;
 
 	for (i = 0; i < num; i++) {
+		if (!test_bit(i, pf_bmap))
+			continue;
+
 		mwork = &mw->mbox_wrk[i];
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_handler);
@@ -2406,8 +2436,7 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		mwork->rvu = rvu;
 		INIT_WORK(&mwork->work, mbox_up_handler);
 	}
-	kfree(mbox_regions);
-	return 0;
+	goto free_regions;
 
 exit:
 	destroy_workqueue(mw->mbox_wq);
@@ -2416,6 +2445,8 @@ static int rvu_mbox_init(struct rvu *rvu, struct mbox_wq_info *mw,
 		iounmap((void __iomem *)mbox_regions[num]);
 free_regions:
 	kfree(mbox_regions);
+free_bitmap:
+	bitmap_free(pf_bmap);
 	return err;
 }
 
-- 
2.39.2



