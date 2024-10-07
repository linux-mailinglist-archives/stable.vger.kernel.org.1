Return-Path: <stable+bounces-81481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AFD993851
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 22:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93E9284B7D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 20:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16808156665;
	Mon,  7 Oct 2024 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B+D+I0w8"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FA320F
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333195; cv=fail; b=CJ76DOQu1NYESMVWzQAUOb3md29WhF1tpOy43F1HEX470tqD53jqxgbrxADVUsrt8UhYOd9bETIPk510EHE9BBeLwZaGZS3uR8VwYq+uYJL4IeP99FiBjS5DGjgwO+Jvs6hMJDgTLsTvHfqyHf7NIttnJSMAok+56LedD6ij+Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333195; c=relaxed/simple;
	bh=IL35gLo7d2DhxyT6sk+jFaD+NLvvZOZn6nMYaGdUQs4=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=lXEsbCuSyGw0DJQmsNYNQe+biKmVucjGmDVuaZ9pJLj/zpAa96SgONfps4Qf9zQRYXvdlneZWEUuCpcbVYHJ4EnGukB5fs1RVJ7wILFR0I+chrS0oDGL9v92Ty0rTdNzN1Jz98vMMcYZTcltJfFyqIpuRFGmTIpvFlo+7Ruf6Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B+D+I0w8; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/dwNsUBorU1AbsYGRvkt9vGYZ6L0M/F2BPX+jFnKGwb/U5DRiFteVQVHL2hERs1Mu1ouC0XiCTqlzEtzZVLVFkjhoGz8cy8+CAFgw3A/+ckaHpSYBRYHM3KryH9qwmscAjBiNrg7dJTvW4g/N96x6b+IinZlauozr4vo4eSCS9yjQtobBF8VV9AjG8hNsm7ZgLLBwmU+/xQzVLiKJIFuWa3jsB0IPD4NSA9KAIYHTX10z7cdDfFAJFMN9tOgOebY0z/0O/BXYDqBeuxI54fBkM3/No5y8oE2gXCUZXo/tlTts+APAkUA4t1/6dgeytfiSQOXBdC5s4D69VyzvJd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21D8DoSLrEDiKqmiZgEZQGETQrk46hiR+v2Evyk+ZdQ=;
 b=TjRwgDv84xnpJloVCPGINDToxlsHc9uNESP9Ku7cG6UV047H/t2aJEQOHm1OZk+7C+8ZvlY7rgu9e/P0QroKuUxo+9w/pBt2q8zUVfunShWbhClR6Xw9+oYHcR/I32qnpHv5DFKHQzWKFobF+loKJCdB32iAA8yG4GKhCW9ZJtf9va35LtXZGwXAU3QbbdUezb5BfOJLiH4sfRQZWCz2wAj9/QhD30JG4NTlYy8kzvz0FHfNkGGgbWJUttL6NK+R+9ljwwwW2UUU0UscyMuMqPimxx6ufrEzh4EaQICYweqEUCD9mN6qicc5cZiRGM0p+IKmgJbl14qBPqm5uOguMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21D8DoSLrEDiKqmiZgEZQGETQrk46hiR+v2Evyk+ZdQ=;
 b=B+D+I0w8/cleDHjubXuvJNAe0kM5vzt+dFGp7r4vJaJ63AEdZd7z0F66UCiK5q1WPiy8yYBVZtGkjfRFGbCD+IAte9F4+gTnuzRcpv1QsWywmlEn/f+f3IFmgFCW2v3o0PRArJU8N2udRcLfJCzLCgN1duZAhNdHA+DEJKhwwDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 20:33:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:33:11 +0000
Message-ID: <d75e0922-ec80-4ef1-880a-fba98a67ffe5@amd.com>
Date: Mon, 7 Oct 2024 15:33:10 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
Subject: Regression in 6.11.2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:805:66::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 238dd195-303f-468d-a018-08dce70f4302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zkc4RU1aTUY3OWNMZU5uYzhpK2ZHSW1RZlJoelVpRURDbGpheHhGYVFCVmkr?=
 =?utf-8?B?aVpvYkhxWW9xUmduUFRGVzJpYXNJeDVXV3IxRmk3Q1JJaW9McXdaM2RhUzZZ?=
 =?utf-8?B?UXNZZ1NWaVppaE1CSzdQbmNvUzBkWW1NNmN2N2puZUZ4d1Jqczk4TFNSYmpY?=
 =?utf-8?B?STY5SVQ5VEtJbENkdEpiUUpHcndhQk96QjJKUmtyYW1QTzNLa01lTXNEb3di?=
 =?utf-8?B?ME9JaXg0bksreFJEQXlhaW5La0RpNUI3OVZQUWJaeTJseWhzOXJoOUdnU09Z?=
 =?utf-8?B?YTB0cVBocUEyYW9oSHdhbzkzL1FmN29oV0Z1bDJZVnQ3SktOYnZsVmpPajNk?=
 =?utf-8?B?WEtRdFJzSndIRU9YOVdsNndOWXNOcW5PRElOWmtRRm5SZElXcFpDRUpRZnA5?=
 =?utf-8?B?TVh6S0VBbGR4dGdVbDZRV3ZxUzRudGowNzNGV2s5bTJubGVHNERGK01ZR0o4?=
 =?utf-8?B?NjE1NXlXcHowaXNFS2ZQdVBybnh0Mk1PNGk1ejJiTzU3L3ZvV0ZMdGxtazBO?=
 =?utf-8?B?L1FQMjB3OTlEQUJVeDhyVDdKUGlBZTNOUU9RcVVrQytHakJTUUpVNHRxS3Rj?=
 =?utf-8?B?dnY3NmlYdjBDOWV2QVlkSlIraHNtMTRzVnZWZjl1ODBjZVlIVEp4SHcwUVc3?=
 =?utf-8?B?K29ETlJENU9nNGJzeWtMUnNnczlIV3NNZ2Urd25mMG9KWS80ZGV2QTIxanVO?=
 =?utf-8?B?UzJ0anVlQ2oyOUgxUXFLOHVPNFVYNFBkUzNxN0QrUWtOUXBjeGwvY3NFK0c0?=
 =?utf-8?B?a3cvekVsVjVjS2doSTF3V1Fjb0NMRTZFRHB4cWZ5aHJTcCtQRmJTd1ZpYjhr?=
 =?utf-8?B?emhZY1ZwbVg2ZDB0ZFN4ZS9HTHNCTTRoSU9nb0pYcWN4YWxacE1rekd2cU5q?=
 =?utf-8?B?c2ROMUZ0c280Y0VRVksrbzIzMk43M012RDRhZnVyRUpsUmwxb3BreEJ6Q0pz?=
 =?utf-8?B?U3FxRWxOMFVJNStQZldmejROSTlWbmtoVVUvZmhCZXNqU0dURHhiNW55WDEw?=
 =?utf-8?B?NmpmS2F5WWFNRnZ5a3J6OHJ3Z1RETDJLNWZXUzV1N0dRWVdMSDczQ0pxWTRW?=
 =?utf-8?B?Mm5HWmRjYkVBa0hJYXhFWmFteGtDZitaTlIya1EyRmRWbW9iNVhhOXdCWjNV?=
 =?utf-8?B?c2hpalNYS0dKZ1RjcldmUTNzWnFLZ1Q5eXFrYTRqbVIrZXBwdERRbFlxNTUv?=
 =?utf-8?B?VjdIaGNMSmRlNkpkS3EzZHBQQ21nTFZDNVlSUnN5b0k0ejRwRXJuY3R0M3Y0?=
 =?utf-8?B?ZVpvZ09MNENzT0NUaEJmT2gxam90djVoMDl0VUVJM0JTUm1ESWVzbXNvR0R4?=
 =?utf-8?B?aVBNL3dJc3I0YjdYZ2tzeVJheU1HRFB1Ris4RWxrZ1JOMnBtOEd5SlFZcGFJ?=
 =?utf-8?B?R2ZpQk9NRVN3L2xQUmw2K053Q2huU1RzLzhna3FVTFN5YWFaaWxvVWRMeGFC?=
 =?utf-8?B?U0RtenFjRFJMYlJIMkpJejdsRFFUQUZrbTZlWkNOL2RpSitRc3FBUUIzS0RZ?=
 =?utf-8?B?N21WYnFYODNhNDJPVnlzYThzeUNDWFQvcmFEc0dFMSs5cWZqb3Q4UzJUNm8z?=
 =?utf-8?B?NTRCSFdaUFF6TlN0aUFoWFZWTjc4dlFKTEc1WVhUNUlCeG95QXY0L1FTQUVz?=
 =?utf-8?B?RFZTakM1QWdSNE1YU0lza200emt1c1NpWGJuYW95L0RQQk5GVlpheCthOUtX?=
 =?utf-8?B?aFlqaFRjeHh6UmgzdkE2VWZicUVrd2VzM1p0eXhoNFpKMnh4TXZnTmZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDRSYlFmd3FCeWJtM0JPQXh5ckJQVGRTNDBzaWdUdU9ISDViWS9IN2U2Q2VL?=
 =?utf-8?B?Y3E5SnozWHFCaGdsZVZHcytOSkt3MGl3OUFNL3N2eFIrWkNndVMzSVRFaWdC?=
 =?utf-8?B?ZjJOcW55WXpSaTJucVVNNVB3UlptYW1MMmQ3ckF6NFRVNnpSTHNHZXIrdzVi?=
 =?utf-8?B?bjV3eVZ5aXFMNmt5Z0JhMmVlQUhRM2h1dTZBSjFZbUlrRldobHJFa0VNUkE3?=
 =?utf-8?B?NlIwT2xOeVFoaENjcE5wZEFxMk53M1d1cmFod2Exd0VoMjZJWXJhbHc2a0pN?=
 =?utf-8?B?Y0RKYnlYNy9FSnp3eitQWTU0VllYa21iSnBMcFU5RWlxY1oxeW9VcHIwcFZX?=
 =?utf-8?B?bmY4cy95b0VKSU85VTNjRFczM1pRblc2MHppUFRQS1h3ZENvcWpFR0ZwcGxF?=
 =?utf-8?B?bDBmVGg2d1FzWko0dHN4cm9QdjlxOExYSGEwYUF5Zk5NY1NIRCtVZCtMRDlB?=
 =?utf-8?B?UWl3anhIY3daTU44bmNpQkVKSFk2NTIvMHEzN3NYOXppNXhrbldnWjVtWkZI?=
 =?utf-8?B?VG1LejluOEIzTEMwZC93TGlOWm5KVFU3dE8raWRRV2c2WVlSRUZjV0xBVUF0?=
 =?utf-8?B?SjNmREUzM1RTcVVKQ3BWbzV2cTZycVFUWTYxRDNsZUkzRXNvU3dFRE8xQjZ0?=
 =?utf-8?B?MUJJMW5JVzlsMWE5WVRIS2EzdHBSTHRqcEZKOFBtUWtqUG5OR2x0aThqdE9h?=
 =?utf-8?B?RW1mZ2swMy9GUGxrMWFTVjhZWExOWlo2WllYZzJEaDNhY2x5ZkxZTS9TdE1K?=
 =?utf-8?B?ZWVtT1lYVmtudW5odkQvQ2tXQkUxOVdTTXJPMjlDWFpEMS9IUGhjVDc4ckhu?=
 =?utf-8?B?U2U3bkJJSHgxUVVCdHExa3FWSmFRVUhqN3ZXZkRWZ2N5ejdnQVlva0RFcVB1?=
 =?utf-8?B?WHFFZCtqUFlQOTRrMjBhWTdmeERKZ1RRekpTUyt4OHpHc2RZYUpyZ1dCZUZv?=
 =?utf-8?B?aE5JTjRMcVFVTlNGTHFkWnk5YVhJb2wyUjJQQzZBWnhSbGN2ZStZTkVzUzFJ?=
 =?utf-8?B?bG9VTElHUGc3S21uTm4rRUZFa25oQm9lcTBsT1g2Z3JISzJGRW52dkp0TzdH?=
 =?utf-8?B?YitnV0NCL3UyWnJMbFZwcVR0WjNYS1lsazgrZVlyUEVCYkVJa01SR1d0c2pS?=
 =?utf-8?B?UFB4blF0QUxrQm1QOXRuWktSK0g5Zm9MNWRtbm5ETmVmdEYrdnZSUmQ2NHVC?=
 =?utf-8?B?bDJjMzl5UkkvZkRlYWZXc3d2cks0bURiYzB3TmpsZUdsbFNma2c4cGVXZGRB?=
 =?utf-8?B?L2FPdUJSZFdvQkM2MWQrbStnelVhK1RFcVQxYXQwbXBBUzBlR0xPQzZNTUNy?=
 =?utf-8?B?cEs1Vko1c0J5c3ZESzBjNVBoS0c1ZG1xNTk5aHROYVhIUGdUSitvOUN3aTYz?=
 =?utf-8?B?MExSdWVJRXFHVXJVUlFPOERUSWR4VE1tSVd2S0F4WHNSUFJWVkdNa0lDWVpX?=
 =?utf-8?B?dm9BUFZ4MHQrcU5HTXRVZHVCV29rOFV0OFZ5VTQyVTZnSnl4V3N1cWVYZno2?=
 =?utf-8?B?VERwOC9uL1VWWGNqcStFM1hKcnRWMmR6a3dSMWc2b0tSQWJpNlRtN0I4Skwz?=
 =?utf-8?B?blNWOU85NG83Y2wvK3ZlV01IZUtYN3ZjOG5rcGJaRVNoUmgxbnNvc2tocXVK?=
 =?utf-8?B?bWRjN1Mxb1JMd0d2Yy9tazZjRE5PbVF5dENiOC85SVZiOWpsMVJsb3ZNSFBj?=
 =?utf-8?B?dzB6Sjd4RXBFYldwaXk3WTJiQjFiMStwYUNDTTg1Rjg3ZlovanFUdGtJZ090?=
 =?utf-8?B?SzBEVE5yUWZUK3ExNXQ1NU9TempsYWlBMUYvdEtka0gxQkdRQXh6MFREVkZt?=
 =?utf-8?B?RWJ3aFZOZFYwTmZTTGZIaWRNcUE2WHF2YjUwZTg5REtQVFUzdmJmdkd4MVZq?=
 =?utf-8?B?RVVMeUozTVozUHVnemtZbjZoVWNQRzNkcUNrVlA4dnJaRWhSallldTJkWm8z?=
 =?utf-8?B?R3Zud1FnUEt6dVRvSE1zazBVakxHdmZiVWJ3Ym1Edm5xSWFlTDcxL0F6THFR?=
 =?utf-8?B?dDFudzFVWFA0L0QwVVVnU20vUEZTQ3RCQmNLd2laZ0FWSkRVbDE3WE5KNjlF?=
 =?utf-8?B?MWp5ODl3bmxzNjhkWEZYVUZuVTVSUHJMWk1GdHR3am9tWXYvMXdIWHp1aWxr?=
 =?utf-8?Q?Ev3Ncxe8qIJEg2LTtgGkQK7jQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238dd195-303f-468d-a018-08dce70f4302
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:33:11.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDPY3IzgX1E46AerpuKqHpe6aDAVxbM9J9ywMsqtAu7m0vyCTiBrqzf23WKoGNzqyXqn5oe2qITD4zcYlCa1Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291

Hi,

commit 872b8f14d772 ("drm/amd/display: Validate backlight caps are 
sane") was added to stable trees to fix a brightness problem on one 
laptop on a buggy firmware but with how aggressive it was it caused a 
problem on another.

Fortunately the problem on the other was already fixed in 6.12 though!

commit 87d749a6aab7 ("drm/amd/display: Allow backlight to go below 
`AMDGPU_DM_DEFAULT_MIN_BACKLIGHT`")

Can that commit please be brought everywhere that 872b8f14d772 went?

Thanks!

