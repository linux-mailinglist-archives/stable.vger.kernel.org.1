Return-Path: <stable+bounces-121683-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630B2A590D1
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F7F188D453
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7223221F12;
	Mon, 10 Mar 2025 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TH6qeWlq"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E331B0F32
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741601604; cv=fail; b=XCGzfn4ooQn6ax7qnJD6xtHsdVFP7bybfZ0vc2J1kyCzyguiEbPR8blB/ZMmBUsXnPBqpd9wZeoQR0KPwdqtTWD3y8reXx7TENU8l6Mlsqbk8Bxj7IGxe6+azyAygpryjUeKZzlqNN8FgAJutBzPx4T71B6brU2qUdnrOzG7/Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741601604; c=relaxed/simple;
	bh=QbfSIyk/fn67mSlsg3UW3rc4CJxK3mxgQZdjU6bRJbo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WhXoMTClh7COQ1Uk6oBiNT8Qa+ALjZqZa/tcugUo5g1SJ8OVIOxKMFwnM6AJnJEVGxiLshQKOSdZGe6i1nPMZQTdwwnxzZiq6M54kO50vUumVSymTVIaxoge+Wo0Nn1pb/YN0/Fao/p+6yuwZk+vX9zuM9D0ZpljWnfAC1HIs14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TH6qeWlq; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jc2SUP9KvM5U8XHq6ZKPHdm/gbo+JBHFT163DnBn9TRhHU5E6lNiv5/HtwDW03EOazMbuUl0j0srpOK1dVNr//BEvGJ9Cji9nwbWwOx1idOEbBvNWQJf9VKZ0Gs9WhyH2TEwP3n32nE2CnqxkNHHU8mZtiXiLyyRZdIX0GRzesnWt4BbCtRFSx3uZrDcmzmuKrwGFuSbbPcseFVb/Ymyn+IFmGif4A0QxKLpl61OIuYIKuQBI91uE7l8X1bYUOdA9GuoXKXWx1q8wN5y8QYCig25euGgMm5lBb7nMBdCdewcNIFCDcywPD4h9W08xgCPB7yW+oEZ8DW5YAscDO++tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DWQIZMqzn5j8TZyQsSGhnWMC+mxS0hjMFSJQLElPbc=;
 b=CSv2lCrIKkQ/NDC9bQc2yG0ITByOK6AdR+Ypgv8l3J+aIbRVJxNMdmWr62bzWLH2290EM+/nPf5uRxnPXjQfjU+EPw7wCT/vPHo/nHao5d/o8obR1hj2VHLAfCEDtUFoQDfeyH2K4SAiyd4OE9qtcbY4YTgtUkbf0d9HXVvGZuLITMUHAX0YgIyHAUQChzmwkUXb5n+VazdF+6/7i0fDtKctjq6FQxg9PM6eSzCORg4wCt+y4DjohZ6Udh5gUvIdTthfyG1dTPJfBOfzBuDKjyYOC8ewa5Ma+MGXBfxLyrRiVt+P6trXFKEYxp1rGskHp9AB+gCm7ly2HPCG17oipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DWQIZMqzn5j8TZyQsSGhnWMC+mxS0hjMFSJQLElPbc=;
 b=TH6qeWlq1VBY2Gff3IXOQ6vD7nzRMRRDBD4ZD0v0hmvd05ov5zaCACddM8+3wWuZ1Kbz9QPqYZ5tZ9mldiDue+zaKRFsf1f/b+w4zDg1jTOtWT8nRkbADHZbAAWQoBb/4hxOmBsPGJ8JLVxVNQlKIWmqxTUzHC6uMFe3F+JALlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:13:18 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 10:13:17 +0000
Message-ID: <da8e554d-12b2-4e22-a76d-7ddd8cc8a8a6@amd.com>
Date: Mon, 10 Mar 2025 21:13:11 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data pages
 handling under snp_cmd_mutex
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Nikunj A Dadhania <nikunj@amd.com>
References: <2025030957-magnetism-lustily-55d9@gregkh>
 <20250310100027.1228858-1-aik@amd.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250310100027.1228858-1-aik@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVPR01CA0047.ausprd01.prod.outlook.com
 (2603:10c6:220:1fd::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de75165-c6fd-4bc6-204e-08dd5fbc2d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXcxV3lvY1lIdlU5aDZvZkRZV2U3NXhocjh6YlgxckZ6OVI1OGtwcU5YM1Jw?=
 =?utf-8?B?Z2t5cnJwOUhhczY2ODgzaEdONnF1THFEZm1UY2VSRmZpZ01mUXc4eVo0eS9n?=
 =?utf-8?B?TGkwU3hkdmxVZEVOcmVTR0VuN0VXcXBvWXlCNm9xYjRxZ3dWQ0l3Wi9IZUll?=
 =?utf-8?B?U2Ixbmc4b0VyRytKc0g5R1hrdXB5ZFdmYTdtYnJ0ejNyZWx4YlJiYU15aCtN?=
 =?utf-8?B?KzJqd0dNa01zUkt0b1JXczNOOVIwVWdBK0NlaDFMd1lFU2E2UnY2TUFkZWdQ?=
 =?utf-8?B?QWdET2V1NVF0OTdXRkpXM01EN1lwZ1hDeE1KRlBCNklPMko0SXkxRU9XeWRD?=
 =?utf-8?B?Q3p3Nnd5Ty9qVUoyYU5MREV0TE4vN0EvS2RBWDJES2duQit1ZGUvZnN2V3hS?=
 =?utf-8?B?U1lEOFpqTmw1MWdUUndIcUxhSVdnTWErMStOUEtiVitiU0FPa0l6RXhzTllU?=
 =?utf-8?B?cHhmSC9Bbm9rZmlVNmdESUZqdmdZWFozbDBXdDNtZDZWWms5UTc5Wi9vRC9j?=
 =?utf-8?B?VzlGc1c0bktTU1VwaDNNek9YayttUDBvc1FBM3BHVHU2ZUpXYndlU3N2WVhl?=
 =?utf-8?B?REJjaElTTnNEajhUUVFEL01WTm00YXpEMWZ5bUJZbzZzNW1sOEU4cXdha3Iy?=
 =?utf-8?B?NGFxZE9SaytUMzhQbWVnM2dsYzRqU0NBdFhNTjlmZmF2bzFpZ3Q4aW92VjZr?=
 =?utf-8?B?WnQ4M3NHam9kT1VzYjJQSUdWanhpSkpxRXdDOTFxaVcyUnNCcDVqZXhqeDMr?=
 =?utf-8?B?UzR1YVA1Mlo0Z29lY0Q2WnpsMGFlcHhGU2tGZm9WV0RvSXlBNXFKUm1OQllR?=
 =?utf-8?B?ZjFwQ1dkN3E4dVBBQTJPOHQ3eXhucnpOZUZhN1haRXBvUWRPR3dXRDBpRDgx?=
 =?utf-8?B?KzArVnpiVlRqMkpsc2E1QTdOeGY1RjNWNUxNSkdneWtOTkdjdVJ4YSt0RW4w?=
 =?utf-8?B?NDk5Q05xMFNWNFE0ZTNDcExuRURlL05EWGtaeFRoR3dtWUNrMlAwWFc3ZEUr?=
 =?utf-8?B?eWZYNytjc3ZMQzZnMjVaOFhVS0VOdnVtZWpHYkQzQ2JlRVZhTUNYclNSL3Z2?=
 =?utf-8?B?WVFUdWhiM1hCdGdrM3dQSW9pNVo3eXFBT3RJdnM1U09IU1RMNEppM2RqMXdN?=
 =?utf-8?B?TTVTdFNiUjVzNDlJUVY2L0F3VE9yZ1lJeWxCUzlocFFmdWwrZVhya2tGZDNM?=
 =?utf-8?B?cEM5Q2F1M0NrZ3ZDQUlWd2czYXFOc1Yxam01aTN2ZXhTb0tCRGtWanFoUXNn?=
 =?utf-8?B?MFE2RXdzaDNxQ3VjNlhoSGVHenhuczBEeDl0eE1OQ01SdlRQUHBocnpuUi9N?=
 =?utf-8?B?eVo0ZG8xMnQ1dnVKTEp6UlNLWlRaeEZoMTY3K2F3V3ZzL2dBRno3RU9CV1RV?=
 =?utf-8?B?NnRyNzlpdzZmNEd2RWdJNElxWTQyQzVPN0g5V3FsMkdoaTlVUVQwRjVNVWpq?=
 =?utf-8?B?dENUeUJMNXVDMGxydjFTYi94bzhNUEN0ZUtpWDlhcTV5eGtUczllcXB6b0Rw?=
 =?utf-8?B?Qjh3QkJLQ3UrcUdqazNZNGRHdTcyWnhnUEszUzdKUndoMjVxRVNBQk83VDMy?=
 =?utf-8?B?ZnY0T3RLakx2b000d3hab2kvc2gxWmlqMTdsb2MzbGVxUE9jRVZ6S25mcmlE?=
 =?utf-8?B?Y2FUK0piV3dMSmQ3TlJPNmhpM0FYQTk1OUVxT1A0U3hTdTBHVkpEM212em9u?=
 =?utf-8?B?TUpaZGdWYkZOYWx3WTdUWnFmN0J3WXY0bU9ZSDFlR3FWVGRBT1pQQUJrVmR6?=
 =?utf-8?B?Nnh6MDhUWkZlUE1qY25lZ0dFSk9LaFhGS0VWTEVES20vRHlxOWhYZy9xNDJN?=
 =?utf-8?B?ajJFM3FSYjRhVXF2V1A2akVVN3k2RVc5a0diYW5xN043YzdHRGZ1L2RiNE8r?=
 =?utf-8?Q?OER+WjHG6tAgx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUw4VXB3Tml5RHNoUFZSSmlFN3FwUWdPMWpYK283YUMwcm5abC8xdHNRVDNO?=
 =?utf-8?B?aHl6NVpKNHpPOG81U0pDck1GZ3d6dGVLRXhkaFlnVXo4eG5zVVdydUlaM2J6?=
 =?utf-8?B?M05mcEYvclBqMGg2S0RnV1FleGZ0N2pMMlFVSnhTSTgrcTZFMFM2OGdCMEc0?=
 =?utf-8?B?b3FIaDFRTDgzNWFTVUgwOTdpUUpmeUdRbGNRcUl0YjdLOENkMEQ1WExTZGRZ?=
 =?utf-8?B?WmIwdHJqMi9iTGYwckRmTEVkeHJSZ2xmQUp6TXdldDNvY2h4UUh2d0FBZ3RF?=
 =?utf-8?B?Ty81Y0hzd1hRbHZoYTU3OW1nclUxSE1lM29yVEtyQnF5U2pQMlc5L0c0RXZs?=
 =?utf-8?B?VEhrTUhRTVB3cForWXdidnQrM2k5OGQxelR0K3E3WWRFdUNsS000ZzluaDNI?=
 =?utf-8?B?dFQzdXFuTXVyV2c5bktzaFBseGc0b0FRZFc0RmgwcytjK1hVRmtiZUVRQkdo?=
 =?utf-8?B?WjJzdnUxSmlCSTNHQ3JCV293NzlxMlhDUmdUK0c5L0RNaDBZWG0rVVo2WlY4?=
 =?utf-8?B?RDZnSU0xTHlwdWRwY01kQTB5R2RaQUJVN1F6Nm1ScVNDRUxmdmlhMjRBNmVT?=
 =?utf-8?B?aDVrcXJMNjkxNTlGeTJrRkJid0FETE80ZkJ3bWx0R21ySDF3TTNjdnZuSCtr?=
 =?utf-8?B?aTYzaGhZZWoyd3U1RkNaTENaU29LdnlzUmpROFNUY0owY25iUE5RbHZUNXh4?=
 =?utf-8?B?Z3hORFg4TjExUTRkVlIvSWRZVExCS0p5dEw3eDdEaHNzVWhLUkl3V2tOUGJS?=
 =?utf-8?B?WWR0cDcrRmdJT3Y3ZU5zNk1sSW5sZEJmZVBIQ2QzOG52d3hhc0xNMlRZZzdY?=
 =?utf-8?B?ME9KSlBYdlJTMU8zdVRxVGVLN3h6WU01cnRYdEZmTFFJRzBzV3pTU1l3cERZ?=
 =?utf-8?B?ZEV6Tks1Q2tVYzdpV21RUVNVWElGU2VYOW5KbjRibVJvSGl4UDA2ZUpJT2My?=
 =?utf-8?B?MUhlVHE1LzdPRXQ0UGdFdXpNbzZOMklIMkk0N200SFAzMm00a2NOWEROM3Ja?=
 =?utf-8?B?SmVBL1VHTG13eGYzNWVRSTE2Z0I2UzlxOXh2cnRKTk1YaGxxQzdXdTNDcXFh?=
 =?utf-8?B?WU43em5FSlUxK293UXF0Y0dJbmZYUUJPeUtvNEhvVTVrQ2xDeWFsNzRwcVd6?=
 =?utf-8?B?NVFPNWZDVUJvd0hTSmg0a1A4cjZjeTR3NGNCTityTkdyNjllRGlydzZRR0o3?=
 =?utf-8?B?MmNUeFUxd2RXK0EyK09idkpRSko4SnFMcWVjVTVWNWw1b2NOOS8zcmdpUXcx?=
 =?utf-8?B?ZFczSGMyamd1M25MRW9wNWxORVRxVzZybUlXMUlySDdNdEw1VjJCVWN6ejNp?=
 =?utf-8?B?OUNUbW5nVjZJK1pDeXA4blhiNS9XUmExaHlubHhuYmVOb0QrNmx2MnJIVnpv?=
 =?utf-8?B?cDB4cDJvRmplcjdUdWxuc2hjSlZLZUE0UE5iWnJpTG5oa3Vra1J4R3NaejEv?=
 =?utf-8?B?SzZORXFPYk1jMUE3bE5DRnZaeUtNTW9MS29BNFduRTN6WmVxVGVwZVRsNkhI?=
 =?utf-8?B?SHpScGJoellCc2VpZUhUSDRjT3cwRld3STFYVEkzV2ZDTktybjNpUVFnaXBp?=
 =?utf-8?B?Ynk0MVhjRVdwb1NrQzVDZTE5ZURzRXM0dWFuN0F2alRPRUE0M2xoQktxKzMv?=
 =?utf-8?B?Y2Z1YVpMaDVRWW5xWVBpVlhMUkZmMXNDQTN5L0RzaVcrdGhKcHFnL1E5a3Jv?=
 =?utf-8?B?dHFBS0NVY2w3NXA5b0JQNDR0UVdYQXVPRUptYjlMcXhJdU95QmV6bmh3R05y?=
 =?utf-8?B?VnBZUXhjN0tKQm9laXBJNzZxUFVrdzdEQm1mTnBoUk85YlFrVzNjck0rOG8z?=
 =?utf-8?B?UzZiZ3I3dk5XeGdiUSs4WnJuVHY2V1lwOW5BeitaTUR3ZGwxOUtGRGFWb0tJ?=
 =?utf-8?B?QVJYdmR4czk3bU1TRkFoZUc3ejBVYlpzVVJ1QkNxalZBczFMSHJXK0EydkN5?=
 =?utf-8?B?WmZoaW43Qzc3R2FPcEVCQzZ6dE4rMHJaMWhYaTduSFhUNGJ2WVJCREVGbEo4?=
 =?utf-8?B?ejhhL3lPWEp0N3Y4a0NQVjFCQkpuajVXZnVhNyswNmY3cnFOYVl6MWFxRG9j?=
 =?utf-8?B?eU9uZ3JvUUZ5b2FTSkZPNFkySDVNdnlTSElHN2hRdE1PSlh3cUhXUXFYVnRV?=
 =?utf-8?Q?xiVRhcYopitLk65zwsuJxLGyG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de75165-c6fd-4bc6-204e-08dd5fbc2d4e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:13:17.6906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKRar0Jvqd2DxX3lxtCtVACgTwxBbNTta7VTSp/JbFdzKWoVlcW2ryIJ0uKV89tDQUEcoMFJkhD/09lbJobP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725



On 10/3/25 21:00, Alexey Kardashevskiy wrote:
> Compared to the SNP Guest Request, the "Extended" version adds data pages
> for receiving certificates. If not enough pages provided, the HV can
> report to the VM how much is needed so the VM can reallocate and repeat.
> 
> Commit ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command
> mutex") moved handling of the allocated/desired pages number out of scope
> of said mutex and create a possibility for a race (multiple instances
> trying to trigger Extended request in a VM) as there is just one instance
> of snp_msg_desc per /dev/sev-guest and no locking other than snp_cmd_mutex.
> 
> Fix the issue by moving the data blob/size and the GHCB input struct
> (snp_req_data) into snp_guest_req which is allocated on stack now
> and accessed by the GHCB caller under that mutex.
> 
> Stop allocating SEV_FW_BLOB_MAX_SIZE in snp_msg_alloc() as only one of
> four callers needs it. Free the received blob in get_ext_report() right
> after it is copied to the userspace. Possible future users of
> snp_send_guest_request() are likely to have different ideas about
> the buffer size anyways.
> 
> Fixes: ae596615d93d ("virt: sev-guest: Reduce the scope of SNP command mutex")
> Cc: stable@vger.kernel.org # 6.13
> Cc: Nikunj A Dadhania <nikunj@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

Missed:

(cherry picked from commit 3e385c0d6ce88ac9916dcf84267bd5855d830748)

I first cherrypicked and sent, then I read about "cherry-oick -x", sorry 
for the noise. thanks,


> ---
>   arch/x86/include/asm/sev.h              |  6 +--
>   drivers/virt/coco/sev-guest/sev-guest.c | 63 +++++++++++++++----------
>   2 files changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index 91f08af31078..82d9250aac34 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -185,6 +185,9 @@ struct snp_guest_req {
>   	unsigned int vmpck_id;
>   	u8 msg_version;
>   	u8 msg_type;
> +
> +	struct snp_req_data input;
> +	void *certs_data;
>   };
>   
>   /*
> @@ -245,9 +248,6 @@ struct snp_msg_desc {
>   	struct snp_guest_msg secret_request, secret_response;
>   
>   	struct snp_secrets_page *secrets;
> -	struct snp_req_data input;
> -
> -	void *certs_data;
>   
>   	struct aesgcm_ctx *ctx;
>   
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index af64e6191f74..480159606434 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -249,7 +249,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>   	 * sequence number must be incremented or the VMPCK must be deleted to
>   	 * prevent reuse of the IV.
>   	 */
> -	rc = snp_issue_guest_request(req, &mdesc->input, rio);
> +	rc = snp_issue_guest_request(req, &req->input, rio);
>   	switch (rc) {
>   	case -ENOSPC:
>   		/*
> @@ -259,7 +259,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>   		 * order to increment the sequence number and thus avoid
>   		 * IV reuse.
>   		 */
> -		override_npages = mdesc->input.data_npages;
> +		override_npages = req->input.data_npages;
>   		req->exit_code	= SVM_VMGEXIT_GUEST_REQUEST;
>   
>   		/*
> @@ -315,7 +315,7 @@ static int __handle_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>   	}
>   
>   	if (override_npages)
> -		mdesc->input.data_npages = override_npages;
> +		req->input.data_npages = override_npages;
>   
>   	return rc;
>   }
> @@ -354,6 +354,11 @@ static int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_r
>   	memcpy(mdesc->request, &mdesc->secret_request,
>   	       sizeof(mdesc->secret_request));
>   
> +	/* initial the input address for guest request */
> +	req->input.req_gpa = __pa(mdesc->request);
> +	req->input.resp_gpa = __pa(mdesc->response);
> +	req->input.data_gpa = req->certs_data ? __pa(req->certs_data) : 0;
> +
>   	rc = __handle_guest_request(mdesc, req, rio);
>   	if (rc) {
>   		if (rc == -EIO &&
> @@ -495,6 +500,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	struct snp_guest_req req = {};
>   	int ret, npages = 0, resp_len;
>   	sockptr_t certs_address;
> +	struct page *page;
>   
>   	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
>   		return -EINVAL;
> @@ -528,8 +534,20 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	 * the host. If host does not supply any certs in it, then copy
>   	 * zeros to indicate that certificate data was not provided.
>   	 */
> -	memset(mdesc->certs_data, 0, report_req->certs_len);
>   	npages = report_req->certs_len >> PAGE_SHIFT;
> +	page = alloc_pages(GFP_KERNEL_ACCOUNT | __GFP_ZERO,
> +			   get_order(report_req->certs_len));
> +	if (!page)
> +		return -ENOMEM;
> +
> +	req.certs_data = page_address(page);
> +	ret = set_memory_decrypted((unsigned long)req.certs_data, npages);
> +	if (ret) {
> +		pr_err("failed to mark page shared, ret=%d\n", ret);
> +		__free_pages(page, get_order(report_req->certs_len));
> +		return -EFAULT;
> +	}
> +
>   cmd:
>   	/*
>   	 * The intermediate response buffer is used while decrypting the
> @@ -538,10 +556,12 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	 */
>   	resp_len = sizeof(report_resp->data) + mdesc->ctx->authsize;
>   	report_resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
> -	if (!report_resp)
> -		return -ENOMEM;
> +	if (!report_resp) {
> +		ret = -ENOMEM;
> +		goto e_free_data;
> +	}
>   
> -	mdesc->input.data_npages = npages;
> +	req.input.data_npages = npages;
>   
>   	req.msg_version = arg->msg_version;
>   	req.msg_type = SNP_MSG_REPORT_REQ;
> @@ -556,7 +576,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   
>   	/* If certs length is invalid then copy the returned length */
>   	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
> -		report_req->certs_len = mdesc->input.data_npages << PAGE_SHIFT;
> +		report_req->certs_len = req.input.data_npages << PAGE_SHIFT;
>   
>   		if (copy_to_sockptr(io->req_data, report_req, sizeof(*report_req)))
>   			ret = -EFAULT;
> @@ -565,7 +585,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	if (ret)
>   		goto e_free;
>   
> -	if (npages && copy_to_sockptr(certs_address, mdesc->certs_data, report_req->certs_len)) {
> +	if (npages && copy_to_sockptr(certs_address, req.certs_data, report_req->certs_len)) {
>   		ret = -EFAULT;
>   		goto e_free;
>   	}
> @@ -575,6 +595,13 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   
>   e_free:
>   	kfree(report_resp);
> +e_free_data:
> +	if (npages) {
> +		if (set_memory_encrypted((unsigned long)req.certs_data, npages))
> +			WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
> +		else
> +			__free_pages(page, get_order(report_req->certs_len));
> +	}
>   	return ret;
>   }
>   
> @@ -1048,35 +1075,26 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   	if (!mdesc->response)
>   		goto e_free_request;
>   
> -	mdesc->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
> -	if (!mdesc->certs_data)
> -		goto e_free_response;
> -
>   	ret = -EIO;
>   	mdesc->ctx = snp_init_crypto(mdesc->vmpck, VMPCK_KEY_LEN);
>   	if (!mdesc->ctx)
> -		goto e_free_cert_data;
> +		goto e_free_response;
>   
>   	misc = &snp_dev->misc;
>   	misc->minor = MISC_DYNAMIC_MINOR;
>   	misc->name = DEVICE_NAME;
>   	misc->fops = &snp_guest_fops;
>   
> -	/* Initialize the input addresses for guest request */
> -	mdesc->input.req_gpa = __pa(mdesc->request);
> -	mdesc->input.resp_gpa = __pa(mdesc->response);
> -	mdesc->input.data_gpa = __pa(mdesc->certs_data);
> -
>   	/* Set the privlevel_floor attribute based on the vmpck_id */
>   	sev_tsm_ops.privlevel_floor = vmpck_id;
>   
>   	ret = tsm_register(&sev_tsm_ops, snp_dev);
>   	if (ret)
> -		goto e_free_cert_data;
> +		goto e_free_response;
>   
>   	ret = devm_add_action_or_reset(&pdev->dev, unregister_sev_tsm, NULL);
>   	if (ret)
> -		goto e_free_cert_data;
> +		goto e_free_response;
>   
>   	ret =  misc_register(misc);
>   	if (ret)
> @@ -1088,8 +1106,6 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   
>   e_free_ctx:
>   	kfree(mdesc->ctx);
> -e_free_cert_data:
> -	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
>   e_free_response:
>   	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
>   e_free_request:
> @@ -1104,7 +1120,6 @@ static void __exit sev_guest_remove(struct platform_device *pdev)
>   	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
>   	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
>   
> -	free_shared_pages(mdesc->certs_data, SEV_FW_BLOB_MAX_SIZE);
>   	free_shared_pages(mdesc->response, sizeof(struct snp_guest_msg));
>   	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
>   	kfree(mdesc->ctx);

-- 
Alexey


