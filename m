Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6377E070C
	for <lists+stable@lfdr.de>; Fri,  3 Nov 2023 17:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjKCQyH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 3 Nov 2023 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjKCQyG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 3 Nov 2023 12:54:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486071BF
        for <stable@vger.kernel.org>; Fri,  3 Nov 2023 09:54:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24F5C433C9;
        Fri,  3 Nov 2023 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699030443;
        bh=03QJ3PTCv+FjBj9S/gwPR8AYKtrdfz+IgTjZitD7WdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8DCkJ14x4w34x3tOqYXmmzrH6nPzt9hDkXcYILMc0TrCTMoTdEuBSnr5IkLwmiO4
         MWQh8LzkG2oulV82QJ58BrAF2eens8GmnG9gD1nPx4s3Kqo0QMTlswul857GXPBx2z
         6bPvSxA75lyF9BX1xYaNMLHFNULdewYizxlE1suD6FBl/wTmQ/R557SKvfu6H39aaU
         YebSBv9hHHEdpRvJpFVqULghgOsdnyuxyVGNjXhIyAaI0Sb4MSi77Vp+W4fua+qCub
         yqWlPcGYZYyzxOt2UuT7JajDm4SqRzOdihYAf8GAQo3Wj8u1bAzvCMnDqQl5qxxBPn
         2J3yheVPauoPw==
Date:   Fri, 3 Nov 2023 10:54:00 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Marek =?us-ascii?Q?Marczykowski-G'orecki?= 
        <marmarek@invisiblethingslab.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZUUlqJoS6_1IznzT@kbusch-mbp.dhcp.thefacebook.com>
References: <ZUB5HFeK3eHeI8UH@mail-itl>
 <20231031140136.25bio5wajc5pmdtl@quack3>
 <ZUEgWA5P8MFbyeBN@mail-itl>
 <8a35cdea-3a1a-e859-1f7c-55d1c864a48@redhat.com>
 <ebbc7ca7-5169-dbdc-9ea8-c6d8c3ae31e2@redhat.com>
 <ZULvkPhcpgAVyI8w@mail-itl>
 <ac5b5ac0-9e8-c1b0-a26-62f832f845f0@redhat.com>
 <ZUOL8kXVTF1OngeN@mail-itl>
 <3cb4133c-b6db-9187-a678-11ed8c9456e@redhat.com>
 <ZUUctamEFtAlSnSV@mail-itl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUUctamEFtAlSnSV@mail-itl>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 03, 2023 at 05:15:49PM +0100, Marek Marczykowski-G'orecki wrote:
> On Thu, Nov 02, 2023 at 06:06:33PM +0100, Mikulas Patocka wrote:
> > Then, try this patch (without "iommu=panic"), reproduce the deadlock and 
> > tell us which one of the "printk" statements is triggered during the 
> > deadlock.
> 
> The "821" one - see below.

Thanks for confirming!

Could you try this patch?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60a08dfe8d75f..348fd6c6702a5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -41,7 +41,7 @@
  * These can be higher, but we need to ensure that any command doesn't
  * require an sg allocation that needs more than a page of data.
  */
-#define NVME_MAX_KB_SZ	8192
+#define NVME_MAX_KB_SZ	8192u
 #define NVME_MAX_SEGS	128
 #define NVME_MAX_NR_ALLOCATIONS	5
 
@@ -2957,8 +2957,9 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * Limit the max command size to prevent iod->sg allocations going
 	 * over a single page.
 	 */
-	dev->ctrl.max_hw_sectors = min_t(u32,
-		NVME_MAX_KB_SZ << 1, dma_opt_mapping_size(&pdev->dev) >> 9);
+	dev->ctrl.max_hw_sectors = min3(NVME_MAX_KB_SZ << 1,
+					dma_opt_mapping_size(&pdev->dev) >> 9,
+					dma_max_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 
 	/*
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 946bd56f0ac53..0e6c6c25d154f 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -405,4 +405,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.get_sgtable = dma_common_get_sgtable,
 	.alloc_pages = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
+	.max_mapping_size = swiotlb_max_mapping_size,
 };
--
