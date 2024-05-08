Return-Path: <stable+bounces-43452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877448BFB89
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 13:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5131C2090F
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 11:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0547A15D;
	Wed,  8 May 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ObjK/WuK"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497308174F
	for <stable@vger.kernel.org>; Wed,  8 May 2024 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166102; cv=fail; b=kXEuIfsxZbiPDaLyfy6lyDoxLl5ufF2iQX2b/0UIqo795Hn2y9Q1c6T2IFA6DJLyskIes0Dd1+BYEp8FBKkwKUHdTh1Anht5/bEUTI9xBXcjYAgk1x5QdwEg1fwmEkAgcLzfwOXtUCeCGQXO3fhqN8MQGjh+QPuIMUukOF7vy2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166102; c=relaxed/simple;
	bh=/Gb5Vi/0h3l5VDvsvqCzIlX4RHazYEXMcNQuM+nkKok=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A5CwM8seyJluGzhGEOwqyKzmgb7HDXTxFZPXYgvUC30so0NYkp/1aTd02pRneWV2yeyOc7/QOA+gDpxu6FE21JneyMDYkzsOC2ukIEk6hEuKRXppKE8ZnlCQKGWtNRwotR7y+Cu/cRPyfLT3gF7r/OjhLAdTLPSBMcEuZXna2FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ObjK/WuK; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jW5L4VVNDcz9Gv8ANvU4eh0ajET6son3ht8qSzevJ0mocu0N0xAANR0z3FSwz7b0tClM6d7Xb1yoSff14DYDvedZZXZnvP+a56I2YuKAwcLxcH/FBkzgQ17WLjGe/eRXQUBQxEvAxT8EpMHqPEPwhApCjSxLOECPumW+fjozRnBLoETx6mhJUj7TGfi6aFEIRyioM2Q+P/qGyqwqup5NvgJqW2tJBlCK12kMckqsWO2F5jrHYLND6lJz0b29eyBOEiYQdll6kHyv+AR9Xp6Bk4EMi+5/FYZ1RNJWC0NE4Zsm2vq2pH5Ba2bX20T8Nl9qZ8EUzO1nn8W0vnZEUTaJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1irHSsTbOdRurdHkFeenOq4rC0x3EMHXzEeCjW7tBo=;
 b=iRX3AswICmw0dDTpBYEnplo6wwZcHYXKX+1fDg2HEDZyrpkpeuXYCReKpqDjnCeH3Q8blXUV/TN6TatIvvXgo89GV75GJbeXXpt1o980OT/24uMcdVRxNUQxlZ5x9jPPcJ7zN/29Owf3O47lc0ovgmzAPmL5EyE46Dgn0/vw0TAAR0d35NiFVoyJh2doUg9Xz/4rb1jkiy4UlQ+6QA0NjocItlYl2NE781dgCsb+qLUHIVIoXEu6PX1cKpru4EnQ/FkWEjB35mgymtlH13s78Qk+kwr1+D9A0xrtmWmgok77U2SbiAhV5wzSWpIxcwC/ZRirBMpH+ugmFaYkZCZ2aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1irHSsTbOdRurdHkFeenOq4rC0x3EMHXzEeCjW7tBo=;
 b=ObjK/WuKacgLo8Yqz3UR9g4ld0RQ50PDKiOgCDJY7QbXz+4p7t2p3r4xRKPIusRxmeU7oHDQXB6D+PArOdiyl49vub2xxyR1tCbAlirVvMooycBnvzPXIO0p1pnuGEyH6XqTo9pV0leph5qNbyXG+6JwriNfKALH1aix5oktKiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 11:01:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 11:01:34 +0000
Message-ID: <8e7ed389-c894-418f-a8ec-1ccfb13e2126@amd.com>
Date: Wed, 8 May 2024 13:01:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected]: Games crash with 6.9rc-5+/6.8.9+/6.6.30+
To: Christian Heusel <christian@heusel.eu>, regressions@lists.linux.dev
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, heftig@archlinux.org
References: <gifkxwcrswqevdig33inrsieahso2lcxbhcawu6d2qprnujoij@eqg53vwjamts>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <gifkxwcrswqevdig33inrsieahso2lcxbhcawu6d2qprnujoij@eqg53vwjamts>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0226.eurprd08.prod.outlook.com
 (2603:10a6:802:15::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: ba33c3e6-f231-4956-1747-08dc6f4e3914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2tIbXB6WDJhUmp1SXM4WVlYWU1VQXREam9aMEx3T3pmYzRQWm82Umw3dUxJ?=
 =?utf-8?B?cHREVXlyZkJGc05OVE02NTBjUmliQU53TkpCUTNhRVdYK0hJbGpYbXRZMTNr?=
 =?utf-8?B?aTQ1cGpaOEFrQVpkNEV0TURVNnNRSFlKbHg0NWxsbDVmS3NsdGM5SEp3UE9w?=
 =?utf-8?B?WGhwOWhsY0VpRkVVZWdMcGdBdllqOHpEbTFTbmwxbVZTbXR4Q1dKQUd2Tks4?=
 =?utf-8?B?SCs1djdUSmZPcWNvend4d2R6Q0U4VUg0N25DK2E1ZXVBQkEwWTIzM2hBM0hZ?=
 =?utf-8?B?aStHVlFrcitIQVJEcGZmclNNMmJ3T0hPN3dVb0MvZmt2QzF2UWVVdUVnWmFG?=
 =?utf-8?B?bzZLNDBZOEJtWS81ZndDamZYNTV5Wk8wY1Q3U3pJQ25SUzRiRkRYeGlzejgz?=
 =?utf-8?B?SmpaRnF3QWJEOWp2d0dHWHgydGFjSkp4WHBkOW10R1ViRnRYTExGeGJYRUFo?=
 =?utf-8?B?OEJ0VWdyanVpYlMzcHlnU05FU0tDQUQ3YmFjNkRZbzBhSllFTFdPN1hSS0lD?=
 =?utf-8?B?RHI5YjVaNjdhQjUzMjFvRTVjd1FRQjFDRVZ3V1lGL0lINGNvTDI4dFpKWU5u?=
 =?utf-8?B?YzAvdE5naEh3S2U0M2dpUDdZMktjbWlIdlB6VlpVSk9pTTFhYUpRNUxQakp0?=
 =?utf-8?B?TjdFbEwyWXJrbU5xMWcxQ1J3a2FoNDlFY2pLWSs1S2o0Y0ZnckdFYlZNM3FR?=
 =?utf-8?B?UFJYQ0hUTUxxcnhsN0lsQnh5UHkvY0V6bXVaTDRRL0thdThuVFYvbm1OdFhy?=
 =?utf-8?B?YXVySU9yQkFLeXBYNVhyWnZlK1VCb05vU0pjNUZnd0UxVm02Vi8xN2ZuSU0r?=
 =?utf-8?B?Q3VhSG9TOGtzUmM1L1dCaDR1aWxsaUY0L045VjhHYzEzUmZoRFNWeHlucWlr?=
 =?utf-8?B?c2w4ZWhrSEVtRkEzcFp3RUhmNXZnL0pZRGRNR2xvWnpIK01ZRHJHemlMU01x?=
 =?utf-8?B?KytHbmU3ampyVkZMZ2NiYTRacU8zQjZ1U3hrWGQrUm5ha0grVi9JdHRiREdE?=
 =?utf-8?B?UGp0bTNBakhUSmQzOVk4ZmhsbEdFR1poS2MydnNUQ0VlWm9ob1R0NWhUWmdL?=
 =?utf-8?B?eTBFbHhKVGZFK3oxKzFLcGlDODY3L0tvT3p2cWFZaDdhNERhRlMvWWtqTHRr?=
 =?utf-8?B?aFdvK1gvZmVQSU5RQnE5bHF0Y0FkcVZjOEJVcHNSam5EWmM5Z255SFVxNmVK?=
 =?utf-8?B?OEhSMUREUDNsTjVja21ySll3a2ovenRJd2tqeTFsTXFQU2trWFJBRkt2b3JB?=
 =?utf-8?B?dHMrYWgrTDR3bDd1V1pOK284MnY1UXZzQU1RTENrVVJKQXFTNjhIRjNPekF4?=
 =?utf-8?B?dmtHYmJQazQ1Q0RjY2VzOWd3SjI4RjlwZ1JGQVdGZHZlUWw4Nm5ZcGpGeDU3?=
 =?utf-8?B?OS9KdzUzR1lEY1RGS0NVNHNIaUFZM2JrNTlKY3BOUjlhREowRUpMaUVRcmJO?=
 =?utf-8?B?TTZoTDVGaXdvSFdmV25uanArTHBlbTNjNzlWVWVsWjdRdWV4cXFkaElWZWFj?=
 =?utf-8?B?RnY4elU0aThZODZuUENxUU10RUwyL3ZXWlI2WTV4UUtwMDdvTHRqQnY5SDJo?=
 =?utf-8?B?MExCeHVyUm9Qa0lZMGpVYmcreTlLU1dCVmFEMUFSZlYzZ285UDhKczNFTWRW?=
 =?utf-8?Q?rN04gm3HIwX5A5TKm0gUFsaVucueHWpjS/86lFFo+f1g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekw5WnVZWGsvN3dCMERUTG52UVpybmJCRnpiaEJ3Zk9GU2ZXVEdiU1JlTWVI?=
 =?utf-8?B?S1IwQlREOUs5YXM2ZzdEZUtlaTR0eXlxVDdxTmE2TUgva3d4encrTUF1WENj?=
 =?utf-8?B?Tk84cTB0blAyNFhId1VQdFlWRVl5b09FZzFpWXVQRmFjWFVKY0dmQkY4NTZl?=
 =?utf-8?B?OFUzWUtwOWdpK1NoMTdqQW9Yb2lYNHhtYUlvN20zMmJIZzArZDkvRmNsZmJM?=
 =?utf-8?B?N2Q1TVpLQzVZMkx0TjhaTTB6Mnl5Y3BsUjh1SnA5aXNZYld5d2RUWnJJT29E?=
 =?utf-8?B?RmZBQlBHUklEdTlpS3dNdXZkdTN6bWxtS0lhelhVMXhMZURoVCtFL1Bla1NL?=
 =?utf-8?B?Zi9kK29JVlN3MzZtQlU5YlRBQlBYMEREcENLdTgvUDgwc3B3VFlSdjZRSGJw?=
 =?utf-8?B?TnJMUWhNQ00vUjh3Z0d0T3VteUJYQVA4SVlMZitPaEpPMTd1Tm4zTFluSmdM?=
 =?utf-8?B?Q3ZhMk9VNldnbXdkQ3lVNS9kUnVuUDVvYk5BM3RKT2Q0SVdBaGdHZGxlV2R6?=
 =?utf-8?B?Z2VBOVM4L3YzTDRGajN5VUZ5N05FcDlXNXFnUXZQcjE1RVhUZXdQcDdmUDlL?=
 =?utf-8?B?OUx0d0ZoK2xvUFgvTS9SQ3BkSTFSMnZkVUdXVDRKRHFIMnVXSVR6T09YUEpr?=
 =?utf-8?B?eU5LVU92WGxyS0dCQzZXL09BRUZFU1pkdGRmbGx5Z1hXRHBQYjBzZTRCYWcv?=
 =?utf-8?B?Y0RrbnoxT1lZN1d6QWlXRU1SWUw1U0xnVU9NS1VxeHJBTjBZNFZnaGluNFE1?=
 =?utf-8?B?U3JlQWxaWTBKeGZCVjFKRlpkbTVKK0R0OVpCdHI1NERsdVFpYnI0YXJDYUdq?=
 =?utf-8?B?MTZ3ZnVFcjBPa0lNYzk2SURHekFCS0JkRU5xNXBSd2FDUGpZcHFKdjl1emV4?=
 =?utf-8?B?cTU3NWZ5THN6d1psMEtiMFgwRTlNVDV3Y2Yza2NVdU02V01tV0M1bjREUy8x?=
 =?utf-8?B?N0VRbUJaOXc2VlNGRzVmLzBqU1E4Tlk2VWwwNFdWcmV0RHNUMmY5aTM2WDhs?=
 =?utf-8?B?NkxaUDcwMld5TG1HcTExRFJYZEhBa1lENUhhdmtEcGdCVzFKWENEVDBFYUtj?=
 =?utf-8?B?T1BIMk1tMVFNTldqejY5eDZCZ0hLd2kwV05lOGlYaWRRR1EyanZ6VzIwdEox?=
 =?utf-8?B?MHg4cGxRZXlhd2E3Nkx6MkUzNlcxM012UWNZeDlPaWkzT0drWCtBUXhlaEZx?=
 =?utf-8?B?WmJkUUdSbWJqZGFBRXZDNWJDdi85MTdaaERYZTYzR2hNT2RKUzRaVy9pNTVZ?=
 =?utf-8?B?RUlZY3hBYkd5VzJhZ2tMZ1cwUXJMZEdWMWtYdUxkTGlBVXVMam5CR21CU2pn?=
 =?utf-8?B?ajdoQThMWkFGM1hSY0hBUW9vK2lOQTNSRytOL041c2ZKdm9uRkdFYmVxZFRT?=
 =?utf-8?B?YXlnZ0FtZ2tHWnJzOS9ZaUtJMGVGNzh3YkdsQTB4eUFXVU1TdHY3WThDRllz?=
 =?utf-8?B?RUxkNi9mZ1pQblRQU3g5T2dOU3JsZjJ2RVNaSE1TRkZzdFlzeTlOaGV1MXd6?=
 =?utf-8?B?eGg2N2Zua082anE3aEc1YzBZS2czK3hUTVpIdWZZSTd5OWQxU1RmYS9PYmtD?=
 =?utf-8?B?alJJY1J3OGZvc3hLU0ViSUNTOG02dlNSSExXZWVpTjNGOC9sZzdieEFLekhC?=
 =?utf-8?B?Z3ZHZVJ3YXo5bTBZTit3Qk5raWxLN1RhbllWRTZBQlVnZHNFeG9NOHZ5V0xo?=
 =?utf-8?B?SEdocHZCeWFxWWkvNTh5UDlJd3lzdHUxUEROYzNzczZ1OFFGM0U3UDBIZzhK?=
 =?utf-8?B?SklDZzJFUjYzVFhuR0d5QVpPTWRCbGN5QjV3UHo3SXpKdFc0R09IU3BwZ3BT?=
 =?utf-8?B?aVNaQjBuTkY2UXlXS0tGVFd3WkQ5ZktwdnZjN2VvNmM1QU5wSnR1YUxITG5N?=
 =?utf-8?B?cGJmdmZYS0c5V1RMVnRzMS9VRUx4SU5IVUJUUjNvSzlzMkZhekVXVlMxSE8z?=
 =?utf-8?B?MUlMb0pQWG1ncmp0ZzgweVUrSUV2ZHprTXFyc3VCYzA0cUtoT2o5OWhKV1dB?=
 =?utf-8?B?R1hBbDBIVzJMZEU2Y0JYVk51RFJvaVNSdE84blRmaFoydjNpdVl2dml2V0FI?=
 =?utf-8?B?WnFueDlsLzJiSGxYZVFUcUY4UkVUK241VnBrSGw1V0MzOE5GYkhUR05FNWIx?=
 =?utf-8?Q?6vQNSe+9uBo4V1+tv+144dBQM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba33c3e6-f231-4956-1747-08dc6f4e3914
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 11:01:33.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFQOGJABTvjq6U9zYla4J7T4z/Hx7pUz6baU8G3PCVO3DXPCSIhnCvxLCcX01i77
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402

Hi Christian,

most likely Michel just pointed out the right solution.

There is an off by one in the bug fix, which might cause the issue.

We are still testing, but so far it looks good.

Regards,
Christian.

Am 08.05.24 um 12:36 schrieb Christian Heusel:
> Hello,
>
> I am reporting this to the regressions mailing list since it has popped
> up in the [Arch Linux Bugtracker][0]. It was also [already reported][1]
> to the relevant DRM subsystem, but is not tracked here yet.
>
> The issue has been bisected to the following commit by someone on
> Gitlab:
>
>      a6ff969fe9cb ("drm/amdgpu: fix visible VRAM handling during faults")
>
> The DRM maintainers have said that this could be something that just
> worked by chance in the past:
>
> [Comment 1][2]
>
>> Christian König (@ckoenig)
>> Mhm, no idea of hand. But it could be that this is actually an
>> intended result.
>>
>> Previously we didn't correctly checked if the requirements of an
>> application regarding CPU accessible VRAM were meet. Now we return an
>> error if things potentially won't work instead of crashing later on.
>>
>> Can you provide the output of 'sudo cat
>> /sys/kernel/debug/dri/0/amdgpu_vram_mm' just before running the game?
> [Comment 2][3]
>> Damian Marcin Szymański (@AngryPenguinPL):
>> @superm1 @ckoenig If you can't fix it before stable 6.9 can we get it
>> reverted for now?
>>
>> Christian König (@ckoenig):
>> @AngryPenguinPL no, this is an important bug fix which even needs to
>> be backported to older kernels.
> All in all this seems to be a rather tricky situation (especially
> judging if this is actually a regression or not), so maybe getting some
> input from the stable or regression team on how to handle this well
> would be good!
>
> (I'll add that I can give no direct input on the issue itself, see this
> as a forward / cc type of Email.)
>
> Cheers,
> Chris
>
> [0]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issues/47
> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
> [2]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343#note_2389471
> [3]: https://gitlab.freedesktop.org/drm/amd/-/issues/3343#note_2400933
>
> #regzbot introduced: a6ff969fe9cb
> #regzbot link: https://gitlab.freedesktop.org/drm/amd/-/issues/3343
> #regzbot title: drm/amdgpu: Games crash if above 4g decoding/resize bar is disabled or not supported


