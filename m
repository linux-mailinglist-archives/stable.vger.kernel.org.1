Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4AE728A2E
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjFHVVQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjFHVVO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:21:14 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0902B2D51
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:21:14 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358K00m6022555;
        Thu, 8 Jun 2023 14:21:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=sKQEd2SUWU06zWPnuP/vSa/UyC65V0E8QaxheLy0Plw=;
 b=pl4kFHGRk1rUHAdbBebbgsq9ACoJSNiZX92EMg1U0DLBWhitdG7KrP6KtbIMUxXtbpqy
 N8++0yYzkJKrhAHBa5ogZGXWpFkbLxiJECzMMWodHZZWcxjFSxpYgUIO9avt9V8+OAGB
 2kSBKYs3SRkLHkcTqHdF4UMPjRniwtmDUxpwsq3Ci4J9+82bmb6ghjdQW5GtJgiutG9x
 WDDOkkx+RQiYDBtzWkRK+ANFCyZy6w+bNn8Cmd0aSKSNLbG8EOkVGwKZpdYgpUysON/z
 8pw6PYMRU72Pt+wzQKHNivkczACHBJOUOj2PIqZtWuZlLtpnMbfiN7B8ypkElux9VPeD 4A== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2av7a3cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 14:21:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR0ODknEZCNMwlR3Hq+ws7+A+/5C5hlzS20eCP37lHGifUzXMbbLgpVzH63ZmjW2CZzRVvGkKOGxs3piOQNc/B1RLEtQhBjDFPMeAuiEq/M41FBjUT+CeuVhakrVU8+5wWcMMf3vgyRN+8rzZM0QXxkMb8ZBVcCXYAbuujTTMHpb4Ya9Ln4hbzSDY0Tj9VfbxRi9O5018qppPjGU9nF/ckUHZiEzVpzbksmO16H+3WPZb10/t+UItvi6L46SUW3j5MUuQRpInGAVAEr3h/tFJkPWiz8OEL3OqaYR4XUh+dBFCXLyG0zIXQzLRPFZiG2c46F4xtavnV62hBt3vdUpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKQEd2SUWU06zWPnuP/vSa/UyC65V0E8QaxheLy0Plw=;
 b=VKzclCD9RFbE6KGLWwjlnnUwDrvWQpy2yf2KX/MHpEJZIG+KRgcixqJJTrQK9yZ5HrSpTTH8quJWv1W3YTyxJhVYjfcN8572XHx7dXvP63SJbLbu6eq+sARBkB7lgD7eqA8cFI+awGq9FhlYOWD+7m+yiSYGudUcJItcsLGGr56bNAQabL49+AJcDeLgHg0kNrPj9l0CvmbsMt/VjzV65Hm9f2RZnSgIkZe6v/FsNyGqodPel2fFRp+7BsVI10FZ3zFxwDpjPSYzHlEPiTPhsoyeBiCn7Nfgma0m0/OJoaPy73owZYSAbCKY23VsXfr+lFsIKZsjDScBNKfdiQF9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by SA1PR11MB8445.namprd11.prod.outlook.com (2603:10b6:806:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 21:21:08 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 21:21:08 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 4.14 PATCH 1/2] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Fri,  9 Jun 2023 00:22:12 +0300
Message-Id: <20230608212214.8636-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0170.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::12) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|SA1PR11MB8445:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2d4d77-8db0-4040-4632-08db6866466c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSDBj2MXG0nSFi2VWAUUm8Oy5za8j2CL/FgUvLMQo9+hcjhE+0macHB66fwEF50nbmZkfrMbd5xvLTS/UhIQAXohLUkuzvFzWDpFE+REpRBujcqdrwg+6rXbrc8MA/ZGlJIo2ltNtZqg4gQEDOaSQwpujHE2/vwlpHjeyPMBq8cM6k/O8RnLHulVGpxMKZlau0krYzBBFNi2t2nE99BwCf3j8L2CSNPwLigtwCq9OnMIoOH3b1Y6Shj0uMIjjYYKTEKLlFG2gj2X8HSzBmyKDafSLegoGjB0lumSfbLPpSHssfRQk4Kb7MX1B0uNL9MDZQdUdwQPzELPIJrgkYnzZEh44hQpZkFS31oyXBXfYmiCcdkzpKhB3T/kIDfwSVPv9PA8ysZSX0vtflGwiarZwqAyrkDyteFBFet5NhomrYuHVr06ADMtBHpNw4yxHvL3O0iLmIGyklvLOUTcG8FjjXfz3DNJ1OAaJmUPEcB8jnnRsxWBd+74uJP8JUnV3+orzPhYsQwpvAaZi/4lV+wXG+9eHpIaZTPk9bjdPPMCOsjqOKhv/xdhN9O0/EM65U1CAmwoqNWjLyZBdOFTYhkdm1R+TQhI6gQyqARosY9j8KF6U65vhDc3HadYVvha6Vt7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(346002)(376002)(396003)(136003)(451199021)(6666004)(83380400001)(54906003)(478600001)(66476007)(8676002)(41300700001)(8936002)(66556008)(38350700002)(38100700002)(6916009)(316002)(4326008)(2616005)(6486002)(52116002)(1076003)(6512007)(6506007)(26005)(186003)(107886003)(5660300002)(86362001)(2906002)(36756003)(66946007)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hI9uoD6jXlziuSzz6lfJvKlMcp0whXGRvmh6IWe7HsXDcL7yQyFpnuQv68xZ?=
 =?us-ascii?Q?sUNAoEL1gy3MV3dE7qaD5B4vHgf3AwPkEa0cBe/W/SEAKpH4CZaFDnAq52Av?=
 =?us-ascii?Q?Y7ysoTNFdFRSX9qya7ASmoQmVgDLvP8Fz1/IJygmi5xMWZEA6kktT1nLfdz1?=
 =?us-ascii?Q?P+HMMT1vjwqoZm0eUKjnHEV9G+7lFYK/NH0EoyeL59mBRkFaVlr32YmCnzDu?=
 =?us-ascii?Q?ZlNKmXr9Ey9qPm1XH5r9TMhPB2ANCMjoG6LTiMPtFrPk/xe6wxamve8LDmt4?=
 =?us-ascii?Q?6xPhCf2vEsO4NXwvgNC0keGtQTPoxwEvzH5yrwHwN6nkns/etGidbPHDjsm5?=
 =?us-ascii?Q?g7all7VthJAuUKVn8eeu44n/vxAurSFtQv/hFV/TNnrYXuTWWA4YM/jTKVpP?=
 =?us-ascii?Q?BL0xyGPDQ9DvHeK8m+Aweg93gCDeTKYTiW2x8VoZQxvzE44U8QKkJ6qo9RW7?=
 =?us-ascii?Q?snKlgF+kMNKqv0mFUzWChYtviow+XwXxFZz/vHtEDnAFG0FyCwtK2cQIloMy?=
 =?us-ascii?Q?9Vwbwek+b4TNhw8vp0ouY+WKCZ1Y/gtkJjj5WYcDSHxclUk0PDB7HLTm9na1?=
 =?us-ascii?Q?znngWUKkKsj3nkKiAUBlJCaY9FOajJHAC5D9StSx/+Wvn4YNnk1Rv6ncAdbD?=
 =?us-ascii?Q?W9Rk8o7p1WdAvp1TvoON/Bh3ub7OVwKlZxZFkaz8o7F1ly8S7l4FY1em1Ljw?=
 =?us-ascii?Q?cDCvF9MsVTmK2sanIOdCoU8a+4pImjM+H5ah4mhWHQ6X+7a3ZLsxVSsyukY7?=
 =?us-ascii?Q?uQpW1SpjtI/Mj5lssa1t0S8/PBwr5VCizJqxKkiDYEJ8loiyoC6kDnb2OZUx?=
 =?us-ascii?Q?UKha6Pk9Kfo31sapr84QH1Ac5xJCa1jxMLMkFEJvBTh0IJiaL2AZfC5jK6Ea?=
 =?us-ascii?Q?M4Z8v5LYh8436g8IpuYa17GvSRiUIEGtxyTAGWkVdLj1bGbMhgHUGSwhGbQK?=
 =?us-ascii?Q?aZOxEsSOM68bF48kY7g8LDxlrQZq3ycH68dbX/R/dYgtVF3ZuQ/fRVpPNJ5q?=
 =?us-ascii?Q?umOYc8+RAtY1qpVXgq0OHENJRSA1wh6xbPCD2IxJXDu9dj8BNwZWKfelJwEH?=
 =?us-ascii?Q?3wdf/1ne0bDO8l8BgpohYwaflmFTwXcnpXvVCp4H0+XEc5jecJUbav/fwbM4?=
 =?us-ascii?Q?ub6wDa7p0rqY8+lwHp0txxvsdKW3rfyZ0hawKAZGKhl9JF2VocbD/1Ya+FAf?=
 =?us-ascii?Q?2I9/ZwR2HqeQu9nIzmf4Xmxb9R5eRY0k+QHW5XafzDWjGjgFbLrm289PWXYT?=
 =?us-ascii?Q?G+onTnk2tx7gt8Po9Ewt8pLaLJ1ixXrF2vGJudwau5fgCwHUcWwYaCIEd/f/?=
 =?us-ascii?Q?+4j4swHdCW/QGGitMoLgtqaRkUi/4YQCtEO+nK0EN0JZyvYxwR2tEpUrCkGB?=
 =?us-ascii?Q?TMglWjxjK6cFp8cgQYSZLaWF6V2Nq+13+4rpC5r9Dkv6eKU7zvzfDFFoSieW?=
 =?us-ascii?Q?H7jMbWIC7Sx4MUtsrBjr0LDliNsOcVjv7ENE+4bj2HBk8cxNT0VIm1UNxvqX?=
 =?us-ascii?Q?VEiIoZ71rAG3UQq+lPg+W7bsojKXme8oJNbL66jDevDeA8SV9vNmx4Q23hsu?=
 =?us-ascii?Q?1C4DbfeQQNevMMstwwNnpoPnMRofuMvEk5TerzWogr1tAn7PA+40LTEfKgB3?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2d4d77-8db0-4040-4632-08db6866466c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:21:08.2180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oU6M5Nexdp9c9wFCbUHEClFtFS+tjDWimjoZlYemS61y9WKkXIHSvvqgdvvX1y0hxgK2wdH/PNABrZX2TjltiBA1FrOVLy8pLqmIRkgJGmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8445
X-Proofpoint-ORIG-GUID: 3GBT9s7-hHekYH76-24YANamnS5ua6X4
X-Proofpoint-GUID: 3GBT9s7-hHekYH76-24YANamnS5ua6X4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0 mlxlogscore=998
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

From: Josef Bacik <josef@toxicpanda.com>

commit fb686c6824dd6294ca772b92424b8fba666e7d00 upstream

There are a few places where we don't check the return value of
btrfs_commit_transaction in relocation.c.  Thankfully all these places
have straightforward error handling, so simply change all of the sites
at once.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[SG: Adjusted context]
Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 313547442a6e..33700561c582 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2387,7 +2387,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -4014,8 +4014,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -4210,7 +4209,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	btrfs_free_block_rsv(fs_info, rc->block_rsv);
 	btrfs_free_path(path);
-- 
2.40.1

