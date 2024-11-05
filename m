Return-Path: <stable+bounces-89778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28EE9BC373
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 03:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EC01C21D54
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FA352F9E;
	Tue,  5 Nov 2024 02:55:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D3481A3
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775347; cv=fail; b=Uj6FtEdsXC9vdhbxlp3XM5XCpKiDxHSthP4qAN3e++nO5QgpOpj8J7PVroohVi1bY3RiV7pkw3k4IjPVbX5wAVEf220VbYO8wpmx+AJlz3BWORybLnCdGMD1qr9dzmWVdFmiZ9AgoX7s0Ur5b5HHsHFh74t+R72c9tlVXj+Xkyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775347; c=relaxed/simple;
	bh=cZqCSU48N9kqdlxE0KNa/6IKK+zzBqG5Oioqwd1PbVc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nhnIRG3iXMQeMWkjR7pDyobpl7nE0OGC0+T8NuagLdYflii9MALGvwWlx9/l5Mq6aGmMWGxJFgg2fMbmmvvIotxl08wTuTJTRhJzauNd5ugPGQMgNoKgAewxebUkLxlZgtM8HOuzJAwEb+wfJCQQw6ElaYL1u5I2RPXdsgOlc08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A52h3U6006011
	for <stable@vger.kernel.org>; Mon, 4 Nov 2024 18:55:38 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42nkkjj5sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 04 Nov 2024 18:55:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMWpyRC0uQdWnlrLIOtZd3G2g2iYg0fh+gL4fwHeUpa58EwtWMfpqKpRvaFIWErEEKZSz9hKagg0l4DMtaCLihb3ALZqKlVXJ96zPQeCSfmmTXo5YljxKbReBWsyldLgfki+CnL76x4dT0JKJLWOLwxz4SnhcVCcKpKCovcZnmG1BYiKdDsoIrQotkyoM15oreRyrJlupmMSkKPZAgfjM+OSeIj8lopXO8ZzSWT1PoBbYW8JiCwBIcoLJOrHZyDJ7X61XX5B18bYjoYEMLUEeRcEaZ/Z7VfXZnF5l7PIsFUDncBffjEIeJLQqUiWaX0la1ru2CAryGd+ibuyigPdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ye1jaT1a45QkeBlb5D/YrevfiDCbJvSeEOb2w55aRK8=;
 b=x1Kzb75aHMVJIBVKwFi+XVn9r75NaagV3bEyLNWk/fwkOQmLo/lCoCa1hRWsZ/7TAkl6glnXvQIVXfjn4yMn2uJGlanHnQcsfPaYKUV+BcUy4142xDxDEGPDG9crQXp8IdTyDChdxqd28CrfCKJeKelT2gJ34N4LIZsCsR//I2yhBqLv97mw/inHgP20JxN8BQFg6vqY5/02hrdBMf6tNMW9pfT1Xhe165SJltnK//DRnNv9rw5o5pM6mMQtQIsL37+DacnraEONAXkivft67TLUBNlpHylQhpowTyuCT2X29RC3QCziiZck/1bjheA7EF7rQA5aw7iLOxlBenDrSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by MW4PR11MB6618.namprd11.prod.outlook.com (2603:10b6:303:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 02:55:33 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 02:55:33 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1] bnxt_re: avoid shift undefined behavior in bnxt_qplib_alloc_init_hwq
Date: Tue,  5 Nov 2024 10:55:04 +0800
Message-ID: <20241105025504.3494934-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:405::35)
 To MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|MW4PR11MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: febe8b55-12b9-4d69-d7a6-08dcfd4550da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSf8Gj1M6IFxKGGDHJILdkMUmq09fQQZ24xluuGcFP6w7AdePdTtoT9HH94c?=
 =?us-ascii?Q?VurzURJhYjEiLosafYFm/6FDQsHexmh6JSX/aImdYz/ZzIa0jmerbyBrjdi8?=
 =?us-ascii?Q?F5THaKIS790D5ACiws6kQVodmi1qvyeYw74/D9Q2anVG+1dm/w64CFFHetOb?=
 =?us-ascii?Q?SlV8Q8Ka97R6JJltXyj87TtElfv2kI0OUPTZDpqTVYlH0zRFEq+m2dwTRpW8?=
 =?us-ascii?Q?AkKHdOnBY221tC2/wprigjJWwgslmLJzA1KieyfDYviS0QvckAOWmxaOixbm?=
 =?us-ascii?Q?LhJ/A/9PJ1K9pAnIjl4K6c4xN8gRfBlbQptSwTFvT34VY9vhWvdkuzKlWcnt?=
 =?us-ascii?Q?FkvIww2NF3DML/WTsYlH02DJ5XIgOApIVY1QS5wWuwjh56NAP5B3w0vrrX0m?=
 =?us-ascii?Q?Ka0aCyV/jbZ96djfOSFBEgT4xr5JYknmV/XWd0X1wxrBcFwAul6wz+GZwhzN?=
 =?us-ascii?Q?kLYT7DzfjgJmeK88lGeuTxj27x4+3crhrkfQ3NHoPY32mZ6VfybHnJi4IZNI?=
 =?us-ascii?Q?QVOxoQF7rdGyKsOjALcISXJJmIB0U/y4gCu++9BssVDj0s9MuNs/NMzMLoSL?=
 =?us-ascii?Q?8AdixIMlUcSkIblmUc1vItmtKpNaE/4WJW+qrZcdQDtaZSo6TFB4A7HTvj34?=
 =?us-ascii?Q?dWcl7ll4W49/Q+fTBQPK5MJNUkak0Yp9OjKoCWQFdLcucSaFz5QKgLzx3EXw?=
 =?us-ascii?Q?MHB2upv3vaAfyay1UEThq5X6JZhHPvV5sdkRFgkFOkYLFvPThuWOiHMpTDKf?=
 =?us-ascii?Q?3Yj2xchR3UdLm2ZMpEPC/5khwAUcvA9t0IjXfk4dbN+maaRd/7IWoHLrOmxI?=
 =?us-ascii?Q?9JZHEK8Iw9TbVNpThURbf7daxSZopvWCSHHPNL9+LrBXX6u+Mn0bcYe8/g1x?=
 =?us-ascii?Q?aGZfPx8s84cxx0SMEVwQ4YsuO3PV9oiqlRLo/PVmFDmu6PxMq1mGL0j8gWCM?=
 =?us-ascii?Q?ysRoBmZWLnp7GAZ3xek73WZiWdOzmfXa/SKjaNhF1QwxR0SHyzGvqqI2gTmC?=
 =?us-ascii?Q?Ruufklrmpv3M5WBQXWdsipyxySPpzT5S+3V3r+1ZTEUDsZLTXcFPwjQoLfbJ?=
 =?us-ascii?Q?aokJFuVP5iC64EVaL3surR98kr1jECBDruT0Lx9ZV/9nrvLPjkyRkLgwdK4Z?=
 =?us-ascii?Q?+FQlOetbeSNx+u5m+N6ud1vtwIIFKmxa6QZ3E4G9+ggdgc30ZVAHHBsoZggB?=
 =?us-ascii?Q?f1MfTMW9DXsQ3aegCmlBBDMZVdBK3XbXmHmqv4dWkBK+3g//D0/qm95nRsmc?=
 =?us-ascii?Q?tZyAEXQ4xFvr4qLPKICQuBgdeO0hVIYRuWjWiFYnTBa4WQk/gVK2eFpWMPXZ?=
 =?us-ascii?Q?kWpYMhYHbz8Ahk1fivklPYQW268o9Ys3eAgWtxkw/LEKGodmoM9AT3XPzf3u?=
 =?us-ascii?Q?FZSyEtZFEkPMRteAwFHIYGgldbng?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YL6IcXyCeYxQh7qGL8NihEuNToOMT5O+cVwOXy4biUWlLHAVGTRtAduacMvc?=
 =?us-ascii?Q?gv4sjXgT11JJu127N6t/6yBWe6TGaBuLa4RI1OBdOkW6QYPF7ztIi9spG49V?=
 =?us-ascii?Q?kl580Q39LF3zF1JRqVc8Y0B+9CnRYGOEWE4MZe6WhW10fGCYA268dy20KA51?=
 =?us-ascii?Q?u0usO+Baw4kZSYkrfCtbuXLrZAt7kw3ILVBcuSRJgQv46ESJQqbmsB6CCsQS?=
 =?us-ascii?Q?5pJDwE0880TAuJPkvqEE6SFyICAH1JF9BOwIHOI0IIkfsU/G2aYDj5GAX3qh?=
 =?us-ascii?Q?EX5k7ROhUdbMTvz2nAj32WRUhFe46lEuLXZmeSn+Zo+upigzOLzEaSyD+RyT?=
 =?us-ascii?Q?0SF3u9U1rduMMGAQ4S0vm1Okq1qsLi5LQ3D1j7Yx2N/C+nSGn2rUSLiPmEtU?=
 =?us-ascii?Q?tPkJP31BXSdAceaF2J/l2FDzp+W6k/HsUM1sZYwBWbpfym/AbtsbrGODDbla?=
 =?us-ascii?Q?AwuXqJmxbmM9Z6iZCAwER0wHWsSbSn1FszfGZY/daWWtXiFdVHQMJJbvdcII?=
 =?us-ascii?Q?gIM5tLjGyBRJOCvGdqXHlAmXFK4np7zwtZ3utpA1rAJbzz+GPrrKq3Nz3IP+?=
 =?us-ascii?Q?sm2Ucy+d6ST//wr+o449gsNtMXNzlXsFPsXzwOrnhCbH8oloUZmzD/f6+kT6?=
 =?us-ascii?Q?HBDAu5Cr6mgYecMX1Yp5th93qSkTQTl0aMfs39NCrUkReHHx9Ly+EF3+onqT?=
 =?us-ascii?Q?CWqCJU7cEfQuDXylojgTsemEtVCRu4pTfVHQb/wUEMq10SEogZ1E5YZOLb8O?=
 =?us-ascii?Q?51xB+xGYkYceF3dzYk0sXXEU7vEbGVfEhljZ29msJBO/DeXFG/PuTaK+Qm0h?=
 =?us-ascii?Q?tGeh4ubvIY5BCiYHMU9Ncilq1KnYSzETleTLnfwTwtxJjbExTdX9HDuzLUsn?=
 =?us-ascii?Q?1TKlyQPi06OqyHrboZGkmttxPFiMSbRS02851o36u01K7AgbqOotua3Ud1S1?=
 =?us-ascii?Q?xqr8b068q45KxpEO3qIGn1M+L1uPExdTtjrX16VSkbLwOe/nUbJaOUKKQymi?=
 =?us-ascii?Q?QqQNNLpF5+GyLO8E9BWrenA7plUaDonFj4Ma1L2BzdfPrNxiKuVNYv4bZ/yw?=
 =?us-ascii?Q?pMPA9Ok1h8ScjFSola8Z0Lz4mZNDCCNITSPAeebDjQwJdEJMZh7X85JUsYDu?=
 =?us-ascii?Q?LmTaSKeaXKJwW9f4p0efcF2pqKAyHRRPFHMpJg4YF01cXSEkGGkWnNYmMOw0?=
 =?us-ascii?Q?//cK1wI3EmG7hpFlWWKddjRA4nsQigaaK7rnQDFVih26vXYibS66Mvhu24/Q?=
 =?us-ascii?Q?foqUB5oLk63BtkYVclNXGut7cHfdqVRO07xwJBOV3QcFYRKGr1yDtAvsT8g1?=
 =?us-ascii?Q?9FWEPjm3Du647CcW7HgU6y1F+/Lhe3JgPBqpn4TnZLAVgbadoqxC1RwK8T58?=
 =?us-ascii?Q?YddjSmmMkmVRkXGzn60+fzRtkZ00a4re9hZCv8bvb9pY3gkujl4T5TSFqEX4?=
 =?us-ascii?Q?C6Myolol3sd4qPC3ooPSx9EkPZKFaOemHqSe8yE8uB1sftcL2K7iyRsLCCny?=
 =?us-ascii?Q?grr/+AfagsFhriTN706yD4VwW6tmN+PKGeBpnj/elVsq5scdkkY28H5cme8s?=
 =?us-ascii?Q?8diLmf5QOhw23Yj/KS7MkTqgaq0ydFh2jzNJNvBNhnrwhsMYXEbHT3LJ+EBp?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febe8b55-12b9-4d69-d7a6-08dcfd4550da
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 02:55:33.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9my7HH4eXC4KND6XOSvtip5lRFIk9JuHOwU0CKrffdANaCN6EKvpiF2XoGch/UI4cqKaDQiB8JWTqLD53aOUTezxtkFbPWMB9qENV01bGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6618
X-Proofpoint-GUID: NbIlhLTear8PLY_d-uGDlcESSrHyeLf2
X-Authority-Analysis: v=2.4 cv=YvBdRJYX c=1 sm=1 tr=0 ts=6729892a cx=c_pps a=1OKfMEbEQU8cdntNuaz5dg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=Q-fNiiVtAAAA:8
 a=t7CeM3EgAAAA:8 a=6Vgt_Y1WA2IAHscJAYAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: NbIlhLTear8PLY_d-uGDlcESSrHyeLf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_22,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411050021

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 78cfd17142ef70599d6409cbd709d94b3da58659 ]

Undefined behavior is triggered when bnxt_qplib_alloc_init_hwq is called
with hwq_attr->aux_depth != 0 and hwq_attr->aux_stride == 0.
In that case, "roundup_pow_of_two(hwq_attr->aux_stride)" gets called.
roundup_pow_of_two is documented as undefined for 0.

Fix it in the one caller that had this combination.

The undefined behavior was detected by UBSAN:
  UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
  shift exponent 64 is too large for 64-bit type 'long unsigned int'
  CPU: 24 PID: 1075 Comm: (udev-worker) Not tainted 6.9.0-rc6+ #4
  Hardware name: Abacus electric, s.r.o. - servis@abacus.cz Super Server/H12SSW-iN, BIOS 2.7 10/25/2023
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x80
   ubsan_epilogue+0x5/0x30
   __ubsan_handle_shift_out_of_bounds.cold+0x61/0xec
   __roundup_pow_of_two+0x25/0x35 [bnxt_re]
   bnxt_qplib_alloc_init_hwq+0xa1/0x470 [bnxt_re]
   bnxt_qplib_create_qp+0x19e/0x840 [bnxt_re]
   bnxt_re_create_qp+0x9b1/0xcd0 [bnxt_re]
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __kmalloc+0x1b6/0x4f0
   ? create_qp.part.0+0x128/0x1c0 [ib_core]
   ? __pfx_bnxt_re_create_qp+0x10/0x10 [bnxt_re]
   create_qp.part.0+0x128/0x1c0 [ib_core]
   ib_create_qp_kernel+0x50/0xd0 [ib_core]
   create_mad_qp+0x8e/0xe0 [ib_core]
   ? __pfx_qp_event_handler+0x10/0x10 [ib_core]
   ib_mad_init_device+0x2be/0x680 [ib_core]
   add_client_context+0x10d/0x1a0 [ib_core]
   enable_device_and_get+0xe0/0x1d0 [ib_core]
   ib_register_device+0x53c/0x630 [ib_core]
   ? srso_alias_return_thunk+0x5/0xfbef5
   bnxt_re_probe+0xbd8/0xe50 [bnxt_re]
   ? __pfx_bnxt_re_probe+0x10/0x10 [bnxt_re]
   auxiliary_bus_probe+0x49/0x80
   ? driver_sysfs_add+0x57/0xc0
   really_probe+0xde/0x340
   ? pm_runtime_barrier+0x54/0x90
   ? __pfx___driver_attach+0x10/0x10
   __driver_probe_device+0x78/0x110
   driver_probe_device+0x1f/0xa0
   __driver_attach+0xba/0x1c0
   bus_for_each_dev+0x8f/0xe0
   bus_add_driver+0x146/0x220
   driver_register+0x72/0xd0
   __auxiliary_driver_register+0x6e/0xd0
   ? __pfx_bnxt_re_mod_init+0x10/0x10 [bnxt_re]
   bnxt_re_mod_init+0x3e/0xff0 [bnxt_re]
   ? __pfx_bnxt_re_mod_init+0x10/0x10 [bnxt_re]
   do_one_initcall+0x5b/0x310
   do_init_module+0x90/0x250
   init_module_from_file+0x86/0xc0
   idempotent_init_module+0x121/0x2b0
   __x64_sys_finit_module+0x5e/0xb0
   do_syscall_64+0x82/0x160
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? syscall_exit_to_user_mode_prepare+0x149/0x170
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? syscall_exit_to_user_mode+0x75/0x230
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_syscall_64+0x8e/0x160
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? __count_memcg_events+0x69/0x100
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? count_memcg_events.constprop.0+0x1a/0x30
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? handle_mm_fault+0x1f0/0x300
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? do_user_addr_fault+0x34e/0x640
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? srso_alias_return_thunk+0x5/0xfbef5
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f4e5132821d
  Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 db 0c 00 f7 d8 64 89 01 48
  RSP: 002b:00007ffca9c906a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
  RAX: ffffffffffffffda RBX: 0000563ec8a8f130 RCX: 00007f4e5132821d
  RDX: 0000000000000000 RSI: 00007f4e518fa07d RDI: 000000000000003b
  RBP: 00007ffca9c90760 R08: 00007f4e513f6b20 R09: 00007ffca9c906f0
  R10: 0000563ec8a8faa0 R11: 0000000000000246 R12: 00007f4e518fa07d
  R13: 0000000000020000 R14: 0000563ec8409e90 R15: 0000563ec8a8fa60
   </TASK>
  ---[ end trace ]---

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Link: https://lore.kernel.org/r/20240507103929.30003-1-mschmidt@redhat.com
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: bp to fix CVE: CVE-2024-38540]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 1011293547ef..7d8dede13929 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1014,7 +1014,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	hwq_attr.stride = sizeof(struct sq_sge);
 	hwq_attr.depth = bnxt_qplib_get_depth(sq);
 	hwq_attr.aux_stride = psn_sz;
-	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
+	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
+				    : 0;
 	hwq_attr.type = HWQ_TYPE_QUEUE;
 	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
 	if (rc)
-- 
2.43.0


