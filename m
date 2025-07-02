Return-Path: <stable+bounces-159258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74D2AF5FCA
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 19:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE7F165414
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 17:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFB32D94BB;
	Wed,  2 Jul 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="49yLHlz2"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F22F50B7
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476789; cv=fail; b=Vj+s7Hth1uN16sUT/jRQeazHVXUBT7kFssvjoO3XziXfjYG5HaS4K95AcL4rhcw2SLAD2p77RXgbuCOnAsPKfaL1w6cljFplUTK2TkwuxpD2k43xyZ0bIKBUML5PDOA8+spR7/OVtIUx6fFfh6ojaqw+pKdL0jDYCalybjObZOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476789; c=relaxed/simple;
	bh=yMPYukXj1/XCo3x68RMh8mnW0+4LRF+FO0h7P906v1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eVf1XBJNid9SKYiGfeRCcbiuxektYrJ95eQ+QwwygNsmj4oDjqw232nKNSvXrQCc0DpZNpJKvpYboU5p9mUdp8nRBW9Wk6XrWrk1P5m7DJP/w9Nea/rr1lEEtFvJkesMqld3p/QeS0baFicDaOqyMA7gU+AG4okC+Vsth/CDt3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=49yLHlz2; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aw+NFRSCsW4M0/Karle1RA/NRKGP98KPI1Ts1au7FqepEuZj9IRI0qpg3dsLvZhH2OP5A/q2hW95f6cXNJhee0zdFX1x2XM8ljF1S7D83tQiTT6EVEEhQKP0HhmbOASySu8k+4Uz5OxMUy6hlVup4l4rYUW6A8QswMXafOYMpdtNMfH/Njtm52jxdaHoJuXUvCJA7kk1UmeIwpXyXMUkr73l1gqvdqDITAS67RAGDrKZoMF8DVk0ZopyuhII1d3R79/mz9B1VhkQXfvxZiCILHxm3OnOmkj9ACNw/Mxo/PPtgLf9VBcVht/utRgQQv1a7hi9FLRKoD+N5ZJ3eKrvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SS4K7hXLeNAfFFmCh1k0iBTT2+dvflcv1O0IwK1bag=;
 b=JpdDOwvH9ITl3CGUPr8DeOb3rgj0OlZLTBkgXmSjkHAlZAo0ZybPpin9K841f5Kcj+bFQ+EJ/sXcLRmqYQpNhj7P42jXih5Djunn8LICh9z5WKz5ckVTDv2JkDbGm06nFyfxSUgj2H8ErOylrmuXCavKIZsjvOcUkE8MNWw11i4gx6W6qld1RAlGQYxgd6a0R3fpa6mX8NyYjgwt8OCTEKw+uJi88nKsSCUJ5kQ2DlA1evllkz5TSQwFW7XdvJ8aBfQ6WFLClVvuqf5VzU3dFYmSGpADqDlpZNS/VSPc9W3Roi3rFC1GsZrh9ght02kTAmGNtFzwNos77VMJTg9VhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SS4K7hXLeNAfFFmCh1k0iBTT2+dvflcv1O0IwK1bag=;
 b=49yLHlz2ok70gNKYS/7qb+fk0088E5GneBdrQwfm53F4XbWCdgmolWF5QTbu0/bfliWpR5SLga4FFCSbxjCGeNOUlJ0RMKpNvnSwncBgjijRg1qB9AOnImZlHOMg1LfRkk6Kn5yzaUG7Vs/5es72Pw7mCld3beGrjDI3nZp+1dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 2 Jul
 2025 17:19:44 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%7]) with mapi id 15.20.8880.021; Wed, 2 Jul 2025
 17:19:44 +0000
Message-ID: <8b274e68-29e4-436a-9bb1-457653edaa2e@amd.com>
Date: Wed, 2 Jul 2025 12:19:41 -0500
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6.1.y] EDAC/amd64: Fix size calculation for Non-Power-of-Two
 DIMMs
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, =?UTF-8?Q?=C5=BDilvinas_=C5=BDaltiena?=
 <zilvinas@natrix.lt>, Borislav Petkov <bp@alien8.de>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>
References: <2025063022-frail-ceremony-f06e@gregkh>
 <20250701171032.2470518-1-avadhut.naik@amd.com>
 <2025070258-panic-unaligned-0dee@gregkh>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <2025070258-panic-unaligned-0dee@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:806:24::18) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: b17025f8-17d8-4ac3-5dbd-08ddb98ca339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1hrZ1doaERDS0ZndW1iWjh1QjVRNnBDSyt2aExXYXk3THBiOWcxa3krSk9s?=
 =?utf-8?B?c3RWRThveUFxdHdMbDlZaE1GSDZaZDA3UW1EdXJNZ3JqY2tPZlR6OHZ1OFNa?=
 =?utf-8?B?RjJEcXR5TklNMy9hb1J3cWZjNlErNy9mbi81TFNhUDJzSjA0MUQwTGV0VEtJ?=
 =?utf-8?B?dWZrOS9KMk9tMGU5VVVNM3hzVGJhSGw3VTIwZnM2YXFaUlgzNzBkN202VmJJ?=
 =?utf-8?B?Q0FxZVRSRmhEeW1qUjNWT0dscnN5M25reHRFck5OTGRMN01BYjNmT2RLOUtI?=
 =?utf-8?B?ODhkdmcwcTh1L1hlTFlDQ2NzeUJzNUM5Zm4wK2tHQ0tsZnhSampUQmVBd29U?=
 =?utf-8?B?Q3YyZHdkaUIwLzFDSnI2SUZzQlFjb3NMYkxSZzNodVdDeWkwTHZtb3RUQ01y?=
 =?utf-8?B?V3JCSUtGcHVkdko5ZFBUaXE5ejF5Zmg4ai9IRDNpcHdmTjlSRlhVd1RYVUxT?=
 =?utf-8?B?TjRRb1UxRzR3VTNEMlNNZktJSUE0ZzRMcHB5U29sRWxKUUhnbHpzM0NYREtJ?=
 =?utf-8?B?UjVNejNKbytJZk1UWjRpSmlDZ0ZGRGpBdVhwNG5Jb3lEVVlkakZiNVRQME1m?=
 =?utf-8?B?b1RrOURlcTFHVDFBSWdmKzNqUUloelQ1Tkd4M2RtWk56YWQyUFBaZ295SGZE?=
 =?utf-8?B?c1N5cmVGRFRHTDgrQmhEazZGZVMrY1lwcEpxbVF5U0FSQS9ZNm9RRnBnL2dN?=
 =?utf-8?B?MHlQTDRmZ2k1eVFPeHJFZG9mNTFLSGM2aElMdmd0VXBpakFKZjRsanhlKzhZ?=
 =?utf-8?B?MGg3TjVqUHJJUG5JVFdMbTh1Y2VnanU2TnlZTS82ZkZySU5La1dJY1FWeWdW?=
 =?utf-8?B?YkxqbUg3MGFRTUltMXRrRG5SOUY5dnVJWHJ6VkpSRDBrU0FPSDNQSGx1bThW?=
 =?utf-8?B?bHJScVp5NnFyTk5jdk8zQ2R1TUtGSDIveVh3ZnZPMUMvUjgvWk1EdHlBM2pT?=
 =?utf-8?B?OVFSQzYvdnlWQitGaE5tYkZ4S1NtN3lrTSt3QmNQL1NlYnZOSloxUm5xQ3o3?=
 =?utf-8?B?eDAwUnlab3pGd01VYnBLQitiYXFob3BJOWxabEJjcUl5MVI0UnkrNjR1b2ZN?=
 =?utf-8?B?VUdGMldJZ2lveTBlSzc3ZkJvdFZ6RW9SZEg4emJNS2F3NXNaTFRhSWhIWXdF?=
 =?utf-8?B?TE1zL0dVZy83Wm4raXJzTlNnVWIrSGZkQnE1VUQxRUw0RWQxQm1WZlFkSC96?=
 =?utf-8?B?OWpwUDdMdUM0R3ZIT2VrbTcvRCs0SFMydldwb3AwRms0VGdWMGs0amZOSlBj?=
 =?utf-8?B?cExZM3JOYndDWmVMVHdpZlZsS0JmV1I2c0xrRE9heXBJNnl2blFKWTA3d2h3?=
 =?utf-8?B?Yit5RkNNejJsRDFsSmxGODFyZDlSYmEwaWtCNm1PVEJCYWdSRlQ1blUyMXNp?=
 =?utf-8?B?cU5HZXMxMVloM2R6eEc2Y1c5RVBaZUVBTG5PeXhMS3luMFdocnFNczZpd2Jv?=
 =?utf-8?B?Nkd3UzZlOGkxRW5zbjR6cGJiWldnREUzYlNYOEl5dEhHaVg0WVF6UVE5VDY2?=
 =?utf-8?B?SHk2MGdRc0h4WWtJOFNYZkF2Uk1zSU05R2tNOHNjY3FVWW55Y3JvK09FUUds?=
 =?utf-8?B?U2Z6UmpNTVk4V3FrQ3lmblZiRDMwdmtUN2lvdHREMFBBN0tIb2U5ZDB1dkJr?=
 =?utf-8?B?ZkJ0R2RYcnlkQyszcmgzRm5UVzdPcHNXUGEwdlM2UkZkbWFCNjJ3a3FubW11?=
 =?utf-8?B?RFZlb0Z0ZENWMUl6emhUR0pJckIydDUrYnlvTzBWdWJQNjFYUCtKU250VlUw?=
 =?utf-8?B?T3RlUHI4dTdJelNrdjFtYWh6cXJGaWh2dlBzRUpCa204U3A1SFJ1NVJHRGt1?=
 =?utf-8?B?eGxhT1RPZXZ4NUZZbVpES3ZvTm5xdll1YUh1Z2xCcDNIeU9xSG92QjJ1eU8w?=
 =?utf-8?B?eDZEU0dkZHZ4QVl1QmtjeUJuSHRRbU4xOXlFdmdsOFFsZ1Zlbk5XdFJXcWhK?=
 =?utf-8?Q?qtIL0rOpEDs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDdtZUswQkhZaWFYczZUTEhsTlkrZjRnZVg5Y3pSdDlFbS9RakZLZTdYbVRK?=
 =?utf-8?B?b2pQL0c0c0puNTlBSTFVblR4cmNQQWZKckZiUktOSUJhN2FsMmY5OEJsS2dk?=
 =?utf-8?B?Q3U5bWxld045SzBLYlJUSFRjQXpFOTJxWWNTaXI4WHlEOHVqNHdJQ1hoa2x6?=
 =?utf-8?B?RmljbENDdjlCcmxFMTg0QWpQRXRxRDFWaU5jV2d1N1dUZVNEZlQ1N3NLOXJ2?=
 =?utf-8?B?K3d5MXVDOXcxbTJzOW5OekhsZUdZWVNlQVIxSzBwQjVrQ1R1aWYxRmFFZmdq?=
 =?utf-8?B?SGx0K09IZFl4dG96WWIvZmZsNkhxK3piSWVRbEVJMm1mZkVBOTR4U1FqQXlS?=
 =?utf-8?B?OVJpamQ0eXhwS0ZSTXNFczFZOUFENkMrUVJqc3pXTFBqaHhJb25UZEpUeWtE?=
 =?utf-8?B?Q2orenBwbnRjbkFoalFBb0hDNHRXeE5QRjc5S1d1UVdhS3FtN0VLeGp6MEE5?=
 =?utf-8?B?TTVXRmlpMWxYbkhqNDlyWVc5VGVwbTNpcWluVE9BUGNzS0JBUGRRL3ZpRERG?=
 =?utf-8?B?YmRaa2pEQStROWtOdGFySWdtR3FLUmltcWJBS0tTclNJdjQzSkZZZUdPQm4r?=
 =?utf-8?B?Z01INDhiS3o5OXNDa3VJWk5wOVVnUTg0cFNZTXJXOUJuMW8xWmc5a0pVY0Iv?=
 =?utf-8?B?eFJDUXBiYXJoMDVEZkxJZ2NJbjFhQ1FETnlXQlZleElDWHdVbDNxNVlKMVlH?=
 =?utf-8?B?azJ3TitsM2dwd1BmTHVsL0ZScUlGbUlkaDY2eVZvYldPR3FranhOU3dvSUZS?=
 =?utf-8?B?Z2V6UzVsUkI5M2E2WXB6eWhyOHY5UGdCTUpzbndhc3BReVBKWk0zSHgwRnJZ?=
 =?utf-8?B?Z081ZFkxdXdMdDJXNnZwMnd1d2JyaWQ2WnlGYXoycWlvMk5yWmhhNFBMdDZP?=
 =?utf-8?B?SVRwTmxSem5CWlJnM1JINjUyV2UxWFF6Q3F0RE1KOTk5ZXJHRkU2L3ZzVDdS?=
 =?utf-8?B?TVBVZFlBZGVhSkJ2bmxCMnRrVlJaaWc0OFhhUUFjcXNTVnhONHAyRXRCcHFJ?=
 =?utf-8?B?dSticmw4Sm1odDhmR3pLeG1DUzNkNU4vcHAvM0lPNlkxSmN6b0pTNnhOWWg4?=
 =?utf-8?B?MzJoeGtmeSs3SkxFa2I4S2pzUnRBOHpQM1RIY3VVMzAxbFBRU1l4aWUrZ2Z4?=
 =?utf-8?B?TXl5eUlHVENaZDd3VzhQSm14ZlZpYXErMjJVVU1Rc2FiNVBSZS9vRTdlZytq?=
 =?utf-8?B?c29Tek5VZXdCc1hoQnM3Z240bEVJb0FIZVJENzk1T0R6a3JMZ3d1cUt4ZVNt?=
 =?utf-8?B?UVlKOVVQbnA4UFVpOU9SazB0MGlTSWtzZ1VyK1ZBNW53RDhpQitrMXY5NFBV?=
 =?utf-8?B?QkFQcTczZVlTZ0pTbDRPengrK3o5SkVjbElUUitLVmtFdXpaTHcxai85VlEw?=
 =?utf-8?B?S0RQUE9hK1QzK1dBWDQ4a3JHVTd2a3o0S2MvQ0xqWCtkRzVhdi9HSWJ4N0J5?=
 =?utf-8?B?eXRiNG0wTTBMb2hmamI5bXZsbmRQL3A2VUNHNURzODc3WWhRQ1ZxdFA5Y1VW?=
 =?utf-8?B?NmswRVBTZ0JlNEFpa1dmZFF4azV5WHNUcllMdzMrbWlmaVpZRHNFdmd5cjYx?=
 =?utf-8?B?cTRkeGZFbDB6b3NUM2h1UUxuTzBwQUl2b2xyVnRMVWFTUTVDTUx1RlRMaXdK?=
 =?utf-8?B?ZnlKWFlPZEFQaTF0NG9pem9wbFZNSG8xRnovTFVIOW5MZ0tib0loN1JzWmh4?=
 =?utf-8?B?ZFcwaFZxQW5sM1IveWFXZVdTR1RuS00zNFhOU25FanpXN3lLVkdUalNlV2NR?=
 =?utf-8?B?K2FyZlo1TnQ1NU9mRDJmUDFoaWtiNGlscTVIaXNwSG9Jby9LcEtSZnZzNDVH?=
 =?utf-8?B?Q2VIN2VLWUlRSkpjUzloS3poYmNOZTlkUGxLclJGZ1BGVHZsc0x6cUw0ZVF4?=
 =?utf-8?B?bXVuMlN4cFF0U0xFTWwzWjlaZy9RZzBBNXBrdkJEa2RxMUVYb2U5RHB2NFpu?=
 =?utf-8?B?M2tkbHpPTjZXL1NxWUl4L3BsbFJsUTdtYk1tcFdnL3M0dHQxWFppUCtSQmwz?=
 =?utf-8?B?Zm8vRFc5L1dQT3hIWjlwVXdUS0UwQ3Z1NFJTKzNEazFUV2xBSS9FeEdra2Jr?=
 =?utf-8?B?RlVJWjhQZUdBR0E4R2ozVEhyVVRyY2NxSjI2eFVlQWlkZklPczllZTIwWWJ4?=
 =?utf-8?Q?OOkXWf3MqEsX0Sh7sZkAL6PKs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17025f8-17d8-4ac3-5dbd-08ddb98ca339
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 17:19:44.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIa09rnP8qLd5BbK1BIlMocKsq8M5g4Ws5aQOiW05VLFjQuZA1qVAdnJY7EvlgaWOkltG5V2iHdYvgrvTEB0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

Hi,

On 7/2/2025 09:31, Greg KH wrote:
> On Tue, Jul 01, 2025 at 05:10:32PM +0000, Avadhut Naik wrote:
>> Each Chip-Select (CS) of a Unified Memory Controller (UMC) on AMD Zen-based
>> SOCs has an Address Mask and a Secondary Address Mask register associated with
>> it. The amd64_edac module logs DIMM sizes on a per-UMC per-CS granularity
>> during init using these two registers.
>>
>> Currently, the module primarily considers only the Address Mask register for
>> computing DIMM sizes. The Secondary Address Mask register is only considered
>> for odd CS. Additionally, if it has been considered, the Address Mask register
>> is ignored altogether for that CS. For power-of-two DIMMs i.e. DIMMs whose
>> total capacity is a power of two (32GB, 64GB, etc), this is not an issue
>> since only the Address Mask register is used.
>>
>> For non-power-of-two DIMMs i.e., DIMMs whose total capacity is not a power of
>> two (48GB, 96GB, etc), however, the Secondary Address Mask register is used
>> in conjunction with the Address Mask register. However, since the module only
>> considers either of the two registers for a CS, the size computed by the
>> module is incorrect. The Secondary Address Mask register is not considered for
>> even CS, and the Address Mask register is not considered for odd CS.
>>
>> Introduce a new helper function so that both Address Mask and Secondary
>> Address Mask registers are considered, when valid, for computing DIMM sizes.
>> Furthermore, also rename some variables for greater clarity.
>>
>> Fixes: 81f5090db843 ("EDAC/amd64: Support asymmetric dual-rank DIMMs")
>> Closes: https://lore.kernel.org/dbec22b6-00f2-498b-b70d-ab6f8a5ec87e@natrix.lt
>> Reported-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Tested-by: Žilvinas Žaltiena <zilvinas@natrix.lt>
>> Cc: stable@vger.kernel.org
>> Link: https://lore.kernel.org/20250529205013.403450-1-avadhut.naik@amd.com
>> (cherry picked from commit a3f3040657417aeadb9622c629d4a0c2693a0f93)
>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> 
> This was not a clean cherry-pick at all.  Please document what you did
> differently from the original commit please.
> 
> thanks,
> 
> greg k-h

Yes, the cherry-pick was not clean, but the core logic of changes between
the original commit and the cherry-picked commit remains the same.

The amd64_edac module has been reworked quite a lot in the last year or
two. Support has also been introduced for new SOC families and models.
This rework and support, predominantly undertaken through the below
commits, is missing in 6.1 kernel.

9c42edd571aa EDAC/amd64: Add support for AMD heterogeneous Family 19h Model 30h-3Fh
ed623d55eef4 EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
a2e59ab8e933 EDAC/amd64: Drop dbam_to_cs() for Family 17h and later

In this particular context, the original patch makes changes to
umc_addr_mask_to_cs_size() and __addr_mask_to_cs_size() functions.
These functions, however, are missing in 6.1. They were introduced
in the module through commits a2e59ab8e933 and 9c42edd571aa.
Instead, their functionality, in 6.1, has been squashed into a single
function f17_addr_mask_to_cs_size().
Hence, the cherry-picked patch makes changes to
f17_addr_mask_to_cs_size().

Additionally, gpu_addr_mask_to_cs_size() is missing in 6.1. It was
introduced through 9c42edd571aa commit.
Hence, the cherry-picked patch skips changes made by the original
patch to this function.

Also, tested the cherry-picked patch on Zen4 system which had a 96GB
(non-power-of-2) DIMM connected to it. Below is the snippet from
dmesg:

Ubuntu24 default kernel:

[root avadnaik]# uname -r
6.8.0-62-generic
[root avadnaik]# dmesg | awk '/UMC7 chip selects:/ {print; getline; print; getline; print}'
[   27.584535] EDAC MC: UMC7 chip selects:
[   27.584537] EDAC amd64: MC: 0: 32768MB 1: 16384MB
[   27.584539] EDAC amd64: MC: 2:     0MB 3:     0MB
[root avadnaik]#

6.1 kernel with cherry-picked commit incorporated

[root avadnaik]# uname -r
6.1.142-edac-6.1-stable-24153-g431fa5011469
[root avadnaik]# dmesg | awk '/UMC7 chip selects:/ {print; getline; print; getline; print}'
[   24.600370] EDAC MC: UMC7 chip selects:
[   24.600371] EDAC amd64: MC: 0: 49152MB 1: 49152MB
[   24.600373] EDAC amd64: MC: 2:     0MB 3:     0MB
[root avadnaik]#

Without the cherry-picked patch, the module outputs incorrect DIMM
size information.

Please let me know if any further clarification is required from
my end.

-- 
Thanks,
Avadhut Naik


