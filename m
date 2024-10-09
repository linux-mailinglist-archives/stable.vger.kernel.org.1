Return-Path: <stable+bounces-83146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAB995F9D
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 08:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28B80B21F1B
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222AB16BE20;
	Wed,  9 Oct 2024 06:20:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A89E1684A5
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728454817; cv=fail; b=bFt334lkYZ6zvLYL+WqFMRYCMcssCgMnV+oakyyXSVIJkyCVl9fzfCDbVohQdmqbGi2WindmvmBYjDjjUYnkgREuVb++duC9GnfRANE5yitDFRb2qAmHIApnLVhFNJTZvhYDN3/R0Ct5YDh0JhJ2gA1ftem6h88ixDT4/orSnqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728454817; c=relaxed/simple;
	bh=AkVGIvnxBKt88cKZCfDgdwQLtjizTfLeedVk0/kHPl4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GIi9176npzwFJkrIq3L3OpQNRgAuKVm45LMUVUBTC70kVnwdaPIpAi51W7xns+tDTA/ho9ofwbWOeP1RWfR3dAtVCzMGnbtpic6ut38NnfG3xZT04gAx+593WX5aw70T3WL/OPvDbLIclJwnXSbN3IewTtW+DwOskoFvExbX8lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49951XJ2028703;
	Tue, 8 Oct 2024 23:20:13 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4234ykuq51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 23:20:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdng8agdSNDRM0vQaxmPKDKmxnMAWruMXjk0KMDqcOVWzK9crZDQL43S+Mc9qETb+bWtw1bBWzYdv2IpeOTU6Ij6oID+g2z1CFfe19XWRZQhjArbWejh5KNZLIrTLD07cYEROT9vrN7OU0fZN7I06TBJ1iLXjDkdleL1YeiEyy9rwMVdINt9WUXc4kcEHUX6kR+WJsoYEu0VpYoclBEy8TOrbSB3VswvNTVu6ZYe5rK632HLb6Qv/wiEmC5YnVui+WVoW/mLQ+P2YQG1AzczlhcM8t0jQm6BI838khYtiowxKgPmGlXmCenkkOi1JgyOZMfBnUTDX1R1zJag+8MgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TPRERr6GLBsdSW9b76Wf43wKIgZBjCA8yGCX0UBWAc=;
 b=XENn2LVG0Mksb/jKZcxd4DIMEK7+FlyCf0Mpau5uy2AlzM1N+gz4iqE0EwgSSS/lpa4Cq6LKGnXYjhNxM63JJ2UWq4Q1ajk+3WQrZAwI/2Ftl6sJqRdKdKyPNwo4Rww3Iyz61XsbysRlS4l99Tcb8giwgAS9P29oJtyjmTdR6bg8xchkj7nOQ9ZDj3cyXLi8WYNexovfKbUw84gGZ9Im71889HaZ+UDtiQSZC8aw7mHyn4f8sWx/EJ9kXF1GnqPk4KEEI0g4z6CB/WAEJI116xLgr8eMNRrfVpTg1CsP8voG+/FqxX2ofgGZElmmIOdWw3pNRTF0cAN7fbhAyZqFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB3152.namprd11.prod.outlook.com (2603:10b6:805:cd::19)
 by SJ0PR11MB5038.namprd11.prod.outlook.com (2603:10b6:a03:2d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 06:20:10 +0000
Received: from SN6PR11MB3152.namprd11.prod.outlook.com
 ([fe80::b311:7964:52a0:4174]) by SN6PR11MB3152.namprd11.prod.outlook.com
 ([fe80::b311:7964:52a0:4174%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:20:10 +0000
From: libo.chen.cn@windriver.com
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, libo.chen.cn@windriver.com
Subject: [PATCH] Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails
Date: Wed,  9 Oct 2024 14:19:50 +0800
Message-Id: <20241009061950.2802693-1-libo.chen.cn@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::16) To SN6PR11MB3152.namprd11.prod.outlook.com
 (2603:10b6:805:cd::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3152:EE_|SJ0PR11MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: 816f2c78-a18a-4d8a-43bb-08dce82a6d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?khIfuoGI2DjkuMZ8vG3oGF2aQG7QhHx6pe3WgLN3vP+cNO83roFQk16AcIkW?=
 =?us-ascii?Q?uHX7kT9b7G1Q7QQLNIGMIFC0u+TRbb2MqPemKPpRSdldRpQBW9sNEMtxqpzZ?=
 =?us-ascii?Q?ZbVOsA+L9gpEingzta89E2W2qCOMObvwjSs8luB6Hc4VqMJhmVm0XTqbjOeT?=
 =?us-ascii?Q?GPixtmKrFju4ORkqdj0PoJDKsj502OQm2+DqwOYQx/yVYTX75tHMPOkbwNJr?=
 =?us-ascii?Q?PYmSoYiqxVO+IgkNbfmMGvuGtrv1ZLPkkwMjLtisr71SBwfb57pEghfZs0B5?=
 =?us-ascii?Q?nt6upRuNvPCCcRoRPybWY151nMQ2zFqXy7CS0JsfjaWw7CWkQmhMASRbtJqk?=
 =?us-ascii?Q?MzXUu9AhwobCepnNuh7N7Efg4he7h84JarobIivsgqYJx8iQA92dSgLVFbYP?=
 =?us-ascii?Q?TAXdoy8hIwzwCxMIBgfE9jBfi30q2Nq3bUmar7gLxsht/3ttF/WpAukZM4U/?=
 =?us-ascii?Q?AZ8MdHjDjGk9AbU7LZ9dI7vp9N1uR61nIbacCEYzKZvLuCBcclMivFSrM/ew?=
 =?us-ascii?Q?T0lom3xMY/RNprD5FVFY60lTPIcbp1n04qf4n/tKD+7YbA3LGG9kaRkPsYUj?=
 =?us-ascii?Q?cX6P0vt2ZQk1n4fIOHLmBJxSr2ise7IE9SJ9EJygPEcDJVvV9lFPo+Xapmk9?=
 =?us-ascii?Q?Tmmz83cHB4YF58pEF+8XOKADLcn0Uwnf7DTwsGQ4ech80b08VfhzrwKUAI1D?=
 =?us-ascii?Q?jfqMGtSY2VAiEYRY+cGsP4bVI8Q3koj5mee91h/o0nSqghlxTYVimv9i0RaM?=
 =?us-ascii?Q?DM7rx6Qq2zNKFbSkogTIeU4IN+R2BwiZCrv1S2hY3bejl/jsn80myWq337jh?=
 =?us-ascii?Q?yHiLeiEpzxIuxYG4f5U/B5y+m0ccKJ+ki8yrECyEx6NlRngfOv2eBavzRXiC?=
 =?us-ascii?Q?smf862SMKS9C/6K+gQN4bwkQVKHXVpWybX/Xyf3O7OD7kEkeaRM6bB0prXw9?=
 =?us-ascii?Q?b4OLro58Nku3iMUhdjfOPe9Viio+bjt35PPrN6dl9j+mFzjpwDA7k3w+rEI0?=
 =?us-ascii?Q?KKzPqsnk0jtxg08XLbyhmI0UlyYvDBCIyoAlhkaBNbnPLdVb1i0YAFsWD55O?=
 =?us-ascii?Q?iuCbEazdXUOcWQSYl8RmQ1ZxM2wRnNfnMr4gRDgSwUkat54i4B538G7ll1DL?=
 =?us-ascii?Q?f0Exk3uBbimChK+3/pQpp/3bURwjZNMFTZ39B6RcdwfVVS20GxArY6WXR69V?=
 =?us-ascii?Q?6uYLsx0Q2u4JNN9qWj4AuVvk3hpWH57hUMzhBZkbGBLGItNwXbRYhgv6YH5u?=
 =?us-ascii?Q?8/mDcShw2vO8q6snon8F3YLfsPsRIr6DgZDp8tMEvhujMU2iIlthhi29h9gF?=
 =?us-ascii?Q?C0rVJYkaNlHbrq+DVgDLfToSURc8pkvG0tJehGZ34z6EeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3152.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cr3q+drMfL0dFdPVJH0mkFUAYhVj2fpo7/6NlCbxnibO4Wrx1iWRjsAM3O76?=
 =?us-ascii?Q?6cQRPs1CZD3qVZKg9MxjsBPI6d2aTBuuk48xjVmrR5OQHsTFwGoBanqBWSOs?=
 =?us-ascii?Q?4wA+fP7JI/UZwm6jBR1eewTV6mJ5061GkzED9dTE+dfY7c9hIivi5yoIJ+sE?=
 =?us-ascii?Q?tkeUia3DFq7BZTgYM5cPOfrGiSvcI+wVA/Cs6edL3xAdZX+52d0jJyshFiJT?=
 =?us-ascii?Q?IKkhPw2HFeNVEFBcDLenqJ2+4kkC+C26ub+q09ubaUWs3YxGb69SGrVb9KNZ?=
 =?us-ascii?Q?7iuIDurldYEseKZJdFPnhFfue7Mng38yP5XitCrtUy2S2o+FrGePPuccfzA+?=
 =?us-ascii?Q?HSQDI2Edk5dhv+Fkih7kbW4RKGb1SsdiUGFnXd3RCE74febIVAQOQyka9ZdW?=
 =?us-ascii?Q?7Xz9Ns+rIS2MIcFH2pqYRo3hfeS2VxoccPpt9uWvHKVOpzcvj856iiqv58wt?=
 =?us-ascii?Q?yHASiDq5xnNWjtOLLezDT+gdteEmgeik3DEINI9zFo0KUB/OZNgdUD+vsu2N?=
 =?us-ascii?Q?985O+zmK8DIYhPTSO9FD2ujaInPzi2Fr+7Yq/h6lvo0ODlv6E1MMhfn2Vmpo?=
 =?us-ascii?Q?Tp/oUsyYk1dN7fT8KZAojDbKrFJCbhm3au6BpMpMJeUawRHZ4u6f1rBkqMxG?=
 =?us-ascii?Q?6RmR4Fzd+r2znxsED32CcjQ7M1zg/T+fkXEdghKw2F48AmFXYZuFyP2wc+Hz?=
 =?us-ascii?Q?eAPDmNkoSTQzJdoV3NzU2i0IcGdJ6brv9xbSV+tqZT3iDgYqsCC3FJeluseF?=
 =?us-ascii?Q?Z3N79IRhIMsp8wcKp72Ch0aH7dGIJ3jT6yUlt9diX7hDYkzB3XcQ60/qcl3B?=
 =?us-ascii?Q?K1nsLG8UJCcgPq3GVSYOx4GB5929KB3gt1C6QQj17wlXWtPGnc1mO/EFwKnI?=
 =?us-ascii?Q?DTXL3aZogGztlfPiOFvIzllDahxAlY1Rzg31JNbbYbiaiHXqhXHVdwe0CbQI?=
 =?us-ascii?Q?c69nZuSjiPiH/1MMQL5a3+7aBrg061jBXlODDKDAZp7GO+/27cQgvrFMaRQG?=
 =?us-ascii?Q?iVHhAIrnVUU8o7OZebjfe4W4yVUpGxCUPPR3j4vDYqEr4pciUFuWa4F/Xbtt?=
 =?us-ascii?Q?1URjhZiSXNHRtJuB8/JrGZfJs+yFOHkMTgEwiY0IS7a7X0y2XPoOC2w5aqVa?=
 =?us-ascii?Q?Pvql8xfLz/k9bdQkuRvSC2Z55eeh/6K4E0Yh5xZ+eIfHTlYUoh5sPowD/z3y?=
 =?us-ascii?Q?a5+j2K8BuW9CKYXCz82a3a/HCOwtrdYF0RgJNOSVmv3/D0jTYsg5f9KySP+T?=
 =?us-ascii?Q?w+BWJ+r+ZKid8xxId06bqcxAqTwnkgoshXJgK3PD9zCkMCMfEEiyMUSwwhsh?=
 =?us-ascii?Q?CgbXrKBallCV4F6XczGskR2tsHbjkjaSJeBKs9EJ+qBCrc0P1+96+0OwsUCP?=
 =?us-ascii?Q?j8eD4CH7YEp50/QhFIJDyc/ydEUCKBjDZbSKF43g6oyu9vdCA+OAMAWsS1jK?=
 =?us-ascii?Q?6cKa61J6Gld07JEc+b9Tf5MR4KhKiArr+NaYY43wAOnRuwhiSpfj4s2bUKYS?=
 =?us-ascii?Q?D7FbK20nTBDaVJtYGfPOB2ysHd/Za8OE0VfBvz2ErXu5Ur6QkEOw5BRuY46K?=
 =?us-ascii?Q?1mH4gduSMRXICb1yQs7976+0ZWk3ZbBHUIwsjGNhXBm+6nRZaZpUYJyMrpXZ?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816f2c78-a18a-4d8a-43bb-08dce82a6d33
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3152.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:20:09.9693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCSr5AllkhJpKWToHuuHPGQzQIfaTzEn71kwFWxtWltBHOb1OfpzQSu7wK54Kbm8Nz7gKih47+r54p1b9gvtihn6qsC598ycbK7QXU+NXsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5038
X-Authority-Analysis: v=2.4 cv=AKB5nO5v c=1 sm=1 tr=0 ts=6706209d cx=c_pps a=Bc47kgIQ+uE7vzpOcRUeGA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=QyXUC8HyAAAA:8 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=TATMwWlPqHHbbuS1RdkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 96orD1-kMW1-1Ant2yrB4V1Wl98bFq_q
X-Proofpoint-ORIG-GUID: 96orD1-kMW1-1Ant2yrB4V1Wl98bFq_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_04,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2409260000
 definitions=main-2410090040

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

commit 03f5a999adba ("Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails")

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

CVE-2024-36913
Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
---
This commit is backporting 03f5a999adba to the branch linux-5.15.y to 
solve the CVE-2024-36913. Please merge this commit to linux-5.15.y.
 
 drivers/hv/connection.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 47fb412eafd3..8283e7ba156e 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
 #include <linux/export.h>
+#include <linux/set_memory.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
@@ -216,6 +217,29 @@ int vmbus_connect(void)
 		goto cleanup;
 	}
 
+	ret = set_memory_decrypted((unsigned long)
+				vmbus_connection.monitor_pages[0], 1);
+	ret |= set_memory_decrypted((unsigned long)
+				vmbus_connection.monitor_pages[1], 1);
+	if (ret) {
+		/*
+		 * If set_memory_decrypted() fails, the encryption state
+		 * of the memory is unknown. So leak the memory instead
+		 * of risking returning decrypted memory to the free list.
+		 * For simplicity, always handle both pages the same.
+		 */
+		vmbus_connection.monitor_pages[0] = NULL;
+		vmbus_connection.monitor_pages[1] = NULL;
+		goto cleanup;
+	}
+
+	/*
+	 * Set_memory_decrypted() will change the memory contents if
+	 * decryption occurs, so zero monitor pages here.
+	 */
+	memset(vmbus_connection.monitor_pages[0], 0x00, HV_HYP_PAGE_SIZE);
+	memset(vmbus_connection.monitor_pages[1], 0x00, HV_HYP_PAGE_SIZE);
+
 	msginfo = kzalloc(sizeof(*msginfo) +
 			  sizeof(struct vmbus_channel_initiate_contact),
 			  GFP_KERNEL);
@@ -303,10 +327,19 @@ void vmbus_disconnect(void)
 		vmbus_connection.int_page = NULL;
 	}
 
-	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
-	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
-	vmbus_connection.monitor_pages[0] = NULL;
-	vmbus_connection.monitor_pages[1] = NULL;
+	if (vmbus_connection.monitor_pages[0]) {
+		if (!set_memory_encrypted(
+			(unsigned long)vmbus_connection.monitor_pages[0], 1))
+			hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
+		vmbus_connection.monitor_pages[0] = NULL;
+	}
+
+	if (vmbus_connection.monitor_pages[1]) {
+		if (!set_memory_encrypted(
+			(unsigned long)vmbus_connection.monitor_pages[1], 1))
+			hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
+		vmbus_connection.monitor_pages[1] = NULL;
+	}
 }
 
 /*
-- 
2.25.1


