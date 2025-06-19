Return-Path: <stable+bounces-154830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB33AE0ED0
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 23:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684503BA8CD
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 21:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520725C83D;
	Thu, 19 Jun 2025 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fqRu2Dsm"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0F30E820;
	Thu, 19 Jun 2025 21:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367031; cv=fail; b=P4VkWxA7oAfbnxBPAWEfrugX7gsuanhNeR9FV4898IOJjrii5H/1jIzzAPOq2Hcz+m6ZBaMcM/x5fw0ultcK6035F/drXv3k1ZTAUBO+SMZPDfDjkq6mJ98F0Z0sXR0WKfi6JkkFvFyaij8+hDYWyOLRHm5XFKmr33Ic8qFKKK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367031; c=relaxed/simple;
	bh=aP1+mCq7LrFd0/Fik+91TGFlkEgXLfMa8iwiDwTEuyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rk1WQ3oJWXhWG33GcQsm0W/Cn+zjOEyRPYt8vR+a5iUsHdqRyEKQHOytMYLxG0jQnvO6mP97K3WXg0NfHDvOwYGznuK/2Y46K0JexSnR2ng2cIL5CVimWGcvENH/avP/lBgaFnzqicWGHciq67DTKcFysc44DkhFL0EZadFMefQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fqRu2Dsm; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf+Gj1fAq0UNFI57+TXgFP5MVzcjhShA4OLdZblLWGzlhHb32IVaf68uRrl1rUOmgglJc1nDdaoFOJmoOihKm4QeCuxCby5DcUKpTzUB6yhKpzhTIZ9kS/QfMJhmYkymoGCacGEXvQBzwn2336J0WRIdsG69Hz2/lzdNpvj44KktpsAQpRDqpk+F9eu8aqBnMRHTwDzcRJmQcCzDOjUyIMo1wSKZqyM2szexfHc9oEfpEEspatQ/+jYLsSFQus8kn47aEkRuh21De3LPt+Rk+flLM1AEOW1NxUjEuZhHpIdXGwL6im61vUNtTUEgdG4LoGsOPgKd5/rqyd3DOptQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNm3zmtmJDNvza7nUzOYJez68i0I6w1ytSAICNGO/8c=;
 b=iqgzzu9eVrC+P6Ex9Y5xpyDITmqwqzL8L4POOyVFCxnq/A+Wt5gEA+6Vbnvjq0mP9KlD165cu9CEQt4fQDQll6bVjk1ibk7N49bcBy+jpbRSPHDxwpS25P9X96iNe5i6oRiF02jbY6mxbFm1tvO3jBBgzcVGJGNJ8Unl7TZzujPBj0gnlfkTO/Asy4DL3+G5yg1bTGV5+7mIO10lSHOuP1/lAP6oiIcwsRz4Lilbdoh9PaRwuAR3ij+iAGr3aiKfbvtWQcq6s4rKqNi0qUxdSo8R0UMKsxVK+p321buFN7sU7/dQX6VJ+/BPf333zslHrNAC0LglcGP5PSZgWzm0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNm3zmtmJDNvza7nUzOYJez68i0I6w1ytSAICNGO/8c=;
 b=fqRu2Dsm7Twx3HgidOx7mHNnqV9K9Q9OjCokwppAtEvqFYsmbBN4tCRogEeMPo5dgGOSzCmRmWgldR5h8sLc1+gM/N5hUVUHZsJPXtZC81+WQrrkQAtKW5VGtB0vLrYPrLpk+Ll9TxEq3OONcfMIUrq0oKY8GH0UOSCnG1749b4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Thu, 19 Jun
 2025 21:03:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 21:03:45 +0000
Message-ID: <fdf78dfa-452c-47c1-8322-c05bb5d2f1bd@amd.com>
Date: Thu, 19 Jun 2025 16:03:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] thunderbolt: Fix wake on connect at runtime
To: Mario Limonciello <superm1@kernel.org>, andreas.noever@gmail.com,
 michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com
Cc: stable@vger.kernel.org, Alexander Kovacs <Alexander.Kovacs@amd.com>,
 mika.westerberg@linux.intel.com, linux-usb@vger.kernel.org
References: <20250619152501.697723-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250619152501.697723-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR07CA0092.namprd07.prod.outlook.com
 (2603:10b6:5:337::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec4481b-0532-42fe-47e2-08ddaf74c786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2ZoVXI1eXJBU3JTTkJXQUEvS3FBV0F1QzVhdjRkSjlzQ29SMGdELzREeENR?=
 =?utf-8?B?MW1IelJlOUtNNURkamI1d0d6cWk0R2RYQWl5aVNCcWZJY2VWRGYzNEhNVW5E?=
 =?utf-8?B?a1VJR3JWZDdtV2ZoY1g5K3dXbElSSFBqbG8yQ2lBUWcwVFRCTGhiVHJFSlVL?=
 =?utf-8?B?cjlNQzRRK0paRzBOVEtWWElCZWFQMElCS09xNUlPN2FHb1YzUEI2TDJGZWV5?=
 =?utf-8?B?aEo2NDF6ZksyQ0N0SjBwNjhRRXlTS2FzWVdWOFZVRGhJWHJubFlYM3Y2d21x?=
 =?utf-8?B?RENjQ2N2Mm1oZXAxUE9wUjF5eSsrUVV3WFJOcWZ0TTJXbmh2aE85dHhDRE1h?=
 =?utf-8?B?OCtpbUZTak12QmhFSFpsTy9paUN5SzhWVUxldjdoTzdIcUtBRmQzUVJsOXZh?=
 =?utf-8?B?SDdnYkdTU0pLZWpXcGdvaGp0akxBbmhBYUk2ZXFCdWZ6dnVhWXRtc1dtTEg5?=
 =?utf-8?B?enBjMWhQYXBUU0RpMCtCaXVQRU85RVRwQTQ5UXljb3IzSDd6elJDL1NSRnZi?=
 =?utf-8?B?STRtQ2dmaDk0VGVPV3lCMjA3YVJuZURlM3JYUXhsT1hLKzQyaGQzSnRwL0hV?=
 =?utf-8?B?NGNlQ3hRbnhhQSttTDdMYnRDY1RoSjBObk1rNVhTK2pzSlZ0ZmhyeWhqajMy?=
 =?utf-8?B?WVMvODAvdjhhV3M1YzhiamJjSVQ3NlY0Vm5JWm9xMm1KRlZpcDZJOGJiekh6?=
 =?utf-8?B?M1ZnV2lQYzJOZGpQaDF5a0VyT1JGU0xFcCtvOXI4WEZKbnRPOEptNGFvTkZR?=
 =?utf-8?B?ZDFDTTRJdGVqbVUxajZZdTl0cmMzT2VDcENsYjBMN0xCbjhiSnlKdjZiVEYr?=
 =?utf-8?B?MThPWE1IV0tnejJQWDZ6UzJ2dWZDcEhhU0U0dXA4N0ZWM3gvcTJUN3BUaUs1?=
 =?utf-8?B?YVRxYUNGbWl2d3RRQ3I1MTI3M3I1V0hLdEtkbjlpelFiL1lPVmlSZ2xwWmlH?=
 =?utf-8?B?UFFQMjU4WGJTSDg5N0FpRk5reDFQNi95cFFtaDhsS3hHWlltZWRNTzZ5Nk90?=
 =?utf-8?B?TVNGamswRDZoYmZHbkozdE51dXNyQi9ZWEJqcVFydWlTVW9uaUFHaGtvYTFH?=
 =?utf-8?B?SXN1V1V6aUF5VW1RR29INzg2dVF0ekw5NlVaVGhheXA1NFRsUUpwL1haU1U5?=
 =?utf-8?B?MWgxRmdyWndEdGJMZUtNSW5GSkUwUzJKOGRoank1bTFBbEVDV2EzcFdSNVB2?=
 =?utf-8?B?Q2FzMkVmQklLS1FzZlFTODZVK2pOcXNxL3BYc0tvQ1I2MDh1QjJ2ZWc4RTFN?=
 =?utf-8?B?QmoyRUV2bmRaWURDNWpzZXEvaldMc0swUTZSdkhyWWhjYklsNkptUjM3S1hM?=
 =?utf-8?B?WVlYL1ZET0ZEZVE1a01YZjV5ZlpHaUtLdkpQWjlsYTBSL3loem15VjI2bXQ2?=
 =?utf-8?B?ZUpVK1RqUFdRNHhUTzFBTEFhUVAvc0RIUXRzOTlidlo5cGFDTVhRV0xpL1RY?=
 =?utf-8?B?KzlMRHZrYTNUWWpKaWl6b3NLb0U5MnRKRm5xZ0VTOU8xSXdxZjhTK2hPUm4w?=
 =?utf-8?B?YzBscDVoSmNkdnZORjljRmZDNGxtVDBmaXZPM2U0azNWTkFHL1FMZXl6dEtq?=
 =?utf-8?B?OHFET2dOT2g2L20vL3U4ckErNndoQkFyZjN5eWo1WUJ4SDdEVGQrNEYyZjRV?=
 =?utf-8?B?UDBpcDFSY0hWVFF4dnE2OXNRT25BSlFydFdGNS9OcmVkY0VpbmI2RTJuNU1O?=
 =?utf-8?B?V0MvQU9MdDFuYnpYQ3A1dXhRQ1hlL0xSVGtOd0RkcldGTmZMTHFIWUZGWDRX?=
 =?utf-8?B?YUlDZnZxOFNoL2Zxbzd0Z2dSTnRhdVZ6Z3pBRGJUY3hQbnV6TnVYUmcrcm4z?=
 =?utf-8?B?b1d2QWVBMi9yL2JJZjVLbWhMZ0l6UmhTYWk5enVzY0FZazV5V0I3N1daVmFh?=
 =?utf-8?B?UFpSVU9weDMyQ3N0c3ExTHR1OE5FL0VoeHExSGlPMTZvZlFNbVB0T05CeEU1?=
 =?utf-8?Q?9PGEIOBvAr8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTluejRiNG9UU0g3VHRNczVGTS9aa3pyeWJPYmZpdys5SG81bllENHNqbGFu?=
 =?utf-8?B?eEdyd2FhQ3dvbk1YWWk4ckRhMVRDdDNIMU1hbFpHZXk1WFJxQ3VpUG1SRGx3?=
 =?utf-8?B?dnMvUXBoeXRyU3FVN2s3eC91R1NOYkI4d1lZVlJaK0RtLzZ6KzhMT0grV05s?=
 =?utf-8?B?b0hnMFFxa05ubnJxbFpCMmdVL1RQWnJuUk9oSFB2TWRvK0lKbUJFcFk2WTc0?=
 =?utf-8?B?M25YM0FyL3A3Mlk1VXRYNkJaSm5WNkdvV2lIZC84NW03WWFnTFRJMi9weE82?=
 =?utf-8?B?bFFyNGt4MFA4TkUyYkVwMmtPaURuS2tqc1dLL29rdEk5TlVKS1JJU0Y2ek96?=
 =?utf-8?B?eWNQd0VQRTFKdVB0czBLcC9PdGJCamtXZW1oZmRKdVN2L3hXOUpKaU54Unpl?=
 =?utf-8?B?bFJFczZDWE5LU0taMEZKZVduZDJQTko5emVCNUtOSHlGRlFBYnZERHZwcFhk?=
 =?utf-8?B?OXlwM0RFaVNDTnhpazBpQ1poTUZBaXBBSkVpb1Mrb2FlYmlzSXhjamp5MzRN?=
 =?utf-8?B?eDlZcWJVcHhkMkZvYkFTTFN2b1MvMjNQbmNyTSs3b0Nwck5RbWd6UGxqSm5y?=
 =?utf-8?B?NHpyaUxnVG9LSm1XMXlPWUg4OFgvVWo3Zlg3aVFVNHBjelRWSDFFRDBXUVpp?=
 =?utf-8?B?eSt5TkwyZXJXZmdBeG8wTTdqWW5pcVVLNEVkRk5jeS9PTmU1WExCVWREVlVN?=
 =?utf-8?B?RG42dVhkMTgyNFFXeGR6WllqcXVmV003aUt0ZlJxRTc0QmtMN2tNSnY5S2Qy?=
 =?utf-8?B?aXNsRHdQTzVacU9LU0hMYWVhd0YydnZvTnRnUFdidE50akNrcmd5clQ5V004?=
 =?utf-8?B?aTQ0RGhqbnE2UXNDZ1VhVHJRS1BOb2JvbC9teXNvVkhuOUpaeUhORW1SamVa?=
 =?utf-8?B?V1FUQWMwT1pCMTVxcC96UktibTZwblRsMjZUWS9KVTIvREhQSmhiVXhXajl4?=
 =?utf-8?B?a1pVNURkRW9qRlFPZW8xeDlWblBMUGVVUmdTc21UeFFBMzBPdG9tL0RQc2Q4?=
 =?utf-8?B?U0hIQXBqb3ZUK0lYaktaQXlIOGFCcUFHeXNzOUtTSzRvUjFqazlMei9oRVEx?=
 =?utf-8?B?UXM2S0QzSHhqKzM1UThaS2dadUxSSGJ1SGEwb0hYV0liWEpRcTRvb2U4UG1s?=
 =?utf-8?B?SXlLQWlxUmlJLzByR0FQYklWMHFaamorUFhMeDJSVUZFWFBRcVNJNWRQN1pG?=
 =?utf-8?B?RVlZbjhJaFYvYnZMUFJCT1Q3WHp2dzlrUlBuQ0tFemVqN0hWNVY3bFdmZVZP?=
 =?utf-8?B?a1F4STZLaGxwWHZTNUozZ0RlQVZZQ3JtSENxOElRbUl1MWMyWkdCcDU1V3Y5?=
 =?utf-8?B?b0M2TG5SdWJ4QkE3SmNLbmtUOWREQWh4S3NEQzllVjcyWkJVeFNlWTNCMUYx?=
 =?utf-8?B?U1JjK2g0Y09ETzc5MFZXRWJXODFra2RSMzlYQkRkKy9Kc2xTa1VTdEhHeTJu?=
 =?utf-8?B?NHl3SVFmTSt4K2ZEb3RFLy9DeUpac05HR0NyTE82ZWlJRVdHV2RIbm5MWHJN?=
 =?utf-8?B?bm80a2laSVJjcmdGTCtnQmE5NW5YV2hmb0xYWVRSWnozMnF2NWRiQXA3TG1Z?=
 =?utf-8?B?cFNEcldQekZnNHhGY0dMOFlxSzFDRzVJVHZTbmFKTW9xaGJBMzgxK1JXeDVz?=
 =?utf-8?B?NXZwRTNhY0Y5WTdSZnU4dzc2eFVZQ1FtQUxKbHdFeDFvbzY2QVJRZG9MUklH?=
 =?utf-8?B?Tk5GZzNoaCt3ZlBwWTMwTkp3czV4K2ZLY3JuaDIvTjRESERNcFUyTEpSL0U3?=
 =?utf-8?B?Rkd1c2dkYWVTSU1zYUcvRVF3NWdMOGhCdVcrb2pPZkk4bnZaMktBYWIwckxV?=
 =?utf-8?B?cVg4K3hqNytLYWJESmQwVTVlSmpGL3BLNmxoQ2VzYVJycncvL1U4WWlFbXRj?=
 =?utf-8?B?QUt3MkpDakNMRkRjSkdQRVQvdUZaMXYySytJWHhCTFl3MkFLQzExZmdFS2kv?=
 =?utf-8?B?YXE1aEpmZUJvbkhWMTRJSG9ramVVNHRWT0VLTmd2SnI2d215aEQwaEFhMjBm?=
 =?utf-8?B?UUlxRm5hZko3YnFzTmloQTlKczJkb0lmRGhlWStlUUptSzkvREQvRElqUDN1?=
 =?utf-8?B?eVIyakdlYlBnWW1WUkI1ckRqTGd5NlJuZlBSYzBkSUFkNmk0ZjJOVGx6VzRx?=
 =?utf-8?Q?0ycdCQFLwKYoLjPCmgQcz6ihi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec4481b-0532-42fe-47e2-08ddaf74c786
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 21:03:45.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuJHGat22PtRaP065QM40Voam0mQy6ZxJmUwDg9l2UaXi2qbGiNbjGwb/uaCt/xAUZ3R679Y0KncdyuykUWUyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351

On 6/19/2025 10:24 AM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 1a760d10ded37 ("thunderbolt: Fix a logic error in wake on connect")
> fixated on the USB4 port sysfs wakeup file not working properly to control
> policy, but it had an unintended side effect that the sysfs file controls
> policy both at runtime and at suspend time. The sysfs file is supposed to
> only control behavior while system is suspended.
> 
> Pass whether programming a port for runtime into usb4_switch_set_wake()
> and if runtime then ignore the value in the sysfs file.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Alexander Kovacs <Alexander.Kovacs@amd.com>
> Tested-by: Alexander Kovacs <Alexander.Kovacs@amd.com>
> Fixes: 1a760d10ded37 ("thunderbolt: Fix a logic error in wake on connect")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>   * Fix kdoc issue reported by lkp robot
> ---
>   drivers/thunderbolt/switch.c |  8 ++++----
>   drivers/thunderbolt/tb.h     |  2 +-
>   drivers/thunderbolt/usb4.c   | 10 +++++-----
>   3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 28febb95f8fa1..e9809fb57c354 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -3437,7 +3437,7 @@ void tb_sw_set_unplugged(struct tb_switch *sw)
>   	}
>   }
>   
> -static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
> +static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime)
>   {
>   	if (flags)
>   		tb_sw_dbg(sw, "enabling wakeup: %#x\n", flags);
> @@ -3445,7 +3445,7 @@ static int tb_switch_set_wake(struct tb_switch *sw, unsigned int flags)
>   		tb_sw_dbg(sw, "disabling wakeup\n");
>   
>   	if (tb_switch_is_usb4(sw))
> -		return usb4_switch_set_wake(sw, flags);
> +		return usb4_switch_set_wake(sw, flags, runtime);
>   	return tb_lc_set_wake(sw, flags);
>   }
>   
> @@ -3521,7 +3521,7 @@ int tb_switch_resume(struct tb_switch *sw, bool runtime)
>   		tb_switch_check_wakes(sw);
>   
>   	/* Disable wakes */
> -	tb_switch_set_wake(sw, 0);
> +	tb_switch_set_wake(sw, 0, true);
>   
>   	err = tb_switch_tmu_init(sw);
>   	if (err)
> @@ -3603,7 +3603,7 @@ void tb_switch_suspend(struct tb_switch *sw, bool runtime)
>   		flags |= TB_WAKE_ON_USB4 | TB_WAKE_ON_USB3 | TB_WAKE_ON_PCIE;
>   	}
>   
> -	tb_switch_set_wake(sw, flags);
> +	tb_switch_set_wake(sw, flags, runtime);
>   
>   	if (tb_switch_is_usb4(sw))
>   		usb4_switch_set_sleep(sw);
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index 87afd5a7c504b..f503bad864130 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -1317,7 +1317,7 @@ int usb4_switch_read_uid(struct tb_switch *sw, u64 *uid);
>   int usb4_switch_drom_read(struct tb_switch *sw, unsigned int address, void *buf,
>   			  size_t size);
>   bool usb4_switch_lane_bonding_possible(struct tb_switch *sw);
> -int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags);
> +int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime);
>   int usb4_switch_set_sleep(struct tb_switch *sw);
>   int usb4_switch_nvm_sector_size(struct tb_switch *sw);
>   int usb4_switch_nvm_read(struct tb_switch *sw, unsigned int address, void *buf,
> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> index fce3c0f2354a7..d46d9434933c4 100644
> --- a/drivers/thunderbolt/usb4.c
> +++ b/drivers/thunderbolt/usb4.c
> @@ -403,10 +403,11 @@ bool usb4_switch_lane_bonding_possible(struct tb_switch *sw)
>    * usb4_switch_set_wake() - Enabled/disable wake
>    * @sw: USB4 router
>    * @flags: Wakeup flags (%0 to disable)
> + * @runtime: Wake is being programmed during system runtime
>    *
>    * Enables/disables router to wake up from sleep.
>    */
> -int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
> +int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags, bool runtime)
>   {
>   	struct usb4_port *usb4;
>   	struct tb_port *port;
> @@ -438,13 +439,12 @@ int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
>   			val |= PORT_CS_19_WOU4;
>   		} else {
>   			bool configured = val & PORT_CS_19_PC;
> +			bool wakeup = runtime || device_may_wakeup(&usb4->dev);
>   			usb4 = port->usb4;

Mistake here; at suspend this is causing a problem since the pointer 
isn't assigned 🤦.

I'll follow up with a v3, sorry for the noise.

>   
> -			if (((flags & TB_WAKE_ON_CONNECT) &&
> -			      device_may_wakeup(&usb4->dev)) && !configured)
> +			if ((flags & TB_WAKE_ON_CONNECT) && wakeup && !configured)
>   				val |= PORT_CS_19_WOC;
> -			if (((flags & TB_WAKE_ON_DISCONNECT) &&
> -			      device_may_wakeup(&usb4->dev)) && configured)
> +			if ((flags & TB_WAKE_ON_DISCONNECT) && wakeup && configured)
>   				val |= PORT_CS_19_WOD;
>   			if ((flags & TB_WAKE_ON_USB4) && configured)
>   				val |= PORT_CS_19_WOU4;


