Return-Path: <stable+bounces-136577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C52A9AE13
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8859A4A0C61
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7705B27B51E;
	Thu, 24 Apr 2025 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T/8jLW5F"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1B27B51C;
	Thu, 24 Apr 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499429; cv=fail; b=lgGkv99cF42s2JJllFoE5HQHzHzGtFEfTBIk+zvV6bwtlkIHA8IIsKaBJ9n08Lgw4z1mrknfmz3H9Nf7mcTorsLK2E8rmWazjAv532cFODntFdlqpbr88p+vwGXxezkEYcbGdHslQ0713OP8Y98xvpR7zM8PuNMurWVscO1VlUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499429; c=relaxed/simple;
	bh=ckjS3sYhxiV2mrfOON4sOzMJRIoMBas2QBFFnaaQAb0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=f0GLt5IN6ZqxTSulT+9lYclH53rX47/gZOdxutpis/TUkdzAMyg9uO1uS/0VusfGDsWzUEPTZRtga0dvABLd0mKy5VJc67XjMdmJ4gtrNmFus3Mhq7HNhR11bZScHWKgp8WYuyKOT38iOtuC8m0fwMAIZVPDe1nT+LBh9akRlwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T/8jLW5F; arc=fail smtp.client-ip=40.107.94.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTU1T+pVk9J/cUIGu9OVIaX+kDAq5yLaUrkL3DHRLQVdxwjL1K3C+QAEyfvDU/n5T9Ha5zS4k2yVmfzKWEXLvo6Fbsg7DzVfNj9PHYafnTUXdWzKMPwbHZHJsHDKR8p76KvD/Tql7F/XqZ/tGFpnCwd3GjuGnAec4Ys5RC0jpD0oBUWaYLZpLxhqYoq/HFpr7nbZcEfPw/9Qba4IEQijDR0mJ6S5KgEpudZpPX6t86GPFhDhzPA8vIcZe2OZvbQeWXRPW9CyvHStgTCM/q0wUWPjh2qRdsRS/wt8ii6XetidSdbNLEJ2AOrM4v/1AmTDMogDuVvkDUg8L6agRhTIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRXvnMPOt7Yl2JchPyI6ub5zulWW6JDNX0ggLzGNv/8=;
 b=NB96s9c8R0xpGRb1ksbLvuLd4uQQK9Di5jd71UJVv2b4Nww6gbHDhS4gZhY4oFAy8SsPAtS4JLeujkIWXDtPvD1I//tliKg9u4IWUWUiNQN6GR00U8ZXpCu/Xyh+q68cMas70A0DQ5Dymyw3iqPqrafmUIpm4ELOy829ZIlhGNtR2IEhwI9BjzomWiIupkh3DAACkNU4HsNucWTUrKU+Lr5Nw91svilVoxTrifBbN/5h+Cqdydb1WDFO/iDS6ju5ncxFvHG8w76QyK0rTFlRHm9OimvzI+GX/WmEs5roJAKrgtUN4qcHRuD/L2af/LRD4yhM15f4/BVBbHE23w4Xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRXvnMPOt7Yl2JchPyI6ub5zulWW6JDNX0ggLzGNv/8=;
 b=T/8jLW5FoTGrJ/jft14UkoKl3Fdhy4YN8jsaYCPi39stCN9QLS2oSU6GBvhQZ42V6Me4KiG1S891X8Xxm4IrPMmL41MSkVZofn72YU6oM8/b2/DlrUtgv6xves9wUXnGjwlmwUi55ZS84c+vLvWThkmWS/WAk+X9JSgn11edR30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13)
 by CYYPR12MB8656.namprd12.prod.outlook.com (2603:10b6:930:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 24 Apr
 2025 12:57:05 +0000
Received: from CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216]) by CH3PR12MB7523.namprd12.prod.outlook.com
 ([fe80::f722:9f71:3c1a:f216%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 12:57:05 +0000
Message-ID: <98c62087-0a95-4d4d-9e9f-9d62a530af67@amd.com>
Date: Thu, 24 Apr 2025 18:26:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V2] amd-xgbe: Fix to ensure dependent features are
 toggled with RX checksum offload
To: Paolo Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Shyam-sundar.S-k@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, Thomas.Lendacky@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Raju.Rangoju@amd.com
References: <20250421140438.2751080-1-Vishal.Badole@amd.com>
 <d0902829-c588-4fba-93c0-9c0dfcc221f6@intel.com>
 <c1d1ce25-8b5f-4638-bcd3-0d96c3139fd7@amd.com>
 <d5114fb3-4ca8-4ab8-acb2-120a7b940d6f@redhat.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <d5114fb3-4ca8-4ab8-acb2-120a7b940d6f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::23) To CH3PR12MB7523.namprd12.prod.outlook.com
 (2603:10b6:610:148::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7523:EE_|CYYPR12MB8656:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb547e7-4d63-439d-194a-08dd832f8370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWREcWczejk3Vkg2NlZuTVROMjg4bVdYOHdvN3JDdUdOa2VGMUpWZ1dFN3lU?=
 =?utf-8?B?TzFYQXBjWkNHbjFzVFRZSEFDcDlGRVZqNVJFS3dvS1pQWEVsN3hEaTUzNGNi?=
 =?utf-8?B?bERuM3l5S093WFQ3c2cvSTBlcFArc0E0ME1Oa0RZS1VTLzA1MkVSMFhZM0pt?=
 =?utf-8?B?elNGbU9VNEVCS1ppQkRzQVlFL2pmOEdkdkhsMHFKbWJNZlhFZ3VGSm5Xd1c4?=
 =?utf-8?B?TStBbkVQRlFOY09xTGsvS1RtYWplaVpvZlNYMGhyNXR5cmVMd3p2Ukdmci9J?=
 =?utf-8?B?UEpBc2VERGVIaDdPd1FOWVVqcEFiRFZab2J2V1hCaVVXSW1aWWNHVDhONnRH?=
 =?utf-8?B?UWdLelhZazlzcExGc3BpQithaEtWQVZYOE9OanNlMXRiRW5hV1dLU01XQTFR?=
 =?utf-8?B?bFRMSk1jSi9lRkM5dmJ5ODcvOUpIek9WQW5IUTFpYmNoeFZ0Z1VkdVVXa2ZN?=
 =?utf-8?B?Tm9MK3FTWXZJUlYxZ3NZdXNUZ3pSQUVQU1FRTEh4eHUyN1lDNGJGSUM1alh1?=
 =?utf-8?B?MjNsUGhoN0NQMDVJd2tCN25OWHVCSXlLYzgrZWV5OGtLdVBiZFhVK2pRNlEy?=
 =?utf-8?B?ZDJoZmtBRUhzR3A2eHRkTUJWclFWTXlDUFY3bGNNSERHcGtZWGxMTDJnUGs5?=
 =?utf-8?B?cnc1dWxETTdEbllHS1paNVVzOCtvZjBvdVlkR09LTTZsV0lSZEFUNlJUb2t6?=
 =?utf-8?B?Nk1SYzZHYzZHdDFud3o4R2VvZmYyVjVSWDJSVmloTHptUXBhQ2xMcWlWQkRx?=
 =?utf-8?B?akVjQWd3QnhCcXZMd0k5LzdWeUovTnF2S2N1N2wyc3ArdGdSUGsrdWlFOFVk?=
 =?utf-8?B?LzZKOSs3K2cydGxKd1NkVnpuSnAwWkppb3QrMHhDQUE5Um5hbnhOc0UzRTUy?=
 =?utf-8?B?dEJBeFgvL00rM1RnekRIVnRqSDB5UzRBRk5NUUJWYjZyUTdRTDZxMmVVZU1y?=
 =?utf-8?B?YkJRb2hLcmtSd3J0WFFUdXhnRzhJUFVTNEJ3RS9LRTFCTUpIUVB5d0E3NDR2?=
 =?utf-8?B?SUkwSmRFTWc2SFNHMGxsdWt2bU5nbFZuVllXeEVhckNqbkM0UWNINWI0QnNz?=
 =?utf-8?B?N3VHazBsSU1iRWdKRkxPa05LNVpUZU0wMEpVcFZHQ2tLVTBpcTE1MlluYlpr?=
 =?utf-8?B?aGZzUExSNXRoQzRqRWVtaEZKamJZRFZ1SStmVmlMcnlVd0J2d01FSHhsNjdy?=
 =?utf-8?B?WDgwVmNxN0FleStLeVc3bFN6alBoTmI1RVhTSVpBWmRCaWIxTjRUOEZ0K05Z?=
 =?utf-8?B?MHAyaTBrenVXMnJEY001ZWdldmJSSWZJNUZiS0hHUUpJUllyRXVlWi95TFMz?=
 =?utf-8?B?V0JEYkhHUFNhUXZHbHVFcTlXN0pVMURwNEN0clN5Mko5TUtRd0Q1OVdhQzJY?=
 =?utf-8?B?d05lUTdqSUZqc2dSVzBtdFJidFJXK25JeStldnJ6QU9ZS1dvNXE4bytnc0hS?=
 =?utf-8?B?VE9mMzJTa0srNlhyOU42T3lBZ0NlMlIwVnA5dktTTXgya1VLV3pvZGsxT3p0?=
 =?utf-8?B?UEZrMUdvNEtEN3B6VHF6QWpNd1cwcGhCQ2t2ZXNkTHQ5eXJpSE84c0ljVkp0?=
 =?utf-8?B?S2RMT25Ddk1xR24vL2dXK1ZtZUVmVDFuaVdsSVY3ZFRtODJIUEhpUFlxd0hh?=
 =?utf-8?B?eUtmQ0RxUjEwWmZFaTFRSTd3bjVLdUZoU1FPWUFid2RLNVBUUjFIK2NUUTNK?=
 =?utf-8?B?bk5BVkVrRFJ4ZGVHVXZUWkdxR0NINVFycFdoSklhbUtiSS9TaEdSRk9Wands?=
 =?utf-8?B?c1RtOU14WEdyM0ZQbXViSzdtckJuV0xnTnVWSVAzNVdDemZacldoQWRpY3Uw?=
 =?utf-8?B?N0ZkNzE1ZXhlaENxWlNXNlVPUjd0MDhDZTRweXg0RHVzS3o4d2RoOEJCMDE2?=
 =?utf-8?B?WitmTkZRTWRpdm9wVklZemRHbGNOOUZCNENLQ1QxOURlQUtvMEdsRUJkaU0x?=
 =?utf-8?B?ODgyNmorSHlWQ3NpNlFkSGFyK3dYVVBrL1B4N2N3djhhSHVtSWpTQkxSL1Jx?=
 =?utf-8?B?WE9zdXpiTjNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7523.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTZYVmhxWTJjeUVxSGlxWit4SkZqY0Z3amNPeS9qWnBMaXFZcW16SC9TT2Jq?=
 =?utf-8?B?TVJEQWNlblNuODd0ZldhVFU0aDdKcENIQzBvN3U5NVBYSy8wYnJwZlA0aFBk?=
 =?utf-8?B?blIxc28yalRnb0RmWjNSUFBBNDd5Yk0ydXhIcGZqcXEwc1dwSUFrSnhOUEtK?=
 =?utf-8?B?ZW9YMmd1VjBnMUV2ek5yWDBrODNlTGc0elhIcU0zVWh2bzNtZXNXdHNWcTVP?=
 =?utf-8?B?OHJxcnc0elJpMjdwVHJlbFVtbDI5eWJmMktBbUlVOWRqUFRKVzhET3hmelRr?=
 =?utf-8?B?SWFCVndSZ3NYK2pPMGZUOUVaWFI3bStVb0FRckNDY1ZNd1J3YkVYV1VUVitV?=
 =?utf-8?B?WHZRVWNCdXcxTEdiT1FxYkoxbFRrREd3WCtqSnZzMVg5NDVudG4wUEdNaDd0?=
 =?utf-8?B?Z2lpbGdpZ0VkNFB6VnpZNW10T1J1WVZvUjc0RllKT29HaTRFSVhKdVRjSS82?=
 =?utf-8?B?QzlNMEg5RGNSMHNKeVV1VFhyaXBuMU1WRVdwQVhJU0NoYXpsSmhDQW5CSUh3?=
 =?utf-8?B?ZWRqSTNmdU9nR2pqM3I1eEpzcTVuWDJRcnU3SHdIYUVJWnVrTENTK3RkTzRQ?=
 =?utf-8?B?ZU9RbGJiRXJOQTljTE54RFJBdXBWN3pzdE5TL0pGYVVRclZybzBVZncvMHdD?=
 =?utf-8?B?RHpnUlFxMVlWeUVUVHVRS2J2dytNQTlTcmR2YXFza2ZFZUt5MmZ2S3BGbG9p?=
 =?utf-8?B?dFBGd0JUd0ZLdTYwa0YwcHhUQmhWWnN1cTJhZi9yZnpKdC9YYWMwNlJHMDNh?=
 =?utf-8?B?L1Jhb09yeGNTMWt0OWZVdmQvNDFHcUVzbWhBeXZSR2RNTDdxZUlrcGxJUXpY?=
 =?utf-8?B?TXVrajFQTHp2NGxpSEdtQUNpNk5xTmtCWWh1Rk52K2Fyd2IrN1BIaFFrOUpX?=
 =?utf-8?B?cnhEUy9hUkQvRldhMXZKaEwrY3ByMDJqdHBzOVJrZW5XYStSRHBzT3dYUTRH?=
 =?utf-8?B?OGJxRmZHc0Z3YUtNc0QyY2NjblVtU2psanpzY0t1ODIzSVUwNmc5eU5QcHFs?=
 =?utf-8?B?aUpCbU85MDNDdXZuUTNvWGpDZHQrU1FWQVoxcGdNazRzZ2JxWGR6SjdGczFv?=
 =?utf-8?B?S3o4ZmhOalBKdDBBZlV3Z3dqRHhMdEVFbVpOeEc1S3VtZ1V3NUVheDRKWnRI?=
 =?utf-8?B?NVlZUU1ZNWI3MzJqdFFyKzFFakxPRzJreFFURUNuYlFpYjVJSXVHS2JpdlZ2?=
 =?utf-8?B?SlFoeU5iRVY1ZERIRjBmaXZDUFRuNWE1cTdrSU9EczN3WG50bXpMODkyQ0E4?=
 =?utf-8?B?YnBENjdPTXNEMnBiclc1VnhNSXpmTVhnSjJWK29QVU12Q0ozOGRrZFBxU1ph?=
 =?utf-8?B?ekROazc5Q2FJSmE1UExTTklZTlh1UHdmdHR5WHZ3eVQ1YUNGRUxaaGtsYk9s?=
 =?utf-8?B?V2VVdE1ja015RzdMWk9LVURlN1RMcStheVUxZnB2YkQ0TGlEUDUwRGJOTE9w?=
 =?utf-8?B?b3NwYnIyR2ZrQVZQa3Y4SHNuSXIvdS9rbUJhUi9LYkZHRmI4aUVueVg5ZUM2?=
 =?utf-8?B?UkxPTEt6ejBaMm5nUXgwYTJoRk8yMzY1aWN4bjFHMkFMelpQUk5CSTNtelBX?=
 =?utf-8?B?UEZMVU9TQmlyWFBYQnMyeUw0TjFFbkNVdEowRk5TdndTQkdPQWJzejJqbGpu?=
 =?utf-8?B?QUxZc0dNbDVzZjlPbURwcFdDOUVJeW1ZRnhjVTNoT2VZWG9ZZU1sWUU5SGpG?=
 =?utf-8?B?V3ZlR1JWV28xNS9UdTY4VTUxU0N3RURyUCtacHJ4QnJGOFBWZ28vbEx6OGdO?=
 =?utf-8?B?U2ZqSTJYOUxOK2dXQ2sydko4aUI0endxN3hkTzZOd0ZxbmxRU0QyUEc5dDYx?=
 =?utf-8?B?Wjh1b0NmaVl2U2M4dXNxTVdVUktWM2NMdTA5bk54T0JnMWpqOElHeHNhSkY4?=
 =?utf-8?B?OXp1Q0diY2diaUlkczBYbG00TS9QZms0R3UzbWFXd21Cd0FUQmkwSVpoTkRD?=
 =?utf-8?B?YnJLczlGdy8zQlhlalBKTW9iMmVoanJYTG9OOWVsT1Zoem85UnV0aUhsb1RF?=
 =?utf-8?B?NTR0VW5IM3NOWnVzSEpVL3NFSEVBM3BmclFGRWMyOWhPNTdKUVJVTDVGQ1lX?=
 =?utf-8?B?NEg1QXpSTUZmeDlOR1hWNWxGODJnSW5SOW9kcjNGTzBMU1dyNzhDV090UFhz?=
 =?utf-8?Q?d84rnMlYpEjWdAHBLdlDYX1Zu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb547e7-4d63-439d-194a-08dd832f8370
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:57:05.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 874qZajtZlWlMg2JDIQtA0dqe29WMtbN3Lu65i5k0K6KYhZm+yBrvBHizs3iOakosuwLZiVxAo7jl/gJ2Ar21A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8656



On 4/24/2025 2:24 PM, Paolo Abeni wrote:
> On 4/23/25 9:57 AM, Badole, Vishal wrote:
>> On 4/23/2025 3:50 AM, Jacob Keller wrote:
>>> On 4/21/2025 7:04 AM, Vishal Badole wrote:
>>>> According to the XGMAC specification, enabling features such as Layer 3
>>>> and Layer 4 Packet Filtering, Split Header, Receive Side Scaling (RSS),
>>>> and Virtualized Network support automatically selects the IPC Full
>>>> Checksum Offload Engine on the receive side.
>>>>
>>>> When RX checksum offload is disabled, these dependent features must also
>>>> be disabled to prevent abnormal behavior caused by mismatched feature
>>>> dependencies.
>>>>
>>>> Ensure that toggling RX checksum offload (disabling or enabling) properly
>>>> disables or enables all dependent features, maintaining consistent and
>>>> expected behavior in the network device.
>>>>
>>>
>>> My understanding based on previous changes I've made to Intel drivers,
>>> the netdev community opinion here is that the driver shouldn't
>>> automatically change user configuration like this. Instead, it should
>>> reject requests to disable a feature if that isn't possible due to the
>>> other requirements.
>>>
>>> In this case, that means checking and rejecting disable of Rx checksum
>>> offload whenever the features which depend on it are enabled, and reject
>>> requests to enable the features when Rx checksum is disabled.
>>
>> Thank you for sharing your perspective and experience with Intel
>> drivers. From my understanding, the fix_features() callback in ethtool
>> handles enabling and disabling the dependent features required for the
>> requested feature to function correctly. It also ensures that the
>> correct status is reflected in ethtool and notifies the user.
>>
>> However, if the user wishes to enable or disable those dependent
>> features again, they can do so using the appropriate ethtool settings.
> 
> AFAICS there are two different things here:
> 
> - automatic update of NETIF_F_RXHASH according to NETIF_F_RXCSUM value:
> that should be avoid and instead incompatible changes should be rejected
> with a suitable error message.
> 
> - automatic update of header split and vxlan depending on NETIF_F_RXCSUM
> value: that could be allowed as AFAICS the driver does not currently
> offer any other method to flip modify configuration (and make the state
> consistent).
> 
> Thanks,
> 
> Paolo
> 
> 
Thank you for your observations. I agree with your points. For the first 
case, I will remove the automatic update of NETIF_F_RXHASH based on the 
NETIF_F_RXCSUM value, as checksum offloading functions correctly without 
it, and I will include this change in the next patch version. For the 
second case, I will retain the automatic updates for header split and 
virtual network, as they depend on NETIF_F_RXCSUM for consistent 
configuration and there is no alternative method to modify their state.

Thanks,
Vishal


