Return-Path: <stable+bounces-83165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB8F99623A
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 10:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC881C21FE0
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 08:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF2F184527;
	Wed,  9 Oct 2024 08:16:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A416EB4C
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461796; cv=fail; b=OYu8+/83kArT1P987D7nNo072Y6vtKhkuspPuplm7RqV75jG6B2LRDHGeptfpwhcylUYbCDPhsQ6gGSXu43Ny75aoJAicEdZvMkpQuKf5+8oJ3Cj6HKqDDqEDAzbBziToi4nV8fEmZ3JdIgY/CX7BSZNqQzWINampyW+r7x8AFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461796; c=relaxed/simple;
	bh=SA01r24MeX1EwwBk4dN0yuv0pGcLgB6fRHbtfpN0EEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xsvi/cSvxHt3WyZBrPuz/80nJ1dj+sXXhBL3C3TY/5z55x9nXDv/MdkCWRqHWGMyGba94o9D05ZEH6ZH2w+qbFXYDYoSVpcdK9Ehi2eD3f8LsCfuHxrRzjpMFZWui+udfkgqRHyIF1e8eY+Y1L4gAwJ8mH2CRAWIbwzUELW/77w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4994sVVD032192
	for <stable@vger.kernel.org>; Wed, 9 Oct 2024 08:16:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 422tp448qp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Oct 2024 08:16:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQWg3/Rpx7DSTRfHNZnORw5SR715m7Myi1NQH08CBscIMSKoI15lth/K10O+dzUKnYwY/ZuHGh3WJmjQ90aFiEuu5KVEwuimvHyU+UjtC33qai6ElovvFIWkhF4s23qwwkSHWhqQBbdL0Zr0O4c3885raQm3rMreg30oYTLdeJvfyB7RBttCvU1RFrDhfqw0a4IJl/mZ/Kl8bNHiHb8bPV0H3v8DmoZwClKvv/x3WhpT3LXUQUTwr8uBR4Zz7E0UmBIhfvM6DEwRkIbDSIetVzJsaYR5egwHWHm+GS04dIiiSEfwY8B/vsRcv+HGUX61b66MxRP5OUsLBwwr3j5v5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bSj/j23VQaW6B3GQJ4/2IpexgoRFVI1dYrntLgBIR+o=;
 b=b9a49ith/aQqLn2OF2BKDXpN9fn+ELsdwS2Jv65ZZj0Gjb1tPJR+t816biKB1W0f3a/UMWC04jlA+yNnHwTjj1ClS3J/hAcCVza5hZ/mkT+6JfAbirYe08juGYUmIcTe6qoBCJ6Z07+/6S2KQBna6ty1VAhY3qSedZgAiZYWTnVvkWeOiyKkzEosBG3agIXSsV/bj7KvaoM41krXsNmc34+9QkVVG3M1geHiDk/el4IZFvKsqqN0hpUljbLdzrzdzKefzD0OaOaEWnNRYWxxDv7tXie5jPPxuyE/y6NMA/55ITKVOvQJUXE+FAjlRBGLXgzMcB6Li9Vt+TUNydPRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB6890.namprd11.prod.outlook.com (2603:10b6:930:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 08:16:31 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 08:16:31 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH v2 6.1/6.6] wifi: mac80211: Avoid address calculations via out of bounds array indexing
Date: Wed,  9 Oct 2024 16:16:27 +0800
Message-ID: <20241009081627.354405-2-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009081627.354405-1-xiangyu.chen@windriver.com>
References: <20241009081627.354405-1-xiangyu.chen@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0236.apcprd06.prod.outlook.com
 (2603:1096:4:ac::20) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CY8PR11MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: edb92033-5820-44c3-9e48-08dce83aae56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ASSKqzR8OXBN6FXRY2icYs81C/sMDF8lhcdUiHj1GfyR6JK2MA9RdB10r4VD?=
 =?us-ascii?Q?7WjJ3zV21PBIM20YhKpD/+OU850bSMHrQzscuK3ja8yBYtLkaPLq9xtBziig?=
 =?us-ascii?Q?Gvraut/1rjIZvCpJ6SJAIfqVY9Zb2CFe/zFyAO7lbG3R/bHmasJEnuKs68dp?=
 =?us-ascii?Q?p6dBKNiAKf54mQ/2O3/5zEN+55h1eS9dnqfXIFZzciqila52dDHNQspePjjT?=
 =?us-ascii?Q?B/vAl7yCCtCYv01XKdAvzWiNL//4uVi2H4ZvJj/UqBO0aTNJmijPBKltLj67?=
 =?us-ascii?Q?GD0jdnGJd4BeIky71hDrRi46tcmysX4PNpKFkmEN98dUJ3HpHb15h82JKEU/?=
 =?us-ascii?Q?Fuefuf5mmu/BUVCHR2gBilqZ4rLeHPlztSKnjcEYLCna7zI779HuZyC3+zRn?=
 =?us-ascii?Q?a6RnRfFvLdnD0ODup9vUztUPq15NzTIS2wNJLMZwA2Grt13dAbHp/h4gL2xW?=
 =?us-ascii?Q?lf/I6/oic9F8cT5OW86d2VRUUlKm1gUfZVJcYmKx+cFPDHpgw5DNDcxAz8Ph?=
 =?us-ascii?Q?noO2fwZW/yNMh9wSG6ETGbiSVhl2QK+lSl7eSm2SrvC/kqLnR854/0AGe36k?=
 =?us-ascii?Q?jOXVTpf5Wkm5eRSaVMEXnmUVxVsdITmkXdOaSSQkMyJGN0C95WNw8Gdbkwva?=
 =?us-ascii?Q?HMRtq7J1PiXpreLTk4jWdc/bmaxsleICHCCa1y9NWt8AWautNh8nHQjaCesu?=
 =?us-ascii?Q?Fxj9/K9dd0SYeJCCYc0fveRuV1Iu6mIEAlE4aT0KbTj6X2PyJ8ESiDiO3/gh?=
 =?us-ascii?Q?Q0iOavtBvfigh6e15uS4tIj0hsFaO/9hLxnIfBzolYf6B4AiY113Tzqybnwb?=
 =?us-ascii?Q?LquJbq7pIQjnfFmg1uHm/3XdhFqnbV4Y063t7QfnJHP3Zi0HYpGSlm9mftIs?=
 =?us-ascii?Q?48MHKths73IQlricne886DzhuPENkYPeDs06tdyku6VdFhnMpDw6BXKSkT0e?=
 =?us-ascii?Q?APUwc90L8kKIueiByDjHN66E5Iiqz/5YYF8qWPcItOhtOg8UqHTE+4joUtCY?=
 =?us-ascii?Q?umC8FfqqgYOadxKqwkrK7D0oLU1a8k/7JaV+qfhxrPhJ5/oLGcXcG8Hrh4FL?=
 =?us-ascii?Q?EaOXQlIupweU7xY0d2R2gr/nlTMdNNtziTBK/Vg2PmU27jG02ZlLtJLwcMD6?=
 =?us-ascii?Q?yAoAYFlwwitfvM4MidyBXYAwadb+b7E0avFRu1lQ3V3c/O2KPdKlbb8dtZXu?=
 =?us-ascii?Q?7oKRy9UeqVJKdzoJpa37uw/nmoLjR2/o2e3CiSd/C3GV+IO6SuntmFOnDuHe?=
 =?us-ascii?Q?UeX+RodW5tY1ZFMsOlUoNHR/4AOLPHk3TwA0+9oRaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7KeISbR7AfRR0o+Ro72KA/Ps9QH/YcsKPHZLmh+gZMofi9U2VM06xmMndjuo?=
 =?us-ascii?Q?IuPzbrWMrDFu02X8w3at2M24Gkr4bAAnxARKGc7hE58X1DVZh6KqanENLF9Z?=
 =?us-ascii?Q?HzTOr9V6EQDcOzz7t/XmkIy6rlI7NiMq/+krcDY/tEM4RoQ3Q3rWlLhFkgN/?=
 =?us-ascii?Q?CrzDTQY23mNKIEuStAImGyRdItI3B2IQRewJRLStrRLwWv+mHmuDFm3d0RRG?=
 =?us-ascii?Q?NwpRFdFe9FEuG9S/c3IjyUnT8+lf53ucRqn1GX4Q+rhBhh327441OOX6Espl?=
 =?us-ascii?Q?bdyOHB/KsuO4kRqwLkL1iVYNe70QuDZzB9tsNDvyH/ZosfbaTYSZpRnKO7Pt?=
 =?us-ascii?Q?QwMgxk//FhoQ+FpgNf0IHktvt8S32ObfHqCxRPrnzs82hC1vFqoNzn86vXmu?=
 =?us-ascii?Q?ArtwdtBkNaut4+j8cRdu9F3fqP88OtnBREIA2qYWrhYDcZ7NgbCgduxNstCF?=
 =?us-ascii?Q?g/8YjE6CPnOkMd133gUlMc0B+CpT1LQsrHtWwOoKBdlAMljy6bG+7m75aJL/?=
 =?us-ascii?Q?iU6o9AknHItT7TYrQCAkPODTf4slyRDM5aFQjXUK88Eisj+dijkl74Qrfdfl?=
 =?us-ascii?Q?Q3e7qM16snkp9+Svxwjn8LBZ11IKU6+qwxkjKcaNxWQaw4jic+IIzCL/Ohy0?=
 =?us-ascii?Q?73XuxVpOUHDSr5iqjDQztotWEb/6hieL3vgarJdH5jD8dGWmEro3r+HFPa2j?=
 =?us-ascii?Q?4ZHa5s72rUen6FYRdH2V+X0X028X6KIPS5pDnlvYvNu7isl/xXEhIc0wgBvH?=
 =?us-ascii?Q?52kyQRgki45DxM/g82/iQEDZUs7dqTnO8yjtpSIOBDscCVpVHELHnrwXNuOk?=
 =?us-ascii?Q?amRKPSXvGIN7aJamQNypBN+GdjXj9qjNiI6LFTDT58h+YvgPQ/OAJJKKrpHs?=
 =?us-ascii?Q?ePXn/eDbXjNhI9+ojG/xNe+2qGVnsKAuVytktIb5+N9nbKW5ZyKRkFvWn1BQ?=
 =?us-ascii?Q?Qa2ebYXCIk8oTWdIC5yKBEDfDkV4cjyYuGD/H19u5OqnmVCDnbRbV/qHyXgm?=
 =?us-ascii?Q?Ugqv+7NiyWIic+EocgxInn8fb3iNMG+6mxni/LQWEIK1qT1XUwmyYxd02e/J?=
 =?us-ascii?Q?n5uVo2VinO1fIdoJAh47US5Xq7KWxOi2YzZ+0gtsyi7NbtVz4rMC9wPWuZM+?=
 =?us-ascii?Q?wz3LVHgLJIGuS5XWkm9a904FPnyragZ48L/J+/N2VTNEExiy+SzXCVoL7QwQ?=
 =?us-ascii?Q?2bwOW2yBbE03MIpXOdFbjIuft4w5ZJ5In6TRv1pE1WpstJvI1ISOMWDwf2ZR?=
 =?us-ascii?Q?pbasqMtzWxwDCFUsn4Gsd0HlFxs40ruiu9zQHmyB5ajBZR8G3vrRuIT8G58n?=
 =?us-ascii?Q?OSOGHVuewOTqdQZ5sQj9t27Jjic6nVZcKT/LyCvqcZ5mdTJgOCnPcnEwJvt3?=
 =?us-ascii?Q?yQ0WCat6+Yj2sg2g9drENAU4pZWRrqyooUuPZcbuhQZ2JKcv30iE+O07xnvk?=
 =?us-ascii?Q?vvMtVmhVfsnWxZDHc66lvYlW8xImoqt22MfHYz2EbPIhuCidTqXq5Cyrd594?=
 =?us-ascii?Q?7k8xrXzCIjNYFgXUYDaETbJSClN4SeoMjycyiG/XuQXaTkTeMbO7D8kqBFMm?=
 =?us-ascii?Q?nkZcEJ016sqbG7zN/mhqGVZtUV0USFTAWin47Fw9lv9+ioYYBZ4VNB9JwZO2?=
 =?us-ascii?Q?jg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb92033-5820-44c3-9e48-08dce83aae56
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 08:16:31.1933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CIYoQbXp3XPo3fzd4qrMyeVAD2xoHwN8YOFT2TjnFPNlgO5DJZmS4BpRBfPWQAgPmzAmo928KjJGEQVRDLWSxFAzae0Bn0LUyJ/YsaKmZmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6890
X-Authority-Analysis: v=2.4 cv=XPtiShhE c=1 sm=1 tr=0 ts=67063be1 cx=c_pps a=WCFCujto17ieNoiWBJjljg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=7mOBRU54AAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=t7CeM3EgAAAA:8 a=8rlKWU-16rCVmec68OUA:9 a=-FEs8UIgK8oA:10 a=wa9RWnbW_A1YIeRBVszw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Brq4fWEtFGv5xVvAR3XdTp3R132bZBLV
X-Proofpoint-GUID: Brq4fWEtFGv5xVvAR3XdTp3R132bZBLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_06,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=720 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410090054

From: Kenton Groombridge <concord@gentoo.org>

req->n_channels must be set before req->channels[] can be used.

This patch fixes one of the issues encountered in [1].

[   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
[   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
[...]
[   83.964264] Call Trace:
[   83.964267]  <TASK>
[   83.964269]  dump_stack_lvl+0x3f/0xc0
[   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
[   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
[   83.964281]  __ieee80211_start_scan+0x601/0x990
[   83.964291]  nl80211_trigger_scan+0x874/0x980
[   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
[   83.964298]  genl_rcv_msg+0x240/0x270
[...]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=218810

Co-authored-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Kenton Groombridge <concord@gentoo.org>
Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[Xiangyu: Modified to apply on 6.1.y and 6.6.y]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
V1 -> V2:
add v6.6 support
---
 net/mac80211/scan.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 62c22ff329ad..d81b49fb6458 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -357,7 +357,8 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
-	int i, ielen, n_chans;
+	int i, ielen;
+	u32 *n_chans;
 	u32 flags = 0;
 
 	req = rcu_dereference_protected(local->scan_req,
@@ -367,34 +368,34 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	if (ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS)) {
+		local->hw_scan_req->req.n_channels = req->n_channels;
+
 		for (i = 0; i < req->n_channels; i++) {
 			local->hw_scan_req->req.channels[i] = req->channels[i];
 			bands_used |= BIT(req->channels[i]->band);
 		}
-
-		n_chans = req->n_channels;
 	} else {
 		do {
 			if (local->hw_scan_band == NUM_NL80211_BANDS)
 				return false;
 
-			n_chans = 0;
+			n_chans = &local->hw_scan_req->req.n_channels;
+			*n_chans = 0;
 
 			for (i = 0; i < req->n_channels; i++) {
 				if (req->channels[i]->band !=
 				    local->hw_scan_band)
 					continue;
-				local->hw_scan_req->req.channels[n_chans] =
+				local->hw_scan_req->req.channels[(*n_chans)++] =
 							req->channels[i];
-				n_chans++;
+
 				bands_used |= BIT(req->channels[i]->band);
 			}
 
 			local->hw_scan_band++;
-		} while (!n_chans);
+		} while (!*n_chans);
 	}
 
-	local->hw_scan_req->req.n_channels = n_chans;
 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
 
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
-- 
2.43.0


