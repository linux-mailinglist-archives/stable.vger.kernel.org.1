Return-Path: <stable+bounces-210382-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD72D3B43D
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 18:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BCBEB30119C3
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F629B778;
	Mon, 19 Jan 2026 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JGfQVURB"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010057.outbound.protection.outlook.com [40.93.198.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC4E26E6E8;
	Mon, 19 Jan 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841722; cv=fail; b=A6oRnXuvt/gLqXimR279P4RFdsKM/ZfQTzFsxOWMF1FEgT05Ecmy8s+/7F03UT7ra2Y+ECxPOne50O/SpYKkH3spU7K9aWMVpCVX2l/0cjyaGwRgUYCC/CEu5ujBCZlEjW3nOA4hoa0nAmM4Zhhg1tPS3swdXJvtHCV7BKtCXjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841722; c=relaxed/simple;
	bh=Hj2hITzYKOfj3TTzn1yZL3sOof6o4xzm7Nty0ujgfdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sSaZr6ROVIratz+xaKcwkd9F8r6S8M9IgQD0993WcVLL4Vu+XkbJ2EEXwcgAFHpLoqM+yV2xAPXpAAClLODWZZS3tvhEv6ccU6Im3fYQ/0XTGLjnTHUzXK7oCYDlVXEnNnvaDGFuhNF3mwpsunVsF/ZxAZajK3VlNXTOQ4jUxF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JGfQVURB; arc=fail smtp.client-ip=40.93.198.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG27itpp/W2vkivYt9WvmPZ+v+BTtMLULTOB9DR3veiSiX+F6pKlf+hUxpRFxVCAuGOWL9P4PyOBv4r4b+NxXbfY4wSpwpgsyj5nD9P1nZ9GU5E+sh4q56FyJHy7ROk0xxVvYLVTU0QNXLdep/2uEBFp09Xtd2hUvqdDXsGAym5OVqxKUd74bLtapK2LCSwXI5FjDAyiIouEQmzh5QnpP/HtJg+njnUzJ7vUi1iS2Bdbgrd02zAjznKJ9rxhpc3lkzyVt0Jhi0I0U3etlRFDaNzwZaqWpjTxhtdNIxwuQDft+fpnEZ6bOoFRpK7XDQmv1iSiq4ERT7XCnaSsn3pQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9XXSdb7YLGFb9evsZIIlx5N6+3gaqMfTARrMamPHk0=;
 b=ZrwzFCc/lgAtbDEnL7Va8mlwWvLGLxIeYNY70wmj9JEJPC6XZnSMuSyqzPEJeVy6yXhIl+Ki+9lKQzIT/Mnpp/AHYoyb4R9QZpfcEDLdlSOIWpa7ScVWcCfW/YkGlL2N6K0IUxZdjjiYcPC/ySfP5DkHxmcsbecHCJXg1A0jM/e1wcSKUCDwho4iwiGxn5CBt2rdoDJEvc+KoLByOpdq2/T3bjBNlDDE8giL3s0sVyxU7+9JLw+3OJGqodZiR09Tj1gvGdGhRGekz+eU6UhMJmJ/EphHegkg7hLgkUMktHPxXaEoFXpAhY+cRLdAUbvi00ty2JqcFsdbxdt5KTUqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9XXSdb7YLGFb9evsZIIlx5N6+3gaqMfTARrMamPHk0=;
 b=JGfQVURBakWpn8Uo1urm/ew8y9OR9KnN7+1DqiHfXMrTCUV0/EoT2nqjrsQIlW9JgLBdDygK57hnaUT/ZfWNcTIIDMpsAf69oafNhVrgmp5/w/J1plJo8UT8uHiUBFVJhIAe5rusLbK+434vV6BO4NMdwBuw498GQrXkNAzpeTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 16:55:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::94eb:4bdb:4466:27ce%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 16:55:18 +0000
Message-ID: <b522f04b-9f8c-497c-b9b7-91c9be1431fb@amd.com>
Date: Mon, 19 Jan 2026 10:55:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] platform/x86: hp-bioscfg: Fix automatic module
 loading
To: Armin Wolf <W_Armin@gmx.de>, hansg@kernel.org,
 ilpo.jarvinen@linux.intel.com, jorge.lopez2@hp.com, linux@weissschuh.net
Cc: stable@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20260115203725.828434-1-mario.limonciello@amd.com>
 <20260115203725.828434-4-mario.limonciello@amd.com>
 <dce90eeb-d7e4-4063-b99c-1e4a894a8409@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <dce90eeb-d7e4-4063-b99c-1e4a894a8409@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0121.namprd11.prod.outlook.com
 (2603:10b6:806:131::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: a71ffca8-15a2-4d4d-390b-08de577b863d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2JjRyt1N3VKU0NnazVsV3E4NEQ3YW1sdHVpQU1wblNPN1Vma0VBNnJmNnZy?=
 =?utf-8?B?VWNUNWFqTkdsVFFJZDRvQzZYTzdsaUkzOC9LblRqMXdmYUpmZmVMZlNkZG5E?=
 =?utf-8?B?Z3JLZTJydnhadXF1Q3hLS0s5MkM5QkdKdXF2a2VuNWllZFdacjVIaWFpcWNk?=
 =?utf-8?B?VVRvV0lCbUlUc3VLMmNLODF5UXRWaktvNE9mTEJ5Si9aZDkrejlnWnJUeG9O?=
 =?utf-8?B?OXZ3SkhTNVlhelkyZk1BVng5UXFwVnhZaklMMGVkSWNQNTRPRHo1Z2o1cWFO?=
 =?utf-8?B?SkxMdWVqcExQSEdZWFZPRGdGSFFieHJRc3BJRVExUTR4OFZMYU9UU2w0ZlpT?=
 =?utf-8?B?aG5JckVpTlh1VFMrYmZqU3pYcXpPSVAyc2FEcHBjRGZLM2kxb1ErNDFQd1Ur?=
 =?utf-8?B?Q2kxQTV6UkRKa040ZEVHVnprMjdacHpseDgwTnU2azFSalFGMGt0Njg4WG51?=
 =?utf-8?B?MXJUa0g2SVM2V3VKRitDSkpVRkloblRlN2Z5RVhMRWpIR1NlNjd0K1VZN041?=
 =?utf-8?B?cE1LQ2RlV1A4S2ZxbnYwcnNEM0VhSXpVaXZQeitBZXVWWHdlalRFZVFsYzlH?=
 =?utf-8?B?M2ZnZis5SmJCRkQ5K2EwenlZbHhFVmxqN2NMMTN5WklsSHl2RTB4cjFBSkMy?=
 =?utf-8?B?VVZDbjVmYTlZT0hsS2dwK1p6ZHNONEVxZ0dyS0NIMVpOV3NJd0JEV3dlbWUw?=
 =?utf-8?B?WWQrdEdlTy9kdTc3c1RnUjRoVnFhWC84WGxyam1LeTl3d2dmdnJWOVVCTkEy?=
 =?utf-8?B?ZjhLbzZVRldRWXYrZUJQVkZ4dXpMdzdXM2JoOHV0VzNiWWVUUXdGbEx2Q3Q5?=
 =?utf-8?B?MjZiQ2hMK09LUytreTFNdHZKU1NyTzdLdkd0cDVJMGdUUlUyaTNYWVBlNTVn?=
 =?utf-8?B?YWZsQVRBa2tXamsva3hobGd6a1lhOHBJZFAxVnhNZWlrZ3ZCelFrbExYVDZi?=
 =?utf-8?B?OVBtWVZaSFc0ZlZPVDBWY2NGSXB4NFpjdXFFekV3TUgzUzRTOFVxK1hoWTZJ?=
 =?utf-8?B?akxFYXphcTNmZ0JSNFJUWW5jd0ZQaVV4NGh0OEZncVk1Y21jL012WDFPQVlQ?=
 =?utf-8?B?cDRoZUI3Mld5bHlhbzVSOTIvUFhhb2ZyWjFKdDA3M3owcXBBS3VFbjNCZGVE?=
 =?utf-8?B?RTljQkZFWUNJOG1LaFNVSjBGajB6R3BHZ0ZFUHZRek55ZHdpMkZ6N1NCajJD?=
 =?utf-8?B?cGtFY0ZNcjZuWERjUi8wZ3lhTXFYTlgvVWlzNnVZRmlDdzR0L3puQVhjTG1D?=
 =?utf-8?B?cVQvQ0hhY2xrNXFkcHIrSWRTUjFPd3dha29rOTJoMXVHcHdxc245dXMxSXox?=
 =?utf-8?B?WVdFSWlhZDdUeXRKYlFVSFI2dVJaVUV0RGZqUlF0ZkxFZnFybXgzeE5UcURX?=
 =?utf-8?B?YlczRmdCTWcydG1maXhQYml2Vmd1TkxWRTkyQWQ1ZEg4bTBXQ3ZKTndlTkl1?=
 =?utf-8?B?MnprdGJaVXFWV0pxYTQwWHZPL1B1aHV6UG1TMzZ4K1ZGTmtJMy8xTnowUDNE?=
 =?utf-8?B?bHpPdzBlQzFlNzVWeW9pVFFZcjloUkVlMXRTcW5TUVdzRERiOSt2ak9saWNv?=
 =?utf-8?B?dGdwL3hGOTNqTTJUMVAreForQ09Nem5TTk5QTEFLY21Id2w3dlBEc2VtVmRk?=
 =?utf-8?B?ZkZkemNka2Jpcjd1d1FUOWNNc0hwQkpPY1Y1V0l6aVNSSTM5QVJGL1BEK0Vm?=
 =?utf-8?B?K0ZNUXNIc1JkVVNhUkcrNzlkV0RBQUp6Q2cyV3dpZ0xOa1FUZ09tdC8vbjlB?=
 =?utf-8?B?dDI2Y2ZzY2FCQTZoSlJWTXFkNUV5eURtNjU0SDB2Z1A4akRLQjhQZCsrLzVK?=
 =?utf-8?B?c1hlWExzWUNIV1dtSkljMnI0UjA1dzVPNXNoT1czQVNXMWY5enpkT2gwVVNx?=
 =?utf-8?B?TkpkVXlHaVNUd0VBeWlEcHh6NW1nTWxMOUZrb2Q0T0M4bnJaODQ3VlNncVJv?=
 =?utf-8?B?ZDVQcERPRGFBOXNZR0wzSDAvM1NyL0lPMHNDblJKYTNyZThOY3QvVWVtaFdQ?=
 =?utf-8?B?ak5CaytiRk4rbzM3S1htVWdpMzJCVzZ0eTB5QWZ1QlZBa1pnUnpOSkY1Slow?=
 =?utf-8?B?YVhkUnFvZE5pSnNHVW5pb2g2ZHAxQnloYXN6TklTeksrZUpLMHUyOU1rQ2kz?=
 =?utf-8?Q?V6xs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVTWml2dExjUEdiZzRxZm1Dak9JQU5rUnVrYzJRMG9adHlYWkR6eVo4Y2Jm?=
 =?utf-8?B?aFEvTGgvT1FVVkVYbFNqWS96T1lsbkRIa3I2S0hxeWlzcFZwNGxNYWxIdGlm?=
 =?utf-8?B?b2RDRHlWQ3FSV3AwZVZhSVVpTk12QlpUNitDcWQ1cFY0YmVSODV4ZThnZ1o3?=
 =?utf-8?B?Zko4bGx1RVZLejd3SlJyNVFVKzFVM2lwRXFabVZ3S3g1UWtKWS9lZnBLME1C?=
 =?utf-8?B?ZHl4N1Ficzk5SkFYL3U1b0Z5bzRyZkNNU2VvSFliRlRVbEtPd2k2WkJaZHJP?=
 =?utf-8?B?MGJYdDFnQlVvcDYxcTB1V1ZVSmhKZldCcE1kN0pHZSs4NlpScHFFTkJMT0VX?=
 =?utf-8?B?ZjlMbmN0VzRrbHJiaXNjU3ptcSt4U01zdmxEbGswRTI2cXd6dlQxaUY0MThV?=
 =?utf-8?B?bnJoa0VkdjNyWkpBQTBjVVFuNTA1ck9vM09QM2pmaFQ5REh1SGtTYzNQbHdR?=
 =?utf-8?B?UkQ5SElxOXZlTHZUR29icEU1c2JWc3FHTGlMMTdWeFFLN3lUNCtwQ2xuZVpC?=
 =?utf-8?B?cS9wS1d2dXRWQTY3RXAvcWhhMGNrT1MrajBDeTVCc3owbU5mSlBGVk5KOUJH?=
 =?utf-8?B?ODkvOUtzRGk4YU9La3VPS2J1ZlhKOTMySkVzMnB6djdUSzF5M2JXQVhlR2s0?=
 =?utf-8?B?cDIxbUxlVlFrOTVQTHdpeHgrL2tBUHh1UVR4SEpuR0FnVW1pWlp1S0ZJR01O?=
 =?utf-8?B?cW5xdzFjYkMraFo2Vm1IRnYxN0x0aHlnYld2bjZ5QUJLRTNXdUdTeEd2WERq?=
 =?utf-8?B?VG9GWGt0NmhBT3A1QUFpU3dySlR1L0FJZkpyblJFUXY0dHlaM21DZmpYcWZp?=
 =?utf-8?B?bXNyYzNwOElzMzVJVStUSmprb05nbzNmUEgxbDJQd2k3a3VnL3lqL2JTS280?=
 =?utf-8?B?QzVwMm00OExTbGpqS2owakZ3VFlKSURSa0k4L1dFZkR2L1JkdDlLemxhQVBQ?=
 =?utf-8?B?eXBza2VpVVdnWStudXREUzFkZ1FTejlxRmdWc0J0d2U1YjhlL0xxOGJMeXFy?=
 =?utf-8?B?WmRxWjZSV2REcExSQzR3UWdRclgyeTl6VktVcGdtd3lGY1JZdkhkSVdJcEZL?=
 =?utf-8?B?SVpMQ0NNUnVEZGdLQ25GdnVJTE0wTkZPbFlwVmMvbmdoaW9VRnJZQjBVRUg0?=
 =?utf-8?B?OEhtVEpFYTJsNFNzdGdBNmtGYmVQUytNOEs2K0dlZHord0t5Q1ZoTVJrUDNa?=
 =?utf-8?B?eFUyRVRtWnNwenJ0U3g0dk41Uzl5LzNxNEpWZkkzMTNmSkYySm80YVpycksx?=
 =?utf-8?B?cEVFRlJtUnkxdWRrNnB5TllrMHR0V0Rxb250MU1RclVRNi8wK25oNzVLakRG?=
 =?utf-8?B?MnpIN1lMOENSOWliZDF5akNkUXJ5dkhTMmlJRXBSL2REdGVEZ2dPTDgzT003?=
 =?utf-8?B?eFZrRVVxWmEwc1BzNjJQd2x3US94NEMzcnRxaWFvOFQ1RnRkMXZjZWlUeUJq?=
 =?utf-8?B?c2twa20yZGhrcWdOeUxLSUtJeFR6Y2xvQUY2RUVTUkt2QlRuQnMvOEJ3aWI5?=
 =?utf-8?B?U3lNY2NOK1pzRzF1K3F5NHRkbUJjTzVPdGVlRW5tM01ITWl2Q0UwOUhrN1J3?=
 =?utf-8?B?N3cxellzY29yNFVQVEdiaFV0ZlFBdWorRjJ0RSsvNDhaLytnbCtDajYxVG1x?=
 =?utf-8?B?ZHgydDdNeGZzUiswSGhHWWd1YWZJbVVHamFVQ0NHNDYxMGlWdWhwU1V6ZjU5?=
 =?utf-8?B?UHhKTzdSSzBoV1dkWEZHMEp6WGJHOTk0MXpKZ2sycUxqTUEyRjZsbFhOOEtS?=
 =?utf-8?B?OGtIeXd1ZmZhY0xXMTNCZXUxQksySzRIYVpxS0hMSDBqUFU0Wk5TaFVBWXVr?=
 =?utf-8?B?RjFjRUtWV1lPVmp6QzVtSWpUMmptSnUxamdHQWhxZk9LWmFzSDdaNkJKRnJl?=
 =?utf-8?B?SmZlei9UYVNjYjl2S0xvaGx0UHlMMHovZTlKRjkwV0VFWnBiR2dxREwvc3ds?=
 =?utf-8?B?RzlLcis4ZUV2c3ZpcUxsczVhNWZMbUhLeXhHd0FUQWJzaktJcURna0E2T0hh?=
 =?utf-8?B?YXpJVTFEcGZGUlhkZktNQkE3NTdnc2dBL3g3dmR4aW1UZktsR2UrQVREUXp4?=
 =?utf-8?B?L1V0N2tKWkRuMWl0MG13VGJURlZ6VElrOVc4L0l6U3VhdHJUeWFPRjZ3Nkxt?=
 =?utf-8?B?RG54NTVZaG5rR2FSTmxJVTBBTVA4OXZMR0FsSWlMTGdjQ1hsaDZmQ3N1S0lS?=
 =?utf-8?B?a1JWdG9JK2paMlNqMGhIbFdmTU1KRk5vOXlQaFFkSC9jam8rSlNoOThOelJl?=
 =?utf-8?B?NDNDdFdYSFVuOEVJWWFiYktJNjhlTGI2Ykx3MS9TNUxneXgwU1k1WWh4MGZm?=
 =?utf-8?B?dzlDMFhxMHh3a1pGbmlQaCtWempVN3ZPaGFmYVlYWHlSQlM0cVVLZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71ffca8-15a2-4d4d-390b-08de577b863d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 16:55:18.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s7avZFoeY+DppyTPKvOX6SMykwRSLIfIfpj3Y30RRRFF6uhkr8wZDIaBlQ0UsMwGxwUy5wUcYndd2l4ATZaKzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399



On 1/18/2026 4:51 AM, Armin Wolf wrote:
> Am 15.01.26 um 21:31 schrieb Mario Limonciello:
> 
>> hp-bioscfg has a MODULE_DEVICE_TABLE with a GUID in it that looks
>> plausible, but the module doesn't automatically load on applicable
>> systems.
>>
>> This is because the GUID has some lower case characters and so it
>> doesn't match the modalias during boot. Update the GUIDs to be all
>> uppercase.
> 
> Hi,
> 
> this is the second time that such a error has prevented a WMI driver from
> being loaded manually. I am planning to replace the usage of GUID strings
> with the guid_t data type in the future, but for now i think modifying
> file2alias.c to fixup any lowercase letters inside a GUID string will
> prevent such errors.
> 
> I will send the necessary patch once the WMI marshalling series has landed
> upstream. 

That's great to hear, thanks for sharing.

Thanks for finding this hard to spot error.

Sure.  I was really surprised it existed since the beginning of this 
driver.  That (unfortunately) means that very few people have been using it.

> 
> Thanks,
> Armin Wolf
> 
>> Cc: stable@vger.kernel.org
>> Fixes: 5f94f181ca25 ("platform/x86: hp-bioscfg: bioscfg-h")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/platform/x86/hp/hp-bioscfg/bioscfg.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/ 
>> platform/x86/hp/hp-bioscfg/bioscfg.h
>> index 6b6748e4be21..f1eec0e4ba07 100644
>> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
>> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
>> @@ -57,14 +57,14 @@ enum mechanism_values {
>>   #define PASSWD_MECHANISM_TYPES "password"
>> -#define HP_WMI_BIOS_GUID        "5FB7F034-2C63-45e9-BE91-3D44E2C707E4"
>> +#define HP_WMI_BIOS_GUID        "5FB7F034-2C63-45E9-BE91-3D44E2C707E4"
>> -#define HP_WMI_BIOS_STRING_GUID        "988D08E3-68F4-4c35- 
>> AF3E-6A1B8106F83C"
>> +#define HP_WMI_BIOS_STRING_GUID        "988D08E3-68F4-4C35- 
>> AF3E-6A1B8106F83C"
>>   #define HP_WMI_BIOS_INTEGER_GUID    "8232DE3D-663D-4327-A8F4- 
>> E293ADB9BF05"
>>   #define HP_WMI_BIOS_ENUMERATION_GUID    "2D114B49-2DFB-4130- 
>> B8FE-4A3C09E75133"
>>   #define HP_WMI_BIOS_ORDERED_LIST_GUID    "14EA9746-CE1F-4098- 
>> A0E0-7045CB4DA745"
>>   #define HP_WMI_BIOS_PASSWORD_GUID    
>> "322F2028-0F84-4901-988E-015176049E2D"
>> -#define HP_WMI_SET_BIOS_SETTING_GUID    "1F4C91EB-DC5C-460b-951D- 
>> C7CB9B4B8D5E"
>> +#define HP_WMI_SET_BIOS_SETTING_GUID    "1F4C91EB-DC5C-460B-951D- 
>> C7CB9B4B8D5E"
>>   enum hp_wmi_spm_commandtype {
>>       HPWMI_SECUREPLATFORM_GET_STATE  = 0x10,


