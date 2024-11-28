Return-Path: <stable+bounces-95702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622C49DB6AB
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 12:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27DF3281899
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 11:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B7198E65;
	Thu, 28 Nov 2024 11:43:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F715146D59
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794193; cv=fail; b=XovyWbt0tzogvQT+xISe0Q7og/8jq5cDyKFRhp1n5R9eMNj9L+YgOFpfZqHedUHmcygPInaTXfeNTdibBpGEolcsF6nyRtSfRV95+bc9XjahSA7Sif0iR5CN74s5kMs9obk5NnZBoWh7Z7n0TML8g1qNsxZSXtNNzV4zDlRI8vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794193; c=relaxed/simple;
	bh=QevZq3QIIRmCVhS43Vm5phBabZBbn2KxIRpuFPpAAeY=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VN69wS66ZNCgB0tIK4bVAVFQkQex9TJynEqZyYMRKA68H03zwD69VnO8qpxO1OPIPOtyZt1kXqo19yr0T/xb7OqFJQO5zaVwxxoZGS2p6kI4in3QLfC1jb4RFe/ocRePzDCOWGPUMo/z/+YvnIhxH4rt9onOMJZ+o34LboiakHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASB2CWg031235;
	Thu, 28 Nov 2024 03:43:03 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 436719rwy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 03:43:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACCL12t2S1USRu5JdH+lzmf1yiUTZcnvdAh2fFsgUGNcJnMAK1pHVe74b1L/TE5qzGoQq23def1AAKFDX2msZ1p/880b0tgIZl1J2h0BP6w0TuMGZXrKn7GhI7r8YEo3eriWfUayPFUMvHwYJPQGiDYk6vT+X7ubPYzfyCrqdkj9yjqb/5or+vsaLq48GhbjTO7oYNgHKy8XU7UHzNsEj5p0pLgbqwIAAKDfdzIyJd0E972i7k6Vl1OIscdgRRYdpleUw3hBwDcubuw2KtRTA6dNFGGOjgHGe7ShsWQ6ZBsL2A+DKND8GBHJb36ZqbeF/Wwfj1jykzwXMp2FGlWgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OW6W+lDZqjyTLFDdfC6M9vY2RKd8TTUaBuCE5qV/O8=;
 b=bDqwLu2j9U9ZUnhnACXbyjSTQOW0d0l7CPrLD1927Qe2JaDdTigRUlv2OWiYRWWoWcALpgbBaqvj33XOlcoo0XHYub9SbBmdnZ5ApfhbUnWzc3+vUaPvD6zVgSLE9vhuXlhMSedw/+Rys7DdsBhEzPX7GyD6/agobfKsQPSAkJTzZ9U1PqnVwBw4t6/bRqrDjQNTzqGXXKC1qBpG9Ar8hU9nh2L+nqLTNs7QW45cBB9PoyBS0j8ZvLftW2cPBzhiBZQNGUZ+gyiO/38hMNoWGpxL5g3m1qQE20b+8+Et3nsJ5NJlO4pLhPU3xpkcWdpbBak7hhVjwNpR3NbD/diEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 11:42:58 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 11:42:58 +0000
From: bin.lan.cn@eng.windriver.com
To: stable@vger.kernel.org, llfamsec@gmail.com
Subject: [PATCH 6.1] ntfs3: Add bounds checking to mi_enum_attr()
Date: Thu, 28 Nov 2024 19:42:40 +0800
Message-Id: <20241128114240.4098561-1-bin.lan.cn@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|PH7PR11MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 67157caf-7d58-4e64-62c3-08dd0fa1cdfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9Zkbalvr6YD/2RhmGT06N5X6jfDY9u6nevML8rb1n2bahPVGBrPRiwUIlGC?=
 =?us-ascii?Q?t9OKwkHkavJMuG0QKjueh5Hphq0SILnXVlojfTpaJKZbqn47TDzCommPxkjR?=
 =?us-ascii?Q?srbT6LIBbMUo8kyHQ56ARSKCI/c43w6RGIJqaql/dOOeasQpQVpcoVwJEOKD?=
 =?us-ascii?Q?ev5fkPQRDdrHexLM7+g1gPdQA5qayyzsWgrxBNEXhBDiWX8J7k359MIeSDqn?=
 =?us-ascii?Q?x6d4FS/N6Z8oxQ5olmmDUFxqk7EZrOj+KHAoct0HiL5NXEGS9mjsXmDMRVLc?=
 =?us-ascii?Q?u2EPJsGScMJ6xpd2vdZUnevKeSvS5KW0HFG+jlROnABgD4ZyAffzgMFMBRk1?=
 =?us-ascii?Q?rlRB3LqCeCxsxRCTOB7PmTgbke2/w8HTZ9COp6Gsu22d79O7KdjgB8xX5uVJ?=
 =?us-ascii?Q?F0EJ2mmFepgRVj9KNYA8KbNd9nxURl9DjXXzrNBVbLbTvM3v3Zzz8UPHs3lz?=
 =?us-ascii?Q?cnF/FjKrXP++soxcT4l+eLOUXzvpH3wQqRaJxdslE0q/qs5sb3LTxyzTCYfp?=
 =?us-ascii?Q?v2HGjtK8swrumnzMzdjlJ7hz47jqhdOLzPgyTlqNLpBt/FPr3a6Xk7sLUaQd?=
 =?us-ascii?Q?d+avPVHfh76mLYVPceO36EXN9e4XSXjHRAAr74zt2h/HMHzpR9URoRgBK9u/?=
 =?us-ascii?Q?mrq8dMMk0sausQKtWQ6266SLjh//WfcA4jZ1ATDsIxYCKWB31NfNEOtTT8Og?=
 =?us-ascii?Q?8su+5duzLC0a82dc9aFlNTcUzp9OLFRCUS414Fzmp+V1HO0sBvYuuPgIO4kj?=
 =?us-ascii?Q?tnOtGclz3ADKC7Kwv8qTi4AICXODdK5LRxl0T4eERhvhpmhg41yI0GokgjLZ?=
 =?us-ascii?Q?KO3TKyyqwRyGMg/+MmGFFbDRbgtj45NYzkiYgHVp3HacyES4DmMOo9hZWXOJ?=
 =?us-ascii?Q?DqKdcMLsF3CWmxTZUVWEv+vnzoplLZSwizBgGa9x1GOY2dvtUBhIKLGMCLLk?=
 =?us-ascii?Q?MFnTI6+aAa+BgiiKf4iRtShNwaqVy1zvdkW4YYWzHQ4MN/yHbxTz3qrQgfrz?=
 =?us-ascii?Q?akeDegveVXDauqVEppJwA7VPv+SvlGNf3CCSFLPMi6W6QN75nVXiLi62STOQ?=
 =?us-ascii?Q?5p0s3ejNMQgLrBEvu/qspPfK8lbd0WXV5IOJhiG00OrcVfy8Ir9tKAje4NVQ?=
 =?us-ascii?Q?oExcHICWM6MGZXzrlIThpe7ZPT2fOUjtFl5ObGk5JC1aIFZ0imybvJ8GituR?=
 =?us-ascii?Q?mpFXwrmbM7pRrfOc8dbpYnFPDQm9a5r3PyZL4FjaOp0TFsX2TtinYSguhZFn?=
 =?us-ascii?Q?8yjTLJMjh7RSCsXIJxOEpHyhU2rZyYhOCHrEe7V0mbfpuA3qo6gQl7iztXR/?=
 =?us-ascii?Q?DWZUY054xnVpPlPYQcdGKmENaRbEpkmaGjfgWNQD27dJVRCgA6IfNxWX5TIC?=
 =?us-ascii?Q?YtfdLaFxQXLyZ4xB2Olh/1eNwhUnJgziUf8onWwTluC0tYYYIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gm5IXWErZ2bseQptbTwXRlkYpIAzrOtadAEr+71uEqgk2bKgJsgkgpejEBqP?=
 =?us-ascii?Q?k+thZVufmN2G79nSin8+4W0/1Gg9TgSBeWQ5DtuQC5UozH2rxD3tFjpx+4I2?=
 =?us-ascii?Q?2yjkbeVsfZM4lVV7vG1SZDZyWXgS72eUkdFycNm4SxObV/cIjcwqleewd9hc?=
 =?us-ascii?Q?3XHlZfvRzFLfSjcN+6hkLbo8nwZI2FCCjXKN4n8VXXrY4XrRHKpQHY0z7cNJ?=
 =?us-ascii?Q?TFugQ3CBh8UT/80byuTJfnbT+cd4qf20yI0FL4Vn9WTaH4j3Hio9NXZBrPUO?=
 =?us-ascii?Q?OtQt+ZTFJip8JGkj9WkP4RajLvRdRoloO4afytV4FB+QCV/W43TAA9aIX1/3?=
 =?us-ascii?Q?GXKTZcb4a5oWX0faE/Y6BOGlhsGAyfrKKbkNA08oAvSSJzzNtV/l9nGNhiMn?=
 =?us-ascii?Q?X3ly9TOFPgxFVjpsUIMNsfRZWx1KNQ4Nci1lt8wFJPqrBM7Ymhl+7dZOFu+g?=
 =?us-ascii?Q?c3v+0I2pj0JcHwua00S3v6zQ0EbRFv0hkAfnIcHooJvxHOlNwAyphdFUax2G?=
 =?us-ascii?Q?of4bNGqzeV3GGhFeSmc/syH5A59yVIv9qBwIAkimbnsyYyGbCs4KC0zyTwd5?=
 =?us-ascii?Q?22570N5hLb3GTVWQq4vxAaHGnjevEoTulanhUSHgLiWrv67LYo4MWVim5TNb?=
 =?us-ascii?Q?UT8kat1I+nyxktC9/FZgUuPYF6AZjf/LZr4oKP/1UkPyLFShtWCg/Y0qh1rf?=
 =?us-ascii?Q?o7dKhXsVOpCfodZUXs5TaEWZORs1dWtw1bRhZgUecbwMqVuLx4YLHb3/HiJS?=
 =?us-ascii?Q?UTY/fGNP7t+2kQM7ROhyO4n7jf66WLY6DPNd8k1wKFWCu5lTmENjm0dwL+Iu?=
 =?us-ascii?Q?96wfyAdkdGqcJ1dvzGn1WTCuaFbgp0w8okX48HL63PjTVqmIggt+vm53JeSp?=
 =?us-ascii?Q?Z0Lms43vLbEiXo856o7t30N++A9aPxmaSpS9KhkALQbH0aKqOqDUXj4vD4a2?=
 =?us-ascii?Q?8nFmUzwLWFpQ68Lld2WEioQM224Nsu39GHdzau7Iv/pkCA9QfAgok+eumJ25?=
 =?us-ascii?Q?pMsiTdR58kLDVg+9PBRmhdi03HBKcuUxQUzB0ZpMvtPKvAvmVis2vZF6PA5/?=
 =?us-ascii?Q?JyBz+iuWQ4UKQSzsUaALr2MfK+kjp5S1MAIu5k6AdAtl02KvC4z9W2M29BPs?=
 =?us-ascii?Q?gZtOOpE+rQWj9uJq2hxVmwViBIAuuZJmyo9RtimaV9QlASrPum2Zzc44KOXP?=
 =?us-ascii?Q?boKYgc4mad/D9J57McMAvkz8qaBkxeqQdAvVRJewh6ncr54Dx3wOL1ZVG6zD?=
 =?us-ascii?Q?yU0cn5TYT/NMWWLSphGZ3mGFo+7VDE+vzjIJ0Aqtemv2AYhk01cFqb31yFdB?=
 =?us-ascii?Q?fr7UEyYv8gNEYMbUNn6MFxHjEVYxFzvmPi3SBJKL+Fn/3gFRzHiBGaislU9w?=
 =?us-ascii?Q?Jpl+n15WONVaib1jJgIkammBEMz4/orPOryTDpBQfwHKNKdkPEFtvUQeeupu?=
 =?us-ascii?Q?cSdPPGnO6fzfJtJKEkpszvGbRWRvzXJkdJ3WR4x8dFwiCxpm7+FdO3VdRciU?=
 =?us-ascii?Q?HkjXziMw6g5t3RPWN//wuMlhG85y1Fxv3dxQ9DBXtOomn6xBW15F1lD7VVgn?=
 =?us-ascii?Q?rj24kjTPGqAcFnTjLnHYw4Yw4+gMH4qW533FAk/xHIAQoaim9vSkrttmQdvZ?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67157caf-7d58-4e64-62c3-08dd0fa1cdfb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 11:42:57.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xjN6vG8YLed96Lwl041oAKoCKY2iCU9ubfKafQ/ZzO0ib39ybtXnG981q0Dw7rxdcbzlO9W1fAwZxijXvC2zdjKcyvwzv7dyHAmncRhs9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5768
X-Proofpoint-ORIG-GUID: ZUIOkvAYxo0vs3SCN2bWzEUoalO6WGpU
X-Proofpoint-GUID: ZUIOkvAYxo0vs3SCN2bWzEUoalO6WGpU
X-Authority-Analysis: v=2.4 cv=Z/8WHGRA c=1 sm=1 tr=0 ts=67485746 cx=c_pps a=G+3U1htxrnhIFlrbIuZW0A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=pGLkceISAAAA:8
 a=GFCt93a2AAAA:8 a=t7CeM3EgAAAA:8 a=f8uUEWi10nKzcjNw9PgA:9 a=0UNspqPZPZo5crgNHNjb:22 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_10,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 mlxscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2411120000
 definitions=main-2411280092

From: lei lu <llfamsec@gmail.com>

[ Upstream commit 556bdf27c2dd5c74a9caacbe524b943a6cd42d99 ]

Added bounds checking to make sure that every attr don't stray beyond
valid memory region.

Signed-off-by: lei lu <llfamsec@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/ntfs3/record.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7ab452710572..a332b925cb37 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -217,28 +217,19 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
-		/* Check if input attr inside record. */
+		/*
+		 * We don't need to check previous attr here. There is
+		 * a bounds checking in the previous round.
+		 */
 		off = PtrOffset(rec, attr);
-		if (off >= used)
-			return NULL;
 
 		asize = le32_to_cpu(attr->size);
-		if (asize < SIZEOF_RESIDENT) {
-			/* Impossible 'cause we should not return such attribute. */
-			return NULL;
-		}
-
-		/* Overflow check. */
-		if (off + asize < off)
-			return NULL;
 
 		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
 
-	asize = le32_to_cpu(attr->size);
-
 	/* Can we use the first field (attr->type). */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
@@ -259,6 +250,12 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	if (t32 < prev_type)
 		return NULL;
 
+	asize = le32_to_cpu(attr->size);
+	if (asize < SIZEOF_RESIDENT) {
+		/* Impossible 'cause we should not return such attribute. */
+		return NULL;
+	}
+
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
 		return NULL;
-- 
2.34.1


