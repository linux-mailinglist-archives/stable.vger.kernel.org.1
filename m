Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7216728A23
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjFHVTh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235704AbjFHVTg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:19:36 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9EE2D51
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:19:31 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358JnDQ0018028;
        Thu, 8 Jun 2023 21:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=PPS06212021;
 bh=qv4Av+9JQ2DO5p/wW4BYV0EuDIqrH6P1+2Vlf8UIJF8=;
 b=J8uWFtacgV4eh8it1K2lrHQNa51FvLoVgWve6wERIaT/CMDFuOfNiZLa0RE1jikHGsrq
 QxWb0/DM6HwSAJWezuYWl7OrPvDzp9AblyzmxhGL4FFEgFVK6aileW4qUY6e4bvBxH0f
 j9vyNQq40LF5OqpAM2srQaqjydk1qSyrA/X0zUGus8HlKIvjBswzOAQCWHYCErZJvwKQ
 jVTK2LCemt9n3q6OAktTbKqsTcb58KzZWDVJfB2OYjdURWuA996/B9wG2eidxdTGaE3O
 z1VXuf0ZLX763frC0IudDEtJR8JOf3F1+ME8IunW3wFtmKfejHBW5VpNHJ1sMYrCydg5 iA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2aaft51u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 21:19:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeykxDcm0rCpB6w8dzZunv2m/H+Ktq2VFQEGRiXoKdLjTJPcy62zjYfHC2raTzcbjDbqwjpWDBa3ixrwswUz6Y/ER6lWhAhkkYIxRk8wN71lqxDcrhiNQKenkydgLPZheJnmjBi9X6XFCNpNSRhK2LuUWCD17VMhfbDEZYenjXagQ30paGTn7S7V+TAWVkHrhIUlZ0Ahe/DjU/m9p0IBTMfZlKH5DD/ggzTX9AbgLz4tQP60RS/xpSmyKnp9o3lbW3vr5XHIHUuqKp3VRf5N5CRMcnvWaVeuyRdVuGZstxhbdInAuxsadiRAZccZzNQc5Q63py6YsZZ9qzkm+/vrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv4Av+9JQ2DO5p/wW4BYV0EuDIqrH6P1+2Vlf8UIJF8=;
 b=JpDBZtoQ8gD/nAJaa2/QiHnQTYhVK8lK4Fm/YGnZAlZSlbpn0N9Ee3GhqycNbaO7lMsi8PVKRbC6ogWLfGFp05nKz68ycGsP8CsumYfboAlkB0Nhq3BwF3j8Tq7N/TOW7bd3TjTkIy7RkngBV1fVtwfPEjijL/sOa+47W+hvGQOhS8MAFKHLNmgr2h6tpZek+RJYzlVd2jWtIXI7TaZBMQ9z/uPXJhhDMuSnfdPdIrSPK36yHTO8VUyZDBqHAJncPsvokVyMmErys4Ocy8LUQdCMIgSLb/RC/XJsv3Rc3AgJKDGMw+HMASR7WlWFHggjNVl85ao9W998glPHVWoRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 21:19:26 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 21:19:26 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Zixuan Fu <r33s3n6@gmail.com>, David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.10 PATCH 2/2] btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()
Date:   Fri,  9 Jun 2023 00:19:59 +0300
Message-Id: <20230608211959.8378-2-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608211959.8378-1-stefan.ghinea@windriver.com>
References: <20230608211959.8378-1-stefan.ghinea@windriver.com>
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::13) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae9ee28-3ece-477e-ce37-08db686609f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: do2Xr8P/E10IqdQS7BDPba6BYNtzPaH1OwrldjovY5sG+uTKLyncexvZ+EmU0Uzp+lIEmFiqfdWWT0BxX023q1McztWxD5xN/LBS8ONB2Be/I/o5l0qiYMxbAz5zza8uG5noJkvDIA6vlSUb75YZeLbuvRHufa4Et/TNDEnggRp7ceUgY3yRK4qgRWGMZ/+sDqVvaLNXolS28XRCGqn9Bm0wS8kudygwEZo2Ptr1boxL6gFiBIJnxhodhSEb8rP9JRnafeS/FMqiSbO98bjuLtvyMYlNciyLmbwoHCQNLuXnnc9ESyP//ONBJcO3a1k7WfTxlyRY8nreYaYgid4BcOF194++QZs79o/Ko+Vl28BDUgQYTqEKggE2kmIhc7RDeNxnGSh+v1RdEpCsjXhcxqFhyshMbWMd9wFnmjIhSTHgmk0nIO/jxiaMwAnrdoFcG2XSLNG7q3D4Vfb5iD09HMykpogikY4yq4yNuEeNeDlxHOzgZ6hYa6rGT/CDzy+ZDtR6gBOBHbN2KC9UB+VFTU9F0EywHCeQZuTlIQ0GjWBA2NUOnKDw0JrIx/3JcY5XiR7/xQFYzXvma3tX9jLXMSCVPlFoPLGUHHRPEkgsu7yxkocPOAOOuuVTjWF6vQJi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(451199021)(6506007)(1076003)(36756003)(26005)(83380400001)(41300700001)(186003)(107886003)(6512007)(5660300002)(8676002)(54906003)(478600001)(8936002)(66946007)(6666004)(4326008)(66556008)(66476007)(6486002)(316002)(38350700002)(38100700002)(2906002)(52116002)(6916009)(86362001)(44832011)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ej/hZhM9kpT6X9pA+mGezUL9tMVNts1Eo7s5ny0CGdTG9KaeHY9dU/dcR8JQ?=
 =?us-ascii?Q?7nx77nS1zCjm+bE2nHzhDynvGyCq8EM6zSq1d90gdwtsA3UvSEzUBMLQ4Gam?=
 =?us-ascii?Q?xwEZxoevkSR7jsbfn8+0upv8ZZrW3/Mh+15mT2MmrSfLER8KYwpGmnpmWKaK?=
 =?us-ascii?Q?A0i9NizIWhdPtU1YYdsxLOVZTGHBUVYTRzOwJkTVJLP1+Gb1vJZVpn2P8e2/?=
 =?us-ascii?Q?l3LAfD4KASGBFPfQNP2XoKuoaEgQNb7wPsMnsRJt4vzrtIavVFdifzC97MPG?=
 =?us-ascii?Q?HEheb0SWw5SNTyVfOZyCtwDxwIei8U511E64vWXATPHSeGL+21L6qehNhPf8?=
 =?us-ascii?Q?P+70HPTfCSwufqIqAuRAj4CYnHIJ+sS6QO/d2EHsgQKBgB2G3nWz7B6F/IKL?=
 =?us-ascii?Q?pEkcOfwAZWG3pZz5LXLS5JFdxSh59xMCe4CoebhCPQ/P2ucxP5T0Ces3d/te?=
 =?us-ascii?Q?cUKMvjPa+dQ8ylYLuVvIa9LyNS0pmrDNfUEgQiAcivHnB1QoH1QA1k0s8Xd9?=
 =?us-ascii?Q?us5vCrvKd31ckkXyU9M3e/YgpuU9x0cB+8s6FtoX60nhZ2VUxh9bv573IOzw?=
 =?us-ascii?Q?nmagQ08WpOUlCuB0U0lxdmJW64s21wHy7QDHsuyx7sD7eLL6doNzG8tmTaAD?=
 =?us-ascii?Q?nEI0QaEjfhIAwXP9ibwuPAhERtT0wMoDxS3Vw/SodIJdlAGyU4/8uDt6SuUH?=
 =?us-ascii?Q?m297+GbMtv57kG65u/VgqE3DLdndjSQptUYK0ad89Vy1bYHc57UR5QGnm+qz?=
 =?us-ascii?Q?6+5+jRMS4U0uEE+iZPRJqKr3p5yCaJX3dww6I++/cgP190jXfymZcRj1voHI?=
 =?us-ascii?Q?yvg5SouD2BSXNAb/PPvukiF4agwsPaPr0FaCssLkDhyGEgCl6LBx4OuxqbVd?=
 =?us-ascii?Q?pSXT55YVyifrIe0kfs90xCaP8gO70ii+UFe27wSqtgG4AT0kZ66YqpfkhC49?=
 =?us-ascii?Q?WFIYPKcl52yB044pDizJJrTcuGQnoo53q2ZQLwhFcu+nEgQVn6qna71nVLyt?=
 =?us-ascii?Q?zRP9X9lg5S2XpTMeKaeCqGpBz7eKTwX33VQwpvl6WIg97IEpKjtT0vpqbEJz?=
 =?us-ascii?Q?r93qUpeyZtp0/SKL6cxc8eFwi3xzhv2ACevcQqZLct3L14Bf3bLoMAOhkyl3?=
 =?us-ascii?Q?gBmCRm8m/ziodywYXhLmdQnHGRV4tX9nlwa2DWyJ3+lHnyhs7NPioUn7PG/+?=
 =?us-ascii?Q?2uWkHpxnzg7k4Nn99a8bifDSP6X9Sr45S1RE6ZWOBfFTlOzRjoY1zq6s9QKD?=
 =?us-ascii?Q?DivLQ22F5fNpOZDPnYCltM9X54oPJG+dGF3Jdzb1nHauglWUGSkEV6CuQ0uM?=
 =?us-ascii?Q?M4m3N37FaT+jjQBNTzjn/C2txFGg/qpFR/hT28lEUJhEZkjoW6MPUoHQ1/BE?=
 =?us-ascii?Q?cJpiwrvRUBuu51wH9nN9ai2wtMIwM3f+TodW41jQCyqI2jProRKOr2U2Djxn?=
 =?us-ascii?Q?7Z0AoaEwkgND9hoiTeV+V9AdDPWPO4Wj5pDkEu+bsP8KPc5Yzmou9weVIJbz?=
 =?us-ascii?Q?LkgYG4sgb5HMT9qeXxUQpiavXGTte3eIeAOYDKDKIQcuXf8uQhau6X+FDl2G?=
 =?us-ascii?Q?x1A7L36GfVph59X+akBB9nCAURbgTZKhU88Vmi4tkEPh0pCcKl2ABLB8YeZl?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae9ee28-3ece-477e-ce37-08db686609f1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:19:26.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlbmOT8PFinfKdSR8Yc4BrYmBkUD19mU9WO+b02qfZyAldPfHrzUNORIo05GIWNxCmmBSciMlywQDKqsEg6Kq/0l2RidhnzI2U7Bcb9La9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-Proofpoint-ORIG-GUID: e8N7SE_va6hp8PGWIfvp46WaqKWe1T6j
X-Proofpoint-GUID: e8N7SE_va6hp8PGWIfvp46WaqKWe1T6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306080184
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 7d64180fec2e..93db4486a943 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3270,7 +3270,12 @@ int prepare_to_relocate(struct reloc_control *rc)
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

