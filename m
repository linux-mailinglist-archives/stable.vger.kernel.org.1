Return-Path: <stable+bounces-43071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B38BC0B9
	for <lists+stable@lfdr.de>; Sun,  5 May 2024 16:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CC928252D
	for <lists+stable@lfdr.de>; Sun,  5 May 2024 14:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604BC22334;
	Sun,  5 May 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o+H3V08Y"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DA9208CA;
	Sun,  5 May 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918687; cv=fail; b=DkrPM3XsBpHolLDM9YQ7xBKUuHSBgSwJ+we+tXk501viuTS8/7KUxPxlbbpZ9WAJVw7bwzXb3jmlPB2YedYnra7tmwk/dzfLQmmf/16kYRrU85/1pP9D9P40euO17+s+6vVv2eqk0/BzkDVwmVbWBi7FAZqd/pIekBYrFWRStJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918687; c=relaxed/simple;
	bh=nL8PDDWgGQEwWbcv8lPqHrRv1IjtA0JMgwC/nkA6mOA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MR7ckZgLoPT87fPhuzYpyWCqqklg8wAdby+66ykT5y5X0u+bYedpZqNcZzQMmPQOhiEI33xU4eiqwwljxYAVNbrR6fNr93db44srzeAMLHIaaq9jeKqaDQ55uFVvmJasMTwHTxNGb2Z2Nrgr+9KQ0ipX3dXxeByDffVZT3a7Lsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o+H3V08Y; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQEZcx8bZHmlNeR6ka4qIeMo1zr3VZomtGlMq3ypAD248oBvu94F2vAZb3DN6i3BsNvvsBvVbLaEfB690sDxndfXk0Os9yv1dHwFAspt5sbq1uu8oTWRKwX8DFAi6F90lUzysPIUekPJTHOt3wJLmG3znobb9ID3Xa1FHcAyDxdHVz15bt0A4hOsJ5dlPSFiv3aWX2yMjXSl3GnPSbZ4ZCvYsS6T1unZvhhT1OYcEvP0xcgOnMbDMUAfsVAUEH03vaP4gwEit1YiLlX+C9B7pLPl6SefnH8MeqJNB6RoJFwVmKHTCn8zTixatim+U6k0ONO//UbnYbUPHKOH27JnPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9wRphGIs3DaoweQXYq/YwrDwU0+6FRdnMePEBMWdXU=;
 b=Tl9f/dum/ren3uonLhZCeUTEnGBhk0qUGccDZ8fbUIdmIJu/vkp9CPudmT4QDRB1lxlWaTpxox1/cWj9tiBFQJSIi3xm5VVOjJhd1AeC1OQ9UPz2FBPNlpe8p6T9ZUn7DJuwRKQd3/+JqABqaJdWDQMXmZ4R5KqGCSEjRDRF3Z+JFNStUcGCVrATjF7wr4PAsSkVBuIORrQLNGXRdvX9xaYnruTM9OhcbdXvAncisC8gDAejRExbinogPVlxfHe5c+X48EQSdEVKjNewFQFfBX/I90viLI2OeGvGaH6fKX6i9UFsBkoMkma7KAQUx7SjL/nNYZLZWvzBHzOAsF2t1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9wRphGIs3DaoweQXYq/YwrDwU0+6FRdnMePEBMWdXU=;
 b=o+H3V08YJ5x4uLZV6i2Tw/aKePMz8obCD7nZa5MyXGZBQOWJZjnfDO58Xz8XLv1gB3b84tPIr+eMtmhzZKC6MaUjAtfhYpK6777qaw2QSgrFvvnQmU/AfkvgaUUE+INAKzdfk6rTZ9nDi+qeOFRQA+wYqSAUsu0wJduePTjHYLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 14:18:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 14:18:01 +0000
Message-ID: <c1399f72-e8c8-4474-afee-53e0c6f0d1fa@amd.com>
Date: Sun, 5 May 2024 09:17:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Thunderbolt Host Reset Change Causes eGPU
 Disconnection from 6.8.7=>6.8.8
To: Mario Limonciello <superm1@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Micha Albert <kernel@micha.zone>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <wL3vtEh_zTQSCqS6d5YCJReErDDy_dw-dW5L9TSpp9VFDVHfkSN8lNo8i1ZVUD9NU-eIvF2M84nhfdt2O7spGu2Nv5-oz9FLohYO7SuJzWQ=@micha.zone>
 <3f1f55cb-d8df-4834-b22f-c195d161cab5@leemhuis.info>
 <1eb96465-0a81-4187-b8e7-607d85617d5f@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <1eb96465-0a81-4187-b8e7-607d85617d5f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0276.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 805a4f1f-ccdd-4846-51fc-08dc6d0e2b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1ZLR1V1Mmo5R0NRNWNmZWtQNkJxYTlIN2N6NHVPQ0FENUhoQ2tJUmxxanJz?=
 =?utf-8?B?NlZvdHRxbm1rQmg4enlyZmhvLzl4ODRodFdhU2E1enJ3d0dQVTBWL0VLYXZJ?=
 =?utf-8?B?Zjk5azFlNGZsZWxXdllYTlFjYTZRcjdwMjlCUVhmaEkrcUdndGxtSEFZdHd0?=
 =?utf-8?B?cTlwakxvTlErOVRPOGVjNnBtRmxkSUNWTm1scllWckQ4aG16YVJtalpIWmd1?=
 =?utf-8?B?WE1Lb041cTlleTFYSXhiOTZ0YnhjNlFKVUg0SGRKZUFnVkFsNXdkZ2ptRVpl?=
 =?utf-8?B?ckVrMEcrWFNONEVvNXlnQ0w3clpoRUh3NTZIc1dhaVZPbkdkRi9zaDdYZFZQ?=
 =?utf-8?B?ZHEvZDg1YkRsUXZrTG5IeEZjV1ZnN0xHUGU3ckc3TEdyYlJJU2t1V1ZlNkdJ?=
 =?utf-8?B?dDdRajErcDZPd3p4NW4vVkpSV1JSOEJuRXUwQk82SlZIcDc0NFExNmpXSUhS?=
 =?utf-8?B?UUVjY05HblNPL3hWU2hEK29jd0MrbnpZVnZUTzJ1d2xTSis4WHdSTnF4RTBW?=
 =?utf-8?B?UUh1UTJKSHZ3OWVoZ3ZTMTgxZlFTWHpSZlZRTnE3cU01Q1pGRVFHK3JWbFQw?=
 =?utf-8?B?U2JYLzhDcU5STjNYY0EzUGhhSUN6bEw2dzdOalB4bmlObjlHNzl1WkxWZ1FZ?=
 =?utf-8?B?ckNTZnVFcVZwaklKRUE5NjZVWUlsaFo2Tzh4MHBVQW1nc2F6WmhZY2NHS1NK?=
 =?utf-8?B?RHAwRGp6ditFRFZ3VjZJcXJGOVF6eDJWVmtGeU44RlpCWE5BOEhlRUUvcVp4?=
 =?utf-8?B?RlBDQjRHb2JCQUtvWVVjMDRMV1E4RGo2SUVZOE9YSTlJODRUMUxFRnU3ZHdS?=
 =?utf-8?B?dmtrU3ppRjRuR2J5ZXJ0VGZUT21tL0JtS1E4UFBFQUthNzVTZlF6K1d1T1A4?=
 =?utf-8?B?Y0JiZlo5cngxSkd1cDhSWm9kdkVKUkJQUnFmSmpONW11S2UvRHE4bktYUjNR?=
 =?utf-8?B?V2ZOV1VaSndCNHZDYSt1cFJ0V0w5dHFKdTQ5SzdPclM3RC9uaUlEVlNodzFZ?=
 =?utf-8?B?YytXVzBQNzRZL3hzQXh0cFJYUzFWeTBjSnNlVTBObTJGN2xLdytaRlg0b1N6?=
 =?utf-8?B?ZTBOYklxTjZiTzlMN0pkOFBMUm5Eak5TK2gzY3Q0WlhkZkoyK256N1VPL21X?=
 =?utf-8?B?WGZ6N2ZxcTYrQlBoRWx0MjhDNEFEdkVBcldScExmMUNIYzNuVWthdmppM2ZR?=
 =?utf-8?B?ajRpMS9jQlVndVdZWk5HK08zcm9GdHlQVE5EU3JVbzdlZm9JWndrRGNrYXVj?=
 =?utf-8?B?UXdqRTJpb1h5RlFBN2IyMTMza0hNek9SaVNlYkUvWHNHZTMwRzM2WWNzcWFz?=
 =?utf-8?B?dk9vZXNIM3BSQ2hUSXJxK3I4SCtVZUZIVUVCYm5SWm9KQVVXLzFDWGlpaHh1?=
 =?utf-8?B?YVhsaHVnbGZpK0pDQ3NKMGFHOU1yWjRPTXYxK1RGVU0vNFVWdWtXbnd3eW9q?=
 =?utf-8?B?WG9TYk95aWZhSWRaR294cTFhais4UnZwdC9lVTNyUkcrR1NoY3VKeVBCOStF?=
 =?utf-8?B?UUhXMVdXVEM1Z2lPdmxjZXBJVS9qTmRPcVh6dE9hM2wwRElNd3FZMEk0Y3Zs?=
 =?utf-8?B?TDBkNGYraDdpTXBVSGQwelNEZnNUcE9abU9EcmRZcG9TQ04rK1MrU2tPUEhV?=
 =?utf-8?Q?m6KTcWbrC4AyClpRFnyKxoCz1trwG3ZVKAqhu2i6kXcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3VEcjhJVm9DamlVOUtVS1FsQjNkLytiWC9UNHN6V0ROMTZ2QU1EKzdpaE9n?=
 =?utf-8?B?YXhlUm15ZDk4ZWhjUU1zWkFwWWhZeGhkSGU5SWg0dklMSC85WjFFNkliOHFv?=
 =?utf-8?B?ck5tblA2Y1g2SkdOSXBOYlZnNlpVZWpkUTZONGFGRFkyUEpEUWlad0Y1eG40?=
 =?utf-8?B?SmVwQldOeEZwVFIrenJ5ME5BSUtmYmh4Uys2WUNTNGxTQWRCSGZJbExFY3Fr?=
 =?utf-8?B?bTNnVGpwV3NWeWlOTEN6SE1sazd0Ly9oYkNTa0FHQktVUTE0bmtFenJEUEJS?=
 =?utf-8?B?bmh5MnZkTHR6WTF5MS8zRFBPcjBrMUhVbFdYOEYxb2VlN2hEOVgvd1dUcHJO?=
 =?utf-8?B?ekIrMkRpc3NUT2ZGSUpKeUF4S3k3ZHU0bHRpWnVpeTJwbGE5NVFaZ2gyQSts?=
 =?utf-8?B?Z0FvTE16dUtsaFZpRTlNSitFek1EV2FqNkUxZ2JaV2N6TEUyUTZiZzh4RVgr?=
 =?utf-8?B?ckh0SWZGbXFDVDFSV2owdVRJUWtTR05vOXdhYVN3VDU3MHJ2ZUxlb0tBUHZm?=
 =?utf-8?B?c3N1TldNT2kwT1RSdDFGU2pWYy91TVoyakVLOHFUWDlCa0xMYkJ6MXIyOCtV?=
 =?utf-8?B?U0V6d2VmN2tFMEN6TGhSM3RoZFZBQnNvcWRNanBMMnpKTWNpdlZTWDZIZ0Ey?=
 =?utf-8?B?RURmV3B3TE9uMnduamJvNjRaZ2ZxbjNCYXFiaFQyZG45OUdPOW5LUmhseTBE?=
 =?utf-8?B?R1NHUzQ1dUVHeVorcHcxQ21ya1BRaU9KcnBSek9mMUNNd3VMTXo1Y1hvLzlt?=
 =?utf-8?B?ekt0czloMjhzV2h2UzFrNUIvRUFmYW94U1dBL3E5NXhyd2xkYXdtbUNlYjRn?=
 =?utf-8?B?ZjhITUszOWR4eis0OTIvbm11SzhRZ2NZM3gwUk93Q3NoazNVYlgvV2J2SW1B?=
 =?utf-8?B?OXpubi9oWmVBUXpjNWJhYzZwL2JGRm8vL0ovWlFuV0hZaTAwZkhJL1EwQnpq?=
 =?utf-8?B?ZDdTRzRKVlEvNTB4SnRkc0VSMHRjMzNEKzRsZEdRUE1FU0d3MDVmaUsxY0pI?=
 =?utf-8?B?eHN6N2N3WlJrbGpUOGs3RHA3S0EwdENEZEdCajJCK05kN2JjS1JQeERXYWZX?=
 =?utf-8?B?ejV1TnlFQzJ3N3BsMHMzVzIvdG51L3pzdzNNdkdtc1BjT1UwZzllMWxvTElW?=
 =?utf-8?B?b2FlL2pFWUUxcWtNY2xLY0hpYS9NYm1NeFU0YlhPVW9Fa1BwUm51ZCtCcWg5?=
 =?utf-8?B?UWl5MnYzV0c2SGFEWURTbndtUkU2dWtqNVhuaUNEelVDTVAreHhtWXU5SlZl?=
 =?utf-8?B?N2Z2SE94anNqNkgrNnpoLzc2cy9kZDIxKzBUVXhIL3BMS0oybytDYzhLaEhE?=
 =?utf-8?B?RWx0d2s1akUxS3VKTnovUjc0U3JhbE8zQmM5SmZEeXhIdXA3OHgxNHByb25W?=
 =?utf-8?B?MHZYQ2RVMHYxbWMrUUZQMU5xVU9aZFYzMXNVamFoWFdnRCtHUDRzUnVZWUJ0?=
 =?utf-8?B?eXJyR3dlenNIZnppNFRmQWc4VStlbVp2dzdkb25DM0l0em95N2ZiZHU3N0M5?=
 =?utf-8?B?TUo5VWdzOXdCMUFQcmt1QzVscTJhREtYMHBBcXErRU1NZ0FoSGNDeVdmN1Z3?=
 =?utf-8?B?OVlaMFVrdkc4RlBucmJOMi9WTVJKRlpuN3lmOUR0UThITEN3ZU9yT0p0Nzk2?=
 =?utf-8?B?K2hSSWRJTStNc0FxZFlMQVMzVHZvVFpiNURoT0VXSUx3c0kvQU5RVzFuQ2xR?=
 =?utf-8?B?K0lCRnJkdUJzVkZWL1BucWUzUjVMeEl0SnlUdUNRVFdEMkFJUVNMN1pTMWEx?=
 =?utf-8?B?d0VvK1RFWEt5eWdpbis1YlBOTEMwMWYrOEsyWk10Mkg2MXRlNGg1dVRFNEFC?=
 =?utf-8?B?UmhCK2liN1liVjM2OXlzV3NrSGJDVmx1b0dWWHFGY2xLWllTMFZXaE1iUHlT?=
 =?utf-8?B?M3NLNkMzQ0owdFFZMTZXOFMyOEVkcmQ1ME9pcEtJdy9mMnNHak5aaDNkUFN3?=
 =?utf-8?B?dU55MWp2Zlk1K0RWUDMvS0pJUFhaWCthMWV4K2wvS0Q2a3NJMmFKWkRlSkx5?=
 =?utf-8?B?ZFhGaWFDNlArR2grVFVaUTlHbDhqVVNXcWJObW5aUjBRL0RDVHN3dmc2aDM5?=
 =?utf-8?B?Qlc2bmg4TCtQOGxIYjExSTFZY1FyejJWRFNNb3JWNzVneE5xQ3NETGNFQmN2?=
 =?utf-8?Q?Opes0maDEyHCxV3zpqHb9CxzZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805a4f1f-ccdd-4846-51fc-08dc6d0e2b9f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 14:18:00.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TCqvcgO3JfZXwURkItvjeaFBcLAHqrhiVSPidgPBCpR1rR4MI9o3QlF6vcICJNVdSRzQbx76m5P/Wilx0k9BoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729

On 5/5/2024 07:37, Mario Limonciello wrote:
> 
> 
> On 5/4/24 23:59, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [CCing Mario, who asked for the two suspected commits to be backported]
>>
>> On 05.05.24 03:12, Micha Albert wrote:
>>>
>>>      I have an AMD Radeon 6600 XT GPU in a cheap Thunderbolt eGPU board.
>>> In 6.8.7, this works as expected, and my Plymouth screen (including the
>>> LUKS password prompt) shows on my 2 monitors connected to the GPU as
>>> well as my main laptop screen. Upon entering the password, I'm put into
>>> userspace as expected. However, upon upgrading to 6.8.8, I will be
>>> greeted with the regular password prompt, but after entering my password
>>> and waiting for it to be accepted, my eGPU will reset and not function.
>>> I can tell that it resets since I can hear the click of my ATX power
>>> supply turning off and on again, and the status LED of the eGPU board
>>> goes from green to blue and back to green, all in less than a second.
>>>
>>>     I talked to a friend, and we found out that the kernel parameter
>>> thunderbolt.host_reset=false fixes the issue. He also thinks that
>>> commits cc4c94 (59a54c upstream) and 11371c (ec8162 upstream) look
>>> suspicious. I've attached the output of dmesg when the error was
>>> occurring, since I'm still able to use my laptop normally when this
>>> happens, just not with my eGPU and its connected displays.
>>
>> Thx for the report. Could you please test if 6.9-rc6 (or a later
>> snapshot; or -rc7, which should be out in about ~18 hours) is affected
>> as well? That would be really important to know.
>>
>> It would also be great if you could try reverting the two patches you
>> mentioned and see if they are really what's causing this. There iirc are
>> two more; maybe you might need to revert some or all of them in the
>> order they were applied.
> 
> There are two other things that I think would be good to understand this 
> issue.
> 
> 1) Is it related to trusted devices handling?
> 
> You can try to apply it both to 6.8.y or to 6.9-rc.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/commit/?h=iommu/fixes&id=0f91d0795741c12cee200667648669a91b568735
> 
> 2) Is it because you have amdgpu in your initramfs but not thunderbolt?
> 
> If so; there's very likely an ordering issue.
> 
> [    2.325788] [drm] GPU posting now...
> [   30.360701] ACPI: bus type thunderbolt registered
> 
> Can you remove amdgpu from your initramfs and wait for it to startup 
> after you pivot rootfs?  Does this still happen?
> 

One more thought.  When you say it's "not function", is it authorized in 
thunderbolt sysfs?

See 
https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/thunderbolt.rst

Is it showing up in lspci anymore?

>>
>> Ciao, Thorsten
>>
>> P.s.: To be sure the issue doesn't fall through the cracks unnoticed,
>> I'm adding it to regzbot, the Linux kernel regression tracking bot:
>>
>> #regzbot ^introduced v6.8.7..v6.8.8
>> #regzbot title thunderbolt: eGPU disconnected during boot
>>


