Return-Path: <stable+bounces-89793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737999BC717
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 08:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EB31F21038
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 07:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990E11FE11B;
	Tue,  5 Nov 2024 07:31:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393D1FE114
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791894; cv=fail; b=IH2r2M26KbhsiJXM4WueZET3LwitM/lxNZScTTHoaTgzzHJNovpz82oLrSbXh+IpSleeDuqmVusPCbG//dm1g4HbRFoDuQbXROoQ5HJfwceMxycXOt0xQ87nlwiXAvTyybYCms9C1+YSNLyhfSoV8zjt2td0ulr61cuJWITwbJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791894; c=relaxed/simple;
	bh=D8qohAPL3d0NsS6KRHKl4LxRBtm7n4QyFXIzlcrxEIo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AN7lNXyQO5VZWt9Fk+ZcYoXYAQd0v+OGsqvNWGWbqarENhKrYj+LHUv+rFixqu2+8sWMKPaVFkWoWLTo3UsabbS8b+his+tN6eAQ3D9fZ065qXxDHycFB2YaxsCJoR152l+mYXBe6GUfRAxJ5WNe27UQm0s5CJz6c98LT2GJdhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A54j4kJ029805;
	Tue, 5 Nov 2024 07:31:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2044.outbound.protection.outlook.com [104.47.58.44])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42n9a0jqyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 07:31:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge3gPRgf2ivBryGNVcopX+oyjCvZ7PXHBHn8wIrw+m+009AGEqmUmetGgRdq3tIaEHmrcgn5An+8+/rtEj8vn9LUhhgpN6vUAPIRjokb0nCYw2VTqqfsvZyJ4NvA38UZZywe9e58UDtIZh0dB0/Z/3cKsVpAlOyz+5Jaulv/ihLRkLCUJi9RKXti5jmcsMo/uXr8cg332KL5B7e+5jL/kjrn/S8t179lKMR79osK5afce1XihkXf8qm29Vkg+HQCq/c+JRAw3YuxX9wPrMfSbnjvIgDeto3aHBcabV2v5XIEadR4k/6MHI5d8psn1z+vXj8ndt+AAlVDFBUjlmC5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BuRJ8RUgrn3gGYe2Ql6R8SIpPbrwoGaxopYcneRNFP4=;
 b=a4CApJMXOLg6/3a4RA3GLP1Kqab75nDOI9ISwr3MbMF6rEr4vb+YudCAqzY4uwx+pe36ezKYIW6CoXaWiJtEH/kDJxsZhTh5DXXiEZnENzHU6dEEbaCeqw6rvFq9qOFjBua6ye1mVZN3YhItIpP0J6TyLfdqey2fOwWAvHaC+tHavy+1n6a1WOOCVO0V08u9HTM80M9eXm7duP1/q3O53S0dm6EK0h3YdcO55oeY8EGcscB+Yk+0fp6BIZ7LIXbQn/I625klJoQi/m+GbgRhfEZCwDBkIcD3m8lM0nib2aHXBeOG3rrpohiMdRHdhaMNi5qYxqrLt6cl5kPaWku7jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 07:31:23 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 07:31:23 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Cc: cyrevolt@gmail.com, alexghiti@rivosinc.com, palmer@rivosinc.com,
        sashal@kernel.org
Subject: [PATCH v6.1.y v6.6.y] riscv/purgatory: align riscv_kernel_entry
Date: Tue,  5 Nov 2024 15:30:56 +0800
Message-ID: <20241105073056.3560336-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|MW5PR11MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d2cee3-cb01-4c9b-a1e7-08dcfd6bd9cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+n8EIEsHA51OEVgsF1jQa9BwXG0LIGGfLY05rntV5C79BtfYS+lIyyjzS6gY?=
 =?us-ascii?Q?Qq9c89VZEVqRuZRpSanR10MSvBNOSAjKgixDRLu2P9utg5dT4zlnMKRFEOuX?=
 =?us-ascii?Q?BR+VBtfb0BpwZ5Mo0c+0yIjRkDGpQzJiQf2JUcF+O/6xUcUQHAa59XROJow0?=
 =?us-ascii?Q?8Z+mgDLWm4D9qDsxRT1MOYgcgUo1oNQq/0cZMAhbVh/dQUwAopH2C1/pRKyC?=
 =?us-ascii?Q?td82YUVj+AQKoo7EdQAXS3w3RNuT9zhIm22ssYUKhuciPbLDIb6Vxg+t3T0e?=
 =?us-ascii?Q?Gy74DevzhVj6mYd1n2bA59P8vqKmwH0/G3VFebr++rL9rFHoVi9lFXajnyT0?=
 =?us-ascii?Q?7WlckubattF8lbcqy9MmoRlKbqusfLi0XOnBU/XLCygqetHoVM0O8TqoPlHK?=
 =?us-ascii?Q?VpZc5Tzg9xXK6CM6jloudINnaEjNdeobTtWCwj8diCVmRsHiftwbxPdon+wz?=
 =?us-ascii?Q?cmfQag+lafIbLoyxJXb++asNvHp1BA6cDokj2vU1Eaa8S6S6zUYAkd7b2r+O?=
 =?us-ascii?Q?rKbsmsEYDv1tDRHrcxQdWYfxWjRVg6IZq8G+QefG4s065y7wEwkFT8VgXeKL?=
 =?us-ascii?Q?Cs5G1YqmCGpInAV/gXPD2sKGN6nqESvFVJgFPE7b+UezYef+qVvh2twsb3+8?=
 =?us-ascii?Q?1mIsyebuXnHcP9Uz5w7l4x6hhIukXH1+8lV0f2NKPiUpAjY8MBGKzFqWbUTY?=
 =?us-ascii?Q?jb+28xNuTJgyN8e/fWnFnJ8AWTueEhxPn4PK5qb5O2sdfx3BQ4IUQ+Jkr6GY?=
 =?us-ascii?Q?c2Xbx3Nab8BP/fPGUSoewUPjrd6vF2tusu9nbIFSl8Q+V+I/6obpViM1dxLA?=
 =?us-ascii?Q?IEDA98tvkZcNqjjMAJu1taDKIlwQd8xqqLUo5O7BFsyPIJVIHbXyoSBtz0xK?=
 =?us-ascii?Q?3zqOkXKYJRCS7q6dIzb0aTK5Q+DyyzaRaYxLjWkNj5Gw/OgzpQr+aw0R/WUz?=
 =?us-ascii?Q?GHtuo8VW6zpnihjsih96ceYchA3iXOxxJed7LJB17ss4J+nfQ+Yl4svaim3K?=
 =?us-ascii?Q?MsT+LAAO7dNtCliLtnw7fX8T6CvuTTP2R1pOFvEZUBT/5m2ZKKoNw7JV313w?=
 =?us-ascii?Q?75lYxFYRo5Jc1SIj+kKn5JqfpNPuKBShTXtJA7boD+Ovljy5KvSFlogYKR84?=
 =?us-ascii?Q?NY2g9JbjtWWJo14/S/TTDgRZ+uWr3g74Sotq+EjUJwgw8Z9FOB8QOt6Rusox?=
 =?us-ascii?Q?igK/xYjrAY2u1P5G9UipzxmgBeh9gNEBAKSwwlKFVQYmsXmalr4eRDfF7HYQ?=
 =?us-ascii?Q?QwAOTFHWLyXBtvKxut8PuneYMdrdzeoQxcVFV8i6QCeNMsOuqXVyu3N/vehx?=
 =?us-ascii?Q?4yoOfdV4NspE7QT9A4hDhUsH5y/GvH2DQjuHwhYtuGfrSrtgJX63g2+PiW6b?=
 =?us-ascii?Q?ogDVHfpHPMdmK3IWJ7yWUhK+K0uU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?74dyvnO1j6lNf13kcLiGLtIGHwNTJeAY/t/o3z3yJB3n2C0Y1RvtcZLMbDWY?=
 =?us-ascii?Q?fkItZiW9XZA+oIMZ/Nc+PAcO0bA2A1AchqEbr/feAiybw8zzhTt77hmb/aWO?=
 =?us-ascii?Q?87t3awic6rJcrN/LwiloQP8tIw2EqNC8FiGtGKpmbPbuEWdoGZWE4m6TdJ2u?=
 =?us-ascii?Q?iB5Pr294NH5JAomiDswKoYrDilIbcBiFshJu/wSUhJN4VymiDDeC70vN3IB9?=
 =?us-ascii?Q?EBqJqm+dKP5CjTjH0kLxHoMI4lbZSJBRn/l8UrbgyaqSbuvMMVLzz9dNo6g6?=
 =?us-ascii?Q?XXLNhkird8K5y2rjtlbIwE4td95rcqa0Fh8+pU6rqW/feA9GhIqNtjN+WU+o?=
 =?us-ascii?Q?S+TKxady+P3FD2xIx4Is6bYfKpzNGbBvLYbWMq1RGdu8aiynDDKzy4Z9xWun?=
 =?us-ascii?Q?7BF3KCcEjE5hEVHuIRDPoug0v87G3/MVCKoQdz5WVoutU+voDkOAHBfoVA+W?=
 =?us-ascii?Q?GTXMfL5jSvHbTJXtewOdC4H3ROd7akYDJM6kxMXV1K7ErXQAf5h6oArvcZFM?=
 =?us-ascii?Q?D+kz/ULnOW95dxhXhVv5FKq8vCXuFIKFqOff7EDc7JBsjXgPXsR2nBeDB2if?=
 =?us-ascii?Q?r8wssNhC6zMLzuEmxvYgVt02F5nWEaW28FMXDfA6M7m3K5FM8c/yiqLk1zX+?=
 =?us-ascii?Q?MXH+vXEVq0f4NHAULYsv3YnGsKMcw5h7gwR3qUiXaxL6OSGf8iWIMbhq5Ly7?=
 =?us-ascii?Q?YFu5D/M+t+em2sv6mmJqmBC450symldguSbclQiGPrfOXT21zzczb2jEB5Rq?=
 =?us-ascii?Q?hNl8VNh3ffbYgAkAvz5Wk/UpTKzNkj3+E/FFNQbDqFrStqLsJ5eSgRSBBpyr?=
 =?us-ascii?Q?vl8JA8D00B9D1Yl413cbjo1P3UBiNEZ4bN8SScFuwh2Zrel/dVkJqyhabKQ+?=
 =?us-ascii?Q?utZYH3+KGQUZaI4N62EVA+HdOgfiCpDiJ1HkF5pnY2QcV46g42+imLdQLU8x?=
 =?us-ascii?Q?MhVuNrB4T4ibF2exuk1boq4WYHiTwjoOMoGQjXBUWleVlGuUeSHoAGZ6qcrb?=
 =?us-ascii?Q?GMZ9OwxeEv9YXX69lIxFUNr98/7m5vTSoRQG+TZ6hz1ZlAVvo9+8pHiCRqgk?=
 =?us-ascii?Q?jDrwZDk8ERqa7zuUqKlfLoGXIDSIB/4WM8SQvdbCgcQB1o7MZxCK3Hx3PnFG?=
 =?us-ascii?Q?Y8HRQUe/mqh+6DEUogYJfB4FO1yMZgzyS91WDyz108z8eCl4YrcvMhA+0Rj2?=
 =?us-ascii?Q?PWu6B2nwzRQHmHCL21f/fmmhuo++DbZ4vuTBBLOa4Or1GvCC4xA6dLeDNV9g?=
 =?us-ascii?Q?jpmFqkaJ1g2/chqOVtyd6byKBF92TK6jKz4AxD4ui23t7uHfgAngoxQ8LBKx?=
 =?us-ascii?Q?pBKFNn6x6YkLffjkST+88jRYnzp5dQ4wNA++F6f1l3WM2n5YMWPWXupENLy7?=
 =?us-ascii?Q?fd+esABOfrMco1R7sJZiT3QnXEQRQmeSsROCj41mapOd1eRV1Xzd0jbcber4?=
 =?us-ascii?Q?1m6p0ly+010sghotVBv3mh3GScDiFF31tZKDSxed4OMaPRDOVz1vE9VKcMsR?=
 =?us-ascii?Q?vAYHx3gMuPTZDwtRURQwCvyYgRR378J1j/RA0E/fDozZ6T6oConByg23reoG?=
 =?us-ascii?Q?Tx/n2boFmcdZJA28Cn1aDCMFQzjp0B1TAukeUZWdtMjCxgX/upupgC6fqmmJ?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d2cee3-cb01-4c9b-a1e7-08dcfd6bd9cd
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 07:31:23.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/T2MKNnfsxPflMD9o1JlK60Hez4IIZ3fZaT2UjApCkfGQjCBs5YxwbI6WO7DLV9l3jE+fCVCsHaiYztYsldl6CzUiXGVeqGOXL3vqymbE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
X-Authority-Analysis: v=2.4 cv=H7mJwPYi c=1 sm=1 tr=0 ts=6729c9ce cx=c_pps a=di3315gfm3qlniCp1Rh91A==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=bRTqI5nwn0kA:10 a=mK_AVkanAAAA:8 a=pGLkceISAAAA:8 a=h0uksLzaAAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=GeVlq0rgLwz5aExdsfwA:9 a=3gWm3jAn84ENXaBijsEo:22 a=MSi_79tMYmZZG2gvAgS0:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 2utROnWg45sXPcR6JM53J5Jy_8UMCTvC
X-Proofpoint-GUID: 2utROnWg45sXPcR6JM53J5Jy_8UMCTvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_02,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2411050054

From: Daniel Maslowski <cyrevolt@googlemail.com>

[ Upstream commit fb197c5d2fd24b9af3d4697d0cf778645846d6d5 ]

When alignment handling is delegated to the kernel, everything must be
word-aligned in purgatory, since the trap handler is then set to the
kexec one. Without the alignment, hitting the exception would
ultimately crash. On other occasions, the kernel's handler would take
care of exceptions.
This has been tested on a JH7110 SoC with oreboot and its SBI delegating
unaligned access exceptions and the kernel configured to handle them.

Fixes: 736e30af583fb ("RISC-V: Add purgatory")
Signed-off-by: Daniel Maslowski <cyrevolt@gmail.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Link: https://lore.kernel.org/r/20240719170437.247457-1-cyrevolt@gmail.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: bp to fix CVE: CVE-2024-43868 ,resolved minor conflicts]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 arch/riscv/purgatory/entry.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/purgatory/entry.S b/arch/riscv/purgatory/entry.S
index 0194f4554130..a4ede42bc151 100644
--- a/arch/riscv/purgatory/entry.S
+++ b/arch/riscv/purgatory/entry.S
@@ -11,6 +11,8 @@
 .macro	size, sym:req
 	.size \sym, . - \sym
 .endm
+#include <asm/asm.h>
+#include <linux/linkage.h>
 
 .text
 
@@ -39,6 +41,7 @@ size purgatory_start
 
 .data
 
+.align LGREG
 .globl riscv_kernel_entry
 riscv_kernel_entry:
 	.quad	0
-- 
2.43.0


