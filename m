Return-Path: <stable+bounces-109299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877AA13ED0
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 17:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872D416BD78
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1A22CBED;
	Thu, 16 Jan 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yeTrX9xC"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79E22BAC1;
	Thu, 16 Jan 2025 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043663; cv=fail; b=YJeCC9/lPb++io5HEgCKQbW6RIb3rKfzHPZa+GlNBc3JUl7i/Bh7jpVGgWovNYK1N08MtP0F5Z7svUIkYkltdkn79ePpvzn9WMjoFXav6/+3oJvs/qeyr+aGt4w2IOy2XsdNfBKb1U6aou4z9JpmcPID47S2cqa+GhbxD5zFmiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043663; c=relaxed/simple;
	bh=XUVD+dDg6XPrWO/z7J3Hw5ae6oAMeOwTgI9XXMEr21Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Qj3hgBuEJWijZI13e3VBA9f19LFLhcl2K7Oi6Dq7NAdE/ilBYANatfsc7YuWoJiYr4xgoFLymzg8Bs6slZnhkKSUQiocRP9LUt9aNUEbWw6X0d0KWTR10EWs/sWJB+keRAl7BkIVWVGPLNWJq9nvfzfxkNM414PZC70CfZJMKH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yeTrX9xC; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTB2bbt7Mc5MmVstp8nxoeeq8otrqrjY1jsBMaYMlwzQK9d8vG8HnAsdqfzbAKGaSnpMqwr+0SbzS0VQKD2HGIWy8gQ9UxgEaBTX0L/WcyXbj2LVuu4gzFC0NaGLWwaVZJqM4mQjipWmAxJR5eHsIWllk/z9BU1e9bIpOPZ414ERJZc2yQpU3MjvgRysUMXcv2oc+QIJrIsjd+RjKg3FSd2Dg2PIDQtwzI5Gq08j2SLhYtzko8LVz92v0RKp/OF4ZL2gByso0ZXkamOwXpPi2lSpL+W1+rOPcBsET7HhRgu34QCadxCTsZv6sYjcL5OOQ6nmZ3T19A+kH/F30RSy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7cGaWVN6b4G/1Y1kKh9JVyZas1GfqQ1AhMvE+F4Cku0=;
 b=TQPUgiVOoN+VplE0OhNCqC6rscGdyrCjoWYebw2Lw2UB0MFGS6V8cdW5tyiOyaHDoOjuWElb6OxDdBJXYUo9YnmJSWMnZaFZZJ1xMfVp8n+w7bLYRHWjj+7jZGM4ZB1ANBkdP2lZ1qUCJV3NmThOP38N6j/Ts7p2Y1Xh6ZftT9tQKbFvGPdf8VpLoaoa4SrNSaShH0jPvwpqJROqnuC7+bnEY1jXlFx/oNVHhPsdR6nhZu5VEFAAfp/i+f9z3NIdOrYN87OgiLqdC+6kmCNTYPncUwUMUtmC2ga67MtF6zzS4omusRS8yWQxoWUunpOFoKUwB9+DbGXwCueLCjr4jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7cGaWVN6b4G/1Y1kKh9JVyZas1GfqQ1AhMvE+F4Cku0=;
 b=yeTrX9xCAk4WQ5FBtDDxTQYEDCDTST0EzuhAJE+OtJr+llPdpipqZGC5Wa61D6xUPmbHvQlbsERiQI5GYxPEG/HuSvctVKbH/F//e/Xn1gSnyx1sOPawEP4JH7gr3WHnhkCougdrqFzCAE8Ox6FSPS9czNQscKjkgOPMF7OLd8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4956.namprd12.prod.outlook.com (2603:10b6:610:69::11)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Thu, 16 Jan
 2025 16:07:38 +0000
Received: from CH2PR12MB4956.namprd12.prod.outlook.com
 ([fe80::fa2c:c4d3:e069:248d]) by CH2PR12MB4956.namprd12.prod.outlook.com
 ([fe80::fa2c:c4d3:e069:248d%5]) with mapi id 15.20.8314.015; Thu, 16 Jan 2025
 16:07:38 +0000
Message-ID: <ab28f8d9-266a-48ca-80cb-21ac66a97e61@amd.com>
Date: Thu, 16 Jan 2025 10:07:35 -0600
User-Agent: Mozilla Thunderbird
Reply-To: tanmay.shah@amd.com
Subject: Re: [PATCH v2] mailbox: zynqmp: Remove invalid __percpu annotation in
 zynqmp_ipi_probe()
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jassi Brar <jassisinghbrar@gmail.com>
References: <20241214091327.4716-1-ubizjak@gmail.com>
 <25eb1e35-83b0-46f4-9a9c-138c89665e05@amd.com>
 <65a1d19e-e793-4371-a33d-e2374908d7f8@amd.com>
 <CAFULd4YKGnOwumpUeW5Yyr-G+BmC=LUSVbFWg74GC9a628VN5w@mail.gmail.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <CAFULd4YKGnOwumpUeW5Yyr-G+BmC=LUSVbFWg74GC9a628VN5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0135.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::13) To CH2PR12MB4956.namprd12.prod.outlook.com
 (2603:10b6:610:69::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4956:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e47d717-c826-4d31-dcc7-08dd3647e59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZpcGVGL3FCM1FOeHhkUjQvdU5tdE5zbk11QVh6dGVxeWVkblRZYXNUZ0Y1?=
 =?utf-8?B?Vk1SSW0zZk9QNE91TUVkT1dJWDlHNVozRGVIRmlhSDAzMmQ4bkwwS2hrRlJv?=
 =?utf-8?B?dEtibGh6N2dFU0llSTlIMzFUN2hoUDU4VTNPaW5FWVJCSDZPTTRnK1l6VFY5?=
 =?utf-8?B?NjlIQWZzUG85YUYrNTVWR05halFPZElyY3V0Yk5ISUUwSy8zT3JTSERHMEty?=
 =?utf-8?B?cW1VNHlwNGNtaVdBSHgyMmx4b25WVjNiVUJLcCt2bE9qV3h0MktJK3o2bVRj?=
 =?utf-8?B?QS9IeXIzYUxtWGVNc1hBUk1wRjIxV0lONUVtd0FiVHVEenkra0NZTE5zNUZW?=
 =?utf-8?B?WCsyUjdJQXB5SHhPYXVaZ3BQOTY5YjZHYlJHNjhuNG9PZG94c2wrRzNhZitK?=
 =?utf-8?B?Ti8yaXFYMVFqSEJLdDJ6VDcycE5XZXJNRVR6Yzdtbmt2SVlJWkVCdlVObElX?=
 =?utf-8?B?WjVFeEVNR1FFY095TVRnRmYxWkZSWTBFbFFUcnpHVUFhTDlCZllRNlJUTG80?=
 =?utf-8?B?b1paZlpPTG1BYkVISDY5cDl0a2pKTHZyWEhXaU9PUFphVjIwUVFiVE0vLytY?=
 =?utf-8?B?cGJ2dDNMN1JBdVVWaFFhZ1FyM3NmTFA0RUNWc3pvU3p3alNDTzF2RjdLbGJv?=
 =?utf-8?B?SGtDNkNubXZXaGxJdHZRbVc4aEFhdWk2WVdtL1E1ME1pNlZWbW51bHNGWEJl?=
 =?utf-8?B?NkVGRUFOYnJtQUhNY0dpYjJ1SmM1Q3J5L25aN0x6WXhxNDB6WXNvKzlCOUl5?=
 =?utf-8?B?Z0E0a2JtK0l0SmN0d0hSUEp5dTA5MzFwczJZM1gxYTAwNGQ2YWRVKy9sVXdW?=
 =?utf-8?B?UXM3V1Z2eHBzMk1kS0VCK3lZYUNzdVd6WGFpaTRDTFFTbDhjY0hob2hvZXdh?=
 =?utf-8?B?eXhJcHQ4UzNvYWxwcGJKd3RjcnRPdVpaQ1FoQ1VFRElVclE4WGoyL1lSckNi?=
 =?utf-8?B?amE0T2RScWpFK1NoWFVBUWh1ZFpDcjJjbVdrd1hDc202cEV4Zy9PNnBLc3VE?=
 =?utf-8?B?d2ZxejJBMHZzOGRPSXB2d3E4UjJGdHJPd3BjQnRZYnBBbWNTTE5qOTdiSXZk?=
 =?utf-8?B?UkNXb0NiNklGSHhhWGRqQ1NEd0h6OWFUWWdpYktPMXc4YlByS254cVJJSUJv?=
 =?utf-8?B?bVRTSEliaVRuTGtUdldnVFNkWWxKWVI0MG5Ub2luQUw3eHNteGFBTjFBQVhZ?=
 =?utf-8?B?d0hQbDVOdFdBU2xHYTYyOHJMUzF3cUdZOG0zZDdzaDh2OWYxcWNOZkR6K2hw?=
 =?utf-8?B?cjVCdDVGZzZRbWc5cGI2OHY2Q1ZFN1Fia085RzMwRW95U3FUNDNLbXVRSUlW?=
 =?utf-8?B?MVhGYUFCd0xLZTdGNWtPa0VnL20rY1pGTnNWR1VGUUhoNllDRE90Vlo0Y0l0?=
 =?utf-8?B?aStlQytoSHVEcmtEVnRiOURYL3VDVUNVVSs5TXpTQTdOdGE0M1dMNkdyODhV?=
 =?utf-8?B?ZVRrRkZxb1VSTEdDb0swY0gvYU9DZnRSWDhDaG03eWdLbUEvb3J5K1lQaVZC?=
 =?utf-8?B?VE1yYlhkMGFhTHpQVzR2bDFWbUNVSUZscFFUYTRpazZzZWlkUWRYS0RTa2dt?=
 =?utf-8?B?bVZlY29zSFBRcGlZM2JHZy9YNlV6MTdJSXk5dkQyZEhqV3lGVm80SkErYkd4?=
 =?utf-8?B?NFg1ZUQxRjFFTVU1STB0Q1Y2dWsyL05pQ09HVG5CY29YVUVvOTE3Ri90dXV6?=
 =?utf-8?B?eXp3bWJTa0VJYmRteFJobDhTR2YzcnlTT2JtbGowMGd4V2xtUVl3Vms3OU5T?=
 =?utf-8?B?bXlkRDFnTm1GTzlkaHcrMXNEbnNKZVBFSitJbk5KUDhQTHZkL2ZUaWpyWXhm?=
 =?utf-8?B?cW8vUlBXUi9IWTZaMFVKRzRkaGw1Q2tGVlZkelc5ajF3TFM3cXppRk00b3Zm?=
 =?utf-8?Q?wyga6zGZWpN4b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4956.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXNqem1NT05pSURDUThlOE10cGdMa29CeUVScjd6MUgzZjYzclVkdS8rcFNz?=
 =?utf-8?B?VjVKckFoSG1HNWFFNFZuTVdIbmIxbktsRFRtUVNZbGU4TmdwaGI3QktnaytE?=
 =?utf-8?B?SFROS3Z0VkdSckt2MWtzV3hIaDVxR3JLVkdSRXBFeDdNODQzelFKejZUdlJN?=
 =?utf-8?B?UE9hemlZaGg0ZlJRSjNSNWRSYVRUTFk1dEpORDlTbnRlZmdua2xWUVlKOFVl?=
 =?utf-8?B?bFVBTmF4ZWpqLzU2RW5PbURZVndUTC9ETC85SUlmeTY0cjNMbU04YVVxTmZ1?=
 =?utf-8?B?OGNpVWZjazlBazRjUU5uTXVuK00zRjVmWnhqVGkrcUFUYlVEcURmeGJyT2hz?=
 =?utf-8?B?VUREWmVCUis3V2RCUFlRS0ZQZnVsV1JoS0dyMWViRTV5bmVzZzJTL0hvaHBR?=
 =?utf-8?B?eWRySFNobDZYejFQSHh5NUNMaGtVZkpDVzgzbEk1aVY0d3R5Qmc5b0FoNGJO?=
 =?utf-8?B?c1lTWWRZRkYrR3dNUVR0TGFEL2JDcURsR01iY2kwWk90MUNTek5ORUEvR0E0?=
 =?utf-8?B?TEFHRTB3eTVBNVpNczg4WlU0MldCbnRLSmtzb21XMDI2VDRnWHlRVjBQd0xa?=
 =?utf-8?B?WEprcFIzbXIxcWw3VUNwTXdJUDVvckI1NWdKaVJyNmVFaEZPalBiSHlhUzJl?=
 =?utf-8?B?dThZTEUrQUswbmF3aFlNQ05EWVliUnFWV2RGY0JFZHFUUnVtUE55WHpiV3BN?=
 =?utf-8?B?ZDQ2MU5WdlVnTmlBb0FPaytVUEU3Um5XRjkvRGY3VS90TmJORGZjbXZzQXIy?=
 =?utf-8?B?YStvRW9mVXV3emo3LzZ1NGtKN0p5ZlZEMWRYMVpjVGFkdHdQcGFRZW5icVhS?=
 =?utf-8?B?WVlKb2NXaVhIZ0YycDBtMVdaV1hZMUNRaWhFM0l6Tm9aeElOaGVTRGgxbzNG?=
 =?utf-8?B?R3pIYUFqZGdvV29pcTd4cHZzSSttSE9QaGZlbENncU1FR0xveVBkelk2UEd1?=
 =?utf-8?B?ay96bmVLQ2FvdE11eU1WUlQ4Z3V0dlgxanltQ1RIcmhZWVg1RzlwQmZBbWY5?=
 =?utf-8?B?QUVsWTVqT0FPNHRKQjdSd1QxNFZ5U2RSUkVmUmxYU3FnZ0ZVZm8vMjVQUGN0?=
 =?utf-8?B?aDQyZVFudm42WmhTekJSa3JSZkJ6bWJ2NDVXNktuYzU0SVE2N2JMVVk1VjMr?=
 =?utf-8?B?TW5nSlF0K0tjMHpzUFFCVUc0U1VKN1Nvc3BMM3EwSXQ2dkdscjVoVFFxK2VL?=
 =?utf-8?B?NytLRHZTRSsxOEsyMXhST0NmckVDcm5GMmIyNzdGOEFWRERWWDJBUkRxaHJY?=
 =?utf-8?B?NGcvcUdJTzUxVVU3aXUxQm42dnpodis1NWhGSkZOWWRmSk02Yzh5WE5OSEEv?=
 =?utf-8?B?dkhjTCtGSTFXYzV6VEs0Tk9sL29zSWxIeEYvaUJBMXI2dUtXWDR2Z3J0Ykpy?=
 =?utf-8?B?VDdPaHc1YkVrQmg0NG50OTdWWGtTb0RIelZvZ2ZFdlJOOGZEaHpFRlYvKzJF?=
 =?utf-8?B?MGIzaDA5dmFRYmxNQVNoL0lrVENBUTVGMGRCNmF1bE1nR0x2dGk4dDhsMWNk?=
 =?utf-8?B?QkRVZkM2Y3Nqb0cvMUtLWXRnS2lEQjZQdzVoS0dqV2pLODc0bEJCUHNNaHVZ?=
 =?utf-8?B?TU9LZW82YUVUcGdxZVNOWE1yd2Y2ZDFzM3lzUHBoLzZ1VDIzT08xSXdnMjNE?=
 =?utf-8?B?bXE4djUwdDAzanl2YlprdlBNVy9DUzZpQk5rY3pnTFArdzdVeGpNMmdtMy82?=
 =?utf-8?B?UlpBWkl4QkJPakRNTkhOckN3QlJJQVVtUWFJUnJTSFdLWVA3MGlBdVpWaGty?=
 =?utf-8?B?L0xGbEVvZzZ3c1NCUUsyV3ZYZmQ1M0ZjL002QjU4RlM2RHFXd0FMcWlvVjNS?=
 =?utf-8?B?LzNBUXBnNkFtOHNUWjZJOVdvMDlDRGJNb0lNT1JOUVluamxGUE9uYVQrb25G?=
 =?utf-8?B?K1pFaWF3bjRVVVNuVmdkWEdKVGxyeHZ6OVpud2RYMjVuOEZuREozMlZEb3A3?=
 =?utf-8?B?NW1icUY1RjljZlRJellLZUxUT1l1OUlGT0d0cFh1RUpyRVVpVzFJUUNvWlUy?=
 =?utf-8?B?QWJxNDh6L2Q5TmsweVlhR3dlVjhkeDJwbm01ektYK0dMN2prM3ZaL3QwNkNM?=
 =?utf-8?B?V1pGV3B4Qm4wUkR0N0VVUm5LeDlPM2N5T3k3NHozd3BxcEtIY2YrdERwSWRT?=
 =?utf-8?Q?CfajANKU72CCKUVvLe/Qw7NKJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e47d717-c826-4d31-dcc7-08dd3647e59d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4956.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 16:07:38.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6JRVaEVHHOk9e9RZQKR0ifuXN11cYm8Tg/N0BDPYXgU2ZZGPIFJ/h+1HApbkWR2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052



On 1/16/25 2:52 AM, Uros Bizjak wrote:
> On Mon, Dec 16, 2024 at 6:47 PM Tanmay Shah <tanmay.shah@amd.com> wrote:
>>
>> Reviewed-by: Tanmay Shah <tanmay.shah@amd.com>
> 
> Is there anything else expected from me to move this patch forward?
> 
> Uros.
> 

Not from my side. I am not sure workflow for this subsystem but, I 
believe this needs RB from Jassi. (subsystem maintainer).

>>
>> On 12/16/24 1:16 AM, Michal Simek wrote:
>>>
>>>
>>> On 12/14/24 10:12, Uros Bizjak wrote:
>>>> struct zynqmp_ipi_pdata __percpu *pdata is not a per-cpu variable,
>>>> so it should not be annotated with __percpu annotation.
>>>>
>>>> Remove invalid __percpu annotation to fix several
>>>>
>>>> zynqmp-ipi-mailbox.c:920:15: warning: incorrect type in assignment
>>>> (different address spaces)
>>>> zynqmp-ipi-mailbox.c:920:15:    expected struct zynqmp_ipi_pdata
>>>> [noderef] __percpu *pdata
>>>> zynqmp-ipi-mailbox.c:920:15:    got void *
>>>> zynqmp-ipi-mailbox.c:927:56: warning: incorrect type in argument 3
>>>> (different address spaces)
>>>> zynqmp-ipi-mailbox.c:927:56:    expected unsigned int [usertype]
>>>> *out_value
>>>> zynqmp-ipi-mailbox.c:927:56:    got unsigned int [noderef] __percpu *
>>>> ...
>>>>
>>>> and several
>>>>
>>>> drivers/mailbox/zynqmp-ipi-mailbox.c:924:9: warning: dereference of
>>>> noderef expression
>>>> ...
>>>>
>>>> sparse warnings.
>>>>
>>>> There were no changes in the resulting object file.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
>>>> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
>>>> Cc: Jassi Brar <jassisinghbrar@gmail.com>
>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>> Cc: Tanmay Shah <tanmay.shah@amd.com>
>>>> ---
>>>> v2: - Fix typo in commit message
>>>>       - Add Fixes and Cc: stable.
>>>> ---
>>>>    drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/
>>>> zynqmp-ipi-mailbox.c
>>>> index aa5249da59b2..0c143beaafda 100644
>>>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>> @@ -905,7 +905,7 @@ static int zynqmp_ipi_probe(struct platform_device
>>>> *pdev)
>>>>    {
>>>>        struct device *dev = &pdev->dev;
>>>>        struct device_node *nc, *np = pdev->dev.of_node;
>>>> -    struct zynqmp_ipi_pdata __percpu *pdata;
>>>> +    struct zynqmp_ipi_pdata *pdata;
>>>>        struct of_phandle_args out_irq;
>>>>        struct zynqmp_ipi_mbox *mbox;
>>>>        int num_mboxes, ret = -EINVAL;
>>>
>>> Tanmay: Please take a look
>>>
>>> I think this patch is correct. Pdata structure is allocated only once
>>> not for every CPU and marking here is not correct. Information from
>>> zynqmp_ipi_pdata are likely fixed and the same for every CPU. Only IRQ
>>> handling is done per cpu basis but that's it.
>>>
>>> Reviewed-by: Michal Simek <michal.simek@amd.com>
>>>
>>> Thanks,
>>> Michal
>>>
>>


