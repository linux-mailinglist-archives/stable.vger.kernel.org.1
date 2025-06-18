Return-Path: <stable+bounces-154627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D13ADE351
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 07:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772563B7727
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 05:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9CD1EF0BE;
	Wed, 18 Jun 2025 05:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cdQkTfgX"
X-Original-To: stable@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C2522F
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226319; cv=fail; b=oCo7cB03OdPNudjUVg/fle8Cs67ouGCMNVn0gg12zx4mBjTimIMxK84GCwE6Ub54pX5ExJwM7Rju6KXhbKgXJwXlgLIMeiL6npJKY6DRkRkHolrW9ThfbX2yTaK9nD9SHIwH0IiL4IdAUPQqG/aaSQExbXZeBmo8Cc8d/GjUzpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226319; c=relaxed/simple;
	bh=N+GJSRKck9XcZ8qvVYoYfvb3h0mbD8rfAZIIlCpOiZo=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=NzN2qzNhYAvv1dfofVqn9KUcvCIPHy9Ut2goSEl313q154fi3DVfTp0U0dzFGsAZGfNvxE1tLu67lWGnZnheB40siabIGYR8wZQ3hFmCIp2ktkHE9T0E2b2NXjeDdbWGu0r7/wTM33VEe0MvA+9uGnO66e3RCiDENNCoKibR02s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cdQkTfgX; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YU2zx0Y1iCTRJbGVNsr49byG4r64iip6AZELYO6/OSwHokzb/7LnPahkpm/1ZaUtE98tycOJIsM2k/ZlJs4Y04KW3l9JGpx6eQOOe2WLb65yvU9FxJkePGZstWyfgj53y25GDVpANLrLwNr/DrIO9J7ZIGKmdae4B6XRa+gwOEMvBScuRqw2VX+76pFTo8u+YVLyxfR6/yY6f+ST4vVL8vBPH9c+NQD3mpM+9d4ROZH5RmdqI86/dbMyfTIRYL7Tg4r7CfeZ6Xj2+qoI/aVkyyhr3WE9dZtweXgabznUn2ulTmgiiB5gTVpK+/HoGciB5RuS/0rtvhFZ+GyK++dZew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eVYhqU3B9EN/Ko+hj6iiFGwNgXerPwBK8Q84A2JL0Q=;
 b=giCP6b8MWUrK4862FwojFi38QP6fWvHP6qQD9rLhmOv8aeawD0l+tGBehPRDW3bz3x6qEYN+7CEuO/Ra6MV/gSKJ0RMFxJP05zEZjyg4sVWLQP+gheahuIV/yPRBiuWwxyDZhpRTVqdwn2JUtJO7Lb2GEAqTluynb0HWgKbsM3YcZ6CWXVOCNWelaHaI9DPCEhqIaDaQVTUrvPsKoSBF+t1r1uZFAuCqdQG829lfCxg250L0T4q5IQqZLAcOfs3X1VWmZ/NB31eM0lB83ur7BhmLTSTjBeVSwtxhqxFC2MHOoAS2oEW0Rt7u4GVtxLr5rrgn3RC6eOgctaUZfcL1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eVYhqU3B9EN/Ko+hj6iiFGwNgXerPwBK8Q84A2JL0Q=;
 b=cdQkTfgXZF9NpGR9Gn3TnzoVg9DL9ScgixykA5HucZHCN4M1YHpGD9adWnv4cnE5H9Cur8hHhi/bKz2qiMR2fXa7/9UOZRB1gWm0V0nc4AmOtLLOzhu0kZUlP4w/ixV1tBJo4cJ9tDIEEtnIA+E72ha9ZGsSlwKf35Om/o3RCApaf3wTyNqP7yyN/lCy8YC37K3drjlSyITxzMpt0Xx8SP4z57wr3G19l2ak3rlq3BNAwryCULyag+ye/v1lVPODHsYfxUPvnUhALm1MWnhQHmMp++xLm2Flfv4jALAv6WfNEUuAUcDo5k9/plaYy3rkMtHSEzQCyY9SmgIe8qeXLg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9601.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 05:58:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 05:58:32 +0000
Message-ID:
 <PN3PR01MB95974E38ACEDEB167BAA2BFBB872A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 18 Jun 2025 11:27:36 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>
Cc: stable@vger.kernel.org
From: Aditya Garg <gargaditya08@live.com>
Subject: [PATCH] drm/appletbdrm: Make appletbdrm depend on X86
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::22) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <f7c0bba8-ba2a-48c1-8acd-56a1c557cd61@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3af8d9-38e8-48fa-3c39-08ddae2d2720
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8022599003|15080799009|19110799006|7092599006|5072599009|8060799009|6090799003|461199028|5062599005|3412199025|440099028|4302099013|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDREd3hkSjJyenVlbUlVV3NuM0J2YVgxdGc5WEJ0WVF0RmQwQ0FlUy9tdVkz?=
 =?utf-8?B?Zkp0M2RVR3dpTW5BbXNzbzV6ZEMwdHBUQWpoWTdVOWRSMWJsZ2RjQ0JzeDNp?=
 =?utf-8?B?RDkvdnVVQXU4MHJLd3hpSS9Qb3ZmZEdBQXRwRy9DWTlzN1Bicnk1T0J5MUZZ?=
 =?utf-8?B?OW9TZWhOYXUxUjhtVVRvQ3p2U3Q3OFZPZURvckthbEZQcG96VTZ6TWhHRmc1?=
 =?utf-8?B?RlZKb2lVZ3g2UURaWXdjaUlHamxBbzNidnp2ZWlScFRhK3NOSU5YM1kya0pI?=
 =?utf-8?B?V2JzVU9Tcy9YVFhCZTFHbno1NDdVSVNkOFc5OGJKTC9WRzhUZ2pNV0hpQnVz?=
 =?utf-8?B?Nko3ZEp1VzFYRHAxRzdmQmM0cHVIaUFMWmNzeXA4R2FUaHNsZHRCSS9Wek5D?=
 =?utf-8?B?RStPc3FMRDgvOU9HWElCbG1oYXBJNWFDS3oyeDhYV1BQVHowYUpnOTRnS0V2?=
 =?utf-8?B?NjZQNWltL2ZRb2p2NWt0Q2xKblBlYlFvdFpmb1FsQ3M1R3lRRG9VZExYYzQx?=
 =?utf-8?B?VzcyVzdCZVhpaXd4RGdVMzlhQjBmTkhNZWRSeVZ3R1IxUTNvS2wyZ0xQUjQz?=
 =?utf-8?B?aVZFajNmUXRvNWx2N2ZPYkxLbjkvbnorYmM2c2VHTkNtNTVaTURaU3NJKzY0?=
 =?utf-8?B?MFlSN1h3MU4rUWZhbGxYYlppMXlYelpPVkNlMGdKb1dnWmc5KytZUlVHdWxx?=
 =?utf-8?B?eVdaYy9uMStGYUlQd003dzMxd2M3WHdzTGZVQWw4R3J6NHJCOTcyY21rYmxk?=
 =?utf-8?B?V01lSndjd3VQVlRML2Q2bXE4V2RGeTU5bklaWU1BRjQzVm84b2o4bUcvWk5p?=
 =?utf-8?B?eEpmeHcyRTZBdVFRazV2VkE4dGhPNFY2a3YrNWROa0VGRUdLVENidjdOcTY2?=
 =?utf-8?B?QXhDUDU0YzZGZWJXVWU3UCsyRG05ZS9TQmx6TWJZMzRDNWdzMUpDMitVYkJY?=
 =?utf-8?B?SHUzSnNCenJlQjdva0tTNWVYeE05UUxQWEtCSDN4L1NUQVE3RGcxdW5WYjh4?=
 =?utf-8?B?TVNPVFVpQWZYcmFDSEdjT0p5LzZxRlp1eGVlcVVWUWJMZXRDOTBhN3RER2Z2?=
 =?utf-8?B?YlV5cTBuOVBOUUtuT3c1VHVpbm9KTmsvOVhNTG1oemNIR3hmWU96M3BLSndh?=
 =?utf-8?B?Slo5T3R1VVFCL1o0S0JHSlVwZllKbHpkdjZWajJvdGViL3gzQUR2bWFMVHc0?=
 =?utf-8?B?YlFRQjRnR0FXNDJ4RGk2SE45Zy9lQzdhQTVxMkFCcTBSRzIyVjNzL3ppUnhW?=
 =?utf-8?B?L1laK1RsTVBleTg5RmZYRUNDb2JkcC9kSUpERmNCMzRaOWJWcVFSVFNxNElR?=
 =?utf-8?B?dm9PM3lSTnNQaWQwb3RBWmRVa0tlVTh1Y2JPazd3KzRoTkFhOTdxd040YWxh?=
 =?utf-8?B?TEtXNzg3bXhsVWdyQVNQVG4rcTR3MGN2MFZNQmdieFFCdk1jY1l2Z0pGemta?=
 =?utf-8?B?bHB1OWZYelMrSEV6YSs1Z1dGdzVqd1Y2NGdpM3A1aHh4QXZveG5KRjlMcUxt?=
 =?utf-8?B?S1N2LzFQRXpIekJsRFhpaGtaQXNNeFR1dzkycHZNK1BURzhBSmF3NlZvRnNl?=
 =?utf-8?B?QUxZQno3VjF4eVYxWW04QWpiOTViY3BUeHN6blhJT0M0bVF6TGRJRW9xN2hU?=
 =?utf-8?B?RnBGV0hlRXgwMCt2aHdmU3ZzOXNQMmVKaHljc3Evc01CeDdxMG5mV3p6S0FZ?=
 =?utf-8?B?Sm9UV0k1aWNiUm00NnpEQk5MWno4dE9rU1Z5TFEyQWpSZ0FrbzZ2YWZzYVgz?=
 =?utf-8?Q?0LuyLNqZjB70inSfGyMzVUb5U+pyj9YT7+8sRA2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZtQjJybUYrbGhvMC9NYlBLYUdOMXcwSlFOcnR1MmJuZXFuVHpMcThxck5x?=
 =?utf-8?B?MDdKeS9jSjhWV0dtaG0raHE5WkdWK29RdEQ1dWd2ZGFRVWFTSDZTSmV6bU1M?=
 =?utf-8?B?eWFnRisxWTUrUlova3Y4cVNIZUNpRGFRNWFrQ3EraXAyQk4zQ1dwRTc3TTBa?=
 =?utf-8?B?T2RZSkhiWkF6RFNqbjBXeEVjUkYyWHAzcWQzSXpaNkRKYndJUFlvdEtEMVQy?=
 =?utf-8?B?SWdJRFJQdE5ZcjI4VmF0UW0wYWxFRlJVSWdUM1R0QlJUNzdKa1Z1UFYxWlI5?=
 =?utf-8?B?MFdac0xJUGRJcjRFQ2laZGdFalhaVlFhamsxM1lmZXRuaDNyTUUxV2V2a1Ey?=
 =?utf-8?B?MVVwc3NIVitkN0dRZ3l1cWx3SGZEUmk0ZHlSSkNKZHQ0bGppSVB0a3FldjNU?=
 =?utf-8?B?azEvRml5d1A5WDk1b2pTQ0lhTGJZT1JRRWUrd05ybTl2WHlWT1pmN0Q1VnFI?=
 =?utf-8?B?NDB3cjhOYmRYajYvMmZPMWRjdUp5SS9kbDI2M0U3QWpuUlRFWWora1ZSTDlR?=
 =?utf-8?B?RWdUMnJlT2RMVE9xMEQvb1grcDRaRGsyUyttS2tGOTV1eEJVWXl3aUhyMXlI?=
 =?utf-8?B?TTMxYkR2bHIyNDl6T1kzRWc3Vmp4RGxqVS9TS3hjalY5eDJsNGJld0VGVCty?=
 =?utf-8?B?am1XWmh5bm9JSTc1TVlYNnNGWjZhMGhQZE1FTGptTFlRNXVrQW9RWVp0M3RU?=
 =?utf-8?B?ZVVGL3BxTUpVUGs1MzI5YVFNa2d0UERBNWxFaFB6S3ZNeE1xYUlDVWlvd1kr?=
 =?utf-8?B?ZTBPbkJBTk50YUk2azh0MFVIU1d5Q1NrWmwrbzZ2VWtuNDBOL0RScVQ1Qm5a?=
 =?utf-8?B?RXpIMXV3WmVGamJsdzZIbkVabUZNaFBOdXdwcFZZdlhQY1gxeUFWT09zL08w?=
 =?utf-8?B?VlptOUttS3MvbEtwbDZrSHVhNGtTUDhEbDRabjVCZnNWK3Q5U1NOcU9Jdm02?=
 =?utf-8?B?UG9yTFhQOHpoMk5SUXhxK1lUaFl0a3NjMVpEcXdpQ3N0MVdhZjVDSXhKQmlq?=
 =?utf-8?B?dTUvMmhpZWdjOEI4V2FGMkRmd3RMYTNpekVyVmZUdllKanhiaURuTm1YVDRv?=
 =?utf-8?B?OHhuWHJJbnlHaXhJWXpoSW13L0NWVnV4R2IrSHV6eE54cmFNSk9JS2NFdlZo?=
 =?utf-8?B?TTlGNEUwOUk1T1lKY0xURXhkYlJzQ2pOdWNDa0pJSE5Hd2dOZTBGdjBzNll3?=
 =?utf-8?B?azIyVGlRalV4OW9ML3BpSzloN3BIRHFxQytzRXU4NTRMVEhndWljT2gvRUZT?=
 =?utf-8?B?eGd3UlF0YzFhTTRuY3BsbmZIcmZIZ01xWGQvYXNHUlROMk81cEdPSkhJdnZV?=
 =?utf-8?B?eGloZ3IvMDI3enJFMmE2b25qdDRPcWIrYVNHR3RLNmYrVzNielZyTVlod0ww?=
 =?utf-8?B?UW9qY3dOa1ltVUE5RGJha1FPUGxFOHVvcUphbERTbHljUVltdWkvYmZQK0c1?=
 =?utf-8?B?MU5BWDNkZU5jeHdPWmNtNExwSXk1a0p1a3dZWmpzMEoxa0FVcVJPQVJ1c1V4?=
 =?utf-8?B?TFArNEpXRGE3NWhQcEJIOE1qYnkxdlhPYXRja0dPY1IrM1lqLzRoYXNKM1Vs?=
 =?utf-8?B?TzlUazlEc2t6bDNKMnM2RWdiOEpuWGF6UitjTk5oS2ZCeDROb2MzUHVYYWgw?=
 =?utf-8?Q?ATJGHW+K/HMukowqbUXsDUS41rf+17x3bMYGgGgNM0Cg=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3af8d9-38e8-48fa-3c39-08ddae2d2720
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 05:58:32.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9601

commit de5fbbe1531f645c8b56098be8d1faf31e46f7f0 upstream

The appletbdrm driver is exclusively for Touch Bars on x86 Intel Macs.
The M1 Macs have a separate driver. So, lets avoid compiling it for
other architectures.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Link: https://lore.kernel.org/r/PN3PR01MB95970778982F28E4A3751392B8B72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
Sending this since https://lore.kernel.org/stable/20250617152509.019353397@linuxfoundation.org/
was also backported to 6.15

 drivers/gpu/drm/tiny/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 95c1457d7..d66681d0e 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -3,6 +3,7 @@
 config DRM_APPLETBDRM
 	tristate "DRM support for Apple Touch Bars"
 	depends on DRM && USB && MMU
+	depends on X86 || COMPILE_TEST
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
 	help
-- 
2.49.0

