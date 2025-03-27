Return-Path: <stable+bounces-126846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FCBA72E5B
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 12:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7204F1892C67
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 11:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA92820FAB6;
	Thu, 27 Mar 2025 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L7j9SBn+"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C401FFC45;
	Thu, 27 Mar 2025 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073332; cv=fail; b=WTTdZ3btF6GAsPw81J6NgUodd+wFV2J2+7PjZMzNOFZe28I/HK+yhV4D+SipbE/m6v7OtNneYkjvuZtlg4IvunwDUYhHKnMFVlwaLlfZa9i64I4dv8uoKMd+HF4quRsSGyU1nyfJ4PPfhjDQP/5XLMM7sRoQ05v6TS75pRGIDDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073332; c=relaxed/simple;
	bh=W1Fj59zmgcnnJK6MAP0qgRyaMFlF6ycB+SLFZq6DVmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uIF+3Ylsls6aWUalDjs2BK8uLLX7S+91dCAK9jg5/8kPAEGF+KBwAZIxiu4d0DvbtwxQsOmkceQ8BhFvEVe4xHQfbb0b1LQiKeND8bLBp1AImwIlDgSYcuTDrnRmmP9vRgGUZhjjD3Z2XVb/czeZNYjzmHCAW6tn09C0qthpxDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L7j9SBn+; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9jNpic62HXV/bAHLSemBsEdaLNocviOUpidYn7JzahXD/HwuRUJIOStZLmueXbed3ag28msbd5msr9ImrHp/FMV2t9BsVuTXURnJAPs+My2PE0NJwD1IkBZ96gsJJPdYplLUW3UtZ1ovZPuHQoQ2o8RKZJYLwN8D8YPS7E5t25SefW2bLDLB2xu/pHVu9pyzZ8QF6bHBW53fmWKBhv7e6ns/DedB0t8dyHxgUS3IEO3dDD/ZGbGAcvFDGVibI10Vt3PrE9S2A7WJMuqT6al+haVZbTNnFt98BUxyHJSGsSU/F31vL5h3sAHBzZ8zkG/fdi1s/4rQ6HYB9GpT+p+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfE7+cotwIBvjIPQrKriVAGFcSRR3TIE5FlNScAaZz8=;
 b=W4MmMvVNmUwEUhtP2JZym3MfamU9dLV//27YiHRtu+OGYGBRuq88RQZkNnETMwJwtTFj27OiFvjAHE9Tb6bdNsQpaW23gSsFJ/xDWynZfxmxgjUxw9wP+RPh24e9eeeV1LHcCWw51625w4WMh5sNkEpX3WMPozgv6wW4DHIAB8FcPJWY0J6OEwPz95HobjAU5c/728Q+9xz1S0uevN1Red7J0b34VeMH1pGgZindsCQtKH6OsaqmUfVbGe5DcSHPz3mzkn5GXuff/QkFb76l14gHzwVg+yyWPGz4RQqwTkwsURJqz48uEBvBdO5uFWqZgvU7ETF6Irmtv420IrRAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfE7+cotwIBvjIPQrKriVAGFcSRR3TIE5FlNScAaZz8=;
 b=L7j9SBn++kNWpOUW24ZMPCVplMrfTCUiWK9S+0nasiqxv4yoRSVBtKADoqCujkj48VBd58V7faOHYYwgWB9WugHu+pAur88uZ0j/Qkf+8+fe6KHNUcnKPB+kqi0TvR0WTQ5rLTpDadPzjLMlatNdBKHEjwXszQUCxivQTmZoT6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH1PPF189669351.namprd12.prod.outlook.com (2603:10b6:61f:fc00::608) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 11:02:09 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 11:02:08 +0000
Message-ID: <d06367d4-9bbd-4a8f-a6cf-e95576aa974a@amd.com>
Date: Thu, 27 Mar 2025 16:32:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] usb: xhci: quirk for data loss in ISOC transfers
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 mathias.nyman@linux.intel.com, stable@vger.kernel.org
References: <20250326074736.1a852cbc@foxbook>
 <bb78e164-f24f-49d2-b560-24d097cb2827@amd.com>
 <20250327103443.682f4cd1@foxbook>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250327103443.682f4cd1@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::18) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH1PPF189669351:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a4a164-3a9a-42eb-16ce-08dd6d1ed148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHZiNEQvMVlpNHpXSTBUa3dDVGVsUTRMdDJjOGlzVHcycXNUc2hhZktFNklM?=
 =?utf-8?B?STFRdk8yLzBoTFhyRHFvaWtOSDJrRDAxZjV4TVdOOFR5TFZlOU5WRFRZSzN5?=
 =?utf-8?B?VTFLbG1pS2IrZllEVkR6dVh4VEFwMWdETXQyQ1hrZndvaGdNaGZkMFBGMWdZ?=
 =?utf-8?B?RS93TVJJeUFldHRSTDdkNkM1UmpmRzdzV016ZkJ6MTE0QWR0aHhJU2Nkc2Y2?=
 =?utf-8?B?QTFRa0NCN1gvK3dOZkFxYjJPZkl4MktnaWFOWFdtbjlDOGF6Zk5jVFBxejNU?=
 =?utf-8?B?a2grL2tqTGhzTWw0VkJGb1c2S2prelBnaHJEK1d0eUc2SWY4VWphY3NSeDRy?=
 =?utf-8?B?NXU3anRqdUs0VXI0Q0VxSzdHeURmRkJDL1c1c0xOYkt0U082S2xZUTdRRTls?=
 =?utf-8?B?aGJmNkhzdmc2UUhxUlYrZ0J5N2tYMEdxenE0WVhvWGxBdkdWSk83aGlGQitu?=
 =?utf-8?B?dTY5TU9wdkRzRUNxSVlDV0orRmh4TWQrUmJQK0V3T1lJYkhPTU9jTEZwVXV3?=
 =?utf-8?B?V0pUbEpFOFB6WmRUcHIxNDIxOVZvVHh5ckF5Q0UwWHRXUW90dndEcDBSQjNO?=
 =?utf-8?B?eFlzZTB6UkRYSHdJTUxIa3RvMEtiS3ZYb0kzK2tXY05jY2Z2NGJVRGZ0bzJp?=
 =?utf-8?B?YWtqSVpRbTNFenZUdDNIaklrK2FTVU5xdzJZU296UkQ1MEM3K2xkdklKTjlT?=
 =?utf-8?B?RHFMNnI1WHF2SkZiWTc5RTM0OGdqOHliVmorQ3RRVlRRaEZRWTJGbUNtU2h5?=
 =?utf-8?B?YmxRMkJTNWdxNGhnQ1o0MGhuam1HNjZ1ZERSeXFoK1RDSUhwcnBEd0JvZkcx?=
 =?utf-8?B?cmVhMWRYVysyZ0wxOXdCeXc0YXRPSkh4WnpnM21rTzNST3RaK21hOUZiWDQv?=
 =?utf-8?B?dzRna1FIQjhEbnYyc0E1dHBGVytRNzFyMUFOd0NhS2NrOUdFMmczbndRY3h5?=
 =?utf-8?B?ZStaZmM2UUs0VTZHMzZrZmJrc3VxOVpSNGRKam5xRFBnMVZJSUNHM0xlcG1I?=
 =?utf-8?B?MzJ5eXZPNGZpdjJxMitZdEZDS2h1YVd4YytBWU5CdElsNzNreDcrZjlJZjE0?=
 =?utf-8?B?bkQ3SkpXK29hMUdwYm40UDBzWUoxVU9KMXpXdlBHem9Ic3RrdGpUa0FtcCtP?=
 =?utf-8?B?MEN5cndSSmxoc2dYdGxDVEs4OXYrdUwxZy84bCtkbkxmYTdFVnNVOUFyVEtG?=
 =?utf-8?B?S2owajY1Q1Y0bzJqRFluWkYzU01XTDJyWC8vQ1dCTFR1VE5lNFNQdHFPcEJh?=
 =?utf-8?B?Tk0rcnFzL0Z3VVRJRlBNU20wTkVzdnhSME4yck5ET1RaTG96bzRCUGNmMmtC?=
 =?utf-8?B?UXFiS041RXdkeVo5bHIwVmVMTCtUSUxacmFDcVNvYXR6ZnB0d29SMFRKZnB0?=
 =?utf-8?B?WjRsZGhhOUxXS1BoUFVZcTNhenkyOGx0dXA4aEtNMFRESXRueVQvUkd3cTV2?=
 =?utf-8?B?NW5tcVNqSENxa0dnRkd1aWtoaFFhbzJJc2RRUUhDRmY1ZU40MUdZN0V0TllV?=
 =?utf-8?B?eXNsRkd4ZDRVNkZiMGw3L3dFelhFZVpXMGJJQlZnRWFvdFNpbFkvQVAvMjYz?=
 =?utf-8?B?UkhWY2ljQjBEZWxTcm1UY2FBdGxsa3hlYU5zU1Z4bkNYQll2bVhaT3hYWFc4?=
 =?utf-8?B?ZUU0R3QzUVB2RVd5QjR4Q1lHNHh0VTF4bC8wRmR6dlcvSmVqVk13ZFZ6REwz?=
 =?utf-8?B?S2EyTFRIdEhVUzRJZG5XR3ZwTDdqV3lRMlNWUmRrUnZVMWtKUUN6MUJHZUQ2?=
 =?utf-8?B?d25ZZm12NFloZVJKWVJVeUJFYUZnY0hkOU1VbGplMXhxblB4MHQ5Y2dBVVdo?=
 =?utf-8?B?V1BzeFJIT2FZVWtkYUQ5a3ROaVM2MTJQNG1BbWZvK1pEUHlRK0VFUkYwTnhH?=
 =?utf-8?Q?HWtWpxet2NasP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXZiZTZaRnNIbHB3YmNHNi8ybGhIOERkbkhlZnlnWExNb3lUNHprZnlIY21r?=
 =?utf-8?B?dmxlekJYVmkyeHhmR0d1Y2QrSmlyd0t2NzNXM0NBQm43SGtiSUJCVXdIZnEy?=
 =?utf-8?B?SUFWTGhlNVpsMzU4Nm54Y1pWR0JDYXp5RUNWekgrRVNrZ2RpRlZ3Y0RZSXYz?=
 =?utf-8?B?T0VOOURFZUhNcW9IUEhzVUdmcjRkSEhBd1dlT01aZ0hSTHMxTUh3VTJNM2xW?=
 =?utf-8?B?Qk9BWXZXeDB5UkIzOTNBUkVhNFZXaGs2UTRhUTBsTi9ZdGNxRklpTHRRRVVj?=
 =?utf-8?B?WXphMnBUVmk3SHJKMVR5MEliRGF3TWUxd1MzTFlwaUtkUjVRSWkzUFcxUThH?=
 =?utf-8?B?dEh6VzBDZE1qa0xvK3lYbUd6YXRJRko1ZjBqc3ZBN3ZHcDhIVFZBdnNweE1V?=
 =?utf-8?B?NDM3S1MwbkpQS01tcVFLVEFNY3BNVzRmeVJaWnVRc3pDOFVpUzN6ejdVVEpL?=
 =?utf-8?B?czJzcmlWOVorZ1pxakZmSEdMbE5hdHRlSEVwR29wdTVzWHh0QVNMMldicmdn?=
 =?utf-8?B?ZG5oc3ZrUXg0NnRKK1REcFpCcTNCNlMyZkdBQVFTTEEydE5rMHZ4Tit1djY0?=
 =?utf-8?B?NytOMnArY090a0dkWGRhbS8zOXVpTmJZR1Fud0VYVmlwVGJsWDJnTS9IYjJm?=
 =?utf-8?B?NVhNWVlJaHd5a2FtemFLTitvSjBTNEkrR0FDVCttdU90UW9mK05DOFlYNWpT?=
 =?utf-8?B?bW1FL0FCTGZ2ZjUwaXRiZEsydUJtOGs4Y0l5dkdyUkZzYjdabnkvWXlqZDVZ?=
 =?utf-8?B?WVdPTlVOWENWL0E0d0pNclJ3ZHlhOW45YWNrMFFnUGtXZC9Ka0ZlQnhnbkhQ?=
 =?utf-8?B?dDBZbnhlYU1hbnFmMWlleW8wcVl0dHdGeUhjbmpSdnkxYXpkWWVLdnlhUTJq?=
 =?utf-8?B?RFh1SUk3ZUdCT2dQM3VIZDBNbjQrZEUvR24xYnRNVVZ4R0hSK1crR3IrazR3?=
 =?utf-8?B?VTBaZWFhbXhaNktjc3BJUmhIVlF4SnFFM2l0SWhaNlBmMGlDSTE2SDBDSGht?=
 =?utf-8?B?OGpyY2kvaEFZUDRqbWZsczdMNDdUNC9CWG10RkYyNnRucHBxT0c5Q1hha3l5?=
 =?utf-8?B?aVJQbUgxRlBHcVZQR0JSL2xBQWRxVFZaNkJJcVhiUFFwaXFHcEE2eE5qWUpB?=
 =?utf-8?B?RW9aSTQwZnloUHd1cHUzelJQMkp0TnJLS0cwLzFYcFBzRnhYSzJ3ajYxOWg2?=
 =?utf-8?B?NXgvOHFYMjJRMzRsdVpqR1hmZnc5dG8vWkVuQ0FmRXpzdHZlM1BaRWNlOFVK?=
 =?utf-8?B?UVIzZGJNNFU4dlI1dWh3QnE1MzQ0TThzdWQ3U1hNTmY1dmkxRnZhVVhvTlVx?=
 =?utf-8?B?c0FkM2h4Y2R3cjFVVUI3dWNqV1BZWTN6anpSMk5aK3hCWmdvTEc1Rjg3dWNR?=
 =?utf-8?B?MEpmTUIxYkpoWm1oaWtvZ1IvOWVSQ3lIMkJDY09lK2RkZURzOW9NYnhQRzdR?=
 =?utf-8?B?Y0hmTHdPdWdkRXVnaXExMnlpcUR0SDJWR1JHVjA4WmVLYks4MXNmekhOL2Yv?=
 =?utf-8?B?WGJtRVlHcHhjeW8raU5JQ0huaDZxdTBuRzJ3a0pieEhZbnU4czlYNlYxdDNr?=
 =?utf-8?B?Y2Y3bUxFWVMrbWcwczk2MkNzQm9YSDF1V3JicTBFT3dJSVNYRTVobFh0NnY5?=
 =?utf-8?B?d05TbmdiWFNtSXBmRHYyc3NtYVNnVUZFcWc2U09FSStoTUV6OUs5RWRmRzA4?=
 =?utf-8?B?NGdzSnhMRVpFYUpHRDMvWXR2SUFjVXRuVzBOb3Uwb080N2ZrN2FYUWZsUkFG?=
 =?utf-8?B?SDU3QlJ0eFIveVgvWTFIZTdZb1oyT3Y0Q29mRHJzUWFIWkpwUzE0ZnVoT1VE?=
 =?utf-8?B?d3hjYStIQjVhYzFvVmhxVGQrMWp2M05mWjhlMWl0YjJkZjlYT2VOdEh3Q1l5?=
 =?utf-8?B?c1N3U3RFMTA4Qys1NDhBTzBnYXY1Q2RnQ0k4cXlVTXR3bm5lYWhKbUlzUEp0?=
 =?utf-8?B?bW5GdlBYZGh5bmFnNkJucklVQ0ZwVHdZMGhwR3Y5aFN5dG8rRm80a3JOamdm?=
 =?utf-8?B?amNvcjhqM3FSOEFRR05JcFVHKzN6c2J1aXhuVHc0WHJxYTdHL1BlME9LK2V5?=
 =?utf-8?B?R2F4cFl3UjZuQWp4NVFlaW50K2tndmhXeG0vdHppVjloRXJ3NEtKSERpOUpI?=
 =?utf-8?Q?iWTFEHmCXQ2Fsouen5NWmNtgP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a4a164-3a9a-42eb-16ce-08dd6d1ed148
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 11:02:08.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ce0/BrIPYdtnivOD4ZqP+axpW6c62mVjRhJCuxZgEOZe7gp34CjpB9ElfuHo+/XbDL97dvC9C7xLAQEJiwGzMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF189669351



On 3/27/2025 3:04 PM, Michał Pecio wrote:
> On Thu, 27 Mar 2025 12:08:53 +0530, Rangoju, Raju wrote:
>>> What if there is an ISOC IN endpoint with 64ms ESIT? I haven't yet
>>> seen such a slow isoc endpoint, but I think they are allowed by the
>>> spec. Your changelog suggests any periodic IN endpoint can trigger
>>> this bug.
>>
>> If such an endpoint is implemented, it could theoretically contribute
>> to scheduling conflicts similar to those caused by INT endpoints in
>> this context. However, our observations and testing on affected
>> platforms primarily involved periodic IN endpoints with service
>> intervals greater than 32ms interfering with ISOC OUT endpoints.
> 
> In such case it would make sense to drop the check for
> usb_endpoint_xfer_int(&ep->desc)
> and rely on existing (xfer_int || xfer_isoc) in the outer 'if'.
>

Got it. I'll address this in subsequent patch.

>> I'm not completely sure about this corner case if HS OUT endpoints
>> can inadvertently get affected when co-existing with long-interval
>> LS/FS IN endpoints. Our IP vendor confirmed that LS/FS devices are
>> not affected.
> 
> There is also a third case of a FS device behind an external HS hub.
> The device will look like FS to this code here, but the xHC will need
> to schedule HS transactions to service it.

In that case, the original code I provided in this patch doesn't include 
a check for 'udev->speed' and is applicable to FS devices as well. I 
think this code should remain unchanged to properly address the third 
scenario you mentioned.

> 
> Regards,
> Michal


