Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4268779BB6E
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377464AbjIKW03 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240568AbjIKOrb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:47:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D7106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:47:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BDDC433C7;
        Mon, 11 Sep 2023 14:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443647;
        bh=1PBabzn6tRMoB2zOKbrufUQhmQk2t/MSSjXbGc+FYRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tCbUKJAefl9+Kdsei+zvPnxLSNi3sK+bUIDz/GPor3ycGgFDvpizTx40XmJ4PU4Ns
         3p7qH75Lkab8FEtHy/vuuGVOhpNxEl0JxiESeyIZoka+BPpQV0Kgt1lY4KhJlqoFMG
         40qiQOY/gdvFn6bPiBq1TX3VjSUBdOEDzROdhxmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: [PATCH 6.4 450/737] nvdimm: Fix memleak of pmu attr_groups in unregister_nvdimm_pmu()
Date:   Mon, 11 Sep 2023 15:45:09 +0200
Message-ID: <20230911134703.168898728@linuxfoundation.org>
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

[ Upstream commit 85ae42c72142346645e63c33835da947dfa008b3 ]

Memory pointed by 'nd_pmu->pmu.attr_groups' is allocated in function
'register_nvdimm_pmu' and is lost after 'kfree(nd_pmu)' call in function
'unregister_nvdimm_pmu'.

Fixes: 0fab1ba6ad6b ("drivers/nvdimm: Add perf interface to expose nvdimm performance stats")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Link: https://lore.kernel.org/r/20230817115945.771826-1-konstantin.meskhidze@huawei.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/nd_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
index 433bbb68ae641..14881c4e03e6b 100644
--- a/drivers/nvdimm/nd_perf.c
+++ b/drivers/nvdimm/nd_perf.c
@@ -324,6 +324,7 @@ void unregister_nvdimm_pmu(struct nvdimm_pmu *nd_pmu)
 {
 	perf_pmu_unregister(&nd_pmu->pmu);
 	nvdimm_pmu_free_hotplug_memory(nd_pmu);
+	kfree(nd_pmu->pmu.attr_groups);
 	kfree(nd_pmu);
 }
 EXPORT_SYMBOL_GPL(unregister_nvdimm_pmu);
-- 
2.40.1



