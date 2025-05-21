Return-Path: <stable+bounces-145733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED32ABE929
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE50D3B86DE
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27219A288;
	Wed, 21 May 2025 01:33:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E233F3
	for <stable@vger.kernel.org>; Wed, 21 May 2025 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791224; cv=fail; b=lrKcvGnmAzd/X/yF9DFYVNm66/PChs9gCu5FvzD8YYLdxALSzB67UlOCq9RAPpNnJAyJ5STtCHFY6xzg6KwCNsHKL9ba9F/uSCbbJaaigkKAbtQ30+F9vhd0G+yGePKo/fK8/fp+YgM8Gztk9V7d/qqe1uroBg1kK1GRY5Vnk/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791224; c=relaxed/simple;
	bh=3U6E3eHeIAqNRz9nOHZ9t4MaiIRhZ8WsaNqY0R5SGOs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IXDaGSSiPNZdvZ5lQ7csMGdFtzLrV9zCksFm/POLjE6Ik3x9I165wl5lUtsy5tMXETSoYj5K4D4B8qnDM+2O5lvk8xNE9IZlbSO0dfIZeYUofHjrvikGi75Pc09+GZydntmkdEaVV6Kvhwiehp2lzJMR6bC4ZRRaYDXKwvfr3cU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L1UcOC004194;
	Wed, 21 May 2025 01:33:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfx0kq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 01:33:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptAcp0R0UGLQIicCXwbnlpOF8hRS7u5ndoAw6sqeKyeM5Th8le0DhPKoG7vxxXAB52weYDBMRCg69JkWvbgNhCOslZF4+2BVAAIsiUuJsIsfUT+HfPhjmpJT8KLB09BOnybvTRe2C9tQQpMNWFbfv+MpWg4H3dwpMVzAEEnrzRydB28wYqJLjnYjY5E0g1IRxpv+qkCy2OaP4BTVWMf0XDBvDeaXLfntrmAn0aikIC5zLMuthyDAJ4a1gHfz3vm/fn5ZKi5JDZ8t6sr0nUj8gFFWbqEIq9AF605vQUiSEEWnd7YIdrH0JMAV5RIlGEKtJ07CZxpAW+8Hm/IYNCdoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4X2TJbD8c46cmV2fihvgb1DH2XfS2z/CnE9BfyLUL0=;
 b=IIw4bmdpQS6/QvBxG8eoNGNwcVTqHFLsZei7EAZbH79PlRndlY7VER5EofnHpX0V64lqKdQKgVsVCFQffPkayUm55KOKFEWAlNr1JQcWikVAHt+D/RU/6hDcdHEDYa6zmua8iVOY4PGotXTy0Dn3R4YoMou4wpwRY8YMmyC2iI5dewp4f9TNq419nnBzO6Pv7zIyhaDVq88YVNd3qHqtn6wIcYlaPZJ5KmPjDOhBJJesrEKsw1pTmLiA2hEg5dJiJSFl4SEYKEE7/gQLhiXD2oMEIbUl0GCNMNjRBS5OFaHP38aQJKp8XalGodHh5BTDN2EKgVd+FvGxv5GtXTlBYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6965.namprd11.prod.outlook.com (2603:10b6:806:2bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 01:33:32 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 01:33:32 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: wander@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bin.lan.cn@windriver.com
Subject: [PATCH 5.15.y] sched/deadline: Fix warning in migrate_enable for boosted tasks
Date: Wed, 21 May 2025 09:33:16 +0800
Message-Id: <20250521013316.3339744-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0166.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::17) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f8fed4-03f1-474a-e15b-08dd98077f30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uFAbPNr4ir2OUh0iJKW9AYfnQbuTL7qjCJw7eOtbiR/I+ydpKe+gpZk5KWv1?=
 =?us-ascii?Q?D6bXK8PJFDqR/IsUGaOIeG0uWJ+Od1QVKDW0RcwSJVeUwXwogWZ2cnWoTz5w?=
 =?us-ascii?Q?jUaXCdycPpEyf/eYI68HH1GLtoWIHEHVmeVKpKvbvlpwer4eVZfVKIy49Cxc?=
 =?us-ascii?Q?vvYW/iG7gj8vxYJeBXUE4LNvdv3wm2nuq/Z2627+DohntAh6U3KQX2PhI3R8?=
 =?us-ascii?Q?/C2nqaT13vt6IiG/sFAR8QWNEtRSkHDKjN8yeldhmHF0RvkuX7nH0zLTc09u?=
 =?us-ascii?Q?U5cFXfiOWXR/tyVgoUc8JEnKFjHwxADQgwVdG410feY4ao/VeTy/QVpJXG82?=
 =?us-ascii?Q?/2gUD10mSToqCA1EVFEPiU9+3C6v67l3QtyqgsokXa5WgcK65UXmHOJJpZ2J?=
 =?us-ascii?Q?xRlyHM99tXWoty1BqyGGyPcBlMzeM77ZLOzOUVK1toZ42j7KicZrP0BbMGYn?=
 =?us-ascii?Q?NB1DrxL8Amnju26ecJ8gMY49UenQDyl3z0bTCLM8BoeSdSgGw6V8YTiK6orI?=
 =?us-ascii?Q?88MLKHVKsXHFmwkP4VkdCygjd7AFHc4W6IZ0pGxKoz94Rg1YJZCelA4JePlY?=
 =?us-ascii?Q?/ngCE93BvsMwy4359rev0ZtiploeTYJh3EoiBAiXNVazhdgmEs5NWJk9NMJt?=
 =?us-ascii?Q?RgTwiI6TcliJPf6dRQXajSp2RV5cSSbumfIqMzJgFt+0Y3922mlnMBOKmago?=
 =?us-ascii?Q?qbJLlGq98YLvoSymAPbHD+qPQxihXs2I8IMclkc9K3/ijfISQxMIaqQKF7k7?=
 =?us-ascii?Q?0UUG9+AMvGdZzvBRHRTUSipN7Iis6F970ULXp+gEcTZ7e6NGkbFRBoY7/xLy?=
 =?us-ascii?Q?0rQQ/XGCxQhn0pgRQDvOeTguQDyxYMLqcZZXjMBbrwieh7Cf8tBsvFfb8dJZ?=
 =?us-ascii?Q?9ZSh0yD/b7rdCcnelfoqSTXtn/FHTcn6ijuJJ8GENjpKSPebtBB9jEm5KRNk?=
 =?us-ascii?Q?2LZ5QpqFTKW0wq42c/z3ScUR+6TREN5hj0hQEIGnxEqyLhnlwStm4w4uySTO?=
 =?us-ascii?Q?O+/8TvwiB5HuvApij6bd9s3+8KX0VcdcoHumXoq4qLXQXb8M5rIJlayqO+SC?=
 =?us-ascii?Q?jtITe8MvGwpsROmVHnzcL6HJ/IuEUU7ysh28fBdZyCLr2FYFZNi/kLzcUg4v?=
 =?us-ascii?Q?423WN8On2l7jx2bHsmi2bHf97X5Fh39AvAPCdi7zwwUOl7n3veqFLKIucR7Q?=
 =?us-ascii?Q?gv5l8ZdutlWUnehxHtM34xf2b1ydt0Z9BweCK4qNHeT3zO+dzGZX8ISRAF+K?=
 =?us-ascii?Q?bWZc3xFj9Tieha/Fmro/szhThtU0E+QOGq8NwA3PhEHj7qw2iMUBBVbWPg2x?=
 =?us-ascii?Q?ntXVjC1L4pUPKTcu8cCvZ8viqMxGRYMkV28DgeOUysIHSg4eVGWdDZC+XwcV?=
 =?us-ascii?Q?awKzPxa+shovbGXk8k0/KLuVzIizD3rrtPqGlV4DKnRnrEQ+Eekvc6SmW0pG?=
 =?us-ascii?Q?o4bdTWXkC9c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?anEwu593nHq7oePzBOd2OwdOGWcDYc3VhVkZqkTYiV/HB3DZlkt3t+y7NlWp?=
 =?us-ascii?Q?FQZ2iGp1zYa31A3G83Hc2Okb4TZbvvH/XrpgSNryr9TbdeUUMzQRTIOQrYGZ?=
 =?us-ascii?Q?YH1GtwBSertFqjawcy6GcNaV5Ns5Ou5xmtdU5WI7rnrrw7bourC3g6sWHHRY?=
 =?us-ascii?Q?SIgmAGlWgas0kyXFzAq8+Ps4+fHDkD1pweFl64HTr247c62HTM04AdGimTko?=
 =?us-ascii?Q?NddOzKMIzLWQFzKQMU2VIJGoBVW7+aw9ExtDy/v9TDxjQJ2GBQxNmvZSY1/Q?=
 =?us-ascii?Q?NJJKE2s2YKZOeEk+OKvWUrhJNMD9y/WMjxbUS8c9MMWlPH/PhUHbais0rugO?=
 =?us-ascii?Q?lNHIHNv37/wwRXlZbnWnfBZt+R48i7JrNrWfuUZgumjnUVqVW6Y6zeoCQnK5?=
 =?us-ascii?Q?ghbO2EUpP2Oz4kTRJo3zKJKcwZYZIVNWH1SRmvaAsvYzMXvzrN9qSmY+jeuC?=
 =?us-ascii?Q?HeZpDz2FNbQfO5KzV++PYcI4PtJNJ8D0cwNC8n6DJ/WD/bHATry2ItkmCsB6?=
 =?us-ascii?Q?KpUoUrsUbI+Z65/KqDKFMPEubPB+BlHUJo9sJXgXoj+0ofCq9tLjMyRdcnZR?=
 =?us-ascii?Q?8f+NGBCT54UlhmNy6p7XYHlSRUbtPA1oNgR0JQ8Hi9louzwrcF6fdTHEKQ20?=
 =?us-ascii?Q?TarMLtppk40pyJj4p9SE4pHOfI7SflYbPVIIWIkFfeZ2bDCmYhr/8E/1THN/?=
 =?us-ascii?Q?SZ+5BI71LtXiZ3E1y0XqslPeHkSA3FOsfUiDdT756dXwnBtORJf0cdvRVtak?=
 =?us-ascii?Q?JD0nXc5sDyParc3apiQeRhIPztGWkXLcsuHDc2CjuLHRe6C/DEumAZxpw3Ti?=
 =?us-ascii?Q?W0o34Ie8IbaRGKQyweW6BJiqdFOgu2LeESoKf8Gj+cw+PHZeFoIUc2kfqp9f?=
 =?us-ascii?Q?xFsbCh5D1Z9xZ+1es3RY2bsDBSrp9J+gljQjjWvpOJlNdo7Fsl2w2oLRtpQf?=
 =?us-ascii?Q?cMJnPZihRfR/HJQgD++PsSLP/Ng3ZsBTB3j/PQNCacK8N0CjfjRTR/LZLL8c?=
 =?us-ascii?Q?2kWRd8KLvCF5uPW++t2U7o8ERoGHUUzeqUKWKzJSARWDpcQuG0bSkNolAU7S?=
 =?us-ascii?Q?sxPykAJ9HHi8c3zAadU40JR+Qg3uLQ3s34c1KiNk6gSF86nV1ugUEhTfQYnX?=
 =?us-ascii?Q?GBmGd38T8GOWRL+htvol5B6x3cb/oImdRCZ24XbUrEzjghfpYg8ZteU5dJ0L?=
 =?us-ascii?Q?6vn4yWNBRHnX0pWzMZd8EGvRJ0PITqSETG6NO0MvgXREgeFhPC7xAyOPnpsP?=
 =?us-ascii?Q?m263bTxRi5EWgRxkyHBD1VOIKtV8ibpfuEjYvgNqAuBYaPFtUgjYIzzB0IR/?=
 =?us-ascii?Q?yMVR1Z71EPqZT2sTv1u+5Z8hExuYFfvaImMcGQSTiebsjpVaJcMBQ/K5W54+?=
 =?us-ascii?Q?KGZBF79rOoZFf4SeOU6KXMouwlNnJXzYI7/axDq8/Mj48ctTz7gUAt1wMg3g?=
 =?us-ascii?Q?WF8A37r0B0HhB573k4GZrGkohzaQoxYMOpt0JknAqqFVhx6nHQbeOr5RijJu?=
 =?us-ascii?Q?JuUkTSiDHNU/p6dAj4NHL2g32hTrVFzwU4da2azGumn191HJUP7m+55zpZqC?=
 =?us-ascii?Q?YXFmK3vx3lGn77cX7OkVlA0fxj8eAifzITABMpmwC+WTDgNXViX3t76x1lDj?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f8fed4-03f1-474a-e15b-08dd98077f30
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 01:33:32.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KI/xzY2n38jldpG0Y44FiW5ZXGT+jGyImw6PgHhQgELei07uWMsvdAP9s3cuXbTY3rWvQZvaFWzqtixQMSnEYYEVZaO41qTi9vVHSxXo6ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6965
X-Authority-Analysis: v=2.4 cv=ObSYDgTY c=1 sm=1 tr=0 ts=682d2d6f cx=c_pps a=zzjaJ2HwkiRAih7KxKuamQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=t7CeM3EgAAAA:8 a=TXSmb4N2Zo2ZqIVaM4gA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAxMyBTYWx0ZWRfX/1bnitGr3r+Z WAVOOWDElrMiBqufaU9DU/kW8/1oUw+abOdgnFl0C9LrpEXT+oE3Oa/8QpddirTROWszGn9M4WM pZ5OpI66WTLSrn6rS14lNqlYRL6N7Nexl2TCx3hSc9PNk1WvjfeIHVnwwcKTCG6Wd2qoVIHOlYP
 rkFmhFOJx7c3kEVPI+w3psfOspEmXO+wYeRUwxp9OX0QI8YhCavFkRxN2xlgowsokw+SDb04+tH uHKKCJA1jBTUBIYu8GYEOAVpw5Wip9NBX95uFBUXZOuzU0ENz7ytxk7lWmyF17610lFJFPz3dNF UL8i3p8+r8jhEW/cmJukSXKSq816HJPRsfnC6AEOd0fGdA/ICPJpoc7IaAqRTxEvNgzFfs1Wx83
 gjRd/IZAo6l1kcBbz4NhMLYTMOVL2p2xcr4h6cNwCHAf8KPWwJIWS2+ZKuxatUJNdie7/UwT
X-Proofpoint-GUID: z9u3v4HBz6A9sLgxLNPIYcOfoPqm8fUn
X-Proofpoint-ORIG-GUID: z9u3v4HBz6A9sLgxLNPIYcOfoPqm8fUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1011
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505160000
 definitions=main-2505210013

From: Wander Lairson Costa <wander@redhat.com>

[ Upstream commit 0664e2c311b9fa43b33e3e81429cd0c2d7f9c638 ]

When running the following command:

while true; do
    stress-ng --cyclic 30 --timeout 30s --minimize --quiet
done

a warning is eventually triggered:

WARNING: CPU: 43 PID: 2848 at kernel/sched/deadline.c:794
setup_new_dl_entity+0x13e/0x180
...
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1c4/0x2df
 ? enqueue_dl_entity+0x631/0x6e0
 ? setup_new_dl_entity+0x13e/0x180
 ? __warn+0x7e/0xd0
 ? report_bug+0x11a/0x1a0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 enqueue_dl_entity+0x631/0x6e0
 enqueue_task_dl+0x7d/0x120
 __do_set_cpus_allowed+0xe3/0x280
 __set_cpus_allowed_ptr_locked+0x140/0x1d0
 __set_cpus_allowed_ptr+0x54/0xa0
 migrate_enable+0x7e/0x150
 rt_spin_unlock+0x1c/0x90
 group_send_sig_info+0xf7/0x1a0
 ? kill_pid_info+0x1f/0x1d0
 kill_pid_info+0x78/0x1d0
 kill_proc_info+0x5b/0x110
 __x64_sys_kill+0x93/0xc0
 do_syscall_64+0x5c/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
 RIP: 0033:0x7f0dab31f92b

This warning occurs because set_cpus_allowed dequeues and enqueues tasks
with the ENQUEUE_RESTORE flag set. If the task is boosted, the warning
is triggered. A boosted task already had its parameters set by
rt_mutex_setprio, and a new call to setup_new_dl_entity is unnecessary,
hence the WARN_ON call.

Check if we are requeueing a boosted task and avoid calling
setup_new_dl_entity if that's the case.

Fixes: 295d6d5e3736 ("sched/deadline: Fix switching to -deadline")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20240724142253.27145-2-wander@redhat.com
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 66eb68c59f0b..5bb8915b1ca4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1514,6 +1514,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
+		  !is_dl_boosted(dl_se) &&
 		  dl_time_before(dl_se->deadline,
 				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
 		setup_new_dl_entity(dl_se);
-- 
2.34.1


