Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FFE7ECD73
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjKOTgl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjKOTgi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C98E1AD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D3FC433C7;
        Wed, 15 Nov 2023 19:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076994;
        bh=b93Dx92s0SjCfe13HMd/eAvselD1++HxnDBzHkhKB1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yo+ytvlpNdIvez6+RwLbpjBvBEbMykrKC6kYNdY1l7QXoOgfze5SzVZoG/vUPviJO
         h5xs28OtcriwHcnMpzopGdw2IlRys9FPjQ01ThTzwbM1DrjKOVhnZJumJ6wAKLp7nr
         JX62W5ywlncV8pUw1dkn9njDPjbLrNJRB3lIlu6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Li Zhijian <lizhijian@fujitsu.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 464/550] cxl/region: Fix cxl_region_rwsem lock held when returning to user space
Date:   Wed, 15 Nov 2023 14:17:28 -0500
Message-ID: <20231115191633.032448299@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit 3531b27f1f04a6bc9c95cf00d40efe618d57aa93 ]

Fix a missed "goto out" to unlock on error to cleanup this splat:

    WARNING: lock held when returning to user space!
    6.6.0-rc3-lizhijian+ #213 Not tainted
    ------------------------------------------------
    cxl/673 is leaving the kernel with locks still held!
    1 lock held by cxl/673:
     #0: ffffffffa013b9d0 (cxl_region_rwsem){++++}-{3:3}, at: commit_store+0x7d/0x3e0 [cxl_core]

In terms of user visible impact of this bug for backports:

cxl_region_invalidate_memregion() on x86 invokes wbinvd which is a
problematic instruction for virtualized environments. So, on virtualized
x86, cxl_region_invalidate_memregion() returns an error. This failure
case got missed because CXL memory-expander device passthrough is not a
production use case, and emulation of CXL devices is typically limited
to kernel development builds with CONFIG_CXL_REGION_INVALIDATION_TEST=y,
that makes cxl_region_invalidate_memregion() succeed.

In other words, the expected exposure of this bug is limited to CXL
subsystem development environments using QEMU that neglected
CONFIG_CXL_REGION_INVALIDATION_TEST=y.

Fixes: d1257d098a5a ("cxl/region: Move cache invalidation before region teardown, and before setup")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://lore.kernel.org/r/20231025085450.2514906-1-lizhijian@fujitsu.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 89d24cd71606e..7392206eb8699 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -288,7 +288,7 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
 	 */
 	rc = cxl_region_invalidate_memregion(cxlr);
 	if (rc)
-		return rc;
+		goto out;
 
 	if (commit) {
 		rc = cxl_region_decode_commit(cxlr);
-- 
2.42.0



