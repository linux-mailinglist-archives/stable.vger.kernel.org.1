Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9A762200
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjGYTF6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 15:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjGYTF5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 15:05:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C42F7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 12:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHgZVKrrVW1rA654dQKxR053Kqxy9sHWPhHpKt+e8ii8YD3ey1dIviVebxfdNGBudTIOuQEDxfZ5GmANfQBJDCJTH9/PsEBAOsCNSSicFRGfXZBQLx4GbxFR5G97ZeaHEnsZSGSZ24A5kKcRCqxDg9s6ZbCZOMykLkTGQ0w4FrCmpGU354q3le2/1XNMo0hYnAu04h4yS4XVM7JBFK1mWCDrrgulv8We2vg15Z362KokM3GsJCZNJP8AwLMu2sK6lqciWLaLqyh/zxOjhVccXJftYPJZGRJlZ27/lCWxUH8qQOvvboxdXSAJAwFfD7xgRZgVVjPUm4HCJ7HvFYfxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaa9LxbXWbQYXQK7cfAnF3/T4Fz3c+f2NKRYmCOcN0w=;
 b=CSIWgXUpnxRau7eg/EEb9qrW/HbOjq1jd8tXImUs7TKnj7R3W7isG5I/U+RVz8WAJstCMHKTNNZltNGCHSmKw5ZMDqjgcL0BM2PqugVr3Y3aO78Q3m17Dg+F7GcT3cn2m4s3XXPedXqaqylp/cZb+dVUIav7PU5l6AVkn5++8voKvVEciXYyck8qRgBzW6WjB/GvyZ8M4jCVBB9XwJKLv4Ns5TRsAW3y6rx79SS5h2+eQkZEOk+Habt5cXbhOCFf4loCHYI8CBMoUCQyYb1EPssOT25YDxSW6dPZB8Pbnez8wJy81qv3NPUQn1KE+GjcrtlwuxiMhSPydIlrPD0Qfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaa9LxbXWbQYXQK7cfAnF3/T4Fz3c+f2NKRYmCOcN0w=;
 b=Hzi4rPtD/MnmnNvYdOsldFPovI204RZDbBd8shkKfXc+EUnDAWFTiU2JxIB95ita+gqfvKZlb6fBjIaE++XK2A7AHFxEXUD5lQKLGGJdZTDyeTOzkSb5oCMrLJ7oobYXSgwa7hm1wQrATHHVqCpzD0Jdlyi2LIsmJur4VE3iSuPkrsbzL1J0jz/B5MoJbtn/MCmG2CjvAhRItOlSQ2DBAv8cSNC/QlKPxxRYnHSPkNBXASDt9ov1jzpcbbOF6FAlPUR2Fl94Ww+gpl5vbG8U0i/iuAXmu14R2nStrgqHYhoTzNWHfjDXnFeycLgUlL3qWkDqUgfvLNO0QNK0CoQ03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 19:05:53 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 19:05:53 +0000
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
Subject: [PATCH rc 2/3] iommufd: IOMMUFD_DESTROY should not increase the refcount
Date:   Tue, 25 Jul 2023 16:05:49 -0300
Message-ID: <2-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
In-Reply-To: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0002.namprd18.prod.outlook.com
 (2603:10b6:208:23c::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: e53e81e6-4dbd-4cdb-b85b-08db8d4229ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oL3MhuUVAcm0Rxzi4dyt8KhGE28m8Yntegn9rfxHrK7h8H1j9MQ8QVDZpjHLR7umcNUnk9KzT+xAf50a3EElzT+BuLdaecFF1BDPBPJGxcxWSIHkfDlO5VMjOFkS3+s2kpX3kfXy5U60zqLVTs0Vgkdah7FF5NQ0BCiUeLvjJLIcjil4xzjTAkFySdtqYMlWT/CYZsDnGNaW3lm0ZRbb1yncRF5NKJ5TlQ+RYwE6Vw6g6Cr7AIFdENAfzu2YPchYWPVidH7tt/LsatvbruPRfHJOptOtsHwYkOnD0UrxGKgAMTV55GbQ4yB7WndAMUHxHJkUeyLwgj8m4u30xc4m9mYr/1T76Ev2bdfqICGfIISegKXs4mpV/rS35+xAVHWqTRarrFZg6ERl/BWUZ0Kpbbf8me6Ix1N/Qqqnpun/fDXYpt1Ibjrny8a3RznHF2tLCwTQoI7LPOFJoO1qR84mDVjrutnUICVC/Q8Le+/3BiQ/lGtj12zjFqngYWHLCEtDBPaZ3dIajAYMMWTt8h2vg5DXF4XI9KeQ1z/P2olLa/4j2wLMoKmi3A51Nx+jsZ4X4avZS5Ce179lAyRi7LJ9yh2uxQSJMNOqLZ8c0xkDWdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(2906002)(6666004)(66556008)(45080400002)(8676002)(478600001)(6486002)(7416002)(36756003)(4326008)(66946007)(316002)(66476007)(54906003)(6916009)(41300700001)(83380400001)(186003)(38100700002)(2616005)(6512007)(5660300002)(8936002)(86362001)(6506007)(26005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rtpyt8TimCPdWyQF7N0FigxFh006PisPlmZ5/vyTQEUwkHKTO6j4Rmw3e1Iy?=
 =?us-ascii?Q?9ZCSDpLk0oPRTdtbALAVY5zWzPUdOYNJcsFgdCiHJXW625rmeVUkllrK2+bY?=
 =?us-ascii?Q?E8kzA7PMdMqpZEby0V1pf10ZXDmymm+8+k1BhvknQM9/tgx9axx6qdYMh2kN?=
 =?us-ascii?Q?Bap3/+OVCWhtalj4ZVcZuVM2Hlg2KzRbA6yxMQ8qE6fMeHzSEjyM0MybycMq?=
 =?us-ascii?Q?ysyip7t6HUO9FBdEPMm3xbIHFl+w6i/IEfK3Y8eNAkrcsB412QUfOrYayE+S?=
 =?us-ascii?Q?8ozvKq44TNtmkVVmaW4bNE7iZ7a8p4+w+rkeAm2U2XRor+NJNBn6+48X9e9D?=
 =?us-ascii?Q?Yu2jf/hZ8Dnq8hcZiAaGGK0LTO+jq++5BK4lVBXsQBW38GQD29TmFk5uW5kY?=
 =?us-ascii?Q?YRTZhC547f5GUiWuy8QB6AMT22UQ73LT59aRxG8kjlE34dkDGacyN7MUVhs3?=
 =?us-ascii?Q?lMMnU5POrW7nqo/hfvzEZkSc0zgMB8v5Vf5hBIll07sKu5URyVbolcapbC2d?=
 =?us-ascii?Q?LXZ4wqGyowZw1edMqQ1rvC+Ty6qzPO1qJki17ti19yaSBq2m+XYFo3rdApwd?=
 =?us-ascii?Q?BCFuB1OGOj88c2sMQHaw/+rWTiEauDEHvqirZts9qNoMiLdErx4vc8OdrP20?=
 =?us-ascii?Q?E8K11XjLZEiWVgGDEvUahQxvM8oIn/lC6mNgiG1YsryzPkaTiWhFMKxUWYbR?=
 =?us-ascii?Q?JC5bogCEtRL7kXpTQV/JDJW6yuLakIpO4sMV/Svydu8GfPFyoI9cGSzTBUXy?=
 =?us-ascii?Q?HE+BGbvyWB4Q6FgnT5tpkYCN7PhxCfnqamw+zkrS5xA3Gx6FA1AWjj88ywfQ?=
 =?us-ascii?Q?Z1QCaOecXiPQbvmurNdTbdfD3ZMsnUDdGTb6DVa96AlGcymJjoIxOvRFJPbo?=
 =?us-ascii?Q?Xi2g91GU+1ld1kPyM1VlMV7ALq3/SCIiun0OnO45FkduHNdASTUw9iTSGf+3?=
 =?us-ascii?Q?+XHJ7EP3OTjxZeNqo3u8mHRNtQZiiYHoYYLjHGWgm/Q04HJ58glt0u2cPpPy?=
 =?us-ascii?Q?HHOxzk3miK27HNWOz0ubWbMp6eudaVtqVNI5MLfUbRVaui5a+kNbWULajdZM?=
 =?us-ascii?Q?tMhiSpRCtOF09h6Fo5z6B7pNpxZOoaHvNSlf66NclWt4MgOM5Md1mMr/2Bf3?=
 =?us-ascii?Q?i18XPDAHBQxjVhcMl4u4K+szLmOqg+bOWK4ssj/ywhq25Yh+HJdk0WPvd4FY?=
 =?us-ascii?Q?o2AMNSmJ3L5By98f2lwJi8XVgMJE8wuP7GEH72UptGi7/PnYSCgQdKkmJZyb?=
 =?us-ascii?Q?5ODXz2CATlmdqx+kveAI4Pax6zsFSf59sTAlj/KGyZHXUdahW+8sJhCNCKK7?=
 =?us-ascii?Q?GB+dXx4tWaaZ5X+LdpCbWZ4p05SrHGeot/xEGk2DYK7RLwpe/VnS5zc13qDV?=
 =?us-ascii?Q?QlqK+tkfiaX4BEwhHSySTJ3iO+e00FYQHmwcgy3imLsdwq8Kupj+P1YvamI3?=
 =?us-ascii?Q?jQVF00Up2MUY4+lEVuODbX+BFIjBeAsHi+xr4VxmcEiWQIxwYAPsZaYOv85K?=
 =?us-ascii?Q?XVmsBNs327jntDKXQKoz83quLZmFMV31++O3uX3jqFZEDT9fsdaJsgPs4aRK?=
 =?us-ascii?Q?AwNrdUAhtBayDEMOga6VmYjv8MYECOaWbnmzkpzT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53e81e6-4dbd-4cdb-b85b-08db8d4229ed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 19:05:51.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txvsW3eXMamN7HpdbCjri0mnSWN1DMiml2Pbcpa/r+ZWjViBtsv/IFczJtmhLShn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

syzkaller found a race where IOMMUFD_DESTROY increments the refcount:

       obj = iommufd_get_object(ucmd->ictx, cmd->id, IOMMUFD_OBJ_ANY);
       if (IS_ERR(obj))
               return PTR_ERR(obj);
       iommufd_ref_to_users(obj);
       /* See iommufd_ref_to_users() */
       if (!iommufd_object_destroy_user(ucmd->ictx, obj))

As part of the sequence to join the two existing primitives together.

Allowing the refcount the be elevated without holding the destroy_rwsem
violates the assumption that all temporary refcoutn elevations are
protected by destroy_rwsem. Racing IOMMUFD_DESTROY with
iommufd_object_destroy_user() will cause spurious failures:

  WARNING: CPU: 0 PID: 3076 at drivers/iommu/iommufd/device.c:477 iommufd_access_destroy+0x18/0x20 drivers/iommu/iommufd/device.c:478
  Modules linked in:
  CPU: 0 PID: 3076 Comm: syz-executor.0 Not tainted 6.3.0-rc1-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
  RIP: 0010:iommufd_access_destroy+0x18/0x20 drivers/iommu/iommufd/device.c:477
  Code: e8 3d 4e 00 00 84 c0 74 01 c3 0f 0b c3 0f 1f 44 00 00 f3 0f 1e fa 48 89 fe 48 8b bf a8 00 00 00 e8 1d 4e 00 00 84 c0 74 01 c3 <0f> 0b c3 0f 1f 44 00 00 41 57 41 56 41 55 4c 8d ae d0 00 00 00 41
  RSP: 0018:ffffc90003067e08 EFLAGS: 00010246
  RAX: 0000000000000000 RBX: ffff888109ea0300 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: 0000000000000000 RDI: 00000000ffffffff
  RBP: 0000000000000004 R08: 0000000000000000 R09: ffff88810bbb3500
  R10: ffff88810bbb3e48 R11: 0000000000000000 R12: ffffc90003067e88
  R13: ffffc90003067ea8 R14: ffff888101249800 R15: 00000000fffffffe
  FS:  00007ff7254fe6c0(0000) GS:ffff888237c00000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000555557262da8 CR3: 000000010a6fd000 CR4: 0000000000350ef0
  Call Trace:
   <TASK>
   iommufd_test_create_access drivers/iommu/iommufd/selftest.c:596 [inline]
   iommufd_test+0x71c/0xcf0 drivers/iommu/iommufd/selftest.c:813
   iommufd_fops_ioctl+0x10f/0x1b0 drivers/iommu/iommufd/main.c:337
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:870 [inline]
   __se_sys_ioctl fs/ioctl.c:856 [inline]
   __x64_sys_ioctl+0x84/0xc0 fs/ioctl.c:856
   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
   do_syscall_64+0x38/0x80 arch/x86/entry/common.c:80
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

The solution is to not increment the refcount on the IOMMUFD_DESTROY path
at all. Instead use the xa_lock to serialize everything. The refcount
check == 1 and xa_erase can be done under a single critical region. This
avoids the need for any refcount incrementing.

It has the downside that if userspace races destroy with other operations
it will get an EBUSY instead of waiting, but this is kind of racing is
already dangerous.

Fixes: 2ff4bed7fee7 ("iommufd: File descriptor, context, kconfig and makefiles")
Reported-by: syzbot+7574ebfe589049630608@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c          | 12 +---
 drivers/iommu/iommufd/iommufd_private.h | 15 ++++-
 drivers/iommu/iommufd/main.c            | 78 +++++++++++++++++++------
 3 files changed, 75 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 29d05663d4d17a..ed2937a4e196f6 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -109,10 +109,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
  */
 void iommufd_device_unbind(struct iommufd_device *idev)
 {
-	bool was_destroyed;
-
-	was_destroyed = iommufd_object_destroy_user(idev->ictx, &idev->obj);
-	WARN_ON(!was_destroyed);
+	iommufd_object_destroy_user(idev->ictx, &idev->obj);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
 
@@ -382,7 +379,7 @@ void iommufd_device_detach(struct iommufd_device *idev)
 	mutex_unlock(&hwpt->devices_lock);
 
 	if (hwpt->auto_domain)
-		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
+		iommufd_object_deref_user(idev->ictx, &hwpt->obj);
 	else
 		refcount_dec(&hwpt->obj.users);
 
@@ -456,10 +453,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_create, IOMMUFD);
  */
 void iommufd_access_destroy(struct iommufd_access *access)
 {
-	bool was_destroyed;
-
-	was_destroyed = iommufd_object_destroy_user(access->ictx, &access->obj);
-	WARN_ON(!was_destroyed);
+	iommufd_object_destroy_user(access->ictx, &access->obj);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
 
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b38e67d1988bdb..f9790983699ce6 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -176,8 +176,19 @@ void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 				      struct iommufd_object *obj);
 void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
-bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
-				 struct iommufd_object *obj);
+void __iommufd_object_destroy_user(struct iommufd_ctx *ictx,
+				   struct iommufd_object *obj, bool allow_fail);
+static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
+					       struct iommufd_object *obj)
+{
+	__iommufd_object_destroy_user(ictx, obj, false);
+}
+static inline void iommufd_object_deref_user(struct iommufd_ctx *ictx,
+					     struct iommufd_object *obj)
+{
+	__iommufd_object_destroy_user(ictx, obj, true);
+}
+
 struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
 					     size_t size,
 					     enum iommufd_object_type type);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3fbe636c3d8a69..69387f9ef7f14c 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -116,14 +116,56 @@ struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
 	return obj;
 }
 
+/*
+ * Remove the given object id from the xarray if the only reference to the
+ * object is held by the xarray. The caller must call ops destroy().
+ */
+static struct iommufd_object *iommufd_object_remove(struct iommufd_ctx *ictx,
+						    u32 id, bool extra_put)
+{
+	struct iommufd_object *obj;
+	XA_STATE(xas, &ictx->objects, id);
+
+	xa_lock(&ictx->objects);
+	obj = xas_load(&xas);
+	if (xa_is_zero(obj) || !obj) {
+		obj = ERR_PTR(-ENOENT);
+		goto out_xa;
+	}
+
+	/*
+	 * If the caller is holding a ref on obj we put it here under the
+	 * spinlock.
+	 */
+	if (extra_put)
+		refcount_dec(&obj->users);
+
+	if (!refcount_dec_if_one(&obj->users)) {
+		obj = ERR_PTR(-EBUSY);
+		goto out_xa;
+	}
+
+	xas_store(&xas, NULL);
+	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
+		ictx->vfio_ioas = NULL;
+
+out_xa:
+	xa_unlock(&ictx->objects);
+
+	/* The returned object reference count is zero */
+	return obj;
+}
+
 /*
  * The caller holds a users refcount and wants to destroy the object. Returns
  * true if the object was destroyed. In all cases the caller no longer has a
  * reference on obj.
  */
-bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
-				 struct iommufd_object *obj)
+void __iommufd_object_destroy_user(struct iommufd_ctx *ictx,
+				   struct iommufd_object *obj, bool allow_fail)
 {
+	struct iommufd_object *ret;
+
 	/*
 	 * The purpose of the destroy_rwsem is to ensure deterministic
 	 * destruction of objects used by external drivers and destroyed by this
@@ -131,22 +173,22 @@ bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
 	 * side of this, such as during ioctl execution.
 	 */
 	down_write(&obj->destroy_rwsem);
-	xa_lock(&ictx->objects);
-	refcount_dec(&obj->users);
-	if (!refcount_dec_if_one(&obj->users)) {
-		xa_unlock(&ictx->objects);
-		up_write(&obj->destroy_rwsem);
-		return false;
-	}
-	__xa_erase(&ictx->objects, obj->id);
-	if (ictx->vfio_ioas && &ictx->vfio_ioas->obj == obj)
-		ictx->vfio_ioas = NULL;
-	xa_unlock(&ictx->objects);
+	ret = iommufd_object_remove(ictx, obj->id, true);
 	up_write(&obj->destroy_rwsem);
 
+	if (allow_fail && IS_ERR(ret))
+		return;
+
+	/*
+	 * If there is a bug and we couldn't destroy the object then we did put
+	 * back the callers refcount and will eventually try to free it again
+	 * during close.
+	 */
+	if (WARN_ON(IS_ERR(ret)))
+		return;
+
 	iommufd_object_ops[obj->type].destroy(obj);
 	kfree(obj);
-	return true;
 }
 
 static int iommufd_destroy(struct iommufd_ucmd *ucmd)
@@ -154,13 +196,11 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
 	struct iommu_destroy *cmd = ucmd->cmd;
 	struct iommufd_object *obj;
 
-	obj = iommufd_get_object(ucmd->ictx, cmd->id, IOMMUFD_OBJ_ANY);
+	obj = iommufd_object_remove(ucmd->ictx, cmd->id, false);
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
-	iommufd_ref_to_users(obj);
-	/* See iommufd_ref_to_users() */
-	if (!iommufd_object_destroy_user(ucmd->ictx, obj))
-		return -EBUSY;
+	iommufd_object_ops[obj->type].destroy(obj);
+	kfree(obj);
 	return 0;
 }
 
-- 
2.41.0

