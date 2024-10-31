Return-Path: <stable+bounces-89378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2019B7266
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 03:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BC51F250FF
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 02:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9D081AC6;
	Thu, 31 Oct 2024 02:11:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC89D1BD9F7
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340695; cv=fail; b=DKeelHLp7UsubzR++7AWcqC3Lj+duIdKJnT6x/7pbdYLzNcARPBfeUaDgcjRhdapF4RXP9mYYv28pb+t+mdky7W9/zk3rfOJgx+dO5xnNLi0//v+36IxnZPmYZdUtkYUXnxDcy7X1DUyDdqt03yqa8sDMtF0oSFLLsKpAnITuNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340695; c=relaxed/simple;
	bh=5BvX/tLM0BoSHlJblYWSFh35/Awy5eCE1Uww+FifNa0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NxDoaXpVC17kBHguka/j9tAT3vf5OBF9ckeNR45g1HWTnGlAUHuE0a4aY3BCCtLhZbLxFzEJMlBIyfkP6dz2mKxTFv5KDWy4awtIq76dgXTw+Rf7InF9yuVJYeGj1jMHMcR9E+kdLGR6QtfXOxbgeWcbjF1//G/6dc5XkvesPpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49V18qI3026147;
	Thu, 31 Oct 2024 02:11:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42gqd8nstj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 02:11:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSJz1HmvfaBRNARqr+/3fafsr4hey+qWRfq0WNATF0JXnRs1qkR9yBd+cDQ9x6mOp5vejEZ0HxvQwBiMGkOK16KYxaZ/rc84ISmxDrez8UPrS7y7laDoVv14XHK7Bfd7bFclU1mjjAN3pa4UNQo90LZvvctok7tHnw0hwajGjKji1PA2EjyUhooOBNXc4L9yyqEi50ppNxDy3AUVg9J0hPa+xUXqGSEoQIyRcqkE9d3NCv2pNra8lmUMuFEjzWfsYisZ9DDMRRa4gCOQv4QIuPApGDZfS8Ekj6nPVenxLJ+aEfhffDZt4RVdFK8BfNMLkrY7MB84MAwPRO298D222g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lvg1ukniq47RbdkMmO++ggTbbsM7pbpA5JNrwjv0z0=;
 b=jlyEan4Ifpv+IkrJLd0kA4KqmcetFLdLs6x3A6Zg5LUuDd0tjllMoIy+i5Z3rYUHUOGOeJRzLx2jESQPQAUSUUnv7isIzNFrv9vy+/IgVkZh1W4jxRGaIpUdDp3w8pg3tm+cBJKsNINCPGEFuBqxbY+IQ/aI0Ol2hnzckKQvYZ3UjDkzZ1O+Ou5EWToQwre3ONTlU+iJp9FWVZoDkSCocKr/TtoVc2JsKvod7oX2FsGnOq0qlfwnETKwy180z8GYeaOn7iwRjUg5TybuAduzACGpBe+L6VuCQkdp/zrhpxQRApLA6a5OMEnPfKurPuK9MG+skbw7q/XbOLU3q7yRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by LV2PR11MB5975.namprd11.prod.outlook.com (2603:10b6:408:17d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 02:11:06 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 02:11:05 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: mhklinux@outlook.com, rick.p.edgecombe@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        kirill.shutemov@linux.intel.com, wei.liu@kernel.org,
        gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.1] Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
Date: Thu, 31 Oct 2024 10:10:44 +0800
Message-ID: <20241031021044.1838730-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|LV2PR11MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: b9604f5b-6db2-448b-9a7a-08dcf9514679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aAhuyiEgltNKcRZ5pD/zG6r3r2mxSJw/uIv1vO32ALetEgGZyZLvom7jZJHn?=
 =?us-ascii?Q?Ck7Hp2SDzox48COIGLTeXW/oVYIxi1glpnchcPwPD2QHVhLNHHXhsJCheOGV?=
 =?us-ascii?Q?5WnwBKNVQzlUCveSFr60Pl4GNkDtcPQ4STnvodLrdvZ/fl8geAxVR1Hv1Exf?=
 =?us-ascii?Q?3WYqnOWBJtRx5mBj3m1I2PPAz0Rq+1+oujEiCCB2jYvh+hEKtKySVq0bzeum?=
 =?us-ascii?Q?TtuzfugXkkwZyoaNCIpIVGyYczz+Zz3SIuhDAJBFdmjwRLIYtCcD+tOQzOL7?=
 =?us-ascii?Q?uj7ge7aAEz/r097k9OPGMKsTZxO89/GMsBJxMd0R7m/1uJgQF/FJHRuGiyVl?=
 =?us-ascii?Q?CbKealsv52vsWodoM4zlPUJy/PHAycKuXYU17yTAlNfRTrZxaFByu41nJZF9?=
 =?us-ascii?Q?0thcwMKJmhqhBtOIo+FDVmvK+agXYWqqX5euT3W4tOFHUud1E+Skmp+fEz/p?=
 =?us-ascii?Q?eEyUq4AeMZlcK4BuNSK/0622GzXFOoaZ3rxMWGmPt01ToUunqXfMRkX7cpdf?=
 =?us-ascii?Q?3GXxmnXYv+lYQEEzJZh7LBie+QrbHiG/gvsiIbxvkcYs6UiIIwzLybp9FXu0?=
 =?us-ascii?Q?+TV7SbYfysEw/N/BvfhVibs+TRO3oyVdu5I3e+IqR7+ATiMGCsuoubwHOJCD?=
 =?us-ascii?Q?t+xK0QfuwWaCVL1Dowggg1gm0hQ09l019d2Z2+dP6idpt7d/oFf7l2/BqKw6?=
 =?us-ascii?Q?TGX6c2wOBzxQPQKgOyRecOdSwhqajdP3vT0zJ7kNRhVWm7MkgcKyOJBiAaba?=
 =?us-ascii?Q?PeUoWaMSlL6/cUMqiRYaFTwaC3GgDu4+GPN5bOuqu0q8/Qd7M7xbGT04/Uw4?=
 =?us-ascii?Q?QUx3hvG8rr63shzA4qyFcwn1vo7ZQ/t7hLPv2jqrhfrTLAVRHut/LAMjiHCN?=
 =?us-ascii?Q?6jrgb9OmqJZwL9oR6RiUFen9i+NKggoLBA4q2qxJAoO4njysHzhcmDg0tb9q?=
 =?us-ascii?Q?jMsU86NbPKkmvIE2c+mdwcwzBkkuFwpYUzAvO/JAxFyfBvUqM+1jhQtK9h9S?=
 =?us-ascii?Q?sHFzUMJU0bBra2v8L9Cj1nnE776oSGEklMEkvxD9IMDWQZb8ufqUcRv0dVKm?=
 =?us-ascii?Q?X7Pt1dSlWucTa2XDNgPxqMjinALuHC9fybvD6Os+l/0ZestC5zT6NRCL1Fpi?=
 =?us-ascii?Q?MfYGk1Mk5nzMdgU1xkb64y7aRWg54V4UV/0oSdKBHUYiWYkqozCZ76+t2dS4?=
 =?us-ascii?Q?NwTbvrVIXWnlsVv/1I3PedTx/9b4P8HztU17E5zM8JZg1t2LGkD/nce8FSmW?=
 =?us-ascii?Q?SKSY/c+uEcT6vImFloZXUVHcobXTPjXnuYWj2klT/joikXw2fjOACl+x1EP4?=
 =?us-ascii?Q?AaPZSfqbrTb6CJkG4LlPJHy326OQLyrz/zCCLhDQeWoRDYD38akFEBIMcf6E?=
 =?us-ascii?Q?UQ/O9AT8fDE7OH/EKnxBzdSr00oA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SupZVQY6DGY/EV5dWmHS9NEd3aFIO2Z7CXGgx9e1OkjbU79/8j7IUx3sAHsm?=
 =?us-ascii?Q?kTmfhIHz6L0gs75ZzQ7B8sBW/wY4gU2waHqSFJS3ewZS0l24D2+hCIhd2Kb6?=
 =?us-ascii?Q?1dXmt0SipJ7i5XGnAzq0K2Gjgk0531l2ti6+6ByeoiUkHU52h2Z5JmjjNzfn?=
 =?us-ascii?Q?xfkpDDXF599j6X3KXVrdfuF/P8Ydlkzv5NbWOMBW/W4JP/vC+nXkYIXo/o8q?=
 =?us-ascii?Q?UysYq4ZSrsNNHW2nIhxxn6wlhH420H07xOzf/g4tcKp3zIlliHf0A5BRyfSN?=
 =?us-ascii?Q?O+aRf8zn57YWrN4HiiY+2rEOGA5601nKBIHy+fhF0DC6f+QoR0gcIq5mkcVN?=
 =?us-ascii?Q?Ufp2rnIIfOLpY0egUnsuyckvvxTwx7o4QmdXOnt9wVXbh0SNU9Khqz2TXuu3?=
 =?us-ascii?Q?mDLLVtKiWydFo7WxhOBQIeliDNPVY1shctnLxSYEin63ZvG53yQReBjWv17R?=
 =?us-ascii?Q?xKPvhmuafHD3/dAY7LrnIfga+7WBCL28V6B8nIkgf55gTBB6XDuGIyZZqCjY?=
 =?us-ascii?Q?PcEc4SR9JW/b2h8hwuBFxd8nMC/5LFD+50plEMhoLj4ywZ+qMkMsFNXq4lF4?=
 =?us-ascii?Q?lRcCMRvuwxTcHRqjyvSmE7B/ReJbYPbjTMGEs2YesUw4Hiz/toO0HLqhvstW?=
 =?us-ascii?Q?D8k3JMuvSRVHj1V5Yn/x65laiOONlVsxMgB+75ePMaFVvFGMSr4OWS8pAsz8?=
 =?us-ascii?Q?2AefFk5zXxoFQPZ9O773amwVr/fO0YZuCEXt3Vh+orBmy2IQLHxT3zSktPpJ?=
 =?us-ascii?Q?vTvGFgBluoLuXlwnOCuv46qGR/SchSToHpNeq/7HpqijU778IRsPxpZqQ7sV?=
 =?us-ascii?Q?MWLoVqa6Sp8o6fMQjes+V3B6edbr4Fm3XmSc4zSQPI1CW4ZLHMN4smZ/5H5L?=
 =?us-ascii?Q?6RPI01XV863fQjAb2109arYD89dpiaMSZdf0gocLNNCDU0IodblR6g+PUIwX?=
 =?us-ascii?Q?rzAp2Lt16AyDkAJ0UD5W2bA6kCYTXNSClCcrpTBD42Udg/+kP6dGts6dmk7M?=
 =?us-ascii?Q?C60UPXcnYp9EUMIiOw6MfAyjFnY6M8tWJb2F12bntRbQ6g5C4yDpKGSuGF3t?=
 =?us-ascii?Q?f/jVEfanXcmZs0iT5X7ipvY1EkDWEuwEkHc5dR4Jav43Nwo2dLGFf3iQ7DG6?=
 =?us-ascii?Q?UOgpRWdEy/Uftq6p0zZPZAdf1d0ZdCOoYhadzYTMStNzjSHAEjVPTQmQqf5I?=
 =?us-ascii?Q?+uCHEZoV7ZSt1N8NKy91duIine4/FPVPXXSnQ64FuS6PNUWhJqsz+CRP7AaF?=
 =?us-ascii?Q?uBs7Sk/7iBfrUDywK+O0Bkq5t0fSEJ837dIPA5IXL0kTC0cflWbjJMUY19oh?=
 =?us-ascii?Q?KIYn4HOlAe6dXGzlAkGBG9hwuR12BffVwS/6Kl2ZmQE3f/OVJWX4StZhRUFY?=
 =?us-ascii?Q?jj/yIxGQSABwbIMn1f1trFadly6I6xh/RX4z9zX4QJvY1/HTOOJyH6bzKsr9?=
 =?us-ascii?Q?PdruavtFoUXpkyp6c4qZgssSNXLDJfMDj6zyN6KBnZuxflF3IRKL2t7ZPzOZ?=
 =?us-ascii?Q?pgqP4YYzGyA38Q2PYQszBoTXmrVTbufv1qGFZmK4Ryy6hWgANKO+W5ZABmYf?=
 =?us-ascii?Q?iXu6KHsaYGtj/4MQVFkPesqhrn+VIA0om4zbdzVfjc8aprz8OwVoy/zxtIX9?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9604f5b-6db2-448b-9a7a-08dcf9514679
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 02:11:05.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKrn6tcnxlV95ZW0JTn9KeYnpagEyzHa2ADYcdK0F5eQbsxGr5ibgpuVG+sv8pk9QNi9/hVgexgjE3cajaXOrFgPaGYOWnZTsoNqzgh4/H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5975
X-Proofpoint-ORIG-GUID: IEUvfK6-j75P4IW5bTGTMaYJ13f3M4iV
X-Authority-Analysis: v=2.4 cv=dKj0m/Zb c=1 sm=1 tr=0 ts=6722e73f cx=c_pps a=1OKfMEbEQU8cdntNuaz5dg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=feaVok0oc58xApDyoqkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: IEUvfK6-j75P4IW5bTGTMaYJ13f3M4iV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2410310016

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

[ Upstream commit 03f5a999adba062456c8c818a683beb1b498983a ]

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

VMBus code could free decrypted pages if set_memory_encrypted()/decrypted()
fails. Leak the pages if this happens.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/r/20240311161558.1310-2-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240311161558.1310-2-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: bp to fix CVE-2024-36913, resolved minor conflicts]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/hv/connection.c | 66 ++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index da51b50787df..23fb0df9d350 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -243,8 +243,17 @@ int vmbus_connect(void)
 		ret |= set_memory_decrypted((unsigned long)
 					    vmbus_connection.monitor_pages[1],
 					    1);
-		if (ret)
+		if (ret) {
+			/*
+			 * If set_memory_decrypted() fails, the encryption state
+			 * of the memory is unknown. So leak the memory instead
+			 * of risking returning decrypted memory to the free list.
+			 * For simplicity, always handle both pages the same.
+			 */
+			vmbus_connection.monitor_pages[0] = NULL;
+			vmbus_connection.monitor_pages[1] = NULL;
 			goto cleanup;
+		}
 
 		/*
 		 * Isolation VM with AMD SNP needs to access monitor page via
@@ -377,30 +386,39 @@ void vmbus_disconnect(void)
 	}
 
 	if (hv_is_isolation_supported()) {
-		/*
-		 * memunmap() checks input address is ioremap address or not
-		 * inside. It doesn't unmap any thing in the non-SNP CVM and
-		 * so not check CVM type here.
-		 */
-		memunmap(vmbus_connection.monitor_pages[0]);
-		memunmap(vmbus_connection.monitor_pages[1]);
-
-		set_memory_encrypted((unsigned long)
-			vmbus_connection.monitor_pages_original[0],
-			1);
-		set_memory_encrypted((unsigned long)
-			vmbus_connection.monitor_pages_original[1],
-			1);
-	}
+		if(vmbus_connection.monitor_pages[0]) {
+			/*
+			 * memunmap() checks input address is ioremap address or not
+			 * inside. It doesn't unmap any thing in the non-SNP CVM and
+			 * so not check CVM type here.
+			 */
+			memunmap(vmbus_connection.monitor_pages[0]);
+			if (!set_memory_encrypted((unsigned long)
+				vmbus_connection.monitor_pages_original[0], 1))
+				hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
+			vmbus_connection.monitor_pages_original[0] =
+				vmbus_connection.monitor_pages[0] = NULL;
+		}
+
+		if(vmbus_connection.monitor_pages[1]) {
+			memunmap(vmbus_connection.monitor_pages[1]);
+			if (!set_memory_encrypted((unsigned long)
+				vmbus_connection.monitor_pages_original[1], 1))
+				hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
+			vmbus_connection.monitor_pages_original[1] =
+				vmbus_connection.monitor_pages[1] = NULL;
+		}
+	} else {
 
-	hv_free_hyperv_page((unsigned long)
-		vmbus_connection.monitor_pages_original[0]);
-	hv_free_hyperv_page((unsigned long)
-		vmbus_connection.monitor_pages_original[1]);
-	vmbus_connection.monitor_pages_original[0] =
-		vmbus_connection.monitor_pages[0] = NULL;
-	vmbus_connection.monitor_pages_original[1] =
-		vmbus_connection.monitor_pages[1] = NULL;
+		hv_free_hyperv_page((unsigned long)
+			vmbus_connection.monitor_pages_original[0]);
+		hv_free_hyperv_page((unsigned long)
+			vmbus_connection.monitor_pages_original[1]);
+		vmbus_connection.monitor_pages_original[0] =
+			vmbus_connection.monitor_pages[0] = NULL;
+		vmbus_connection.monitor_pages_original[1] =
+			vmbus_connection.monitor_pages[1] = NULL;
+	}
 }
 
 /*
-- 
2.43.0


