Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48E679BD22
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377605AbjIKW1g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbjIKOre (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:47:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA64106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:47:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08882C433C8;
        Mon, 11 Sep 2023 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443650;
        bh=rS05EBp3DPUD1sTFH7Dj8gQabQwSFyPV2yM4zyfKmU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKau2NN2AbrBgfbneRx1KMDDtK+skipZPUJ0HI3RHqnTTnEubnIdRSVR0ecOVQG3Y
         wjzqZBjPj0oD0gwpABcvttCTVxmR/BEqIW+B2ye6zWL2uv6Asci8qs4Pnu8F1qh6vS
         cWnWFwuTs3+R0IXiDTHKgPiQ3UNAbDJwaZdjiJ+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: [PATCH 6.4 451/737] nvdimm: Fix dereference after free in register_nvdimm_pmu()
Date:   Mon, 11 Sep 2023 15:45:10 +0200
Message-ID: <20230911134703.197479056@linuxfoundation.org>
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

From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

[ Upstream commit 08ca6906a4b7e48f8e93b7c1f49a742a415be6d5 ]

'nd_pmu->pmu.attr_groups' is dereferenced in function
'nvdimm_pmu_free_hotplug_memory' call after it has been freed. Because in
function 'nvdimm_pmu_free_hotplug_memory' memory pointed by the fields of
'nd_pmu->pmu.attr_groups' is deallocated it is necessary to call 'kfree'
after 'nvdimm_pmu_free_hotplug_memory'.

Fixes: 0fab1ba6ad6b ("drivers/nvdimm: Add perf interface to expose nvdimm performance stats")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Link: https://lore.kernel.org/r/20230817114103.754977-1-konstantin.meskhidze@huawei.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/nd_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
index 14881c4e03e6b..2b6dc80d8fb5b 100644
--- a/drivers/nvdimm/nd_perf.c
+++ b/drivers/nvdimm/nd_perf.c
@@ -308,8 +308,8 @@ int register_nvdimm_pmu(struct nvdimm_pmu *nd_pmu, struct platform_device *pdev)
 
 	rc = perf_pmu_register(&nd_pmu->pmu, nd_pmu->pmu.name, -1);
 	if (rc) {
-		kfree(nd_pmu->pmu.attr_groups);
 		nvdimm_pmu_free_hotplug_memory(nd_pmu);
+		kfree(nd_pmu->pmu.attr_groups);
 		return rc;
 	}
 
-- 
2.40.1



