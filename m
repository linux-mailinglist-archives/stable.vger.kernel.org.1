Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7376AFC9
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjHAJuJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjHAJty (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F9C1BD3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4650A61512
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52981C433B9;
        Tue,  1 Aug 2023 09:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883360;
        bh=bhI1XMp4LNAjbKRv3x2jUyFYp4WRfZKzqo2vqmpKhps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ae72hx082QcDWERL+esz539qwgnCrWT1TJU/f+U0fcX9ChW3dS8E1zEoT+aaUVobq
         J80i1KJKKOvoAi02dreGfjVNh1qWtUebF3I8n/NT89MohmYKOSJxGLc0aCs0qlwcsW
         c8W6/wT4KPOHSCHRsUV0vVbmj4lXOCp08NIxrIs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.4 208/239] iommufd: Set end correctly when doing batch carry
Date:   Tue,  1 Aug 2023 11:21:12 +0200
Message-ID: <20230801091933.322306263@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

commit b7c822fa6b7701b17e139f1c562fc24135880ed4 upstream.

Even though the test suite covers this it somehow became obscured that
this wasn't working.

The test iommufd_ioas.mock_domain.access_domain_destory would blow up
rarely.

end should be set to 1 because this just pushed an item, the carry, to the
pfns list.

Sometimes the test would blow up with:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP
  CPU: 5 PID: 584 Comm: iommufd Not tainted 6.5.0-rc1-dirty #1236
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
  RIP: 0010:batch_unpin+0xa2/0x100 [iommufd]
  Code: 17 48 81 fe ff ff 07 00 77 70 48 8b 15 b7 be 97 e2 48 85 d2 74 14 48 8b 14 fa 48 85 d2 74 0b 40 0f b6 f6 48 c1 e6 04 48 01 f2 <48> 8b 3a 48 c1 e0 06 89 ca 48 89 de 48 83 e7 f0 48 01 c7 e8 96 dc
  RSP: 0018:ffffc90001677a58 EFLAGS: 00010246
  RAX: 00007f7e2646f000 RBX: 0000000000000000 RCX: 0000000000000001
  RDX: 0000000000000000 RSI: 00000000fefc4c8d RDI: 0000000000fefc4c
  RBP: ffffc90001677a80 R08: 0000000000000048 R09: 0000000000000200
  R10: 0000000000030b98 R11: ffffffff81f3bb40 R12: 0000000000000001
  R13: ffff888101f75800 R14: ffffc90001677ad0 R15: 00000000000001fe
  FS:  00007f9323679740(0000) GS:ffff8881ba540000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 0000000105ede003 CR4: 00000000003706a0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   ? show_regs+0x5c/0x70
   ? __die+0x1f/0x60
   ? page_fault_oops+0x15d/0x440
   ? lock_release+0xbc/0x240
   ? exc_page_fault+0x4a4/0x970
   ? asm_exc_page_fault+0x27/0x30
   ? batch_unpin+0xa2/0x100 [iommufd]
   ? batch_unpin+0xba/0x100 [iommufd]
   __iopt_area_unfill_domain+0x198/0x430 [iommufd]
   ? __mutex_lock+0x8c/0xb80
   ? __mutex_lock+0x6aa/0xb80
   ? xa_erase+0x28/0x30
   ? iopt_table_remove_domain+0x162/0x320 [iommufd]
   ? lock_release+0xbc/0x240
   iopt_area_unfill_domain+0xd/0x10 [iommufd]
   iopt_table_remove_domain+0x195/0x320 [iommufd]
   iommufd_hw_pagetable_destroy+0xb3/0x110 [iommufd]
   iommufd_object_destroy_user+0x8e/0xf0 [iommufd]
   iommufd_device_detach+0xc5/0x140 [iommufd]
   iommufd_selftest_destroy+0x1f/0x70 [iommufd]
   iommufd_object_destroy_user+0x8e/0xf0 [iommufd]
   iommufd_destroy+0x3a/0x50 [iommufd]
   iommufd_fops_ioctl+0xfb/0x170 [iommufd]
   __x64_sys_ioctl+0x40d/0x9a0
   do_syscall_64+0x3c/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

Link: https://lore.kernel.org/r/3-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com
Cc: <stable@vger.kernel.org>
Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reported-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/iommufd/pages.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -297,7 +297,7 @@ static void batch_clear_carry(struct pfn
 	batch->pfns[0] = batch->pfns[batch->end - 1] +
 			 (batch->npfns[batch->end - 1] - keep_pfns);
 	batch->npfns[0] = keep_pfns;
-	batch->end = 0;
+	batch->end = 1;
 }
 
 static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_pfns)


