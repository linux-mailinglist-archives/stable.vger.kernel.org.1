Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC27E2384
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjKFNM0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjKFNMZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:12:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C983125
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:12:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C014DC433C8;
        Mon,  6 Nov 2023 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276342;
        bh=8PV/5/SRWlxR1xQA83hFuYLvGyRRLaZH2JzhM2Gm59o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zTcVbQ7WiZycxm+VqthCJI3jOuawOovtOakP7ReU3Gd36wmXHLl4LWD0DvDSagMvk
         k1eNtmLV3fRgtkSmq1g/EiiePRLhQmX9EssVFzhpSvhVNsscX9cOYpwjxLmNSz4Vrz
         WgbdT5/O+ztho/FtDBVAIaKQ+Xf++ZblKZgesUIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 02/62] coresight: tmc-etr: Disable warnings for allocation failures
Date:   Mon,  6 Nov 2023 14:03:08 +0100
Message-ID: <20231106130301.893382283@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit e5028011885a85032aa3c1b7e3e493bcdacb4a0a ]

Running the following command on Juno triggers the warning:

 $ perf record -e cs_etm// -m ,128M ...

 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 412 at mm/page_alloc.c:4453 __alloc_pages+0x334/0x1420
 CPU: 1 PID: 412 Comm: perf Not tainted 6.5.0-rc3+ #181
 Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Feb  1 2019
 pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : __alloc_pages+0x334/0x1420
 lr : dma_common_alloc_pages+0x108/0x138
 sp : ffffffc087fb7440
 x29: ffffffc087fb7440 x28: 0000000000000000 x27: ffffffc07e48fba0
 x26: 0000000000000001 x25: 000000000000000f x24: ffffffc081f24880
 x23: 0000000000000cc0 x22: ffffff88012b6f08 x21: 0000000008000000
 x20: ffffff8801433000 x19: 0000000000000000 x18: 0000000000000000
 x17: ffffffc080316e5c x16: ffffffc07e46406c x15: ffffffc0803af580
 x14: ffffffc08036b460 x13: ffffffc080025cbc x12: ffffffb8108c3fc4
 x11: 1ffffff8108c3fc3 x10: 1ffffff810ff6eac x9 : 00000000f204f204
 x8 : 000000000000f204 x7 : 00000000f2f2f2f2 x6 : 00000000f3f3f3f3
 x5 : 0000000000000001 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 0000000000000cc0 x1 : 0000000000000000 x0 : ffffffc085333000
 Call trace:
  __alloc_pages+0x334/0x1420
  dma_common_alloc_pages+0x108/0x138
  __dma_alloc_pages+0xf4/0x108
  dma_alloc_pages+0x18/0x30
  tmc_etr_alloc_flat_buf+0xa0/0x190 [coresight_tmc]
  tmc_alloc_etr_buf.constprop.0+0x124/0x298 [coresight_tmc]
  alloc_etr_buf.constprop.0.isra.0+0x88/0xc8 [coresight_tmc]
  tmc_alloc_etr_buffer+0x164/0x2f0 [coresight_tmc]
  etm_setup_aux+0x32c/0x520 [coresight]
  rb_alloc_aux+0x29c/0x3f8
  perf_mmap+0x59c/0xce0
  mmap_region+0x340/0x10e0
  do_mmap+0x48c/0x580
  vm_mmap_pgoff+0x160/0x248
  ksys_mmap_pgoff+0x1e8/0x278
  __arm64_sys_mmap+0x8c/0xb8

With the flat mode, we only attempt to allocate large memory if there is an IOMMU
connected to the ETR. If the allocation fails, we always have a fallback path
and return an error if nothing else worked. So, suppress the warning for flat
mode allocations.

Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: James Clark <james.clark@arm.com>
Link: https://lore.kernel.org/r/20230817161951.658534-1-suzuki.poulose@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 1be0e5e0e80b2..c88a6afb29512 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -610,7 +610,8 @@ static int tmc_etr_alloc_flat_buf(struct tmc_drvdata *drvdata,
 
 	flat_buf->vaddr = dma_alloc_noncoherent(real_dev, etr_buf->size,
 						&flat_buf->daddr,
-						DMA_FROM_DEVICE, GFP_KERNEL);
+						DMA_FROM_DEVICE,
+						GFP_KERNEL | __GFP_NOWARN);
 	if (!flat_buf->vaddr) {
 		kfree(flat_buf);
 		return -ENOMEM;
-- 
2.42.0



