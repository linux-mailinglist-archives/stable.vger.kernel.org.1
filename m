Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C27622B8
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 21:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGYTze (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGYTzd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 15:55:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1182519A1
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:55:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlXke6IcQ//WBvxGPQI3WNUzjv6/kBQA7gE/sE4HG1m58fD54gXDOqha5FiEkSo9q+lLtzi5okeI0zPjO+dJs58+m8fQRKTUVeWyzKMvXIb6ZJyLqRHabBv2rKtZRVHEqjlF4DkNiMFpvkg1w+w8NND12/JKeTNH7pyBCqPNYpqp1qnrNh242sZcUcmy6Nq81xPSHBqPUx7AKJalRPJ8tWtyIxCGH/ZossoBPBSgzc1tXHFXVJEs7W3DupMItqZ7rsodUldpiWXzEYQUbQNYGK6/PplR0DGjySlixF8BusEet36DfKc9dfBdXB9HLfI/oTuKzqzevtJdGR66TZT6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NIpZA+sG8d25qplq4rUDdijnV7NMXZ6UH7Da4BJ800=;
 b=IjCeTZ3fRiNNrIEGs/HixsW3sduIzSWTcaAod34Yu0+NJm2CCdkyYxPMW9R1nSim07539Jh1nOMgLkfqjJnn9mDvOMGpJ8m5ohixZeXPeJAzVMq8yJSSGu+aiTlAnopflC6nALq6Opwto2yk51cfun7tFj2VYtgN6gw/dJ3uYiHKfFfiaUMG51AXvYsw0P3oKy4RE3bOdI6T9bwT0UeAnuvQC1fQykGcbCGOm3kenrD+4BRqWoZhq/OPgLoTSxpUhEOlZlZYHrgrtI9nJ63tXknGqnBN+WDk4LHfObsou2V+vxSKcoj0Sx9gaZl/dvjfVYzEYWD/3Ou46GMkxagtrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NIpZA+sG8d25qplq4rUDdijnV7NMXZ6UH7Da4BJ800=;
 b=PGo00BNHu2pTmfXhMJdzdq/51zvYI0AQiGLYX6WSIEPKVogxmx5nH3swg8zn5Ep0mBPHZvN+F6FWq3B7AZ8Rs9FUmlCHEQFjkPqcn5oSqxCMgXiSrtTyPF3mdofQ7XhTsLrG+KLrTal1xWEHuFM/93clK6aQcj5FkIZLeD3NECMd5BG5KoAyyioU9cCuJUzq5cxnz8YhcKcAcJppRl9lSeUHD7U38RJCGiPVGH0uy5D46ThnsnnH0USBCWCIJy6Dg4XnEc10f1GV0lga+Z2AilSxAZZlRaiSJAd8FaAvPDClohpnYnMG1/OrHAuOxng+g3teWx1L86ezpkUuK/32Xw==
Received: from BN9PR03CA0327.namprd03.prod.outlook.com (2603:10b6:408:112::32)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 19:55:30 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::8c) by BN9PR03CA0327.outlook.office365.com
 (2603:10b6:408:112::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 19:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 19:55:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 25 Jul 2023
 12:55:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 25 Jul
 2023 12:55:13 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 25 Jul 2023 12:55:12 -0700
Date:   Tue, 25 Jul 2023 12:55:11 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <iommu@lists.linux.dev>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Kevin Tian" <kevin.tian@intel.com>,
        Lixiao Yang <lixiao.yang@intel.com>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        <stable@vger.kernel.org>,
        <syzbot+7574ebfe589049630608@syzkaller.appspotmail.com>,
        Terrence Xu <terrence.xu@intel.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH rc 3/3] iommufd: Set end correctly when doing batch carry
Message-ID: <ZMAonwbzOgm6IY7/@Asurada-Nvidia>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <3-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: b51b15ea-af18-47ab-32bc-08db8d4918b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/+iNXkA0nvL+I+OnTN3qLG/yCZgjS7xC5PlVXlA+HUJEmfaDNlVg7i0CSqEOOB+iPKqf8TjljzLhaxyr6gDDPhI3LNtsK/QVnrr6cPjnAEIzESyWHRJ1C3DyBuQsM4eG6nJIX5p4ArD/e7mLWbTrM3ATZqhBTHmboSajV+EP4KjrP8T5Gu/QKbZfewdYhng5hTntdERj+2aDIbYbFrzBi3yqGiyAeq+G9pOPt9CSK4YdSoiRmcKRjuPk16os4u7fJQv7jeFfLyQcZRFGL/YYZ04hmusDos1a8EfGqYmDtMbzvfe1jQ70olahi8WF3GDoNcBJGxIvHdbq2wfPIPfTWSNcPspzdOSLMvNXV28W3sWMej4Pm/qlcXrwdNLXuuqZZuw6tvVNe7mKScnmEVcQvKLaBfGQWZrEH7HJbGtEuVAbtEh5HOHTHtwk7bgG6mGOHhaQV3GSKKQ7uQxVK2xmXbneKDdTs9pFO4mwaW/iP3fiCELt/4FM0/VOJ4ASKAc85xI82KiwRN0uGs3z5QvgnaSMYD/43v2NdB7/ALn0qoy/8fYkLmN0+3PaZfVJexYDvp+FtXte8Lm7Je08oqnFaF5AnjDCg6ZwQGyA5hx/E+6zUpD0A75PA6nOfeYD/5SLr9gH0HVTRrd8XKVzungSBJSKcKchAKtYEjcfM5aZryZJZQcTJtL3GJ3Cn2EjUJlLX/rrAcLhHIjZxjN7jVP2mE6Ly39v26JjqEsCtlPerw=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(55016003)(40460700003)(82740400003)(9686003)(478600001)(356005)(7636003)(70586007)(4326008)(70206006)(6636002)(316002)(83380400001)(54906003)(47076005)(426003)(36860700001)(26005)(186003)(336012)(33716001)(40480700001)(7416002)(5660300002)(2906002)(41300700001)(86362001)(8676002)(8936002)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:55:28.7486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b51b15ea-af18-47ab-32bc-08db8d4918b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732
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

On Tue, Jul 25, 2023 at 04:05:50PM -0300, Jason Gunthorpe wrote:
> Even though the test suite covers this it somehow became obscured that
> this wasn't working.
> 
> The test iommufd_ioas.mock_domain.access_domain_destory would blow up
> rarely.
> 
> end should be set to 1 because this just pushed an item, the carry, to the
> pfns list.
> 
> Sometimes the test would blow up with:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] SMP
>   CPU: 5 PID: 584 Comm: iommufd Not tainted 6.5.0-rc1-dirty #1236
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:batch_unpin+0xa2/0x100 [iommufd]
>   Code: 17 48 81 fe ff ff 07 00 77 70 48 8b 15 b7 be 97 e2 48 85 d2 74 14 48 8b 14 fa 48 85 d2 74 0b 40 0f b6 f6 48 c1 e6 04 48 01 f2 <48> 8b 3a 48 c1 e0 06 89 ca 48 89 de 48 83 e7 f0 48 01 c7 e8 96 dc
>   RSP: 0018:ffffc90001677a58 EFLAGS: 00010246
>   RAX: 00007f7e2646f000 RBX: 0000000000000000 RCX: 0000000000000001
>   RDX: 0000000000000000 RSI: 00000000fefc4c8d RDI: 0000000000fefc4c
>   RBP: ffffc90001677a80 R08: 0000000000000048 R09: 0000000000000200
>   R10: 0000000000030b98 R11: ffffffff81f3bb40 R12: 0000000000000001
>   R13: ffff888101f75800 R14: ffffc90001677ad0 R15: 00000000000001fe
>   FS:  00007f9323679740(0000) GS:ffff8881ba540000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 0000000000000000 CR3: 0000000105ede003 CR4: 00000000003706a0
>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   Call Trace:
>    <TASK>
>    ? show_regs+0x5c/0x70
>    ? __die+0x1f/0x60
>    ? page_fault_oops+0x15d/0x440
>    ? lock_release+0xbc/0x240
>    ? exc_page_fault+0x4a4/0x970
>    ? asm_exc_page_fault+0x27/0x30
>    ? batch_unpin+0xa2/0x100 [iommufd]
>    ? batch_unpin+0xba/0x100 [iommufd]
>    __iopt_area_unfill_domain+0x198/0x430 [iommufd]
>    ? __mutex_lock+0x8c/0xb80
>    ? __mutex_lock+0x6aa/0xb80
>    ? xa_erase+0x28/0x30
>    ? iopt_table_remove_domain+0x162/0x320 [iommufd]
>    ? lock_release+0xbc/0x240
>    iopt_area_unfill_domain+0xd/0x10 [iommufd]
>    iopt_table_remove_domain+0x195/0x320 [iommufd]
>    iommufd_hw_pagetable_destroy+0xb3/0x110 [iommufd]
>    iommufd_object_destroy_user+0x8e/0xf0 [iommufd]
>    iommufd_device_detach+0xc5/0x140 [iommufd]
>    iommufd_selftest_destroy+0x1f/0x70 [iommufd]
>    iommufd_object_destroy_user+0x8e/0xf0 [iommufd]
>    iommufd_destroy+0x3a/0x50 [iommufd]
>    iommufd_fops_ioctl+0xfb/0x170 [iommufd]
>    __x64_sys_ioctl+0x40d/0x9a0
>    do_syscall_64+0x3c/0x80
>    entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 
> Cc: <stable@vger.kernel.org>
> Fixes: f394576eb11d ("iommufd: PFN handling for iopt_pages")
> Reported-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

This fixes the memory leak at the HugePages, and likely the rarely
triggered BUG too since I see no repro after applying this patch.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
