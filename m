Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C136FA88A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbjEHKmR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjEHKlo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:41:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B812A84E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AC061909
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B07C433EF;
        Mon,  8 May 2023 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542466;
        bh=nDEMnWd+EuASQpGCscuzQoO4JYuhzm2i1ixt+YU41VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwuJQQr0AvJNpKYNN480TZHoIpZNMxVDtt4DdCeE2wi1JHUJeetJtP57O6J8bZGcW
         0N2W/D7QMzdIvTWaehn9TZpBk7f64/0+GxaW+niwnjOyw79EVjGpHSjrMZ3EBzEdrd
         13IJxf2Q9OZs1Y9bQIqOReHVLAkAN0W68Gu6IKQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 444/663] iommufd/selftest: Catch overflow of uptr and length
Date:   Mon,  8 May 2023 11:44:30 +0200
Message-Id: <20230508094442.482028778@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit fd8c1a4aee973e87d890a5861e106625a33b2c4e ]

syzkaller hits a WARN_ON when trying to have a uptr close to UINTPTR_MAX:

  WARNING: CPU: 1 PID: 393 at drivers/iommu/iommufd/selftest.c:403 iommufd_test+0xb19/0x16f0
  Modules linked in:
  CPU: 1 PID: 393 Comm: repro Not tainted 6.2.0-c9c3395d5e3d #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
  RIP: 0010:iommufd_test+0xb19/0x16f0
  Code: 94 c4 31 ff 44 89 e6 e8 a5 54 17 ff 45 84 e4 0f 85 bb 0b 00 00 41 be fb ff ff ff e8 31 53 17 ff e9 a0 f7 ff ff e8 27 53 17 ff <0f> 0b 41 be 8
  RSP: 0018:ffffc90000eabdc0 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8214c487
  RDX: 0000000000000000 RSI: ffff88800f5c8000 RDI: 0000000000000002
  RBP: ffffc90000eabe48 R08: 0000000000000000 R09: 0000000000000001
  R10: 0000000000000001 R11: 0000000000000000 R12: 00000000cd2b0000
  R13: 00000000cd2af000 R14: 0000000000000000 R15: ffffc90000eabe68
  FS:  00007f94d76d5740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000020000043 CR3: 0000000006880006 CR4: 0000000000770ee0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? write_comp_data+0x2f/0x90
   iommufd_fops_ioctl+0x1ef/0x310
   __x64_sys_ioctl+0x10e/0x160
   ? __pfx_iommufd_fops_ioctl+0x10/0x10
   do_syscall_64+0x3b/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

Check that the user memory range doesn't overflow.

Fixes: f4b20bb34c83 ("iommufd: Add kernel support for testing iommufd")
Link: https://lore.kernel.org/r/0-v1-95390ed1df8d+8f-iommufd_mock_overflow_jgg@nvidia.com
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Link: https://lore.kernel.org/r/Y/hOiilV1wJvu/Hv@xpf.sh.intel.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/selftest.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index cfb5fe9a5e0ee..76c46847dc494 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -339,10 +339,12 @@ static int iommufd_test_md_check_pa(struct iommufd_ucmd *ucmd,
 {
 	struct iommufd_hw_pagetable *hwpt;
 	struct mock_iommu_domain *mock;
+	uintptr_t end;
 	int rc;
 
 	if (iova % MOCK_IO_PAGE_SIZE || length % MOCK_IO_PAGE_SIZE ||
-	    (uintptr_t)uptr % MOCK_IO_PAGE_SIZE)
+	    (uintptr_t)uptr % MOCK_IO_PAGE_SIZE ||
+	    check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
 		return -EINVAL;
 
 	hwpt = get_md_pagetable(ucmd, mockpt_id, &mock);
@@ -390,7 +392,10 @@ static int iommufd_test_md_check_refs(struct iommufd_ucmd *ucmd,
 				      void __user *uptr, size_t length,
 				      unsigned int refs)
 {
-	if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE)
+	uintptr_t end;
+
+	if (length % PAGE_SIZE || (uintptr_t)uptr % PAGE_SIZE ||
+	    check_add_overflow((uintptr_t)uptr, (uintptr_t)length, &end))
 		return -EINVAL;
 
 	for (; length; length -= PAGE_SIZE) {
-- 
2.39.2



