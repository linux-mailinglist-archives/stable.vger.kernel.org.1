Return-Path: <stable+bounces-125853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D58CA6D4F4
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE31188CFA8
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C732505CA;
	Mon, 24 Mar 2025 07:21:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD519C56D
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742800890; cv=fail; b=GcOFbIKoS1mKspk4+AtU8czK+P+KsALz2Pw042XDlw1I+J1lic3MBC8yKeyMOrJQta4bXVpgco/tPuM4/RU+mrEryQWfGu0MGIF1fnAOpU4I1DhOfqtFr9kZ+IVS91GnR+9NXI7pUWhj3aOiTuOGZOfxXSsa1PfdAzOlo4gNTDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742800890; c=relaxed/simple;
	bh=6uBZFXGtDoyn3XMigT4KLH8Dt7r6HP/8ojxwRbr/E/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8LbtLXpguLSnneXoua0xElUBBF0cy4uXk1r1kHEN69VzXVHPH5Qg8KOEFLmzkNv7J4aDmPPPeEDUgQrn3Z1eYr2cW+l2T3xMlx/qcP3RMZqdE0q+Wb01Un+k4mqVRVVcXVh7RCw5XDnreO6Inplf/DBYfihFgBhigbTH22Y/7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6dRHF002107;
	Mon, 24 Mar 2025 00:21:26 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45hvqk9fg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 00:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTGYc3LmGslaJRdBP8XwjlRsAgF18lVke0F7B7h549ooYFGLM7RehPSmqqOWLhKS/dskgNpiIlm95KmfZHZM1dgoThXR0/25o40Xs6l9cPzpa7tc8nPiMiPJH/+DkLYDPSDtFPVAs1433ZFNwy0fK3OPTzrcL8fN2LUncLr/IynKN3m4lLflwB2VlT3KH/6o5zFamZHrWpcg12cFK/YkbsIpEzwJT2tiiEmVI6EZHCsFLdFliVb945yX7Oa4OplOxB1xiHzYA1YSGue3MNP8v/CnLbaityKd8QaIhPwztzQ5m58Vc1X354DcVlolbZRnnQC4Ib5v3aZMRiSlHm+Lig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bVegq+v9XxjMI0EA7HS1pTekPphTV+wxeik1xd7PGc=;
 b=cvIHNbrGF+MV+LXhJjpcPdp6vIwqmMFUvksz5vqxh3zxePeRnBvF4tZFyEYtTDSH0+DZKLf3rQWjx+7WMzT8tSSIXOWQTVOmNc9CWhk6XlKaZxBA1ALzceOXeJci7gRPZckRnXDbSa9Bj0vqiEetpO4XP+4P4/gOcjYqJkutEZvbn5o3IVo1vMHBypRQhDmcSudz52uxSqU4wPK7mCn3xGvz5NxgdxH+lUhQM4rasTvHt8//9fV75f3GnWaWlVjwPJBU2NQecEwglJdy0ZaBkrk5SSRZo4VHEVQl+pPospCYJG+dPSVLnXXU193XJgKofyrryUlDppkoMo8bR27LOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 PH0PR11MB7166.namprd11.prod.outlook.com (2603:10b6:510:1e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 07:21:25 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 07:21:24 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: regkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, ebiederm@xmission.com, keescook@chromium.org,
        akpm@linux-foundation.org
Subject: [PATCH 6.1.y 7/7] mm: Remove unused vm_brk()
Date: Mon, 24 Mar 2025 15:19:42 +0800
Message-Id: <20250324071942.2553928-8-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250324071942.2553928-1-wenlin.kang@windriver.com>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|PH0PR11MB7166:EE_
X-MS-Office365-Filtering-Correlation-Id: e905d8a0-3857-4279-ad1a-08dd6aa47c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0LvOwOz9JY5YLHWzxMfFhtkNwplePN2VfTHq5//RpdjlXPHGJXTyJIP+bWTw?=
 =?us-ascii?Q?cpfaCJdUErBUrS4ZRxwDcdQggzoBbgWY+q4o4uHqMgqgxqtTc093Yld3MFhq?=
 =?us-ascii?Q?aavZpY1JgV0MRtchX7Pe4DMCOoV9etclt6tuyB7U8pZl1Ud/ZAMgFaHcrRLG?=
 =?us-ascii?Q?lIgTlgtHi1UkBNKQqPjQ8BK20IfCSfO1CeiyfHp0NeScV/BO7J3AC5DACRrj?=
 =?us-ascii?Q?MigpyiIUqSpyGbL8kGr7YOgSXquRQIrlv0vKc/98FeN1aRfirkfwaKzM+aNp?=
 =?us-ascii?Q?/jCdHbWhJ10KulWBI1uIbvLV+SoxeLEghjK1QdoKlN0Wyx1+B5XnHgQ94qSc?=
 =?us-ascii?Q?5HByoh4N9pIlvvAPsWzgsW0htnQhtmpYOwQE21F6yZNpTAzVGupoIWhZsUyf?=
 =?us-ascii?Q?kxF+leuBub7WRW1TRr5sJVcv1zz0+pHVkyJ0VtcH0hIJczbd+x6bR/9g1p6b?=
 =?us-ascii?Q?vfDLzTYLZaBzxGBlzY9DLHsTs6S6ik4Xv8fo+NdTD3GMWD/cVE38e9ofVaCb?=
 =?us-ascii?Q?AkMf3Y7ZsNkgZ2BUYUII+iky7XgjZb12Wqwws8Q8hbTRaJDOdZRbgVjB49E/?=
 =?us-ascii?Q?51TVzPDqVLVz8nObV/ywOVHlyftN7eg80b7qJ6fGKfRSZzu2HCkyD/Z42R8u?=
 =?us-ascii?Q?Z7UMAn8Z0WAN6/fbts7D7HSu3U2CGO7M0WPFlZMrNL6W8iwz8GjmbyN8uTyR?=
 =?us-ascii?Q?eJS4M25uyskKx2wlR7hqg/w4NHKU/MUzXDt9aIhG69Ei5mCFLOi9XeEo1Rr4?=
 =?us-ascii?Q?jLVgS0ZTBpKuaWrcM73o/SpkFl9mF9gVLZ+1wXKzPCKfGoO9PUZBmu97y6a7?=
 =?us-ascii?Q?m/YiVzaAjcxE7gf613BJdi03ahhMuH8ItPAFBBAczBfhA21rf8ScyJrbOStu?=
 =?us-ascii?Q?q0p82PyUjnpxMKBJcLpBHOBedD6JGf4vmyOc1jJqNYGZyEm21EhjE2+rmKTI?=
 =?us-ascii?Q?3XINR2QxVzSonvV/BBF7K243RglGKMaqY4XnH3j2kI40HS1jNvu0bNvVqzE1?=
 =?us-ascii?Q?bEGSyr39Li2xgkPrzTqwG4FmHQndtMCADl4gVSPd+ArWs3z89WW/mVlVstgH?=
 =?us-ascii?Q?rpCic3Cfc/u6hp9XKSQChNdt1vQgvNTRD4Wdj0py0e+MHj41MES1qYsmxN9j?=
 =?us-ascii?Q?rlIEatecEX/C766LTmLJKNC31RoX0oIWSZTQS6BOUTG+r9Y52HQ68lEaCIwO?=
 =?us-ascii?Q?k456AAmEWDlBC/QpnFWDV0Rk7xgNrfMx4JVytAfk/QbOlC/YeuuueHy2/Mpv?=
 =?us-ascii?Q?/iMlEyoN9TleUvNtEoVbvJ7ZjcbAlLK8oEfmuUvd5tPQprzTXV3s+w24T94/?=
 =?us-ascii?Q?EF4BtmnvFdXrz2WSzzxoqzLMTTKaSXTXsWDRa/LPDEDrDMq/g2lOm4XQtw7B?=
 =?us-ascii?Q?HPkaFN0a8znMxplRHOSLR9UxXmRtObdnHa+qUYUI1H5BiQFuuuFdQdYTnuD7?=
 =?us-ascii?Q?6pp4IVryiG8lqOCps6gI5WY3/nA8vf5K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/O2QXPJe2VSED82qvzHjVTOvA6I/SxB4Ar3qMKUSrVy9v4tlrh7tkDLiCyVi?=
 =?us-ascii?Q?ufogrLAirhDEuV5iU3mbmzY3a9puOqny2V46R8rkJqGl4qMPZGG1TAt9AcV0?=
 =?us-ascii?Q?wtzMyJ3xNFUmNeO96jND5ICaz+kbFM0AJ8TRFDEow0Mm0aNKJeMgSlvOaYQY?=
 =?us-ascii?Q?WUV7fGV8289pButmjdL9gC5EdEHhrfiIVme1c/cqONDztkPY7yZbAzUAgbEv?=
 =?us-ascii?Q?ezEYg2ndQNLKB1VArtAn19owuF0NKUFK33gN00HlqR9tVE6JU+KovwaiJIiz?=
 =?us-ascii?Q?Mm7v05FgX+pvsnP858XK1pnPjBSSX6cJcmzvCTlDVaOUMidwRZ/1fE195LO/?=
 =?us-ascii?Q?1bfkHW0E3ska0lrzX9FGx2Q0RTtFN1hvJRlh9bmt/9hIR269sN5IKDtv0QbL?=
 =?us-ascii?Q?ZCA+IPro1GafSRtLnlksMNLNCpXJTgEOkQF+cDtQtXPJ8eFHi8Tpivc30ny9?=
 =?us-ascii?Q?aGywA5xCMWjGZZIAu+I7CIKn5rzpDcJ9ciumylP2xvx1sMxqtF4HUBv2O6Ur?=
 =?us-ascii?Q?xqYVZnCsQofVJza7YsCq/4mc6At7Qab/fU+94tsqfLNwUlzhmOx6V4NGJRGt?=
 =?us-ascii?Q?Ij9bTbR1/xpv+C0mCA7bi77yjVu5GxfFLlYksydLexndJ/nnF08E41S3WAnr?=
 =?us-ascii?Q?hCGqXmQ/jIgvbNf4aw3x6TH9CPLmry31EvJROxRoniYEaV6/zxcw3dUTKIEZ?=
 =?us-ascii?Q?08YfGYNiTDtD3HSw8a6dgM1F9dc7xxEtFjjWkkaYn+VlgUDNQfOjw7TeA9Qe?=
 =?us-ascii?Q?BBeqWHwZnLIjZ93BEwuQCf+o0YaK2IUdUjwYql6eUT9A689nDBrFKBUA5b/t?=
 =?us-ascii?Q?6jCPE0cbsoKQHZwPkWWFCi2T4J00uNuJ2v6XNtB3ZRrYg61Xak28pfJxf7bs?=
 =?us-ascii?Q?0LDb2nxjEHnoFgWR0kjCMd1kFdjumhrRc5Fj2Bc697szuYeVQf/KKAEypvJA?=
 =?us-ascii?Q?yBM617da15d9bB5nxxFK+Ws2GdnV+9eHQf8hLY2H8a2Ub/dhOeMSwaHN8ozR?=
 =?us-ascii?Q?g6lHm4vDbFu8E1A5WhLgY8xzIAlSoneC19z6fO+7A8ujTvEyFO/JLDlYT3YJ?=
 =?us-ascii?Q?Sy/3IfYQwL0J1XEmsiJsWSM4TlcDc46qSxLJa1du2Mf/wbtHnQsok3p21lIH?=
 =?us-ascii?Q?MsliZAlfple7XB0P3hLcji+HoeE9r87E+nr0bKAj6PNOblxzPZpMu20NrUV0?=
 =?us-ascii?Q?prqb8c5v5TfCPXgd+Y/De19bjR4+ZvSv8lw7WbMwY3PtsmVsrT18P6qcciiD?=
 =?us-ascii?Q?hmY2ue8BUL3q1vYU4dz717/cr1rcj0hqHb6YR3E6q2xW4YGIyDHhX0vFCYAY?=
 =?us-ascii?Q?LT3QE+k0VQDT7JS21WcOuAakTTnJE7vvSb7NSm2pAifF9qlPr8X4V2YPHi2r?=
 =?us-ascii?Q?X3ghXRRGOXahdY7HdA+HxgWuM0ZuwGq8KPGUuqfrSmRbrYMfpyk7SJ6gZNJc?=
 =?us-ascii?Q?eyLCDdZd9tFnSY9CzIltC0Q1LvR5SIA0OLY8Ce+BfQ6vf/pG/G3lGOQNu2KL?=
 =?us-ascii?Q?hnZ1a8ISX12iwAN2/sVQIAiheIJnsCnnuIaYC0kxeqVa8yWVlER+veFUWFKk?=
 =?us-ascii?Q?gvzHdHwGB/M6IPp3qzP2BwjAesJ8S3jn1d6bRwj3Y1UbA0wKWCzqevfPRspg?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e905d8a0-3857-4279-ad1a-08dd6aa47c37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 07:21:24.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fQ3ShXs5K7m1r7vbYfZUnCp+9kzR/hSHBHyVBejqSugt+6JNV6AzUtQiQd6mKb+OlUrY1IzjcPEZDOOQFB6sWyCBlQV4HXNlKMBhM+OY1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7166
X-Authority-Analysis: v=2.4 cv=XNkwSRhE c=1 sm=1 tr=0 ts=67e107f6 cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=Z4Rwk6OoAAAA:8 a=37rDS-QxAAAA:8 a=PtDNVHqPAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=JvzyLxfkzvKq0Z_-GKIA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=k1Nq6YrhK2t884LQW06G:22
 a=BpimnaHY1jUKGyF_4-AF:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: DQKqKaas86AxRJKsTh7rc4pblnDTXn2Y
X-Proofpoint-ORIG-GUID: DQKqKaas86AxRJKsTh7rc4pblnDTXn2Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503240053

From: Kees Cook <keescook@chromium.org>

commit 2632bb84d1d53cfd6cf65261064273ded4f759d5 upstream

With fs/binfmt_elf.c fully refactored to use the new elf_load() helper,
there are no more users of vm_brk(), so remove it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Suggested-by: Eric Biederman <ebiederm@xmission.com>
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-6-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 include/linux/mm.h | 3 +--
 mm/mmap.c          | 6 ------
 mm/nommu.c         | 5 -----
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 03357c196e0b..fe9df9f7ad2c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2826,8 +2826,7 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
 static inline void mm_populate(unsigned long addr, unsigned long len) {}
 #endif
 
-/* These take the mm semaphore themselves */
-extern int __must_check vm_brk(unsigned long, unsigned long);
+/* This takes the mm semaphore itself */
 extern int __must_check vm_brk_flags(unsigned long, unsigned long, unsigned long);
 extern int vm_munmap(unsigned long, size_t);
 extern unsigned long __must_check vm_mmap(struct file *, unsigned long,
diff --git a/mm/mmap.c b/mm/mmap.c
index ebc3583fa612..6054a513ea94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3202,12 +3202,6 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
 }
 EXPORT_SYMBOL(vm_brk_flags);
 
-int vm_brk(unsigned long addr, unsigned long len)
-{
-	return vm_brk_flags(addr, len, 0);
-}
-EXPORT_SYMBOL(vm_brk);
-
 /* Release all mmaps. */
 void exit_mmap(struct mm_struct *mm)
 {
diff --git a/mm/nommu.c b/mm/nommu.c
index 859ba6bdeb9c..586c0654f3d9 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1572,11 +1572,6 @@ void exit_mmap(struct mm_struct *mm)
 	mmap_write_unlock(mm);
 }
 
-int vm_brk(unsigned long addr, unsigned long len)
-{
-	return -ENOMEM;
-}
-
 /*
  * expand (or shrink) an existing mapping, potentially moving it at the same
  * time (controlled by the MREMAP_MAYMOVE flag and available VM space)
-- 
2.39.2


