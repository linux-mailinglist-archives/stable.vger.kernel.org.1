Return-Path: <stable+bounces-194433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF20C4B7A1
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 05:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC723B251F
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 04:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ECE279798;
	Tue, 11 Nov 2025 04:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Srxeuxp6"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023117.outbound.protection.outlook.com [40.93.201.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC54276028;
	Tue, 11 Nov 2025 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762836294; cv=fail; b=dVjiyQ3PuqWoUxNQ8YJOzGSFyYZUeQmsj+WonKsAkSAcM9TsVg3/OYuztUNU8mImDfb1oU19NZ+wsGCqxEBt04njBBr91pVtoRE3IwcHfKeuhiedVxjUDQdvVvwvjYNLjeRZLtBLKGXPcRZ8QFOBvMtObQJAmr4jDV+EZrvnWaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762836294; c=relaxed/simple;
	bh=v4sTI1dLIr71Feijpv7pu5yXEGjRzNYArT7YPwBM2wU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BQ+OsqqX+0jFqwONbxjMjLE3bFvSk3XrrJu6Ox7kmV1v4O5K6iIc8TgidlyZOTvWH9UdgPtFFTTOlYMozM7jrd3xQ5FJjdAZG9WlP9q+ajeemjEhOioDIfW33Yj58fB24uKs+KQ/3P8oemtdPzmkyWooAUtcy3vDKgtkwg4nc9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Srxeuxp6; arc=fail smtp.client-ip=40.93.201.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKG7650ZXCDHIKqJ3jr5gmfnDhm+L3GqsgnTrH9BSxhn+TOD58J/SykfoU9H75rB2B5EOkqJuyk4CbdqbV5yVlswkOjgqCz+3zRuCz4SQ3puQGNwhd/s8/dcY1JQf/K1AFHHcUUgVQCnT0G5FUL+O52rs3/63fWd0gzRJ9qN/NnmwfTsEcGeNtbGg5AUCFVud2rQzpovO2GjqDi0GX3PLLif0S26btY+J26UBWiGCLjMB3xRxXOColxxcpp2Mh1DszzETiE8Rn8p9tAi/aTVTIZF2cLJH2BFQlgDC1Ic/O3m9yz1HYww3lrVbp1L2tNEdGvunIfyKCwfUao34ZzZ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ut+b3CrbZYVdbMu/7VkRrDqQaODV08nkh77iKG4EEzc=;
 b=JsuRK9aEGkbd4kEMpv0+ERdJh3NunXXtcYe/nNpYYXLLQMZh/30AwRI08M3x/+y0Xlc9L7bsYX1jYxmL9E9tFlV/xdrg8ndSqEBTBa5XvcxMi3zq0qECQM7p5MfZlx1bScIN3R4rwQ2z2SJ5PM6zhkb1qcdIefGsqYeE6cUc2H+JhRamKKs9awW69RWwRZRK0TpRsWQEqa8Kndjpzg+PpKsxn79WfnkQyR3oyXsqR+F5mkvU0HuV4vIf70eRLTo9QQGF97D9z1eLmwzzNH71ptYDXtS0i9YRqUq/FDDxI4GA6c8lh/CzliztCL867NCosxW4VXGTqNVNnRpCsg1PgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ut+b3CrbZYVdbMu/7VkRrDqQaODV08nkh77iKG4EEzc=;
 b=Srxeuxp6eHleENsh47zG6GP326bzm5jPyCHFYYK37bQ9uzdQPhz66ybm+tZiL/OAqJXK4sbqUO6712F5E/eqvWRlvHGnmbnO5xyCCpYz9eTa0rG1s88MUhnMtJhT+AeRG6T7XsOdqjv80HgLOfad9bpc+9n7Rm5Umg6Zg4rTkv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 IA3PR01MB8751.prod.exchangelabs.com (2603:10b6:208:534::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Tue, 11 Nov 2025 04:44:48 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 04:44:48 +0000
Message-ID: <94c91f8f-cd8f-4f51-961f-eb2904420ee4@os.amperecomputing.com>
Date: Mon, 10 Nov 2025 20:44:45 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/pageattr: Propagate return value from
 __change_memory_common
To: Dev Jain <dev.jain@arm.com>, Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com, ryan.roberts@arm.com, rppt@kernel.org,
 shijie@os.amperecomputing.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251103061306.82034-1-dev.jain@arm.com>
 <aQjHQt2rYL6av4qw@willie-the-truck>
 <f594696b-ba33-4c04-9cf5-e88767221ae0@os.amperecomputing.com>
 <f8b899cf-d377-4dc7-a57c-82826ea5e1ea@arm.com>
 <aQn4EwKar66UZ7rz@willie-the-truck>
 <586b8d19-a5d2-4248-869b-98f39b792acb@arm.com>
 <17eed751-e1c5-4ea5-af1d-e96da16d5e26@arm.com>
 <c1701ce9-c8b7-4ac8-8dd4-930af3dad7d2@os.amperecomputing.com>
 <938fc839-b27a-484f-a49c-6dc05b3e9983@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <938fc839-b27a-484f-a49c-6dc05b3e9983@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::12) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|IA3PR01MB8751:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b890fc8-7277-42eb-b1a5-08de20dd0b46
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Yk5TYWE0VWxLNlprbHJLNGd0STBIVXVwcExZN3hWQm9wUWJtNlpNc2k5aDY4?=
 =?utf-8?B?SXNMNVZ3Q0NLNVdMTlE3enVCSVFwaXNCRFEvNUdHUmwyNHZMOER6aXA3Mk1v?=
 =?utf-8?B?WjdLSGFNbE5mL3VRb3hHM09Bdm9zKzVCVWhzK056S0ltc1hVQ0FMVEhCU1A0?=
 =?utf-8?B?NGFmSE9FU0I0WG44NDdJTG5pREk4M2Z4anYxUXNHTjd2ZVF6SVNJVkNKSisw?=
 =?utf-8?B?WGxmc0NkN1JOZ1NCSi9DVHhWVDl3R0wweWxXc05sRlVGZjhkY1RzOHhZQ3RX?=
 =?utf-8?B?UktqU2Jucm5QK2JTSHpuZnhPdmhtdHRCZkxnNkEwZkF2aDJjWFR3ZGludnJa?=
 =?utf-8?B?eTZ0eU9xVFJKMDRycWVQRE4xMkxqVDJHWVJpcGpwUVhIZjJPUkZXWTh0a3Fn?=
 =?utf-8?B?UEVoUnBoQlcwMWtWMzAyNEYvRHBSZEtDanArMTJYMUZhWTE0UThWTDlLY0dv?=
 =?utf-8?B?Y3piWG8xWDFtd1B5M1NUclRabS9xcXNSVUcydU5udmJGcGkxRWdWZDF0SmpU?=
 =?utf-8?B?OU5ib3lESU5peWdZY3IvSUUyNURMd0xKU0xvWTQ5amI2NUZqYmxwSm9RNmFK?=
 =?utf-8?B?U0hnWEZFNDJjdUhxdzRCRTAwcDk1N3g1YnBYSWhacnFtZTBKczROYTVNeG44?=
 =?utf-8?B?elNaWXl3SVBuK2VTeFAwOHdaZ1liRHZLeEh0NEZ4bGVLNDhJdnhuVDJsbEVI?=
 =?utf-8?B?bUV5SUZnUlZkbDh0VlNSV0w5bXg1amZ2K2F2NzA3eGNkK042a00rVC8zQjFV?=
 =?utf-8?B?bkFjNTMwcEI0Zmg3eE5lamJpQklaaUthOXhDMTlHSjJXeWd6SHY4TVZsQ0pl?=
 =?utf-8?B?OXhXUkFGanNRRXBNSGNzcHl6Wm91RmlScnBNNWtpVWtNeldrblJLaytEZ3kr?=
 =?utf-8?B?TUowekhEOWp1dGNOM0tLcUxpMjVlZThSaTJxdllMdUgxeDBUN2RMeHF0RTRk?=
 =?utf-8?B?UFBEY1BFSzhGWUtWd3hnNG5KSDhRdHUzUHEydWlEK3Q4Y0UyV3R2SUM5NkZw?=
 =?utf-8?B?SXBPb0pTc3NTdStZZmRHZm1DUVVYaXFzNnM2VWNRYWRDSU9CcjNYa1REUDA3?=
 =?utf-8?B?TUdsUGYxUndiOUllM2toQkpBU1VneUN2UFZpbENwY1NKMDl1ZjIrczd2L1RM?=
 =?utf-8?B?UEt1KzU1UVl0a3ZwT2Frd1J2dllLSXk1RDJNNlFxSHN1a0FpQ1E2RXFrYXUv?=
 =?utf-8?B?QXVTYUdIOGVTTmJkL0FBckVnOGpGQ1Npa255TU9CRGVScGpyZG5qemJpS2c0?=
 =?utf-8?B?bEZBcDhySXY3cExwVFpmY0Z0UGJURE0rZVlRUFA1UFNIcDc4U0cxN0lYZVRW?=
 =?utf-8?B?TytXT3pxellzMzJJTldRYzQxOVR0cG5XbGE1bFdBVjl4V3V2b1pUUUZoRHFi?=
 =?utf-8?B?bWZoekFBUCtWZi9sckZpTVplbUZuQ09OT3BxMlZKdUljQVp5Yy9aR1VYUVBq?=
 =?utf-8?B?RTFzMTc0U0tqRkFDd3V3M2tSeUZyMGdPdGJSNjgyc2oxRnROUUorbWUvSnJW?=
 =?utf-8?B?SUVZYmRwWkJEWUdiWmc4ZEliTXN1aVFZQzNCR1dWMEl1bXJLaUdWSFg4Wmh6?=
 =?utf-8?B?QzFiUW0ybURMMGtIT0ZEZWhVTFJza3BFbm0yZklWSjZjMzVLOG5BM1hIV0cz?=
 =?utf-8?B?K1E5YXVTaTZzU1JvSUNqZDd3QkY3bXBYL3BvNm1sdTVRMENNdm03ZkVuUWVD?=
 =?utf-8?B?em1wbUh2K1ZHRFZFUDlYSldlR0lna1dtdS9QTnZjSzRWb3d4TXJZZkptbDJZ?=
 =?utf-8?B?UzdJWUw1RXZodTBEM29UdnhBSGhKM1NQb1Q1amJoaHdoeDFBOU4zOThBSjhH?=
 =?utf-8?B?ZG9RQVlod1JsL00wZ0Jjc2x3U1dOKzJyWDYwZ1JpVkRzbnE2NzZFOXpkRE1k?=
 =?utf-8?B?Z2U4Qjc0cFJwQW9oKzN4N0hXdTZ3RzB0MlAwdG9wQUZXMUQvM2lLaThCVXAy?=
 =?utf-8?Q?Y4b9psBf79anL4lyXSb8C/11Ki0J4Wt0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUpxVnZnUlU3bENZREN1TkZjZkhyMnZGZ3RrbTQxSFV4ZEQxWHc2Wm9DVkZY?=
 =?utf-8?B?WEZFcmMzdWJRSTNudXJZcTIyQU5JR1RDWnhSQ1hqZmdzRSt5WlZpR0xhYzdV?=
 =?utf-8?B?NzZON0s1YlRaMktOYUk2KzJQMDhiZ1dmckY4SHFqZ3Y3RE9paVRlbUFrblAz?=
 =?utf-8?B?YVVydlRCTktyWHhNQ25CL2hQTjRNYXFEajhIaHRKRVppQzkvdHhGaVRjQ0Zm?=
 =?utf-8?B?R3dCY2tQU3lGZVhnY0VMOGlKaUMrSmN2RlBZR01QNERNTDVrQVdjZTNmaGhL?=
 =?utf-8?B?aUVQeFlhY2s1NGQwY1JIM1J3bkNkVFhnUnYzREZicS9adWkzbkZMVmtZMWpO?=
 =?utf-8?B?Y21Rc3ZFalFncFhkTkEyb2RkbmJ2UFlyamdTQUU2VUxkZVBPZURkN1Ezdmly?=
 =?utf-8?B?emFZemlMRmNTcWlWQkxYbndnaVFtQXhWWDd3Q1NEOUFadjlEb3FwNVRTZU1h?=
 =?utf-8?B?RHN5K0ZQblpmUVZxdmpVMGM1QlJsbytzbXdRbnh1cUZMSUwrc2NGZExRa2h2?=
 =?utf-8?B?NDV4MmpnZkVBREt3aCtySXVvYnBuM3I0b1JSTlp0aFYrQXZTOUFOTlFUQ2pL?=
 =?utf-8?B?LzQ5aW56NUhsSlI5SFJTTkhISzhDY3lCL0lTRFpjMDJiTnFkbjJXRUFROUlx?=
 =?utf-8?B?UHI3elFkbDlaeVNOamxPcFQ3ZHVSYW1FdWJ2RmhEaDc0OFdJemNpZlJ1cXZR?=
 =?utf-8?B?YVNyQ21ldk1hYVZGSGNsWVR4dWVyZU5OVlJOaVVNSUVOcjM4NEZGR2dzaU9V?=
 =?utf-8?B?U09zRHU2ZmlmcVdmRTlQRDdGSWZDZUhzMHpOSy9zWFFJLzdEaEZBQmRhTU5R?=
 =?utf-8?B?MFBvU0ZUWEJCNWJJNmtWeERHbEJBQ1VTWFdYazErOE1lQnBLeTUwY0o1Y1JR?=
 =?utf-8?B?SjBRQitFcHZjYVBDZ3JkSCsydFdKTGNjL2NoeGhEMXdTbmU0ckFpN281RVpp?=
 =?utf-8?B?SVEyRFppSUJXamE3YWd5c2FpTTVmZ2RvSkpHYWE1NWQ4bXBuOFI3ek9pNGJj?=
 =?utf-8?B?cDlvamtaZVNUKzhLcGlXeHVNUURvSTBRMDFEd2ZIZXo4UHRyRlN2QyswSXpR?=
 =?utf-8?B?cE5oaU1PTmtkOWdkYVhoSERRV0pOYU42RDBhVVFmZ3ppYytuS3p1Z0tEZkhK?=
 =?utf-8?B?dHRrd0pIVHAwSmRmOXBGYWY1VUpxUVdkSlpKVFBMVFB2Y0lkTWNDN0hpeGRF?=
 =?utf-8?B?cWdvZTF1UFRtTXNsalNhVkZkUnpjMUgyM1l0U2ZGSy9FNVN3ZHdwcDFhL3Ba?=
 =?utf-8?B?a29pdTFVZ0tDKzhpSFhvRnZVWGsvMUR5K0ZDTjVTbTRBbkIvbmJRMnRweWJ2?=
 =?utf-8?B?Y1J6SjQxZ0o4ZU9JUnlGYUpZY3hhZDk2NHlzUXBCcE5RSlhCOCtzb2NnT2N4?=
 =?utf-8?B?WTVGTlluWXhLM3F5NWU5Q0tuZFNCdStiU0V5eXdpL0U4aVJidGxPeWxhTVAv?=
 =?utf-8?B?Q29wRUZJMGFrcGFCd0pvVk5Sd1NXakltQlpocGVpUmJHVEdUQlE2UmVlZy82?=
 =?utf-8?B?NmZqbXczaHF4ZmIrZm9BTUFiUGczVlRpdzJzUHJjYUpBS0M3ODU0UEkxZzFE?=
 =?utf-8?B?WWZ2ZmhpU2JkYnBkZFY1Wm5EeTRTc3pvdklTL1dqVW1pLzFkUElyQmhrNWZV?=
 =?utf-8?B?UittN2tHdGg4OHhHV3UybGc2d0FqdUV5VlVCMGg3ak92MExCdEl2cnpnTTc3?=
 =?utf-8?B?bVV2RnJDcGRaWkFzcWJ2NnpvN2VXV3VIeEN5YzZzdW1xVjBGazk4Ly9RQWdp?=
 =?utf-8?B?ZHc2VVZnQkgveExOaVVqcGFyTllML0FBVHdFbjdlenBlSVNSUUdIMEpHSkFL?=
 =?utf-8?B?dk1ITlh4VWgrMHAwVlA4YTVlS3VjT0pXZW50STZyeXorNHZ0MmdhQi8xck1E?=
 =?utf-8?B?ajVSNDdWa0VNNjNwclM2TTV6cjV4WXB6bnhXZWxnSVNkREhxODdMRi9KckxU?=
 =?utf-8?B?WUdlR1RudW9YZjVtclFnRUJyQ1ZxSkpsOTBHanNlcUNzZ1cwNmh3QVNLckFE?=
 =?utf-8?B?T2NUSk10T2I1WnhEVExnY2MwcVJZaWZJdHU3QlZNZUtDMGZnRk15OG90dE5k?=
 =?utf-8?B?ZHpmSFl2T2hkUi90WnN6dFFvWTFtV3V1OTl4aTY1SzRzOUlWaGQ2UlErQWla?=
 =?utf-8?B?WkxoSDZvRXhBTDJlT0hxYmRLRVJ0UlZYanNXQmc3RzZPUTR4K3JBTjlnUkMx?=
 =?utf-8?Q?QhGa5uybygnjlTovfozLKT8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b890fc8-7277-42eb-b1a5-08de20dd0b46
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 04:44:48.5283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsTGSQNk+2Mcs/+H2A2uZYYFTsQ4bZa9HLfD4KjMDl01hjRdU0lM+OCN2QjbUkk+lH5AGbS5rP1YsAd9J90FXAG9PTRRzLTquQb50qEfAZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR01MB8751



On 11/10/25 8:37 PM, Dev Jain wrote:
>
> On 11/11/25 9:47 am, Yang Shi wrote:
>>
>>
>> On 11/10/25 7:39 PM, Dev Jain wrote:
>>>
>>> On 05/11/25 9:27 am, Dev Jain wrote:
>>>>
>>>> On 04/11/25 6:26 pm, Will Deacon wrote:
>>>>> On Tue, Nov 04, 2025 at 09:06:12AM +0530, Dev Jain wrote:
>>>>>> On 04/11/25 12:15 am, Yang Shi wrote:
>>>>>>> On 11/3/25 7:16 AM, Will Deacon wrote:
>>>>>>>> On Mon, Nov 03, 2025 at 11:43:06AM +0530, Dev Jain wrote:
>>>>>>>>> Post a166563e7ec3 ("arm64: mm: support large block mapping when
>>>>>>>>> rodata=full"),
>>>>>>>>> __change_memory_common has a real chance of failing due to split
>>>>>>>>> failure.
>>>>>>>>> Before that commit, this line was introduced in c55191e96caa,
>>>>>>>>> still having
>>>>>>>>> a chance of failing if it needs to allocate pagetable memory in
>>>>>>>>> apply_to_page_range, although that has never been observed to 
>>>>>>>>> be true.
>>>>>>>>> In general, we should always propagate the return value to the 
>>>>>>>>> caller.
>>>>>>>>>
>>>>>>>>> Cc: stable@vger.kernel.org
>>>>>>>>> Fixes: c55191e96caa ("arm64: mm: apply r/o permissions of VM
>>>>>>>>> areas to its linear alias as well")
>>>>>>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>>>>>>> ---
>>>>>>>>> Based on Linux 6.18-rc4.
>>>>>>>>>
>>>>>>>>>    arch/arm64/mm/pageattr.c | 5 ++++-
>>>>>>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>>>>>>>> index 5135f2d66958..b4ea86cd3a71 100644
>>>>>>>>> --- a/arch/arm64/mm/pageattr.c
>>>>>>>>> +++ b/arch/arm64/mm/pageattr.c
>>>>>>>>> @@ -148,6 +148,7 @@ static int change_memory_common(unsigned
>>>>>>>>> long addr, int numpages,
>>>>>>>>>        unsigned long size = PAGE_SIZE * numpages;
>>>>>>>>>        unsigned long end = start + size;
>>>>>>>>>        struct vm_struct *area;
>>>>>>>>> +    int ret;
>>>>>>>>>        int i;
>>>>>>>>>          if (!PAGE_ALIGNED(addr)) {
>>>>>>>>> @@ -185,8 +186,10 @@ static int change_memory_common(unsigned
>>>>>>>>> long addr, int numpages,
>>>>>>>>>        if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>>>>>>>>                    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>>>>>>>            for (i = 0; i < area->nr_pages; i++) {
>>>>>>>>> - __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>> +            ret =
>>>>>>>>> __change_memory_common((u64)page_address(area->pages[i]),
>>>>>>>>>                               PAGE_SIZE, set_mask, clear_mask);
>>>>>>>>> +            if (ret)
>>>>>>>>> +                return ret;
>>>>>>>> Hmm, this means we can return failure half-way through the 
>>>>>>>> operation. Is
>>>>>>>> that something callers are expecting to handle? If so, how can 
>>>>>>>> they tell
>>>>>>>> how far we got?
>>>>>>> IIUC the callers don't have to know whether it is half-way or not
>>>>>>> because the callers will change the permission back (e.g. to RW) 
>>>>>>> for the
>>>>>>> whole range when freeing memory.
>>>>>> Yes, it is the caller's responsibility to set 
>>>>>> VM_FLUSH_RESET_PERMS flag.
>>>>>> Upon vfree(), it will change the direct map permissions back to RW.
>>>>> Ok, but vfree() ends up using update_range_prot() to do that and 
>>>>> if we
>>>>> need to worry about that failing (as per your commit message), then
>>>>> we're in trouble because the calls to set_area_direct_map() are 
>>>>> unchecked.
>>>>>
>>>>> In other words, this patch is either not necessary or it is 
>>>>> incomplete.
>>>>
>>>> Here is the relevant email, in the discussion between Ryan and Yang:
>>>>
>>>> https://lore.kernel.org/all/fe52a1d8-5211-4962-afc8-c3f9caf64119@os.amperecomputing.com/ 
>>>>
>>>>
>>>> We had concluded that all callers of set_memory_ro() or 
>>>> set_memory_rox() (which require the
>>>> linear map perm change back to default, upon vfree() ) will call it 
>>>> for the entire region (vm_struct).
>>>> So, when we do the set_direct_map_invalid_noflush, it is guaranteed 
>>>> that the region has already
>>>> been split. So this call cannot fail.
>>>>
>>>> https://lore.kernel.org/all/f8898c87-8f49-4ef2-86ae-b60bcf67658c@os.amperecomputing.com/ 
>>>>
>>>>
>>>> This email notes that there is some code doing set_memory_rw() and 
>>>> unnecessarily setting the VM_FLUSH_RESET_PERMS
>>>> flag, but in that case we don't care about the 
>>>> set_direct_map_invalid_noflush call failing because the protections
>>>> are already RW.
>>>>
>>>> Although we had also observed that all of this is fragile and 
>>>> depends on the caller doing the
>>>> correct thing. The real solution should be somehow getting rid of 
>>>> the BBM style invalidation.
>>>> Ryan had proposed some methods in that email thread.
>>>>
>>>> One solution which I had thought of, is that, observe that we are 
>>>> doing an overkill by
>>>> setting the linear map to invalid and then default, for the 
>>>> *entire* region. What we
>>>> can do is iterate over the linear map alias of the vm_struct *area 
>>>> and only change permission
>>>> back to RW for the pages which are *not* RW. And, those relevant 
>>>> mappings are guaranteed to
>>>> be split because they were changed from RW to not RW.
>>>
>>> @Yang and Ryan,
>>>
>>> I saw Yang's patch here:
>>> https://lore.kernel.org/all/20251023204428.477531-1-yang@os.amperecomputing.com/ 
>>>
>>> and realized that currently we are splitting away the linear map 
>>> alias of the *entire* region.
>>>
>>> Shouldn't this then imply that set_direct_map_invalid_noflush will 
>>> never fail, since even
>>>
>>> a set_memory_rox() call on a single page will split the linear map 
>>> for the entire region,
>>>
>>> and thus there is no fragility here which we were discussing about? 
>>> I may be forgetting
>>>
>>> something, this linear map stuff is confusing enough already.
>>
>> It still may fail due to page table allocation failure when doing 
>> split. But it is still fine. We may run into 3 cases:
>>
>> 1. set_memory_rox succeed to split the whole range, then 
>> set_direct_map_invalid_noflush() will succeed too
>> 2. set_memory_rox fails to split, for example, just change partial 
>> range permission due to page table allocation failure, then 
>> set_direct_map_invalid_noflush() may
>>    a. successfully change the permission back to default till where 
>> set_memory_rox fails at since that range has been successfully split. 
>> It is ok since the remaining range is actually not changed to ro by 
>> set_memory_rox at all
>>    b. successfully change the permission back to default for the 
>> whole range (for example, memory pressure is mitigated when 
>> set_direct_map_invalid_noflush() is called). It is definitely fine as 
>> well
>
> Correct, what I mean to imply here is that, your patch will break 
> this? If set_memory_* is applied on x till y, your patch changes the 
> linear map alias
>
> only from x till y - set_direct_map_invalid_noflush instead operates 
> on 0 till size - 1, where 0 <=x <=y <= size - 1. So, it may encounter 
> a -ENOMEM
>
> on [0, x) range while invalidating, and that is *not* okay because we 
> must reset back [0, x) to default?

I see your point now. But I think the callers need to guarantee they 
call set_memory_rox and set_direct_map_invalid_noflush on the same 
range, right? Currently kernel just calls them on the whole area.

Thanks,
Yang

>
>
>>
>> Hopefully I don't miss anything.
>>
>> Thanks,
>> Yang
>>
>>
>>>
>>>
>>>>
>>>>>
>>>>> Will
>>>>
>>


