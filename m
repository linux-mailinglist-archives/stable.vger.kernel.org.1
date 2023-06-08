Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CBE728A2F
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjFHVVR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjFHVVQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:21:16 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67A2D7B
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:21:15 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358KtDKK026661;
        Thu, 8 Jun 2023 14:21:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=PPS06212021;
 bh=b5RfH3HqMk9k+YaQX4TeAD8sm+Ko+d74ydITCJK1lAA=;
 b=N17144MRK8WPV8EVbfpuQrHsS/vSzyS9rMI2GJfc/61v46afVKiYZGm8WHpZrIDDnzc+
 n77Rbh+2pNJlOrhYCa+TGLRcjJvngUM0FjbZhcqrghw7zZij5shhoI02TTOIr3FehJ8w
 7sxynzSk0dVbSklg6Nh30v0aZtpICrDvbOsXLMR/5Bmihrfdyfwy6UPzQbieBU0iAGqx
 ebCDCsBaODyAMKZVF7rTypTdLPeuOnFiq+u2jnLGbg1HZeO5OEIr4Ud57ZKuGtWytkwK
 GlQJBWCVjv4G0dzSiIHLcBMD7Y9p7BH7CN2x8AWWLcGGOCiIaG7r6zsZA1C0VNyb/PCX /A== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2a80t43f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 14:21:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLUtStaGdiFsPQassdEXesUIPW9q3NT81EXxTLQu/7TYGjWsLvAbNV3g4yQ6Cdtp7o0l/SzM+5bQslVzlVwa0347q+AXtwqH+zw48XqC/HxtdbNcqu+Fer30BLXqd0mYbzPJUOFX4bJtyNZRCOiS5kk8pPO8Zt4mPFIcdFT+8zqVY0xK0+lY1E3W/OFXTgL4AVehRDgSYByg92ztBHXV+q5qYnuiErBmmLheoaalWJ56sAqxPa5dJNG81r4xQKhGKYorXU/VTfzxyefXnkkLtXwYTpesUx5rnQVn3jRY6ka10VgScNNR3yvxVsMS9uD+p0pBlXua9dptjYoMF43DIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5RfH3HqMk9k+YaQX4TeAD8sm+Ko+d74ydITCJK1lAA=;
 b=hBO4dlBesdoDXQvXWTESXaiHPQqjgtR5vgBnJGAjuZE4ohV6JV6KG8pUmHGqfgKZIxtGn8N59RWOgR2jgsM70GP7sc4nHSGEOv1WnFYfX9oE0lmKboK6qmkDQbhXkVWur8+KEGKTXuq2+KWdcYzjc1v4kOTeDDhsXy/J5AeuKdHGG/VLoeKaViQPT7baig1WeDbbkYpGPZ66N4zKjO8NMx77TS/2O3GSdBWZK7cdllhIgzlfEHF+EwPUX9wIvGsHPNU36FObc7gs+sN9Yrl9k6DrLhsWPrzUTsXQaJyCIMy5GtFMGSymahnySfsPKcX2YiVUkO0Z3mTsFDwg47Gxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 21:21:10 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 21:21:10 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Zixuan Fu <r33s3n6@gmail.com>, David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 4.14 PATCH 2/2] btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()
Date:   Fri,  9 Jun 2023 00:22:13 +0300
Message-Id: <20230608212214.8636-2-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608212214.8636-1-stefan.ghinea@windriver.com>
References: <20230608212214.8636-1-stefan.ghinea@windriver.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|SA1PR11MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5caaac-acd0-4d7d-4129-08db68664777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEj30OiVmwlrtunjfZmSftS4sETyBxzlh0Xsvt5Y1JnzntRhVRMzdkonsRn2j80oKUYhQqoInPp0WMeMDYUymDYm3EnELJWZDg/vzAjUdUDWJOGn7bRArj6X59rfhD8zPlbSb01XUxsF3SDFHnG0zSRG4jp39m5pOTQtQNEdwUWGz1Ky7awv1rAt0ZaUvdtqYBlwvPBHa3vcPqjXqEEq4u2RfnnUZRSicKwiIaMeMisvXqHHfDYIT0e0fA7oClz1Gn3cCXcgbzBhyiTDDahc+2mfm1hXF6sCYyTNGeNLd3mtLqDANuUwM09kNDetDp/EYkRIMtjD6Zj9zOzeMvFZxgT98CmrbC4f4Qis5hY5sC39WJMdDO4fpVt3l66ZyR72lSuX3Ykml5sCho8mEUPdAYmfRwTbfHEQBpCz5/gAmxo1tqDbRWhcgICndAj1wy9oRv3ltEA7ItVO/4phlu5UugDl7K3SupPlomcHH76gycE3mm7lXlhUmldE0IJC04y5uHdB5sLitkE/NMJbilpOS5KxzvOdlH2OoTf0fKfc0jJS2R5yL9pidCcaihTnfJlqZ1F/sEQ+3gNGAF8RfbDpR2lH++S2TJO8NVxcHoKfnYmJlaUS9vyaKUeNIH4SdOdS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(346002)(376002)(396003)(136003)(451199021)(83380400001)(54906003)(478600001)(66476007)(8676002)(41300700001)(8936002)(66556008)(38350700002)(38100700002)(6916009)(316002)(4326008)(2616005)(6486002)(52116002)(1076003)(6512007)(6506007)(26005)(186003)(107886003)(5660300002)(86362001)(2906002)(36756003)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h3QL5sqrp1pqlTko36Cjavv2C+BfeJt94pktarSTRzhDSOrSsNhmQ5hIAkGz?=
 =?us-ascii?Q?mXjap5osN5LYBlW55Q7eo4H6iYGI/BXQr64z32dYn5HOJIJ/6vrfg6NOZgOb?=
 =?us-ascii?Q?FtSUVWr8y5RgJzitGSp5mZd8tdrXxvDKhZDoVFlgzC7kHjFPxkk94juPcf9g?=
 =?us-ascii?Q?awB5OsIa2WjDIEwIdCyLnCBcJqgbEzQv4hkMEMlRpf9uiTXewcOJJWQzUlBC?=
 =?us-ascii?Q?/8TRcvFnri8Oz8qAXn+ZQsjfgIkppS1kEun7uo9FieC/1xm1PvskCkRu3xEA?=
 =?us-ascii?Q?qOV09SBrVZfacihDab3R4a5h9lqUUUg1l1Qj5WAH/XhTqjiBksXC/oFzoXNt?=
 =?us-ascii?Q?76ucyXX4Gy9WLsmEp1a9u5YVB2ETehPBRpd40S3naNCvrWVz4moyjBdOY0L5?=
 =?us-ascii?Q?ur/yvxc3q7RzIKyYnC5SQU32jtuLEmnfIeucfqgD3JvKuAyCVuFebDkMYLD0?=
 =?us-ascii?Q?EF/sMk8ERFxB1eFqG13vDdnx7W/ljXF4C7Te8+HYoGyk3uYyLADIGeftl9o6?=
 =?us-ascii?Q?zBjSu3cgecIcDHZeB/c/mqxM9yNbDzWcEmSV3S27PMhMZ8lOYuhYHRwVDD8f?=
 =?us-ascii?Q?7tKfoJSZwdqfx1DUc+4df9g9DUYgQ4u5EGu/IStdMF6zuji7e3Qyx2TgdSiv?=
 =?us-ascii?Q?/VxA7LgVvuFawjReTlRSolfuqK7/6QZ0U0gwT9eO6JvMxwJapzy2g7jlU71W?=
 =?us-ascii?Q?OmpLUpqJOa81pPiiMkpRJ2UEsbKFeF0oKtcGTKpZl91QXHqDAA4PqAjP+Ylm?=
 =?us-ascii?Q?Y+YwuXqaBbDytQTVfwv91ivVSS3pBWk535rFCsoXvK/TVq3nvKvzVGT/Ce4v?=
 =?us-ascii?Q?yLTFJCUduzUpUhBLvF+Kiz8/cFbiqz4J8o+H/8cEdyXxGMCeEDWEp8LVd5gT?=
 =?us-ascii?Q?qCcER8QpH84gm71xxxSGUSs8COk2O/dVW0Tm6T5zgdS9dIdi63Kk2S6bJfrD?=
 =?us-ascii?Q?zeZ58rXSjrSyikH6RtQOE61gn454dApmY6MRBxlEYPOOkOv+M9Hms4x1WfHM?=
 =?us-ascii?Q?3JpVDu5YCxOmOLx0tuIG7vOXqu1iVXA8qV//5M9TYJzmVjIyVera0ed1FivU?=
 =?us-ascii?Q?rLpBKMn1SjEdusA6GIi5+MP9R+GWSBWAakwRI4P/h9hQRecsDHmqv0md5NUt?=
 =?us-ascii?Q?nNT0PhFc60/nsVZ1HcGYF6h5dTO7kREnEueNgDJMOr3t7phXIRRx18s/hITw?=
 =?us-ascii?Q?mtE4lQJJ8deGxwmKwwlpxmkTrhtfGenZctlJtpmJTCREO3o+vhz2+jvwMl73?=
 =?us-ascii?Q?s4TjdIStvZN1sQ30kEH8aDxcCuxhqMP4yrFJ9nSPgA8oX1d1JJKyMHWnbl5J?=
 =?us-ascii?Q?+sT0rSRFhSPEbVnDgVsIkSGZ5aKY/UrkPy8RZ8p39bHNay/DpqVGq/8D2zsw?=
 =?us-ascii?Q?SqMIpQHFoGWCmqb/Xzebp7LQIIRtDjF47h1If560HMjtlLZj7p80TN9Qamme?=
 =?us-ascii?Q?qJobbmSRoV4+H6I3fVhKRGb6z0s5hwmufzxKsJ3i6Tg5oAPlLbJiVAlYDkAW?=
 =?us-ascii?Q?yfQi8XBoycTMqvcniJxlDJu5ZqWHfY52wXlb1XkFuIvVzM+bKTFSDzqdjYE2?=
 =?us-ascii?Q?M1HfHKhW2nDBD/5JZBW9MOWb/1DBFIiuTMt/gaqVAf2LEjHGLto+2ef2SQNr?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5caaac-acd0-4d7d-4129-08db68664777
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:21:09.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZTiNTE3E/WICNYQOiFMWIHGAr2DbfwuSJGHkqABoOZSBlHqRn4SB7YyK36a3QneqlJu4CwBSxs2LJY+ouh05A5XE+ESqTFj7JeICz9xYNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-Proofpoint-GUID: QNA-IiMXSWNLuvCyAY-38Xqq4xYPm9Uc
X-Proofpoint-ORIG-GUID: QNA-IiMXSWNLuvCyAY-38Xqq4xYPm9Uc
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
index 33700561c582..fe5d6f77892e 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4014,7 +4014,12 @@ int prepare_to_relocate(struct reloc_control *rc)
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

