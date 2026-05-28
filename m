Return-Path: <stable+bounces-254728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHjiF27uF2p8VwgAu9opvQ
	(envelope-from <stable+bounces-254728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:27:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBA5EDA72
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBF07301FB19
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C233263F;
	Thu, 28 May 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rzGVQ7c/"
X-Original-To: stable@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103ED32F757
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953253; cv=fail; b=FnGnS6KlBm+zTm55IpKAxUaIDThZG7/w99FKcfcwbs/4VjvSoG6oro0NUP4lVOEVOUMHX9JPKg8qW/oalwE9dRMAIj2dpvAG+NZOD68apWBMEcDbUTOySLVYJXSA29m96TJCs7F+EOvK49fNXkYvPQm5r3D5Ge21XfhHc0Kct7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953253; c=relaxed/simple;
	bh=+2RMvhQXtGjQeQ1W1yHmCeSKXpDJNaZ84Pi52Q2Hr8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=REMJUQZ4jpCdp+t4dYPBj9Q8GMbvcOkk74lGklj6OKQ3QaEGgt+hC5E6qviNX2UzCwbTZqUxUmJpbjG4iZgso7ci0wIvrBQI4eRk4fjVsaPmYpZMYGZAMIbxl42o+72LacKRiSHfQBWzacSYA0rAsrFXix0M50V/P9/OIU4Rbp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rzGVQ7c/; arc=fail smtp.client-ip=52.101.53.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmD6TBsXdGvhdARlsfGc40F4Y3Dnjc4B8AXjqdt/E3RkG6WWzMoA9kSlyF+mT3/TYlMnmUCA3UAH1ZRq3Wac6yAHYzzzXwS4sIZsGYWh5fVGbbzccWdQSc+PLviEaz3lHVQrUZF+UkqTVYx6utPZns1clpg3P1dSeurg1Z6GJHeQztTjqxrZG32rgUeBJtHmDwenBY8A1540HkJgH1kR/N0va6w8UjXVKdfUVMx1wHMirY5RxhmAj/Cl/WAvzsY/QoyB/cPU5PuCptznk2CSo6poAoNVv2Onii6Kop++zsN23tMhIQuvsFSpiyn6ReqKKQADxOQdbN/bUKPPbyVXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtQsIVtfgxmaBJBE8N3ruTIf3iTPairQbVXI08j35S0=;
 b=MLTr3xNPB8QaArX6rqRbn5EOnJMkvX0EQYbHRTTfdokPh7CWeGkJuzvljGoDuPjsf8kbSq3k83JO8pOIcUspgjye+JDLuVeybunUORcKXKm53ROHwRoileuupNy63oyWoPFasjS7+Y9T39X9y6nEZaCCft6p0wziZQpeXWCnKTMaOrGwBwQYUYGjKzAkezkmwHNi/aaS9lQCSa7rwYLzrXtYLHIR/XlLIP4r6K3/GwAqO5YmB5Q+xq/YOU5E+y8cW/sfkw5b3LFolFJfKBbcZ2Mh1Fn0DAMSrdcgGfXhU01xLUk5Q6xpOPwMF7LkuEPAKbNPFs2nErgUPQWCE/6zsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtQsIVtfgxmaBJBE8N3ruTIf3iTPairQbVXI08j35S0=;
 b=rzGVQ7c/z7MzkdlDEohbP6jHQQPdGKlDLaAq6O0BfB+X6ZXXJFb7HDt5MyC+l2sbQX3ym6peUSZxj8dahK+nVVNzGZGVj9EzrChGThAh6DWQhsaIuLnAw8/j2UBPWAHK8x6De4VzztTCFBXP6JafGk5Yw6hznJM1P2UqGqq7TzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 07:27:26 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:27:26 +0000
Message-ID: <9164ec6a-ef61-484d-9d52-92094fa28f7c@amd.com>
Date: Thu, 28 May 2026 09:27:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/gfx9: guard fault IRQ puts in hw_fini
To: Yunxiang Li <Yunxiang.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Tao Zhou <tao.zhou1@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20260527204940.1741202-1-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260527204940.1741202-1-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0e1809-1a7d-4ad8-10a3-08debc8a9108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Aaw+v6QlstJQbM6or+n8dHOWpEK8EOBaeKStEGwa+NMwyBV5Ard2+YIefo36kyBityIsVmOjnM1JSy9268+Q9NDITAKlrIn1LJbwlyW2me+qiw2v11znPYP8hvBUZckqiFxxgr9z7ooFD4iBwERdlR1Kud3Zg9pqfUOTIoZ0LEgO0MDMdynsLiiyyTGZCeBY8Q3+3J2zW7Bowe+kbMqb7upxdlk9G8qaV6sxl0ehuupn5ZeXrwVq7A/xvoD9RFV9vKOJoeKzDQWAYt6uxWaObqY9CB32BhqqVvakS3jtoTI3pLDWbnANFgN91NyZjw4kpCjDMFB9mN1r1UW+2a941RWfWJ732rAeGd66JGonQwgakJwrGerTbzmp22saAGCo5AzuOWz5LqOOsKdml/JIax+01D1Mhb5aRTn0cmBShSoe28WBsVmuCNFb6X8RQQx6QPdOkeFgVG+OmTZ66cJuPR1ciXsvxVHnX4FcmcuBpFKUc3+G5i0fsNXFnTFTrYmhIo9uuR8y0l3I92MnwcnSY+eysc+iQc0CKlX7nH/sWjDadO+zNHgocoI2OXHCGic3ax2UJUFc28yPOmYdgPBzUTKwkmx+2P1n72m6HTWL306ZvdPYLjkV1/W7NOEgNoJH9jphvvYjSGnqfTjNlyMndbmHbd5VUkQm1uEXlddlt0gzGzMigQe+5Cxxj7EYRhDk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0lDeHVFY1ZucDh2UGlSNURnbEMycWNydGpmNnU2czU0eVluTEV4T1I4SW1h?=
 =?utf-8?B?aXdUeHo3ZVozOGNlZmJXbXY4ZmEzOGZncU9vS1JEakkva1MzZjJrcWczdWww?=
 =?utf-8?B?K09WOGxCejZlNnNzeUYxdXBQTnhjNlJoMmVndTAxN1puaTgyU0ZJUmF5SE9Y?=
 =?utf-8?B?aTQ2c0xVU3hKTC84SjR1VGExZlBjM2g0U1RMRjBQaUZZam52bVNKOHBlb1lY?=
 =?utf-8?B?QWJDVllpbFhOb1RJQkRhdXV3L3VjalF0SzlHSkdBWlF6c0ZrZERraUdYRUVZ?=
 =?utf-8?B?akZRUURJSXIzRVkrUjdtT0RSR1k5Y2VhOW10ckNWYkM5NXJTV0Nsa3ZxQitW?=
 =?utf-8?B?cEtMRFJ0cEJyZmpmUWNjYkFnSkc4NFQyQlNkL0tsbzVqbHljNmxFcldZeFk0?=
 =?utf-8?B?R2o3VHZieSt4WGlWU0xGeDVNQlZoTlFiekRHSXNZbjZSS3ZBaGpUZTRrWnJy?=
 =?utf-8?B?N01HSjgvdVhCRzhRbFNwZ3ZEYUtMVHp1QkhPMW10SGxHTWl0L1RyMUF3WG5I?=
 =?utf-8?B?eHNGREt5ZWsydWFDL0R4eGpuU01ETmZoclNRRitwMStJazllZTFta3hZdUlR?=
 =?utf-8?B?TXZxVHkvSHlhcnF2eHVrTDRDeGpSb0VsMUg2QjIxNkZQQVkyQXZYaGRjeVVY?=
 =?utf-8?B?YVVZYWM1SXRocDVjdVVhYWFmUnE3VkZ0bjYxbmJoRDJDUmpGVy90S3RDZTgv?=
 =?utf-8?B?dS81VThhTThmR2hwMmFOWG04QWV6RVMxRFJSK3lnZUl6ejd4SDg1MkVaZHVO?=
 =?utf-8?B?RytUOFRKN1lmTkkybkFLanpnZjUzOW1LMUlzZnpKdlJ6RkZUNy8xOXRER1c1?=
 =?utf-8?B?RnU0cldPL0hCbm1NM2RmWkEwd1BlM25xQWczWW5lUnJNL00xSmVjWktlb0NG?=
 =?utf-8?B?V2tZL0w3ZmtYM0s1Rk8rbnM0VTdsSzBqTm9SMXZqSDhqSktrU3VQeWZtdXNt?=
 =?utf-8?B?Q2ZqZEVyWDBrRGxiYnJ2dGt1SkFFdlJBd2VEQUpPMnVVQkw1SDZKMTZjaHJM?=
 =?utf-8?B?bVVzUXJOb3dhQzM0bThsbk56VEVkdzc4RjFVT1ovN3RERFZUNGw2VTRGQUht?=
 =?utf-8?B?ZEV6YmNvY09icEt4cUxjZnB5REtTZmJ5NVVXVC9zSEhYb1o2OUJoR1hMQ1BR?=
 =?utf-8?B?V3lDTjMwNDFmUFY2bjU2Z1AyM0UybXFPU085bGlKeDc2MXppY3Foc3lRYnFS?=
 =?utf-8?B?MU9NcjV6ang4WEVpdDBFVDRSbWY2cStweFZsMkZVMVZxRWkybGZrOXRIM1R3?=
 =?utf-8?B?NERSSTIrME1ua3VnQ3pGcStWSS9UbkFBVldub1B6NTBhNVRUc0w0bWZ4SmNP?=
 =?utf-8?B?VncwdFQ5VEpjNUZ4dHZQLzBhbXJuNXJNWjBoNjV4b1o2a0dBTXoveUpWTVll?=
 =?utf-8?B?OHZTbmVRbHlqU2VnakUyMDA5TUtVaVAzZEUyQzhRWE1ERFJkSFk5c2R0U3px?=
 =?utf-8?B?VldncEd4cFFlYWlSZTNnRTZHc09tYVpoMG1DSUw1SUd4OXMwS2xwTVJXS3Ri?=
 =?utf-8?B?aXNOWlJ6cncvd3NkNHI2L3F6NnY1RjAxcHJLNkQ4bHRpUjg0azBPNmZnbWFX?=
 =?utf-8?B?ejJ5dzRSZG94OXFDOWNVU0I0WEhsN0o2eFlQUFlGMkNQbzQ3RlAra1FpUG1m?=
 =?utf-8?B?MExGYkxzUnJGTkJCTnE1QjZ3eDhYSDFrY2JRcVAxb2lxMGlsdEtyQ3A4M3B0?=
 =?utf-8?B?dCs1UGRhdkRKcHo2Y3RTTWFVZFJqTVZDdjFnMldPNVowMm5MRytEaDZRd09a?=
 =?utf-8?B?RHY2QlVleUoyT2hvQ2hzVjZ5ZEF6bFZGd3JVQmwveStMc0hNUWhtajYxTTFm?=
 =?utf-8?B?Um1lU0dOalRrVFJ0QmZjWEZtdktuY01WSDN0Q25yY3FWeU44Z2pkbFNLQUg4?=
 =?utf-8?B?TmE2TUZ1b3o3NyttZG5KSC9tamhSWHFrRnJVcVI0OUo2NmpjaWZFZFNSekxM?=
 =?utf-8?B?UkFseEcxejMrUkdHSXE3d3ZxWFZ2OXZRMStReEZ2YXFLRDZpbmpmVnVtYnUv?=
 =?utf-8?B?bFZ4aUJ3RnNrenIrM2tGVnB3dEtjMklSMXpMMUF0Vm82ZG1EbTkxT3F2TnZQ?=
 =?utf-8?B?SmJRbW1pMmZ6eDJvRzRybU9NTGNSSTF6Y3phcG43MEVaaWdwWStNZDUrK21k?=
 =?utf-8?B?aVVJVld3SFZjcERHclRvZ1hLbkRmWmM3RWhUdFNDZmJ5VzJlWnpuUXR3SkhU?=
 =?utf-8?B?WWFJdzlFTERHN280MHFRRXNHUUdGTmxzSk4ycW9vSlI2aXdkcmtJQ2xjUFFL?=
 =?utf-8?B?WnFpbWpVOGRta0RkcjdIZVl2cHpoWThvNTgzcnYrZi9SVFUrZGg1VWFUQnFv?=
 =?utf-8?Q?mUdJHLODgallTCmZSG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0e1809-1a7d-4ad8-10a3-08debc8a9108
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:27:26.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkavZwk12HiJgtLazWagujrpJA7j6pezkK7AAqnzwpgRFYsdR80FERJMysC+iEGx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254728-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:mid,amd.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 69EBA5EDA72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 22:49, Yunxiang Li wrote:
> gfx_v9_0_hw_fini() unconditionally puts priv_reg_irq, priv_inst_irq,
> bad_op_irq and cp_ecc_error_irq, but the matching gets in
> gfx_v9_0_late_init() and amdgpu_gfx_ras_late_init() may be skipped
> on SR-IOV VF, partial late_init failure, or an earlier IP init
> failure.  When hw_fini then runs, the unmatched puts underflow the
> refcounts and trip the amdgpu_irq_put() WARN:
> 
>   WARNING: CPU: 4 PID: 6367 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:676
>   RIP: amdgpu_irq_put+0xc6/0xe0 [amdgpu]
>   Call Trace:
>    gfx_v9_0_hw_fini+0x200/0x9a0 [amdgpu]
>    amdgpu_ip_block_hw_fini+0x29/0xc0 [amdgpu]
>    amdgpu_device_fini_hw+0x309/0x5f0 [amdgpu]
>    amdgpu_driver_unload_kms+0x7c/0x90 [amdgpu]
>    amdgpu_pci_remove+0x51/0x90 [amdgpu]

That's a good catch.

> Guard each put with amdgpu_irq_enabled() so hw_fini only releases
> IRQs that are currently held.

That's a clear NAK.

This just works around the problem in an incorrect way. The real question is why we have the get in late_init()?

Regards,
Christian.

> 
> Fixes: d97b02bb9c7aa ("drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when enabling legacy gfx ras")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index bf270e605949f..e5a3735d98342 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4057,11 +4057,14 @@ static int gfx_v9_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
> +	if (amdgpu_irq_enabled(adev, &adev->gfx.cp_ecc_error_irq, 0))
>  		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
> -	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> -	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> -	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
> +	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_reg_irq, 0))
> +		amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> +	if (amdgpu_irq_enabled(adev, &adev->gfx.priv_inst_irq, 0))
> +		amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> +	if (amdgpu_irq_enabled(adev, &adev->gfx.bad_op_irq, 0))
> +		amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
>  
>  	/* DF freeze and kcq disable will fail */
>  	if (!amdgpu_ras_intr_triggered())


