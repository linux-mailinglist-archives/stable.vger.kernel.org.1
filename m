Return-Path: <stable+bounces-188828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA42EBF8B6A
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 22:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F88E3ADEE6
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 20:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E726C3B6;
	Tue, 21 Oct 2025 20:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vaDL/1Xt"
X-Original-To: stable@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53443F9FB
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761078329; cv=fail; b=g4NdQ6HXWKNK6Gp+SUKJ41FXCyrsv9kpV6YNGz1jeWI9rluM8nloMjX5Gd/Hjr5iSEz8jEUvg0nAEPby5bI4vavONr7PvXYHw2q/rwFx9zzhXwAVV1uJ9jkm9VjgAJHOHcJmMrtdlOmFQnF7pmjP+NmDcojxVslHzc3mKskiOkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761078329; c=relaxed/simple;
	bh=PpBk1Y92wX9u2MbBvGIqRh4FafM4tCOjgjdtvmHh+yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JBruGChpmEb049XmtVpuQPKVpoUc5fM4TTrd15D6L92FAGp4w8PzDYj++VgJ805BA3ZvBXq0Ah7XkceqcDYMJlokBtxDbpIIpsva9T3hi8KdRoJSK3zejVgVzYKvt6lW8vS+xcaCIN9CHGKx5LnDT5gBCnQS8/W9OdeRUcSw6m4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vaDL/1Xt; arc=fail smtp.client-ip=52.101.46.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoCM2sZauMGGbZlZHmL2rPGDptPMIM5dB0G0glxbrTi3oMdazY3ENrE2jeL0mwEFNaADmGpeAFczWG9vrykss9fV8gEOGBkUUYm4V/jheWpOzPG4Y1/A1Vn0FWJr2bLKczwmSZXD6jCntnBLNfRrxEDMqhVix50qt+LeBVPVXmBz09QtRsORUARYG1vwxU9ZcZVjJKgzD7a0hTzOeXccmripe1fSVw9V7VPrH+LPeMsbqya2OUmLL4nf02Xc9iTAAyA9Ooqcm7KbIxyaXyoLLomAB/x+vg1Nl9WXuPGR6BVsJ6Kmi/7gqyIeF66GIvjSqNit11J1t25CzurXzKUQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgIyvIcVaQ68uH8uNXoAoAYtVbbN8fQb6Him37tKs/A=;
 b=ZNHwO7j+1r+4k3WwFJ9YvJXvm1Hwvsg9N4IDFjE833cdC7wixku9JHd4FfEo8FR4ZnE6v9ksKJxsZjs3TqWQbrf+L0Oom8hKQl9i3My5m+dFKSdkei2nebnBvVR62frNRI7dVNr9nHh/pdtVTV19cnHzkdiu1v8VvieoVuFhoHGc3NXMpgI2U893BsHHqLKWg7B0vcrobbjXtNtTLpBN53r2mvyHXfpOlaiH6eLxjRhK7gG0h1SsUUzRgMAycrH6wwS+YYLarvUAULW0IssGjNpXKOxWXmj7Bm29gcu0ZqP0Qzkes427kOa5wkoQd5+9Z9J+5s8VqgtehBFOFOeXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgIyvIcVaQ68uH8uNXoAoAYtVbbN8fQb6Him37tKs/A=;
 b=vaDL/1XtV3muTXc0MR5Bg6Lo1+v+tK0a8QsWpSLxjrKWthbhDUBFMZgCSAZc987/1RrK3fpAWehRkE1rXyzRvc+l/F3IjQ8SJ2cOcENcDau/2H+PntlYVBwJ3ByspBnmaPTztKOJVu1CI/kuXYFccs6asxKNcDHjxOcKZRyT7Io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 20:25:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.016; Tue, 21 Oct 2025
 20:25:23 +0000
Message-ID: <6787f557-cfa7-40ae-a8fb-d40bf40f4707@amd.com>
Date: Tue, 21 Oct 2025 15:25:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20251020223434.5977-1-mario.limonciello@amd.com>
 <aPa60qtBV5iCiY2I@sultan-box> <aPa7lwfpALpbCmed@sultan-box>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aPa7lwfpALpbCmed@sultan-box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:806:21::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ea517d-608f-4e60-8e32-08de10dff649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXBTQmt0UFVaY3hieU11di9pNjhkY3dTOHp2SnZVZHhScHlQd2NJRjNXOW5q?=
 =?utf-8?B?L3NpTXJRYjc1MTN3OXh2VHBNdldOaUMwWnErcTRCcHdzcTJDamdiUHdGTGdP?=
 =?utf-8?B?NVpBZVRFNndteVBkZjB4L0dhYVdnazJBaDRrQm1wSkhqZFdxaERkRDc4bWhi?=
 =?utf-8?B?VklaVUZzMHE3ZkdwUXVVdzJJMmRlaUJKYjdjOUh5SjcvM2dFQ1JoTE9KM0JL?=
 =?utf-8?B?VGhNazZwbjZwWDBFWXVXb2s0R1ZHejdYeno0endDdHZuWWh0SlVBVUU1NTYy?=
 =?utf-8?B?S284UldSM0ttamVhcXVvZXBGbEpQZVViOWQzM2FEYURpQmxON01HR2FoVkxM?=
 =?utf-8?B?dVRDbkVOa0xlLzM5a2orRWRJYnExNWtvQjJ1UmJydEdjU2x6eWkzckk2aHpm?=
 =?utf-8?B?WHdCRUxPMnBwQ3BpMUxjR01FOTRoVVdyMVdGNlFydmI4anptUEQ3cE9YWVlH?=
 =?utf-8?B?OTBOLzhsczRzSVpQNU5OZ0IySCtURUk3WDdwQ1cxaStXd1ArbnJ4QUtlZDJ3?=
 =?utf-8?B?VlZBbnkwYjZ4d1RITG5yaHR5VUpPQ2tERG5UWWtIc2xkbFNzLzQ3Yk8rOWxl?=
 =?utf-8?B?M0daM3VTcmN4L2U2K0VnQlo0bVFSMFNhV05peWFUbzlYbWNYY0ZGcjlCREpO?=
 =?utf-8?B?ZElzc1k5VFZDN2gyQ1RzQ0lNSEJGVG1LOHhtbHNmNHg0UmZTMmRmc2R2NnZX?=
 =?utf-8?B?KzZaOEFNeUVZRm9BbHhqaGJHT3NQVndvTjBSZWswcmRROTNqOG95RTA3Y1Fx?=
 =?utf-8?B?bjFMQ2VFU2l4RWxNcTBVM1A0eW1hYW50cDRDbVZJSVI3UHg5M2xQTjI4YWpC?=
 =?utf-8?B?T01xYVBxOVZKbVExVjU5Yld0dVFsNzAveWRBMUZsOXJaUEdOdDExaFkvckN0?=
 =?utf-8?B?NTllYURnZWF2T2FKUVE0eDJwZ0JJL2RhV2wwaEtqdGFZMjRCeXU3MEJvSk9t?=
 =?utf-8?B?dXY5Sk9aTkpNWWZVMEhBenRPN0c1Q1Q3d3U1NlRnUkJENUF5VXZJalJEZkJL?=
 =?utf-8?B?bC96anRoK3M1RDRzM01wWXhjT1Y2STQ4ejEwV1ZURzBjeHJHTkpYRWF1emlt?=
 =?utf-8?B?TUl5QkFBUE5sd2U3NW11QXd0OXYyTTBGakRSUERqQm9uUEJZbmNlWEpRYjZU?=
 =?utf-8?B?dGI4N0VXQmp2bVFKdEtFbkdBaldFdHhmY0FqQjJpNVUxcGNzZDU4ZEFzelNN?=
 =?utf-8?B?VHo2SDI0VmpSVWhSU200Q2Q5cXRQZ3RJM1VZek9hTWc5M05lcHplcGZxcU1m?=
 =?utf-8?B?U0VNaENMT2YwcHBwSkp0NU1YeHZOWVEwenp6cFdNTzBQS05GL0FtaXZoWVBp?=
 =?utf-8?B?aHFvV1ZKUnd1bVpJYmdxdW4vMDJUclBJMERNRUNGYnNUVGtqUUJwNmJPRzJZ?=
 =?utf-8?B?ZFAzK2JMUFduSVl1azdyR21rZFZJTEVxeWlWU1RGYk1WeGROYVVXZ1hZQUpW?=
 =?utf-8?B?VEROTTRjclJwdlVNdEUvTFpMWnNSdkVwZUg3RFZoNEcxeHBnTjgvKzJxSWcz?=
 =?utf-8?B?UXg3VFdsUUlqVG5Jbkhpb0NXK3U1QVlIbmIyWlJVWjVKUE44alU3TExYRzE2?=
 =?utf-8?B?aTg3cUxkb1hOWWpzc0thRUNWbTNvbzl1akZCV0NWRSszcEVsQXFBUWhkL3Qy?=
 =?utf-8?B?UXIrZEhyQ1I1T2piRXpQY2R4cFRoOHFKMVZyM3hzTklqRHl6QS9wWVVKSlRq?=
 =?utf-8?B?UVJnbjZ3dVpKa3RTZkR3MWJoV3l0YlVZd2FCK2t3WjA3VEV6WFFlSGxUL1Yv?=
 =?utf-8?B?a3UzSTB4a213YjNYSTF2ZUZPWlJQOTVqWklnR2dYVHZ3ZGIzVWxJNEVCTDkr?=
 =?utf-8?B?b01VZFMxdFJXZUJ2cS9PYWhlZGRvekZ6SWZtYi9YNS9xMUVlUTZDdWluN2lZ?=
 =?utf-8?B?VWRtYVRucngzcHgvRGQ2OXpGOTBXN2JFZXZ1VXBIalpma2xHbXl3QzlzR2pv?=
 =?utf-8?Q?6lzzGMNmonFw+Hak9OUaTTXvIpQ6G8GR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGVFSmhabk5oN1U5YlNsUks2dzVJMHBseGtrOXhERUdaQ3lQRk1YalpUdGZU?=
 =?utf-8?B?WXpHODUzcTBBRkdnWXhiT28vNE5CMTl1QzJtTUE3RkpaSURKM0FhcVR1ZUNU?=
 =?utf-8?B?UXoxM0ticzgwMDd4Z0xTNWRqTTdoQkRXN2NVOFdnbllsZXlJRUYrUW1ZNDNY?=
 =?utf-8?B?TG9vNDM0bmJmMFlzTDRSbENWcEhNOVk5bG80TnhuZDh0REJ0bDc2UEg3LzRm?=
 =?utf-8?B?VkZFTWIxOE1FYWdGVVBtZENxMG9DaElnUnZ3M3N5NXV3V3grYlMrOEhWaEZ4?=
 =?utf-8?B?ckhwRzRpcU5QR1Z0cFFOdkc0SXhWTHpjbXRRVlJCOEoxTlhOTTUweS9YL2dz?=
 =?utf-8?B?aVJXeVFqZHlPS3dNSk9aUStYM1haQ2pSUXBHMThQbWpRcGpiWWlWWUlLdFhK?=
 =?utf-8?B?NjBtUkxuZWJnQ1h3VFFqSlFuWThCWHlicFhhSytaY1BwMHFwYmVvMnczVTRr?=
 =?utf-8?B?NXhmVC9URzVIR1U1OUFQRFRDUngrbU14cWtXa2ljdDRIRUh6NGU3d1NqMHNk?=
 =?utf-8?B?bnNiNUpDSkRUL1hNSjFPNE0wV3VXNFNzQlpobUtqTjBEc3R1WTRjcmpkR1FM?=
 =?utf-8?B?R1krR2trNmo4M2ptV0QzU1BuZEI4S2lxcTYxQWdRUVNSbXZ2TlBaU0UwMG1z?=
 =?utf-8?B?NHZkWngrZWZ3K29KTnZWbTl4bnlOdy9zWkt5MFRMekpXVTBoUmszRm1na014?=
 =?utf-8?B?UmNzNCtGL3NnY0MwbnB3OU1HRzBaR3ZWMUlMTXRBTmltS0xYVXhWaVZmK20w?=
 =?utf-8?B?TGY1MTNjTHVOTTE2cis5R3pjWTdJeWlqL0NoeXFIUnN1UGVtS0JaS1JJSFlX?=
 =?utf-8?B?UzdJaVYxMEl5VVkxakIwYmpaeFVsckF3NFNNVnVGMjJHdFRBSFh5NTJCdUUr?=
 =?utf-8?B?V0o0VjVmUjdUTHc5YUh1bG12N1F1NU5lcGgzWFlKeG9KUEExRjA4N0l6UXNJ?=
 =?utf-8?B?a0JtcnFObHJTMDBNK3NQMHBVSlpwQlVEeW5wS3ZEcXp3UEdXVUMvRWVvajB1?=
 =?utf-8?B?V2t4bm1WNnVneEhLSy9iQml2WUlKeDdjVEc3RGZiMmlTRTFBTHowRE1sMWxV?=
 =?utf-8?B?S2tUYnk4UTdZVjloL0QvcDFzSEFETlNYeDRwTCtBeVpnenpUN0NtWDhvZXhQ?=
 =?utf-8?B?YnJzK1RncUNjTnVVNURtYlg0MlBQSTBsVThNUFZhSHhoYWliTHdLbTNkK1I0?=
 =?utf-8?B?UXp3aVVWcE96WmxjSXVEQkt3Mk1ra0VXTFlMaFVDVlQ3aEtpTXZCRDNHTmtP?=
 =?utf-8?B?MkRoRUhpdFQ1UjA4ZTVaUGdJMlJ4dlpQd1dJTmg2YUl2eEUrQlBYRWlBVWti?=
 =?utf-8?B?N1VETnkyck5hNlR2b2IrRlVsSlB5V3lWM2JDZnB1T1lzVkR4MkJBRnlGTkU3?=
 =?utf-8?B?WXZHOFhVRmNQRkN1eVdJbUd0MWpqOEt5UENtbTFwL1NmS2FFd2IvQml1V1Nj?=
 =?utf-8?B?NmFkVHhLMmc0MW0wN2JsbzhZV3ZJaUtpTmtoUDZsSTJwOFNMZG1FY2crcnhx?=
 =?utf-8?B?Sk80RmMrZzY5RW4wcUc2NFpPWG1XTGZkb24xVUJwTzhWOTcyMng5WGR3TUJD?=
 =?utf-8?B?Q0pWcENQbk1uUU9seTNBZnRveFl0b1lRZnNJR01leTZwM0F6K2RvenlPSkpB?=
 =?utf-8?B?NUlFYjdoRFhYUHVWYVZFd2NiVm5XM1d3eDZiL2hhVWhlQ056QzhyL09wZVNX?=
 =?utf-8?B?Ly81WGozQTE5cGkrVmxSOFRxTkNEakwyWjRNOTJLc3N1Q1lESk90eUExa3E1?=
 =?utf-8?B?ZU5jV2FTcU5nSDk0WVVtZ2c1QjBrdktUNUxUcWZRUDJXNDRKaGZER09memtq?=
 =?utf-8?B?ZWp5LytnMTZiWG5WMzIvaDlQSENNNUtBdlRNRVZqYmVQMlZrZlNnZHVaYlV3?=
 =?utf-8?B?dlVlUWF0UWM5ODVBdUhmR094bitoVzNsTU1NQkl4NXNYSk9BUStqMjljYmln?=
 =?utf-8?B?c1VCZm9IcnpYSHcrcmxocjZtRTVsdU9tb2FDSGFsRVNYZjFuN3ovZm92QkpH?=
 =?utf-8?B?MzErMnlwWXU4U3E3WlJUb1AvQzcrejVJUDJBSjRnVnlDa09xNldKM3E0QVFO?=
 =?utf-8?B?eHpiOXd2L1NKeW9UM1ZrNHVrL2dsQ1p0d1JhUHlwQzFEN1dmNHJTTktmTGFo?=
 =?utf-8?Q?b1IZdmVRoQgy6qV782VVq9zh3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ea517d-608f-4e60-8e32-08de10dff649
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 20:25:23.2321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REdub5iOVEOm2bskZ4kUGlPUdpDJoi/Z8y1Mvr5u+M5W0v1ykTFpZXjOR6UT2/zR4dtisllbtI8D+HMC5qWKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932



On 10/20/2025 5:45 PM, Sultan Alsawaf wrote:
> On Mon, Oct 20, 2025 at 03:42:26PM -0700, Sultan Alsawaf wrote:
>> On Mon, Oct 20, 2025 at 05:34:34PM -0500, Mario Limonciello wrote:
>>> Adjusting the idle handler for DPM0 handling forgot a return statement
>>> which causes the system to not be able to enter s0i3.
>>>
>>> Add the missing return statement.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
>>> Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/
>>
>> I just noticed that this link doesn't work; it seems like that email of mine
>> didn't make it onto the amd-gfx list?
> 
> Ouch, looks like none of my emails today are showing up on amd-gfx. :-\
> 
> Sultan

Some seem to have shown up but this one is missing.  No idea why. 
Anyway, it is what it is, at least it's fixed.

