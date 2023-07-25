Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5B7621FF
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGYTF5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjGYTF5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 15:05:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC8E2
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4mWApD3fVOrKBE8wb51oqscFjzzbMn/pBVkWXkMDcfOgcaLeUCAnLJxQKCoc+6O2nLtFb/nmzIo7ji6LsY/CMa9EKhRAwmWIF0M6YmFNQEkMY0DxsnoCYfJl3Y3AKxilPajsmOOAB08qYkP+5iI3WXpgC+N1Z5oDw7sMMM13xdmnX2FA2d6+lzRpTwkvBi5yJliIcZNd5F3+uLTSZL9hxMlK2vwms1s5c1jBkBCl55zs5eYa/vw3CfYd/aTKSkn9HfmKl4F+Evd9G4XLqr2InVCNQL1MbD0hwHBy0hfEakX7BRssB3ukYZKL8xho/3hN9BNIuf39YzZ/4TEFSEiFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwaFV3kp6c+cqZ+9yX2XISnnmmyUxemQthJ1QpQyPuI=;
 b=SfD3IHCE6AQ9fM+3em1q4RGJ1c8PJAVxc1TEnnRABPYSxLIaZcOcKUU+fk1fbD0b0sVBBJ0JTiTVhTLXeHhdkfo1RhUERhDYozvJSNp32Djp7b90OgfEyHaS9bkdH2C+x3igD0NbHbft+tIxhwopsmAPIgwUgjxKQfTRHJOWKUvfjKMKuYhbOputAZXmE9z0x3hH7v4zbjylgCgpAemnH3mnIVaj6EisdUbhjq2TCN/IXvQRtCqMraJEl4ORJq/tI8lZz4w4lDgIcV/b/kubdAlYVNcqHdHCRJF4+o63IrpBzVke/a5pZxB+PuxfqlucDrXemXwGjN/9RNFZLjgxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwaFV3kp6c+cqZ+9yX2XISnnmmyUxemQthJ1QpQyPuI=;
 b=bS4GlukJ3V1K3XlzsPHSNsp9mALGmCUGn9MzHHPx9UpuctMhPOu5IC8BIy8LgEYLc0Stbsx2YOx7HGp0RQVCRK5qVi3lf/GB/W7vsDGQSRqxUiYdbp7XkPKcAj7/bTHPQrxu9Vbc2TTsW15zSdNESrFzckPSIfdoCcn6utvJi7eTSpJttVu+hLGf77OUmkKKq9A4bOZGHmuhvmzLEDhzrs29fgSOhJdVazlyjyvJINB3cTFXI0zXsKI7TXAxt9j3d4e8Rf8+yP5IU/d3ZNVWZ1CILW1SXbJvfvAcBExGwrA6+FtbwnA85rAcTc6QAb2TKym8qDaU5RNBwcdVJNJXYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6764.namprd12.prod.outlook.com (2603:10b6:510:1ae::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 19:05:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 19:05:51 +0000
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
Subject: [PATCH rc 0/3] Several iommufd bug fixes
Date:   Tue, 25 Jul 2023 16:05:47 -0300
Message-ID: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:208:23c::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bec825c-49ff-4898-2da4-08db8d4229c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wg5cm+tSiDvVIAUA4S4egmNCeWYSXpOwdO46EQPt+DKV9CVjVgQAkzVYSCBFlS0nVogJ2UbZ4A0n5P9idiS/vgW1z28mD2hGUBdGj2TzN38A0qOyyI+ZQfKTXPuLICRlzmOq+L/jsKf9A9Q0hcWoO5AOTvUFKFya0JGbQ82xpFHcWeZPzgKD50ZULqNxzx4/8FUytSimSYXVNM+nTJLwmVLZHSN/ockdWxczHhwWoKudsfgKDwgr0WuRRABSsFHpxGEwXSzDDrZg5C7T3mCtCJDGP792tUFfAiWyLkZ0xO1uyKR4E8ZOQqQ+RbTV70MkjT0xJLPfcXB+Duol1xgFXj8bgD23mCHzypjGh/xpGC/uPbxTwdQM6zn2/5RVr8gfJ8pNwlF1WpRCIFigPoPUofr2kIVM8pZYHqUjPdtpsptMdIQ89Cw1Lbbwxhzm5qZ6bJVEO8/q2iR8SnTifwsVvJhh+aSDxrqqOkCHgWAcA3sqGpR07Ms7tV8wvCcNT3RotEI29wEoVgyD98B8PDmIhsxVwOicCT2BfdToAtTyBedBYZ/+1h+2aBlC4q4bVQZUZXAb618nsk0dMqE7w0oLv7okgVhPr0X3jfrV67RLdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(8676002)(478600001)(8936002)(4744005)(2906002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(41300700001)(5660300002)(54906003)(36756003)(7416002)(38100700002)(6506007)(86362001)(26005)(186003)(6666004)(6486002)(6512007)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cuuXlK2qDKHx9YJHlg9oa8kt0fOVivXSeGxKpVSeVYNSAW038YF1tWI2hDdv?=
 =?us-ascii?Q?fOSBtGRLk/fLuwkrfDsfFl8pkHWXaoTEe+G9z0yxdFVd7OBZ+rDR4GU1gN7H?=
 =?us-ascii?Q?0g32B/JOk/hMF19AgtsdCRaheqDlsjPuS4lL0gMzlQBrc8nZCvVV38jbD6lg?=
 =?us-ascii?Q?eSnFXE55VOyI8o4TQSo3sKdSXsdsMQVhAVIc9agZHum8lX3JomV0l4NORQh3?=
 =?us-ascii?Q?NXDk1U2CsCAdt5hTM6EXdRgAacVjCNyDUXsBBbgtNNU9sl1skcaXD470vGdh?=
 =?us-ascii?Q?3cO9TyNVI52j5cULGAEZ5RElraluz7+eEGHXRuENttjLbRXu6B+M83VJXvO7?=
 =?us-ascii?Q?WBc85xkIm206z4A/cqX3Uj2DOi5uVnIhM+aLEBr0qdC95cfGp8fsGYzbAUU/?=
 =?us-ascii?Q?e4fuF6f+iFspaFiJ+/NBzobdwE1ht5mmySLF6U+lVEUOE6ZvKS75eA93Vw86?=
 =?us-ascii?Q?Bl2rHEmSII5RR6uDXAHZPWuILNt0MIYAp/Z8WH/WDuIBKAozbZ5ooEfjZrVr?=
 =?us-ascii?Q?/G/q2lO93l0A+qWXx8geIEnt9uYejyN1uyb/2nJuSIGrMfAteboEW7KoxEBt?=
 =?us-ascii?Q?qh9e4kSHFfX7cNmb4NDGyGxviXO+6NiQJgNbbH8+NZM4jnGsEdMFRtwWDSUR?=
 =?us-ascii?Q?wOf20eT1kjw/EkHeLxUX5o8MxC/8QR7W6Z3049gOxoL9u79avZ+o3lGJGtFM?=
 =?us-ascii?Q?vBe0VeQsrf6of33DUIY5hZRRVczmB04AH/udLxAQZSiEmNUbjIE3tkX9V7WB?=
 =?us-ascii?Q?mJe9znTnLXrJ4hRw2JIqEKhVxBFZb8P+hJsfTL0t6lr4+2TnQGyBPO0rDm3F?=
 =?us-ascii?Q?DdusTeVyrey3b9DeY0ae05bSRtOuwFqHY3AfZ6L59QSwJmuyJbkzgyMEhb6A?=
 =?us-ascii?Q?LcDakrzDfSYbi63M4gFKn9xHeY+P1d3R6ApTJXGhZy74wIp83pPrPdjjdX9W?=
 =?us-ascii?Q?epvmAcAIuFWFrikOXk1nh9R1LwhSZQJNX1M71YIEHWqHZfgPs1rkXIF5ruvV?=
 =?us-ascii?Q?4rKPUrKkaOs+XjK5QBjZooo+xHbdyxpaOnapUqn+Ee47/qsuteRA9YYRw0Jq?=
 =?us-ascii?Q?FKkSMpGfywECoM9A7Wn2zLMNVJEkwJsQ+uLd1NmFHm7qpUG8HJ8aKXNOCxf9?=
 =?us-ascii?Q?ngmeYZPOenPK2fS6Fm7fvzwpbG+u0RED2gLh55KjK+qnQl/Sv5Jn0VAcQnL0?=
 =?us-ascii?Q?oX0MPsie0NgvlWBPq7NKDcaBxf9HzpPUkWz+ftqrQGl+xR7CNJr/Kd5b/pGk?=
 =?us-ascii?Q?BgFqxdyHBdnswCjQPk271++MsGb7XqyoPi+yiu1Zf83rnUwSw4M2mD6a44v3?=
 =?us-ascii?Q?2BaS2dlpy9cDf/sBphQhx5lJ4o9zMRvpw6j4xUomVXNRNfs2440pwZwJJs6A?=
 =?us-ascii?Q?COA1OE0JtD3sOGPfloJZftBLXFjDb+qJvVyKa1dlNU6ZEQGzsXEjRzWJ1cgl?=
 =?us-ascii?Q?sYCiEr18awucXRgYZupu7lY3/82fxC3fYIGNli4og07gLrO3xXTAMZ2qDhZG?=
 =?us-ascii?Q?pOaPVIB6bSmc6MLOcaACqs4+wmOzWlZmd6vZQqjrH6B173ckQ8np3T/BNujB?=
 =?us-ascii?Q?uy0PIC0Zm+3C5f8XyORWSFuuBy13S9Vl/J5NXBe0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bec825c-49ff-4898-2da4-08db8d4229c5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:05:51.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAWS02GeZ9td3YAGB+uvEIZpSY6ae5BCF4z0OB23CcFxhKV8GsoDIR7j+4O/dV3u
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

Syzkaller found another small issue, a race with
iommufd_object_destroy_user() and IOMMUFD_DESTROY.

While researching that I noticed an error unwind mistake by inspection.

Yi and Nicolin stumbled on the last one running the test suite sometimes.

Jason Gunthorpe (3):
  iommufd/selftest: Do not try to destroy an access once it is attached
  iommufd: IOMMUFD_DESTROY should not increase the refcount
  iommufd: Set end correctly when doing batch carry

 drivers/iommu/iommufd/device.c          | 12 +---
 drivers/iommu/iommufd/iommufd_private.h | 15 ++++-
 drivers/iommu/iommufd/main.c            | 78 +++++++++++++++++++------
 drivers/iommu/iommufd/pages.c           |  2 +-
 drivers/iommu/iommufd/selftest.c        |  9 +--
 5 files changed, 81 insertions(+), 35 deletions(-)


base-commit: 6eaae198076080886b9e7d57f4ae06fa782f90ef
-- 
2.41.0

