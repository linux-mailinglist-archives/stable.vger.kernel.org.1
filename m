Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD438759E37
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 21:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGSTJF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 15:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSTJF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 15:09:05 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C654D199A
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 12:09:03 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36JBvQAf027959;
        Wed, 19 Jul 2023 19:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-type:mime-version;
         s=PPS06212021; bh=fZ1O1Qe3uccWjP40bnAAEFydsMvqTQDFXAp5Ht2XIcc=; b=
        b2rovQFKdWUef2nI6eED+TSDEQun2gygZFPfwv5KCbHgyVVibO3K77QNDvjy/7yU
        xb6l5AWwcr+8WDyzcwszjBWyiiq1efb0Hw67wqhZKYdhVLF0NMhq/FRgA27gbR3Z
        st2G5OuSEl5HD5Scx2MebB4FzKKO3G1Lh0kwi/HuL/4BeLaUV1iS6rmAdW7NPd1c
        DWRX3MMk56dLBju6qvEkM4xmHAykj26c8vPn/ZTh7t0/tk4eUDgIxcIUKaFXCW5n
        67Th4F+L/bMnpYDRqdJ28+GqSIblMsFgwUq+Xmq1FONTvcePypkN4sdX1Hon3bO/
        BMhQFvaH4F2H+PT+yIeJGA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run9juymv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 19:08:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7ZV2XVk6xvUHFhlPDkd2AB2ry8PzTguZwhptLVDmZm8RC34X+VtZviBxf4h84Q3QnpkCmHLXxeOxKjNTv1pfB9KGF7nJsQ2U7i3L8dniPfvqtQnGJD+VrPgxR+2x9uDR1jYzt1uco8sasrZMMHAHItzTzfnEn+9gUOzS5rfjBmOW+6kq/0RmKgc4NLfvUmJK11rk+pAEkrnkq9FErMS+jTAn+Wv2mns93Dtu4HnI8nkMaAi2mynXRbmp5FHkVxpDsiLDQbHGvyQZUsbYpz9REEBMgKM453dEWXB8HNWztEjhq4G3W/JnmPjqMXqPUuu2IyDqHLHYwc83dEmM7sO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ1O1Qe3uccWjP40bnAAEFydsMvqTQDFXAp5Ht2XIcc=;
 b=cCtR7nBHTUT7/oVwR0NmPx3WXyId1ayUMz+bQuxJOcLcJLQkfdHVcFjRld3/VeJfBrJSruy4BbB/wM1orsGIwr26zYAGaHDd+fQbnj1CZ603gVWtceHabqwLXE4aLJVSGBV70IXLsTfHThi691jv48BXsN7f96+JFBMFLyOW2ROf/VDcgBigMh20lwcPMbs4yMFalbaqHnY75UsvoqoMvgmq3bh+rGLbjBJGTyBpQTcZUn4GIzeU6ZPeIWJJseLX2Upbyw0LrBfuOyhQHdrqQGQ7j0stwnlrQ444w3DSoJfKvYaRK6nkoVFzSKgTQYsfN+HxkFfn5tAzdCVTRSs0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 19:08:28 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 19:08:28 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 6.3 1/1] f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
Date:   Wed, 19 Jul 2023 22:09:44 +0300
Message-Id: <20230719190944.15238-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:802:2::43) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|MN0PR11MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9381683f-c49e-4538-40a7-08db888b88ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGlwenEGB+xY/PN9aHo+VB86ueaBs9aG3L7yXoWUeOzb4N0wArvA/bNGo4B01VI6knz0dU/jIShYfpxID4kYdDxAu3NaUiWkBv23vihHOfmfw3vKWJpLYpFLvrkJvV9/IXySjyd0q0jMJFARKF964uEEke6PfMsbY9mZ9FF+DM5Yhhf23klJznObNgA/cX7wvVXJb2H0oIYBLGEBp4Jh0omI1GEL0ecxi8ruZPl4nORd1bwS1GauXA9LEg5CE9oo82hCWvTJsKG4dUw4wnXUoIz/jdtbTwta2kEOxOe0T/+WY5OCX6sIaXrAmwX8xCNoCiFGOKRj6nII0BmXKBQ693moJNUXThlEqnjlbnOrXFcJKHeoYwFNcx8EEhV9lORc63da10fy8gC5vFUC7Fgu+iXpUp1f4Bl8sUFYt+WEXCWtkqf99ITl2z5U1QS5TNoIZ06ljBBsVtTSVTZzzNsMUKYwuWNjxWNLzzwxaNeU0uC/hjDpdOSMKKArR5U3X31icqhOgBEo0q9c6gr+1ICdmmccZqsOvTRnfGe5JFb8GzKfmZ3jo8pU0BMr/iV2mTe3EFVgTRrTiV2WjejQhV3k7lREMn6DQZgsBqMT08CZ1fbc0K172Z7OMV2BD67GFXCW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39850400004)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(44832011)(6506007)(966005)(2616005)(6512007)(186003)(83380400001)(38100700002)(107886003)(1076003)(26005)(52116002)(6486002)(6666004)(54906003)(38350700002)(66556008)(66946007)(66476007)(4326008)(6916009)(478600001)(5660300002)(41300700001)(316002)(8936002)(8676002)(471894004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7JjcNsLA7uwm54BqFpHZ44lVcwwnQO6LIP+SV8N4STbvvwtMoy6ol8+Qeeb9?=
 =?us-ascii?Q?9xmn6a3bh4BH/gwDU/f/Ay3Yj3gy4sO4Ioml+5mJaULvkolL+J5e4Jrifjbk?=
 =?us-ascii?Q?PlG4wasV37otS9blxpTNq1atU1zLYv0yulhTifPuNDstRutCTBZBUXBaGM3e?=
 =?us-ascii?Q?pEf9JwF1rk97IMzNFcIqLP5QS2Td4KweWJN76CVg+9c1CWbUDWR2PJlWkknk?=
 =?us-ascii?Q?7heaTGSG3rxuDhU+IwzhG1hWJDmBKANT07Ycuo8g55yMXQk5X6WylunbB5+X?=
 =?us-ascii?Q?FNqSbQC7CwiRT+dPSOUkyAdlqXShQBcGGsroQKpzreY78NRCq8F3XPyIXzV9?=
 =?us-ascii?Q?ead5/SzU0qrgowk8CVg8eoNC7MSTzmToBEZiCx7aFtLOKpseDWxYH+k43agZ?=
 =?us-ascii?Q?hzNOpEznx029U3QU2iot3fVcMpFh2MR+Fq8iHwhhdGfMKmg11KcsklW4JpHo?=
 =?us-ascii?Q?L2jj09moVxIdNlHLl0k60akMfeuzaXmSwFArw3pea697rgQq67FivZrN2EUM?=
 =?us-ascii?Q?BChE6/ZgJ5T5+mCFLG6nTgxxJpyVp7cHHKDSZHKFyT1tMVqDNeOK9m+wjOtP?=
 =?us-ascii?Q?jP4w1Ba6FMMekoXX6qJXOdbCYhhkcmgDEkYMCvMFLraiQHq0+FdcrNZZthqQ?=
 =?us-ascii?Q?Fvjw5jikOCgwmmhdNQ2MN+wvjbw1trByfvTfQ3qF41uImYFJMmJav9VJq8rH?=
 =?us-ascii?Q?RNkJXTMpvXHsDVylyPn0SDHXEXbC8U0+kC/39E9TkO7Nt2eYwEfhyLJRmK07?=
 =?us-ascii?Q?0DeezPrBMljUMGpO7kZWgZDg36PjpkfruhKRvKXezQjixyUoSzGhWZgQjBLd?=
 =?us-ascii?Q?U0uvIXPopCKTyjCQOASwMw/MzSlkP6vczGnhXUho4e31+xsbSn+TCrHbZy+I?=
 =?us-ascii?Q?1giSPT6iLmzmmc9uTGCDya8V3Lfy5RgSvWNxxXC28L6QJQeHMMRQUmC3cVj8?=
 =?us-ascii?Q?uqufGy4P0E4G9TKuEH44faJtAPS2I8Qyx/eGcyOvMLw6KMoi+yPtxTIaMAQ6?=
 =?us-ascii?Q?XOVLfNogNhcFuXr/Kp+NREdxu+ppM2nXuejUTY4bmdQ5ZaiDtwltkSfkoKgt?=
 =?us-ascii?Q?1tsLltoHGmgJg9L8BdhH19wtCIfQJPdRJgkpg9g7isb5+yEtWTD8pufe6hha?=
 =?us-ascii?Q?N8aYWvOurHGb5g5yHU5BY8qWdE4x4owqGMz4a9PvlJDPyPUC/jcfLf++r2Tq?=
 =?us-ascii?Q?vckIpxF/+wM502H/BPGD2TwgZE08Kja3eerl8pRB4khUSyv9w4917rzq2aQe?=
 =?us-ascii?Q?JDomu3FXKLcuU7G3tVG3kgvVG0waVg9f/A8T2cuvNHhLx2ObPFLnJjW0UVkW?=
 =?us-ascii?Q?zzgXkK3dPJWX6FFTlqLn/OXfgrkUQ8ZnXDnrtaspcSAbJlm0Af9iB6ljMSxL?=
 =?us-ascii?Q?Nv5r2yVDFY3ZR0uijfyTB7zEjOL5roCue6VvUMA6drw/4/9/zd+0NnyYLM6U?=
 =?us-ascii?Q?+hKeAXWILNUPB7qTCWV0/msg83opIxWU9tl3Vk1EO1T496KTqC2XkBGqraOo?=
 =?us-ascii?Q?tCeD/URm6/EcO/Ubn0aa5juWDcbPLYy0XC6/2cOneInb7zo75MBDXExS5CcH?=
 =?us-ascii?Q?7KMB6CSTJGBLrvoYz8ZI/KBuJVmiIqBhOeXncrfstObujh7IWzGR3XZaY2C4?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9381683f-c49e-4538-40a7-08db888b88ee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:08:28.3814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4HRFP+Dq2yEhOtxaNz+e9NQ0kw9ZCfB6S4iNF/kW6hubxueHxn8qn5KEAwXUPzCodL2uHlNNpbB/Y1aNUyQutjLqUetRM+fqIL5rtLB5hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
X-Proofpoint-GUID: EYvPsPl5cZU-HBP1t_Sbqv7krh0CA7C_
X-Proofpoint-ORIG-GUID: EYvPsPl5cZU-HBP1t_Sbqv7krh0CA7C_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_14,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 fs/f2fs/gc.c   | 21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 47eff365f536..e7fc3459fab1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3809,7 +3809,7 @@ void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi);
 block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
+int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 16e286cea630..766f79d792a2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3278,7 +3278,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 			   sizeof(block_count)))
 		return -EFAULT;
 
-	return f2fs_resize_fs(sbi, block_count);
+	return f2fs_resize_fs(filp, block_count);
 }
 
 static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index f984d9f05f80..d88957b9036a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2107,8 +2107,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
@@ -2146,12 +2147,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 		return -EINVAL;
 	}
 
+	err = mnt_want_write_file(filp);
+	if (err)
+		return err;
+
 	shrunk_blocks = old_block_count - block_count;
 	secs = div_u64(shrunk_blocks, BLKS_PER_SEC(sbi));
 
 	/* stop other GC */
-	if (!f2fs_down_write_trylock(&sbi->gc_lock))
-		return -EAGAIN;
+	if (!f2fs_down_write_trylock(&sbi->gc_lock)) {
+		err = -EAGAIN;
+		goto out_drop_write;
+	}
 
 	/* stop CP to protect MAIN_SEC in free_segment_range */
 	f2fs_lock_op(sbi);
@@ -2171,10 +2178,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
 out_unlock:
 	f2fs_unlock_op(sbi);
 	f2fs_up_write(&sbi->gc_lock);
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
 	f2fs_down_write(&sbi->gc_lock);
 	f2fs_down_write(&sbi->cp_global_sem);
 
-- 
2.41.0

