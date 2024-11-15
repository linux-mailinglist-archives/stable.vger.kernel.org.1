Return-Path: <stable+bounces-93488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788649CDA99
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5EA0B239F7
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E981142E86;
	Fri, 15 Nov 2024 08:33:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3693B18990C
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659636; cv=fail; b=RQwj02Xtz997fBx2fXdCw97AsWma0dpMC5DxYjwbr6UjZ9h5EWilk1WMD2VbpzK0YEgzIGp0lyoadjZed7v15ArQ6ELOaIO31wPb0FZjFYhXHLuq5sMmdxwHCo+LkqExYyDj+Wb75ZOhsWuyHs6F8w8dG9vHJ54QFXovI2H3F8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659636; c=relaxed/simple;
	bh=+3z+FP4v7veE51tA9XhExf7KGcgmTYzx0PYJZISzi8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e02n1BVG0THV981rWogFPleZiXhEBjdL9obABwOhE37rSPc/ksLatinSOC87Pp6PTtE3ca4GR/K9fbEfHtFumw0FvFZZMozT0e8vDfT//Z+812nTUV+QyBfeC4Hs45GFRTlpbzFUzQL/r8/ad+SgaDfFjC4y9cyef7LBZ/TXK7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8XGAi026037;
	Fri, 15 Nov 2024 08:33:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42uwtucw1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 08:33:34 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYBwB2mZ0W7Ng8iqsa//9Ynk0i5RxVUd5p5viqOS379+zKCeBKtv8rQQhgYhXjnx33B7ub6Rgpcq/+nNOPOal3pUuTC038jnINONEy137kF9bUeGgk1Jy6AtjIP5LKwKo590HK9iKop/YHLLy4G8ARmJ6QL6dTt0LK436O2pR9eisl9Zufl4nv03if7TlSA1ort+6uva340s0NsJM8zxAO3gXqGGtSHxMTa6Cr5zMyG9SwTitcskygYFL27I397qDVy2lpGjjuu8f61ZjyidCghxKbnRBIiy5zOFj3uiVeQo28eukefKu4nTcJ5KKbpZHt2NZakNY26Yalfv1a6m0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejSDFPsJxoS0/C8R6pQ+mNPwjbqu/KH3wh/J4ocNLs0=;
 b=RtQl1OXFv4DUDC3F+7hXJ1H4meAGNQ3Ckc12bX+fHdbXjKLVEi6K5J5B+R9mmLHUxLgcCxlra3hxY9111xrqIiZc92OxzBFNFr81lzDWs6x5/hbvf6qO2gxmInEyiHYsmys8Cf7g4wIS1Lv/ppG93lZnTDYIx0YW1bg/OS9twt2dOyzMXNmveWJAaAJ51yLNL5hLrcbSFsJO3aaTHkJGYc0W6axGKmHCf57UiIzVMozP0nYdZeE31CAZ2BqxLwklKJNkQv1xHBxHh8anu8OuW54PGlYuSkv2xXROKzPeqR2sZEeVhP39kUbNbLoUnmafc0RtfhuSCX2T0hI+nc7bwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by DS7PR11MB6221.namprd11.prod.outlook.com (2603:10b6:8:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 08:33:32 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 08:33:31 +0000
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
To: abelova@astralinux.ru, perry.yuan@amd.com, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, xiangyu.chen@aol.com
Subject: [PATCH 6.1] cpufreq: amd-pstate: add check for cpufreq_cpu_get's return value
Date: Fri, 15 Nov 2024 16:33:37 +0800
Message-ID: <20241115083338.3469784-1-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::28) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|DS7PR11MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: eed358bd-0459-43e5-69d2-08dd0550300a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3V85ftotifiq75R13TIbgPl2XjR6XLQcpPRE+lEfS85NCv2b8tbtbJyaP6VY?=
 =?us-ascii?Q?Aqy/Z/U3h8UEgECS25X2IQcIus9ogNGK2my22S3KxkrmphXsbUsh/OySs4Ox?=
 =?us-ascii?Q?qval4E/zq4f8hY8yJAO2XnlM1KC6IAeW7JTA99zYJTtmhnoZLr+u3t2jLgBz?=
 =?us-ascii?Q?zzmRuZ8wg+A26iADAPnv6QZAVUPU++9Lku5DdxbIw1lcZNyGlBYkP/o3Yrw/?=
 =?us-ascii?Q?Req+0BSeYVDgppsOk1k5OpDweFU/5Kx4se3tkv8uEyKstg+cir0ytkR5pWUX?=
 =?us-ascii?Q?AfsNmtAfti3AqsnTq04Crv2QKYa6NFFK4FekREctWnsK97ksnW+j6U+CKJHn?=
 =?us-ascii?Q?YhPSTZvazfrZ6GYH4Jsfz47ZFmsYc52jkQwklsUPDtscNdl2+owIcL8VpNgs?=
 =?us-ascii?Q?qtKbkKxUxnJiwU9BwXNp1+qgIey4Hh33SgRhSJRU9IHFWhpoWgpNhEQuMP7B?=
 =?us-ascii?Q?DJYCvsrwXNcQL978xBrW2tWiDmvp1OzK/C32dltUls9B/ZZaMWHJ+vndgojK?=
 =?us-ascii?Q?EaanP7fy1eB2VKAIrU38jnQL6ROcpjtpjKKQRi4Q7M2L/9tF7KAzZtgkYk/i?=
 =?us-ascii?Q?jyi3OXLpfcQlSF4R2r50FE36ExfT4PYJZGnYtv+teMC55eDiIH2Fh6Kn3Bba?=
 =?us-ascii?Q?FXknIkbLrp6jNrS5/GeXm5F3P4VDeT5D10tBYR0lbzbs17WI+qlOjjtJzGN2?=
 =?us-ascii?Q?HqfUw7l9l20zURhOdjfxlQD4TzC3pwTogEwcypPg/lTnajmzGK5o5AlQ/lU2?=
 =?us-ascii?Q?vQoCmpLWnxenqctsvDIevamdKeSKiGvD6y2QIgKyxML4mVFRXl3jPwt9Zc39?=
 =?us-ascii?Q?v/ENesAqEN/gQrPJnqvjkoZhw6DrJGzHV70crMSkrbFa8fAKi2EGfixRD4aV?=
 =?us-ascii?Q?zi92ujT/QKB99GH8fcXW/G9xXNEkIbImTs6rHImVzF+IwCLpUE1D/Fyxe/hq?=
 =?us-ascii?Q?nbSkrjC0mbEL70sJqEAGh53t9D343jt9GeadkLT1z/jEBCevs7tzuCX/5/2p?=
 =?us-ascii?Q?eoTqsfemhmrvs/ZyqEwMqS1Hk7VSz09h1N9cav3jRXt9NLLDU1uUuaj24NlU?=
 =?us-ascii?Q?dEG+lPVLrgjQWQ3iJYktkFzvMgqDebTu8i0MpTTmywbRyNkdgYSJ9VF+z9oV?=
 =?us-ascii?Q?mKTrKzwgBztITVqfRSy0mQZb9woZv3v6FQZeZW3LQUssz7zVVKHqfk3DWdVK?=
 =?us-ascii?Q?L5BLWk25XqYoP7WMpkQQaGCN5/KFhXdPLBJRSvlzK65xV0CXdXcXmHyAdjHH?=
 =?us-ascii?Q?heRee1Vav8Gj4QWzo1hmKLXQ43UpmlxyyNZQab+xwj64l+mLc69GrDeSPvkt?=
 =?us-ascii?Q?7DlmGoSanAdipGO+vS/OdEoWDai2bzsaqEaBWd9pr87wY3Add+ofsLYJ9Tut?=
 =?us-ascii?Q?JKzooOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLmPu3hsjrd9X3CeAB2xaSdqmCgF6Gp3p/MmZKPPU78jImwvQLDO7loIRnm0?=
 =?us-ascii?Q?MJ2Tg5RqquXJse8emQz52DA/egTLUZ/qZ44vCTVWpMxWt7wkvS4Lx4ARlDgN?=
 =?us-ascii?Q?35mPcZ1bFs7RJnBa+4L/MWdh3g7c0Fo73ajKO9eYyUROkHbq/O0soKVR7boC?=
 =?us-ascii?Q?mw3xRTJvoqsNFAAe+mYnBLETLdWG6n/bxItjEJO2cLjmXIt5zpYhxKeY2b7K?=
 =?us-ascii?Q?NyJ2AW+9bq0Z0TAloK4etNT88BuIwK+ixEPVM8J5WiLqitpebda9Ldcg+ykW?=
 =?us-ascii?Q?/WkTKbvR9qNwf9BwTFghCk4x6td5vD9/YybJRinhQoWJZwbcW+GWrwc3BVVx?=
 =?us-ascii?Q?HLbA8LF0BGvCqtNguS8oxOE7/0B2tnJae+EzzHLHVZGPQ5Ep1fMDgbyONldM?=
 =?us-ascii?Q?qMxe12RFrRbasPo0hTxlHzaQ6X0XPPoN1c970dCnF2pd4ORqsCPX6DiCalQw?=
 =?us-ascii?Q?aXqnn59+QWIeIqbYjjPQmciOlbChd58CSiAF2eCZKD1s/oMSKQg89Rw0ZYKy?=
 =?us-ascii?Q?YO/3r18dc2RQHOJdoCE8W1UyXnDuQiUCN6zN0ctod1ZK2z846QyGvuC43UFq?=
 =?us-ascii?Q?+nccxxhrfdSIL4TfMnvKY+1nzqaU+4OFm7FbplNsV/O8wassDbnQthA/CEgc?=
 =?us-ascii?Q?Va4UUgS2FnVN2NWyUcHYrUlcyc2OvLnhK37cAUIi+1fAr+EDqqSSVTQxTOp2?=
 =?us-ascii?Q?++0kgiOVnTU6ajOGOTcN0V1vQexWA8fNVL+MeiNS3ZYOTzBBoAmZGSkVrRIT?=
 =?us-ascii?Q?Hc2qJGehFoCzboMY4aKP8iznOaCgefD1npVcdbgc335EbAcxHWRXEl/pmTb8?=
 =?us-ascii?Q?0GDnhxQlTkaE6XSckLEd4Pu7nLy6xIwcfeEgzLwacbjiPUz49iZaSj+YeJ2p?=
 =?us-ascii?Q?XesnKnWusqBlNrSt8yRU+rbcOppCiD/xoB1bBJ7bJnopD3TCO8MoF/4xWpYt?=
 =?us-ascii?Q?jqk0kJVz+ZC5N8VgZqkyGmxJrnV/Jy6F74bCfBNUEY2lJwJZHEPnEax6kwix?=
 =?us-ascii?Q?vsvitCAfWuqz7HQ2Xq3w7RGtWK47yVvDBTEOsydNSyY6IhMTXenCk2aWfYcE?=
 =?us-ascii?Q?4SNMT9C6yXR4xJopLxtJk0J3Dea43AaSCrHbVcOYtpZ+dfq2fqFuubmhOwWi?=
 =?us-ascii?Q?8vsSyNmPpxr82Bwp9O8l3IdvQYFel3aIJndLpQE8y+FEhP90v+ozHp6U3vus?=
 =?us-ascii?Q?wZtNzWwGXHHODbTAh57SZQu28X7Bl7yectlQFaXD7QkTJd55M3cWl6QMBlXV?=
 =?us-ascii?Q?OKdk2vRxRMCXNjFXVwwlsdBFq0og9uTobiRYmlAGD7m6lJ2SBmGcJkvZpnQm?=
 =?us-ascii?Q?inKFiQhPShkw2oNK+WPfTd07A59oYmbqMrtzubCK3PZtIK+pmwccj57wIcrT?=
 =?us-ascii?Q?GkHoUU6Phb1QiHFcI1AF56R0KyM9FJiCDGBTrUYb3k6o5KVYc9MPWY40NFpX?=
 =?us-ascii?Q?iQ7TT6IBe85ZufFnEYfgoEV6jwEU6Qu+Ht6g+CGkLKMZ6Ib27DwSOIq7vWL0?=
 =?us-ascii?Q?42qRdUaK+LYwDO6+M8XGEx3z3FTRyXadpgL71zZDcb3HXVkCDYcwSy2Q8WNG?=
 =?us-ascii?Q?5YGpscwjnh4uKBTqwZ+k3MhsA1rr5TCkNMUJAU5GN4zH29vg3rZf+Pc1ihzR?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eed358bd-0459-43e5-69d2-08dd0550300a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:33:31.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFagPLVDSIhVcbS8oqnCnq1pNcCfmIhvcU3ZySZXIBRqSbrSUXlHDI1rc0cdK35wTUasR4eKQZ3zwqBU2sVWzvX5muS83EqpZcnnS4eCkfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6221
X-Proofpoint-GUID: ZCdEkiBMYmsUNvRn3B5X-pUbWDjZbQLx
X-Authority-Analysis: v=2.4 cv=BPnhr0QG c=1 sm=1 tr=0 ts=6737075e cx=c_pps a=di3315gfm3qlniCp1Rh91A==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=_Eqp4RXO4fwA:10 a=t7CeM3EgAAAA:8
 a=HH5vDtPzAAAA:8 a=KP9VF9y3AAAA:8 a=zd2uoN0lAAAA:8 a=KKAkSRfTAAAA:8 a=T-_msMMreK8bA51VSmQA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=QM_-zKB-Ew0MsOlNKMB5:22 a=4w0yzETBtB_scsjRCo-X:22 a=cvBusfyB2V15izCimMoJ:22 a=Omh45SbU8xzqK50xPoZQ:22
X-Proofpoint-ORIG-GUID: ZCdEkiBMYmsUNvRn3B5X-pUbWDjZbQLx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411150072

From: Xiangyu Chen <xiangyu.chen@windriver.com>

[ Upstream commit 5493f9714e4cdaf0ee7cec15899a231400cb1a9f ]

cpufreq_cpu_get may return NULL. To avoid NULL-dereference check it
and return in case of error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Reviewed-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[Xiangyu:  Bp to fix CVE: CVE-2024-50009 resolved minor conflicts]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/cpufreq/amd-pstate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 90dcf26f0973..106aef210003 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -309,9 +309,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	unsigned long max_perf, min_perf, des_perf,
 		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct amd_cpudata *cpudata = policy->driver_data;
+	struct amd_cpudata *cpudata;
 	unsigned int target_freq;
 
+	if (!policy)
+		return;
+
+	cpudata = policy->driver_data;
+
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
 	max_freq = READ_ONCE(cpudata->max_freq);
-- 
2.43.0


