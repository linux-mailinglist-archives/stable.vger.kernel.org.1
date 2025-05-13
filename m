Return-Path: <stable+bounces-144072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F22AB4901
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 03:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF4B1460960
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 01:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DECD1990D9;
	Tue, 13 May 2025 01:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QcAY2vFq"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B191BC2A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101576; cv=fail; b=Cz9LzzdgLdaDfDolRkdLG2HsZTZcDK2njcpUsMHo3Be1BP5BKxERqU1IyVl/N5TjP7mbUNgeVh1KJ0b0zbwwVF/gpTaNEPJB/eGqHFUXzXnOYpkgYCdSJ6WFEawVZJX65NHtRw7lKRE0HGm0Tfd25exk6BO10/KvxgSyPE/YEHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101576; c=relaxed/simple;
	bh=f/Gui63NMNfJHs2htu6txUZRPWXAzaJgAP4Dypi0Sy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WnNn5zWui4vIFIGAUDdcp4+lsI4WKi+1Rz/VnSvADYntEzSPdbJ3EOFanMMKhinVDXRWWipPZq0/Ijf7B2DHNzH1iiZJz6bqjjBnL29Yu2BkyMjrPpDuD6hgcBUWXq8Vuxj4baaF1YDpbtO0XsoW8Dv30nJXDHozFUO/wXbb7IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QcAY2vFq; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aC5glE6S2NWFqxLhbZKJhlbEnate2wAzYD60gCNQEx/T885K7loBzvLL34meTVKd3mfFGl+9f3FtBjgMhz5RNrjr0HHCQRAvkpXu4CFgKpCj9maRfly4Qj1AvTi8eZP31abvyk8VpaH4SO4uYbSg97/avXVsWApSvvIi1RVl9UNx6y2UDHoRkiXf1KtSM8whtxAYk8zsJHUwOTm6P6VPcGjfUGILXgXKTSNZdB99HZk0pcYDatqy1HLYK+eKY2BW/ZJQxuKE/f31dz7cZgfJHQjKXzEcveGTukT3JgnNOwsRGTLGCmen4DVX8UPhfAeJXlI5TckmAGS01wM3W1T+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewYxUfMELL9/N8f5xdwBdaVRuilsEjt2q2DuKSDFJ/E=;
 b=oBx4rA0hfmC3x0ZBdjFe/i0ZD9Ez/MQtJ0/kf+9d4r4EICqVJPzzxBoQMWVl3iOGqDybuMKqDBoF4/HEz92t5MWkmbUg6EmI+3QDRaPgjnQO3sZPX7HpnK2vvFFyjnTU5SzL6+e2hB+zjcpSg6UZ52UBrV6DXTcJF+V6iA7efW/ht1z39xzZ5k3DoOX3ecHMBE0spo11vp214DfnGSr7NmjUrOA6nF/GvIGgEYA22DFgjywws0DM+HOyIX8lcZcU6Inl4tfJ8yLOsYVtRHmc899F+AngxFRKCwYrmLBKdTWIZzdYl484CCJEArakZKkzo6eQ2Ca/bNtcS5+9RnGPWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewYxUfMELL9/N8f5xdwBdaVRuilsEjt2q2DuKSDFJ/E=;
 b=QcAY2vFqMD1w/IfFSrGdOg2xD9a2vpcwVcQkfIlXh1KSjoOj3tHiijFNEk7PPwtG+Fcmwjs5uh6DzE2ySp/zpVGZB2vhBvPwb2LsXEWDqps1e3sFER+JK9jMXR6DPq7UOS0Y1EW3W93UENIN2cgwI+WO4lKBncc34BTguQgoiRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6021.namprd12.prod.outlook.com (2603:10b6:8:87::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 13 May 2025 01:59:29 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 01:59:29 +0000
Message-ID: <d32947b6-5580-46e9-a79b-11fae276ab6e@amd.com>
Date: Mon, 12 May 2025 20:59:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Turn off doorbell for vcn 4.0.5
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org, David.Wu3@amd.com
References: <20250510190216.3461208-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250510190216.3461208-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:8:2a::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6021:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5e6437-b895-403e-b848-08dd91c1cb9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFZQRGJHZzlHckQ2TTg0TWhidVZlbEFncUM2UkIvRWlPUG1kS1ROZW1sWERZ?=
 =?utf-8?B?U3BNazRLNFFUV2syVXEyUTQzV0E3dlYxVEQrVDVsUWxvci93SUt6aVdkcDdE?=
 =?utf-8?B?OE5XWHlJcHJLZ3MrM3BGTG45MTg3c1l4ZFhrYXlweTZoSWhnV2s1RFl5T3dM?=
 =?utf-8?B?djBvOUluTDArbG0wSDdMa3NMUGNaSmdvaitCMTNaZmkxUmFpMzkwUitQekdW?=
 =?utf-8?B?MlpEdm1VdVFjMG9Xb01tT2NSK0pVRFg2amxxYzRTTFBaT0hwbzBYemxzUm1j?=
 =?utf-8?B?WFFoRDNrUE50Z2NsZ3I3RWVQOXpGSVZaRU5yRjM3UXJIVFFvN01jVkxkNGZl?=
 =?utf-8?B?bFM4dVFMVWgvWHRGenJJeG4xMHh1Q3M1aVJpVERqaWpJVkx2ZzJSbjZGUEFR?=
 =?utf-8?B?R1A0ZVJYQVJqS2dWOGVVeWRnRkwwVTA4V3lVc2hrMnBXaWVUT3pTUzJRZmY5?=
 =?utf-8?B?Ym94NGdMdFNER1FnaGwycEt2VEFhNGl5aW9Vb3dmS1pCdmI0eTNIS1NhK1Zj?=
 =?utf-8?B?ZWFKUjduQ0M1UnlpRDFlUG5QOFQxT1hJWFpBZzd1aVpya1ZCS0orTmErL3kw?=
 =?utf-8?B?WlBGLzk2RUNqbTlrV24rODFEKzl0aURFNVh6THkzSEQ4UkMzMWZVVU1sU2tG?=
 =?utf-8?B?Z0hwa3N3T2t5YWJ1MythUXViVnZ0OTRGazV1emp1VnR2blIxeWJrMHlMc2tV?=
 =?utf-8?B?QWJLY1FrRFJlVUxQd05EOWNjU1ZFRzlyUjZIL0lTSjBGQ2VURkFFMkplZnpT?=
 =?utf-8?B?WklvK1VoRGNLMGdyWXg4SXdRSTlzYzlXSFBVVTlBR2xZczJxK2ZwS1VITE1l?=
 =?utf-8?B?c1l6Umo2Q05XNHhtMGZWaTFjMEpzZXZKbmF6SEdrMm4yTWFvR245d1ZoeHJK?=
 =?utf-8?B?K3d1NjRvSThVOHBsZWtkQ3FwbkNhWTk3bWNPNkJEZjU1VlJYbUVjcWJZQnFq?=
 =?utf-8?B?aG80L1lCdUM5c3M5bWpjenJiTDhOMFc2VUVNdmtOc2Mza2FQRmkvK1l0d29q?=
 =?utf-8?B?dkNhTjB4YU5IcXFWNUlpbkhTR2Fab2RjYnU3ZnFXWndEaG0zbE9FT1ROWmg4?=
 =?utf-8?B?N25KZTNrTTRWeVJOc0NwWUdDN0pEdXJqRG5hOHEyVUM4K29obGFucjYzYXAz?=
 =?utf-8?B?cW9OVzlzUTdlSncvRDg4aTMrbEU0RFoydmh6YnlqenBnMjhOT3VRT2lQTUxK?=
 =?utf-8?B?dGR0RUNUcDBKL0hMbkZmd2JrNTRFMU5jdHlFWW8zaTkxbVlDQTVqL3pjalk1?=
 =?utf-8?B?WVcyQkcvT0k0YkVBZGtrV1pKQnlqLzVJRjY1aFM0QUVxZDVYSXNYTjd0Y3pt?=
 =?utf-8?B?TUV0OHdrN0R5dGNIOUVhOTNNNWFvRXFEdGo5ZkJyMGJQbmw5WUptYVVKNUZ0?=
 =?utf-8?B?Nk05aWszTjJmZGcwMTJuODFaQkJ2V29wMmMyZ2hXTzZsYTJ3eHBGa1NjVGhi?=
 =?utf-8?B?TVlGdkNwOEhIZDRTbzZzUzJIZmVZTGJJQmdOU1lFSWYrZjVyc0p4Qnlad3dO?=
 =?utf-8?B?L2tlMmkwT0VvMERrOFJKRDdiNDh4Sy9uYW5XS0tYVTg0Wk5ia05uK0M1QXBQ?=
 =?utf-8?B?YTVRUGNIVWg1eVk0b3pxWnd0Y0NtVStSVkNCY2RGVGhZMWt6enJXTjNYR2Fm?=
 =?utf-8?B?WDc0ekRmOFBOTzVhUEMyZGhzUzhwNzNmcGVqaUtQVjlqNHJ0eVkrUzZ6MUdq?=
 =?utf-8?B?SlN6VDM2S1pTZVl1Q2RUejU3SGl2RWpHMEVvS3huY3FvQkZHWFNMSWtpazBP?=
 =?utf-8?B?YXRmNHRwSXJ1TzR0bGhJOXdnWTdCTVJGUlNsZG9jSHJnQmVMNG9EWDdMRWtQ?=
 =?utf-8?Q?rwiQwhefWtR5eDnK7q06xcw3+pOAwy/C3hPFQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUpaWnlsTk1JUHNORU8vMVhZaFdyRVMycG5XQkYwOWxGSlNKMldMRzhvTTRP?=
 =?utf-8?B?d3VtTUphTzlzbHczTnlOL0d0NVhjdHEwZWFkZXdQVDJXNEVjczBtdHdDRnZP?=
 =?utf-8?B?Smk0WTBTWDdSd3A5RDgzaTZHcjVUVTF5MW1rb1p2YVI1dUFwK1o1UmJrdHor?=
 =?utf-8?B?elJOUms3WEpRUnN0R0lyTUNHTlpkNEw4RW9EVHZMMkVxZkZ2TzlwVzZudVA4?=
 =?utf-8?B?RUhLaFZuYzV0d2VtOEJSb0hhTUZQMDFxSjN0VWhSU3FlMWFSeFJHdGNpbkp2?=
 =?utf-8?B?cDdsRmpoWm5FbHhpVDdHWnE3SUNkN3UvdnluQmNaRERZUkZ5MnVtVlRkQWIr?=
 =?utf-8?B?RmFPQUtudEVCWFpLalFlR1p1SURvb1dTVzJTa3BQYUNRRTRPRituaWQ2WW9R?=
 =?utf-8?B?UHR5QTBxZ25TdUwvcnpuRmFocUs5c0FUa1lMSGdBNnY1c3JTV2lDc0dXYjhz?=
 =?utf-8?B?bm95dzlXT0RpeVBVYXNZM085U1A4enZIQndCcHlsS1VkT2N3QWswdFF1REJP?=
 =?utf-8?B?d0dhU1pVeG41WDRVMnNINVI1OUxPZG1oOWpzRTh2LytTU1YzWkxEb290S2U4?=
 =?utf-8?B?QUtMYkNtdVdZZEdpT3FRcUxyMktEZXdNNFNWOXpjNnhINTZqUWU3cUN1b1Ry?=
 =?utf-8?B?cWJmdUlFN2Y2NEVkTmFaWUxyNDY3K1J6MnNpTmV0dXJnY2w1VUZMTW1SN2dR?=
 =?utf-8?B?SjllMnc3NFFseHdZcGk1UUZwTkRRNnZXWElXRkp5ZElRNnA5c0RkSFJWaSt1?=
 =?utf-8?B?Vm5TMXFSODlnbnBMVEpTTm1vZmRTQWJ0bDVSQVQvZFd1U09XM0pUZzZTUkpx?=
 =?utf-8?B?NVhMMFg1SGcvWVdmK1hQeE0zSXhlNk9wZGhVa3hTa012cmVpcGZPb1k4c3Vv?=
 =?utf-8?B?b1kzOGkyM2dTYmpOTlRvQVJQWXB2S1h2VE1mLzJ5YktrQm5SUEJaUG9uU3hm?=
 =?utf-8?B?dTJnaGE2RmRTYzdOMmp0SGl0R01wNS82WmpudTZBQ2NyYnAxZ3d3UzRxVWlz?=
 =?utf-8?B?MzNLY2RxalJLTXhhNVZuT0ZvOVRJR2I5RTNnek1QZlhHMHkrRXZzRTZBR0pt?=
 =?utf-8?B?VENxN2xhS3FtZXpFc1VDdUVVVzVEUyt4ZWtGNTRsWFkzWHNtSEFnb0Z2VTFv?=
 =?utf-8?B?ZkZ4TEpVaXZVcUZFRFpsV0x3UWcwR1J5cmFUNFNucDQyNHMyQmFoV3BwQ1hv?=
 =?utf-8?B?Zjczb2tQM3RLV3NqSjlFQ3NVMEwvNW9ET3RvT040Q1JCZlQzVU40ZU5XYzNI?=
 =?utf-8?B?T1FlcCtvNmU3MEtZSUhLVDRPZjB6SmhCR2JRWGVseWVGeHhIVTZHRWIxVXRD?=
 =?utf-8?B?M2pJY1RBcGxzeDhVNklyMlR4WEpUZkVHUTg3Y3dOcUFUSFpVSHVnOWdWeGx1?=
 =?utf-8?B?dzc2djFHcUFrNXdGRXBWbHl6MFhQdzZiTzhOeU5LQmQxNDJGLzVmcGVERVg4?=
 =?utf-8?B?WnhOc2pxTUZ5eEk3alZQZDlGcERQODR4aWJtVy9hY2JVaTZyLzJoNU9XTWVE?=
 =?utf-8?B?WFI4aTBTSUQ5eUMzeHA3dDk4S1pzT0lya0dqbXhnSWNaajZmYUt3cVRlcnFs?=
 =?utf-8?B?YklsN3JZMFZjTGJZVGVuQWU1MTVTRVR6VGwweVlnaFFXV0tpWXl4VDFhb2Zs?=
 =?utf-8?B?VGEwcFliUGExLzZsK1Njdmgydk50Q3RiUitBT1BmemVFMXYvOGtYQ3RqOGs3?=
 =?utf-8?B?VkxCWTNOcXZRY2JLM1FZSkJHaTM0dDBJYkdKVW5EbVlURU9vK3ljSDRkZmdN?=
 =?utf-8?B?dlJPbkpIRlFsVk5rNmNQdlFHZjZHQXk4eHQyKzE4QXlyNFJLcTlJRW9EemhU?=
 =?utf-8?B?MDAxQ2orVHc3Uit0K0paemhpaTRyczgzai9lRlEvRWxXUmc1a0x5NENPbUly?=
 =?utf-8?B?bkVDWXNqNnoxMTVKd0FBNGx6c3hBVjlvSXd1aFRCOVhGVSs0eXNjRnlDQnRE?=
 =?utf-8?B?MEVDZFdOdjRqUWdneTdZc2xMN2h4RlYza09BOWczdkQrSjVxOU54NzJjMTIx?=
 =?utf-8?B?bVVxVXBZN0Z0RlVWMlc2dTNoaXNncW5vOS9kSjZxbFlQVlZNa0xTM0RKYjFx?=
 =?utf-8?B?ZWRlRnFEN1RDYlZFZXVqTW5RUmd3Q1hQQ0J5dVExamN5ZzJCQlAzT0FtT1ps?=
 =?utf-8?Q?kPXYpZ/Fm9I/tx8tlwqh6JM43?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5e6437-b895-403e-b848-08dd91c1cb9b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 01:59:28.9488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z4UHZ1vZaCnhf0wq9dFmK5GjNSqKhqgwtPPZw13t6WXe97OLBykeiwKa5MTplDkhIVSiqLoqa0ptRTcUTTZcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6021

On 5/10/2025 2:02 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On VCN 4.0.5 using a doorbell to notify VCN hardware for WPTR changes
> while dynamic power gating is enabled introduces a timing dependency
> that can sometimes cause WPTR to not be properly updated. This manifests
> as a job timeout which will trigger a VCN reset and cause the application
> that submitted the job to crash.
> 
> Writing directly to the WPTR register instead of using the doorbell changes
> the timing enough that the issue doesn't happen. Turn off doorbell use for
> now while the issue continues to be debugged.
> 
> Cc: stable@vger.kernel.org
> Cc: David.Wu3@amd.com
> Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3909
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index ba603b2246e2e..ea9513f65d7e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -181,7 +181,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
>   			return r;
>   
>   		ring = &adev->vcn.inst[i].ring_enc[0];
> -		ring->use_doorbell = true;
> +		ring->use_doorbell = false;
>   		if (amdgpu_sriov_vf(adev))
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
>   						i * (adev->vcn.inst[i].num_enc_rings + 1) + 1;

Although this is confirmed to help the issue David found the correct 
solution.  I expect he'll submit that this week and it will supersede my 
patch.

https://gitlab.freedesktop.org/-/project/176/uploads/defeac39ec232976c7c82aab151bfe63/0001-drm-amdgpu-read-back-DB_CTRL-register-after-write-fo.patch



