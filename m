Return-Path: <stable+bounces-87686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056769A9D76
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 10:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C4728347F
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 08:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAA4155330;
	Tue, 22 Oct 2024 08:52:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257A187864
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587125; cv=fail; b=udRqt3rww+7QHtfxqOs8aDpWAOHrlurnXWolOe/8PeymQP1AG/Fs0txCCB3DTw3Q+RKKm88Trrh5BIzEICmYCGizp4DRuTjHtlFJfw5nxdwstcLpN+eMIiqu00a6B0f6DunFmDMPX+Al7aD5SAM6qZKJNSYCEIaOk5xoxHzhRKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587125; c=relaxed/simple;
	bh=/G4nsfZ7AT7hnq1DZ4+neyYwkFfJruqlWWmca1R2/9o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NjfSuBOHmT19DPZ8z/Do3o48exzac1jG4tWtutKArtlDjyxY1aVadMMBw+SPa9jGhz7uneuK38wQysWBMUPWdsO+wu5GBkTIPBLO2aogDQ5jd4j2swBbt/KGFYYwLgL/7EpAyf5syFtiLOM1xCQ61D3mvKpAsp+a3eskQ/H2kgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M50634011285
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 01:52:01 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42cc9ktv7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Oct 2024 01:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd0AxCCmt4msFTCN3hVKK4WhH6CqjJKbUEDdfjE0G1pAuiibWH7gwkN5L+HJCi+Xi3LgvDCdANRsSowkZ9sJttdVPV8zVpL7IP4esHepzDA0mco5uAdmHPsIIXrRFC83bYpuJWKhPdDILU6GNk3HaOtjFQ5f4LKj12pntsulHLKXVQZbUnsffgzx6hkJZm/7eTrCd9rqmfTyJV2l3rXZkwfNCKlYaQdleWBnDGfPVxFfMmgb9oQ2pgmCFGJAYUxASvIy/q/HJcAgTa7c1b1ZEOtcWBWFHretvSLrFm6TVUT3O13ZLOJj7vOUUodeejaiIsNnZAlrXs3wzfqieq9/jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFpdGAZU2SAFGtdL0HSQf3B4OkYg4XJPyHPg87h+sug=;
 b=dSMrJxH9nlk3VicXhydw+nHIE8j+9dQellTA0QnlSmA+hyJ2vGI0pwV6dm66uwkvVAad2yIffkPeYgh7/d9i39pUO2dpD+0gtKaBa8O/v+lG9hEQHw29qhOaMFCyDCG3yTv1HQ0ZBFHRms9/nTXnLnMFQ+I3rqt/MkV3XdgiClQJQ5FSFXK4XjVJb1RWPcN5qm5TJaNU4fOmp42rbqBMm1vstxS35AJkN89Jm2NF3SiryQt5/IVgeAKSstP/jj+tcbpao9TkGbxzXMv45HaJZuPFxsvp1I2UjE0USyud/y4ztMpc7FRz7qiUj743dkNL98yRUROTTDhkVdoRj9GcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 08:51:57 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:51:57 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH] fs/ntfs3: Add more attributes checks in mi_enum_attr()
Date: Tue, 22 Oct 2024 16:51:48 +0800
Message-ID: <20241022085148.3115342-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CO1PR11MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a32921d-b4fb-4c16-c36f-08dcf276c8eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eBTlKEQGrn188ZTVd1StfrmgzvRun+dieeeGG+Wnmod8Ow4X2f0rjjTPRbiG?=
 =?us-ascii?Q?U4WzerDRjZo3BVjTHEOXsuK1uhFhAzVK9mIy+i2t4zDBmeJC06sz2HKL9/gQ?=
 =?us-ascii?Q?YWS5JouORAvq/tSuI2OfhjcuQQns9p2kh/cucOo0TRXXl3FRGHCiv8UDuNvQ?=
 =?us-ascii?Q?b8n3kmNiT4ccki5L1TCtm2s7udSq9QQqqkofMWsQNAMJeHnU6WoxjSXs5fdc?=
 =?us-ascii?Q?NmXrraMs/jgGopLwZAl5QVJNJkkDDBvrsL1NOxMhR9oJz4rIotaUxiQeEOk8?=
 =?us-ascii?Q?RsZTPWs7XGgz3cwBqWfwx623AJFjfEEi8cN3vMFH8lJisGxGziXkllRc9TgQ?=
 =?us-ascii?Q?bwqt3XLxrYBCgWTSMNcOm5bHLLKKpi/RCaNOQzwn/BTMO44QJWS5W83L0fqL?=
 =?us-ascii?Q?ZO4SW2LhB3AtgJrH7B77a7LFP5w6R7dxq5vCtPBWEHso2PAgyRd5qdiozffz?=
 =?us-ascii?Q?pHISSnV9rDC5AeSJ0lqa+xYqP3d4fTvnCiuSOcM9aEAKZp4eLl6wjM1LZ3lZ?=
 =?us-ascii?Q?I2+f76EPRuRuc/tQoBHNNUsYm4yShbhh2yhfLqlCs9TvNI8+mCeHm8wvr8VV?=
 =?us-ascii?Q?vKW90Jsi5xTnd+VWxnhVncJ5ThUtvX+xPesgjJEQOW6ctHaH7CFdF1hcwoN/?=
 =?us-ascii?Q?GOjV5pASXSQ0e6iABZiHzjh8UaC72P024eXNrSszaJ8v+nZ8jYByZCIJWCXL?=
 =?us-ascii?Q?rABzZkwiciCeAYlBBcd5AcxJOT7a0MGKbln7m+iXj0fG+M5sqnkSZyw74g7D?=
 =?us-ascii?Q?OsUsMNc9mIhSwBGH00fA57w/hw+BhlyVdHSLNuNomSyYSX1FpoVAne7LupZX?=
 =?us-ascii?Q?eXiTXPRm4aBLD+3aBTX+8Rhk6FFLVAljOfr1GMhabKOBBjBqmxRcp3xnzaR1?=
 =?us-ascii?Q?CrchGFKRFLyHbCNPOA4EH7B+YH53ydLWOoVd8DilwZnyNJ5V1bgAUPfSjdFy?=
 =?us-ascii?Q?XeDcibYh1NOHT9dZS2JjLaGA3iUkzDgY8ipWEtom8ibCuzi06B7jrLfysskv?=
 =?us-ascii?Q?1jgRfEV0iu/AW1VCHhn6TXVNhd8rXduM7yHpkVIjW1xJ8ABag0deuhE99pOH?=
 =?us-ascii?Q?lagcmAwqulyDwri8KvwzzNxg74KUPS+o0Z0p64+NukSIDEQyLTEufMWcTCLb?=
 =?us-ascii?Q?NWFbvPv4e/5pCggDcBc3dgFWn2xJol/Y9sk4KuYuD8iy4ebUQn1kopaoXGmL?=
 =?us-ascii?Q?LZzIM2jYYJngsxAe3AlahNWMk+GNXGy/QT9PrRZnOqlnp9hIh+Ua3XdGh2qh?=
 =?us-ascii?Q?EUmb03FcAQkFd7ikQPTFLUuQmiGyki9wNYJpYOB6QZSVx/61jz5k7G8BhqI0?=
 =?us-ascii?Q?SOmKJgRsT5Ba0aCvQX37G6vF4mmB7s0HN7UA/9VXsoo0k49HGUpyfe0byj9f?=
 =?us-ascii?Q?PZLLH7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FQlAdpaEUiRzKSwzWP8WewPY99SJ0T5AEwYR7U+bxKAS8OEGj86g/1h3A5X3?=
 =?us-ascii?Q?ThMYF+xwPlU2dRu0h+N8ihDJRFZG+3LEMdnuwcnhDJBK9sz+cosniPjF+qjG?=
 =?us-ascii?Q?1xSKJCXGfPPdkKQ5zBqRZRMh7fI9fT+VKD7kskIvZObWnaeeyW8YlTf0M2LZ?=
 =?us-ascii?Q?5BkGj1rNPUVpm8hpyMViC362mVwAEQgcFOJCiSOKBvBo+ecRFYpIHMKQFYHs?=
 =?us-ascii?Q?kmmbeRc6h//3LD0W1LlT9erf7WneIp6v2cTz4vMUzMOZTbCX/IrLDBX4HxO7?=
 =?us-ascii?Q?8R8R1ohAQ5KS5GJVAFcNAvAdA9OXh6+qYCJ98N0BoxcokpfH8K3GBmbURbf2?=
 =?us-ascii?Q?KIoilAaFyex2WFn4Ub9NbbIBOS+lDnoTI610KfeKl7aK5vuUsmCSCbUVT0J/?=
 =?us-ascii?Q?RlrhDAbkOs64z6Wgq6KCaxVL9NqZmcr43iqeQu4xIM2xVmHLasuRMZrjqpTt?=
 =?us-ascii?Q?qJ/ewmnQcGNXR2Z5Gl0VaxHdCGyelddJEcewRT7p1jJROTWs8s7jF9okyYMa?=
 =?us-ascii?Q?LtVIo/GBfKJXxsiwimoGqlahWp2/zmQHxv7reFMJJhRrl6UbMBiGJ4SUfDLe?=
 =?us-ascii?Q?EdFr+6rDd5tfoigYMaFHNp53gM2Rib255DvGhcCtk7FQQVKW3q1WlXO8Uhhw?=
 =?us-ascii?Q?1DDyZr1xE2aY3DKnj1jvNDVS+KtTC8h+zHG64A9TPVVJANSgHAINgn5iaEgO?=
 =?us-ascii?Q?Q3KIE5uqpMgj6SRW7+zUoa7AI/L7Oq0ggg4tVRWhtu1oaHVgJ5wrUwVeNd1I?=
 =?us-ascii?Q?fwvBAGO/Xi5D6rP7ow6X7i0X9inRFls8EUryOlXPLt5M3c0FdrYAYSsuq0/x?=
 =?us-ascii?Q?v01gla3Nh+usVf/4c2KVBfArKjNTtPvwoUgkL3tBVoH21UAf3EsphA+nOoe3?=
 =?us-ascii?Q?V/avilkMRj2zuIV8sdAsByI98wz2oTrO5SD5emPKMLZDfRRL2pwH/ukhpzZW?=
 =?us-ascii?Q?5vy61Z7xv5nef8hXeivsUN7VaYM+R54/1IbWAcjpdecHI3KdaDC8NWenGt2T?=
 =?us-ascii?Q?V4IOgMmqaDvszqcKzmN3T8fqF2mr3lAdJk/256RCAuLaAgnC3sD1xoYsGH9u?=
 =?us-ascii?Q?BQwWyflimHTGpFChhVuZw8iL3TCqG5IdxcWRyGDp+MeRn70SJk02FtRoRtnG?=
 =?us-ascii?Q?GpyjPisCO+5FHALtz8qZ6Z93Tt020jAfgork7ttSq72vvoVBlK65DbNs4skZ?=
 =?us-ascii?Q?X8vwmTugf0NR2NJx8U6UHJ/er7PS4cRdJwbOdnAu75Pj3x195nYIiIGu2PmP?=
 =?us-ascii?Q?Qe2B+9BwZpL2TOoW8j4ScGCTmU12gTZ0H0YZgHnPShmrjR3h5UaRRJUIILRv?=
 =?us-ascii?Q?wPRr4gKyN0uanQSWBfxj2aGapOEnDZFzixoILU7Fxo1vJbaBcR1mzrv9oXWY?=
 =?us-ascii?Q?zXk6aIJuTMLj0MyJBPnPM4OiL3UnFaINau9cNZz3Va5gGw7YAVunYQjmCm2m?=
 =?us-ascii?Q?l/yX5N9hFbJxOMfYfmS/9R9jOwp49G2QqVoiCs3/rlVjgWmbdH3b7nDIfRRu?=
 =?us-ascii?Q?Ph3Q0HBUVKrBk5smer8MAH2nOW8rq+E3drQrOSwu7LnRCe+j1wdPwIzZZvJl?=
 =?us-ascii?Q?rdGHsODEYQwj/MGLzbda8NeXrnd+hf8ATDL8/n7iKbXSKNk0GFSrTpTnCZAJ?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a32921d-b4fb-4c16-c36f-08dcf276c8eb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:51:57.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GLVj5hGtFtjAPUsbIyjBI+qoSpIyhmsdkf1azOgUnGuBEpKb1dMQ4cOWaIAo5O6Z0+qcFlLcgOrNh76vuIj0vCfCBDNK/z19sW5vPR5Jm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4835
X-Authority-Analysis: v=2.4 cv=ZYlPNdVA c=1 sm=1 tr=0 ts=671767b1 cx=c_pps a=AVVanhwSUc+LQPSikfBlbg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=GFCt93a2AAAA:8 a=t7CeM3EgAAAA:8 a=F4_d0iVdzyuZofu-chwA:9
 a=0UNspqPZPZo5crgNHNjb:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: HkgMcUA5CJ19K4_f6lfgcyXgOfpVN87K
X-Proofpoint-ORIG-GUID: HkgMcUA5CJ19K4_f6lfgcyXgOfpVN87K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_08,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410220057

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 013ff63b649475f0ee134e2c8d0c8e65284ede50 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
CVE: CVE-2023-45896
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 fs/ntfs3/record.c | 67 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 1351fb02e140..7ab452710572 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -193,8 +193,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 {
 	const struct MFT_REC *rec = mi->mrec;
 	u32 used = le32_to_cpu(rec->used);
-	u32 t32, off, asize;
+	u32 t32, off, asize, prev_type;
 	u16 t16;
+	u64 data_size, alloc_size, tot_size;
 
 	if (!attr) {
 		u32 total = le32_to_cpu(rec->total);
@@ -213,6 +214,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (!is_rec_inuse(rec))
 			return NULL;
 
+		prev_type = 0;
 		attr = Add2Ptr(rec, off);
 	} else {
 		/* Check if input attr inside record. */
@@ -226,6 +228,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 			return NULL;
 		}
 
+		/* Overflow check. */
+		if (off + asize < off)
+			return NULL;
+
+		prev_type = le32_to_cpu(attr->type);
 		attr = Add2Ptr(attr, asize);
 		off += asize;
 	}
@@ -245,7 +252,11 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* 0x100 is last known attribute for now. */
 	t32 = le32_to_cpu(attr->type);
-	if ((t32 & 0xf) || (t32 > 0x100))
+	if (!t32 || (t32 & 0xf) || (t32 > 0x100))
+		return NULL;
+
+	/* attributes in record must be ordered by type */
+	if (t32 < prev_type)
 		return NULL;
 
 	/* Check overflow and boundary. */
@@ -254,16 +265,15 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	/* Check size of attribute. */
 	if (!attr->non_res) {
+		/* Check resident fields. */
 		if (asize < SIZEOF_RESIDENT)
 			return NULL;
 
 		t16 = le16_to_cpu(attr->res.data_off);
-
 		if (t16 > asize)
 			return NULL;
 
-		t32 = le32_to_cpu(attr->res.data_size);
-		if (t16 + t32 > asize)
+		if (t16 + le32_to_cpu(attr->res.data_size) > asize)
 			return NULL;
 
 		if (attr->name_len &&
@@ -274,21 +284,52 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		return attr;
 	}
 
-	/* Check some nonresident fields. */
-	if (attr->name_len &&
-	    le16_to_cpu(attr->name_off) + sizeof(short) * attr->name_len >
-		    le16_to_cpu(attr->nres.run_off)) {
+	/* Check nonresident fields. */
+	if (attr->non_res != 1)
 		return NULL;
-	}
 
-	if (attr->nres.svcn || !is_attr_ext(attr)) {
+	t16 = le16_to_cpu(attr->nres.run_off);
+	if (t16 > asize)
+		return NULL;
+
+	t32 = sizeof(short) * attr->name_len;
+	if (t32 && le16_to_cpu(attr->name_off) + t32 > t16)
+		return NULL;
+
+	/* Check start/end vcn. */
+	if (le64_to_cpu(attr->nres.svcn) > le64_to_cpu(attr->nres.evcn) + 1)
+		return NULL;
+
+	data_size = le64_to_cpu(attr->nres.data_size);
+	if (le64_to_cpu(attr->nres.valid_size) > data_size)
+		return NULL;
+
+	alloc_size = le64_to_cpu(attr->nres.alloc_size);
+	if (data_size > alloc_size)
+		return NULL;
+
+	t32 = mi->sbi->cluster_mask;
+	if (alloc_size & t32)
+		return NULL;
+
+	if (!attr->nres.svcn && is_attr_ext(attr)) {
+		/* First segment of sparse/compressed attribute */
+		if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+			return NULL;
+
+		tot_size = le64_to_cpu(attr->nres.total_size);
+		if (tot_size & t32)
+			return NULL;
+
+		if (tot_size > alloc_size)
+			return NULL;
+	} else {
 		if (asize + 8 < SIZEOF_NONRESIDENT)
 			return NULL;
 
 		if (attr->nres.c_unit)
 			return NULL;
-	} else if (asize + 8 < SIZEOF_NONRESIDENT_EX)
-		return NULL;
+	}
 
 	return attr;
 }
-- 
2.43.0


