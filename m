Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB63759E3C
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 21:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjGSTJf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 15:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSTJd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 15:09:33 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515B81FD2
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 12:09:31 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36JCTeaD020163;
        Wed, 19 Jul 2023 19:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-type:mime-version;
         s=PPS06212021; bh=zHm9itxeOM4WLqedTsfx3sj4Ow7MyO5o2WIKflGCLVM=; b=
        W1t8a4zrU+yXyjwslBkrF/VNTkfVYDddZ5and3WFooCXsCSgDvGEHsiV5wKranGM
        oWiJeR5hWrmwmxHnxNJnE8O/as0LnO4cU5y7LIlHmQQghY4XVvmP9jWuGrQ1xwG2
        MXwaKPCcTh1rsnG3BEQUUXx2FHvX3Lap8pqJh8XsFTirlflioj9TM//p9GETvWp+
        J9KyOsp2/rMrqwy9U8lk4va0l3GlGkNwhG2MJoz9vSKr1H2JvmFmYIHlWBH4CBpA
        zWGG9P0boBJLEYb/5OktQPROCqXBreS3rjam13ecGsU7nx6x0oIgW0+4iyHLYA74
        UTQOtDkrOAnbk6DZQbY7zg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run8abysx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 19:09:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ru4Kl0g1dEIs0bJSjhcyfI21yLZjiDTqyOAYCP6xdmwilp8euswlzEc68DgEclQAYG6rjVe1yq6/ATv9DYPcd/irmyGZAyoos/yUmuJ1yz8GZrD9S1+ZbJGajUujTjzuYMzS/MXD2WuAdyaK5stla86/4AbziLeZ/BEoo5V4N2e368uYJB8BhhXaZQs9gZVXTjDxIaB1d44z4mR4hh+WdSyfpkp/ck6R1e3kWmUnKBJ3lAXq87NktWR8iQwnkFVgqywOK3qk1mAq6yXd5O0BJ8Zia/oIo+GNJnStsB1HRJT95vPeU+N8i4/T/ykz+502A7KTwNTyjNEMf999yX5zjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHm9itxeOM4WLqedTsfx3sj4Ow7MyO5o2WIKflGCLVM=;
 b=O4XJTefemnwYkOBAE7buTGWXLsR08a0Ok1cvFoITi6K780DEoqwxhaAg/IVdy9Gvv2cJ3UglmyfhoICB1iofDYmigUfzPVUDobKTk9/8JN7Ngc/91rPCB1lNBr8EzfNTiNDc4rFZ4cPzh3Kje2Ox+RiYGqz92xTmwW6QNkujlRVSpIA+eNTsHRYPa8PpITlhMwximijLnoucmXwiurKlalMlk+l0gVTp640LlqbBcYMshKwQlLlUTm+2gfOqbMa8O7rrkJd2iAc4T/uGcmvxL2GS7JcgqKkxS2WapJ0JYTr4RO29gXpUajfsp1NEdMyForKwa25wzlxMKgnRXVdc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by PH8PR11MB6830.namprd11.prod.outlook.com (2603:10b6:510:22e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 19:09:20 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 19:09:19 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.10 1/1] f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
Date:   Wed, 19 Jul 2023 22:10:41 +0300
Message-Id: <20230719191041.15368-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::24) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|PH8PR11MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ae716a-543e-4e02-9704-08db888ba7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDqjFkfVWQRnAYFQSBG01DvskhpVg4RpmuB9w0RgStpcNN4Hy3pHJHadYxpPFRBlXFq2d0i/qdcN5BYKAdY35MTqPAQEZTIqx2PtRyzlm+5Hwmrnnv2w/QyJjqFgC1J57cDnRWMNvdlsHP0cg1CKAfB0WLC2ZmniaGD3MUgAHcRgpSJ/M2QQ1NoJfx/CLVF2aO8fp224/5yOWg/BJW3AEz85YQIJcXbcUOapPhyOSm4KmKaNLoljksI0LhahfbYq73Va41UUkrMebIhzMdo1K9WTicxfYTbc8NEH+6QoFmI9oYWse+ONZtcWSFmyraVi8vDFYt0pVrSS4zwV4uBF6fw42XbbrGgRCXTXjEMw0TKz5n+ApnfNLCEGGqoCzqw/fq3RKmSEMC0XuDl5bmFsMcX9VMo1u9LhA4+dr2n/YB8H1PHH7Oc3wGOsPtMn97sweWPv9nRFIDkjSgIy2lxO24GCpsBOnuKjtMU8/1cNUZilfVcu/hP0NXjcfuUDwCHbwTHSNCVyQfMtSzRSV3ENchajCSQjHMZwLWy4migbL6rDn4WCme5pLMKXcl9mdNq/AOkXtuwZo4f+D4BbKCstO52dUGnd10nb08Xc8YV9JS/ZRRd7G20Epcku5c1HzPZ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39850400004)(366004)(396003)(376002)(346002)(451199021)(41300700001)(6512007)(8676002)(66476007)(66946007)(966005)(8936002)(66556008)(6916009)(2906002)(6486002)(6666004)(54906003)(86362001)(4326008)(316002)(44832011)(36756003)(5660300002)(52116002)(2616005)(38100700002)(1076003)(186003)(26005)(83380400001)(107886003)(6506007)(38350700002)(478600001)(471894004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GZZ3FWbnbPyVLjRKKFaAUS7H5xrtUcgUD4qN5d1KRHuQdhJWaJfLLsfmZVfM?=
 =?us-ascii?Q?o+un5CBTdXj30tjx7DUPfKu2lmIiKf86YVJvsuzSyyLyCGgVzSG7D15OjKID?=
 =?us-ascii?Q?snXeuHv10vafVI+4tJzNOGju8gL337JPW4o2n/KspnsXIfMXklVD9oqH8wd8?=
 =?us-ascii?Q?7HMJUAsrtRP+J1MZyzPxGYfu3q9ok3t7yO99V7X5eec9LnNcE66RGloB7Qhr?=
 =?us-ascii?Q?LELrYxsUmK5ewg0nQiNf1IxacPamniyTjf6oEExq5EzRcgb9I/FhTkYi1CDe?=
 =?us-ascii?Q?mEOWedDg+3nUoIPh8q+Ht3qLrvLGwdYND+qsArmM19HsdQmV18Sk7cwKPLZZ?=
 =?us-ascii?Q?+DCf7AY47AxIzVdDnOXnoWQLxm1MqdYQIAILpTE3qFxl6bvKJWNs+fQzaa41?=
 =?us-ascii?Q?PLdQtjdM9AEFVc6rYwFAo5KfWQ2+vRixhh/a/2yKNKnZyr4z+f7RgweBAdRI?=
 =?us-ascii?Q?ZRX4c4jsPLBL2U3e8zPlvKL23iccICa6K1TyOO2osSbRVQgTmrVwCECZpgFd?=
 =?us-ascii?Q?UfWQaRDaj9R7ENLnI+nNt9RVoUVmXAGflP3ZfweslYDhusRhQbMJyUu/k/+X?=
 =?us-ascii?Q?GBxEOvs37kJhEWMMZX8cduG6i67xJq1MndEy0+P75uyWMTbNitS7Ix76e3no?=
 =?us-ascii?Q?l3qzO57TO7BQgnh1hARV+yf3MTwhgkqHSWMC26jwKb5fBiAmsZDN2F47a7Wv?=
 =?us-ascii?Q?PNZ8eu6LmNjqUqNH2ALyNye90zVTEOyRPwW3x3lbCpegK+z2I2fnix4FyJOY?=
 =?us-ascii?Q?TcFU7gFkhDZA/ywHsA0+/H2A5etyvSv6IxCt8SIPAyKVdGHzZM2MprZlAWH0?=
 =?us-ascii?Q?zB5UjjJj7ZgOOxY7RraKVrSfNzq760V8fbXUboHByYvrgUeZRd6UF4wPYDNU?=
 =?us-ascii?Q?rYl5iAXF2Hv43R3lhwvqyqYydaEqsAFQlLi6YO/sOOi1MyeE+R+K5SeA0q3c?=
 =?us-ascii?Q?y2i/Jy6wFbMyW1VgVgVvoQ3UmAGfEylZ+t2qH6auKxJ0LJyHZUtK6YFqJOal?=
 =?us-ascii?Q?DYKgMae+89y5eOruQGaif2i3r/RbUFvL12hXZOBdEkpUN8ZnuKZAT39Q6kGe?=
 =?us-ascii?Q?X42EDuKtBZ6mzSt8hVcRwKsUdssZsZLATy3ZZ8seAteYTA+tPo76sDaJ/1ZN?=
 =?us-ascii?Q?uaCfLjqXIzRa1b86m6JgMog2aCI5gfHSHbKcdo8Z2cRlG42wsf9NfGE0KvxS?=
 =?us-ascii?Q?GJnuYdlbqDwZq8ENZQYDi085y3sUE71oUeqYIquQpEuaavf80f3IZV2WCHXT?=
 =?us-ascii?Q?Fm+UbajCMbQjc1s+Q9lfbgTCqrSj86lDFB1nRbpOBGcuraNTCzeS/sjevxDd?=
 =?us-ascii?Q?WimBUO1JQp4vlC2PHDUfGSEE4lY2OIGbIbtfUDB4iCOHtPSfRos7uuPKKJJl?=
 =?us-ascii?Q?Hn6DM5pOAX6YmSw0Ok7bx4idez2nLYZASUEDrMmkr1T0QG2qoojEv4eP3aa6?=
 =?us-ascii?Q?h+x2bI56+QnlsZnzXIRxg3HaN9sIE8d7lLr3bwMfX9Su/XHtpnO5ZN8qjA/y?=
 =?us-ascii?Q?zJZbXPig5wUyG7Qijcgvs8+yO1VdvsWIeBmZCU0XrMxZ4mv384XioG7h/nRA?=
 =?us-ascii?Q?x9dNJBqg78WV0oz+PS2hEHVwgixLpzUM2aIAmwt8IUWNWI9X4snQ5Qc0kCTo?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ae716a-543e-4e02-9704-08db888ba7a8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:09:19.9380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dlv8LqPg1KWJoEvLbQGOQ8SymTnTrYNwBx8Frf3tmEaGY2IibAhdkoYPedB6ecK9Jl7KGjB0LwUxvk6ivXxNgDfg/G9YANeeq83FPkOZVAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6830
X-Proofpoint-GUID: a6ogmQrb2V4MOnwqe_T6VH4NK5NKU43x
X-Proofpoint-ORIG-GUID: a6ogmQrb2V4MOnwqe_T6VH4NK5NKU43x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_14,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2307190173
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chao Yu <chao@kernel.org>

commit d8189834d4348ae608083e1f1f53792cfcc2a9bc upstream

butt3rflyh4ck reports a bug as below:

When a thread always calls F2FS_IOC_RESIZE_FS to resize fs, if resize fs is
failed, f2fs kernel thread would invoke callback function to update f2fs io
info, it would call  f2fs_write_end_io and may trigger null-ptr-deref in
NODE_MAPPING.

general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
RIP: 0010:NODE_MAPPING fs/f2fs/f2fs.h:1972 [inline]
RIP: 0010:f2fs_write_end_io+0x727/0x1050 fs/f2fs/data.c:370
 <TASK>
 bio_endio+0x5af/0x6c0 block/bio.c:1608
 req_bio_endio block/blk-mq.c:761 [inline]
 blk_update_request+0x5cc/0x1690 block/blk-mq.c:906
 blk_mq_end_request+0x59/0x4c0 block/blk-mq.c:1023
 lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1101
 __do_softirq+0x1d4/0x8ef kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:939 [inline]
 run_ksoftirqd+0x31/0x60 kernel/softirq.c:931
 smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The root cause is below race case can cause leaving dirty metadata
in f2fs after filesystem is remount as ro:

Thread A				Thread B
- f2fs_ioc_resize_fs
 - f2fs_readonly   --- return false
 - f2fs_resize_fs
					- f2fs_remount
					 - write_checkpoint
					 - set f2fs as ro
  - free_segment_range
   - update meta_inode's data

Then, if f2fs_put_super()  fails to write_checkpoint due to readonly
status, and meta_inode's dirty data will be writebacked after node_inode
is put, finally, f2fs_write_end_io will access NULL pointer on
sbi->node_inode.

Thread A				IRQ context
- f2fs_put_super
 - write_checkpoint fails
 - iput(node_inode)
 - node_inode = NULL
 - iput(meta_inode)
  - write_inode_now
   - f2fs_write_meta_page
					- f2fs_write_end_io
					 - NODE_MAPPING(sbi)
					 : access NULL pointer on node_inode

Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
Reported-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Closes: https://lore.kernel.org/r/1684480657-2375-1-git-send-email-yangtiezhu@loongson.cn
Tested-by: butt3rflyh4ck <butterflyhuangxx@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
---
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/file.c |  2 +-
 fs/f2fs/gc.c   | 22 +++++++++++++++++++---
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 62b7848f1f71..83ebc860508b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3483,7 +3483,7 @@ block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background, bool force,
 			unsigned int segno);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
+int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a0d8aa52b696..6e91be5b8c30 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3356,7 +3356,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 			   sizeof(block_count)))
 		return -EFAULT;
 
-	return f2fs_resize_fs(sbi, block_count);
+	return f2fs_resize_fs(filp, block_count);
 }
 
 static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 66ac048cc899..8e4daee0171f 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -7,6 +7,7 @@
  */
 #include <linux/fs.h>
 #include <linux/module.h>
+#include <linux/mount.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
 #include <linux/f2fs_fs.h>
@@ -1976,8 +1977,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
@@ -2015,12 +2017,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		return -EINVAL;
 	}
 
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
 
 	/* stop other GC */
-	if (!down_write_trylock(&sbi->gc_lock))
-		return -EAGAIN;
+	if (!down_write_trylock(&sbi->gc_lock)) {
+		err = -EAGAIN;
+		goto out_drop_write;
+	}
 
 	/* stop CP to protect MAIN_SEC in free_segment_range */
 	f2fs_lock_op(sbi);
@@ -2040,10 +2048,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 out_unlock:
 	f2fs_unlock_op(sbi);
 	up_write(&sbi->gc_lock);
+out_drop_write:
+	mnt_drop_write_file(filp);
 	if (err)
 		return err;
 
 	freeze_super(sbi->sb);
+
+	if (f2fs_readonly(sbi->sb)) {
+		thaw_super(sbi->sb);
+		return -EROFS;
+	}
+
 	down_write(&sbi->gc_lock);
 	mutex_lock(&sbi->cp_mutex);
 
-- 
2.41.0

