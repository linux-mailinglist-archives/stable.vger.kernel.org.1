Return-Path: <stable+bounces-100299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65529EA8C2
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 07:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF25C163C48
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC3E22B8D0;
	Tue, 10 Dec 2024 06:26:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F4B22616F
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 06:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811972; cv=fail; b=LWt9YRSjMo8fObXyNx3fjSDN8NpJTgC1xrQFkW1HEBpsF8er+wPNvFADNcYyhvCZbQt6eqFElhIY9mGK82GlJvGk39wnC24TGOu7ACIpXZ9roWMGQM0PUc5nJv562xWpLjZv6EkY6t9at1C6p4oSlA3zUJ76ZTc3egjXYHfUgXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811972; c=relaxed/simple;
	bh=WVrbJdJP7dmUUcOe89ATAJIyrMtMJ/QX8ZaD4INdLBo=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BRTyEUckIlrDtVNG4ZkIBfqIbUvzCLefMtI5GeDDfTziXjhirFDVahXJQ8JG7XJbsYJDeSlvXPqj7sNaUqx8LbxaaSTDmeqHF7pC80BdYp6Ah/C6PEMP2jK4S3Hp48V5fW+HmcAF+YVkzahnp7nvCQNGON0aV3BB+xN0X0oVrzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA4mpV8001534
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 06:26:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3jbns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 06:26:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgkRRGTwlih3gMxSVI2cd8PIcBeZp3c2zt0cvbZJiscZ7dOcV4ZhkLrTEtSJKIz+uN+7L1J2UVSHUHjjRU4f1y98JNIUHNLgFYPG90QWYtl+636i9mIGO9uI7koywJ3ZyYzOaDfB7O3hTcx0ACN4nAVJcY9Kmuwiy/NCATbQc9xIChd9n72fw0v0T5FvbF9p2jP5GPfFF8geZr4DpdfFozzwFlG0MzpQtUk7/1c89dIkfXnji2Xn7/fP97owmlMKe5uJHGlWgszuLR19lmAMbfpLf8oEHFXKLssAGFqfk36ywttdzVyOgIDZ4yTa7uXBu26Q5YkRPyEQdfwpWuGYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHwCrrfFyFJOEEgar7OSwX18gys90GJdhHIuURWMaZU=;
 b=eK98XmmlpbbuLh404fspRR5+Qa/eNQ8rju/mlznRpz8sqKl6qEiUp41tjcxOsAzy5BSyf87hshkUPW3+RzRhy9cFwZY9E03gqSq4B8IeouL2ryfzRSRXxipSEI2/vYh2krcfwxRaTmUigz1LofRfVBekTfhNThKNoAZ322IggrUpiQcFx6KkZ8QCrzo3wyzLS67TXZvnv/7eDgkPmN9fzvoMyi0NMqrDiPQR5Hj09yrEJ/JeCvHA4C00qiOte/DKACq3D2nLd7pyUKjYV7JXluVsz2L/n49Y9A0RV1Kb+SkzxSY5llNh8YxyQp6w1hCGCuN9/apiKlFG+ZdWQpuBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BN9PR11MB5354.namprd11.prod.outlook.com (2603:10b6:408:11b::7)
 by SJ0PR11MB5151.namprd11.prod.outlook.com (2603:10b6:a03:2ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 06:26:06 +0000
Received: from BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d]) by BN9PR11MB5354.namprd11.prod.outlook.com
 ([fe80::5e9:ab74:5c12:ee2d%4]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 06:26:06 +0000
From: libo.chen.cn@windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] fou: remove warn in gue_gro_receive on unsupported protocol
Date: Tue, 10 Dec 2024 14:25:50 +0800
Message-Id: <20241210062550.1341881-1-libo.chen.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To BN9PR11MB5354.namprd11.prod.outlook.com
 (2603:10b6:408:11b::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5354:EE_|SJ0PR11MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: dc58482a-286c-4585-e829-08dd18e38738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+t1ZGV/Xv+mnSBYUNiUXtHWDTGACvk7dms5phb8M16Vdjqh5GNB9WGFb6MuL?=
 =?us-ascii?Q?3cQHvdQBdDzDvud4EIxUr2l3bT36MGeZpgmVWMXlwiIlKCtNXi5/3HoR+w2F?=
 =?us-ascii?Q?j/3lVFUPKRTcOg/SQNCoYEZHbvTUoOyyvD7eHMAo3URRABNCGY3T7vHB+Weh?=
 =?us-ascii?Q?Q3WKu04R9+JdrxmPZC1orNfsysJUUvom0ZVXz6lVZurW4jp+LmSJpjy8kOTf?=
 =?us-ascii?Q?JWc9jpoCkuUd592rtfCZG+k5/V9GeQeapXPUYKHL9tKKgIGkc146LRnJADI1?=
 =?us-ascii?Q?pGiOtXYklB4rWU6QOfj8XM/0Cz/sr3KYSh4XDdl46AwDJar82QIgtFrYr2Iu?=
 =?us-ascii?Q?iaDPk7qvlIPJ1hyfLvnz9soxAMIfsjHCAKjbU5UX1Y3GPEwRcI3aSryV4KQg?=
 =?us-ascii?Q?P0CCNQq6DHIyGOujVH5WwWR9fbtUBdYNdbol0rSo7DX9lgW8YTBWX8ieU4dM?=
 =?us-ascii?Q?vjegc3n8SqhKTagPvGCVQRPJ6xCplFnZkrxA5UrvvER2VVPRbkJqPVUsK7pK?=
 =?us-ascii?Q?qz1aKlNgJ8sZL7aoR3dmCTUCgFI1jClJ216eR6LDGv+txbRBaIwdSTVF/FyJ?=
 =?us-ascii?Q?LCz0ieI7FJa2JjcnmhOIJg7+Rajmg36BU3zs8bE8nfIw1J1RERm/GhUZmivr?=
 =?us-ascii?Q?qTgmjBOlfICW+B744Avpksd9aSZVBc8krkPINi2D27trTue2o/3apxFh5IQ4?=
 =?us-ascii?Q?ZMuJbJFYEVEMVg0eBNqMr4Pb0kAwPjHXbPgLiEJTJjHsm8FiDkoEM/2sjZqb?=
 =?us-ascii?Q?u+MvWTR4lkh6aC23NNp7B1H5hrbw2q6QrbioX5dDRp0k46LKiLbVapnmXmzB?=
 =?us-ascii?Q?3Q27e2HWgx/CxrVDXyBYEolY2P7Q/uqCIWA+oZXw1F6Idz3H+xdepggsL2OR?=
 =?us-ascii?Q?85he9FBHHA2qRuash1LgxEW44griDnGswiSovJVMJfgBJBnHu0UStPzKgm0L?=
 =?us-ascii?Q?2wH3UqZ1EyNgLf0FCcY6qKyvA+X/nGUqHXRT5nBq4vSGeaEp+QRSHffFu1fv?=
 =?us-ascii?Q?x9mBVTRayzHeqXsJ4PHxufDzT/+DK9uwFz2x3L+GuQQ/cdCVztHqaDrpDYLo?=
 =?us-ascii?Q?t8J45A2YOm2eHXyzKARlg25Jmr+ZqrCb1BphIwcePJV9twuud5Uxl5WUgJPz?=
 =?us-ascii?Q?lwLZdl9KmMoK6cpG5uBArGl/kmiAos6qVxKI/2zIJBQ8v5ab914DsMdHtRYp?=
 =?us-ascii?Q?SbSAdqcyZtAVS25u/9Q7fu8GZTCuO4RRn+AMc+mg2a3MuIvmEGA+aZsgKplG?=
 =?us-ascii?Q?/ZWOVgq2oF4wMZRBCZlvp6gIWdF6vkDR/JNQTv1dHB9aQXF8wHq9en5wtFAn?=
 =?us-ascii?Q?zXeQZSDP8OMykHraw8+VSNwWkXd13xY5qKJYAYMWeSCcSkPQDajQ4DG0USSc?=
 =?us-ascii?Q?lKWTrbzC0oWEESRtRxT+k3t865dFTuOpDtQ6GwUJTM6SBqBc7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5354.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgRbmIiSnOUM8QULefSCbSP7ip43z+OSHeBMrU5H94CIgwld9pmiKo0KPhMK?=
 =?us-ascii?Q?8WK1GQynRH64GWm9r2sQqBvI2d0FGoDC4bIfAPu3+SQZ1vVe3avNQJg2eLU8?=
 =?us-ascii?Q?uyJ6zz5kE6ybdz5slrHNp4dOZakFXgV3ywGxbNEPFj8+iY3kqT8Gw78HKyNN?=
 =?us-ascii?Q?jUrA74rKTf/6M4uUMmGCIhYWKgcxJE0qLDZ+KnUociw6YSxWUB+6CkPkXWsk?=
 =?us-ascii?Q?9qLUDHQkbRlvhtqYVaz2AXXg/DTVk1XchJArAdB0gYe4Gy0QlnKNRte+XaTY?=
 =?us-ascii?Q?/bZEjqXSO10Jb7DpJCYkg096kNh6twPqc4ZRDxDi0A2dK5zsLDFcj69UncZv?=
 =?us-ascii?Q?3QLKppNDlXeSTp4XDpgR6ki6OJ1b3ABLUG0TTNZ+DQyudwOGmRYvcREabCT0?=
 =?us-ascii?Q?mK3bm62KtLskuTznJ3Hd7ZmGgSDeOki8OhWH1OpPUadXdz+ctakcrg9VS0uM?=
 =?us-ascii?Q?4JtAAY/cwjyKPGLpDS7CPyFYKsJMfGv3Cec5BdYszmcRh26u00n9MlILbNVv?=
 =?us-ascii?Q?vcU1gymwPbSEWcDSha+oneuI4nGIAi1q9CLYCkNAN4vmba09rjhKBICaEK3r?=
 =?us-ascii?Q?4GVRrjUjofffgmRCYhzpqJzMTIEKnVNNcSj7SkCe0sFqb4iT3Oq4afD6Qwk5?=
 =?us-ascii?Q?kqAnT3N+zfJgsUmDjusdhr/vWZHzwbYbV/MMYTdF4nY0WQJddKupYqFaLig4?=
 =?us-ascii?Q?w7vHNr54Q7NSYfoF2w7nXB/p3W5nzoC2vhIsTlA+Is4PVqEpIq+DVtWFfMC6?=
 =?us-ascii?Q?CTrKZcy58Ggc9h6NlBlU2bh4vYSEn7YJMywMyipVTYT85g4jC0/estp6ybUp?=
 =?us-ascii?Q?aMoTCwFIEie7RfpQhxTSDnmVMuaXInxj7qzNDAFZ0l0iK26XvK0BgNLowFch?=
 =?us-ascii?Q?tPvWeODZpW9ed42YxZ6bC07W0yS+VSytau64qeqmkpzlhe8w1QKdbc6Upe0j?=
 =?us-ascii?Q?eFGP8AKZCgD2lCqGnjhPkyz8sJG7eZ4eX3WzYvoh/LN5QoO0Zxq63HqK+wpW?=
 =?us-ascii?Q?IPM0Q4PsrqIwg4iErFPlm9sb6/rzY4A3lUlXI6X/R75K8b/d1X/ZQRpuLso3?=
 =?us-ascii?Q?2WAWzj2sW+lzeDAHSACUxDueQN9NTU6WnIRRch4w/tYO+XqUirjbQYKYUdZT?=
 =?us-ascii?Q?DBFUZhr/eev+FozN9yWKQJWl6oJ1n3+Xuccx0Vy3WHUtCAu/2BDEwspP1bew?=
 =?us-ascii?Q?6AEUiQEoq1D7BLIBH769fk3ksWnjfBsOaumlI00jtcL8Krpv6VORLPt1+9hH?=
 =?us-ascii?Q?qt8eNE6k7qjrAgJRlcuuMbua+S2X/EEt4Ud4Q2xBWKNBLIeM3MUW5/J6C1F8?=
 =?us-ascii?Q?tYlGdYtZkCWWBw5Idvu1ssyyL9+3BX+mJOSgsw6qMM1ubVnZcboPJYytXeve?=
 =?us-ascii?Q?XQffcQqi9AcokDYNQOrE7n28y00V0y+TqDaaSevMFnSxt/5B6Yd6xyAkj9kZ?=
 =?us-ascii?Q?x3jBnkuz5k+c6BwVMOimCgWz5OG4YVIxdT0eiIyJDpkW4bq/+UAmtP8dktQf?=
 =?us-ascii?Q?ZoqpGMDjT0na0gDvyoihXkIBNzhNcPcUNdEh5Qu0CP5Ms7u8nNSHIaECgpcd?=
 =?us-ascii?Q?NJJBH0SbT3/MENi/6DNcwNosJR47bdwgVOd+c1jBY2yHvqZWORvGekCbR3K/?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc58482a-286c-4585-e829-08dd18e38738
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5354.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 06:26:06.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MA1vRb8CXGd5Q9vsFjg/0lkRuuPkA18y1VAbrDKlLrXP55OisV7kcFmVFZG0PvI6vUU6jjyuZdPdR0WBpcYpSOnXmF5Hyx45sF7mRBa1WKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-Proofpoint-GUID: vBSn3s_-3bZYUgwRUbtDiuuiBvyJeaO9
X-Proofpoint-ORIG-GUID: vBSn3s_-3bZYUgwRUbtDiuuiBvyJeaO9
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=6757df01 cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=t7CeM3EgAAAA:8 a=FBNtR9VHoQ_K8lOUHnoA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_02,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=880 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412100047

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit dd89a81d850fa9a65f67b4527c0e420d15bf836c ]

Drop the WARN_ON_ONCE inn gue_gro_receive if the encapsulated type is
not known or does not have a GRO handler.

Such a packet is easily constructed. Syzbot generates them and sets
off this warning.

Remove the warning as it is expected and not actionable.

The warning was previously reduced from WARN_ON to WARN_ON_ONCE in
commit 270136613bf7 ("fou: Do WARN_ON_ONCE in gue_gro_receive for bad
proto callbacks").

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240614122552.1649044-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
---
 net/ipv4/fou.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 1d67df4d8ed6..b1a8e4eec3f6 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -453,7 +453,7 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON_ONCE(!ops || !ops->callbacks.gro_receive))
+	if (!ops || !ops->callbacks.gro_receive)
 		goto out;
 
 	pp = call_gro_receive(ops->callbacks.gro_receive, head, skb);
-- 
2.25.1


