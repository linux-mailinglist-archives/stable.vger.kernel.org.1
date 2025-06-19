Return-Path: <stable+bounces-154719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0326CADFAFB
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 03:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D483BCFCD
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934061CEAC2;
	Thu, 19 Jun 2025 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jWejQ5dA"
X-Original-To: Stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7E1C8611;
	Thu, 19 Jun 2025 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750297438; cv=fail; b=LP4UddXb1xeCFDC6OH/yYW2xEby20C2PPBORkUEGnJZTPyfN+YkxOcFZHIk04rJtERnBTIWod/B0jGbTqCAJtqxQTNYOomIqhMADR5RkrM/HL5FOfcj1DFTGEfLOV75dhg3bdw8rdn/AEGJyzEq0GKsX44I6b7t6sVLcB2kRjtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750297438; c=relaxed/simple;
	bh=GeKgFwGdZhwh3LpA+FZVYDqnx/00jKeyBrV9M5SjcU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eir62g8tWz3OLgWJTC0+GBHbbDYlKIUAejpYCIx1mNddvKhfT9M/Aho+s8RoHwGbhtuE3vWM1u6EjMxjqN1zU8mv6gkyEiv+W3klLxkNFlVEFfBIBfhQ3H+0jnfY38tUY2Xo+H2Ufrm+/t5ttVo9GdS71MrIg8hNH1Ur+Q9b46A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jWejQ5dA; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETTNICTOhcTYE3+1C9eicUB/9KntypG/aXk4jdyim2RnpdpuDAULHZgblY6BeTDbvwvVSMq0WJQpuC3XWLh26ewesfdqosnTQtcFaX+6XC4Nev7SU7YcFlXKHUpUNy6rm2vaDFRil/WH9/+rUJXLrOK2PbP5tFMyK+XG9rUL1rQiqQ02WqkjNXPVl+VSLrdBPn/joQywYQJIQ2LNDEEXt5TsgketywsgeiLBmRELpuwbWClxoHucToD4hFcl6dTIBw8J/zv/Pnq4fN7x2s1vviz/U7KIx4umdtTbuvf/dDtZgyn/EKlFMUkH5h2WiVJqFIXePWwJVHOZ3nz/1bBdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5knfEl3aRCq74HtOJgYsFxlspPW5PgEXCF4cy/ZMce8=;
 b=pbp0QCrddRTkevD4kK2aVIBRUbB9mPZ1NqlICVJ1IbvunjnyEeVv/cgg7bjL6VYityJIVWeAFgxodSXq/qe92GlaSdWJWZ+P3g7yC2SPZKDjo7J3O/9vF+ERoQMArwMweEyF2eN2VMkA/ZfgywPVduym/54eRg4/qiNn6g4uWqQLcdEAQbOVSpWTN4S4aaEcqmxBQaXs1bRKJ+FA+gU9KyAkAlKS5JNl4cejqJ28jxtFtkA86hdEDCa6p1yIlX3yFVFRpUIuZTBGEqOadl4n1mRgpmwzTauY7Lc9nIIt9juR3mYR3rXr9f8tm4ZEY1vpB/CtyyDA/K8D8KcTTtcZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5knfEl3aRCq74HtOJgYsFxlspPW5PgEXCF4cy/ZMce8=;
 b=jWejQ5dABRvCwdem80brBwpYwHQ/krcl5ADDkXa6S0sHOh1gKpv0zgJG6rU7w1EXjejNq45+7SCWdoKdzTEVUOiZHwEV2moX+ptEDN/z4VIk2oH3vaxFQoE5DpJCcgwWrcWFJ2knhCx30B5QoC/Sk/lhTLa0CykSk2lkcXGOEK64Ko61OI33bNTVuOBfQld7tF5rvhCwBkTVgJi1QYHt1YGc2sELSktM0UiMOBF6gmQXins5j8JeX2yTtack4WWkaKewcoTnL6bNzlSibETr6H5SyGsuTWckbF1nxcRarW0CMGduOGYH2e6ZmZ7ShOHZBv2PtbVyQE4kNfz2kzFicQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 01:43:52 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 01:43:52 +0000
Message-ID: <56b5e235-6fa5-49d8-8083-42021cdbd12e@nvidia.com>
Date: Wed, 18 Jun 2025 18:43:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm/gup: Revert "mm: gup: fix infinite loop within
 __get_longterm_locked"
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Hyesoo Yu <hyesoo.yu@samsung.com>,
 Stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>, Aijun Sun
 <aijun.sun@unisoc.com>, Alistair Popple <apopple@nvidia.com>
References: <20250611131314.594529-1-david@redhat.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250611131314.594529-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: a335ecc9-ee19-41dd-fe18-08ddaed2bee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWpRdDN3R0dhUW9WRUhEc0w3dkxTUDZud1FvZFNxMHk1d0dsT3ZZK3VRbGdp?=
 =?utf-8?B?dnVmT2Fxa1VIb2pBajBKTVBoSzdwQTBxdEpHTkpyRGt3N2l6ejdGOXlWai94?=
 =?utf-8?B?Z29KSlJPa0ROUy9QbWt6Tnc1emNOYUxnd0QwdGo1d0JFTzFsTXVHeHlXNndw?=
 =?utf-8?B?ai9CaU9vY21CKzUwSktzNWxmSSs5SG8yNUVqcDU2ZHQxeWhMczFISU5oWjQy?=
 =?utf-8?B?OGdZN0N6NitFSFh6QlU4NzRnR05hWStORU1kbERTYmZMY0pXQ1ZBeUdZV0wv?=
 =?utf-8?B?MWpvSjdFYjcwQ0NUcEdYVlF1Zm1jdmFhT0JTdmh5VXNsd2prTXdUUWxoaFhB?=
 =?utf-8?B?dnpyZWVyQ3JMVjJnTUw5Y3FnTVU2NWFrN0kzMDdtTWIxRzE1OXJZbjFhTUpK?=
 =?utf-8?B?ZUFQa1loZ3N0VWFreFI3RzdaajdMZUk4anY5T1hXam1zbXNVME9vWUlWMldF?=
 =?utf-8?B?MHNBZzBDQmxoU0FzMEV5cXlrMHdCNmswZmdKb2FWMVhDMVI3Z0duYlluMjRr?=
 =?utf-8?B?L3grclVsSmpzOExsR1VsWVBzdEh1Y2hxVG1BVnJuOVNkSjJnbnAvZFdnOGJT?=
 =?utf-8?B?N2FsRjVwWjNXUmM1V1NRVXIzQmhZbWVWVmJrVVNiWTJTRUpXUkhsNUhxeGZV?=
 =?utf-8?B?c05JMTlEK25TNXc4ZWVVZkZyMFY3UVhwQ1V1R1Q1NGpIajZodGNmdEg4SnRE?=
 =?utf-8?B?dk9GeTZVYk12bmJpODhhZTdYYXIrVDFmVnRvd2V5U2lneUxrbTFhUm1TQm5y?=
 =?utf-8?B?amQ2RXlJdmRFSWhDc0JpSHJKRWVWVEt6L1VETTU0ZTJzZTY2NVdXREQ3YThB?=
 =?utf-8?B?Sm42ZDlVazdzN0dGYmc0NnU2dys3Zk80R2ozeGdMK2dXLzBOQitxTHJ1ZW5H?=
 =?utf-8?B?b2xSNEg5MzVKV0s5d1pJRmZRWmtLUzc4ckU4SXZQTVgxeFhvUXN4UTdkMHZz?=
 =?utf-8?B?SVJ1cDRpUU81cVBFUDkwTFJDL3JUaFg0M0VXUXNSTWJTalhEN1kxU1Izd2FO?=
 =?utf-8?B?bUVQbFRSN0x1aDNPQnd6SnFtN1l4b2tMelB3T21jUWZJd2JuWlNOUUhSTFZx?=
 =?utf-8?B?L0F6QzBoeUsremxyNUxiaE1TdFYySm4vZzA5QVBTaExSdkN6Q2ExUDV3Rjlo?=
 =?utf-8?B?QTY2SDh0cjFMRHZtQnR6bm1YTGdoTHdxUGxhUWxweGllQWZCOFl4RytpYWV1?=
 =?utf-8?B?K0RsZm5JK0R6NzIwVDBnb1Ardk43ZjdNZG40Vlkvd2h1WDYzZTdYU2J1VnIr?=
 =?utf-8?B?c2xRSUhhTEFjak4zTUp2QjQvNlFNblZPT0tSOEpTTGFWOTNjenF1OUpxbmNX?=
 =?utf-8?B?S2JsQ00vdFk1cmozUk9ncHV5V2w1dmhtQUZseW85M2dKdjJ5L3FOWXJpMDJI?=
 =?utf-8?B?YVYxRFl4QmZ1UzZpUk1ESC9pY21lUlhZYUZhaldHUlZkenJNS3YrQ291b3pz?=
 =?utf-8?B?cTV2SDYzamIxZElpcXQzY21RZnpXVlpWWGJCRVZMS2dCamdYSTQzNUxCbW52?=
 =?utf-8?B?dWVraE0xWlhmVWZSL0NYYnJobXBjbzJjS3llWEtSQnQrcXJYTEw5aXhhR2tW?=
 =?utf-8?B?UHBsS3FSZWFwUnVFMHY3bmVrazdnSjdzT0Nac2lFOGZBV3d4S25JMXdKQ2g0?=
 =?utf-8?B?NVJzZDI3ejhxeHREaXdDNFFRbER3Nk8vUWZwNW04S0ZnZHhDQ3VHQTNjWXYz?=
 =?utf-8?B?SGt1NXRWTWFPdkxHaVRvTmN0aFA1ZUsxTlpsbG5wRVFMU2MydW1GZ2hXUkRZ?=
 =?utf-8?B?TytNODZBWUNrZXowbkQ4ck0rRmxCQjQ4NkhuRDhhVDdUeGI3NnhEWFYyd0VV?=
 =?utf-8?B?dVA1RlU1OXN1b1pQeGw5S2V0di9mUHcvSW5ROENGRHIyejVGNUpzK2NyUWd4?=
 =?utf-8?B?bnZPaU1QR2dPNEFqTkdOS0IyeUJqTklzVXROMi85WkgzQTNTclZnMnZHQ3RM?=
 =?utf-8?Q?zobwVMKte4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXNUUWN2cXMzbHV2UytkcjFoSTJFMjVkTFJqKzhRTGdCK01CM1NzQ2ZnTFJp?=
 =?utf-8?B?SmZOcmh5QXF0YTV5dmFiN21XdUxTYi81MkRwVUNMelN1QWtILzZ4ZzBvWHlV?=
 =?utf-8?B?ZmVaaWNmL04xUEZnZ0RMOXM5aTZRL3lCTzJBeTUzUDFaSzdPb2RtTDJkdUds?=
 =?utf-8?B?dzZKeW5mRWgzWllrV21YbTFWdzdEWGRHR3l2WHl6cVlWcFU5aTFoalpNaHVB?=
 =?utf-8?B?K205OEZZVlM5UHdldHFyWGx0ZE1FdzNIaGkzclpvU0NFeWNqVjE0ZXJCVUZs?=
 =?utf-8?B?MnVnaU54VStoa1Q2eEZ5ZEJFWU9CNmM4WWlkNHBnV1V6ZkE1Yy9IMzJ5QU4v?=
 =?utf-8?B?RXZHNHZLUzlVenlhYnhuUHFXc3R6RWcvQVd0b3kveEo4cytzeVd5Tm5FTUVj?=
 =?utf-8?B?S2hqSXMzMG44NldJMWl6MHhTTXkvQkFOUitVdFE2ckF0ZE5xWHZyNG5yYklk?=
 =?utf-8?B?eWZvd3BNbW9DM09FRlhLMUt5YUZ1YTVlcXJEcklGRWlDWnVjWDBuc2Evby9F?=
 =?utf-8?B?dFlkeFZHM0x1am1nakdyWEYvOERYcFpvU016NXZNbGk4WXRVaXcwRiswZ3FO?=
 =?utf-8?B?UnJBVWRFLzd5aGFTRHlrYUE3WHVMWmg3UTNQNU5YdGJWQ1oxY3hoSW1rb29r?=
 =?utf-8?B?ZDRodjlmeGNWNEp2SDB4eXQ1b1NGQnAxVnJDSnk1cTQ1TnNZckxrNTl1WXJl?=
 =?utf-8?B?NzYzWWR5M0dQQjRLMFphTmdZd0tvOW5ualhsZUpqYi92Z2puOXc3TEpNMFJL?=
 =?utf-8?B?akxOVWJDVE1NNWo5c2NGWkoyZDYrUHVuS3d0Y1RRSUcxZzhBSjdLZHN2eTc0?=
 =?utf-8?B?c1VJZnRIQ2dCQ3J0KzNZMVZkUjcvMmVpdmxnVFBsbWdVdW1CLzg2YkIyUUJt?=
 =?utf-8?B?T2dHcTZxQXBiUzA0VVRuSGxqZ3hia1BlN29HUEFpRFNQd2wwVzNTeVNFT3ZP?=
 =?utf-8?B?cUwrV0lCc0RLWTE0NllEQ0ZWZXM0OTJuNFJSYlBkaTl5QW8vZnEvS0w4ZFhp?=
 =?utf-8?B?OU1KTzFGc21Xb1ZkemVlZGRiRkEyOXU0U0RxeVN4OE5HQlRQYUFyekdXSDZj?=
 =?utf-8?B?Vk1jeVgzSDJvM0ZvemVackdpOXNOQ2R2RFJxeCtDL1MvaVA1b3VFbm5UNm5W?=
 =?utf-8?B?aFlJeCt2Q0g0OStTWXc5ZzRsNERwaHFGRTVpQU5PUXBBUW9PSFJZOG9Uekk1?=
 =?utf-8?B?OWZKaTRSeEZHNWhUbFpvK3dhSm1vMmFrVUwvNTg0Y3R1c2dzZlJwcGVpRTB1?=
 =?utf-8?B?V3dHOUxFZDBoUVhGcEZTTDVaQnRkdW5Zc0ZoVUxnM01Nc09RL2hkWWx3bUJs?=
 =?utf-8?B?by9ySHcxV0VSTlg1WFZ6bTdaM3lTODl6c20vVkJhNEdIR1VaZlRUMU5KNHJq?=
 =?utf-8?B?ZllCaW1NcTNmc21LblVMRHl6OWt0ajJIU1RRZ0oxU2cwNDZSNG13Z0UrcGQy?=
 =?utf-8?B?K3pSVFNqUUhPL09HTFN3SWkzRk9YTWE5blpLcDB4K2hWYVhTMTMvcW1DR1ZB?=
 =?utf-8?B?eWNOcy9lbmgybWlCeGxjbU43YlM0d1VyRm1sVllGM0JneVFNSHdTekNxNHRV?=
 =?utf-8?B?Ni9ZRWo2dllKbFd6VWsxcXhKQU1pR3FVb25CQ3BMTUd1WnlYWW1XcEdhSjJs?=
 =?utf-8?B?N3JYK2FpWDdUL0plWm13QyswdXRVNHNnMWpaNE4ydlYwR200NlQzQnhTMVVu?=
 =?utf-8?B?RjR0cVh5QkpOZXhieG1zQ010d3BMMmlWakNwa1h4T3dHbDdLYndrLzlzUmhN?=
 =?utf-8?B?MHhZaTh3M1lqaVAzbVBDRnVxM0RuenIwVGJwaktSMEFmMGo5bHJxOVdteHF6?=
 =?utf-8?B?MjFKc3FsTGFZbUZFYXpGT0RMYXY3QytMc2l6M25wQVlCUGUvWjkycTMwSi9l?=
 =?utf-8?B?VEYwWGNJRnV2aDl2TnFzZ1NhNUo1V25icEtDZHNyejlSRjk5YU5MY2gwRVU0?=
 =?utf-8?B?VlFvZGNueWUzcStOZWdzMTJOckpZQ1BtZWo1RnJZUHNWTVBrWnRSOWdlVG1X?=
 =?utf-8?B?WlMwQk5jcUcxYTJreXovakc3MnJxdFJWcmhTQnRvckhIdXJmQmVYd3F0clF3?=
 =?utf-8?B?azBBQVp6bElEcUhCZTkyRG1ISW1hWG5EL2NRMGh1aDRFS2RXZXZTTUwrU2xR?=
 =?utf-8?Q?LY+wq9UeVvLrG+dlnVqElcoDZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a335ecc9-ee19-41dd-fe18-08ddaed2bee0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 01:43:52.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dg9+odj09N24PRGH8+flKh1vkT9TN6YFQK5nDFFIaKIqpjdtGxCle1ME5C1odKZ7s667N/ZudQUkmqGrXP0ZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

On 6/11/25 6:13 AM, David Hildenbrand wrote:
> After commit 1aaf8c122918 ("mm: gup: fix infinite loop within
> __get_longterm_locked") we are able to longterm pin folios that are not
> supposed to get longterm pinned, simply because they temporarily have
> the LRU flag cleared (esp. temporarily isolated).
> 
> For example, two __get_longterm_locked() callers can race, or
> __get_longterm_locked() can race with anything else that temporarily
> isolates folios.
> 
> The introducing commit mentions the use case of a driver that uses
> vm_ops->fault to insert pages allocated through cma_alloc() into the
> page tables, assuming they can later get longterm pinned. These pages/
> folios would never have the LRU flag set and consequently cannot get
> isolated. There is no known in-tree user making use of that so far,
> fortunately.
> 
> To handle that in the future -- and avoid retrying forever to
> isolate/migrate them -- we will need a different mechanism for the CMA
> area *owner* to indicate that it actually already allocated the page and
> is fine with longterm pinning it. The LRU flag is not suitable for that.
> 
> Probably we can lookup the relevant CMA area and query the bitmap; we
> only have have to care about some races, probably. If already allocated,
> we could just allow longterm pinning)
> 
> Anyhow, let's fix the "must not be longterm pinned" problem first by
> reverting the original commit.

Really great commit description, I appreciate the time and effort spent
summarizing what happened here.

> 
> Fixes: 1aaf8c122918 ("mm: gup: fix infinite loop within __get_longterm_locked")
> Closes: https://lore.kernel.org/all/20250522092755.GA3277597@tiffany/
> Reported-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> Cc: <Stable@vger.kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> Cc: Aijun Sun <aijun.sun@unisoc.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
I've verified that this is an exact revert of 1aaf8c122918, yes.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard

> diff --git a/mm/gup.c b/mm/gup.c
> index e065a49842a87..3c39cbbeebef1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2303,13 +2303,13 @@ static void pofs_unpin(struct pages_or_folios *pofs)
>  /*
>   * Returns the number of collected folios. Return value is always >= 0.
>   */
> -static void collect_longterm_unpinnable_folios(
> +static unsigned long collect_longterm_unpinnable_folios(
>  		struct list_head *movable_folio_list,
>  		struct pages_or_folios *pofs)
>  {
> +	unsigned long i, collected = 0;
>  	struct folio *prev_folio = NULL;
>  	bool drain_allow = true;
> -	unsigned long i;
>  
>  	for (i = 0; i < pofs->nr_entries; i++) {
>  		struct folio *folio = pofs_get_folio(pofs, i);
> @@ -2321,6 +2321,8 @@ static void collect_longterm_unpinnable_folios(
>  		if (folio_is_longterm_pinnable(folio))
>  			continue;
>  
> +		collected++;
> +
>  		if (folio_is_device_coherent(folio))
>  			continue;
>  
> @@ -2342,6 +2344,8 @@ static void collect_longterm_unpinnable_folios(
>  				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
>  				    folio_nr_pages(folio));
>  	}
> +
> +	return collected;
>  }
>  
>  /*
> @@ -2418,9 +2422,11 @@ static long
>  check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
>  {
>  	LIST_HEAD(movable_folio_list);
> +	unsigned long collected;
>  
> -	collect_longterm_unpinnable_folios(&movable_folio_list, pofs);
> -	if (list_empty(&movable_folio_list))
> +	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
> +						       pofs);
> +	if (!collected)
>  		return 0;
>  
>  	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);



