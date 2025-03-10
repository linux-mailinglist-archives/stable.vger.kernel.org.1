Return-Path: <stable+bounces-121666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E58A58D55
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 08:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8309F188DA83
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 07:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F57E2222A1;
	Mon, 10 Mar 2025 07:54:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A032221F3B
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741593281; cv=fail; b=rohywmNv2q5eEGGMOXommo/wdlBNWDbg59nE2dLAerDgReQXjR0BbcsEM+psnXgq7bFGNISepUPwE7TGf0aJDTwhhbJ903cmZ/Fo4da9QKT7bsaYOqRcsO7sgBzqhdNOlAHB/qj8jz53Frnz1HebyzGg+G8ySPVqfNCedSszmZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741593281; c=relaxed/simple;
	bh=u1c3+ujak0Vurpf0749d97PwzHAeM+fDQlTDTTLE+Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Wt8d9Ur0NMapCqrdijeLXPGOAsT2xLCohi1Dn+LsdFMVA4KetS21hnc9VkT7li5rnKHMtpv5g17fQ05E2YPoNI4IMdBVDOHAloNrnxQdkJpuWHHBf/QJIYaLuaowpUAS+tu+/yNTO/mRMeDVxYSo3a9n8VSMkdLjbYVSXIXoao4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A7j2Dv019962;
	Mon, 10 Mar 2025 00:54:27 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 458p9qhd76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 00:54:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OwhA7EBm9/2TKBPg+wmGhDpHJ+01JnGUFSJmKUv5kupGzBjehpiaufxCFba03QO42tm2Fly6WO4ZKaiswxcEwbQ4Y0Gqo1vddZ0RZ1OK7MJAF5IZhlTGVp1GhehKs58ygXyBIrh/wlFPXRan+m7hENe/WuTT8V9cdApeY65+Jj1wWqaBy4UwyXGeOiZZFC+/aM6fujO0qGXqwoRIg39y/fS/3RklS8+jD2cL/9Obl5383eZqkiKweIu7mjaLsmFAQQ0cZayu2PMYQ6aYLNR/P37ubW+27GjF0qrGtIsDs/QaEwhm//UpRzQn/BCeEMbUznioXTYnVgb8PbQA4mkqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IH1eXT117hUULv9tOXVVp0Tg9joA+w9+HF/+N3i6YM=;
 b=EzAON1a5BrPhiL040d3ioGRM22l3PtuTsjQ6f2rZCtDWZVz3tCfqccsLM0WOe4ohuG+vz7gqLjzapMnefMZtubXqtQ6uCX6L3C+OHQFcx6lQvQVMA80YEUTJ884KQjwXYK18Oe2by4wEIPwlSL2zZJ0ASY+VWA+6NpI+VaM6IqbObPNpRcG5xIGV0zSPWyEc9CDMQpD5bhen+mwjtW0e4Ih3Fetw2eLl99Ci0ZLN/jJY3tjk8VPeHaxtu2u4TKSOqNX8ovsPzn5+FwDwNbBzG9bLQmcKGsRfhtUNbeUNcoIClDCf0bzHytkpCjisLOeL0JAe6Q+G5QmcUGw/NboCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:54:24 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:54:24 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com,
        Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>
Subject: [PATCH 6.1.y] fs/ntfs3: Add rough attr alloc_size check
Date: Mon, 10 Mar 2025 15:53:43 +0800
Message-Id: <20250310075343.659244-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:404:28::22) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|PH7PR11MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c43459-25df-406d-3c11-08dd5fa8c643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lPRYAeq1PdSbJMtoM1XOd6u7Tzpy0QZSOh9D0BYgOh5nbq266QcAX1xexSZh?=
 =?us-ascii?Q?UIQiM9glXDzdeNcKW1mhGuaZbDYuDTx8dmW7TQWQ8gcMDtWvz05yHNOK1omm?=
 =?us-ascii?Q?0o7njfo4G/7d6vBDcNV0n1DZxNEmdJDsdzs5uQ67YsObmSWtON2E6IUenlrM?=
 =?us-ascii?Q?s2c4kK1i/r4o/g48MQGRXT6vXvA8V/guVPUvB5RkXoy5+1kS5PWnqqLjx8iZ?=
 =?us-ascii?Q?chilcq7BLgYQD68or9knvnhtGzHfIRDj4zDKsolL/Y3dzzkD1gVf7pFh+10+?=
 =?us-ascii?Q?ef1/M9Ajj7ni3goRZDuxBz/v1JPulhxEkFz9OvlCGERpz81S3BR11zz87fr1?=
 =?us-ascii?Q?xnROKAnCxA2lDwJ+Pbs/CGrHHSy5uVekITwD6XcBd5sSh6dOwWEnZjzFpgC0?=
 =?us-ascii?Q?5uBhnHOWVQ7Qh4FXEgA7z48vP0sm+BmbbIfAQxHNs1Iy0O4cfkDqdQlJCn/v?=
 =?us-ascii?Q?MmfJPgNZ3/3izJAsRprhwn1p/t1KJNMHTeT682aCy8w/qTVYSt39sV8wvndZ?=
 =?us-ascii?Q?JfmSRPjkQe7tc3CNsCpMveZLmERIVdKPRwD3OQLlNyUEY7p2BVmNGMz/eX2g?=
 =?us-ascii?Q?o/oTWrux7jwxyECGUnVZkRwF9G6DCMtr0SYGsLDm4RbRcjc2/N5KQMN2y+uc?=
 =?us-ascii?Q?Qw0lvQGpb82Bt8m7TvVf5FkXilUFtedStpf12IUUPR2R00Sa/nbk/LgqMqMu?=
 =?us-ascii?Q?4Osd+qwUt3uj6s9E86JhY3zJe3cEBs6I/Mzynj+Mb/V7TSEfbt73V2PXvEpF?=
 =?us-ascii?Q?uAz6bNUkyyctv5T1kYCdE7ixlAtjeQA/zjkip6/Qpv2uFO6J/YMwFZgHO781?=
 =?us-ascii?Q?GOAv8PkFhZvSrmGNqpjpIGhUP9t0izG15DgK9x22c1QbkqywKmdAhanzljrS?=
 =?us-ascii?Q?635DDm+1BDeGMS64PfrMvWERiMYPSUCIM2IWMZuiGWuNJsIKWrRq6iAgxwds?=
 =?us-ascii?Q?ss9o+bOErPauQzup5xdXOjnEW3Kytgwr858PlhV344oYdTmvehslCKgdsYE9?=
 =?us-ascii?Q?Ike2N5K+3MY9z/jHSu8Fm53Pg7pukdY+bEAhwWGwOc4agFFZ+4A2oyLZlv0W?=
 =?us-ascii?Q?rpEMPcKetKz9dLes+WhPcAVwv3vDRHxi0mLXLtQs/9Tq4dIkwN8OAYQdxiOf?=
 =?us-ascii?Q?RsLhmk3k4B2ya/ZsxfFf4k1n58tgJnKkB0weippS02EJ+l3wwntP6+eM+VHf?=
 =?us-ascii?Q?myoLZOiy8ZObR0sj9htRD4SCgHtbCvMEFFC4fyu7H9nKoT+8DBPPJh31a01O?=
 =?us-ascii?Q?UeOCQ2ADdWhq39RJOFwIjzIXPiJbsZEe9J3W6xk7og9vlJPSb+zFj3AT0R+7?=
 =?us-ascii?Q?revy+xqclaov7xFrEUIBPkOr2XU3UpGguXaGOgZQE7eMomNVCqXbyVV85FzN?=
 =?us-ascii?Q?Pf0nZo3C+uoYAjuOwaHxe7XnS6RlgYTxagnxCr3pQEwFLLKHw8MaBpYcRVug?=
 =?us-ascii?Q?fnjTlJRGkCZzR+XR2aNtk+HJRaPvzGrq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BNwTpHE+ddT3bOZM78kqqcDF+nScXn6mYRn6IRHFKXEgtDylo3XXxPixtzGq?=
 =?us-ascii?Q?Xgq9f8mBwg6gj6xF211RunSDoo7RFVcY+UgafeK0J/VGoVwXK+EfAUHISknK?=
 =?us-ascii?Q?P1Cg5jIXoeTZ4ceN3mJroNsr6DyvvUfgh/j1AtNLsh45j0pOP7jWp/p0HcEO?=
 =?us-ascii?Q?/MivmR9ItVOKMeseDdLdkJYnnb5NhnpdwGinO0Ekg0VB/n59nB9xKMNDRrwc?=
 =?us-ascii?Q?KXJSpMbScB6PuVpUbyJsX+yU+jhlcnj11NaTNfseD3FKlcA9gQZwCmG6QuO8?=
 =?us-ascii?Q?ceKQoPSmUuDIY+6Ku+venrz6y86+PBFxEQ94mYoH3fdl7Wyenc/MR2bD4L6a?=
 =?us-ascii?Q?Ps/OwBiTaPr0Theut0FIIvJvcX1LFkIEoJASM4AUHp45mpUex/QoST7l8MQG?=
 =?us-ascii?Q?Sv6wU/RANCfojc22jnsSVHE39yn8YP6RrPsRBVmlTkjLrAjqLPF6Z899HCmr?=
 =?us-ascii?Q?f8sGINJ8I0sTZ9RJzNYpEoca5Pya4ATvYKmCV0ysBunYvr+jlQD+b+Ahcp0n?=
 =?us-ascii?Q?ry6WEMfxGT5wUwhPqHp4P/KhWEBjaGGVU7IjY3YikZY7v+sR7Hef6jvgL6Xt?=
 =?us-ascii?Q?Hbd39voNbWwThqJHHgxSBovPHE4EnyZ17KavqlS1swii7vmxQZe7cMztHY+R?=
 =?us-ascii?Q?belB2P/OkAeUHlmY6zKykizzQrU9M4+ZymWNqd+tMmIcQ109hvZvdtyYK/P6?=
 =?us-ascii?Q?C14thEhkvNZ8N1q2XVSrur8oJdRiTHFQtlyuHTgCbn1L8bEN7Um6VhKZtb/g?=
 =?us-ascii?Q?2GUS1Y7YVNBxxsrp64lGkB5dZm7B783fgEiFyXXpIxLdeF7j0J8p2OgOQa82?=
 =?us-ascii?Q?VAuXIN+BQ+Y/cZbbpALh27+sRoes3HCFDahKFagnk+tXmMN2PzzJ1cVxBw+f?=
 =?us-ascii?Q?uAjM6vg6eN/Hg8TwE0ZmuLj7HkdwB5U3rYpHa/6LyONPBtOIF0lafg4/ZzlT?=
 =?us-ascii?Q?Ce+/kqcuKYTgNN7MIE00W0WLmCP/L1tu1Caw8UuQ1RdscqHie/EPHK/VZ5Lz?=
 =?us-ascii?Q?6CRn/wfKPfRfmR+4ll6dNQWPu7XqlYD5+mqdJ8SXp6uv5A+8yIPc7IDOTGLb?=
 =?us-ascii?Q?RsYL8wxyoqQHYfmMyZ/9C3T9nrCnVTDp4RX/QnfkHhUBDBDl8fq0o/VxNwz3?=
 =?us-ascii?Q?jgZocm7/CjccX6YAZR2pqDPqwVHQlChH8MovGa/9lcC3wvDqUds2XENrjOjN?=
 =?us-ascii?Q?8UT28qjkelW709B5pKK30d27dKPO1zvD2mEm38q/trduHUeSdEVtsSALBwSN?=
 =?us-ascii?Q?cgZlJ97v+ZUnncLryyFat0PoVbw2o4bRnGJZR/y10/nY9A+9gd+AJVrVWg/Y?=
 =?us-ascii?Q?so4ASy3ro5BUBvVsnZjbYu9XF48thI+cSquZoaeLSionptdpdyf/qJDLAPkh?=
 =?us-ascii?Q?SFKd40tlXJenTVeS991wB+cALJ8N7EbtB8OZ++tRn2pTXVSEKPkZtepBOwWi?=
 =?us-ascii?Q?ARNQnEKkLcu4jnR7nu94oN80RsRZ306hXTTv97m2zqLEtdK58mantWg6Gvte?=
 =?us-ascii?Q?lW+4FK3OIP/2XU9/tCLTSd4i6Fi3QZwUsXlyHOcdbf/VEoZbde7zZSphDJjK?=
 =?us-ascii?Q?fu8YwZUTj3lzgodIvkkVAGJeMBzXhBYf63WxHkYoitmElWiL2UlyD2u4l8t5?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c43459-25df-406d-3c11-08dd5fa8c643
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:54:24.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPqpiih08tvX6EvXXzEoWpiPEAREOX0VRlvXQNfP7VCOUUTF0AzuOIQHi+77up2QrYbjPU5GH6VsD4P/Qs8xATTJKFtHLtXnkIgG19+kKX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
X-Authority-Analysis: v=2.4 cv=QNySRhLL c=1 sm=1 tr=0 ts=67ce9ab2 cx=c_pps a=DnJuoDeutjy/DnsrngHDCQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=GFCt93a2AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=J4P2wOEuqLA4JKkjWb0A:9 a=0UNspqPZPZo5crgNHNjb:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: D8JkChKit-aG0063vCMD_X3KAaReZjpu
X-Proofpoint-ORIG-GUID: D8JkChKit-aG0063vCMD_X3KAaReZjpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_03,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 clxscore=1011 adultscore=0 mlxlogscore=964 suspectscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502100000
 definitions=main-2503100061

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit c4a8ba334262e9a5c158d618a4820e1b9c12495c ]

Reported-by: syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test.
---
 fs/ntfs3/record.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index b2b98631a000..bfb1f4c2f271 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -325,6 +325,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	} else {
 		if (attr->nres.c_unit)
 			return NULL;
+
+		if (alloc_size > mi->sbi->volume.size)
+			return NULL;
 	}
 
 	return attr;
-- 
2.34.1


