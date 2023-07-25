Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E00762201
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 21:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjGYTF7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 15:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjGYTF6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 15:05:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40993121
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCF4K8Vwi7004XG5LofOJNYcbI0napa/uKCPyME3Ns4Qn3gLIFf3RwBc7b8YeS8O8IESggrxK5FNVrBPwdbnWzO0QdrMzFqHF2TBaMX9hUIMHi7bEbexAKaUk/lf2nVoGMGthS9KGNrRVPSP2oQe4eLoZ7O4vTKD9I9u7RgPMIqCqfa1fQt4/NGTncc0u78NKnevrFn9amGgDlvFAfCKCYwhUL4SRJ9SsqqWh0rzGHObHs5Q1GOgqCGhcLjkzMcWOARuTQ1DHcw6yCac9VwAfRK0UoujL1xicJhNSdlruoC0EVpR6iy6lKfdmDfEP6nolDZpEqCx3LCbgxACDH18Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx8H6/+4Jd4oIkPdYcdhE7Qa63ZtJjdt38Sf44TpcNQ=;
 b=PazkoMaG+zxomJ5V1p7DPHCwZnL25s/c0ZHYEbUToXWj2n8xwwOASQjb4RBLXjnrXm5WXoHxjIF1MGKTpC9HetW8Q1CbkPShZX23y1LQ4He4Q0+UIZzGldh1KvuRdn4mafqi0/s/thj21FSZgcyFKxzY+Z1UtzDyVG5P5KD/PF+Ccfq8XgVSo1ggL33k5fyjWzwMwPWCwV8ugZcxAN1vbmSfsHCW2qU5HCiGQMFuQ6szAyAY21A4vG65ecAQKC/Cj0+GvUn2g9lEJwHp07e6HOij0LK9Ldfu691dABCMY+Q3sO/P6kjO9pey1sC+64B5O6y6Z/1S44Kr1c410cMC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx8H6/+4Jd4oIkPdYcdhE7Qa63ZtJjdt38Sf44TpcNQ=;
 b=R2Rw5ymT5wjghF80Pq1JJa3kE4PRunqkXK+0rH0TjkMMemseq1rYd+iHLY62zqHCc8Am08mJYBJO24masd2W23o56Martt6zdP/FaG1VhKhJkCnQDc5Gbg/7jxiTasRFPzaTkOyj3I6lqsrlcI29R90kZyz72jg8sgXrgAd2iqOFvvS65D4OsDL75FR/izTTGCyzD7fuXRiEGNC9yDelraVryzloRohBpUAU3l/fHJz88Divp1+BeTUitFne+A1jZJiht/4N/lsRHwjIitCuIVxbAcwiE7wPTL7na6igbd+Fs5kFBlRt8s3Kxbo0mxvdc2FoPo0mzma9VhTagS6AMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 19:05:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 19:05:52 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, stable@vger.kernel.org,
        syzbot+7574ebfe589049630608@syzkaller.appspotmail.com,
        Terrence Xu <terrence.xu@intel.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH rc 3/3] iommufd: Set end correctly when doing batch carry
Date:   Tue, 25 Jul 2023 16:05:50 -0300
Message-ID: <3-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
In-Reply-To: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:208:178::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca3fc76-e5ee-4211-b85b-08db8d4229ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y4ZT2f7kTLYyVlrjpgVv1h6CtnIbdMe8ipMufemAJw9hzYhYVr53VlnAWGkEZifDrwjzwMVJiFY72Utbhq7QvvmW1ANrDfuhrwVJ4CRECgkZeeRZCae9wljG2fjOLgbAT6H5RL6khqNnGwnXaTXojhTXlehR80+AUStKCLFn9cScLFBs/V3GjrERJTLBXuc1f4il50Ka+OH+9oCLWHgqyxuTK7CD5b0PsXCOrWd47XgO3zmSEbpVs4Gc8gw9BNNkqDAc4KyDd934KrsFwalh8Bve1bjS/JM3fzxDdhNufPAQmuqcj+lrUtsvzljlXhfJOJB542+Ds7p2lFC1W/oazUyHsOoGHRyc7dzYyqB5dvwQ+KLFj5EEAdG+XMaIO/eC0URlR1Ujhx46033rrSMDQqPNweLL8Y0HePg25pnW+QCPegKSWliNB5AsZXfer4yP/r8NtX+D4dvh623UZnAQNxGPsjK0fc0F5fvFCQRvcEtVbz7IxMOUH12vUE3tjqTTctIN2QupqkffEzW8G0UTRjxPqgoGFFPuxnUA6xf3a0Vkc1W0xvF/Y453hNTxWZSVsa0oQQMpgpnk5y7jo7iuG4sIUpLZdkRJFHMrAJe4V1s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(8676002)(478600001)(8936002)(2906002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(41300700001)(5660300002)(54906003)(36756003)(7416002)(38100700002)(6506007)(86362001)(26005)(186003)(6486002)(6512007)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ljaccqu+TxQQzrcZ4MAKMmtx1w3ly0nH3D3niGWHJnjZTIyywhn9A1Fsn88P?=
 =?us-ascii?Q?jqvnXhI9g7E8ZG6B5xCpKTAxl/y9nCcCljWn+XH4RRbwhL4Pw+C68UG/5+4d?=
 =?us-ascii?Q?PkMkRMpgCN4N8pxztkXW1KYfE0KYCDnCftmQdq3z50VJ5752c7eVZFuRu9sJ?=
 =?us-ascii?Q?yr4XYPgbiqKcCpnPXDrWr2RmZv8xqrGeJOhG1PNeC9RZVHPjC+Q+/HnYDzwA?=
 =?us-ascii?Q?OSH8VUqzJ4Nq/1ppHfZyHQ/UBBvLtpLF5eucehzvodzXmHwwh29jNhX1h3FQ?=
 =?us-ascii?Q?W3PvVLk21Lj3k6MFA2JJXeXFIJfVOVQHYVHWH8C9lPTBzv7sM2JPS9dvb2a1?=
 =?us-ascii?Q?rAOt54EJR58CXo7Sgsy8KFoeAKPVKc9r5l38TvWfbGOlcOLdz5/aIFSKmn6Z?=
 =?us-ascii?Q?9g60eFxEKHZSe8lDpXErX9QN+w1OMFlSdtb+LXBt+ar4u4vDPBuuh60yLoup?=
 =?us-ascii?Q?YBjde6vkFGZoyRdrM9HAyizXSHYxgWjHdh6gQrv3TMFKL7XhnWE7kb61QfkB?=
 =?us-ascii?Q?+venG+lmrSZfb7ShlsK9u4ybmOsYgpnCVKSnf3dV5EHIWdXT8wonCEt+xINQ?=
 =?us-ascii?Q?jKEO73VKWvoceWaSP2kWTkhDarOkqcAluCyAFvG1KRsAFJ4DRFuROVea5lMM?=
 =?us-ascii?Q?akfA97XIBEppaY0F42uHj67N9M2Yt1xeqK5Lt5aKGuC1Ps717Pl0bjxL2OmK?=
 =?us-ascii?Q?o8O/Q23rTX9R9X2lfueQh716xhkg4MZ8BTcgDK8h9/IeDL4F0u70UpCFVKnB?=
 =?us-ascii?Q?+x+HinZIHliP3cfwQbm+UhVi5sI1X4CQFsuczZLmZfNUpwKP4SyKapBQtLRI?=
 =?us-ascii?Q?jWu7065uctFJFroLIsgixuOujJYUE9t13oOIyhzKDhYma+Fd7OFChrOiYw1J?=
 =?us-ascii?Q?lq+WCNlQJOSVxiUN/sgc12s4QGEAb6K7VZiTg3wMQQmStQms9BDXWoZV5650?=
 =?us-ascii?Q?cCPEURjHZt6/ZRr8xfhmhaMjy5xbCZwC9kQSCRFovD+ZVUWKy9SJ92eCcrz6?=
 =?us-ascii?Q?EVis/BebyRCRFBY+N91mYbchzlrotTxO3O5GkZIOj+F6Yq9jc+4MLevH+Bg1?=
 =?us-ascii?Q?4UKl8rIxLmtCfYzpI2E+fkla7pTks9pAUCcA/5HPLx7DZa3Uj3P4Q6Z908jf?=
 =?us-ascii?Q?SU4WXRLOYVW3WUsRDotvEOb37Un49TatACLN1ei3ymmvMiDlIPkd5ST1x1wj?=
 =?us-ascii?Q?yaY5rRGo2nYjfx4ioAe8HI/7GIxLq0OQiyQaeWUwQ5mKeLzOr8Dp3cHcQo0B?=
 =?us-ascii?Q?y1VtbbrUB5fgHyepGwBoG0wl2iM304+Cu/rRhAGD7Ia9AUBvg6cP5RQlFsNS?=
 =?us-ascii?Q?4sF7nhwbkCoRmKdWMBrAq+dXemCr4OHHKur0eOvPLGGTG5quT8mxC1+BAe9K?=
 =?us-ascii?Q?R+cfOjOloQddscC05ZL1wktc/y4to/6Y7KqdpXr5JjdYKg06mICoQ9x7kV24?=
 =?us-ascii?Q?v2exXo3pvs4HAntpuLG7A1kGDpiRVCxHgsFi4WGvp/4mQFFOvsH30+hYy6gj?=
 =?us-ascii?Q?kwkmIRz0ArAYxfCznrnLAxJ73rL7fYFZN4YzNZx2AWqP6/QHMjDbELSqFVlW?=
 =?us-ascii?Q?zXrxLZ9fk0Izk9J3dvM3sX7z3MhCne9NhmgHMv2K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca3fc76-e5ee-4211-b85b-08db8d4229ed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:05:51.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayJwR+dDfMOB58iG8ZJUoLuDpaEYsHM9kl/fRDnSrJw+V+YNyfTuRIBLpeaoQgLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6764
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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

Cc: <stable@vger.kernel.org>
Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
Reported-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/pages.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 412ca96be128ea..8d9aa297c117e4 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -297,7 +297,7 @@ static void batch_clear_carry(struct pfn_batch *batch, unsigned int keep_pfns)
 	batch->pfns[0] = batch->pfns[batch->end - 1] +
 			 (batch->npfns[batch->end - 1] - keep_pfns);
 	batch->npfns[0] = keep_pfns;
-	batch->end = 0;
+	batch->end = 1;
 }
 
 static void batch_skip_carry(struct pfn_batch *batch, unsigned int skip_pfns)
-- 
2.41.0

