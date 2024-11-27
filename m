Return-Path: <stable+bounces-95601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A850F9DA473
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B0CB22294
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75790190499;
	Wed, 27 Nov 2024 09:05:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CC18E361
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698319; cv=fail; b=epK/0Q8+9mWwtEy9JUM2XFD9Hrhi3a0zHtbIAufdKMYDPGtNu94agwu4scLBYmpxJtxUVVBq0VfN79gaTIfZ/ZR75Y11tOmw2E0cJhHWM55i1jTagkMlYcK2Ini7elqwu3yiEVjdeQTNi2jyyjW3HEBlbsEonLDAVqcaujuy//k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698319; c=relaxed/simple;
	bh=ZkRt+KTNeac4L8AU7/h4pZaU0Z6Vl/fDvwiD/BfJCuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNEj9R+o6PhWpYrM9C7QPrct24mVB4JENWj6C0M2yNCMap4Mv1FJ7yUgkZOEN/R3SK3h8QdOPPGcp2z0Gwv1CWw7hA6WCGejjtC8ECY4tnYKg3fxgS9kxuBjvt4thW2jOqRdbVgHgxGjN2O5BFXpAKzn4TdajA2QzK9WCi9KXU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR6s3Pe020085;
	Wed, 27 Nov 2024 01:05:07 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 433b79c3ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 01:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiQKAr5MrNaoNy9iEk8fBZ1/g3erYc9MyBJ4SEs5Vn607e1v0Ebjr/dkHOR9hrlB53dziSt3q+MHB9iIiJknIGBgkeIF78xPpE95y/VS57CO22DPl9o1wcsaZfSTxjhj3Q87Ycb9AFMHmIKAqsL+18LTvhjjd4U9KV5JH4NHPifxjKRD/TA7szNcb5BvhjHRjuMKp7Gaj6hiq0wFIwf40cOUjpU4dxzUziuq3u+mGl6Equ1DuQwxN9D2GOfhIvwT2DlZhWZsch5H92uDbQ/huL4efnjKSngUyjibWhDiO7XHACiHqqk1pOUB7SKr+uAa5cdqpsqkcJE8BeuKc11aow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmIUyrZyM2SjcfapW9jRDtMJ6u5eMKaR5J04iU9tZ50=;
 b=GtQWEfaBm7W2C+A24YzqOHAZ1sBYTsBBu90uxbpCDQiulI7a6st6WcmaWRna2Bvm64gffnpzyat5OUpaSkH5vMxHzbVo1NhtP/zIc1Tps35gDLi+f5lpbLAv/R0ADIvCakbTha3mhERAXlMv5sPGp/on0cptXPI+WrYoTM055bqiiHVoBiWVeiCHKQpjoKBBqCpwjX5Gjkgo0P14xqugddaAD0DctqpfTOBxh1eiVKQgixj6Cg78Sv6SEnaEUbERE4WiTOlFhIVJiscRrE1xAH/GAi7STGYiNcRltLCsntumPgPUr80WTOvg7zixTqSHTVB7R23xyEyNIfeKamwTRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Wed, 27 Nov
 2024 09:05:03 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 09:05:03 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: justin.tee@broadcom.com, martin.petersen@oracle.com
Cc: stable@vger.kernel.org
Subject: [PATCH 6.6] scsi: lpfc: Validate hdwq pointers before dereferencing in reset/errata paths
Date: Wed, 27 Nov 2024 18:02:37 +0800
Message-Id: <20241127100237.1138842-2-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241127100237.1138842-1-xiangyu.chen@eng.windriver.com>
References: <20241127100237.1138842-1-xiangyu.chen@eng.windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0033.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::17) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|PH7PR11MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da25c2e-ba4c-48cd-fe40-08dd0ec294a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B54TxCpmo4fynT3sws0X4Sf/5EICuylM9eLorW2DebfVDLhq5RmJMnJZ8r1L?=
 =?us-ascii?Q?mUX6PlAFPf6NYPrgFEXQp/bJ/eMCMllfTSfjab9lqGD3du5Msc2THUyd8hS5?=
 =?us-ascii?Q?28nIYaUlIUwaYzA+AE2nVBm8EJSLlBvKS0/50tzOmRIWhrr6tMSXZrd36OjX?=
 =?us-ascii?Q?nu1LOAPweqk1V3XnjjrdnKW+8KMu7UKEKDWSWGaCk/GPLCEEgIAxY06fDAqR?=
 =?us-ascii?Q?NPM8vboju3P/PzBoyMe37CYfIKUPidBLuFfHjq6JH7cW7v3w1U5Wq3S9+1zP?=
 =?us-ascii?Q?DdnTc8wQIbUhK1p//VM4kQNgCXkzuzMbYG0c7yy62iyzutGH7glGCWPgrxDJ?=
 =?us-ascii?Q?PYilEaQ8i4QxOHpMO3vSepvV0zhR77DazJfQ785UiLdsIMO6oTFOwOeZrYjx?=
 =?us-ascii?Q?MAx6ZWMCy9aN5arLPrINP3e5QPMiMNBnu3GkYDouWCIO0ZG9Ml8cms5VcIii?=
 =?us-ascii?Q?UoJkUzU7szTXB4OZ9fusPr8hc3eF1CCQ6/XN7/KnZ7UWIb+acGq/WMD4Zs1S?=
 =?us-ascii?Q?XdCQKTK82iEX7nyOYztpnhZIUIO1E2L1zfqbNUrxAhZknWfVmcVSitcJ8BE2?=
 =?us-ascii?Q?mSOX+l2upLgHPnfGObgQL9TLakzA/fKaYuoi2bHHAXCZ20+xksZMq2uPwtJf?=
 =?us-ascii?Q?0RWwHnv88G3AIvAYj6ZjvNN3Pn3mn5URMUkdMCLgXUv8supPCaKUdG2VzjsM?=
 =?us-ascii?Q?HPaEf2qdfePXG5WSy6a08qBwiEN/AeNvCAv+CjNAvncJWrMtBXcRoVovK/aY?=
 =?us-ascii?Q?2F5XWZhcSwiGONqBqJpdb4K5lmmxaGejV1o2NEnWuMmMBPewvsX7JetMREKC?=
 =?us-ascii?Q?/1eTCuL2fk+1sezfVZVx5Ak0EsCMFn7LR8zzuiKp2qnoRtaFC3RSXgH0A6rT?=
 =?us-ascii?Q?7Y+KC9BrDHL55Gy58PAdnb6WVGakn8BYrp4d6W8QzG1ruUaPrJ/5Lg0bYzgR?=
 =?us-ascii?Q?6OD68faRQgpPiDJ2j9qIcb0nxO5SgZY2Dnk7NMTf5UqQgeI6VPXgZcABEwOY?=
 =?us-ascii?Q?4kkly5vPyEQ1UxMrTY8mamT0+N2V9Eq+ycgHEhGY9oxxZN1SV0SbM2Un7g58?=
 =?us-ascii?Q?BxMRXYvZ0qn8cQPOzsorIW7RiheqECQMVK5KUZ9bwDSgo6PHp4wB/wMZKlAY?=
 =?us-ascii?Q?R30Sh1XL7k/DUJhpygwvMNG1o9IxkmoXnRz2d9yZEyIwTta9NeiogrrtUv8j?=
 =?us-ascii?Q?h2FwJ/wDNlUnfg7m++2KqVx5PcQ2JE+kCy8XtdUnr+94LOI9uGzR2khqdy1O?=
 =?us-ascii?Q?4N5diSjhmle+88Ikt8jphhL0IRhPChw/yWOwNHGX6ohBXts4iFK9AwFTl+mu?=
 =?us-ascii?Q?ZggUQTabnkMDdv6HVcNx5HL88mZplHliqTxV3wiNW3LFjS4RYGYeAn+C7t/1?=
 =?us-ascii?Q?yHXKo+r30Lpek+XDh7BDPg2sYIKvLIFUoY+UoLH4RWZhB+JTlw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FOjE3vV0I75gJz/TiftGgRizrOyPkeLcWLy3QI4hTBFEFhalKub2sHcFHIr4?=
 =?us-ascii?Q?d4Qqmqj+0E3EZFXJx72OrZTJjjk7P1phLsampc6zlnS6N6KCD7c5HRemnbXl?=
 =?us-ascii?Q?PgLa0aiGe7KiusL2pCN/Bhn0dr2lyxwD2QtsH7jdf+CPFhWG3LSe2we5YX0F?=
 =?us-ascii?Q?Gqlc71XzUbMdnNnmX2RinUSifO5ZqldncauilYtnlZh2yXctXPRI9obaDjoM?=
 =?us-ascii?Q?1vHyYLjxZc1t6Ueiz2qdUVh8er7n9BVJcqqdbNoSAo3CONLX/vIzOX9qo+gD?=
 =?us-ascii?Q?celf8Cse5y4zTP3dfUxRYJnVTx7IRx7xndwiITYnnRpyg8VQfToesiwRJpqV?=
 =?us-ascii?Q?fDBn3+HtehQ1K3BWQFQ6mmNZGe3xINiBr1u6Ol73ZTtpTo0EYtkOzlKIYd5K?=
 =?us-ascii?Q?xFd+lbKpGPHx7pdjetf0g2boGZ1irrpMAp+Ke72ByBLL9U/BdMN71GU6hLJg?=
 =?us-ascii?Q?3n9+LJL50z6shl82xM5N6kaSP/5VEGBZj9r/W9PHUcDSXzIE089KLrha20QY?=
 =?us-ascii?Q?Imprvitg286NGCvf7hMy3IYH8MuScbI9w/Qbl97UhgeRWWR0k+q6U5HIFNf/?=
 =?us-ascii?Q?phHzbgQsIILCLFxuIbVUQCBu3AdQy/ULoUIZtH1+l6A+6A9Nuk4wOkyjofgz?=
 =?us-ascii?Q?W2mkFvNHeD90PK45y+/H5jfVaaPv4HwjJ9Bsl4xt2i84J/38VWqmcbfhrSPs?=
 =?us-ascii?Q?BCeURwsBoHDP/fxSyOdrjxokM28i03bBou52tnMlnX/wtBqr/uZj49PlVq+Y?=
 =?us-ascii?Q?XT0GKhzmJcUbEuLfTs5KFJRxjWwwddgjtfRi5nG4GY62VeQ30PlQyghi39Qi?=
 =?us-ascii?Q?vWm80oqe1pMJAV86XjbdFWFiQVQjX6rBFneBnsXA/OEd1SFBxTPLdg9zE/Ae?=
 =?us-ascii?Q?Z9fPLhdiQJdKyOEkBusI0KJ8rmEESPHnkrlS76vD8T7cMweRrFSdoKC1GJVf?=
 =?us-ascii?Q?8o3YnIjlGLNTjSmQcOrreiMEaU0VDmd6H5Qu6NvhKsx4TmFqXf3PWfxzJlXC?=
 =?us-ascii?Q?4cWxo12MNZOZalCZemaOADO4epnAwOsJL7IaQrMWWXPA9WK4IHlDSUR9+hyF?=
 =?us-ascii?Q?zDgDf8gZHBlaC1k6kGx0ToigWqPo+bi30X5wtCd38jKVqim6qoem4gvkSHnx?=
 =?us-ascii?Q?L8c3J84DtbzFLsFz3IM3QPxhIgnQ7M7MNkx+US2280tUgVk7A4XBLAbPws+2?=
 =?us-ascii?Q?mvMf8mhk5RKd99N6XK/O6nDSYRT3+2Fm/+XQ5q7O2mcfZQypzjUvNo89shZC?=
 =?us-ascii?Q?7J94G2kqsAv/3TYC89P4YP+1LHdoGEysbM5YljqhD2zoIHKsH42HrntlaUSd?=
 =?us-ascii?Q?QJiGBra+rlES0QXr9D89BvqYr2mylj+E1NbC04tZ0NPDAn9tuAp9xIpqCcuc?=
 =?us-ascii?Q?5zIs/GAcKahoc8jPsEvnxYZap4r52K0jkr2NMUsSJmPwsQ7bbthRcZcXxtdG?=
 =?us-ascii?Q?jYS+t1xqY3j5wUHrmBS6nIrj6D83SG71vZEj4wMQWGSgSqImc28LJeDHqCFa?=
 =?us-ascii?Q?Jr8EL+Tus8Yuo1fVnnXmrIGgkLu5azMS060JC8nqeNLYjrMR3YoCODdsN4HH?=
 =?us-ascii?Q?qOVSoxCsVPQZ2MuU/DGs2GZO8bJl/nyZwQOoAapU/a4QrlBfKqVeKKzPaeLB?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da25c2e-ba4c-48cd-fe40-08dd0ec294a4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:05:03.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5aaLXE0bAXli+4FixHaf2xU+VTIUsAJKwYKDCK79gFv0j4wgIORNL/+c9xtl8izgOMSaZ8tLXbGEU5CY+/aNDySJ/AwtexsKNB5Qi2yREM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-Authority-Analysis: v=2.4 cv=atbgCjZV c=1 sm=1 tr=0 ts=6746e0c3 cx=c_pps a=2/f09Pi2ycfuKzF0xiDRrg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8 a=t7CeM3EgAAAA:8 a=rxdiJbMI3mzlZdFzvH0A:9 a=FdTzh2GWekK77mhwV6Dw:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-GUID: f8EuhZwP6bVZG_k3lz0JAxgSM2TAm79x
X-Proofpoint-ORIG-GUID: f8EuhZwP6bVZG_k3lz0JAxgSM2TAm79x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-27_04,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 clxscore=1011
 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411270074

From: Justin Tee <justin.tee@broadcom.com>

[ Upstream commit 2be1d4f11944cd6283cb97268b3e17c4424945ca ]

When the HBA is undergoing a reset or is handling an errata event, NULL ptr
dereference crashes may occur in routines such as
lpfc_sli_flush_io_rings(), lpfc_dev_loss_tmo_callbk(), or
lpfc_abort_handler().

Add NULL ptr checks before dereferencing hdwq pointers that may have been
freed due to operations colliding with a reset or errata event handler.

Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Link: https://lore.kernel.org/r/20240726231512.92867-4-justintee8345@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: BP to fix CVE: CVE-2024-49891, no test_bit() conflict resolution]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c |  3 ++-
 drivers/scsi/lpfc/lpfc_scsi.c    | 13 +++++++++++--
 drivers/scsi/lpfc/lpfc_sli.c     | 11 +++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 0a01575ab06d..0ad8a10002ce 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -175,7 +175,8 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 			 ndlp->nlp_state, ndlp->fc4_xpt_flags);
 
 	/* Don't schedule a worker thread event if the vport is going down. */
-	if (vport->load_flag & FC_UNLOADING) {
+	if ((vport->load_flag & FC_UNLOADING) ||
+	    !(phba->hba_flag & HBA_SETUP)) {
 		spin_lock_irqsave(&ndlp->lock, iflags);
 		ndlp->rport = NULL;
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index cf506556f3b0..070654cc9292 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5546,11 +5546,20 @@ lpfc_abort_handler(struct scsi_cmnd *cmnd)
 
 	iocb = &lpfc_cmd->cur_iocbq;
 	if (phba->sli_rev == LPFC_SLI_REV4) {
-		pring_s4 = phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring;
-		if (!pring_s4) {
+		/* if the io_wq & pring are gone, the port was reset. */
+		if (!phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq ||
+		    !phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring) {
+			lpfc_printf_vlog(vport, KERN_WARNING, LOG_FCP,
+					 "2877 SCSI Layer I/O Abort Request "
+					 "IO CMPL Status x%x ID %d LUN %llu "
+					 "HBA_SETUP %d\n", FAILED,
+					 cmnd->device->id,
+					 (u64)cmnd->device->lun,
+					 (HBA_SETUP & phba->hba_flag));
 			ret = FAILED;
 			goto out_unlock_hba;
 		}
+		pring_s4 = phba->sli4_hba.hdwq[iocb->hba_wqidx].io_wq->pring;
 		spin_lock(&pring_s4->ring_lock);
 	}
 	/* the command is in process of being cancelled */
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 9cd22588c8eb..9b1ffa84a062 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4684,6 +4684,17 @@ lpfc_sli_flush_io_rings(struct lpfc_hba *phba)
 	/* Look on all the FCP Rings for the iotag */
 	if (phba->sli_rev >= LPFC_SLI_REV4) {
 		for (i = 0; i < phba->cfg_hdw_queue; i++) {
+			if (!phba->sli4_hba.hdwq ||
+			    !phba->sli4_hba.hdwq[i].io_wq) {
+				lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
+						"7777 hdwq's deleted %lx "
+						"%lx %x %x\n",
+						(unsigned long)phba->pport->load_flag,
+						(unsigned long)phba->hba_flag,
+						phba->link_state,
+						phba->sli.sli_flag);
+				return;
+			}
 			pring = phba->sli4_hba.hdwq[i].io_wq->pring;
 
 			spin_lock_irq(&pring->ring_lock);
-- 
2.25.1


