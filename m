Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40115759E38
	for <lists+stable@lfdr.de>; Wed, 19 Jul 2023 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGSTJG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 19 Jul 2023 15:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSTJF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 19 Jul 2023 15:09:05 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2EA1BF3
        for <stable@vger.kernel.org>; Wed, 19 Jul 2023 12:09:04 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36JHSZKe005511;
        Wed, 19 Jul 2023 19:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:content-type:mime-version;
         s=PPS06212021; bh=2vK9oquVs6x1jWXlPzoxw2BNBaGqC5w8Um1tbA6DRWk=; b=
        Ojc7dEt7m7U3QWn/Ym+MJevorsb0PJcDaQiG4fsWTpBl5syE+H4JBZCy3NBrU00L
        Kq4b40FVdbkG8elSoJvnDw3G2JF91uGxdlzjxkw6Khri73nj7GzSBNRrWX5Z5zC7
        c6Fw1bVKSZjBm1CWi0IfrNudYr41UHCaFLFj1+v5FvJaqP9FBRbj81Ib/TLKcXIR
        7kG5BXtWOYBg2nTcIvrxPCe1US/jfCCF3PCVCM6/qpIFqTZarPvaV13NUX88A3Os
        7CHIumRqFf+smA7PyzHgJKoac6/ZKoZV/OOfau2/9Ax4oQsvZu2pRqy2TLey88G2
        yxj9Fs4AWc1tky0eozCLvg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3run8abysh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 19:08:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1zSEoOz4xQbnIxM6ItuCnO9TawD0oOCvuk1buYV4f8XqKFzRZ1GPcxudtd6iUfAUpti8rsafuOeqyJ3NLhFnBN8/RKFLpUd2vbJXWJKwMl3hf5GLOdtUPlmDDXAzx59x5pLdgkNEdjMNT4BXbBMYCTRAfum06rxAWO5L47fl3bPV4S5pRDayNsCWMhtTAM+rvZD/V+lHxbrTW2UOrdzlaUXuUxj4PcdrrmMdc2HL3JbtulozXQwDXOQ8Nn7MNLzGn+RniMuQxN+fiGHYBwA3yVuNpveOTmxCkwMvdQa+Liu4au1hokjoCn7p5Pwr9oaWIIFy7ridQJt3naaVNLCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vK9oquVs6x1jWXlPzoxw2BNBaGqC5w8Um1tbA6DRWk=;
 b=KgA6hfBqywWlbSbpS6ZUrpL0fZVXHrzjRjZ7hFqDc2UdbjpWWMG8L0gtSCdbw1qhmFZ/udgOF3lItOZhT0lAJFgoXdwK16i/8fagNsgMYKZNI12EdmewnBaHgmI7+MJPsdPRz9FpGMZWDKW8WxSon75WeDBc2FmDZTMej7QdiQmt1OcevBxVoeAJYbCpOIq1b0qkF1Eqrb+2Nxda89rOv0hBCPHbMZaeCn//EGPRv/JNQ7zQ9MHz24xnjwjZfnLd/a3XeSLRu+N2aQFiKIHJX0be7CQSfFSesKVbTZif7Sy0JTYtTdYQ6hhSqmKorPP0W7wONW0ECmDsW9hhddBSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 19:08:54 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::dc1c:8053:63:bdbc%4]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 19:08:54 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.15 1/1] f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()
Date:   Wed, 19 Jul 2023 22:10:19 +0300
Message-Id: <20230719191019.15285-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0136.eurprd07.prod.outlook.com
 (2603:10a6:802:16::23) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|PH7PR11MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5ec979-8ad3-4684-65f0-08db888b9889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIzDlEdLzl/PvbtyLPuQ0uGc9AI0NvFpAAycHjJET4twjsFcZYdmc0En2LSCmgol4lL3zaJKTXrIXG0cCsmXRz5VpaYx0kh1yCg8WOr8+cqb/df2tEKojaZ5b3545AEhSZVI2hqwcOOSLx4VtP/6Fiap60/IzasnrZHqUzI+Q4gBiQHjSuDmRpFbys79/N338bSrylAI6BiKS/LDM5dk2g16O1ZJ2+YDGVMu68/mIW5grFUfVx6ZhuqgnOW3gOcahMj5gcm6D+w/GVNuO39GUgeg8KMt/PTcMLHbTWMG1a/7Thh+j0PF2xYNMpl6ariM2RkLCmOECTjinzuhAB9xLcy5SCw5SkQOsSdLdN07NqtQX3BUfHxtJ6SWPJ777MgCco66pA+scbh//YavlXyuUYVmRoU4KaRui8Bvej5uwIzgsWbsYVEv+5QFkHna/sQkakR9zUPtml0q/1fG3RupcjqdPx6olpH525pwrV7RoPnK1oIiYI/SjNPgnRaCWHTrBoGZ90KNwxvCmSFgjuCPiainnnvvfefAMZkySgDC7nlJAJXkPSir5FJ8a6OYYBeDMjTYgsNY2CiY02eiiIQLA0UyU9IRS/ktfPozLzFIdBUFtcHuKChSUxFWu19lH7sd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(39850400004)(136003)(396003)(451199021)(2616005)(6512007)(6666004)(478600001)(186003)(83380400001)(26005)(1076003)(6506007)(966005)(107886003)(6916009)(86362001)(8676002)(4326008)(8936002)(2906002)(316002)(41300700001)(6486002)(52116002)(66946007)(38100700002)(36756003)(38350700002)(66556008)(44832011)(5660300002)(54906003)(66476007)(471894004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B7pwUajuHNTKtyrkweX4xO7udYka5pVh+df7UGDxOyRwx447oyTHM8wjyJ7b?=
 =?us-ascii?Q?hzqzo4FPJD5IGyxmv4VGANsh/MRLeIzsYLvNjxfWQePi0hwYEKxMlwPIe1oG?=
 =?us-ascii?Q?+PhhfEWy/hbgFBxfoesxYNbEFFPOazMXIiAFr0gPQGeYYmA90AtR0oOJA2ua?=
 =?us-ascii?Q?4VoKWKaP9LHCZqRALNeYEmaY0EuUOSPf/G5kBopd58QcSjX7QZvghQy29Iv3?=
 =?us-ascii?Q?6bk80ekvCp2y+ZP7yCv1gcCz95UXplZDEV3AhxHf4mrnU0yIRevT8hC1K7XH?=
 =?us-ascii?Q?zmrG2IvbkFqMgnQvRFZXie3FgeUl4mb/Or2+2Pb+HJF4FqtZ85J/cM5fJ8Y0?=
 =?us-ascii?Q?HYxX2HW1i1KdnCMoIOxSKuW9h5BaU2yCkqOK5dbE2OsOkFUTfSiDW1fRqtMY?=
 =?us-ascii?Q?Wf5nzA69l4UTntan/uGQtkvyvrZvudZY8Q+lOGcp2u4AAUVoAim3F3dqry3z?=
 =?us-ascii?Q?U+ZfkQmDgVG3AoWdiheBUlk2Pw+6y0By07bAv29IB41LLryRyt0yZ3tHR1pg?=
 =?us-ascii?Q?PSPWUhTHG36HDAOJBHEJaLtLVqs+hgtSwU2VvEJEdKKDRBgDU46IlOCP/80L?=
 =?us-ascii?Q?Jx4L1HZttpfSULPBpneaXRr419Su9D5Kw2DjJ7Ki1JqVRKArnmWS4axrsdie?=
 =?us-ascii?Q?RlwQ0U42RF0lKHbgDqndhhRL5CsVbB9Vq77rPkpdd9Wwh7YLuv6AlVIZRmLs?=
 =?us-ascii?Q?aW6K76h+58JK1JV5y2Db/XsXs78l4X8yw/D4UAPbTO5Jg5wpWpsziHV9yOvy?=
 =?us-ascii?Q?8VR/eqowL/F8K+FNJpLp6v8HxjzmXb7e/ySJ2bSjX2KhUBLoQ8w9cHzqx5UI?=
 =?us-ascii?Q?bz+uKoxYo5HvaTQRfq5+mfPK7jhhkxLrKlQ6OsCWv2UvqAAXU8YDuUaLUVi8?=
 =?us-ascii?Q?hnVc3BXxQHU3z3joI/hxNiAuf8LPwXXck8BXI+iKSZs8CjfyPfC1EInK+uUQ?=
 =?us-ascii?Q?R/WqRNE9VTx3W+S6J13LdhI6/5cF2ENtOVHN+aQ+0oXCsneXmMk2Voxh2pLI?=
 =?us-ascii?Q?9ePt3Mu4lU/Zi0Y64TAr8dbBtduqAkNKrMZE2lB8dHjOTXha6a5Ps1D+MGmB?=
 =?us-ascii?Q?8LB6pOLFJweIa+gDUkPyNxPYtTdSHlCXfLefHVC7rl3j5z/ZOWwAqOAvEzAo?=
 =?us-ascii?Q?djdeNmV+GAiSf3QhSkj6xG83SABIYmY/1mZxNMsf3YwUiHfGp0sUtK7qIUVk?=
 =?us-ascii?Q?ZueJIUOAfVa6HOHuymFTy8bB+YUVtXU0mNo6bDiS7Lz4K8FkeriywbSO5CBa?=
 =?us-ascii?Q?vuYjMkgqXdEjLUDtv9LujUybwKxcZZsWxt8StU1md2Mj3XDZghd/x5SIbbfq?=
 =?us-ascii?Q?6nAy71hJNr6H06LaQSR2F6yO57IfWnmT3bVDoOnf1nRmnPw2SeF23KsJXVil?=
 =?us-ascii?Q?8uavPkKbxRiic0ZyJunBGG8ER1bwZNg5ZqK1oZvF/IFRPSIR/Ivusm6XfEmM?=
 =?us-ascii?Q?DtrbgGpMmrsA3oKcoDYf+D+RyNmf5vLE2SkUGN4wKLu3EkwcPfTK2t7f+DhQ?=
 =?us-ascii?Q?yw59nEU8FyobAfRh1k9hOxjTb6WYEhD2Afnr96srRjXImXyOSBDD6kqTWPA0?=
 =?us-ascii?Q?QkxsGqpqvT5HgiXXezTXGYuD+Ph7p1zIuxwl9CS5xCTLI7jHg5hZQlN5uvUJ?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5ec979-8ad3-4684-65f0-08db888b9889
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:08:54.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSUx48ithmFce9iGCHPaeDzQ7JGVa+XklmX9x7teis60ayPs+/Gc4Ii+uWFMhE/cs7rIHfZTBvQUaqekKaUcKh9c25Bl17iZOPp9mg8bR4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7050
X-Proofpoint-GUID: GFgXXlk1Gk8xJpSO_Ow0XW7ErsfF0A3-
X-Proofpoint-ORIG-GUID: GFgXXlk1Gk8xJpSO_Ow0XW7ErsfF0A3-
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
 fs/f2fs/gc.c   | 21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5c0920e11e4b..835ef98643bd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3660,7 +3660,7 @@ block_t f2fs_start_bidx_of_node(unsigned int node_ofs, struct inode *inode);
 int f2fs_gc(struct f2fs_sb_info *sbi, bool sync, bool background, bool force,
 			unsigned int segno);
 void f2fs_build_gc_manager(struct f2fs_sb_info *sbi);
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count);
+int f2fs_resize_fs(struct file *filp, __u64 block_count);
 int __init f2fs_create_garbage_collection_cache(void);
 void f2fs_destroy_garbage_collection_cache(void);
 
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2c24162f72f0..e1131af0396b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3251,7 +3251,7 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 			   sizeof(block_count)))
 		return -EFAULT;
 
-	return f2fs_resize_fs(sbi, block_count);
+	return f2fs_resize_fs(filp, block_count);
 }
 
 static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 615b109570b0..7010440cb64c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1992,8 +1992,9 @@ static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
 	}
 }
 
-int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
+int f2fs_resize_fs(struct file *filp, __u64 block_count)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 old_block_count, shrunk_blocks;
 	struct cp_control cpc = { CP_RESIZE, 0, 0, 0 };
 	unsigned int secs;
@@ -2031,12 +2032,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
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
@@ -2056,10 +2063,18 @@ int f2fs_resize_fs(struct f2fs_sb_info *sbi, __u64 block_count)
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
 	down_write(&sbi->cp_global_sem);
 
-- 
2.41.0

