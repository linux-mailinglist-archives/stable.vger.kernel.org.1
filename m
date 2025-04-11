Return-Path: <stable+bounces-132196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72522A8518C
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 04:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4672C1B81CE9
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 02:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62327BF8B;
	Fri, 11 Apr 2025 02:27:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728F27BF82;
	Fri, 11 Apr 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338451; cv=fail; b=iibsbbumoru8d/hK8vcl4PpaHpp8+BOoHfhN79rLS72oWPTUTv4kOEnFPeDt8KDVAS78hp3BKfOpIqVQz7gzZsbmiIdnKtqtQ673rhiuKLTEqVQ+0DaOWVi15+H4NF6lwsdUrk7je+1hnQTkhjyX8GmYpSjG0+35DprzSv5FW5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338451; c=relaxed/simple;
	bh=sLJ7FiG28ncUAYD6gh6YzCtLlwiWXbfNYt4gx3FMaYc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pnRMLTON4RVdt8LfC6u845StoibObLDfu4uoMDA61o3RG/iMDccqkxO5SM0O81v/qpsQ5OBnXw1RWg/xnKyHSq58Ssf8SaCDfr5ll+zvyd6a8oY/NjY3CIUdBuyMCuXc9OHXOzaDHEM2KOzzClT1KC+nYKmo4RHCzutewdUf6PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B18mSi014583;
	Fri, 11 Apr 2025 02:26:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45tsr1qt03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 02:26:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFULSA0k5HlkyqIEbT5iwNssSXlg9mQN4y+ULPc8J1EBTYjqGSx8KLqAG+ht4SVqWcOjNKPBb0f08vLBBC9fBkJqY4XJ6/XainyUmRHE7ntKV5O+f0zMQreCVBn1WPEaHFCKWrd0ZwscKR6qOjpcXa/dww+3uk4ZiCpI3HmjG/zEDqYZ4z2id3ZI3KQ/BBwrKFBIqWKxRFhWtPUtDBrllQABMW8qv1PhaWooGmOA+aj9b9hixHMRXph8GVHqc5plHFtiWdD+FX3Hk20tg9go8kDXOfpqJ//nRMAQXL299nLdHH+Oa6Iy7s3QCx0GG+Qsc7J+MJ8lbGbixJFQ94DXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBAIHBG4ic88cQWcXbWauxQRGZeslouZDyZCVDBUQwY=;
 b=mEtZzNI/ogD1BY8a0A8NDS0pz36tFhjT3XrKEc4P1kHGlogix+NNiYhXEzU6WSjOz5tKC/vJyeqpu3ZZzYL68Cy6ORrzWkB4tH5fPOsp/3M8l8CT/YfUc2odMGGSljhtdw7k8nQY9DJEQ5nX+uKY23KDcY+0GveAurpTPei5isGyb6k9OB92O9T4yGFI65R47/kf0IXQSHE/BID6sxIPvem5p4uTIp8M8hzeCLinm/4yuPHt7LUC67H7/6+sk2iA84VW24V+cVmr0jTh5zxs/oTdXD4P7B69ubeAdLzm3Qnv7qcQWLgpuk4JEELYtKFaeO8+WajuIgxBMIt5uKhynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 02:26:36 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 02:26:36 +0000
From: Cliff Liu <donghua.liu@windriver.com>
To: stable@vger.kernel.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        leitao@debian.org, nathanl@linux.ibm.com, donghua.liu@windriver.com,
        Zhe.He@windriver.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
Date: Fri, 11 Apr 2025 10:26:23 +0800
Message-Id: <20250411022623.947973-1-donghua.liu@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: fca0b609-0eab-43ff-8606-08dd78a04897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BF2deh7GeynsCl5kEgr9ilhTMsOQKrHixagCr+6uU5HwveHFnOhdh0Fwz4Sh?=
 =?us-ascii?Q?pvux+DAFkmGFR8hAOREAoROqngkVTkayqTGyqMLhvpevkJRD0rlPzucksqel?=
 =?us-ascii?Q?NSvoPc/LxSVc/ekJVM7LKFrKcRolXMvT1qy6hR5KMEfW3GErc5HbRZkRHLbt?=
 =?us-ascii?Q?42ckXHuI9W9AQww+ARu+2ETW+tLRVllrWcDmy4P/Vvc+8ZMAJH2mI69+H0FK?=
 =?us-ascii?Q?VGcpi/rFFZENy8SkQLghLdlFcqMtFsrzcXDsVfcLXa5hmS3yGbz26VQwWX0Z?=
 =?us-ascii?Q?VdHh+fCD4wlIs2ihXx1CtwH8TWnZxXmu9Eo6FUavYcJWNB0zMFBHe342RapV?=
 =?us-ascii?Q?AQpQgzZfJYxAsZ4ojsGaawINiaLow+o4FwxNFkC3t6mKZp3Fmwa7XwTdSi7X?=
 =?us-ascii?Q?FxgypCOJwqgrgWXhcHlsLMJ7m3smYGw65Zr9i7CFEcpFHz3I2mQWiUvPTcYB?=
 =?us-ascii?Q?E3Y1NOloWhA3ak9fhbB8OCTLqlYFkMFE2Em1WMRW6EAL14bGzTANnexaSwp+?=
 =?us-ascii?Q?WkMcFi1f+bkNf/XDLLe+jH61r1lrHYyXiXp4x3WQqZVTMsG5/LytqctrYkkr?=
 =?us-ascii?Q?q8No+xbMl4ipS6qUa3tfdRgW/cn20045CCg706hUyM11nlyMFMf7a6PH0cl6?=
 =?us-ascii?Q?udu0YhlYfQjU0f0KQ7Xa2sNSm5VUJRMRyNdw9gP8cru8AYrzTOEmpZiJFzGp?=
 =?us-ascii?Q?iqfbgh5liOBdEa234yrUBDuMyslQWNT7nMVxfzJep7FOiBJfaGOTPpeoXJFW?=
 =?us-ascii?Q?bXLBe9q2HUv3vGL16hi9EiGXZECYsAdDITjC7/bAtCM16QWoc65kB54dKsNj?=
 =?us-ascii?Q?CfkpXvjAxqxCGx9Fpt0noaKfi3BHXE8yfcLF9gsaXMmmFnT98m4VC485DS1a?=
 =?us-ascii?Q?3HNVBK4xvSIm9estThKWfdxO4QxNzF1e9KzqPbyA1RsSW7vMlBfd18mHk7W3?=
 =?us-ascii?Q?hR1HyV6eVe8+Z3CnYyAmJ2SJDW0q34Es6IlLgpXTcL+qlRkswcN9AUytHFfd?=
 =?us-ascii?Q?LM6IaqmaUZIRAGv7mmabmJwkRQ8SKZYDmKRb9pOP6YZmgsxBNEKxFxEjxTo1?=
 =?us-ascii?Q?QxILxEQ7J2aSwpvR6ngMnqCVbyG4m1d8/TW7M+x3rY36TbQoplmhkYRL3jL7?=
 =?us-ascii?Q?zf55qVXVL//bFmV995QtSUXr1k4cwdVf6KmotmOnBPsDLrkPUMylS2v4TIM8?=
 =?us-ascii?Q?Rr4hvIggYegA9WmZ7hHPXIfOBpEiV7wK0oQvCwsbXPeDls/1uqZ8s52pSNrY?=
 =?us-ascii?Q?SHfLNpGxZbWWrXWswFJ0qu2JWzcnVjVWeGnYxCP6a65dxFJsqXSPVHcXrgmu?=
 =?us-ascii?Q?XTzpjiCRPe1FN2DV/WRm4PrfpLXWajjJlojco/67URnWg4/dYw4g65qfGRU/?=
 =?us-ascii?Q?c/z7v2nQSsBLnPspbBpHNCq81pMho8U5N8Yg/fRxOCJDf7rgCklYwNtEtyul?=
 =?us-ascii?Q?oFxhkRZeatQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fLWJ7m2cLX4QH6pFcmRzeEiUmuqwV6dTh796zzyl5S8oyN9ZhZVBgqNjtMDE?=
 =?us-ascii?Q?/ej95+C9AfJrpit7jzz5ecs9wW6QXgBVrgcqIjcWiW4Xjo+Ho9K8obTbkGxb?=
 =?us-ascii?Q?S7HFeoMRqJjLNtELgTMtIg/4z0GoVVN5R55e1JaTQLmX71VAG742ITC56BeU?=
 =?us-ascii?Q?NTc+hHRDoHSjdMJTMWgyH6xLfkqMyHtuqbOD0n1djq+bRrZsI12AQZwd7E09?=
 =?us-ascii?Q?r6DS6Ro2C77C4Y+qvCCyOcV4nUDKlhB9oIXchliZlKzrlaK48d2I6TG8t7e2?=
 =?us-ascii?Q?ZKQlVa9bWswUvLHTBZxRwGWKrUsdjfs8Qiima46xT0GwcOMsswxLTL+91Bz7?=
 =?us-ascii?Q?QUuZEz352GvbZ9Qi5cpM0faDwporxcRVV1d2gx8CaJ5QL2QSqC3V9m9nYPDt?=
 =?us-ascii?Q?LJh+j84u9gZi5cCsBSaIyHH5kmvuB05Wye+XQTAYpJfCgUrQsiZuJWmw5BCd?=
 =?us-ascii?Q?ZwVIKJPvxbueAzlIIyNkz1eVCb/WPPQFT0VfSLSqIUF1NNctjyrO9Ma1Okd1?=
 =?us-ascii?Q?FpZMVBT6e+vIVS2LinvHeOFlCr7IhZkfbW2YnR0hvyN8Uo1EGftwMW1CP6II?=
 =?us-ascii?Q?obtBzdT3qDkqU+UlYUubMS+JNbdNFzKZkdjUQZFvNK5pmQto0uJxL9gDchW4?=
 =?us-ascii?Q?/aEMZFXWDzSSVuw5FdhLPTRtPxuUtJyQo9Cgx8KIaedXnCw/aRi0gwYOByKf?=
 =?us-ascii?Q?qffKpydFvIsvBFA5Rwb8duuMbPOpWeCtcPihB4J4duqfalRUNG+SfNZNEuJ9?=
 =?us-ascii?Q?BtwNtWn/k9C+YDfzLSscAWeSsQxjoMMqdrGakhSDyVb0N/tixHR+t4Tp0qyU?=
 =?us-ascii?Q?Sk9b2TOhZO2j2m5M3Fz3S8oFD7ERg0ocMTDkxlTqKKEUYWux+U4R2pi42fEa?=
 =?us-ascii?Q?aXRYFOfEjsfq/V3D2Q2pbGzVXlynaF2ZU0OUglJl6VILr0sGvwZw3ZrBCW/l?=
 =?us-ascii?Q?Li8T4LmsEIwy/Azf1jlhGADsWltzWgclmu3W1vCLD4I0E6Au8G2juqz4EGMw?=
 =?us-ascii?Q?tPnJFHY8CWYJckmMsupu/el4fLbEtbtLRvjw9ZGTZGjgRJrbPB9JsSwNP9KZ?=
 =?us-ascii?Q?b8Gez+j7GXC3TQJyiu1ACbQqOxjTe4iIiKqwIv24oPi3lBId2HGYcpVDYgOf?=
 =?us-ascii?Q?R3MJCN24O1/mdB2HZrO07Gjce6iwsG2sTTcYPAJaQRhBpqn4DpOCERAzsTe1?=
 =?us-ascii?Q?fd+rkt+8BEOT6Y51uGJPI7sEmVuWDmYSXLIana5NTrD/oNuDL6iwczEvulb2?=
 =?us-ascii?Q?DIEJBsXZDnSP1GD1/Idw17GrYwQO2K3NrfLXfIDDJYVuNVb63tndVM3J4IiR?=
 =?us-ascii?Q?ExCXTv85/n0AQ2ivkqIQy7GyYSqL5HnHE1cdmfSofqnqhK5WLNUDx/ONuH/t?=
 =?us-ascii?Q?xMUpLQR11m1OWW7560IWWk4YmHuCPoTGERVeVQMWhUvpC5EAC1ONUwYiAKVy?=
 =?us-ascii?Q?HYohi9zju8tCSWMSuoBhP3msO/qyd3V0qVTiNr4r6xSsDcwCTQYvTjRywrSO?=
 =?us-ascii?Q?piBA5u//U2zOj/KgN1WCpiXXJ0Zuxy7k6QswxPcQ+pfG6OmN6dDPtFV0wKaL?=
 =?us-ascii?Q?SXQy/S/5vQdVwWFj4qgYLTlY5eH6dysIXQQRZpT1hFRIBxsMz2YIskXea526?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca0b609-0eab-43ff-8606-08dd78a04897
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 02:26:36.6179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSXrzha2C0wxgEfX7dguTr0oIK6/IA/a8cgmR4Ym80KK04EVrDREPpE9OU4ke12STtaOwpgldcy3Vi5XDm+YCvIoFjR48Zf16xZzhi5lRAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-Authority-Analysis: v=2.4 cv=Td6WtQQh c=1 sm=1 tr=0 ts=67f87de0 cx=c_pps a=joO5rFOndlhnht97C4Lqsw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=bC-a23v3AAAA:8 a=VnNF1IyMAAAA:8 a=xNf9USuDAAAA:8 a=t7CeM3EgAAAA:8 a=u2LiicgN0kIDZIMe9SoA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: KTI_EQ2MxGtGnLvzgCzAgKXtp3XPFi9R
X-Proofpoint-GUID: KTI_EQ2MxGtGnLvzgCzAgKXtp3XPFi9R
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504110017

From: Nathan Lynch <nathanl@linux.ibm.com>

[ Upstream commit 0974d03eb479384466d828d65637814bee6b26d7 ]

Smatch warns:

  arch/powerpc/kernel/rtas.c:1932 __do_sys_rtas() warn: potential
  spectre issue 'args.args' [r] (local cap)

The 'nargs' and 'nret' locals come directly from a user-supplied
buffer and are used as indexes into a small stack-based array and as
inputs to copy_to_user() after they are subject to bounds checks.

Use array_index_nospec() after the bounds checks to clamp these values
for speculative execution.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
Reported-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240530-sys_rtas-nargs-nret-v1-1-129acddd4d89@linux.ibm.com
Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the powerpc build test.
---
 arch/powerpc/kernel/rtas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 5976a25c6264..a8299981798a 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -16,6 +16,7 @@
 #include <linux/capability.h>
 #include <linux/delay.h>
 #include <linux/cpu.h>
+#include <linux/nospec.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/completion.h>
@@ -1173,6 +1174,9 @@ SYSCALL_DEFINE1(rtas, struct rtas_args __user *, uargs)
 	    || nargs + nret > ARRAY_SIZE(args.args))
 		return -EINVAL;
 
+	nargs = array_index_nospec(nargs, ARRAY_SIZE(args.args));
+	nret = array_index_nospec(nret, ARRAY_SIZE(args.args) - nargs);
+
 	/* Copy in args. */
 	if (copy_from_user(args.args, uargs->args,
 			   nargs * sizeof(rtas_arg_t)) != 0)
-- 
2.34.1


