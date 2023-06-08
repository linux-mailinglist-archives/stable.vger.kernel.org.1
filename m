Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D694728A26
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 23:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFHVT6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 17:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbjFHVT4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 17:19:56 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8F02D51
        for <stable@vger.kernel.org>; Thu,  8 Jun 2023 14:19:55 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358KAE1x023656;
        Thu, 8 Jun 2023 21:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=FzlCd9jzjkslgZ8PeXCFL1sHPsW9qLu+jgdmHM1JgdI=;
 b=lK7eXKEM8cBDWGIr/BAaeR63GAbTxzgPP36P3++vc3SicvdVCkOPzJS/gC0DYNb1wBRn
 Z0DwJU8vlH0NJ1xykm+3sPTijBxMm48KUwgUPOXfD5hfTGHwLod/+7kQLAY8/1G5robs
 f/Ea5VU/MaI8QQB72VmT1iBEYXVVG8U+Cc8zQ6tc+ciZSZAr+Wri18gJB5XH1Q4TDW4v
 NRdgtklQU+aQ7F1chyryo/U3Kn0hHtj/j6poMsKfgKNsH/VuCsbRIZmCOg1sk5bfvA3y
 YRAIZ0TfcNrrWrrGHG8XAjUNQdaxJG0E6wM/3yUlE8ZSXNTge8mANwxbUrt+O3RM4SBZ fA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2aaft527-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 21:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuA8erpXv5Y1DD5ac3/Xkmc9d79K7t2uaYnW287Pa1IZ9vkLMINtSM8NMV0CtnqzNNJUbGvTPFBoXdYoZtgc3OqfyDwJhPjejnimAT9DZWMBbrd9s+0d+x4AxJ10xFz56YFn/3+/B7SzTlBSeiLw0xChht0P1MphGUYPKuE4tAXIzUK/Y6PhmrJpGWxeTBynZXzr7cVPU3JO0MWcLzayLXhGf2XzyxKuliAxBECCNiUj8QjdCh6MLBAVMpJ75Bbi1nLYQDClz9VPPZyQtu5uyw7nkKP1CEtdEpm8balquVz9sR0OZ9AYpUW264Ly+qsQgCcxBgEnxj2+cqFG5zr6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzlCd9jzjkslgZ8PeXCFL1sHPsW9qLu+jgdmHM1JgdI=;
 b=MFvrkjGzEbq01IQSSFCw7V8d4BDoEK6sBlopFt2JIe/bzDRHMuYVrdDLY0UwWJMGIpuQA5uuFPM8E2iMHNQ3uFjx5EtBpNNIAQzsvT8ilReZiNFt0FFLBs5/zgfLj6sDWP4jelTbb59zOdGXtnbhBDI8FgcHW7Ziwztb54wXDakzMIm241TMb4VzBcda4y9JhOQ4i+sOuK9Exa4ALVU+rf/iwusq6TSDbBkln56Tddb5dU3MOsGytI5vy5vWwygMNlfwJUNT/fYc3b9qDTc2LyA2f3JXTSH6HG+uN0p+7tFHlZ2DUTsf8p39Fqve/WUM3NYUys9/+GaaKb4wI63Nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com (2603:10b6:a03:2d9::22)
 by DM4PR11MB6359.namprd11.prod.outlook.com (2603:10b6:8:b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Thu, 8 Jun
 2023 21:19:52 +0000
Received: from SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde]) by SJ0PR11MB4989.namprd11.prod.outlook.com
 ([fe80::e27:6174:8fbc:3dde%5]) with mapi id 15.20.6455.034; Thu, 8 Jun 2023
 21:19:52 +0000
From:   Stefan Ghinea <stefan.ghinea@windriver.com>
To:     stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Stefan Ghinea <stefan.ghinea@windriver.com>
Subject: [PATCH 5.4 PATCH 1/2] btrfs: check return value of btrfs_commit_transaction in relocation
Date:   Fri,  9 Jun 2023 00:20:57 +0300
Message-Id: <20230608212058.8477-1-stefan.ghinea@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To SJ0PR11MB4989.namprd11.prod.outlook.com
 (2603:10b6:a03:2d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4989:EE_|DM4PR11MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: dab3eb92-a97a-4175-69f1-08db686618f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/9nDG7j0o+Jubh32O3No6vY2N+j2vIcOsW4DIcz2DzRHYrycDM6O+G0HL3c65BvXmQJMDZ3DZxo6rzMR1o3jFi3eT/zkpikGi24DHUjwR/fmsJVzQsnR/UEbj9l6O2INFOMWGcC7B9SntWln6gtfZnxqYV3a863R7cgNBq8Fv6SUyVWR5AQPjxK7H/DYM1FMPvyMhyA5o5hVX5MV5BD/r4CVPHOMqWgPRMHCd9Ds+vdX3UJdcOEEZN/Th83YDKVls7KrhThEh7BqwWVvcV+mwT91C6E3RrbioSCGrFhT3Ks5RJ+4O7w2TZpa7fveOAGrARaO1+sLMWAeW9MW/qPZiCS8NmGp0FiM4j/7Ieo76PhJ+eTNTAsSUrCxd6lHGsJP3HGSXWkHMl9LINdvlhFGWODDpNFRsN/fzXJDnjuP7ZqJVQqPAMaxH8rbQnzZDxttqwuWW8cnCHHUpwzvclsJJP+yyTWu3PyzjbgSDzlP/ufbr6tOxb4sZKjeQ4ulNRUFOzAH147U+yj+YCvRA9XSDGGRTK0FXz15fndBiVfniAVy/Z44qa3dBak1FMCQJTZFjTk60cTadx3uVH09yIog48xqfl1XTBMcCgn3a1X/XwiCVbFbGSL2Ha6XZSWanKz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4989.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(346002)(376002)(136003)(451199021)(6506007)(1076003)(36756003)(26005)(83380400001)(41300700001)(186003)(107886003)(6512007)(5660300002)(8676002)(54906003)(478600001)(8936002)(66946007)(4326008)(66556008)(66476007)(6486002)(316002)(38350700002)(38100700002)(2906002)(52116002)(6916009)(86362001)(44832011)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wsw5BvkwjHDn3A7luY2Qer+BOd5b8HmutSmrd/yvyu/q59KAF93jiB4pzQdC?=
 =?us-ascii?Q?RIVdLH0JVZ8N8DundklKCfWF4PPaPtu1VdJQfGoJMj8QQjNFPVAT+VTd62Ow?=
 =?us-ascii?Q?dUBkzRPFE3Mp9qRqSmmMJZENW6f7HGoLk+CSZwhJKARom0Z7Hmgve3jRoSTe?=
 =?us-ascii?Q?Z0EfFQZMIJDKTIXalRsLTWi3XDrGL8uhiqEjxyyiAjAf9fbUiGFkP/8Xs5QU?=
 =?us-ascii?Q?01AwjoFAfEibn+/ZcaDx4c9E5B4+2E6zTTomIz8k/TXvpM+aKSuuzG6Pxxd8?=
 =?us-ascii?Q?w8eQ12vu5M6HLkIfsz/KW/1FIMkWliypeeinHGJbqb3NCKTs3SzPA1PSeB8X?=
 =?us-ascii?Q?VuWTLFIdYzjjLXPXStCZTydwJ2DJgJpzT0oV6nU4+FnR5T26Z1bVEjvT+3fT?=
 =?us-ascii?Q?ohTqVrnRBAqnA+J5AGtTr6mgVmS5ghyDcmeH0lKOmGYZ8IW2o4fx4BHUHWmx?=
 =?us-ascii?Q?2h71gB4APNVL8und1GEPG3htNqq/0n7TJsdQpDNQqY5bfLeegbRnulPB+W9w?=
 =?us-ascii?Q?xpHSnTUaADU7esu3mI+rn+IK9XH/NwVDnZLg82q0aXoQ4/Iyxoqkm5wspOu4?=
 =?us-ascii?Q?A9UZDmDkAd2SIL1bh3Hf+z/lbflQ7n/uQP7flRXbbpmxEcZFbM2UMDe1vvIn?=
 =?us-ascii?Q?0fmWYmMcnPlG4SrbhxOXnK/r/bQRSaTnUSgF9eMV819G6aAPymgk28w1PSVx?=
 =?us-ascii?Q?k+cYvI7zsqBgMO2tAwSiCZyHG3w0fgy2grf3lZbkvKNViZPN/Phoh5ZjMaMs?=
 =?us-ascii?Q?7rvSp2AGz7c1i1WMTpvhy/9XuvoxR/Hd+Ffs9uNefTA5CTWijlMlD1PIHB/O?=
 =?us-ascii?Q?khzN2nkkDwSluX0WgNCEhCvAxT9i+8zJbWg5tZbtrF8vqYpjVPEGvIAMU7eb?=
 =?us-ascii?Q?2skvQtzyspyZLYekeWgXG7iweLb6hbg3mERfsWFAccjPOzay9XsJ9XWH9MF3?=
 =?us-ascii?Q?BpDCN+6grvBsE7x6QqXoCceIoBwqW063XZE+20ltoPON77TnMODm8qeYQDXu?=
 =?us-ascii?Q?UdVTun9kbotMDHPEFRoXRBwEonjXUmL+0qbTpyzdS3LsNp/rJeA1Q5JLfgP5?=
 =?us-ascii?Q?8AQsuV5PVlm5bMyH6jiD0r5vBqetqrf3lg24P08vVQMAXQ8F90/ztLz2uBVp?=
 =?us-ascii?Q?dkbzGNnpfpgvuCPBoUz0LO6IBMMluO3IjBYwRzcGRiPOocdZ3+gT5woQXUfH?=
 =?us-ascii?Q?u7yqipJgtD9vdG6m2XI9Y3jpQM3MVlrngVnY53OqD0wQLoLhbPeIGut6nXU+?=
 =?us-ascii?Q?klWUY+HhCxfV422LMDVShr7gtDlbCamLibC8wDRhU/2KyZXHjZyzi1Qu0Na0?=
 =?us-ascii?Q?NemkglkMjZUQuFVUcBpG+BUz/meKtLNFyU24t2nDUb4IYTNFWksyMu+Tmdin?=
 =?us-ascii?Q?76NrGGA9PJBXbsCwRfRMVcLySmoO3iGK0l8jfoyiNS+J9AXEYDO1e0a0wZz2?=
 =?us-ascii?Q?htn0skfqkvi6WAxCSyYsXD92CFh6h9B6boy8SEG08oPVby7sNK7LDLikU1rc?=
 =?us-ascii?Q?hCvzlC2y4zk4t9d/l+rcuoij2wBcpcs1d6z6oIJ2y1PV5L8g7t0kE6960pY3?=
 =?us-ascii?Q?AHzOx4zVl8gFe+FAMNM25ckuD+ZCEEEgkMhvK0EleLW+5d9duSEMs9LSX+vp?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab3eb92-a97a-4175-69f1-08db686618f4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4989.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 21:19:51.9729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pm3EyfMdkj9EkD7B6WhKrfJ2Wmim1MIzimKiEC01iiQvfCswwGznGLxdyxVNSMWnk2LZfLxsi1BCaKQiO53iNiOTJsrDVG3MignubpJs+30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6359
X-Proofpoint-ORIG-GUID: VEC0RnHcE11Gy4Faz7Ys17OQmRFWlTXG
X-Proofpoint-GUID: VEC0RnHcE11Gy4Faz7Ys17OQmRFWlTXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_16,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=905 suspectscore=0
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
Signed-off-by: Stefan Ghinea <stefan.ghinea@windriver.com>
---
 fs/btrfs/relocation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index ba68b0b41dff..c19686342057 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2511,7 +2511,7 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	list_splice(&reloc_roots, &rc->reloc_roots);
 
 	if (!err)
-		btrfs_commit_transaction(trans);
+		err = btrfs_commit_transaction(trans);
 	else
 		btrfs_end_transaction(trans);
 	return err;
@@ -4102,8 +4102,7 @@ int prepare_to_relocate(struct reloc_control *rc)
 		 */
 		return PTR_ERR(trans);
 	}
-	btrfs_commit_transaction(trans);
-	return 0;
+	return btrfs_commit_transaction(trans);
 }
 
 static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
@@ -4263,7 +4262,9 @@ static noinline_for_stack int relocate_block_group(struct reloc_control *rc)
 		err = PTR_ERR(trans);
 		goto out_free;
 	}
-	btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
+	if (ret && !err)
+		err = ret;
 out_free:
 	ret = clean_dirty_subvols(rc);
 	if (ret < 0 && !err)
-- 
2.40.1

