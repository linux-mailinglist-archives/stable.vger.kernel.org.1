Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9017A3C20
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjIQU1N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240890AbjIQU0n (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:26:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90A810B
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:26:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A689C433C8;
        Sun, 17 Sep 2023 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982397;
        bh=WlkbM/y4MgXfnBX7TtBPeiqWsHjeB5ARgIvN+s7wJXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ykI5P8yvdUWCOAQ0SKiDUnZJJN5QHWRzv6trVe1yyg/zFtttYzGbTDk1esV3RHEND
         LAQGTOYmZcT/yNWV5dEaUYdxVffydWdKbCi5Y/TFGCa742ZtYNBdczM9nNrxY/KwPV
         OzHkIukTbBCBNKOxDzHkfVEdsPMyMkmtQQnIhA2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Daniel Marcovitch <dmarcovitch@nvidia.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 238/511] iommu/amd/iommu_v2: Fix pasid_state refcount dec hit 0 warning on pasid unbind
Date:   Sun, 17 Sep 2023 21:11:05 +0200
Message-ID: <20230917191119.561169514@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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
index c96cf9b217197..29a3a62b7a3ac 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -264,8 +264,8 @@ static void put_pasid_state(struct pasid_state *pasid_state)
 
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



