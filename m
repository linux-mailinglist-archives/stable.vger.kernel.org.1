Return-Path: <stable+bounces-132815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 854BDA8ADAB
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 03:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827AB17F78C
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 01:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8DF20E6F3;
	Wed, 16 Apr 2025 01:50:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BD30100;
	Wed, 16 Apr 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744768203; cv=fail; b=LhH8IMtiUagW6DcMuguwhRYa+z/b0BqOD8wNzku490jhnY3tMLk01YbbwanMMuCpRnlyQC1J3qQpYwErYgBt9dpkY0pIj9uw9dprxkz+2YdBqRv0Wp56RkKigqdO4kotbpo9Kx9UocLmJODd43GJnN5HHId/EJoaLBFigjOSZcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744768203; c=relaxed/simple;
	bh=JOwF7Goonw82Oa0oUiWLx6eRc3DqhgP6+GPhpMKcIHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V+anYQK80lmr3a2+OAt/H4gTEPAQq3E6wqnghqVtZ4kQrN/RkeLxCLc8P/ueLmICIDQjQjKOSTbanCVGa7Q45NxzraXoZ7+/eiLkVuqI4po/kYdB2YDElAS+HKgWUjQYXidfW5zPt0zvUqEyKFj74tdhDJVHwJ0sltu9+3RaUro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G001lM032060;
	Wed, 16 Apr 2025 01:49:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 461u2m8h29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 01:49:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQnD/6ADV1ajdoXa8exdM57trsFRHhXoMiuw3hdekAoCfOYh/WF7PcZ5IW2Lwutd6haUtMOSSlDbIFu1v4ywQ089vCMyGKTXxDeYkL87H0wbpmyv2WT+rGrt5nes1Y08Gkbd/dA3ZlTExIuLeo+yc/8ShMdf2VTMj+v5Okc9EIATi5FJWUanwcIXtQjobba7o8mOgMv0jGuhC6o/o4ab+gWvRYQzbJSHeQqBF32cUp9+u8es4IT7M3h8WmmoID/eCNRH5suulOoNJP6ZZ58Q8UKZwFTKnANpBXFgE8h+H/KEJ81qT0Y7VwtmIoFRJT6hLIGIKDTT/GzXFCVkofSq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DYnPO1p8AvY4fUlkCp9nU+dZx2y1SCUsnGSj4wU8VI=;
 b=xkYArKdG/MOlj3/pO9cTOGoCOkbRDVWCiaydYi/H6cxqwgmrzt83zLi6lYa3betRMyx619QjCbyjI7pK0mecXV+ZbXt+EArNZsBXDXkbPgv4IpbsraXeg8onFoE0C7rhBx8sg96qVv3awBf3Fgo0FmQXRYLrmYd3EK2c5hGuKcAiTqki2XOIUd30xVBCVD0N0yYsOvQzJGB0xpDQ6y468BovgLbERO+brJtoLAWduF7bVtyZ7m6wRAPNg89fTcSam6qXt5KIrDcdlWT/JPkC74L5za2mvY9lWloSmGE2pc5oMunkptvGMbncPmA17gzqbpPdOLvOB4LEM+7lFxL/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from DM6PR11MB3324.namprd11.prod.outlook.com (2603:10b6:5:59::15) by
 BL3PR11MB6361.namprd11.prod.outlook.com (2603:10b6:208:3b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 01:49:52 +0000
Received: from DM6PR11MB3324.namprd11.prod.outlook.com
 ([fe80::fd0:4a9d:56d7:c039]) by DM6PR11MB3324.namprd11.prod.outlook.com
 ([fe80::fd0:4a9d:56d7:c039%4]) with mapi id 15.20.8632.036; Wed, 16 Apr 2025
 01:49:52 +0000
From: Zhi Yang <Zhi.Yang@eng.windriver.com>
To: stable@vger.kernel.org, peili.dev@gmail.com
Cc: xiangyu.chen@windriver.com, zhe.he@windriver.com, shaggy@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] jfs: Fix shift-out-of-bounds in dbDiscardAG
Date: Wed, 16 Apr 2025 09:49:38 +0800
Message-Id: <20250416014938.1713735-1-Zhi.Yang@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:404:14::22) To DM6PR11MB3324.namprd11.prod.outlook.com
 (2603:10b6:5:59::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3324:EE_|BL3PR11MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edc1820-cdd6-46a7-970d-08dd7c88faa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J8ZJvTMqh5CSkxq/6tNwk7jE2hcb09fbvLHWZc00883s022VVc7D28LobvLi?=
 =?us-ascii?Q?8BnqyWN24epfEfCobi2gu6xaWZRjFpZVe0tozLh3kDFvaAadfpMOpxnKvj4k?=
 =?us-ascii?Q?QhJX41fC5mUfVy4pEQqBfGPwGpQ5Eu5TTlonRkqiPhvkW510oKtGsb9ebh87?=
 =?us-ascii?Q?0Siv38iy6ZaapTZyCDhHEKyRCh1Wd/z/LRJL6xAPOR6/+qqWtwonbT+dBsLn?=
 =?us-ascii?Q?Eusmm9jzZRqRZgeLuZ8C8yzSss2X9AEG27S6e2PerddV3u5eP0Z46qLg2v9k?=
 =?us-ascii?Q?bke0ELcTsNpFJ3tFjwTn34quFy88HdWwj2m3nlJ0YfwN4D+NaTbmPB5Epzfu?=
 =?us-ascii?Q?i52JnJHCe99wIyNFti5QUFSFqhNNBHR2RDGAeItw4l7+4/n/iISb6SxCKfp1?=
 =?us-ascii?Q?RWU6MUX0ofiOz9rqs6TuK8Ws29y89ByxDtiplaK+B3BTSk6dKWqV+HJGlcnW?=
 =?us-ascii?Q?nhIH/KXCR92QX/xdgVGNKWGpHhiuzkxlDTASN6lEPnOGvZS1d9F7LdHlMMde?=
 =?us-ascii?Q?zARI5DEGEzGuEXRRcTkU445OppLKPTqbQnhh7+zgJxWXy4bYzb25Pqxg29Rk?=
 =?us-ascii?Q?adl8SirUf4r5aL1w4dQAVYJOewpI5Mpus6lgvB8lM/7e5+lYxpdvn2DTHPKT?=
 =?us-ascii?Q?3H64YM2PUHHe5fxyebVEirJ398T6Uprb8MhI0gyrzUntZj7uEv0+nCoMOvzV?=
 =?us-ascii?Q?qabhViQlKNwjp5kahm8Zz3z5Im54sWEkI1eL2gnt+vx0r5WldFdfhRqbAxoP?=
 =?us-ascii?Q?PXeR9ocnhLgKI3lg3jNWhUjV7cfdtvuL3ZjhJeimISnqGPBy8KVX2cMCT0fS?=
 =?us-ascii?Q?10JpWVco4C+n91928FnIxgldYsgtB7qI/33wnROAeUvXYRpddx8AmEg8gB4N?=
 =?us-ascii?Q?/WvoAbSCknCPoPvF3Ov4aGFmUkM9W7pxs42vjNJdrr8x1SH90RxC/wDsogLo?=
 =?us-ascii?Q?5Xia36E92sspgFz56oufeJFJh8UOLw+9xFBe6z+0IRFHMbr8b4gYhpGIaaH8?=
 =?us-ascii?Q?NjLvdxuqysxXYpxonuUwHyNXWqkuUhmaOpy8esz0JnRm359YgVJKaMmnpdou?=
 =?us-ascii?Q?qm4AKkGPmBIX5+Tr+LO8LF2kMsd1BHiO9QcINWgesDyi8G7rp5Bk1izMo9bf?=
 =?us-ascii?Q?Hv8uVCCFDfVeUckeQiGNsptv7jy7NQubPuA8XwNI4Ul7zcC0pwDsVIVaGpAQ?=
 =?us-ascii?Q?QoxYTD3pYUIHCQeUcn49+257H3Vk/GTwDE8+d6bthBKB5IwxgC8ce/IHP8eQ?=
 =?us-ascii?Q?mDAMPffJ/jHc4vyhY0rP/1OydAwnL3+UXIDDZQSqmjkpAa5OmTQAV1kUZZ8n?=
 =?us-ascii?Q?yT3qIEuz/n+8QkFWfNoc+q8KYYwQdKTNFq08EO2y8v2lTXzTDEri2phENJQH?=
 =?us-ascii?Q?jLgf+atG+ffKCRFH9EDyRzqquQQ0BLg9KsSslHuz5n1PTAuCTfbkC4pwNN3I?=
 =?us-ascii?Q?opru2/12I9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3324.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mzEOyYywiT46TakgoCvz9eQqkH1PZ+YR7EVS2cD7fZ7JYE+SB06VT6ULpJkW?=
 =?us-ascii?Q?2VZcaUNmBzxNA+fyL0iDbOimnyhMpR/gb0IsfDxXgTo8lXy5GKVdSK8Ef6Wz?=
 =?us-ascii?Q?+RAfu+c1YsCt4EEmV8q/Pu3nzE2+MWmBqOtz5qDwnz+GvGRNXmmKMiRg6Nl/?=
 =?us-ascii?Q?4HnuNzpbtZUMQuPsEdaIO4Ad/DNT1bS/i3ZAxYjX1rtkkBzq1496t+/+lygP?=
 =?us-ascii?Q?x6iBLgkoQm4vNzQp/V2fDkv0xkKcPsmXEJpT5/GCosNtdM23jG15FqkqTJOy?=
 =?us-ascii?Q?9JtGrIumLAyGwPxPcWB0a2aMJNvIJxggHHP6hwCbmIE0bjlGiZHTsraVfHYz?=
 =?us-ascii?Q?39E8ZeJ3fRpFK7gVd7enYS2eDYuxY3H+pjtgfs8pbED3bl8L7k5T3F5UNkgg?=
 =?us-ascii?Q?U6r0PxOXo4zp49/Gf5Dmuq/P70oID9oUNpWRUj3q/9bc5ETBs+1ZgJq9cnQJ?=
 =?us-ascii?Q?mMa82IdXvf1sUODSnwufzHUHCdTlCg/Gaya2E7R/XsHuO9/CiC+xJLSzydPv?=
 =?us-ascii?Q?Da59sgdU++8mb4AJkhCPyit8/SdUZfwrBxw4xmeyMXiQpNf3irGErYeOpWX0?=
 =?us-ascii?Q?BtI9SQQdzglnPaokq9noUrqPss7qaclQo03nPwTvyB3kgMQA5KaxYjUMfdae?=
 =?us-ascii?Q?rUkkjbv6Fl/aARYsJ3ItDWq61WzZpEicRSbwXcV93KFlE+gyDEy/dGK6j8zC?=
 =?us-ascii?Q?8EPHmLlk19aMPO7KSZBCVX3yishP3paJmOOpHRuImwpisZJmslIzkI1L6Lq5?=
 =?us-ascii?Q?jaqP54Gbwl6NfiC9RAK+hsPLOVg2TWJQlfPYrnokPJ0QfXtfe7gXOJ/TKab3?=
 =?us-ascii?Q?jY93h5jYrJfvcTYymkoBp1wIysWmeqBHION9ApJWO2NM07zJAuMk3qVnM3yo?=
 =?us-ascii?Q?D/mtchXTJ1MYqjmXUI/pRbDSFBpdn6UYRXpU2mBKC33FjnMOoEhnOeLbr4j9?=
 =?us-ascii?Q?0kV/MgEicTQtaOcHxcvGqrcXydWJdA//1Huh5mMHEcmylTGSWAbkvo9iTmvq?=
 =?us-ascii?Q?4FwDN0f4wkT+q7eV9Eh72IL4kgEVakQoi1xXBX6KAHDtsyLnkujlMZnYgawb?=
 =?us-ascii?Q?QuGjCtP99G3miz+eTVlXz6b16LK6d3EPL9b1AyR4qp7rIpESTX1Ytn6f3MLE?=
 =?us-ascii?Q?3uCUmslNnngbvhgbxrvhAft4CdQ7z35/7q7kcZgq0jnZ1yfAe7S45KXVcq76?=
 =?us-ascii?Q?2nAvKnV+89NLh4JqE6YLN4Vx05kLB1wvlneyADx6fGCO4ZFnZTYEmvoARh/j?=
 =?us-ascii?Q?o2HAD8Exkr9oPmouxgVb9lmxdEg/Wp9dDAffq+HMYUvOD9kAOZcoB8BruNjf?=
 =?us-ascii?Q?rm4+4su0FizQm0LBCoCpUHvf32jYCrwdU+u657N7xcUjVYFIJRr5DGmx6rpW?=
 =?us-ascii?Q?spI7srSbuhGxMRv12uwGLaIVQCgmT1QENCQbEhvCyRgpXVNG591YPJ48nzbx?=
 =?us-ascii?Q?ppOpb7E1WdTbbljtvkeFTIU8VhhI2YudQObBiW1UecV8J7HTlJmYyZPKSkzg?=
 =?us-ascii?Q?X/hUxZcSwSCxi7ubcd2b2L04aTgjsKTN3LW61V0euSvlWemtaCt0CfV0+GUF?=
 =?us-ascii?Q?VuBbojAGm37U2WWzslOJT62NmRrrQqZUguiADYAI?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edc1820-cdd6-46a7-970d-08dd7c88faa0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3324.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 01:49:52.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +RqfEI59a020l9Z0F7G8k2hEVxclEjl5A46UU76j5DcqSvmE7biEgcTly3ULoNob/qsPL7aHReCJ7Pb/N7UnVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6361
X-Proofpoint-ORIG-GUID: dhTksLnlLq4YsdsvRp84um5YeW8G2FcR
X-Proofpoint-GUID: dhTksLnlLq4YsdsvRp84um5YeW8G2FcR
X-Authority-Analysis: v=2.4 cv=BaLY0qt2 c=1 sm=1 tr=0 ts=67ff0cc5 cx=c_pps a=2/f09Pi2ycfuKzF0xiDRrg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=edf1wS77AAAA:8 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=03eq-TzXFGS1sWTFOaYA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504160013

From: Pei Li <peili.dev@gmail.com>

commit 7063b80268e2593e58bee8a8d709c2f3ff93e2f2 upstream.

When searching for the next smaller log2 block, BLKSTOL2() returned 0,
causing shift exponent -1 to be negative.

This patch fixes the issue by exiting the loop directly when negative
shift is found.

Reported-by: syzbot+61be3359d2ee3467e7e4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=61be3359d2ee3467e7e4
Signed-off-by: Pei Li <peili.dev@gmail.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index e6cbe4c982c5..0d314fac32ca 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1694,6 +1694,8 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 		} else if (rc == -ENOSPC) {
 			/* search for next smaller log2 block */
 			l2nb = BLKSTOL2(nblocks) - 1;
+			if (unlikely(l2nb < 0))
+				break;
 			nblocks = 1LL << l2nb;
 		} else {
 			/* Trim any already allocated blocks */
-- 
2.34.1


