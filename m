Return-Path: <stable+bounces-211356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IA2BYIgc2ngsQAAu9opvQ
	(envelope-from <stable+bounces-211356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:17:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E14971932
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 08:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DEC83004626
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B9B33120A;
	Fri, 23 Jan 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sMyPw75S"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B552BF3CC
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769152634; cv=fail; b=QGaviVj3Po3NV4uCX/6hMFnpyIHWC06E/ajl2E++WbyrfRA23USQqtt4ttI5jZ1CJ+dOhpjOhCyMqctPXH1JVpLPpQTpTSx2PFuFy7wDZP2s+P0TAd2Uy3gQPturWwrzW/HnYVTds7ZGlfHd+qAatv0O0Jbfll7gFxTcV9GYe1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769152634; c=relaxed/simple;
	bh=GbuOplXGkxB83ytMRJZFuAW7rydZrTand/qqCYc9yJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ol8L8d7ozzJf4PM812K7ZY2EbwLb3oH/qevx4TRnEuWysO3A6mh4fQsnQM1/AX8XP0vpHmWosfhr0n7+obW8GJncZO6ZLXHsCeV1v3K6SEg3AOaN3zN5FXTVM0um/wbMekfDEq9Ar1JjuyXvGTAABy4bRBDHcKJvMZnFDS7A+UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sMyPw75S; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydUOwB94eKL94XxMAqZrwjlwzktKogcbMU45PIlZ8ITeR5g7gJElivYAjZ4qouPzgAlKB89pYLmk1wggdNbnWeA8KX78RHoYh1Le7zC6cFh6nDsXKZ/QiwYEj/IR0IXl3KSQ1dCYHL/d/IDRbRjIhO01IKLDIwqO8l7lxRPa1M1pduxY8vRuU6G289zNJCIG9C9LDUakzK6flHRaSVoK93Hy3noYAjSSyp5QX1zDtuLZ1tzbClJCMiLVpa1QmiB5wN4NrZBhSQ4KTrQQnKKTMxzttMSCHRSeIwzB3GkHC0mlHNr7UKDoNfS8MvavQ5KTSSVNIXcW+fD3eA7InXNpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30H/wGKAgBfZOiSqRJTSZQ5tn33d5pfvyct3eEIB1HA=;
 b=rCUXvSvXPHj2ZO8RJMlkS3MVWvPMNL8meJNB/K/TosOW3aGGghVFd5xW8ObDIQvc1LTwTpJXBE2avWrrVmWFY20DVwc8LaqXXQuk8lE7UeVOLRBaFb0CyFn0X7F+HQ0WO/8UBFvgYo3+8cgN6VmXwB5asfymBd1dJ3K0jpFp3/3cI1WUKiISQY4cAnG9J4lzRwkuDDurq1wmCWgYv1br7xWYVnGRPLX1MgJD1Y3yruPJfcfkd8rnFYePZmVxt3wn9eVd5feOD/sY7de1ZSgdNZ+NBspxmgg2hxKqsL3wTS1vyFjtbMrv8rOmlC7wh8Cl5HqJuUiW6F94PAtfdXOZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30H/wGKAgBfZOiSqRJTSZQ5tn33d5pfvyct3eEIB1HA=;
 b=sMyPw75S3VvlOvPFgX5iFe+5zc14U4qqr6ut0ABdRArVy7r6fye+oPF49QiLGSNAL8Qx5TmMyO8sil1jJohlXoEA2Jcrj+hiHQphNr+AQaidedhCIkV/IHlOpQ0u7nbagHCAudsfB5IaOhmSFUuhFWI2t1WmAxKlmgt++1uqtcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 07:17:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 07:17:10 +0000
Message-ID: <d2b50d58-9488-492c-a542-3708fe070d95@amd.com>
Date: Fri, 23 Jan 2026 12:47:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jon Doron <jond@wiz.io>, stable@vger.kernel.org
References: <20260121182447.2434085-1-alexander.deucher@amd.com>
 <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
 <4882409.vXUDI8C0e8@timur-hyperion>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <4882409.vXUDI8C0e8@timur-hyperion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::28) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: aae1a0ac-2208-4940-ec97-08de5a4f6c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clFzSlhZNytNYmlmWGtVdzNVWktYSmdlSlpSTlpGbkRheE5XUVNxMXhxUGE0?=
 =?utf-8?B?ZlFIYU1GRFNCV3kyS2xwYm53T0Z4dEM5UFIySTdUVGNaaXJtUUNMUlF6b0pq?=
 =?utf-8?B?UnAva3M0NW1JaStvWUEyNXNseWJGeVpZeXFENEFXcXhubzEwTThyejB2d2I3?=
 =?utf-8?B?ajcxcFV5VjhnK1B3VGI5Yk42c0ZIRGpmd3RtK2FFb3VNT2pnYlpzUTAwV0Zo?=
 =?utf-8?B?NXZMd01SZEdCYUR4QXlZUWpEZ1ZFdThTeDNtb21oVVlRV1I3SGpmbFRwR3Ez?=
 =?utf-8?B?MWVldlBNdUNxeTlDMnZDWHhJeDF0RVhjc3lMY0I4RHBQcmM3bHo5eXJiUDl5?=
 =?utf-8?B?NDhIdUpoNDRPMFFCZm16V3BrS1Q1WXFTeWNVbTJCMGtRM0lvQXM1ZFR3V3cz?=
 =?utf-8?B?eTlnQVBHcnVXRUV3NElicW56MzcxQ1NTT1lhRFo5UTVEVEhSQ2t5bUowU0N6?=
 =?utf-8?B?ODFGRURJcW9TRG9IcUkrbktjOGVXcmZ2a1JuYjdBWE1tSkxkZlE4V0UyckhB?=
 =?utf-8?B?Rk4wWFU1b05LRnZKbElTVmNFL3RmZW1rK2MzNG1RRUdiSEJUVU9HcS9JbUV6?=
 =?utf-8?B?NnNQTDJ0MjUrM3JVVUIxQjExR2NlQWZ1WWhyUGlPb2pkN1dQWElOWFdJMnFI?=
 =?utf-8?B?VmVsTjBMSjdHOU5HUmJKYitGaWRDc2hrR0IvSkwvT2I3UWl2UnZtSFNhK3I5?=
 =?utf-8?B?UUJCOFE1WWhZUUtCZitxY0lsSm80NnhOZmJDcGtwNTF3SE9nWFBSTU5Na3Qy?=
 =?utf-8?B?TnEyc3QxM3Rqa2d0Ri9nOUptd0o5TzlIUk5QZkdPVjJ5N294K2FOaUNueHVX?=
 =?utf-8?B?TU1PQnIxYnpmTkhZUHJoeHFKVm9QSUF6S29PeUN5WEdHQ0pHelZPa29TZk1T?=
 =?utf-8?B?dkFDUHlxdVhaUW1aalNPa0JOVmhFMjVDMkRjMkhPTC9oOUxpMldZMmlyYndE?=
 =?utf-8?B?Smc4UVQvVlhGS3YzTGhScTU0QVR5WndPYldpMmR5T3pNbHlnWElxalZNck1O?=
 =?utf-8?B?VWhrMVJDaXNOdGdTUkZPK1ljdVlGazFseWN1MzgyVkNSQ284ejMxdXcxVE5S?=
 =?utf-8?B?ZmsxamVRam5TbTVlbVduek53Yk1OVHVkcy9pT0lxdkVLM1BaVTRXOVN4KzZG?=
 =?utf-8?B?VFhaekc5MHJPQVVrajVUUnRYWVYvTDg0QmQ0ekh1OEEvS05jOUlzYUhpbGZX?=
 =?utf-8?B?U2dGYTZpOEZTZzJXaGYrUmZ2eEx2NVhJRVkwalB0dW5iZlZnSW1Ycjd3eERO?=
 =?utf-8?B?YXdHaS9CeEc3cXh6cE5LVlUvMDNKYjFQUmRobGhRREMvcTF5ODl6ajRuM3NS?=
 =?utf-8?B?Kzh1U1JuMVBlU253UDhvRXUxR0xESnZFc3NnajVBbDVPSG9icnp5blAzVDBZ?=
 =?utf-8?B?SGRseTU4Y2ZoU0dnNXQ5SUdpS2hVSzRHOHlMZThVaEpySFJpbHVWcVZLUWxQ?=
 =?utf-8?B?S3hIRmRkNktJaldKaDVHa2p0cTBFUWRsd21PdGdBQUF3TjQ1dURaNEprTWZB?=
 =?utf-8?B?MjFPSE9FaGdXbENLSll1Y1A4amcrU21mTTN6U2ltRlRzcGNrbGM4UC8vemJT?=
 =?utf-8?B?ZWdZYnlzTG9aZFZ4dDlKWmp0MjlEWGRXVlFlVUFxMGlURVU3UVZPdzlsWGdp?=
 =?utf-8?B?OWN5K3cwQy94WTNJNE80NDJZWmJsNmY2TVdpTHlqR2xYQTNtZVZ0OFM1UlEy?=
 =?utf-8?B?NWw4b0ZDRkovVHNKV05wcHJFeERXdHVia0RESTZ1WXByWUV0RFJpMGF1cWpT?=
 =?utf-8?B?U1FvVHBHYTRXZW1nWVFhQnROazRPYmNLUi9jU2pjakhJMEpjcldRb0syeXVm?=
 =?utf-8?B?NkdDQjZZR0k5Qk9LV1prSWdnNWdkSjVrMzJPVTdQZFFEREx3UE5kY3ZsRXFk?=
 =?utf-8?B?ditwYUhIL216ME4vcnNsZ0xyS21lT29xUjEyaGNycTdBK0poYWpwd0ZuUDQ1?=
 =?utf-8?B?cis0VmZBd2U2Wk9NK2M4U3NDM1RVcExsNnkvWFhXdlJEN1NiY2hTdnFheTRW?=
 =?utf-8?B?MjJmRWY1ZEluOVI1RlJWNkxlNlh0aEtGdWZYZjkvMGQ4ait4S2h1dEcxUnE1?=
 =?utf-8?B?MDRtOGNOYnFoalovcVB3LzFhbUROS0c0cTlTcWFoNDlTaHVqSnBxTms1Uzhq?=
 =?utf-8?Q?jtSE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzA2OXVZUFJKS2llWWRxREtkSFZyQXhxa1l0MjNRRHF0OFYyL3FYQUlhYlo3?=
 =?utf-8?B?Y0ltOUZVRGFxTEdLY2d6a2x1cEZSVXFOWWhNSHNNVlkvYUpPRTNUcVJqbmRk?=
 =?utf-8?B?d3ZiWUR1OXVzSkxlL2g4OCtYM0dKUytZOUJJSFd4bzlYbnpiaVlhNndQbnFX?=
 =?utf-8?B?SVRhdXlaaDU5dkhQQWxZeHlqb0Y3UGhZd2RXV2MxVEtwNEJUenNHcUo5RCtX?=
 =?utf-8?B?NzU5angvYThLcTBqZTFXczZZei9jb2xsemt6andNSEpNdm1XaHBKTzU3M0Zr?=
 =?utf-8?B?VlhPc2x6UlRkdzNJcitQTlh5Ykc4Q3E3YzVwQjczOTFsY0pGanFFTGJjMzZh?=
 =?utf-8?B?WDMwMnhOSytVamtoZTBtYzlPcEdOWnlCa2dCNzFIbDNEbzRsYzZFanpEdktG?=
 =?utf-8?B?bkZyVmhnQkhsYVpCdzJDOGN1eXk4UnQweUF6T2RxZm56MlpmdzJLeW5aa1dI?=
 =?utf-8?B?NVBHRXYzNVJTaDhTUEdJVWc5dkd6bmtNd0tFZlNKL0hxMmdVcDJIZHdKbjNP?=
 =?utf-8?B?aVV6S2NCOGEvRlFGNGhZOHYveWJtZmluT0NLNHF4NmlISy9BYmUxOElIYk5Y?=
 =?utf-8?B?cWdrOVdDcTcxcTlQRGFxUDZETC9Bb2NGSG9kMG9oWHRTQnBPQzVMOGVXRkg5?=
 =?utf-8?B?bi9aWnQxVjlpYjhhZEVIWWhHak9XLzk0dlAwdklobUoxb214YXp2UHpPR2Ji?=
 =?utf-8?B?TlQ2Y0pkdUJsUm5ZRFlsb0FxWlJLNmZ4cUpGOXRySE85YVlTL3pjYlB2UnRU?=
 =?utf-8?B?NSs2Q21tZzdpRnp0YUxZNnBVYXpGYU5UL1JzTlVBSWppa1pLWXNTTHppbkhK?=
 =?utf-8?B?eXBMVm9hWkg5eFJDdG82YmY3MzgzL3hwdldiY3MrMFVqbjZ1MEdXTnFKMjZV?=
 =?utf-8?B?SUJnU2VsL0VLMmdyWE55R2tZOUU0bVJDa1ZGeDZVRXU3eXM1SHI3Tkh3aUJV?=
 =?utf-8?B?ZTBFejdQdDJzVUgxcCtkbTFoK3MrTW9XMWlnSnhZR2o2NW1OYzlBWlhBS1k2?=
 =?utf-8?B?Rjc5aUJJYmVUU0E0UitSKzFiZW5ROHRScVRoamhLVEdNMytEd09zUUFIdEJM?=
 =?utf-8?B?bDdKMTFEdmZJWloxWXp3Yjh4MVMzWGp2MHdacFYyNDF6TS9vRG9CZDRNajA1?=
 =?utf-8?B?Zm9XajVGQlltMHdHWnpZY2lOZmZHcGJuMTlzcHFPeFFOSnlmMjdYOUY3NERQ?=
 =?utf-8?B?SUZZWW54QWl0am8wM0hPbGdKWVBXcGFLZjY1eVhWM2F2di9FdmFmem9GUnl2?=
 =?utf-8?B?akdWbTMzbmJnZlBxZ21yU2hCL2owemJLMzVLeEg1VHFKLzVZWG9RRGFaYjIy?=
 =?utf-8?B?T2dSTncrendNNnZzQjBydCszU3BqNUVoanUzNzJCMzVyekNhbmE3L1ZTWVEx?=
 =?utf-8?B?dUZNOFhJOWNMc0ZzNkY0cXFLMFZFYm9vSDNDM0JxbVdpekVEVG9rZ3VlVE1y?=
 =?utf-8?B?aWFXNm9haE1iRTh5bFlQaFJYcndjWmlMWmFFditNUnB0UWI5ZGZyVHRXRUx3?=
 =?utf-8?B?Y0N2Z29LNGNvOTNLeUt4K2pMREJqb1JlTGtpTFJoQUNqRVR2OXlpVjJaUENW?=
 =?utf-8?B?ZDlzVVN4dlUycDJOdDRCV3ZZK09kUTVhcUJpZi93U29XNHhqbGU1dDdKcEpJ?=
 =?utf-8?B?MGg1RERHSks2Nys1VFpmU2t3NmtkdXBIVHhScnU3b0NUdDhOOUhuMEdIUnIz?=
 =?utf-8?B?Yjl4cjVHQzlmNGhQUm5YTCtUbEh2UUJ6Y3ErakpzTEhNQzE1YjgrYWx2NTlM?=
 =?utf-8?B?WWkvU0tOaFg4M0RZN0d4WjlRMmNvTXBoQzVDLzVXZUxZV0IwTGxrb0dHd2xX?=
 =?utf-8?B?NjFmdGNwVHFZdnY0YlVFdzRjM3RXSmJFeThBelpGVlB3VUVRcTZNU2hQYXJn?=
 =?utf-8?B?SWpIcG5wRExoc3dmM0dNZmJra3NGYk5Ic1MyU2ZZdndtK2I5L0pENmtIQytr?=
 =?utf-8?B?L0tidFFHczY0UDVZamkrYjhvQ1ZlYnVkZHdWaGNSRllEeDV1ci9BS2JvSEI2?=
 =?utf-8?B?dElWOU1PTEtITHdCV0grcE1iT3FLWWl0ZmVqMDd1ZW41c09zOGxMTTdDTnJY?=
 =?utf-8?B?QVdLR3NtT3I5ekZGKys4b0k0dFFjNnBWMUJJcmszb093RHhPL0oxcFhuV2pq?=
 =?utf-8?B?MWcvVmNaWnpSOGttRGFjc3VnZUJlZFlOWVljL1hzRGxNTUIrdGl4b1ZSdkNw?=
 =?utf-8?B?aWhEbVJaVUlKbjRMZTJiUlRUSmJiVWFKQXBoYW1kTUg5L0JoUmlIdkFQQ3pv?=
 =?utf-8?B?WHd1YWNwQlpwUXNnT2h0SStubnlGWU5YRDQ3UWtGdjdvQzQyRDVydjF4d2x1?=
 =?utf-8?B?MmdCRUJvZG9FNHE3c0VzU2ExMWhUalAyRzdvcHVLUWNKM1pHcWcyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae1a0ac-2208-4940-ec97-08de5a4f6c0d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 07:17:09.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qdImKOJHEtGjUrAOR7PPwq5elWiUnWLHvUsXG6tkWyHldGT9Jaje2z2f34qq+gn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211356-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,amd.com,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lijo.lazar@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E14971932
X-Rspamd-Action: no action



On 22-Jan-26 8:30 PM, Timur Kristóf wrote:
> On Thursday, January 22, 2026 6:07:27 AM Central European Standard Time Lazar,
> Lijo wrote:
>> On 21-Jan-26 11:54 PM, Alex Deucher wrote:
>>> From: Jon Doron <jond@wiz.io>
>>>
>>> On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
>>> ih2 interrupt ring buffers are not initialized. This is by design, as
>>> these secondary IH rings are only available on discrete GPUs. See
>>> vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
>>> AMD_IS_APU is set.
>>>
>>> However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
>>> get the timestamp of the last interrupt entry. When retry faults are
>>> enabled on APUs (noretry=0), this function is called from the SVM page
>>> fault recovery path, resulting in a NULL pointer dereference when
>>> amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
>>>
>>> The crash manifests as:
>>>     BUG: kernel NULL pointer dereference, address: 0000000000000004
>>>     RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
>>>     
>>>     Call Trace:
>>>      amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
>>>      svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
>>>      amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
>>>      gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
>>>      amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
>>>      amdgpu_ih_process+0x84/0x100 [amdgpu]
>>>
>>> This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
>>> IP 9.3.0 from noretry=1") which changed the default for Renoir APU from
>>> noretry=1 to noretry=0, enabling retry fault handling and thus
>>> exercising the buggy code path.
>>>
>>> Fix this by adding a check for ih1.ring_size before attempting to use
>>> it. Also restore the soft_ih support from commit dd299441654f
>>> ("drm/amdgpu:
>>> Rework retry fault removal").  This is needed if the hardware doesn't
>>> support secondary HW IH rings.
>>>
>>> v2: additional updates (Alex)
>>>
>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
>>> Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Jon Doron <jond@wiz.io>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
>>> 8e65fec9f534e..243d75917458a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct
>>> amdgpu_device *adev, uint64_t addr,>
>>>    	if (adev->irq.retry_cam_enabled)
>>>    	
>>>    		return;
>>>
>>> +	else if (adev->irq.ih1.ring_size)
>>> +		ih = &adev->irq.ih1;
>>> +	else if (adev->irq.ih_soft.enabled)
>>> +		ih = &adev->irq.ih_soft;
>>
>> Faults are delegated to soft ring when retry_cam is enabled -
>> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drive
>> rs/gpu/drm/amd/amdgpu/amdgpu_gmc.c#L541
> 
> Hi,
> 
> As far as I know the retry CAM is not available on APUs.
> Please correct me if I'm wrong.
> 

Retry CAM filter is available on APUs as well.

Thanks,
Lijo

> Thanks,
> Timur
> 
>>
>> That matches with the original logic in d299441654f ("drm/amdgpu: Rework
>> retry fault removal").
>>
>> To match exactly with the logic in above commit, I think it should use
>> soft ring only when retry cam is enabled. Presently, it's returning
>> without doing anything.
>>
>> Thanks,
>> Lijo
>>
>>> +	else
>>> +		return;
>>>
>>> -	ih = &adev->irq.ih1;
>>>
>>>    	/* Get the WPTR of the last entry in IH ring */
>>>    	last_wptr = amdgpu_ih_get_wptr(adev, ih);
>>>    	/* Order wptr with ring data. */
> 
> 
> 
> 


