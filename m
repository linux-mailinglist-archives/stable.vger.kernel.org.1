Return-Path: <stable+bounces-83164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C707996239
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 10:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D1A28546B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 08:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6648C17C7BE;
	Wed,  9 Oct 2024 08:16:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70C1684A5
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461796; cv=fail; b=gMRbiw2K9OHmFSktHcTf0ikEBMByzORnO4p2MT4XGUl9iB1Su+eM75keCIVWvjkI71kBq97RvDrXZwWqXPK1V0UhpQrl8BsXHQd/uMcTRteTluKVw6KuXsyQljAPckdd67ndj6uqIcrDZQbrYkyHehjM7CrTRNeev0n9KRcx7Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461796; c=relaxed/simple;
	bh=KvXB1YEOIPLpSndUxI359B939A2lwXU4k9KwMxvIlag=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SfGS/rir26RrJTrGHsHFG5OZie/gTU1EPfhHJevg2UFzvTIMmgxkawfJDtjLrrR5z811/UAcL/pJkkQdAjvTf6jv60hDw0/gqeISXYq2qOpO5SrO8BJR45T8KtPCqMrBR2XpA87YkE1Z1XqsREtQHce8ALx3CVnjBLOaSlxzkJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4994sVVC032192
	for <stable@vger.kernel.org>; Wed, 9 Oct 2024 08:16:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 422tp448qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 09 Oct 2024 08:16:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T32/lw1pGKVTUnLRc/fF1ep0+2LwbK1JkKabYX247MlNu456rMK+N6wTHN3JomJF27eycNW/rIHamCqm3AytEpRdzul90ODmt/+HXvrsyZ33CUBpoIawfYqESaHsgOKdds2tXfN/asQArbDSuHsFTyzsik5+QYrGZ8vUcmCKreaRXwDmQWF1IHOeTadKmAsh5iMAUZ6lLGj3wjcvMh6Awqx9t5sVxMo9Khelf30qJQUnnVY+ff3e25kbqYHkvi0yIZX6jU9BSi5tcRfpHbMjW6ZoSUy+7tIHaAfoGSDrmSIm7MCoK+OfB/+jTa6WdfDvQFcGSJpluj8YnfJBDhE79g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1kiJpaZnWz5VHnyZf1B2vt32xArUD9AsyA3PVnI+dg=;
 b=K1uptnOnjc2msVPc0APh8Xob/oUa4hjOtmDFQGWXT400h/gPxL8Z22jEAjx34xkN4RrEL4xDnhnMupuJ7O4wBgsTFLGq4F+UwJjbR1R1n5sL5UPbkKHN+L4a93t+WusT+N77SLd6TJyzom5y3+lgAWTmI+i+Sx5iYHK0rCV6VADuzEXp41nyCw3PSYJ7Zlia1dkCQO1kcjMN8xC6+Cg+xyQxxdn+tSGC56/Uz+ZUUtDFdMqZHFEy+tc2fLKV81BR4KmyzC8fD0b1RTkty+R4d+mHi0ejlL6RsF9KwHfT8isjZxX6rFzHe2hTXJKHZ0I8MVMKuRMKlqOydRFYgPYqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CY8PR11MB6890.namprd11.prod.outlook.com (2603:10b6:930:5d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 08:16:30 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 08:16:30 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1] Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
Date: Wed,  9 Oct 2024 16:16:26 +0800
Message-ID: <20241009081627.354405-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: 4ae64fb2-ae89-4cf0-1d19-08dce83aada9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2bqJxlOW3ybNkj/fLhZsUYM2z2VENU5NlEgkOw39w6ngWpJgpsWbrdz0Iryy?=
 =?us-ascii?Q?4ZWBHuSDvO6kZONiSe98n9+dBq7XXxh/RnRABEd6MauX0gCHdwCAEQPfoeTT?=
 =?us-ascii?Q?LwV3jm27ufk54vDBtLqEaAsTSPG6G2UQPtugsPB0r/V5KSkeG5SviHtJU8yW?=
 =?us-ascii?Q?erHvqQ30qLjt7qdPpX6viwuiv6Y7rdMiWG/ftX+248bFwhnAR121Ml/35B4T?=
 =?us-ascii?Q?1pcW/bDg9x8btMtpJ07ysk1pCjujSGHx9At1zGpGeTgFePEnsxG8FEQper6N?=
 =?us-ascii?Q?u0JjJuuzxL0B4bVNxWvablDnuByTcC2pBATyAnyZk1MwacES+bnrjVZsHV53?=
 =?us-ascii?Q?OD2rpAXEgA66tet0S0Y7AlihgSQXymXG8haelO9h4cAfcddaZKwHPsX/1umb?=
 =?us-ascii?Q?dKxYeEnTeIRCPJ5PNh/0HKW1FaS59cUBy3kcoHQqQNsRsH6lV3jpa/DoFr4d?=
 =?us-ascii?Q?KL6hcRV2GR86S+V5/KaUukD2KIoov+cCiZxC7GKMNNPA3JKvtPunUJ6OF3ff?=
 =?us-ascii?Q?5djTVKD4frIv+cyElR57BPK0WvHojAtLlpbywpg2rCMUIwAu31qi9pMh5NxI?=
 =?us-ascii?Q?OvmCwrDx9YQ4SjYsfdcPNdAPNpewIYYygQYvd74gNIkDupU6SWRKrfzZhPXB?=
 =?us-ascii?Q?kB59rIrV/aMKY0TzWfbM/J2za5kXbDFFp3CM/ECXmazHEmad9hJ/cRUSPLJQ?=
 =?us-ascii?Q?i5noNQxRzlagdig8z3osTD7xX1s66QhW59wiNqJAkd18g1LZSgWYs4RKKQD/?=
 =?us-ascii?Q?ocqVNCQ3+mwvqXtXNIkJSkTOB5GtOfNOX+j/X0pk+T7cAGze1DLAHOlg8GIo?=
 =?us-ascii?Q?4hLOP2O6+mTh2jtkM4BEDtqjU3+MgbgVlyLpwr4B+KepCFuA8Tu2PtCoJrUr?=
 =?us-ascii?Q?8hajzKVKYCNPotBYldN0D5pTO0GHfbiFdd5IFyeZMn4LloSSkLtwcayakuIY?=
 =?us-ascii?Q?hAD1i9yQxxM/I9zm0N6osUI3t7wDSxIU6kXHLne8hZAhmEhNVJtpcAba7m69?=
 =?us-ascii?Q?E4d448VZ2V6ET5Oop1gq+gVm7URrjzelm/X9QR8O4Yl9zvNsSJhdyCsronQR?=
 =?us-ascii?Q?JyD+QjckgiGm1tbsTX3pQlmSeMzmF/S7LzADV8FB2uYAg3x1gxNTNd0jHemR?=
 =?us-ascii?Q?n0jiiUYaXifAhKINH5sCzL1w0p+OalFejJeUn+w8i+uXwKZv5dJrV7FYhqlt?=
 =?us-ascii?Q?nk5qfv/d9sLhJDzKThAHxDv5nWnrldHMLXGVHEy3o2ULpFCvbWejrNljWFLL?=
 =?us-ascii?Q?miBnRXkM5ZSlDRbr/s/+rXNNtAzGzko/wEwc1AEaBq2Ib6R2HyYM8NiX4CZw?=
 =?us-ascii?Q?QSCGU5gnipDsjLRM6vl8F82ZtL16+mKFDte7/qm0q6Udbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v7ucSdo+tHu8v7eArvQWvX9j+0ambBCFOm4oyt8C1ViuBc4lirVzcrgUcvEN?=
 =?us-ascii?Q?nza3vVCBPbpQsA65oyAyvzwfZlJQTC5SEm1ZFTR4acgPZYXmbaG5c+S0hKTz?=
 =?us-ascii?Q?o2kO69lwyltIf15zp8gC7ZaH7Iepl/iD3HRFAoH61vw+iLHgNVNJR8KTGrpf?=
 =?us-ascii?Q?cpMerNQORVLJ6Aa0oJKGIXMUhXdu+xOIZhz34cbloWMx76lhgnszSi85826v?=
 =?us-ascii?Q?C4MVw4PInnhiUe57WFaXXFVND4gHSsVqeDisaNTSHmMhUQu2tP7ClPLYDJkh?=
 =?us-ascii?Q?FNZTVnYWh7DpBN4+i0MqighASRK1ZRGOdwsve0L8ZC6bzNSDU8wOo69ZdvZE?=
 =?us-ascii?Q?oF8dAHVaaA/C0LdehVyNaYGx+GBF0Y5zlEC7BeQu8d6dfATRZY1FvhmfTRSL?=
 =?us-ascii?Q?7VL/CP9KvTcjn9rPpxLNkbrR+yIqdgVvqNsK/OTwzUanjbnQ6LYzH7j5U/ZF?=
 =?us-ascii?Q?Ely7sYMHGvv/S6pQuaMmJgDCE5EaZV5KIsBJG/hUmfhXUF87B++CyVMlUrEN?=
 =?us-ascii?Q?uOT4a7AgQW/ZbaR9Uow7Usa2zW/H+aEgLrWmL6b3r+E+EuwLWDmEdmA1cEyD?=
 =?us-ascii?Q?TllaDgAQvDI6MnLypm20RgU8ItWmGM229trgWqkZpvlwWb4kCCmk0JbpgyLQ?=
 =?us-ascii?Q?sbwuWRZA8UoZUE1qFDQGw/QlDdWwzmgqIim7PN0PR4bnMGoMlixM42k4HXRl?=
 =?us-ascii?Q?YBwKC08Qt4g+qSu2tYkHI/qvh9oOxxVO+OtfPresb5N1OLD5hO7HOR8Uh9/Z?=
 =?us-ascii?Q?t4zAqM77cGOayX0u0MkxEH+MEHVgSRDfB7eIEEVlIERDFyp5J+JzpQT4AFqw?=
 =?us-ascii?Q?Kg/A0YqM7gnk9ua5XsI++ubpUK4MI8epQ1sfGOgHArd+lzIgtEfCbWNu3ZSG?=
 =?us-ascii?Q?9n+/33i4tWOBDNzkuaKInSiB4xjlNgmpFx4Rzpd5fNYw6l4cfbak3sccebx4?=
 =?us-ascii?Q?SrWKiyoEckNRBtv3ud+x/NHg7dzBf2Uclm1yWoL+Qc3ImMB0kKOBGjmGeXdU?=
 =?us-ascii?Q?+ZChahFxdXhCOyJp5ZaX//AK1mk6cncrlcLyFfzE9aGUc7/rsdhi8l8Yn/bA?=
 =?us-ascii?Q?WPLMF953sXSOBSDH/26MAPFfcMybt27LErll9z0oMXj6bA26G7yFF8PBMBl9?=
 =?us-ascii?Q?1cbJmrqzkLDK8kyBV3alRqgtxaDZD1SOsRahelvgfwJLHROWjRC43YfpIse6?=
 =?us-ascii?Q?1YmQOYjUVFO9Vq6pyTrZYnTB17eg9A+M5K0Six3PNEUTx8dCEtd3pf2E2TgN?=
 =?us-ascii?Q?VBiXaK4GvSSeovmcxRNx6tKR6lcnEMl2ZlhWTs/gn6XiBK/qMHf/d9g+E54s?=
 =?us-ascii?Q?bJ0EYIm891kgWC0bqZuHE4cZ6DUznEVoA1BA1ajMEJMzVyAhFTKf4v7Cqos8?=
 =?us-ascii?Q?gRCUtMLhyWW0uKIj0NlbG/R83hAUqh76MDO/TdeXByDtbIPnrdC07r2sbKeV?=
 =?us-ascii?Q?TU333rzUVI2sgNj3w58L/c5rjzcAxKuSznsse+EEZIC+1pvZaI/FgHsgd3pe?=
 =?us-ascii?Q?AN/6u4teVA6y1jwqbNwScjH9Clg/+xvcyicRQdQ60hnBXGjZ40tBYqzqtAcR?=
 =?us-ascii?Q?Vta0olru6q/WWbDiy680XXaGPJqmGagwCsLmO1JYp4zGb579RF4dnXgR7u1E?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae64fb2-ae89-4cf0-1d19-08dce83aada9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 08:16:30.0433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0AdErcexCEOUVjDm490MAXSHNf/dyw3qXZFv0pT4xvqKLa7ZXSkIf/wS9Btk06lb4W2CCuRzc8odJh9RinZEUMP647N+s1z7YAbRA3Y+8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6890
X-Authority-Analysis: v=2.4 cv=XPtiShhE c=1 sm=1 tr=0 ts=67063be1 cx=c_pps a=WCFCujto17ieNoiWBJjljg==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=iyetQYRyETB39th_RfwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: loxZeXJqWu3WYFo6wBkjl_ZvnqivUkzk
X-Proofpoint-GUID: loxZeXJqWu3WYFo6wBkjl_ZvnqivUkzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_06,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=969 malwarescore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410090054

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

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
[Xiangyu: Modified to apply on 6.1.y]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/hv/connection.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index da51b50787df..c74088b69a5f 100644
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
-- 
2.43.0


