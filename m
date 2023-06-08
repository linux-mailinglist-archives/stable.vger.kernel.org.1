Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A6728A29
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjFHVUB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjFHVT7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:19:59 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44F62D52
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:19:58 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358KtDKF026661;
        Thu, 8 Jun 2023 14:19:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=PPS06212021;
 bh=HQrQnNJox3RHvorOtnWF8Vay7DaxBdl7finLB5bWNJQ=;
 b=VqjwN7OUPRjqF92SGuYwxQFSNe2uC0VmNu+agGkBB+p3YkINBM2+S/ztwGphH6SlLr2M
 nBNYmRZTnv/Bcud1D3+uvlVovCuDnqpoYLLphbZJzpjNI/LJtlAcG7gJhdaagvdmpnv0
 WXSwqzVE7qv4Auccduj/JN5X1FeqwYfgeVszRlcv+eow/Bt1SxG/USDRRmgI2RgEhZvM
 juXcMk720n5RQhFCQMl6mcCq2U6V75D8uYnnsbCL8eIOKkofIUGhhIIQ8vtoHBh+gdPY
 UUiz9G8qu4kUJF+FVEgAbZvBkQIbKZ2Cy1/K7GsuGFVmR1VhoQOTVFvzmR+VA73wOH51 Cw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2a80t423-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 14:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyTC1Gu9ggCKb2FrCK3bXQAk4Jm6MGWi7xIZYDCpSOO4BlN4Jvh97W2tFV1EALWPJa8Ux03u5RBWDiHpmsXEzjcAN9mscdIC7u7sRHA9quHcRqccY2jUv4jX5wtePea0XIy3hdKFq4Ew8+Qz3TqvatwIoWj8USpeDDk0SIfhdY+mjpjR1/HrTZPukboy1sAbJYPcO3SBigUavdW58g/7v2dfFGaYfKEfnKpP1Z+hXqu5beh4ZFonfo03/8xm7udtJ/3LzGgjQU0Ep59f/UfMI8eMTbcjMUQgWPse7ROL2zkecGvZbRd+15NgmZztBDmj1uDZfFuowU83oS+qchWrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQrQnNJox3RHvorOtnWF8Vay7DaxBdl7finLB5bWNJQ=;
 b=km0EqeMl6wZ01YO2GsZ4vjk8m7nHh9qCgG/wAoe3xZCfGhnv2TMBBA5CRZoYso6JOM/e3kj0xz+z+7euJug2Dt5l42HvFethttk1CF7W4SgVUcpzW6yIpAUA8DFnCon17+Q9Ywzqyldrud0cAc8HjEdq3oC4wvFzOGNFn79OeCE+l7+GQ1KNFDpT7hrAx0Sm90JhfL8EmkxXo9mLkRe0rVnOTZ5qiqhHWka6n5BDuYG/oM/WAJzP9fOVqU24UVU5IRUoIozwZrIh2Em7RWrQmqzdy3z4mMPet5ZuuiUpczfdoUoX3NEPikBzT5VMbfdj9+sFaWaj4H0TFmBgbeUUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 21:19:53 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 21:19:53 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Zixuan Fu <r33s3n6@gmail.com>, David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.4 PATCH 2/2] btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()
Date:   Fri,  9 Jun 2023 00:20:58 +0300
Message-Id: <20230608212058.8477-2-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608212058.8477-1-stefan.ghinea@windriver.com>
References: <20230608212058.8477-1-stefan.ghinea@windriver.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 78fc6b99-a5ec-4743-a081-08db686619fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eyWutKQ35Gr3K/HtqcIWUeKogQnbNii/DxVsZnJFEPWDCrDA1y6zCRfTj7d89SbHwFb5/Hh4eFan6uZmYrjS2zp/EllIW5T4ERm5sZboobzwh+r3FvTsdOtpdlNWqaBQRBaAaIZmOsr5VOmOUQ8UF/7buiY+VXtqqXsDTG4klT5hnu8CuU33eC0fLcp8hoUPGLEb6nZWr/Z780lhLae84jSXWh5DAV299EbY4ip9XJZoL5EtkwlNte0Eidkff596Pjm4qLhv96J9ZK7BXYeWXLLLaqMRqyF2NanLFzaQpLAHxt0W646GJgYTTca84igaGRwJLk0yJVCh9dQgwVRvF68JOuv3OowW0GzA981Q/CwrGMEuQ/wAA77BsPMcOhNfu+/7f2YEIlwVMo6njkybhJdkFcMNRvIiBfVvjFY6sdeOzQI91XzRMKeRI/zYM4Xz4k6NCrj9+9YtqlePR0lvms8le8KlksChd1qIDoNEqT1Dk3IxrMMBSFhHUfyPI7VIvvviu3k9XVrV1hW8Pcfj2uLwA3OQY7NXPsufNg5se0QxGA0LLtFAkeTZnZRCLrdf9MttKimlI2tOy+sN6t5+kpyTn5or8Pgh6FNJk7jhFtcMCEPqhrERnj8PHbODB36j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(451199021)(6506007)(1076003)(36756003)(26005)(83380400001)(41300700001)(186003)(107886003)(6512007)(5660300002)(8676002)(54906003)(478600001)(8936002)(66946007)(4326008)(66556008)(66476007)(6486002)(316002)(38350700002)(38100700002)(2906002)(52116002)(6916009)(86362001)(44832011)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?02M15aZVnU66I8d1qfBLzf9C73RWBM6EMeOp8EatSKmbvag5B4OdVwRZOLhd?=
 =?us-ascii?Q?FZknqsUF027JwcWKDaW/TcXe1EkTWHhPu1GMao7YMS6dTGFnLKN6LYvK9fnV?=
 =?us-ascii?Q?tVMKfC4Z487XYrdU80nXlb0rD+84T6YNdM0Yp0vJVPfwHbdiPnaj9o4LCozE?=
 =?us-ascii?Q?g7FPCNf4KE9lrhUIXNCZPxyI7GboQbtz/AdYQus2GU/+EzNE/jdBdTyseZu2?=
 =?us-ascii?Q?aP/5QOB/quPLPbDgq66jPUx6AiKLcwOTeRn1IT8U5fjhfO4wzAjyP/FC1uLv?=
 =?us-ascii?Q?eizl6rEP/kqpJPddi3f0puzkzYLD0XyJImiJFXWhBHcI/izOLAN5Jw76cfG1?=
 =?us-ascii?Q?y18Ntgz4tdFsT39QdDPZw7OfVY7LFYkET+jPLzO0KsJWR4G9yssri7SH7wux?=
 =?us-ascii?Q?rH9TZDTOzfWLY1ha93jdksUcvlo5k3zPHQcLomzk6Qi9zcUJ1Cs4E1OdbGBQ?=
 =?us-ascii?Q?u9dEET2ji2fQ76SuF6srjKs2eiuFSOZGsDT4C4FRE0xE1KqsUiDBrZr0Kad9?=
 =?us-ascii?Q?XtTogGEnbMxb1xrXO6yjMpMuldjwF3UsaHCwAaljbwVQlIBEA68U5gyfHEec?=
 =?us-ascii?Q?fb8cXzGnsKkM3TtBBnI4J1O0RfMN2QF5yxqtFilAdMyIBOLuv+mTN/NhjFkS?=
 =?us-ascii?Q?ocTexXBhOxI63F3CYKvqXzzd0g4Rx3IN6HNnPMzG/+ciykULBw5SWOWdgATJ?=
 =?us-ascii?Q?jy71YSrBHChRCoudWebfQ38uidiN/WJ8mm2S9R2fEwmh68A3NSyYg9Rn7CWs?=
 =?us-ascii?Q?IPcmRskTBgcwgzG+q8zriCDGp1mhF5PJwmlbR4vNGLoWnEpsw7eeyIaaX2j6?=
 =?us-ascii?Q?4DyyRkvyHlUJv1WXEVMBK902JlfrqI7Xeex0rA48QDBlxE7S3eng7BPe4d+m?=
 =?us-ascii?Q?LQGnHeetzt5vfRjGoHijStLLj52MTV6AW1OSRYk/EtTrWwgvW8P243HbMEYJ?=
 =?us-ascii?Q?IGp3kGZOP4g1I8tOUbdIX0gnd9cJFVZu6TbWpUnD8zVUVLFH2hp45+133gFq?=
 =?us-ascii?Q?lqQ4cKKjIs8KwOBvKITJCOKdPoUNVOZLA3gOZFCJw9vNFNIHtwEug3cPO5Ns?=
 =?us-ascii?Q?lNghaORBhb45n3nyuTMZS5eo+fmK9c3dHCGALGEHj4KWUxOox/3R4W3ohebq?=
 =?us-ascii?Q?UdjpPANk50sS1UN5XjulrXwCEEpiHokm7vK/9SZFMwZt9czG92Yg3gcfWj0d?=
 =?us-ascii?Q?YDwCZDuDtx/MijIAvzqP16Ab+OdhM8T41yuxKQDYNoJa6+u0l3Ard91yRTpg?=
 =?us-ascii?Q?NjHfbgi9VhMuD8zzJNqNKXnR7GPRPYcFVO8YAlWGPLXMmDCiu+DrJ8d/9RWx?=
 =?us-ascii?Q?SBsOmF9eDznz762/Y/t87vXiZ9iE7pQml6OT3c2stnR6boAtn0VdFSYzRNdz?=
 =?us-ascii?Q?KENQyP08TBZg9Om4uQD1DNtg0HcAMxrNoG1cvvEvPzVb2eJUyh6P1L8UG22i?=
 =?us-ascii?Q?W/74lv9a8SjjKXZQcnYgebqL5Yb0rEmPQdF/wsPlPc0X/nrtynfbVu8hf2yC?=
 =?us-ascii?Q?xc22MzTbKYys5L31kQh/kdPlCeT6w2z3qMFZWMtMRv7FcGmNWMVSF/En45dz?=
 =?us-ascii?Q?kp7wFC/6XQLlLyXdWI2LnO7vewraY5sOgNtejh94Aj6Uh0R5oxReaCB5M0Py?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78fc6b99-a5ec-4743-a081-08db686619fa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:19:53.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLbYq823vH+FgHUug8OYX6FDQKLbk0TQzfoTqSNvCpySGLfnUc1iyUgXc3QHtWkELjZBkPRewt+oiqnFu3RC6jA0rTbbQ50qiKzf+S+T+EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-Proofpoint-GUID: sXcK7-9l0n6Moy6RmeogmIeawJfTu4EC
X-Proofpoint-ORIG-GUID: sXcK7-9l0n6Moy6RmeogmIeawJfTu4EC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306080184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zixuan Fu <r33s3n6@gmail.com>

commit 85f02d6c856b9f3a0acf5219de6e32f58b9778eb upstream

In btrfs_relocate_block_group(), the rc is allocated.  Then
btrfs_relocate_block_group() calls

relocate_block_group()
  prepare_to_relocate()
    set_reloc_control()

that assigns rc to the variable fs_info->reloc_ctl. When
prepare_to_relocate() returns, it calls

btrfs_commit_transaction()
  btrfs_start_dirty_block_groups()
    btrfs_alloc_path()
      kmem_cache_zalloc()

which may fail for example (or other errors could happen). When the
failure occurs, btrfs_relocate_block_group() detects the error and frees
rc and doesn't set fs_info->reloc_ctl to NULL. After that, in
btrfs_init_reloc_root(), rc is retrieved from fs_info->reloc_ctl and
then used, which may cause a use-after-free bug.

This possible bug can be triggered by calling btrfs_ioctl_balance()
before calling btrfs_ioctl_defrag().

To fix this possible bug, in prepare_to_relocate(), check if
btrfs_commit_transaction() fails. If the failure occurs,
unset_reloc_control() is called to set fs_info->reloc_ctl to NULL.

The error log in our fault-injection testing is shown as follows:

  [   58.751070] BUG: KASAN: use-after-free in btrfs_init_reloc_root+0x7ca/0x920 [btrfs]
  ...
  [   58.753577] Call Trace:
  ...
  [   58.755800]  kasan_report+0x45/0x60
  [   58.756066]  btrfs_init_reloc_root+0x7ca/0x920 [btrfs]
  [   58.757304]  record_root_in_trans+0x792/0xa10 [btrfs]
  [   58.757748]  btrfs_record_root_in_trans+0x463/0x4f0 [btrfs]
  [   58.758231]  start_transaction+0x896/0x2950 [btrfs]
  [   58.758661]  btrfs_defrag_root+0x250/0xc00 [btrfs]
  [   58.759083]  btrfs_ioctl_defrag+0x467/0xa00 [btrfs]
  [   58.759513]  btrfs_ioctl+0x3c95/0x114e0 [btrfs]
  ...
  [   58.768510] Allocated by task 23683:
  [   58.768777]  ____kasan_kmalloc+0xb5/0xf0
  [   58.769069]  __kmalloc+0x227/0x3d0
  [   58.769325]  alloc_reloc_control+0x10a/0x3d0 [btrfs]
  [   58.769755]  btrfs_relocate_block_group+0x7aa/0x1e20 [btrfs]
  [   58.770228]  btrfs_relocate_chunk+0xf1/0x760 [btrfs]
  [   58.770655]  __btrfs_balance+0x1326/0x1f10 [btrfs]
  [   58.771071]  btrfs_balance+0x3150/0x3d30 [btrfs]
  [   58.771472]  btrfs_ioctl_balance+0xd84/0x1410 [btrfs]
  [   58.771902]  btrfs_ioctl+0x4caa/0x114e0 [btrfs]
  ...
  [   58.773337] Freed by task 23683:
  ...
  [   58.774815]  kfree+0xda/0x2b0
  [   58.775038]  free_reloc_control+0x1d6/0x220 [btrfs]
  [   58.775465]  btrfs_relocate_block_group+0x115c/0x1e20 [btrfs]
  [   58.775944]  btrfs_relocate_chunk+0xf1/0x760 [btrfs]
  [   58.776369]  __btrfs_balance+0x1326/0x1f10 [btrfs]
  [   58.776784]  btrfs_balance+0x3150/0x3d30 [btrfs]
  [   58.777185]  btrfs_ioctl_balance+0xd84/0x1410 [btrfs]
  [   58.777621]  btrfs_ioctl+0x4caa/0x114e0 [btrfs]
  ...

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Zixuan Fu <r33s3n6@gmail.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c19686342057..e603cc8c141e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4102,7 +4102,12 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	return btrfs_commit_transaction(trans);
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
+		unset_reloc_control(rc);
+
+	return ret;
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
-- 
2.40.1

