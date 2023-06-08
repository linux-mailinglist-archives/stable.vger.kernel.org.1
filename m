Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED489728A2C
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFHVU2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjFHVU1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:20:27 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514132D7B
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:20:26 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358Jm7LL009044;
        Thu, 8 Jun 2023 14:20:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=PPS06212021;
 bh=tHxrqpuJO/fVFovp9J/ixibXkDdUMc+0lRH7IxTNuxE=;
 b=pSMsYwVUYFl+aGr/t9JU9tLyaOJdLIrHkVPIOnvc2m/id8z8VeCSfNkokpg2gh9nzPDd
 n947UrLXWKbvpuoUDA6dMCl1yDukl4LVt/UKwPBqIl9s1wj2ecwQdgk2zS1rvmYa6yCR
 ODhdTXhBd+Kkjecygolz+lBePM0q6CE/1ZHDWFLEQ7pcAmq1+HgCsqpgaxwUXKGMYbxR
 8emuzYmCE4LSiKiqVSYLZzet0TGJDRFDofnLVlROa+jInsWb2iB3WVSC6g8fCQXKaH/p
 6wRUtrtlfIhmgo/Cl33XLi28rYR7YiXQgP5/kW6mTnT/qm20TZIY4OM5DV/X8cBSlR/P 9g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2av7a3bq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 14:20:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDw1WUl2KPKqvVGTk6OKFO0hXDOeeEjADj1hJ0+v/kVY97Kr45N82T8NacYqVvuF3CJK47cEt+XdYUFHei4bLOVzHyZz8FDrEOLvirU2jgVTno+9+Fc8wN7leJ9P/2fkRgFqW6Upg77Ia53dMT7lEK1dh5kjt1Lbr3sf9UfZkQRV/jdDw+Zn1Oai6bq5TM8rJN3Zz2XGjMdM8MMVm93bBNdkK+f8gVEcI4A3OpbCfq6CfP+MOykNSDjXZer6XwMBubak1NfIMpXG8cO1nHB4+z6y1HFpeaT0oYpKSOBGXpiUakHnYA3ssUPXCFpqqZf0yCLAycSQbpWti7PsbrOA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHxrqpuJO/fVFovp9J/ixibXkDdUMc+0lRH7IxTNuxE=;
 b=IY7WysfrY9ndC6K/93HcItgWtf3IQNqb2PEtVSF23dQ/MOUWes2qexWpFppVpoLTCva8wNahE4m9DPDKnj/s3mvi28uEFhL3WwQ8q8W+b8MxkHihCUKYHUx9Ql2TA29hUl+A1i4DewBNwLhAfF2BW+d/Gk/5LGCt1G1c2SjNqdsZEZkeEENnnpzZRQmXAyK3LHz8U0PywZNuvqqVvVubPOo7+/Mp3hRmUkvFVbHH/NmWW4M/jrKFgKNgrwWyezhv8l0nYauf+X0V/5ztl9Sl4bVQoHBpcRy2udVLQJGoW7CPb5kWvpVkLoFZwIk6LHsx1On4nMBUvDPJ3+MCwejkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 21:20:20 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 21:20:20 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Zixuan Fu <r33s3n6@gmail.com>, David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 4.19 PATCH 2/2] btrfs: unset reloc control if transaction commit fails in prepare_to_relocate()
Date:   Fri,  9 Jun 2023 00:21:22 +0300
Message-Id: <20230608212122.8534-2-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230608212122.8534-1-stefan.ghinea@windriver.com>
References: <20230608212122.8534-1-stefan.ghinea@windriver.com>
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0069.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::15) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|SA1PR11MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: f234a29d-33af-49d6-27e7-08db686629d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDWBv432k3MLyNw79Tq/m488S8/4D+6q0PEk6CXWX+qZx+FG/QM5EkcgDhTaDZxezQcW4JcvlpfJqbi2XJ3lzNo67N75EIjJqLH9NQ0mcs2nP6AuZcIx9nb2mtdiZ87RTs63Xibx40cdmNiFIb59jHQXvITAllzAksdb77/VbZDMhO7ntoxRxokMwyBMQAbvLGyseMcU0Z6+6CDYT9CgfnTn8HqojE5QCBmKr9DK1rpzzI/tqug6jQVAcJ0FYgaTlgnPrNakb7orP/hbMq7n9zHgAiQX1vCl4CbyUMH6JekRv4kYuNOIMRjUH9i0un+Emgaezb9UrNuE06eGijYUFOWg/uc6oAbW7aTsguKIn0ksJAu7VGh4586Cj4fwdVZVnsYg+MwHhZOtLnIHzhwdQvpHYZav8D/7+HaHlgX4+dgqdz+5Ras/nSybI+gND+G92X/QgrfcbWS1bgEm0ZqTlseuy/Kr6j5f9pioPzbjF57Jtu/VjHDBIHNhjbLCbL64FXriMsAgrE1MIsXWEKOu4umb5nNj7FmpeQv6YhpTiFiFI247YV5wrUJ3KB6AFg+lUg8pyGxEPsxhQth1iDB6q8lsYRlJb8dg756qQeKN+0HlESJl+2RYl8fQp/jwyjZl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(346002)(376002)(396003)(136003)(451199021)(83380400001)(54906003)(478600001)(66476007)(8676002)(41300700001)(8936002)(66556008)(38350700002)(38100700002)(6916009)(316002)(4326008)(2616005)(6486002)(52116002)(1076003)(6512007)(6506007)(26005)(186003)(107886003)(5660300002)(86362001)(2906002)(36756003)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/KT/ZjvdNJtyr9axCHzOCIvKRNb7x/rtzzWDoC1qCn1zixqyFUzA6cVKRIru?=
 =?us-ascii?Q?h2MaNmS4JhzfDWnVDu38HVb6WExnuNKxTDKtEKMB+DOKzcEO/fGA/jtDZrfF?=
 =?us-ascii?Q?y45ec0JzChSGCYeNXYiI0of550nm7IFPbYisFwH9FR1oHL0J0dwFWLHdagNt?=
 =?us-ascii?Q?gpvx4bZRugGLYPW8RRrmSYph1VPOXtvWYq5YLPn9GPOe02jRwIz5FVFZ7NiX?=
 =?us-ascii?Q?IluLEBXef1bHPn6bbEOR5sx2oDuVmIr8ofi9ObyW8dp1y0FzRZeOVbyEAdA9?=
 =?us-ascii?Q?u1wdG4sox2LYXmsm4mfy/wQyU6buoNvHHM28WBE6Kb3BxF+5yRHSN0R/0aQ2?=
 =?us-ascii?Q?JLvvrJwmn4P9LitTgqWTqpDVeWnBb4OS26H1Gqns27yGj/NujiSb9x0dREqc?=
 =?us-ascii?Q?WOkH8NAQHh7QbQOHVZ8PPUaIcazzKHblRnDng+lcgTwrJoF42aZdTTwCdv/E?=
 =?us-ascii?Q?dmfF9kc2ZR3OKnXJMq9ckiOdCsBytDpOPTJp4LYIixidHFzxTHDZR2qw7Ly9?=
 =?us-ascii?Q?Ig4Op298xkMPKJ35vBg5rd4q4c+Pa2sWG8SKF1TNejyvhbjG7QYE6KTb18QQ?=
 =?us-ascii?Q?sT/zLmoILk86UDoRyJObE6s1/EBMkhVyFTG8COgpaiTlFgrLDnYom+2Uujm2?=
 =?us-ascii?Q?av6F0TilvsKR4MqysD3GiuBoXj7UJXeS36s+zhjJ9n6oCXOfhv3jc5exJNx7?=
 =?us-ascii?Q?wDswDIzS5pfq6IrVghi0O0xo6Jk+Lss7CYQyzXEdfjaJ8WfkqvKWEXczUdud?=
 =?us-ascii?Q?XtUuP5cNTazDUxrZ8lfgJI+VurlNgB/wjDDISzmwDF+XJXoPqXU93k8yeOMK?=
 =?us-ascii?Q?VeSfbjDhEdY+rz9+EYep6edrDAXPOrVdlvcofDz+oCdddQqFoydHXXltGa7j?=
 =?us-ascii?Q?SaqjDAHo8fPamJG5XOyRApw47dMW+tjQsMuVFHw+bb6dlrg1zxXM25rQaeDt?=
 =?us-ascii?Q?El+PqNXVZqN/N+fPzDeAAQlScRo8Bu+ket6grwL97uoyA2Hx5+FK+J7kuD3O?=
 =?us-ascii?Q?nSASpIciaoZe7bCSyEzNFxqkJ/tEJWPRuZz0TwBSxqxq0BdKNA829vcUoJBZ?=
 =?us-ascii?Q?rjFhj5b2zW446qXneAo4Z8YxZ+ul16PYkfc1cJqkMV/ebVE1oslUYp8Y6PZJ?=
 =?us-ascii?Q?FC3hjjX80OqDqxlxK/oMfadKAEVxYA7KaCHEw+95RUs0NNuOTUW/KT4DJepU?=
 =?us-ascii?Q?ggROSrsygi+lcZCqctzDQSnP8G/Ha2i8552GYBV67w2e0TWc2THaMbViOu1i?=
 =?us-ascii?Q?LKhw+JG5Lcnep/SWLopbfLT7d5vKNdSPhsMlZz49EBeq3OUII9HtFrcnHdPp?=
 =?us-ascii?Q?JBTZTCtC/hOKPJXRtN4h9V4KPHet+bk+n3Fjq5+z1iEq6BXmWGdudYpwzckF?=
 =?us-ascii?Q?JyWCusyqF8Cxsd/v5Ah+RkBaolXPBkfvwBpl2ed+GZuvla97I6yZ6Lai0iFr?=
 =?us-ascii?Q?zsWDkGtR5cp5TK8ZreV1gSrUgVxZG0RItAFkVwM8txY9ynZB9VJco+clQ7IH?=
 =?us-ascii?Q?StpVxP8C3PuHnnGAJZm1xVWZ58ad/mY9q1pJqbIInDyfKIAX4OaIeOsBWNyx?=
 =?us-ascii?Q?3YZy7Rod6Zcn57Yf8zqJ0SEePfRxLKLn/rvZ8b6lkuIFFzBVnjS8ATRSmKsx?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f234a29d-33af-49d6-27e7-08db686629d6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:20:20.2454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Jx31Lo/efpw7+wzPhkJvYsvOfk+TX9Ad3jRb9rZDltnhIPZfAn/zQhB8NwzWoO5hHQPMzbhKBYoZYx/BAhpfugLUBwLZbSAJyE60m/zrXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-Proofpoint-ORIG-GUID: Fcj_8jOSaZCDR4tq6vKQOI99pfrixpM-
X-Proofpoint-GUID: Fcj_8jOSaZCDR4tq6vKQOI99pfrixpM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080184
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
index 82d0a13ccc54..3b9318a3d421 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3930,7 +3930,12 @@ int prepare_to_relocate(struct reloc_control *rc)
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

