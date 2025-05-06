Return-Path: <stable+bounces-141933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC68AAD09A
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 00:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E3D4A574C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 22:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F7321D3DF;
	Tue,  6 May 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvFpdgHK"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210B921A454
	for <stable@vger.kernel.org>; Tue,  6 May 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746568826; cv=fail; b=pYbCf9Vg2HW4IXtEGfcMSdKKZOgqkGhL/Juw3gN4AVpbbwMjrGb/5uXCNA3DyrCsQVRG99bMLXuAxFv1Co/Jp+Us8ItxtiEAw6gp10YugoC0wtX9NzHe/OCuuwVKviTA/FYDrG6+S+X4rUcIFZhtd972fIh/0Afk3zLRaYzz4DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746568826; c=relaxed/simple;
	bh=Wf4C39jl6R/OsbOmDnOevCNMz092gYdOemGik1QtsCU=;
	h=Message-ID:Date:From:Subject:References:To:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3R5mSviyy5is+J3Bkl2cjc6qO7aNxnrCgr/3+iSrpj6bpBmSquydcijGlIRgTOBredjLkRuLj/oR2lZZVrvxnGMUYbaiiy+uB2rDXybg7JwV1CIuqMjAYzZPLhyyRUKGB3SFx+/+tIIv3ZU2Hk9awCTCqgR/ns7q/ZTLdbOkZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvFpdgHK; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nY/87aE7llgGotUJNJCw58fcD7av61q3lsTkYrMn/sQhDjArYlKkGXMpIXNDarrdtqa6j2yPxMxrJpSTxFDtTXPaPSoJZN+p8den3RTIZyFNVi25iruURZ4eRXOMVTtVzjB2DcvvU0Eacfz6A21k7o+tep6JQ2E1lrpqlQbR1wCrAFsbgSOCv88W0d2lncMS04zXxMt3nRQLqwCgA/UhOZwu773jUMYT2vYE2zjcbRr5DS+V34nplbdF8EWR7mWNGQOS5BjsEs60OcKMnR9m/CSKBxHxZu2Venfdr9oQYJchzj7tgTEDnhKq46og5yPHoKDYdaN9tDiHy3lpNYp6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaM0G4j9UK1qnrTJJ8HUtT82ot2aKnOHh4MPlJ1VxHU=;
 b=BZLawHdqi785K1PEikHuTMIuq/OgJPIVOGPgFGBc/dj+A0Kb5OsKNsT+3aE6RjVhMBFnUBW7Jysd3zdqr2sGgePDP2ERf9KMiZ3jnZIVmO+FL5/3NKFZrIJlz/W5zKHv5NRAs6q5TadU6hKXhPd40v+uJcLOFnXBqFWoSZprv2JKcfX7R/O83VGTU+C/NsM3KLPPtdeiW/MNqPp6DkstoMyGhskXwrS1AmSvOIo6vNS30FDI9o/DzkjjNxCzoeTRJbhDvi7d9L8pyEHJ8xAxub8DpwPyT9OSZ4/X9t4Xgr2uEnNCbfd36nBOyNcRsclMkGtUtn8Z9e2uUGSmmSbX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaM0G4j9UK1qnrTJJ8HUtT82ot2aKnOHh4MPlJ1VxHU=;
 b=IvFpdgHKX8d2ehHTwEL4DjBhKBNefholBLcRuKbXvTIH46Z632uFv+VWwIRf34fkER//ymUbZWV8SDeb1j/040Kt8NovaBBzB8AwsuVYvUnbrGlUko9CQwDWLwK67bon0PS+/9Xg6tomIfea9XJiLZEuxdZcQc9VRJUx/4PbtpylVX0DyKiG+SOjYl42AKteYz6PQbkotSN+dgW5UHlk3EXLPngPsvl6V023zhrYWk5c4xZwvhCbCRqOJAZpOZXLW/Bd6noEkbZcm9ilDdhCcbUx7SGvOn0UDYUOB8L7+ZMk8T+ZzYBaLAaTfrNpldGbZIgHTMChnE1QwPRPjkoMOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 22:00:17 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 22:00:17 +0000
Message-ID: <11c4208b-ad97-4d26-80d7-e728ebe2552e@nvidia.com>
Date: Wed, 7 May 2025 01:00:11 +0300
User-Agent: Mozilla Thunderbird
From: Jared Holzman <jholzman@nvidia.com>
Subject: [PATCH v1 0/7] ublk: Backport to 6.14-stable: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Reply-To: Jared Holzman <jholzman@nvidia.com>
References: <20250506215511.4126251-1-jholzman@nvidia.com>
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Uday Shankar <ushankar@purestorage.com>
Organization: NVIDIA
In-Reply-To: <20250506215511.4126251-1-jholzman@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::19) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6269a3-9e88-421c-bff6-08dd8ce962df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekU2eS82N1M5UFh6RXBCeEQvMjl6K0dCU1VMczRteDFOUTlSdnJjK3hzZk83?=
 =?utf-8?B?ektUZ0c1Y3d5NzU1NUxEOVQyMGNzb08vUWhHc1BRT1ZxcVpKbnRhQ3hEbkV2?=
 =?utf-8?B?ZjBCS0xTRlZ5SVBMTnJiQ0FTejFPU2lSN3NWU3dXUk9VanFTSk03N3pTQkIy?=
 =?utf-8?B?TWdlcUpiRUJhbi82dnRheHdKSVN4dDAzR2U5ZG1BTjY2WU9TVDBuZ29GM3Ay?=
 =?utf-8?B?NWxqemptMm5yc3NOa1ZhT2thME5CeVU3RVVRQ2gzQ2FrNXNVTUdkZk81M0hy?=
 =?utf-8?B?UXBSbFVORGVGQXAzS1hMeUFvVXFKYm1ERlQ0VFZIeWV4Z2ZqRWUxRW9xU2w5?=
 =?utf-8?B?aVl6TU9QYzluTVFMYVdYSWVPN21QTGlxNU1qYlAzRFB4czZKS3R4VGszdUIx?=
 =?utf-8?B?ZkRHYTJvblpMNjFhQlVMUlJDcnRubkY5RVQ2T0RaSmdOVWVpUGl0V0Exa3gw?=
 =?utf-8?B?NS8wU0NTVVlPL3JRK2VMbmttVGdMZkszc0txdXduc1EyZTdTTzRIRUprSzZp?=
 =?utf-8?B?L3pEdDk3RVRldFNuWnFXU0JGd0x1Q1EwL1dFcFdQMzVrUEJleTJvRkFXYk5K?=
 =?utf-8?B?VStsaW1YOS9IK0d1MHEzaDI2RDRnK2Z6TkpHRC90NXV1TUVRUXY5MFg0bWNz?=
 =?utf-8?B?b1dhOHpYbmpyM2htY3V3eVIwSkxhV0J2RnJaS0Y4RkR1L3p3UHd6OGVWMXky?=
 =?utf-8?B?TVpPZUJEZXpVTklkQ29XU2RCUm9vbGpZZ1p5OVJ5M2JXZ1MzaHdNMFYxNHN4?=
 =?utf-8?B?bmxTWVNaNU1HcGtnQWxDUEtmakxBbStHKzNGVEV4NTF4cnZobUFoU1RFYzVJ?=
 =?utf-8?B?NFg0dlBPMUQ4dU9haWJXbFJiSUY1dlF5ZkVoVitwa0xrMkxWRXhBUzNwakRz?=
 =?utf-8?B?L2xuT2ZHZGJDaWdFYmJBSWY3TGhOd0kvYVZ5akhPSDZFeEx3bE12N0k5eDJY?=
 =?utf-8?B?UmNYTnI2NXJWRlVaZW85bjJnZUNoblBsZlpIbEROZy9jK3RIQmRiUVhSOUcz?=
 =?utf-8?B?aEUzL3ZWK203VUxoWHdIcVpKWnFnRFoyQS9PWnBVbndHNUNCbDFlUTQrOHRH?=
 =?utf-8?B?dTM3Qnl5a2JiWjdCQThwdFFyckdxQjZ4MVZQYzRPL0tmblRiQWNBTkkxMHdr?=
 =?utf-8?B?VCtmOVlVUXdURUhxWjM4eUd6Y3NIejluWUVSNVRXR0ZFZzVDN3YzMXR3ZUhs?=
 =?utf-8?B?SHpwbHNiWGI4c3ZtWXk4MTYycUNVVkx3R0ZiNVV6UkJwRENVMUgxY3B4aTJK?=
 =?utf-8?B?cnVzQS90RGlmZ0dFQlI5WnpCT1hPZ3JPK1JoNVBrR2VMVjB5V1Q4aVFWbTVI?=
 =?utf-8?B?c1AwVVU5TTZjU2h3S2FPQzBwWW5SRVorTS9OQytBS2UxY1VYaGlhWFQyYmhY?=
 =?utf-8?B?VU91NXhsblZBRXZhVGllZm5VRVBQYXpvL0t2bDIwLzl0VHFPRW1NbDRiRHpx?=
 =?utf-8?B?czRKSGkyUUNCazNsd3FOMDU3QWhoN1hyMGtGOTFMVTJRVFpvUC9UUGJYQ2JH?=
 =?utf-8?B?cFh4OHNXMmhSVXNiTDJCNHM2cFR4ODJnTEtmKzVEUFB0anIzTDRZUjNDeXc0?=
 =?utf-8?B?Smc0bW5Zc2gxcWg5SGhjSFJKT0VTWjJFWlVIM09xTVhtWE9YRW9GMzZoUzNs?=
 =?utf-8?B?Ym9DZmE0UHJDMmJieGFaVFlTTURrUzJGSGxuOXg1b0RRd0lWZFUvMUpPb0ht?=
 =?utf-8?B?ck1wWXRPMWtKdm80NXh5Um9XQ1p1SWM1WXRiQlpaMmVMcHoySkZIL0xlcitp?=
 =?utf-8?B?TVZTaWh4N3p5MmFUU3JQL0FqZWE4bFo5MHNvSE1yR3RGbHhhb2xiOVBwTGho?=
 =?utf-8?B?TWpJdjNnbDJpZGE3M2VHVEdsak1QenZsTy9hQ0k5cGVpZXhuUnExSDFMYnNO?=
 =?utf-8?B?S0ZUejV0bktzeVdHOFNoQkVENHRyZWZpcWJSRTdZd1FCdDl2VzFBUUpQNVYz?=
 =?utf-8?Q?KW/QL+5/5T4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUlnTTM3eURCeXNmNTZOSmZocjNYYjdIWm9LamlVTXRmWHl4UlY5UUtVREZs?=
 =?utf-8?B?V2Y0b05yMG1BZzJEaE9jRWs0RjM5YWgxT3VLOHRiSWNReklSbXZGWG1IUXUz?=
 =?utf-8?B?OWljb1pWK0x4UnRKcVRBb3FXdVFlWW5KRE9UY3oyNDB0eXBVRExUbDE2a1BF?=
 =?utf-8?B?M3lnWVhZNGRSSnJSd2dLdWlHZkhFa2t6eDc1ZWJhb1BJSE9zTFdVdzY3R3Fo?=
 =?utf-8?B?d2tPUDN6MEtSVzFLZmZWV2liU1RvUkpnbE5sUk1PS2VRV3dTYXN4bHR0a0hU?=
 =?utf-8?B?bVRvSmFSOFBOMkViVFNvVDRnbGt3TFF0K1ZOMmhuaGYrdUxzLzV4a05rdXdz?=
 =?utf-8?B?NlphZllnVXpMT2I3RmNNR0xoSDdSUzhXbFdGWE9YaEtxYkxJS29XUW9uYlZS?=
 =?utf-8?B?ZFhpUGFNMFJUWnd3YXEzRUxleURhbnVoTWVRTERlZEd1L010U3RvRFdiNzNK?=
 =?utf-8?B?Y1JIZy8va2hQVXhvQ2hpcVByMUdsV082dnliSXc1Umo4RnNNakoxdjR6T2VF?=
 =?utf-8?B?a2tMcUlaTWRmYXdmL3Y2ZUVITmx5Zm5TSVN0NnVQVWRXbC9oWUJ6NHJ0dFN4?=
 =?utf-8?B?Wkpsd3RMck9GZVByZFN0OVBiTUZFU0Z3cVVtWEFET2krdHdRQmZ6KzhVNTgw?=
 =?utf-8?B?WGRmOUNMUW5Ka2JjQzZpbTg4Z3l5bUdyVFpuMzZUMnVvb0d0NE9PellHK3ov?=
 =?utf-8?B?WkRETWFsLzFTYUxObkJsd2phYzJYeFRVdEpkbCtrbys0OVVlUkhESlpyOFJQ?=
 =?utf-8?B?UVZ1dkpXMmwzTUdZbDhENTdSdzNaWm00UHR4bFF2dEJ6bXRoVk9YQllZYmR2?=
 =?utf-8?B?UVVwdFJwME9GTEl6QUxjUjBWZnJsN3QzOUhWUjh6ODVZMzNEbWljVFdBakZp?=
 =?utf-8?B?RXlaOHljbkNrUHZoNnlYazZwSmhwR1FMTG05QU5qMlZ2S043cm9VODhpVFpB?=
 =?utf-8?B?WEtyK3dRUGUxU1Z5VnMxZG5ydEFEeGo5V1lWK1UxZjdHbkFzdUlCOUx2a2Fa?=
 =?utf-8?B?cCswdWg3dTFqRTFJWFlVR1M3QUlMTHU5VmpueEcyMy9WcnkyVTg2U21mdWNQ?=
 =?utf-8?B?Y013NEN3bE9pKzFVeVQrZ1Z0SUZid1Ixekl1cEhsREIzeU1EN2FCL05PQXhh?=
 =?utf-8?B?dFgyZGZnaEJpMzRINThzaDBISDAvUTlPWFZDN1czcVJRZUVWZXpXNVg4VXB0?=
 =?utf-8?B?NzN3dTZUV3gvQVl6L0ZLQXc5WU54Z1h2UVk4bitTVC92SFIrVmsydlRYd3Rx?=
 =?utf-8?B?bGZMcWUzZVNobFFtOFluc3ZyRXgxWmZLbk1HYjFwcmZHZUg5SW9jWTlYZXll?=
 =?utf-8?B?MTAyVFY4elFYMWdxS1ZGOFUwQlZDWit3SHBBMC9lY0tZdnpDOGpiTmhQdWw0?=
 =?utf-8?B?cWJ3Q21acThackxqQkhKQ0hzdUVjWmpCbDBjR3MzaXE0dlMrRUtua0tsWVUv?=
 =?utf-8?B?VGdQRENxeDZQZk5TYW93MVlzdDF6Q1VMUFp2ZDlQZm1DdTVEQkxweTJselBN?=
 =?utf-8?B?ZXkycy9XNHJZQnZlRzJaLzJ4WHB1NjBYWHNzZzRoSHpiSEJ6TkdHdGpJT1Er?=
 =?utf-8?B?Y05wT3ovYlRBdW40UnVlZW9NUWhUNW4wdmZGcXBYa3I5ZnVqd0xjaWNac1hM?=
 =?utf-8?B?cld3V0NxdFhiQTVydWJISWN2T0FWM01VbU52Q2gzTU11c1FiWFNmZlpsakRw?=
 =?utf-8?B?OXpOWWgwSDliMDlVWUFiNnZ0OVh6UzBFK2VZekl6OGVMbzltZEJ6bHFmT0F1?=
 =?utf-8?B?SkRITFJ0ZUtmRmZXdHUvaEgyVHVSOE82YS9Wc3lnT3grUjZXQ3F5cVVSSmlt?=
 =?utf-8?B?Vk16bEhYQUw5Q0JxbWd1TkJxNURwSytIT21ZSUZ4QkVnMEJJTVM5K1I5TmRw?=
 =?utf-8?B?NFowVnFha3YrUHlWM21oOElnNHF6RWJGaG5lblJUWWNNc0FFcE9CMmFoaXU5?=
 =?utf-8?B?aWF6N1k2VHJZZ0pBNXVuSHVWYjhlUGE1QVRnWXN3UjZRYnV1eHF2cjcyUkdm?=
 =?utf-8?B?NTJRYmVQaEpZUGl3U3dGZ3VtamY2eXlVekNEbGN0VW9NL1BSaU40NkY1eWtW?=
 =?utf-8?B?dnl6cjg4UldPdUdwMkxNbkpxYjI0OTNkS1lCWmxGcXNCYkg2SXZpK3lDbS9I?=
 =?utf-8?B?dG9CTXRGb3hEa2dYTmwraHcvSloyYkJNUFlBdjMzcEllOFVMQ3hZRlp3VUMz?=
 =?utf-8?Q?TnW610y0d0aebhctbmBcUmzoW2aTFbcznuIwLF/blFkP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6269a3-9e88-421c-bff6-08dd8ce962df
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 22:00:17.3849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TseAqlVXPLIoPg0+MnoksGCiCUJSsytUQAej0PgRsqY0PyBFxEm5wpvYLmeB9XvjEMiFPKlJzI2V+0YP9CmomA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528


This patchset backports a series of ublk fixes from upstream to 6.14-stable.

Patch 7 fixes the race that can cause kernel panic when ublk server daemon is exiting.

It depends on patches 1-6 which simplifies & improves IO canceling when ublk server daemon
is exiting as described here:

https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/

Ming Lei (5):
  ublk: add helper of ublk_need_map_io()
  ublk: move device reset into ublk_ch_release()
  ublk: remove __ublk_quiesce_dev()
  ublk: simplify aborting ublk request
  ublk: fix race between io_uring_cmd_complete_in_task and
    ublk_cancel_cmd

Uday Shankar (2):
  ublk: properly serialize all FETCH_REQs
  ublk: improve detection and handling of ublk server exit

 drivers/block/ublk_drv.c | 550 +++++++++++++++++++++------------------
 1 file changed, 291 insertions(+), 259 deletions(-)

-- 
2.43.0


