Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828FC7621FE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjGYTF5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 15:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjGYTF4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 15:05:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEADBF7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E65mVNPkKH8l4yldMBn9H3AqOTe7j4GaFDIDYHLBDQ6RuT1BlzZz0iFbgA2p16Eub2LdMFANp5E6ZFcHORhSpKh/W8E3FrPSeZfQJzY98dFh2LXo2QSjP9nxNSMTcxVSmfr4NDlTuk2q2FbmsSFsYNd7eTzezuSrDyJRoN6HSbQiHCZfJp6qp9visvmqdu4qhtZxnEVlApV65e0wHJbvlbTf1kwEJ4swt2TN/15HBtdyM4BowY/oilL8reroFbU+Ia067Cd/zUJFPo4WGX79tB1JcS4sH1OxSdNsxe206dzEatSWqqol9GIXrc653lLkvBP5alzuLuvvwl79+V6onA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVhBxlWiu4dDV/jBiDKYIzeOYCb1Nw14MZ76S4A3UMU=;
 b=a+FV7SiGs181PnW2phwL3+Bj9QxABl6m/2Ajw8YssgJiN0Em6BdgG3E7dobNcB2dabKsNzxRWJzXftF3z8dIRk5lyXU3ysLepreekw6ZIkKo+oq7tmlDEls/qGK1+EevopdHdhziDlU6DwPewKaRLZsYsfG/fH2+LjYdhD++SYjTqugf1qvpMYxeSbsQX7dcC1+k1z0hZ+6qSncga3DmX6/Bbn/SupVPPAAzPM6pk8ck8wWtVrk4Yv2mSqtuXOssCnEEpzW2Z2JHItesPHTgnaiwqHdNSN57E+kt64Wi3cmUjpPq8AI63uHl0aLv0X6eJZqgun1v3AD3kLqIYjLe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVhBxlWiu4dDV/jBiDKYIzeOYCb1Nw14MZ76S4A3UMU=;
 b=Tp/WMVyhcsgeyrnvOjsEJRVqcLanknrdxikzc7Zz7KzyFoIrSmP+y7eVeAeOykw4VrERPPx6GxD5Ej8bXkJ7ASnbnEbEx3pzLYYCKiJuQpoFcVxjjMHhCJViuCqSwvm78bqYKBczUEIZrxCtGpGAjEHTJokdVlr9uYGA+Nuj2fBOLohflk8vkcP+3NAzeGnSwHCf95XW9TbSe27LNb2uVskI8JTdJl9l4eLUEewBgPINZEU4t26K923fM87S3czy9aR8ShT190wt1INxgKrbSjiQChMJ7DDYa5FiIpypF9f5dv/7CdYR3xFiQaLXliHWVUdXlwOwT6/aRQcd4BgD/A==
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
Subject: [PATCH rc 1/3] iommufd/selftest: Do not try to destroy an access once it is attached
Date:   Tue, 25 Jul 2023 16:05:48 -0300
Message-ID: <1-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
In-Reply-To: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:208:178::44) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 288b5d80-461d-400d-5738-08db8d4229ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8fZXCT3Xgt2AXzJ/qcJ7b00GTR7zPKcC0LAzIRZ+GrVMHYZsZYqxVYmJXX0GXSPtvrGVHK+ezlIygC1m6lMFl25lC4VMosAiKDg/2AxKnLnpIo6h0oxzKZmILjKRkgJwq+z3m23Y1pvs0Xs+MIQeYUw2bpFFDPLx+k+V9hChpSNz+EKzL8timvqCCkwYxKqpDbFuDTOWikrOeA1HpHWJYy+VBaCYMx4o2aHsSIgdZZfWngwzDb7r73wi01TjhtboUSkF/jzXQUvcTd7PVas6szdTNtRw7ebxRSVPet1DJ1q75mGJCQKhWE7VdF5GGJMeIcsk7q+MRenXJP2hAw+iRg3ErGUB+KoYKurvd1RhytY2f8zhYKJjXy9MN11OD5//1SB6G4W/iNDAtX4o960ptY2e5rLUcJdW9O5o35XGBqOyTyzln4Uz5RTxaW6X/kZlAXczkFYkHPXoB7ARd3lOwysVFU93Cs2ixhEM6ovMPcKuv50v5Yk3jE4SiFyDCHo8ad4pX1hP+ihOVEszGZUhnsGzLBBkq+y6GoFwg1viae8XgHfytwEiNnZWJyJrgZabV3hTDS++7YrDUSc0BsMVE0Jrjg8ze7mX0S22vlmHY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(8676002)(478600001)(8936002)(2906002)(6916009)(66556008)(4326008)(66476007)(66946007)(316002)(41300700001)(5660300002)(54906003)(36756003)(7416002)(38100700002)(6506007)(86362001)(26005)(186003)(6666004)(6486002)(6512007)(83380400001)(2616005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQocUg8/kipUzw9E/3LLkXAs/mh3tKgzWoEc/4gHaqLiAMLdTUD0TVIm4ELs?=
 =?us-ascii?Q?8jqpZzPGTlb4qrmR3Rx4RiohX7IlljjWwZy3NchSI8YAIW9uro70lpqvxeFE?=
 =?us-ascii?Q?5ACFPaFB0gsh4pva+6zCCm9TMsFwZ5nWtqPPVnzQXCN1mtWZwyp1wx/aOdER?=
 =?us-ascii?Q?XgiUcGtLTUOwFK7gvwygVM1mUu8BXF0iaawJl0v7U90a3z9/8cwYXQ4I6PuK?=
 =?us-ascii?Q?qqXlnWq6keQf9Q7hHrEuErc/OiKgdd5jUPjvRoYywIZST54Cy7UBvIY5IgPt?=
 =?us-ascii?Q?CkhukwC/Df0bkZfW64J+GtdLeApECKg+HBTLNASzu4G+lCr+su2NNmE0EPNI?=
 =?us-ascii?Q?BJ+y7kSYDrglRt57UJR9q4Tv7WnhoONzxmCklUINglErbfN1kxU4/2z/jhqO?=
 =?us-ascii?Q?B17IC6MriIF/Kw7jGGS9ntBpC4/VWX/RHqtFaxBIuNFtvX+FrPEBimBkHqpK?=
 =?us-ascii?Q?Gz37UBlZ7tUj+WGeBWcPveysbnEVXlYV6qehH+zwYJQFX9nrcC4V12HzOozT?=
 =?us-ascii?Q?w1v99ldpsQ6Pu0YTkM6aVZDZYjU9he+Y6kOKlf6biYUQ7OSP4vEUIdoawrc5?=
 =?us-ascii?Q?hR/7hLj40kWRzgsYAMy09U1XwRA5Xlcq92flSDUMJ7d4Li2nlspemBF0vqTv?=
 =?us-ascii?Q?arJKjxmit3mJo1N7mE9T9O6BALgrK+FEi22NoCfHMV4nmwEnLDO3CccsUJcB?=
 =?us-ascii?Q?hsCeNOwJekfCT0PSb6cOHVrR6E8PINsX/OXPwFy7sPRjfQlBqc17R4/iPi33?=
 =?us-ascii?Q?+PTSsFL+5ju1ewUZFyoVS81YAmnC1MMvRPZn+k6mGK94KCUogKVVQIWPlNTA?=
 =?us-ascii?Q?tjb6ELv01Pe5CAVNnWfK8C84iwUVzpTS6E9hpecsgcwOVcUM3+6vOw9QSoW/?=
 =?us-ascii?Q?Ch5NrMOjVhPbUYi+r0/7u/sJjXbUDwQZswRjvhIwMIhx+sOO/sUwECrMBoZL?=
 =?us-ascii?Q?aB13arDv9Q5wpyjAsnVXZ48G8dJj0kHO56N38iJDz4L8nmdD3+Chkg9Pk/eE?=
 =?us-ascii?Q?w27CagJYAAydkZE865XIBfylR3uqdy/H5VKg78x8am+8mWeZv+Tam6XQn+1H?=
 =?us-ascii?Q?laBQhTJJmCGK83VlRMkYnLncg63lpDdsU3IkVkE2SZ67NvQdAl/KMOZJhHI6?=
 =?us-ascii?Q?H3GYUIfI69GePtagOc/vGGhQCNahHDe0UB7k4NDirqhkxOtYuVBSymik5+hc?=
 =?us-ascii?Q?pY7sBWov+4bZSmOQ8cliH3wiLKo8VkOXWOYswCQCqON6NlKAsloHBr+oFIP2?=
 =?us-ascii?Q?+bRQKHoHUtkS/Qgi/jGD14NsgaNUkMhI7mYTQRTn0YUuqSUaLDs022HUGYBs?=
 =?us-ascii?Q?yUma7jSgtMH8iTs6JENqgChcDp0P4YtnAnFwWov7DXzC5W0RSo872eSZExnv?=
 =?us-ascii?Q?76ZqUuxLxZXeR8OUh33sAx6uCHX3hLSlFa791+G1dKHcAf9JPepiWGNDPp7q?=
 =?us-ascii?Q?gIehzfhazqiFkVFXCXXqgVHehZPGSlZ3ZaKXvY7PpUH1LNTFhDQJVy5xZRko?=
 =?us-ascii?Q?VpsCJeyU1PVLZBZLrRTTWywYBz+aJ3jEC6n3nL8UqN7BHIxdg7imosmnMaPl?=
 =?us-ascii?Q?27iCi9No/a86LElf5Y8c/2gAEcM7b8UekyG8KGkS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288b5d80-461d-400d-5738-08db8d4229ad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:05:51.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SqhBgQg2/f9Wwb/YXeiJeoPc7P/DNuE7nZJMUycu6WlwVRzrzvgL3bvnoXgrUdfL
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

The access must be detached first.

To make the cleanup simpler copy the fdno to userspace before creating the
access in the first place. Then there is no need to unwind after
iommufd_access_attach.

Fixes: 54b47585db66 ("iommufd: Create access in vfio_iommufd_emulated_bind()")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/selftest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 74c2076105d486..65c8b6ad2504f0 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -716,6 +716,10 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 		rc = -ENOMEM;
 		goto out_free_staccess;
 	}
+	cmd->create_access.out_access_fd = fdno;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+	if (rc)
+		goto out_put_fdno;
 
 	access = iommufd_access_create(
 		ucmd->ictx,
@@ -727,11 +731,8 @@ static int iommufd_test_create_access(struct iommufd_ucmd *ucmd,
 		rc = PTR_ERR(access);
 		goto out_put_fdno;
 	}
+
 	rc = iommufd_access_attach(access, ioas_id);
-	if (rc)
-		goto out_destroy;
-	cmd->create_access.out_access_fd = fdno;
-	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_destroy;
 
-- 
2.41.0

