Return-Path: <stable+bounces-87753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0129AB3DB
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 18:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAF01C21238
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C0D1BB6BA;
	Tue, 22 Oct 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WBMpg8Sg"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6521A264C;
	Tue, 22 Oct 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614317; cv=fail; b=L9L/aLY3tl5D3W1ytx1++kbuf+JmCDUjjZKf/dnM08Ke9woDa48/Zw4QcFrhVdZW1CWgS/36BZ1r30P/Otcx8zKw/2/70lImzM1i8+YNR9oEqkPf1/C9O0XDrij9y7Xhwijfa2LvfggCFr4WOHi6kCLG7GioCkft3V8rGT03+pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614317; c=relaxed/simple;
	bh=nPAXB3Ti7/rN8JcSWp9gUFy0EbFA03X82H3BQTrRSTs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BUjW8/AURUIPiHJfVKyPFb9SSraoUUz+bO8xf8q8EGhRWdp63qH2bfDVwL9tcZPITK09NOOH/2OD/LpKxaztEkOlciZoBQpsBWkeywLM6DKB4lASld0ClLv4HDZcb0yQlO0YBDg5LirJIOFQ1CzX49MT1oO2MurONSOpz0jCLp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WBMpg8Sg; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCCNeaAXIxEOS1L9tZYjMfATc8QR5ZuPWGd2YGs8FB3hOFTpZ3vmvY5A4r/eo26ksC2aK9XNIDkyuOQiPWotdDv3uxmABXqtqZnEq0ZBTU1i5Oo16LEAhmrlhjwM/IJBxp8S5oQO1ooHPWdLoKgQ3nMJN5dUZeMAfrfy61lwE74SMSi3O8tGHN8dTqOs/oa5vjgS5kiKFh+FFLjbhmMxfZgzc3d5pPV/fEKIybw8ZbORxAvRxvvyPQ9BrgDnS3bY7j212qLz6cAzhNvTAHQxLIVWyo4KrQgc0FHS2S7u1Njavn5kdDV+5F9g30wnm7gVU6OdEVQv/Spow+ZLcjTqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6SlOCp9AKo1jXN7zx2r3JLxlirQ7M+MvRzjQRVv/fE=;
 b=JUrqKo/bVslPmRBoBQrLSiYgp63pZU0HaKt8Z8wEaJ3ReeFbQgRsPFtTx6EUq3Nwu1Kb9yT8WA/EDb1ZgIGiE/dU1ItlLVm/sno5QD6ytrhcvfU9GtZlSoTGzT8KAxgmHhW4FbmJhUxAX1pOa8+sDNPKzLgTHFmdSyygZ11b6/OUi3qDbgm3kcFiLFIwqiYrEyB/Sx3ww/WIo6u4iGBgLPm+P92+TXaQTKrXV8itqsdruy6nd3Jl5TA+ggtYZRPFh7TFrEFtzAcaGUmM3Ostbi09/PCZZqVj+DGNyjDh+Iv0C6he4rLfkLkaks9F9n/TvRr+9fXOPg+cmmUfF73blQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6SlOCp9AKo1jXN7zx2r3JLxlirQ7M+MvRzjQRVv/fE=;
 b=WBMpg8SgWOq+qIFb2+3/6aqCR0QOWGHfDCMZMvLBcFXshkNkpxFKlXxuuNeXK+CaljE5qT/+CkKQ59Ei/vIGrP1n7BjgJH/PTPlYYMHRzfRkSqAIFV+hT2gv9nIjNYoDKUWk5VStw+Q+BaCdqgBlVd4CtYD5LIjeUtWgm3ARhlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 16:25:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 16:25:10 +0000
Message-ID: <eab5a87d-c612-4111-9f76-afb575a18677@amd.com>
Date: Tue, 22 Oct 2024 11:25:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
To: Rick <rick@581238.xyz>
Cc: Sanath.S@amd.com, christian@heusel.eu, fabian@fstab.de,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <000f01db247b$d10e1520$732a3f60$@581238.xyz>
 <96560f8e-ab9f-4036-9b4d-6ff327de5382@amd.com>
 <22415e85-9397-42db-9030-43fc5f1c7b35@581238.xyz>
 <20241022161055.GE275077@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241022161055.GE275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0183.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: e047d580-6249-4bea-4165-08dcf2b6195d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUxBekFwNFlabDllWCt6a3ZsdEZja2hxSWJlYXl6VHA5UFQ2YlpNMlFkdTdZ?=
 =?utf-8?B?Vmx5NVZhczBiOEkzZmFtM20zQ2liYUpCV0FSbjR1dWxjMWduZUg2aStJbCtE?=
 =?utf-8?B?cmtVcktEdlMzSHFVQ0pHTWovajZIeHhxTVA3NzVYN1FjOU5oR0pLbFFZcCtn?=
 =?utf-8?B?b2FheWlldEZ6cnozdmdOUHhHWUxHZzdNZVRBUVZkRUw3MllhNk9nYjI5Nzlk?=
 =?utf-8?B?bnRybmdkQVJBMkphVmtRU2kvbTZvOGdsNllKT3VMNUVHRFdNZ1dKWVFxR3lE?=
 =?utf-8?B?eVRXVURtbXlwdTBoNkJYRnhtUjFJRGRVVnJISGZXTnFlTFUrMVkraHdNcmgx?=
 =?utf-8?B?VFF3TXcvNE5xK2xLVUNuNUtCNmhmK0duZlErTnZxdm5iK2NXdDh5N0NTQUxh?=
 =?utf-8?B?YlVhUTN6di90KzdFenk0SEVTKzRZZFgva2NYb1lBQUMwUUlMSG83TFUyVUI0?=
 =?utf-8?B?TFJONnZuMkdhUXBLc3JNZDE3TktiakUweE01M1haYXR0V1NOZ1E4czNnbmdP?=
 =?utf-8?B?c2Z0bW5sVWlqc0JDMHUyNzFkMXNKMGxwa3BXWkR2OU9ST2hLSTdBeGtXbDhS?=
 =?utf-8?B?bGVObllsdTkxZDNKR1RSK01wOVhVYk1nR2pkK0xlV0IrTkM1eEpPQWp6VWV3?=
 =?utf-8?B?ZlgzeXg0c01NM1BxSytyempPaUQxZ0w4bElSMFhPSXVJdHFERjUzZ0N6dzVu?=
 =?utf-8?B?VUFNaU9jeEd5VzN0N2JSOVBjTG5CRGRYVml3M095L1owYzNFaGMyaHBLUU1p?=
 =?utf-8?B?ZXk5NW5KTU1jTU9zZytXbEhGQzRiREkxOXBxVkFjTER6ZUEvQUYvQXhvVzFn?=
 =?utf-8?B?WmhHcHpMWS9pVWgwMlM4ZE5Ta2lnL0w0ZTNNV1d4Rmw3ZERFWlhwSWZVN3N3?=
 =?utf-8?B?L29yTDlUU2p5U3AyMW1HNnZWMVMwNUMwUWswaldzbVFwdXhzeU5Kc2V2eHRq?=
 =?utf-8?B?SEt2a0hwL0JLZTlnWmExYVdDVHk0SCtrVExGVDVPVUdVcWRVY3Ywc0xPZ0NF?=
 =?utf-8?B?eEJ5aFRNWkNQT1ZCZENKRlBjdWh5ZElXMDg2WjZlclFwZVNxdWlkUXVWZlc2?=
 =?utf-8?B?cHY1RGhzdHUzZ0tHc2FWLzJPRTNkN1drcTdqK2pvVy8rYktoaFduWDY5UURD?=
 =?utf-8?B?Y2dDRW8vZ3M1Yk1lN3MwRGZ3VDJ5RjFJckZpU0JlT085Wnk1QS9pdmlQcDFH?=
 =?utf-8?B?MTkwam5iYzJ2d0FjWE9LUTIzT0xVU1ZXWWZjMjR1ckxtTmpyc3UzRGV0Qnp3?=
 =?utf-8?B?KytYNUQ0ZVhuRWcyV3dTVFpOZm9iVlBJK1NIT0h4Q1ZXcUZKMDRwZ0ZTU0tw?=
 =?utf-8?B?d2phblh2L20xWXo2SUVPVEFrWFFGVXlHV2thRVNOSUw1OGpFRm5wRUhNamxp?=
 =?utf-8?B?Q1V1MWFsTVVCS1lVbUZBdHNMelBIUUh3TlZwNHB5QW03aysxdkdPZXhraDlG?=
 =?utf-8?B?Tm5tQ2J2SXBLVVIwaklCUmFNSWh6cVZFZWkyYWYzNDl2MDVITjZKdzJZYUlV?=
 =?utf-8?B?Y21VaTc1SVFmb0hIeFBkTkMvQTVHdVAraXpURitJMUVIcWxFL2xtRjJ0V0Vm?=
 =?utf-8?B?WkV4eElZak5LeHVxWUlxR1hlanFzSjdBd2FTVGtjbmNWVFNWU2lnM0tBNTIw?=
 =?utf-8?B?MXlSVjArUExsSm5Pc2FPeS9FdFhqQitrTjNqUTZIS2tjaHhZK05kbE8yd0hX?=
 =?utf-8?B?OVRLYVFKbGdta0t3bVlIbS9BU21kMmFDVU4vT005bFM5NVJDL016ZGl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODQrY3dUYmVUZFZ6MGZqVWVUUXkwaTBPbU81VXJ6OUZ6QmFzeTdFVWpMbzQr?=
 =?utf-8?B?M3VtZk14Y1NTN3ZpN29YSW5NSUlaNTRzL0dsSW9lamVnTGZRUjJWMUkxVUZP?=
 =?utf-8?B?eUhucEtrQ056YmFySUk4Qmp5a1BJeDg5Q0MvblZtenliNUVaNkVzTkZPalVo?=
 =?utf-8?B?SGFudU1zZ2lueVBEOHYrQS90dTJ2NDhDMlNKTlpJUmlMUlZ6dDdHOWxzc2tX?=
 =?utf-8?B?QTlYMkwrZWFHdnV3eFdleUJuQnJuN2pDUUl3U1hmRzREMTlWazBTS0k5bFRn?=
 =?utf-8?B?QTQ2OGNGZnZiSVJNUFBxSnNGZ0lYdk4xN3BpTHpvSDBOdXFtMlNqZ0EzQUxX?=
 =?utf-8?B?T012Rmt5QmJKMW5CRnFpQ1VWclFQZGJQWGJXTGtEQ0d5Q2N4UnZTczVSM2ZC?=
 =?utf-8?B?L0FGRHJJaGFLSWFTWFNBb1R2ZUpyK0syMVZNdUlmVUFjS2g1eDFIRm82Qk9M?=
 =?utf-8?B?b1lIRTQzdzNyeG1RV2VRdkV3NVlRTUJWUVkvTC93RkFjWi9GUmQ4NEdUUDJt?=
 =?utf-8?B?bmNnZHlDZDBVenlXZ0pnZUhvb1FKRTJXT0RzLzBhcC8yZ3c4QVBqYzV0NHpq?=
 =?utf-8?B?U1BMcnV5MWN2bDd5UG5teUlVa3ZiU0oyT2J3MCszTjFoRy9yWmpWdkxUWktv?=
 =?utf-8?B?ZE94eU5zcHgzQmNsdm1SbDQxa1prQnBURjMvYVV6NUcvNWt6bDhFSjVoYWEz?=
 =?utf-8?B?WnpzdUgwWWwvWW1jVjN6cS9aNU9WLzMxQkxKbWRTa0M0Y2VrMFJCbEgvN0ky?=
 =?utf-8?B?UmdFb3ExaTZwSk1UVGovLyttQ1VRaVBkM0Z5aHpaWEkzQUQvYzFubHlsK3c1?=
 =?utf-8?B?Qk5obURHcVlTbEFGRCtpMUpMeEFvd1RKdG9YZTFhTlIrZThUZjBCR3VZdFYx?=
 =?utf-8?B?dlhSMHJ6MHFUd0FldDR0QjE3MnAxWUdIR0grOTE2dlpjeCtLNVlCR1NXbWYw?=
 =?utf-8?B?Z2dsOS92YTJXN2RjenJCTFBOOUY3R1lYd3YxUk9NMGU0N0ZyWmlvU0gyL05J?=
 =?utf-8?B?L3ZGcmh2TU9UTUJFLzZJYkZSVGhnOHhGei8wL3RNQ3YrZytXTGZCdE1qWWpG?=
 =?utf-8?B?MkxaQ090WDlNYUxTaHR0ZHVwSXdxU1d2U0JFK0tteHBaMXlubDJzV0xzZXBI?=
 =?utf-8?B?ZG5SZkhRMjl6cVhxL1B3TlBxM3dTa3hXYWI5ZnhlaVh0OVNpb1NMYWR4YzU0?=
 =?utf-8?B?Si82VDlUT045T3JmMVU2SFR5TFV6UXNJcFBETVc1cERqRkR3bFBaNityR0c0?=
 =?utf-8?B?T1JyOVkzUXdXM3lpYmNxTEZ3NG1aczI1ZlR5YnNQOEZvMXp0N1JGajZMT0dQ?=
 =?utf-8?B?SjlIdHM0VUxqR2RCdlRva09XQnFxSldYT0xZb0tMc0RKcnpLSUMvYW13Qm1G?=
 =?utf-8?B?R1F5c2RXV0VHR0dtQ0xZbTA5QW9Oa09OOGFobCtJRStEclVENzNTS005UllN?=
 =?utf-8?B?dGRqWjltSVF5TDlBRm9CaEc4Q3NWNGpmUHQ4d0c5aDd4MDhZTVpDRVFBN0tB?=
 =?utf-8?B?Sm5GNE5FbUdKek04RVBteWtlOTlTdFl5TjNaSmdvZ0tZLzNRU2dTWERkK0pz?=
 =?utf-8?B?R3NIOGJITXJUaEZHVFpnMTRtM1pJSVQ1TUtkdUNzLzFhRkY4U0FxS1ZacWxG?=
 =?utf-8?B?alAwUzBYa01pVTFLTzIyR1Joc1lqOUh1cDlGS2pBcVUvM05sbS9KS1JzSjZq?=
 =?utf-8?B?cmNRZmwvY3FjVGl5MFhnVGhmYXI3UjM5Uis0MzVQNFdSRnhxYmRDbVcyUm9p?=
 =?utf-8?B?YS9PcVcwK1FUZGYwVTFhdFAxbHh5cTIyTldZVkszTU9pOEpQVWVDZXVQUEhl?=
 =?utf-8?B?T2xsSm5PSmZmVW8weFVnd1lNNTVSYm1GMnJTTHdVMWNPaisxTEpTdjQrTFBX?=
 =?utf-8?B?ZmwyV2E5b2ZyS005VEo2cGhMem1lVW01MHF5YzZ5MWxybkJwbGNzazcrNE5N?=
 =?utf-8?B?dEpXYVcyMjkyd1M3RkIyVzgrUzd5bjRtMDlZckdJSW9xRlNyWExmbmtTM3pJ?=
 =?utf-8?B?Umx5YVhTSnJEZXZNVlVyR09uVm5xN3BkdmhyNE1SVW9WdkpqNitycXJWbERY?=
 =?utf-8?B?U2tocnpiYzlTd3hUTVp3S1AyMTViZTRUL0RVb0x1RGR0RWhBTXpzNC9LeThF?=
 =?utf-8?Q?nbRqHQiQJOvdi/OYX+NSrx4fK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e047d580-6249-4bea-4165-08dcf2b6195d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 16:25:10.4945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfBrwGBsD3jw6hB/9GD5NRGev3D//9bkJB9ZAiZYAdP2L8gnRciAL/Vq3xgeCIXlVHMrX4sLWyR6OsaYH2iZXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

On 10/22/2024 11:10, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Oct 22, 2024 at 05:44:18PM +0200, Rick wrote:
>> Hi Mario,
>>
>> I apologize. I think I mixed up the versions between linux-lts and linux
>> kernel.
>>
>> linux-6.6.28-1-lts works:
>> https://gist.github.com/ricklahaye/610d137b4816370cd6c4062d391e9df5
>> linux-6.6.57-1-lts works:
>> https://gist.github.com/ricklahaye/48d5a44467fc29abe2b4fd04050309d7
>>
>> linux-6.11.4-arch2-1 doesn't work:
>> https://gist.github.com/ricklahaye/3b13a093e707acd0882203a56e184d3f
>> linux-6.11.4-arch2-1 with host_reset on 0 also doesn't work:
>> https://gist.github.com/ricklahaye/ea2f4a04f7b9bedcbcce885df09a0388
> 
> Looks like some sort of connectivity issue to me.
> 
> However, can you first drop the "pcie_aspm=force" from the command line
> and see if that has any affect. Probably does not but I suggest not to
> keep it unless you really know that you want force ASPM on all PCIe
> links (this may cause issues with some devices).
> 
> Anyways, even the working -lts ones you see the link goes down and up
> which is not expected (unless you unplugged and plugged it back). Some
> devices that are not Thunderbolt certified have this kinds of issues.
> The cable could make difference too. Is it Thunderbolt 4 cable or
> regular one?

And if it's really starting to fail consistently 6.6.29, the number of 
commits is very small, it should be a pretty quick bisect.

❯ git log --oneline v6.6.28..v6.6.29 | wc -l
158

