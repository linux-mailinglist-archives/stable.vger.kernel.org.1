Return-Path: <stable+bounces-124655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 804DBA65828
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865CE1694CF
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F2E19D09C;
	Mon, 17 Mar 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="395hXZln"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D9719C575;
	Mon, 17 Mar 2025 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229213; cv=fail; b=kYszByeYq8aCk0w++xhUvfdCWv/aUii1mIP6KJIZIoroXmstz2kUlsYX5qoTgncepXnFtNRCzya6oFCq0/SX9QLz0ej8bJ3MOuif29H8CvX1tXVWh3+MvQn8Q1aOAkBL7j7HbxPkC11ohBxhjRHBxIiz4VcEccYqBXCnuG8wRCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229213; c=relaxed/simple;
	bh=Y9Db6PBhsVApTrrt/KuIkTQXc8h803PRVtADyoK27s0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cLDYEbVSqzsygZX4TL7rUaz45vxgGKCbsxJpwlFnhGHpTxS8kyq1OM0fN3dS9Sz0x5ICMzh1kFdL4W8iRCYF8IG07CSoIXIG3gNrnRf1434F4vX2Dhb1hBBAAPLbV47cisCwzKsVisz7QGcp2heU4r2m067FC7/2DgLDPGEAVnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=395hXZln; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fifkM0aNQzBxkHFRuYZiCAwHxAjlwpK2kyMXIhE8pHd+RkY/etvghPYMqBZfeqogfvShE+zpy+4IdlqCgarftPqgyzAvsLxflI9bxjhMQ4u2Cr/bT4P1702DHp6zOHvB2BJrXf4RNiglK+JTgJVK3+YMTgVTd/GQQlE8JV7Me/F8rwY4i7cC1YyvnFBAq0h7wvQMqpyFXJmeBx0WpcB7qWc6LtgrDI4szDd/wLV8rds5892Oj+2NsAC8ccQ9eJm+B9SJJQJX+qqtw+14a0DBsxLTirIO2ose3/IsehXHYghcyEXXH3ON1/MLXG0nAfJGGKIXGsL8tMCLcmB7m7b3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfZHV/XhlrhWmcNIQBwCBcRLC5pXwi/fuUBSTck53TM=;
 b=RNA5+LymtFjZvoYzq4OrWUVCntSpy35KRPX2pGhkGmSI3PsjtIE1rPB53hrvWtdngn/qmw8Vhcs/3PYytYhC70a2yEGI0iGvjiusoCq3fhzTGCGPRFdYbComgVXGazUcW9TZYRjB3R/3WlatfFiENTQEuK08KvifSTCDHUk7NnZHU8kVk3oWF9E1hGCEgjRKCLV1VKH3v/bJ2dkktuEzgbeYgt01rAHNeh3E6kTdc1h1M+buZ23+698BPcgX/fCbhOcnK4OVki4sZKgAo0+wRhLQhofOZ/T/nz/XxpCKbXBQP4WZIhIoGoIC5EWXZnlQvWbus1y5b1PKLN91OZeGaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfZHV/XhlrhWmcNIQBwCBcRLC5pXwi/fuUBSTck53TM=;
 b=395hXZlnzW/YnFSXh89bXJu/eTnuuhSrmnWAfbao0P7Y9G6Ef/+Widqp85Ce0iCVK3UBqnSTebVwMR3j5OXcEYIBgEhVy0D2j+rs7MeJkrCTeWNmQM4mbtfo4gw8+anytSh2NhtSsMi0qLuy3NUPyMcU+bKF77cJrrNKSKrAZh8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 16:33:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 16:33:26 +0000
Message-ID: <71eabd51-168f-4d9e-825d-60eb84b1a600@amd.com>
Date: Mon, 17 Mar 2025 11:33:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>, Eric <eric.4.debian@grabatoulnz.fr>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan> <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen> <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen>
 <6d33dbf2-d514-4a45-aa50-861c5f06f747@grabatoulnz.fr>
 <Z88SVcH28cEEingS@ryzen>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Z88SVcH28cEEingS@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d22e5cd-fbdb-4d10-f7b6-08dd65717135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVlyeEcwbmtuTFNJTHlsK0M2SGRTbmdWM2FZV3lhY2wvbXdsTTJwN0FsSU1X?=
 =?utf-8?B?d3dQZU9EcUZMSU92aGI3aHZVUGV0eGZ1Uk5VN0JwVzVJalc1dk9iN290Nmhl?=
 =?utf-8?B?bmh5U2kzbG9lYzJheXhZS0E2ZFUwenJCZ0U4YVYyajBNNk9GSDU1ZVpiSUJU?=
 =?utf-8?B?VUZYc1o5VlYwMWc3a0h2ZGc5b3h2bFQ5bFBRcm81bnJjUnBCZG5nVFlzOXlN?=
 =?utf-8?B?dUFiZlJkNmY0Z2tacy90SzdPT0djM0pLU3gzZVpGWk1VVytYODdjN2JYcXdZ?=
 =?utf-8?B?SmxiLzZyV0xuaVNlam91bk1XKzZBVitYbVlMaURPWm1sU0o0TjhXZjVnbTg3?=
 =?utf-8?B?anM1b3NZZUx2eFlaL0sxem44aU1rZWpqYWR2Rm15Uzk2WFF3OEs3a1JGU2M1?=
 =?utf-8?B?Nzl1NTIzakZVSnlXS2ttWXlTN2UxQzJZVVpCNEIwVWZxQ1pRK2dubEttVnJ0?=
 =?utf-8?B?NTJhM3NxaVBWOEkrRGlHRUJxZzFqY2Z5ZXhucWpxVDFSeFlZNVNvcE94SDRa?=
 =?utf-8?B?dlo2YmNQRkRIZkFvTlNTMTJPcUFxa2gwTDVhTXM3b09BYmgxaEdZeVl0T2ZH?=
 =?utf-8?B?YWFvb3FDYUNSaitCekRBQ3p3b2dsb2tTSjUvbU5LMEJna2UxS3FKU3N0SUpj?=
 =?utf-8?B?K3ZMN3BQclFISHoxOTN1a2NCN2s3dEZIWkVqL2w2bkFzcWJTZHJUNGR2SFNy?=
 =?utf-8?B?b0lhQmh6czExZmVvSW1qcmx6eHk4dXVWaXUrME5lSzdLSXNTdUwyWndIN0xo?=
 =?utf-8?B?U1hYT1JEaGxET1dBUFB1emFCYWJCT2R6VmZtYThNbmhycjhiREZHMnZYN1Mr?=
 =?utf-8?B?ZWx5N1pGZUxVTEZFVFd1eDRHeDdRYmllRTMrdW4rMk0vTHp3UjdUdTdPN0pS?=
 =?utf-8?B?Z0M3ejRpcFZGTnVZY3N4bjA1MDVlcUdUbjM5bTBEOFNSVThNOTJIOW5YTkFk?=
 =?utf-8?B?UVo5RUpMejhhc1JDY0crMW5mNHAvSGpVMHoyVGY2RkV4d1YzMkFJemF0S1g5?=
 =?utf-8?B?cGM5bUFlYmlQWW4yZ3EwcmlWL0RWZWN4emtLcHBMMTAxY1Y1b29DYjhuNlZ5?=
 =?utf-8?B?ZTRGNGV1MUg0NTlWcXBqbk9BYmIxT1RDZUdib2FzVjZjbkl6ZFhEMmphM1VM?=
 =?utf-8?B?NkRybUVSS2FIcW41eVVYTGh2SHF2MTFOcHMzR09jcGZsYXVwSjJSMndoeGVD?=
 =?utf-8?B?Ni9lSTVJRDY1MDhTcXJBbmk0SjhYdlg2bTVzVkIxRUhrYkNSRTJHL3BtV044?=
 =?utf-8?B?OG1KcjlyRVRRZzIycnVZcnpDWlAxaER5VEZCRS9wTkQzeU56ZUM2YjFGaEc5?=
 =?utf-8?B?TUNaZ2ZYbWpJT3RlcWp4N2hqQVdMc1hVR3phQXhycWo0UHVSMjZsZFlPZ3Q4?=
 =?utf-8?B?YUU1TUR5dHdzMWl5NzlxQlpHMzY2YnY3QW5tZ2sreGpkMzRuUjFKd0wwckdX?=
 =?utf-8?B?ZjNJRlQ4bDN3b0RJWXgwMFZBUWVpc09QaENlcmRTb2lIbmgvY29DWkZBaTdO?=
 =?utf-8?B?L0ZUbkxkYU9DQ2pFNDE5eG1USm9nL2RYV1IvMTdNbko3WnBQczI2MCtVWnZP?=
 =?utf-8?B?bTBPemE5UXdxNDlSa2srUGFJN2p6dmJJRzNEWCs0Qy9yVDhQTDFPdTlkR0t5?=
 =?utf-8?B?YTdoTk0ySHJEQUZUcTVyNitlZ1JCc3JDbk5aakhuWnF6NXpWWXBLc2haSGdR?=
 =?utf-8?B?YUNHV21CWXdyKzFnbUJyV3g1K2lHcEwvR1BwQ0JLVURZUklNVWF0dWtETVNm?=
 =?utf-8?B?enhOL1VZQmhmbm1CbW5rZ2VYaDgxL2IxSG9ocUxZWVU4UmVaeW9TSW9mMUFm?=
 =?utf-8?B?TUdmNlNFMS9uNDM4ZmE1bXVtd3lXbVFtZkMxTlpzemdlTGREWEI0dlBMNHpR?=
 =?utf-8?Q?taqtaIB8bz26p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnRaZy96WDM0MCttQzd0VnBMVU5VWFJqSlEyamJMK094elFOZUprNkNHOHNq?=
 =?utf-8?B?OWdQL0hmS0F3WEp4TFA0dTZHbUhybFpvRmY3SGl0OWU3b3FQcksvOTc0bzht?=
 =?utf-8?B?RDRZZmxJVzdRTUZ3OGZkZk1CWUYzZGo0YmVGZGJ3dnlnaDFaKzY3WStHZzVw?=
 =?utf-8?B?TnpDUUo1cEVkSE5wZmZHTTBqTjJKOWgwY05pZU40OHpkRDhWcDlsdEZzbTRL?=
 =?utf-8?B?S2FWdHNZMjgvTHBDVmVkUjZkVkN0a2pDQVpic2QyRTkrTCtXL1d6Q0RQdG1L?=
 =?utf-8?B?dzh0cHlIYUZsTkp0ckFwQVBuVTdMYlIxU0lES2F0aGFJallNaGJOV1VQMkVm?=
 =?utf-8?B?QzhHREhDYUYybzd0N1lQeFprZkZGcmVQL1doUGFyeVlGS3hPS2w2RzR6WTAw?=
 =?utf-8?B?c2xwN2lGQ2JpUVFQSWZBeTNIWXNCOFlyTTcxT09aZXcxcFpCZG9jY0d6VURv?=
 =?utf-8?B?ZmFzRnV4QlhUQXc2OUtQaXVBcWpJWThsUzFUT1ZUOUcvTmJ6MklwRWhtRGU4?=
 =?utf-8?B?UWFCTy9BTk5OamxjZytzRGJlckdOVGg0SGRNRXpCRHdPV3NTcHhsdkRBTmZm?=
 =?utf-8?B?YTJZNjI3Q21BemRZTWFscW1FaTRnQS9VT2hsaTMwM01kYlpjbktrOXVvd0gv?=
 =?utf-8?B?VkVheldOejlaak0xNGo5blo1aVZTTFE2QnIrNzZFUXd6NDhwS0h1ZjEycmJX?=
 =?utf-8?B?eVZRYlh6eUw0dmt4Qk0wU1NmS2tTMmRZbmovZ2RLS01jenFRZ3hDRjFGb1Y1?=
 =?utf-8?B?Z1g3YlBZTkZDMTFxdlRpM2RVN2g2RjdSdDBqSStUZHB3bTAvT3VwTWlTbVJq?=
 =?utf-8?B?bWU1NnprUE1mdGRmb2I4RDArS1haTno2OUc0S1hCRXR3LzVSc1hTMEdma0w1?=
 =?utf-8?B?M1RrVVRXMjJHK1ZmbGcrbE5UUWlIbENoc1VyS2FHemdORHlFRUo0TGd3Qkpl?=
 =?utf-8?B?Y3FIaDU4Wk96MTRhOUJvdWVmVWZtU0s2UUxYb0d6TzlFZlRzNXVhamZ5d2M4?=
 =?utf-8?B?cjh4TzNlUEFBUmo3ajRMUzRLbWRGNkFYb0VmY2ROaEZBTklxVEJxa1N1QXZm?=
 =?utf-8?B?dER1bmp3N044dmNlbkVmYjNWSFVoSXFYd2Evd0d4aUpzZUR5bU1iVkI0MzVK?=
 =?utf-8?B?dFVqRjc1MzM3NzdraC9aVnNmYTU5T1lwd0dzV0hKMTZlZTROelF4SUg3cUx0?=
 =?utf-8?B?NEVWR3d2dGhRdUd5RmNKUmhLU0d3L3lya0tqQ2lKMm5xS2UxVU1Fdk1YL2w2?=
 =?utf-8?B?aTdDQkZMWjlzbU1rVmhPZmVHckVGM0dMUlprcjhzNlNqVVN1QXlUakNPZytt?=
 =?utf-8?B?VEdxd0NjYkFmNmppeFM5ME16YktSOTR3U2JhRmlhMHA5cWFleVNaZjVqVUlH?=
 =?utf-8?B?Y1AzaFd1K3graDkrUk11SzdOZGQrM3lpbG9NYWxEbUxLU2RkekloU0RlejNP?=
 =?utf-8?B?NitsTjNxQnh6SnZvN21GM3VsOC9YbFNUZFJtRk42Z3JQeXQ1UWhCR29KQ2dS?=
 =?utf-8?B?MlBvZEpRbVRsVGxYQ0hLNG5kanRYcVNINUV4RWxJME5SejZjVGdtaDdFejJa?=
 =?utf-8?B?OHFYZzl3N0Y4d282UmprQlRwTjFveGNMQW5NdlE0aHNpRWY1SmxDTFh5d21x?=
 =?utf-8?B?YWV0OXBROVU2Y290WjNHbFhCNzhtMDJYaEx4V3ZzZUdlTm5aOEtNR1pFZ3lS?=
 =?utf-8?B?a1kraFVRelRMN3pRbUxLM1ZvVlJLbStYL2NBcVUwSHhwR3gyb2Nkd1ZWRGVs?=
 =?utf-8?B?ZVFYdVpJRzFFZ245S0NqUXVncGhVVWovVEluTUpzTU4yUHQweXlIQmhlUmZ5?=
 =?utf-8?B?cGFoMzlKZ0lMODM0SlQveDFvTy83NmF3alZQMkU0QWtDVVdneEdVYUY0T0pm?=
 =?utf-8?B?MnY2bGgrdGVieDQ0MHhwQncyUlhzeGt0Mms5ellqTUp5L0FUeStVQTBzSVN5?=
 =?utf-8?B?ZmFZTE9wNHN3bXdkN0xyemxFM0dEbk9nVjNCRlo3dmNDNFNqeTlMaGZNQVdi?=
 =?utf-8?B?dGZTUFdQNGZJRmlhcVc4eGYxaXlYWHdxcnZkeEkyNjljK0F0YWFmTG9Ya21T?=
 =?utf-8?B?cVVMN2o0aTlueGpwSnViZ3VkZXhJalIreXJNTHQrWlZUZkNUNnlPVzZ1QWZn?=
 =?utf-8?Q?njn97YePQmEasFn74SJ/YKqq/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d22e5cd-fbdb-4d10-f7b6-08dd65717135
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 16:33:26.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkJA6BE1IQ9Hkz3W732HGruxZ40A7cn/rnG3SqkKe8Q5szTRUfm0qnh151U5G3NnpB6wliLdkg9L0t6HlCq3wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659

On 3/10/2025 11:24, Niklas Cassel wrote:
> On Sat, Mar 08, 2025 at 11:05:36AM +0100, Eric wrote:
>>> $ sudo lspci -nns 0000:00:11.0
>> 00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI]
>> SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391] (rev 40)
> 
> Ok, so some old ATI controller that seems to have a bunch of
> workarounds.
> 
> Mario, do you know anything about this AHCI controller?

Unfortunately not; this is one of those "Before my time" type of things. 
  Let me add Shyam and Basavaraj, they may know more about it.

Something that comes to my mind though is this patch:

https://lore.kernel.org/linux-pci/20241208074147.22945-1-kaihengf@nvidia.com/

It's been shown to fix several issues where the Linux kernel doesn't put 
the devices into the proper state from the shutdown callbacks.

Maybe it helps here too?

> 
> 
> """
> 3.1.4 Offset 0Ch: PI – Ports Implemented
> 
> This register indicates which ports are exposed by the HBA.
> It is loaded by the BIOS. It indicates which ports that the HBA supports are
> available for software to use. For example, on an HBA that supports 6 ports
> as indicated in CAP.NP, only ports 1 and 3 could be available, with ports
> 0, 2, 4, and 5 being unavailable.
> 
> Software must not read or write to registers within unavailable ports.
> 
> The intent of this register is to allow system vendors to build platforms
> that support less than the full number of ports implemented on the HBA
> silicon.
> """
> 
> 
> It seems quite clear that it is a BIOS bug.
> It is understandable that HBA vendors reuse the same silicon, but I would
> expect BIOS to always write the same value to the PI register.
> 
> 
> 
> Kind regards,
> Niklas


