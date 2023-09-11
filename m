Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3CE79B94C
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241716AbjIKVHR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240623AbjIKOtL (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:49:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89615E40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:49:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD457C433C8;
        Mon, 11 Sep 2023 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443747;
        bh=suNk0lVzZt0fSPMhuawZe77TckFn+lkBv0b+GC2W4Xs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ybd4pMNaxjRSkLqFdnBdLmN96lRZIEVQFIBHPrEZqwNUtYM0BpPvGvwBBng56AzoQ
         StTH4qXLKl66MGjBa26WvFIC4QeXhRU4Po65HpOO33DXsECFtLu8wl2VRraMVCEV20
         RH96X5w3pGqTrVIAcyFYB2gZlnDoOAIwD3nw/j3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Daniel Marcovitch <dmarcovitch@nvidia.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 485/737] iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind
Date:   Mon, 11 Sep 2023 15:45:44 +0200
Message-ID: <20230911134704.125116921@linuxfoundation.org>
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

From: Daniel Marcovitch <dmarcovitch@nvidia.com>

[ Upstream commit 534103bcd52ca9c1fecbc70e717b4a538dc4ded8 ]

When unbinding pasid - a race condition exists vs outstanding page faults.

To prevent this, the pasid_state object contains a refcount.
    * set to 1 on pasid bind
    * incremented on each ppr notification start
    * decremented on each ppr notification done
    * decremented on pasid unbind

Since refcount_dec assumes that refcount will never reach 0:
  the current implementation causes the following to be invoked on
  pasid unbind:
        REFCOUNT_WARN("decrement hit 0; leaking memory")

Fix this issue by changing refcount_dec to refcount_dec_and_test
to explicitly handle refcount=1.

Fixes: 8bc54824da4e ("iommu/amd: Convert from atomic_t to refcount_t on pasid_state->count")
Signed-off-by: Daniel Marcovitch <dmarcovitch@nvidia.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Link: https://lore.kernel.org/r/20230609105146.7773-2-vasant.hegde@amd.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd/iommu_v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 261352a232716..65d78d7e04408 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -262,8 +262,8 @@ static void put_pasid_state(struct pasid_state *pasid_state)
 
 static void put_pasid_state_wait(struct pasid_state *pasid_state)
 {
-	refcount_dec(&pasid_state->count);
-	wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
+	if (!refcount_dec_and_test(&pasid_state->count))
+		wait_event(pasid_state->wq, !refcount_read(&pasid_state->count));
 	free_pasid_state(pasid_state);
 }
 
-- 
2.40.1



