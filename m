Return-Path: <stable+bounces-85109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB499E170
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6E9282091
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85C1C3F0A;
	Tue, 15 Oct 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1H+f+Ev+"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE718A6A8;
	Tue, 15 Oct 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981995; cv=fail; b=QNy9mTr8fTYPX3p44K//xnEPi/XJiWsReSwDxdonvO/m7J3T48ZPd9xxDaW1ShHbhqPxCGfNjRE0usvOgF4Zm9qrDecMkiVFOZBjSakVsQ325C3ajmLQMtTvzZBUQRId6u/RiFVsY/pJ2N+WoaSHjjQ9mPoLS+bleuVO5A4ZKx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981995; c=relaxed/simple;
	bh=hMasDrp7LDS5UgPMknyItSvfweE0V0OxxgIVPgA6R3U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fzk4fvBsiodZjT6Xl0pfqDzyiWxWT5OrexcGDglMfF50Pb997lxGJlgEJPvovaw64t5eBiRcE8ikLK/N7uIvRMGl1bhPciB3JRIqQXHLhRT01cnnp6wfaAs3h7oDPk5BkfaoqI++oVMQkASeffHVXbarrEyu+8C3MAAi7fTJ8sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1H+f+Ev+; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ6ZzRCWcN62H2EImxiMpYBd6gPusmRQ+oKgu4eWhTIztJrIDLT4e8Psk6nA7p0g9bqkCFSAFQu0NBDXEz7FylKxek9djG7PwewAoFdmVU/76l9mHmPXR7WI21JH7LcgFSsxo3p5o/+Cz+vz1plDqwzu3+ImZ1d4igVglOeyQglIzc949er0/73wAv5HFZWw2qWVsPe+GdJu5ew57Xur+RHWcS56AtLFu2U8g/vd2N993LKy/WuDjg26pSCx/Ya33BMuMzC88+FUtGwfm3+TGuAOR850ghJ8QLOK86S9368HSPAlYGsH2Ing1Gb8YP5f6MF57g+Xa/oplKwMloI8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YR2IMCydY0hNDzkUkKJSQhq8J2QoljsruL5DtPChbhk=;
 b=y3KOLmG1OqcWAALcJcYihAors9UBL1/x65tqpR+oFLZnz4L/Dc9yU8przBmWUo0v/dD46plsosFC4LvZTPa69RUBN/bLX67a1A44cMWI87bkf8qK+2aHY2kXnHLC2xD1pfrjr5h3Y87fdLL7yPZ+tlfCiKo8vQbJhbnlxQe8EaLqmg3LYWhSRWhQhn7L7g5OCU2MQ1w5R5VDZ5kLJO72nTszJbIstFRkES4A/iEf385u0N7vPcpX/6MAz7O4Enl8scHKvcd0gVLuvw0XdsHUqS4QOt+l8z3oOdysRFPdFZdUgPg8w2dMb20dsChRYaW6iYZre4mEfjignKP1nrJzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YR2IMCydY0hNDzkUkKJSQhq8J2QoljsruL5DtPChbhk=;
 b=1H+f+Ev+rPvzKbtOUMakMcaHtVDOqLcRFTm+I+MfbItvEl7AS+Jg7Dh5YsJi3vWwuh7/LuEeyQHMjuXhyxiTiAyfqSaKFGIwgiYV0WpkWjdlYZhccliXUJxiRjQOj/5wQeDp208NOYQp3LvCk12aDXKGdAQFbVza6Vh6o6xYkbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 08:46:31 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 08:46:24 +0000
Message-ID: <9a1827e3-1c55-cfbb-566f-508793b47a4a@amd.com>
Date: Tue, 15 Oct 2024 09:45:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] cxl: Initialization and shutdown fixes
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com,
 ira.weiny@intel.com
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, stable@vger.kernel.org,
 Zijun Hu <zijun_hu@icloud.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Gregory Price <gourry@gourry.net>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
 <7eb2912e-3359-8a22-2db9-4bfa803eccbe@amd.com>
 <6709627eba220_964f229495@dwillia2-xfh.jf.intel.com.notmuch>
 <a5a310fe-2451-b053-4a0f-53e496adb9be@amd.com>
 <670af0e72a86a_964f229465@dwillia2-xfh.jf.intel.com.notmuch>
 <0c945d60-de62-06a5-c636-1cec3b5f516c@amd.com>
 <670d9a13b4869_3ee2294a4@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <670d9a13b4869_3ee2294a4@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a87379-7247-45f0-0fa3-08dcecf5d9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cklYQ1YrVktkekxqOWVWZW1SK2xIN1RvYTltRVV4YThpNjNMVlJKU01ab2Ji?=
 =?utf-8?B?SkxtU0FkWGFlMWVEYUhET2ZKWXozazdIbmYvTlBsL1NEMDUxdHIxZWZ3KzRH?=
 =?utf-8?B?OFJVTkdqUFhPbE90UUw3OXdnUmxVSk5JTDc4eVp1NVRiU2pFKy9ZUTZEaEZH?=
 =?utf-8?B?STRXbGFQbHc2Nk5kdk9IRFFCUGRtdjI0SDlWT0JCbmlkRGRJQWNJdFMvOVZx?=
 =?utf-8?B?MmQrWTdKd3lWSnBWOHBBdGJIRnNYMngvMFBtSE0zYVJ6cWlMbWVPODlDRGZS?=
 =?utf-8?B?dGN0bkRHaTlabG1BSEhuK3RYM3VCdjJpeUxCcjFQTXBQbHcrOU83USszdmcy?=
 =?utf-8?B?SFlqS0o5L1dpL1ZhcExqeUpyQzduNGRYbVhPOHZwVnZDRFR4THYrMEpmTU5I?=
 =?utf-8?B?YXBMK0J0Y3Exck94b25IeXpvL3FQN3U4UXV5d1FnY0JaZFpVSGZPRWR1VHp0?=
 =?utf-8?B?L3RkNWo2c25PYW05WWpnSU5OdXdLaThEazE4VUNLd2tGYlNBS3RjRFZBb3pl?=
 =?utf-8?B?ZVZUYTBxVmNoakJKVEVHajNzcU5vMFIrYm5OVC9BaGxOSWkybFpMdjBIOExX?=
 =?utf-8?B?dGNzOU9hYlJKSU9Cc3liUEVGdnFJQXo4bDQrcDRRV0lNaGdRT2twbHlCMTNH?=
 =?utf-8?B?Z1I3ZnNpMUpSSEFscDZNaE9Ocm1GbEs0R1pVYTA5S1hTdzJBcDlTWjd6Rm15?=
 =?utf-8?B?TjluaDgweGwwZjd5anJmMGs3NUcydlVHZW5xYithUFY0TkMrVjFRSi9sQjZB?=
 =?utf-8?B?dU9STlBYNmh2am9HSytHUmk2QVd1WnhLU0wwOUZ0WjRGYTBoMGptaWZtbmlj?=
 =?utf-8?B?ajdUMnBSTEt5NjJPUHJoRWdkdFJ2d1NmVUdhekdRL3hQSXM3Z1pBRm8zV3JT?=
 =?utf-8?B?TThqRXdlenJVdlg2N1RzdlFkWnVFdnJLWEltcktSL2ZpSUMxUGJkZ3hveExu?=
 =?utf-8?B?ZWxNMUJyd29STFA0bytaY2xYNGxRSzU1OWJaZlZJK0VkKzNza1pBMGg2THp6?=
 =?utf-8?B?Uk1abGhJSEJYV2dyUDZ0emF0UW5GK2FubnZRMG9YTmNUWnFVbjlHNERCMmRV?=
 =?utf-8?B?NzMvRS82ZmloRGlnbm15ZTdxUGNHSGpsTGc2U3dPODhDdzlnOGZxSUh0UlMz?=
 =?utf-8?B?VGc2STJPcWZha3JmRTlHcG1wMnZkYjFHRUlFV0ZzbmRBaVpFai83Q05YT29S?=
 =?utf-8?B?Uy90Qi9VaVZtN05IaTJIWjRtc0NQb3E5NVRRRXFUWUh0M2d0djYrTFNVOWR2?=
 =?utf-8?B?amlWZUFWMGt2REs4RDV6ZTNUR1ZQcEoyUUowWm9MMG52VFViR0RKWStlRGJl?=
 =?utf-8?B?QXRlcEkyM3FiWDhCZWZES1hLRVo3WU5OOXlTZFJDSHJ4UzlWNCtWZkkwUlBi?=
 =?utf-8?B?dUxZQnRMT3RQQnNBMXFoMGhDbUhUL2VnTzl5dFJxZjBVa1hNQ01rZXpLa09Z?=
 =?utf-8?B?Y1RyTmxJRmJKM0ZlQUJaT2ZEU25WWnc0bnA4Qkh1THFvdGozUXJXRmVvT2o3?=
 =?utf-8?B?YU9LU3lUVjNWaXhBWGZoMGloNEx1ci9UbVZjdGM5NmZvUVh1b2d0QXMrQi93?=
 =?utf-8?B?cUNyeFBvWDVObFBreVZWcVBtS2RmV2NEMWl3cklSQzh1VlBzek9PWFBmRTdh?=
 =?utf-8?B?aGVwSGhhY1NSTHlIQ1hLVHhuTmtPQlBZMm1pV1N4K1orak1jcE1FY3lqRWJJ?=
 =?utf-8?B?Uk1NSWRhNjBBNzJGcG5Pc0JBUkpObitrdTJxZjZJaG9qQXZyMkFnbGV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVVCdERZeWgxRlZRRGNPTklEZGd1ekRhNENuRDk0Sk4rdHREMVl6QkhEZmNj?=
 =?utf-8?B?VFpVM0lyMHNWVVlqWGNMTithdVJqQ2h1ZUtWWVBQcWJvSTVpaTFmc1JBQ2lq?=
 =?utf-8?B?dHhENFdWUzBjY1dFYlgrVW9Rcm5sQmJLV1lCc3FzZnlEcGE0bDl6SSt0NWJT?=
 =?utf-8?B?bjlRa3UvZCsrcUU2Mk9DSXRWbmJMSUZTZ0p5QjRESzV3THp3NmMyNndHUVJN?=
 =?utf-8?B?djY3bTZlZ0pHOTVPZnJpYXM2bnhFZXJ4em5wVnVXQWt6K1hoYzRXUXd3ZDIv?=
 =?utf-8?B?YXBraDdoeWtXbnZ3WmVhcUNLMmJhVDI2T0RUTFRCOHBtM1JrNmhZOFlVQURk?=
 =?utf-8?B?WWJKVHdTa2VBdllRY1ZkS1ltcHcwb0tLZVBqQXhxaWxmUnF0UXkyRit3Mzgv?=
 =?utf-8?B?Umx6WGVzekVYZ01MMmtxcjFZTHpqVEhld3ZHcjg3V1VPMlJ3ZDhrUmYrK1ZE?=
 =?utf-8?B?eWNQTXBGdVllTGx3UFdMQXgveTBKRHJ2akhlQXR2SXVyRWpxZmdQSXJ2Unhm?=
 =?utf-8?B?MTlENExLRUNxMWFWUGxWWC8xR0xuTWhIUXA1eUZFRlNlR2gxMXBQWGtyMkZ6?=
 =?utf-8?B?eHBVamxlVDVYaEZwOWhMaDJUeWd5UG9TekxxSEF5SG0wakxoVUh6OVk2T2pS?=
 =?utf-8?B?eitraWRSY2JYVGRPaWI5cXZ6NXhRQmlnNmlxT004UGVjYW5aOXZiUEVqMnpj?=
 =?utf-8?B?dk1pZmM4NjFxSWs1M09TU0d6MmwzMW4yNExvWVh3WHpzNkxXTXBJWkdHcFhW?=
 =?utf-8?B?bmR5Y0VodGxORE1aRXZiVjFUQU1zQXI1MmVVa2hjRFRJeWR3RURyd1h1K2dt?=
 =?utf-8?B?NUlhck5WbG0vM3M1Y2Z3YjlHS3BBYUM5dWpnTGc4a1VLQUFSRTQxN0t2Vkov?=
 =?utf-8?B?b0ZYMFV3UFE3MlQzS3ArMTljclk2Y25lZ0pEN2FCdUs5akpYaDV4Q1dXMFph?=
 =?utf-8?B?eUdUT1dUKzJkUXBFSnpQckprSUdHNFQwb3ZaRWhyRDNYNnUzVkJZSUxMZTNN?=
 =?utf-8?B?RGhMcTN2MU1lNExvdkxwS0pNeTA4aDlsOWovdnJaWTRDTmtjN09DbDhmeEYw?=
 =?utf-8?B?emlpMjNnSVJ5R1FLd21OSUVaYUdiQkVHN0JaV1BuZFQrSUtYQ2Z5L0JHeUxq?=
 =?utf-8?B?MWRVNmJFTEw0N3RPclhGNVBuN0pYNURTSXVkamFxbjg3RHJYR1lXQWpwai9O?=
 =?utf-8?B?RTVMQzlpRVJrS3QyUVNKalRpaUZrWU5lM2FvNmZNYWtvaE51VUlCSzA2SjhW?=
 =?utf-8?B?WjJUcThEalNBK1RtK0dCZ0VJLzVZWVdrdURzd0FydmM0N1ZWZFMxa0QxYjB3?=
 =?utf-8?B?MFBBWDhRc3BBeE1pY0YwdSt0VWZNc2xVVHdjYnZjUjhWZzJCY1MwbTloWmpa?=
 =?utf-8?B?cm9kYllsYXBCVElqRTcwb2ttamE0VnhjRUI5aUtGZlBJT3Y5N0NDd0pkeUlm?=
 =?utf-8?B?MEMxdjlEWllwQzF5dmJJL001Y1hFUzB3bko3TVFUdEdJS1RCR2ZvVXVmRzVi?=
 =?utf-8?B?ZlhpTDZ5R3NWQnFzaHI2UUNtRERRNFE5d0ZlZ3c5NEI1T05CdzZZcUd5aWF2?=
 =?utf-8?B?ZlZJZmZ0czJPM0oxUnFLZTJ3aTJxYTNZc0k0ZG1EQzNIeDNvUmxuZ0R1TkIr?=
 =?utf-8?B?eDNocFJhdm9zZ29oNWIzeE1sK2xrbytpMFIrbWpvekJBYmFxTXQ1bHI2ZUtj?=
 =?utf-8?B?cDFkQ054UzVISlFJKzlVN0dyRnlWOEpCZE1RbXp3eDhrdTFSWFYwcGZmUHlD?=
 =?utf-8?B?bFpYZEUyOFlWS1cxL2daam9ON0hhWlFRZVhpd3U3THlCcUUyMWZVUXlYVitu?=
 =?utf-8?B?TEJnbXhYTFVXVkJLZjgxN0c5ejZwbnRQR0oyV2xnTUgxNDdOWUxzNDRoZ21T?=
 =?utf-8?B?NkRRQ2JPc1k2TVkxVUpBdDQ1NEVmY0c5dEFxeThwc3FyNTV6OHlQQUY2TDlX?=
 =?utf-8?B?TTVjNVRZaWJJRE5maVo3cjZzMGIzTGFuMi9PSHNsaXBQUmh4cUwzWXFIYjhv?=
 =?utf-8?B?clpzTmc3N1c1Z0VEZm80VTBKMVlSeVBUSlhjZE1uNVVBc2FyUkRGREpYck1F?=
 =?utf-8?B?N0x1YTBpSFI5YXB1NWh6VEFXeGN0Q2J3UFN1ZUFHZnEyUXlkclhnNlF6M1Bk?=
 =?utf-8?Q?cOK1ZhIvSv2tZ8J6eurdae/WG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a87379-7247-45f0-0fa3-08dcecf5d9e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:46:24.8511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlgM0tIsJ/MrkKCTOwyN7lpowgyDQIdYAh56zJpnpp+kXcaMQuLq3/jBCFchVglcog4kAcSy9jS1f5GX4Xmqog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015


On 10/14/24 23:24, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
>> On 10/12/24 22:57, Dan Williams wrote:
>>> Alejandro Lucero Palau wrote:
>>> [..]
>>>>> I am skeptical that PROBE_FORCE_SYNCRONOUS is a fix for any
>>>>> device-readiness bug. Some other assumption is violated if that is
>>>>> required.
>>>> But that problem is not about device readiness but just how the device
>>>> model works. In this case the memdev creation is adding devices, no real
>>>> ones but those abstractions we use from the device model, and that
>>>> device creation is done asynchronously.
>>> Device creation is not done asynchronously, the PCI driver is attaching
>>> asynchrounously. When the PCI driver attaches it creates memdevs and
>>> those are attached to cxl_mem synchronously.
>>>
>>>> memdev, a Type2 driver in my case, is going to work with such a device
>>>> abstraction just after the memdev creation, it is not there yet.
>>> Oh, is the concern that you always want to have the memdev attached to
>>> cxl_mem immediately after it is registered?
>>>
>>> I think that is another case where "MODULE_SOFTDEP("pre: cxl_mem")" is
>>> needed. However, to fix this situation once and for all I think I would
>>> rather just drop all this modularity and move both cxl_port and cxl_mem
>>> to be drivers internal to cxl_core.ko similar to the cxl_region driver.
>>
>> Oh, so the problem is the code is not ready because the functionality is
>> in a module not loaded yet.
> Right.
>
>> Then it makes sense that change. I'll do it if not already taken. I'll
>> send v4 without the PROBE_FORCE_SYNCHRONOUS flag and without the
>> previous loop with delays implemented in v3.
> So I think EPROBE_DEFER can stay out of the CXL core because it is up to
> the accelerator driver to decide whether CXL availability is fatal to
> init or not.


It needs support from the cxl core though. If the cxl root is not there 
yet, the driver needs to know, and that is what you did in your original 
patch and I'm keeping as well.


> Additionally, I am less and less convinced that Type-2 drivers should be
> forced to depend on the cxl_mem driver to attach vs just arranging for
> those Type-2 drivers to call devm_cxl_enumerate_ports() and
> devm_cxl_add_endpoint() directly. In other words I am starting to worry
> that the generic cxl_mem driver design pattern is a midlayer mistake.


You know better than me but in my view, a Type2 should follow what a 
Type3 does with some small changes for dealing with the differences, 
mainly the way it is going to be used and those optional capabilities 
for Type2. This makes more sense to me for Type1.

> So, if it makes it easier for sfc, I would be open to exploring a direct
> scheme for endpoint attachment, and not requiring the generic cxl_mem
> driver as an intermediary.


V4 is ready (just having problems when testing with 6.12-rcX) so I would 
like to keep it and explore this once we have something working and 
accepted. Type2 and Type1 with CXL cache will bring new challenges and I 
bet we will need refactoring in the code and potentially new design for 
generic code (Type3 and Type2, Type2 and Type1).



