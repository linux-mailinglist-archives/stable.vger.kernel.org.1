Return-Path: <stable+bounces-23249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DBB85EBC2
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 23:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550241C220D9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBA12A158;
	Wed, 21 Feb 2024 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sVEEBeZW"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A50129A9A
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554101; cv=fail; b=XiLyHTWPYIA42/J7JGdwHY0hi81jKUaehPnk5eZUq10Tl7St9bfniBGkDDi8Jd2dV/6nteD/z8kVXJ5hTKiaV5EQIxHoQ/QnXTgETDylcd4G+HnUj4mNImuay8rYYps72IDJSQZ7NDT4bUBZqMkpU6M7003kYTsBabHgNamV1rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554101; c=relaxed/simple;
	bh=UuoMCj2Fm1t2aEcmBGLGjQOPHOLkGIZwmr9CKr5cuqc=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=GNN4QyQfbbdjLax59/snenw26nY6uFxKr6W2BES16W+gqpn9EXWgUgDy5gXTDMUXPp2wPpZHtOo0UZrCt3OyvVdYlfxhUD0rBovtSjYRkt9tiYmv5uPkknztoUT6a9LO4MilqNLcHaawr9tqbFMcRJf1Pj0yFylOFCowxk2YOss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sVEEBeZW; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7UjVxGs6t0ioKKp9bYCFelMa1renUPx++uHqqa5LPQwhaUBByDOOPfXlj2sQ7XG72NmF1suuL7eyBQsNiZ7zFFpswAM1HRa57Nsz1VvCL5M4Z/dUP6qwcH/LXlqA6/tCjnCLazkJ/0+mIgeGjcnxpnGeMP1n4QZgL8W4yk4tZm5HMDffPPU9z3bJ1MZ3/TGK63WGw2sAxNP7sKFxmPByUCXizdZpv+MF5z61AK2Kq/LZMYVDL2VitPVFmahMrJTVxY9eB5IoC2nGerdwZmk7LGRVEa2sUovgTR6IdRDl/lVYnp/aFgNfG++KubvxtXlv78P/COLAlO3NR4BbISSYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04hcrvaSmPQnmDv25ekU4EO4DXZJLAqbv2F9QtL/ReQ=;
 b=SjrFqQOjUXPFsXsyUuQgjriI4mPlGiBQdxHzcrbEMwNpfp6pz/SSn23e+oeh6GQ+SG07r+tYaIHFNey3YQVRznSyO48vj3dOv07+wyDCNelpnky0cNJJ6G8FZ2qemtYuQ3PjAab7B3BF2hEYCw94SVPC4qwv2iy4e8756jmbUdV8Rb7dFCYaOvdcGL916/pzeHgqmYFeLeogDbOfJC4IK4mFStUK4WWkXP2RYJ9NGEhuZmR20PeEOsA4J8qjNeIKJGZJpe4vclYniyZePpWthAEzBGLVzSNj52bDyNuwZSl2axwgh9xIPyGQ5j5jw0TcFpOQeEzbrn5TY8ud8Ck9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04hcrvaSmPQnmDv25ekU4EO4DXZJLAqbv2F9QtL/ReQ=;
 b=sVEEBeZW1YlJZSdHFLIJA8JLb3vUQSswSwtHjKK2viDYVTpbjy7HhiYeTx8pACwQYcgUlNq4hEjwzXPGC1fwW12AbGRix6MpKNyccUbhrGDtAr88scwc2yAx604QEezAA88F06jzZa+jro/+VedgFfAV6fWqyXkupibSIlsir9jvXZ1OkU3iN9CQaXcSux6mqUHUBDJXcj54hPqcr3VscUkxufBmKBJCaT5SYbie/g7Zv85B0866gOIklkysGi8FIm6Uz98Ki8MMRRmNOgR8ZxAvG8PbCnebfyWB89sgmM/deq8ml3Jp68ahVw63xXeCbyQvAhVefj54JiH/o1oQCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5268.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 22:21:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 22:21:23 +0000
Message-ID: <776b3967-8346-460f-a024-9d2595a474fe@siemens.com>
Date: Wed, 21 Feb 2024 23:21:21 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6.6.y] riscv/efistub: Ensure GP-relative addressing is not
 used
Content-Language: en-US
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0043.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5268:EE_
X-MS-Office365-Filtering-Correlation-Id: c4680402-cfdf-44ae-6a10-08dc332b6fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k62UNk4wB6uqt64gIFHni0eDoAKSiNjZJBhy0guRTL54u/ZhiUTVbDh2Dnjqm+QA9TQ3EKH6DMpk+ayXFziQfodMGiwiRreGUCMXRMUGY2Dm/fddfc1amEIWHzgJb88PAd6FV1D+aK0pu757bpDp9X/YPUvxmV2NdAECINRPPxx8gV3ugvlrKU3TzSdAiFbHllgJ6bzVITSoIU1vcLugxRCEcQVLKhj/LtzGvwSZXFkxuX9Gbd4tuHliAkSYuKf2Qdrgi9jJ9VM1PhYNXWywgZo2dQB6WcboEEGsM8b/p4QCsl6wQ40GSXqPqYsngm4JrYqaEe0A8P+vdY29EPqwt96kWjGHV2NtUYrKHEJ+6+OLfUtdOe/ph70fo8yfc1AH5F4CNTfwHsUZ9hJsVGsDJrdlehSSGG2SHC74HRIbmqMt0sgCBSJQjjdJAy/vPLwhm5fLPsWvT0CMg+36MlM6PhFosGr0mTqQJ78onApZ1LTbpEHwf0AcZ/rzjfkUEXj7IWe6r0vyPorD55p9EchlkisNJJRkQ3vHjLsN1AWwAdo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTdMaHZ4UTNuNEVUR1Z0V2ovUGlTQzBmNHVvSUxBWkUrVXRaM2toTzJhK3ZQ?=
 =?utf-8?B?aWJIbWEwV3ZZbHI3UUVkNXRVRmxIcU1IR2pSM2YzVjFveDVJNFNvZkk0MDQx?=
 =?utf-8?B?MS9SZ2FLYkd1Ym1nYVJ6bFZVYjNOMzdIMDR6RTRHM3piZ3BoanZXS1VaOXEz?=
 =?utf-8?B?T1hrd2tMSkdMdWsrdVB0Snkyd1F2WGRBbit3TTFZTW9EaVRqczd4K25jekpU?=
 =?utf-8?B?dEJBS0pGc2VaOGs1U1l1YzZWQzFlcVNFa04rREVSWCs0Q3BqSGRsQjh5a29D?=
 =?utf-8?B?amp6NERoQ01DcnRxRzFSZXRDR3paMTRZZVBkSmJRcE96bnFkWTNHaUd2NDVw?=
 =?utf-8?B?TEJmOUFyRWgreE91cUxaakcycFYwTnlqNnFvTjlyNFArcGZqb3RoQm9tS1BV?=
 =?utf-8?B?ZFdYQmtFYmt0MEtTSFlzelZXZy9Td3BxNmNGZ2dKenJsaW56MjdDZzloRWcx?=
 =?utf-8?B?VDIrc3lBcTdhWDcxeTJ5Y1VtUGRwUmlEK3ljeE5YRlBBOTlHbUNPR2E2U2tY?=
 =?utf-8?B?NnVEV3pubUdaQ0FNbzQ1SmdtSDVZMFo4T1JnZXRsZWRDdUdzL1psc1A1dGEw?=
 =?utf-8?B?NUQ2dllMYS9ESFdGa2dISmtvTmpVbGJOa0t4dUJDdXc4ZVN4SjgzV2Jid1Nv?=
 =?utf-8?B?UzB3dkdKelhaNHJXbEV4bFYwbkxKQ0orSXVmcExTMzNsUEMxSnNuOWpIVGRO?=
 =?utf-8?B?c2NmTm50d25JS0E0ZGphc3dHMHkrNXYyK0tzYUcrb1grbWUzYnV5ZkdjMTFP?=
 =?utf-8?B?a01KOERtUitVSU55MFBKeTR0TWJlNXBSV3Bnd3JrTXJ5dE9FOEpxSnZqbFEy?=
 =?utf-8?B?S3YxL0g4dkVmTDVkWFUxNjkvTkxJYTUwdXNJazNjUENTUVJsdXF3NHNZRlB0?=
 =?utf-8?B?U1ZPZ05RUnRSemZqNVN3Y0NwaFJwZ21UREdNbk90LzRPdktIMngwN1puS1Rn?=
 =?utf-8?B?Ky84WDNkaEo0OEhjU0RuYUxTZjZvdi9OQ2lsaXdNZ1lCTC9QSG5rcmNVZXE5?=
 =?utf-8?B?QjhTZlRjb0d0dUJWTjVTSjNPZkszTzdWZGM4dDVUVTZoM0NFZ3hEcGFHZlhz?=
 =?utf-8?B?Q0dFUmlERzRxUzB2aGdIVXBEWTZHTHYyOVo4WEd2NTZhdENtdlh6dmRTU2Vk?=
 =?utf-8?B?T01EY0JzcHd6cm9HZTQyZXF0aVJyUWJyeWlUdDNCU1k5RFZIT3E2N1NSWDFW?=
 =?utf-8?B?YTlNNjJZaExWbHRndmtCRUVUMkZIUWx2aFA5bVF3enRoeHBPNGJDS2hDQkls?=
 =?utf-8?B?ajZPOUhLbzQvWklUWitubjhoL3h3SDV6Zk4zTjVNU3IvcUlOakdXbk5tZ1d2?=
 =?utf-8?B?eTRJYmkzd0QxMjYzVTViT1prSkJ4YXVHQ2dkaDNybW5UbHRkaWt4VTJjVVky?=
 =?utf-8?B?amdlNktUb3dZRzVlZjU5N0FSOEtjWFgxM2F4Nnd3VzhOcFRqZktvYUZ1N0th?=
 =?utf-8?B?Wi9wc2FBYm5CdWRaSWdyWDdoL1FLaWh3UzRrRytuK1h3WW42dUhQbzU0UE5K?=
 =?utf-8?B?SU1QME0xQ2pUL0Vvd3ZHOW9wS3FpTHJ6TzEyV1p4Mkx4ZVN6aDdMSWRtSVow?=
 =?utf-8?B?T0FzN3pkUVczdUdoalowZjVkb3Z1TWlTT3ZPM3BhTy9kWHBvTVVSU1dIc2JY?=
 =?utf-8?B?aUhyN3o3d3Vjc3E0OTJrbDFyUFZHVkZtNzFUVis5SENKS013TjdTQnpKVWdV?=
 =?utf-8?B?eWhQVVB1SzdVRnptMEExaGg1eFNCdFlMZWl0WTJWZjJtWmNsb2ZYQS9HU01a?=
 =?utf-8?B?UmhhWHltb1NTcHNUM2VOY1FiY1BDUElvSjdEeEpWUzZ5QTQyRXNnOXA4eGNU?=
 =?utf-8?B?Qmp1SWMvYjRkQjJFQnZxYnRpcy8vK2N0eC9PZFBCOXJDVHNyc0Z4R2RQTm5p?=
 =?utf-8?B?eTd3UXZYOW9hcFBydUl3T1hERERHYTVlZjdSMmRrd3NxbjRFTUVLT25LcXlO?=
 =?utf-8?B?S3lkSU1RdmFYa3luQS83MFc0ZkV1M3M5c3dOWjhGZzZHd0d5c0tKcG1iaVVP?=
 =?utf-8?B?a1BDdmNjME9mbmNsT0x5VGJNMENETjUrb0JCaTNGMzVSNXZlWTZMb3FFSStY?=
 =?utf-8?B?R3J0Z1FIVDZNdzBLZFFtVld0aHY0d24zSm9YVzhhQ04zYVo2bXYzdG9rcG1W?=
 =?utf-8?B?Ry9Ccy9kRGdJQWVJaVc5VGhQTVdKUTkxWVdkSGliK0RYZWxMV25IOGNZUmFo?=
 =?utf-8?B?K0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4680402-cfdf-44ae-6a10-08dc332b6fe0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 22:21:23.4218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jIpP1nhkuAcZ3XmJosuc3eWkO7IrHuYCerAfPSmw9vTn5r7C/qYhEvExsDZiKPKq5IVf/U8pzujlC1AEeomHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5268

From: Jan Kiszka <jan.kiszka@siemens.com>

commit afb2a4fb84555ef9e61061f6ea63ed7087b295d5 upstream.

The cflags for the RISC-V efistub were missing -mno-relax, thus were
under the risk that the compiler could use GP-relative addressing. That
happened for _edata with binutils-2.41 and kernel 6.1, causing the
relocation to fail due to an invalid kernel_size in handle_kernel_image.
It was not yet observed with newer versions, but that may just be luck.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a1157c2a7170..f54715672d52 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-cflags-$(CONFIG_RISCV)		+= -fpic
+cflags-$(CONFIG_RISCV)		+= -fpic -mno-relax
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
-- 
2.35.3


-- 
Siemens AG, Technology
Linux Expert Center

