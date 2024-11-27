Return-Path: <stable+bounces-95623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59B9DA83E
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 14:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7335B283138
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33AB1FCD19;
	Wed, 27 Nov 2024 13:08:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40B71FCCE7
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732712933; cv=fail; b=ezAop3gj2SxaazIeAgu2X5E9YdoNEXp49KYoYmg4v/fJlkJQ8xdiNGy4t07hOFNEtL7DDNP/mm43YuEQpbRkRQDnyrJg0/PKfTrYzEx/dB2aG8HMIKlBHf9N64r5dx5Q7ceiUrCXF+hT3SZSy1WjG/Je/xgUeaQW/QXrtkPGQe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732712933; c=relaxed/simple;
	bh=eU5MVUFopDfsqrcfIHDnrPKY3qJRSZyMFDKDzDbOUCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Iy+JXxu5hgNk4FA4fsulUnYpYNK5LMpaPajzMtjC/xB3xNPOrOatBo1p72WEPT/TPz51azBgl2gfDCjaEpawCAl2hj9b/VJPJMYOtb4J10eMAoo6hk3V7dPmTyMEVPBJJF6dgNQSdAJnotitlmUOnfWtd2bEKIYQbeZOv0deknI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR5tF9Q001341;
	Wed, 27 Nov 2024 13:08:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433618ch66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 13:08:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPI8Rpze5MfqObeqE3WgnyYAUuLTwsdWGQ4mO8OpbFN0MFrTaQbGDZR54OdR0GnN+a4oCKRLnVbYcn32gcYrMP+an40AmdPxQ0u1sOKXY6z9GjiZ8kUefLq7z8NJUSpnzn/OntCkR7c+Y4pQU7jJsL7XgRI+v113xTf3uy+w1ng8IGB6OotjMOfCPQc+MT3Umw28wyR8nXiFECXEukoJVPQsPHVGw+VbsZZMSFEMuAJClW6UbsFl/cnJr7CxtKa/VFWNtIwlYTEaEktGoM1ww8a2ITW9SoNqFQE2kLKYXTTunQz8lMnSlmdYaO7bZUdnreQwHkaTZ5gcrRoICB78fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRSX6lzKWWFC9Spyl4Dn7NR/MRPG3vy4YVL93BDC9ec=;
 b=ofMez0nVhx+fdyVbE6Qdhb7jdPF0tKAzlisbGkmaa4TO+ltclXDjkZLF1KpQdPcn8o5Vhq5MkDj1BrnWIj2a29uTCNIWprfSx5gdqzU5tbNb92N9/EhQu4usIcxPfhLgWAz8OF1WBZ62oRQai6ECwNjRBpz7AWKxqz6PhbqTy89Mc7V610knzdRSQg003vuuzwFT61ldHxpjGBJfq0c7TWPW21/z5YZ1IPFqHHQwZ3eXXPqpEmJRQIf3QkupuWMf91U4OQ/IIcWx2/3w91GggZDtMtJaVhizRM2Osbc+gL2sV/Raeb01yRQuS8kgStXPpPpWTHtSt1BqCvNMoccgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SJ2PR11MB7647.namprd11.prod.outlook.com (2603:10b6:a03:4c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 13:08:39 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 13:08:39 +0000
From: Bin Lan <bin.lan.cn@windriver.com>
To: stable@vger.kernel.org, llfamsec@gmail.com
Cc: bin.lan.cn@windriver.com
Subject: [PATCH 6.1] xfs: add bounds checking to xlog_recover_process_data
Date: Wed, 27 Nov 2024 21:08:14 +0800
Message-Id: <20241127130814.1203257-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0179.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::14) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SJ2PR11MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b269181-3e15-4c34-a2fb-08dd0ee49c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cKrz4H6dwbILfjAgzawfYnBdJzTpck3hPK3S81P+i9sUI2y5ns1xnVQLI1tj?=
 =?us-ascii?Q?OapsvQtx4imQ311lTYePlvJwomwxAL2KOnuRKX31vHZ7CasUCMWgvtC8xACB?=
 =?us-ascii?Q?0O/pzMqyVbWoKfgF32sctAa+j2VdPczoC2i8xAQa79vocpYP7PokMrnPA6dv?=
 =?us-ascii?Q?fAVRakEAvA/cClO0yyG+BUGdF6dAfr7IKfJoqcvNOcBgpdWlAmCN4ye9K1D+?=
 =?us-ascii?Q?wEDT8WPeXqNStxEcDIZk54IOqv++Pqfzod8cpMjVOT3jnltM/t7x4npBTPN/?=
 =?us-ascii?Q?Hua61v5kWMmi4W1RjGAe8PXPoe7mSAhlWM3PTUiCQ/9tH4dVfANC3I7oxLEv?=
 =?us-ascii?Q?OVyfaNl85z4jEW4uB1USRWHiBnt8JtZ9eNFlAxAp7+bVHMSXl/qIk5pPIgKB?=
 =?us-ascii?Q?fQCSqK26zzflh+MivrlUKm/UsbNVGEDOmrLrAmV0w6Ev6BUM4Ej/ETLQE/VF?=
 =?us-ascii?Q?EpSXY5PGCnMrnZASlvmHpbtcViUf9Cex3KLDS0QnQ+C8WP6Rg9Pm8iWis9qw?=
 =?us-ascii?Q?bvLgbQQ9TelviK8l4iZUc/R+NOk/KgV31UataLXP6OlVJRxoc/fFtYtPRD3A?=
 =?us-ascii?Q?jNzYl/RaXtqTgsHJYvqUbkfTFslLSZsHLYS7m6TZQ2rj7ZkIguT5xETAAVY7?=
 =?us-ascii?Q?aKt5qjgCu9KVlcQjrNOFIyMRHEzVg/E3WIsPH7PqtNZtIDA1HQ79vwNlh1x3?=
 =?us-ascii?Q?wfgANpCMsACr46Bvr+AKylofR0VDeMYM0AAU+cay61VObgkY02cBztHfXt2P?=
 =?us-ascii?Q?vxmfhjiDg6gt1AU4p5RbAgng2KTh19Y+HY8zZ/4L/7dznO8e7ipM0zT7Hw0/?=
 =?us-ascii?Q?8Ct5h331Un6a/yGBVoRJY94bPN921dAGBNRG82J1F0nqX/Pj4DHJjdNrlTON?=
 =?us-ascii?Q?g+bVgds1djjIoWUijIqPr9Qc/63qzIHHKgUk1AsqRt7ueO3uPV0S+heTuAY4?=
 =?us-ascii?Q?8k7SXAcK/aoidXWQcFQBi2aks1FSPzql4X1sr/HA4eQILbt0eB40VK1rTCKq?=
 =?us-ascii?Q?nka19lEBZ1A74Y/K4FfiNDGcPasXploRYr2nwXkcJYpFI9HujiF9G3ZnRrMa?=
 =?us-ascii?Q?ZVhisQe/hkfkMHu45pL4QFQ08lSoVNTMSRaqWj7J+Q4Yd9qjh2dmKBR43yF9?=
 =?us-ascii?Q?vxZ0vBtfoDH0tgcwTBARaqnJ5S8AKnvutWvbTyq47STJkU5VdFqdqdT5/fpl?=
 =?us-ascii?Q?Yzlz6Tl/dir0zxNxMDZiHn1trHqDDqZQal6cy620xCjnmnEpLKSBXRh7uCfj?=
 =?us-ascii?Q?8Jb40b1Zi85BtgYoHWiPj9ZHp0iOseZsCVBFPDgfuouLLY8heGb5Ta83ugtG?=
 =?us-ascii?Q?zkRuePfmG3XzLAC4WG9nW5kBxTU5MRALOt0JF/YHV3JFBN9qIZnwdYqQsPbs?=
 =?us-ascii?Q?QZdSBQIKBmy1yTohC28N41m5+j4z2xC9zwAu57SRjhj8KlksFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QxnhQ1jZPJndoqxJZqb+o2cQC1YTZmr7Sy0aSbs3Qimd0HUbAvNgpS1Da7Ht?=
 =?us-ascii?Q?OW5JogS8qfTZsXLG8tbNMG9b4oWn/ZG0NjMzGCDWygkTYR1uElq1S7Vs+wAP?=
 =?us-ascii?Q?VuRrIZlofBYM2AB61EngfrVeRpgNgyo4YUnJ6K7nQL4FdqikqEU/6TLrrJVo?=
 =?us-ascii?Q?c1zmF+ysa3YYuncv8+C2zwPFIaSUWyNcNFRTLDViHtflwXPoqnBVl0quT/+3?=
 =?us-ascii?Q?laG6lyzt0Mrd2NzhzewMhQX+NTMRPblP+QEVCzagBGfXs2blUejxCj+xkBcb?=
 =?us-ascii?Q?M0YnpHmbm6l2Y0jiP5Ya33LDTaVqgdbwBGiuCucNx+y8tJFs9n5dF/tkjYsc?=
 =?us-ascii?Q?azeq0kqhxL2tUq5om5aPePbsEqFiP/IU9IzJ6UBSytyzbvlPZ0fMFcEiBN+F?=
 =?us-ascii?Q?65ry/mytWZFa+NagiHGsX7zRIN444mWBQy7mvL0Xo6rZN2yWpHpEDSvGjATM?=
 =?us-ascii?Q?3w9QLCpmht+UzIa9sAKCTwkmfgspAWgbgHWjDo2DMKB+qiTrtmEGzM7bsy7k?=
 =?us-ascii?Q?OQzEbFcQ1dxmzj43b91h0oFPnVsdRhslVIc0v3RC9GYNWdl7cqqFoZdkKpMo?=
 =?us-ascii?Q?mx87pAW9xJZin1+BJ9uNMObIcyy8StlBhUxDrosn6F7DV4AbPK3NDZi8pLDe?=
 =?us-ascii?Q?RfRLkNVm6LWMTNgNlL3Ph5HKvUX0qfxFmW9w6G2/n5WTelEAb8pS+4CFoXsS?=
 =?us-ascii?Q?fhxojys+aGXhCgGzZiMvK5aPsazUpZx9kBVgvcEHyZPThwQ3vgXLBpGWb4fU?=
 =?us-ascii?Q?St9QDEv6HnNaGsdeUySKaj5ynqfKexocMmC++s9q1QKPruwgQ/rBEK9M2adn?=
 =?us-ascii?Q?BPpFBc+ge4rDkCqwJfuNDhXT6Aw4FyvQqiAz261EkDSnwv3nZQv/fLm4PWkH?=
 =?us-ascii?Q?jn30mgawnCP3/+Bg4f5MNYBfwLsGXlJhjja5XQVAEUtJcCck4bx1odJtqe4X?=
 =?us-ascii?Q?IrtLH5RsPHeluR45mCAO/kJeZGyk8NxEuiGMs9fUkEaeU4XNFk1ud5xcNRUl?=
 =?us-ascii?Q?7uie1/DUy4geU8PewBYo9RQxDOnV8YV8EAQ3qYgX5xMkpj5dT7nP5w+fHi3a?=
 =?us-ascii?Q?Ljiv7ft3NA5A+g1BhMgd5PTAtr3UQNTZZY8hlaUlOTNoB1fuVc3cEpGFQubk?=
 =?us-ascii?Q?/IW9utHNimgIssbGs5FOG7YPJtE06hTDQfdd9EEDfROKOJaR9kEG/UPRvLn6?=
 =?us-ascii?Q?SyUFBlT/qPu63E5aeyj7GemsM0BKrtiAgfFFNcZRONFJrR5d5C1c4COm3H4t?=
 =?us-ascii?Q?txkm68UKL9R8AOhnKqfBAQ90jYw66V6vw3nLgVZCDbd0+FC5aV2+0P5cpSwR?=
 =?us-ascii?Q?80cZJqhepoOgQ8L0qtFHIXDYl/vdHonuEDoa+xCQONQyEGehM9iJxFlQH1jz?=
 =?us-ascii?Q?1mZjupKkVU9wh+xdHNArOIj7GeL3kr780mBYJHAhqRAQPxrqvXDlUuP3GsQR?=
 =?us-ascii?Q?scWK/jzgbR9uw0AjmJkwbUD96mgMdREeK+qVpntFNzH19082FUki1HlNIHvs?=
 =?us-ascii?Q?s4AqT6EtC/28C7VYs348dg0XeIWN9shLImXfSuWEGarOYq41gAI6bulSqaZE?=
 =?us-ascii?Q?ve6Ab0Fr9j8ToZcMGb5IswWZfbXZonBZO+Udl+DlWdopd8vpMnNF0j9Y0YwX?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b269181-3e15-4c34-a2fb-08dd0ee49c36
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 13:08:39.4807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWxy1s0rifGtv7g8JFGbBW59p4dsVMfDZMbdQFtg8WCWHoMhFFRvPNMWqTJ1RPb41VXBYl5ztDE5Vlq5Dn6W9T8qRFtIl5b9BXsdEESSUdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7647
X-Proofpoint-ORIG-GUID: LKPUew93rUGWE7x9qScI1eaPFIiwEG9E
X-Proofpoint-GUID: LKPUew93rUGWE7x9qScI1eaPFIiwEG9E
X-Authority-Analysis: v=2.4 cv=O65rvw9W c=1 sm=1 tr=0 ts=674719e1 cx=c_pps a=p6j+uggflNHdUAyuNTtjyw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=gZ8OVRd3LIMJ4GaTPUUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411270104

From: lei lu <llfamsec@gmail.com>

[ Upstream commit fb63435b7c7dc112b1ae1baea5486e0a6e27b196 ]

There is a lack of verification of the space occupied by fixed members
of xlog_op_header in the xlog_recover_process_data.

We can create a crafted image to trigger an out of bounds read by
following these steps:
    1) Mount an image of xfs, and do some file operations to leave records
    2) Before umounting, copy the image for subsequent steps to simulate
       abnormal exit. Because umount will ensure that tail_blk and
       head_blk are the same, which will result in the inability to enter
       xlog_recover_process_data
    3) Write a tool to parse and modify the copied image in step 2
    4) Make the end of the xlog_op_header entries only 1 byte away from
       xlog_rec_header->h_size
    5) xlog_rec_header->h_num_logops++
    6) Modify xlog_rec_header->h_crc

Fix:
Add a check to make sure there is sufficient space to access fixed members
of xlog_op_header.

Signed-off-by: lei lu <llfamsec@gmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
---
 fs/xfs/xfs_log_recover.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index affe94356ed1..006a376c34b2 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2439,7 +2439,10 @@ xlog_recover_process_data(
 
 		ohead = (struct xlog_op_header *)dp;
 		dp += sizeof(*ohead);
-		ASSERT(dp <= end);
+		if (dp > end) {
+			xfs_warn(log->l_mp, "%s: op header overrun", __func__);
+			return -EFSCORRUPTED;
+		}
 
 		/* errors will abort recovery */
 		error = xlog_recover_process_ophdr(log, rhash, rhead, ohead,
-- 
2.34.1


