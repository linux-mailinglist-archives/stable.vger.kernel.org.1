Return-Path: <stable+bounces-82806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C107994E8A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04601C251DD
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91AD1DE89F;
	Tue,  8 Oct 2024 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="iQIdhE9E"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F031DEFF3;
	Tue,  8 Oct 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393489; cv=fail; b=czHHxF2QeAagfcNYJN4/7adTvwTi6tgwAn0YZSISTu4aNxhh4po4hyZtnZIjnlv5iC6Oz3g5BV7+U/WgWObrw5vBW5bWfmNErbWsbyr3I2JVHCJ4cpaQ9Aj4MP62rNh+HFE4ksXAam/D0aiDsqjN5w/crR7hkgQnAfiIsNv25rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393489; c=relaxed/simple;
	bh=N0Z+Ggey2eKzqGVC/72swZ2uNd9gRxjAQQU6fkjMQI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UpyRrxfLeBuCPpozg3VvRXaDdfRiEf9n4KEABGlWGir6DZvuB8AVNJr1fRygJL17eacplhCv6uPnXlRrUxiKgcOq3jJashD64p6P040fwDcikRclaXiPzAfLAaZr9WZbd26KVXMVJMqr8yZtlKTzlVk/eZIQWcKQViCNzXqCxNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=iQIdhE9E; arc=fail smtp.client-ip=40.107.105.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ln4QB5ipKZkuzzeKR/7gpdsOGsIgQ0uNgoUf0zeHRc/vd4n9/ziB3m2t/JxuTFM8iterfk240933BmRa+Snt/IHAvAZ4yoLSedSr2YlPKNb7qpDySmuHBluKtQgVHCgetW/1zzfDrNG+OMD6xUYKrba4pEzvo8SJH6zU2vSWweVoA4imL0++c4046z3X0V72ep25EC4WKY1XP4HG5VXgeJ3vp8qnn3go+KxT68uWIEfOi2BDf/LQ8NTd8VLRBMETn/NPMxkOpq/P2+6MckvKCiC/7i9vGURDYc9iY5xieZb0QWnDnIbAkfojVya9madRvqfBwiuVq0sj/8S9zZcSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc35PtGF46CuO/AnilsQKVarwlDgX2Lh1dPcWEShVmM=;
 b=yQB+3XKEyQI7nZPFJMvIFFNjcpEQ8l81OXxHZJMZBTnzTiNTtz4uZCpZGeeOv2u9qby9dnvEKgtvRdo1zS0RDE5Jr8XQDbghfLDlH6NqhwmQ681WZr6FNxBqLHwIfgHW6FuLYbFWWDJLqCdL4d3mBgky9L0PxZ4mzbzzQbONFs2xkcAJ+SIiaHpQ+wjBcZ5Qs3IXq1rBWPofrVLVllmdv/HJP2NlUD7kYohZsi+Ng1+1sllTbRQ08BjkrnbANkHb6/5BqeOKv+fDLaSVbtsDhGXedhAjX4OanlnE0gtW3tAGST6+0Rgtl1lI28XOjr0SLaZl2BwheAvxl9HVuuQuYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc35PtGF46CuO/AnilsQKVarwlDgX2Lh1dPcWEShVmM=;
 b=iQIdhE9EZBwF6vXpXYVKlJS9NQ9l6Hmw5elZRupOZgwq5SS824jAGytz7cEdckQwBjJ/UHZnVSVXXY/AVibFembKJB08EawTNOWrWJGkopINltme3q83Pkucs5+DuM6yOeB/Kr0L63HWsMzpWPk2w1yWjy4U8BjllnPpqb17bhdsuUyL0g9/KawteCVQH1uedVCpIb3DPrmchU7TcL33ttNo+OjZ4vtv2lr1ZUGG8vvONmt9TSFx1TkS8UroCH3hCCShl2tn6bTGElEvuM2lOZrccvnrhTKP0dv+eSP1Wc/JLxIdJorWddWHQCmQ7nPayeEuK1Li1uP11awFErlt4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from DU0PR07MB8713.eurprd07.prod.outlook.com (2603:10a6:10:31b::10)
 by PA4PR07MB7183.eurprd07.prod.outlook.com (2603:10a6:102:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 13:18:04 +0000
Received: from DU0PR07MB8713.eurprd07.prod.outlook.com
 ([fe80::d782:d26:ecb2:ba90]) by DU0PR07MB8713.eurprd07.prod.outlook.com
 ([fe80::d782:d26:ecb2:ba90%4]) with mapi id 15.20.8026.017; Tue, 8 Oct 2024
 13:18:04 +0000
Message-ID: <b923dcf3-1fbf-440e-9b45-9c6535d6a28b@nokia.com>
Date: Tue, 8 Oct 2024 15:18:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: etm4x: Fix PID tracing when perf is run in an
 init PID namespace
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Leo Yan <leo.yan@linux.dev>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 stable@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240925131357.9468-1-julien.meunier@nokia.com>
 <20241007200528.GB30834@debian-dev>
 <93e822b1-76d1-454b-a42f-adf9292d4da6@arm.com>
 <c519631b-e02f-438c-a61f-68fa97583668@arm.com>
Content-Language: en-US
From: Julien Meunier <julien.meunier@nokia.com>
In-Reply-To: <c519631b-e02f-438c-a61f-68fa97583668@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0247.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100::19)
 To DU0PR07MB8713.eurprd07.prod.outlook.com (2603:10a6:10:31b::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR07MB8713:EE_|PA4PR07MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 97632d8a-f70b-45b0-41e7-08dce79ba3fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzlMWjg0eWU4SlNtc0UybXU2Q201UW9tWnkzZ2xRQnJwU21TVEdPZ3NONUlS?=
 =?utf-8?B?UklkMHVkTlFRUEd6SXZjRW1Rdms5VTN2M0Z0VGNSdlNCeml2NmtlSkVobHVB?=
 =?utf-8?B?RTBGTjdvK1h5MnlXVmN1UVNrN0ZvRDQwQVhFNXVQSFNIdFVqOG1mclZ3Q09E?=
 =?utf-8?B?bjEwY0pIeWhDYXExQnhhWktyUGQ5RG5MN2MvMXYvdWJYWDl2TENsYTNkUGd3?=
 =?utf-8?B?SDMrR0JVZWhpdzBvVTMvcm1sNUVUOENzbG8rVXBUSHZtM2ZVdXpVYkRpbktF?=
 =?utf-8?B?OHRSSjJCNjIzL2NRekYvTlU3c0kzRmM5R3RtcjdUaE53RHErSXFBa3hvMS9s?=
 =?utf-8?B?b2JNRlJhVmpnQmhWQThrTkdpWVExSGlHbkQ0amVCSnd5NGFrb1BSNEtpcWhM?=
 =?utf-8?B?SE5JM1NKaE9KVkhiaVJFT2lEc2pLSGh6SkdtOFZEQXI5WGlPa2UxR0VQaE0r?=
 =?utf-8?B?OUROVVJQMm4xZFpQT1RWUk1nc24rcnB3Nm9VVC9Yb1N1UiszZXlac2NpM2Ux?=
 =?utf-8?B?ZG9ZUytPSmd5WmpyNXFMWHFFbEp5Uk5aRlcvQy9Nb3k3Z0xydWMreHpTbGlS?=
 =?utf-8?B?WjlKZE1VeGoxczhGYmNXeE82bUlrdmRiRXlxTk9pOGtYZ1FrTUF3L3REVnJq?=
 =?utf-8?B?QW9CbUI5SWczRkNsazhjNHhRZUp6QkIyaVZBQzNIRHJtMi9xb0xRei9PTjdX?=
 =?utf-8?B?eElocTgwcHVKY09EZ2xSZW96QXg3bUdWenBoUCtWZS95dGc2M1ZoQjNXcTVF?=
 =?utf-8?B?eVZCcWZnODRDK0NRK3NGRXlIK0VGdHFudXBLUHhSWmxOcmtSMXgwK0xCQVE0?=
 =?utf-8?B?TWk5a3FFekZkVlZoNkhIUU1aQ1Q4aTJQdjR2N0ZnUGxXSkZ5MUVJMDZOM2g3?=
 =?utf-8?B?Yk9PeVFZbUQ0OE5LWVM3bTNBWEd4K0hFYTZzVDZuMzVxbzYvNzgrdzloUlRa?=
 =?utf-8?B?VUZoUGV3bGw3VklwN0cyZjIyQ1dueG15QWRTdXRqM2dOKzFXaEJCcnBzQnpW?=
 =?utf-8?B?WS9QRXpCV1VjdmxMWllJUkNveUUxbHp1S0ppSlRROHVkaFV5ZVFxVDNVcXJa?=
 =?utf-8?B?bkVXSHY2OHBldGNROFc1QloyQmFxV1JhS1VyUi9GN08wSXM3N1JQOWZ1L1cw?=
 =?utf-8?B?djl3MFE0aDNNNE9VM2Z2MWpjQ3dodGorRmpidUhkaDN4OVJCUk8rWlZaQW5p?=
 =?utf-8?B?NWlWNTFLWlltNDNHV1NoQUhkOG1SWVlUOGlzdFFUQnNFSzQ1endvMXB1eHNm?=
 =?utf-8?B?UUpRcmpIV1l5RGRYdEtOYXoxUlhzSEtPcFpOQjRJS1ZJcDEwaXd1R3VjSnhJ?=
 =?utf-8?B?cE56SlhocWQ0Y2lrWVMvNkZaU0pFZmtZbjBzMDBZcFF3QldSMmlvbVBYSEpx?=
 =?utf-8?B?WHlyT3dPWFRqVjFoTVptZTFGOWlvUUgwcXgrVkVrREVMenBDODUrRVdZME9H?=
 =?utf-8?B?UStQT2x3Z0RzL0UwaGhQandqNnlRNE8wbDBVVUcwQjJRS2RjcyticUNrWGd6?=
 =?utf-8?B?cldrdHQ4WmNRSkxtZnlUcVJuRmxhUnVLcHozeWM3ZnJLWCtKT21nT3cwdWxj?=
 =?utf-8?B?TlVZRTQ4ZFB3R05ZUkxYa2hZK1RwcWQycGFTcDlZa2FhUEFHanRLOXdqOEZO?=
 =?utf-8?B?OVN4ZHBqZG5iNlQ2SnoyNDJBVWlyOE5xbWVndW9JWTFyd2o0VlJjZXROaGlr?=
 =?utf-8?B?eEdib3daZDVRVjcvTk5YRnpmU3dTNFQ4UlhOdUt0bnJBYjhJYnlrMzN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR07MB8713.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2pYcGZvTU52VFBWYkpzTWlvT1UxMCt5a1NLZllpMkFoS3VkRFllc0pnUEZH?=
 =?utf-8?B?cWF5U29xUkJ4QkNSSFZZV0ZXNXVsaXB6azIrVDVUeUdFQnNoS05FR21ERU51?=
 =?utf-8?B?dno5WFU2YU5TbXE2eW9WTmhTWEFYYWZ0dWNGYlNPQlgweWRkKzdmRUpZMjNt?=
 =?utf-8?B?RFRBSllvbFV5K0Q0bTVTcTUxWWNxejh4QmhaNU90YjRPV2g3M09zR3hJWEtD?=
 =?utf-8?B?OU9wWFhOcHdBV2VoSmM1Qk9TRkN3NlJFUjZSc2FEOXpSNUpXbmYwWnU3UHM4?=
 =?utf-8?B?MFBVNGR2cEpDMHVWamdpY1QvKys4MVh6UkFMSUtmcjIvQnBqeSt6ZERwd3B0?=
 =?utf-8?B?N25KUGZMQTBYN2VsYWJwZDFRZC9jSmNMNDhEM3FqdnhXN08wOGRsQThsQ0Ju?=
 =?utf-8?B?cnMvZythNTJBTlJDUEdXaFRUTGpGWjNsRDhVY2huMEdTT0FnWG5WOG1NdEVY?=
 =?utf-8?B?dzlXZFphVW5qTUM4UjZEUWcydzBnaFFYVGljdFU2VG5pK0JNRVRvY3RZWENv?=
 =?utf-8?B?MFVYUmNzOEZPSE53czZ2aGRVQUEyZDdUV2M0TDk0cTlBRlNIWGFHcHJ6ZWpq?=
 =?utf-8?B?MDJUNUJ5b0s4Yk9vRGtNdVBlZE54VXUrZVdMSUxCSVVKU0phY21DVW9TODU0?=
 =?utf-8?B?cS9UeWxmOVBHV2Jka25GaHRaU2Z2dzcxeFIwaHBrTW51S1BXMXpBdFBnZXBH?=
 =?utf-8?B?ckZNRkFQWk1YU1VaZzJRNTRaeGhNU2xpelVBaXNkWjVId2dPN0p1d3F3QmF6?=
 =?utf-8?B?YmRFbnVJdktqZFZyTkZNUElkaE5yWlREUVl6VUpXd25ZQ1pDNnNUWlFGbkww?=
 =?utf-8?B?dGEyVFlUck82R1JSamFxSDIwMjNwOVJ2SSsvZ3NxWkZ1MENRU2haUmR4Z1cx?=
 =?utf-8?B?RmtsQUcySzhYcnNyVkdFL2dxNTVPQlFXRDQ4bngxMHJWZTA3TGtnWmg4REUx?=
 =?utf-8?B?TVFObitHRjhOOTVxY3JQOFhhN0ZBam15VmxNZEJtWUVkMDVyRzNQSU9VSDYx?=
 =?utf-8?B?bFNMYjJOK3ZKQlhzbmpMelNZLzAvdEdqL1dvd2ZoWTk2ZnZKYnB3SVY2TTEw?=
 =?utf-8?B?WWtOSHpwcG9GZ1VTV2FmbEx1cnJ2TTB4RmNkMExnY3ZxV0dvVGczK1Y5Z3RW?=
 =?utf-8?B?Ty9RMVBuTzRId0c3QWhyOXJRejJMV3p1anlWb2srU3JwdzBPeHFRN3BXa1VI?=
 =?utf-8?B?b3BUbCsxMysxYUhJSVNyQmdyUmQ1YTdTMWdJK2pGUHJxSU5PSDYyU3BnMStr?=
 =?utf-8?B?SEI2c2ZVWXFwei85RHF4dW51bGFwVGNGREhqQlBKOWhmV3hZNTFLVUZNTmE3?=
 =?utf-8?B?Sjc0akFnT1lGOHBaN3c3akxTYmszL2F1MC93bW82VHVoZllGMHVhWDkxTTJs?=
 =?utf-8?B?bEMwUFRzc3E3QmVxbkZ3VXhOTzFmRzFYb1dLdlBpOEQ5K3lDTUVCRXd4Wm00?=
 =?utf-8?B?ak5UaTNlRmhiQWNLN0orQTZLWVpDT2RhMkppd0ppSm5uQ2NjTlBEeFM3bG8w?=
 =?utf-8?B?WFRMd2JSUU9RdFpNcGgySGlZWGhLdnNjYU45cm5wSlVNRnZEODJlcjdGMmJG?=
 =?utf-8?B?a1AwaTA0THdSclF1WitkL21XTTZuc0t0aDd5dUtKQ2FKUGkzenV6Y1V2YXFL?=
 =?utf-8?B?cFhuSmErQmdUd085ZjNONUFJVUN0VTI2ZzhSSDRFQ3U2RjY0ZkY3RElFUUZ2?=
 =?utf-8?B?a2xwUzR6YXJ5QzlKTHF1dnhXVFA1dUxVVzZkNWpaL1BQYzhmVGU1Tm4rNVdN?=
 =?utf-8?B?TGlkMWdLT3ZHTkhLQ0NLWHN2MjdIWlBiaktKcStjRXd3TmpLUDZxNFdUb3pJ?=
 =?utf-8?B?RVFLM2xHVHE0TTRHTk9vc1NwWkE5YjkxRGFyQ3Q2YlkzVzRVclB5WnNRTzlq?=
 =?utf-8?B?VVZTUFQwWnZ1RTFlbnJDdnkxVCtMZ092Sm03Nms2Y1ljSHloeTRpQXNRSzZ2?=
 =?utf-8?B?YnkxK0hxeDRpekkvMWkrK0hNc05QamNpbkZnMjgyLzF6WlNyNy9kdU54M20w?=
 =?utf-8?B?bVpDSVNiSnovRzRpOUJOS2ludVFzNHdyeVM1UStTRVhtT2hHeFNxTnQwK2Np?=
 =?utf-8?B?Y1orbXorajNTY0lyb0tuOVZ5V2NDT2I4Z1AzTUZDd2EzYXZsK3I5YTFPM0NV?=
 =?utf-8?B?SmQ0cWJXMTQ1YWkxUERyRHMzT3FMQTUvUlIyUnVVR3MyYTA0SmJVZmxBekVq?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97632d8a-f70b-45b0-41e7-08dce79ba3fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8713.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 13:18:03.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F33ORDX1amOx9WvGBIrZtcxIGYBn+9YA8LMi72JbFmglF8fmgLLR2ddnBZV7icoX1dgWUgsqbqEgIlW35/ZHxl+dKETGB/jLv9RBB3IwCdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7183

On 08/10/2024 11:59, Suzuki K Poulose wrote:
> On 08/10/2024 07:52, Leo Yan wrote:
>> On 10/7/2024 9:05 PM, Leo Yan wrote:
[...]
>>
>> I thought again and found I was wrong with above conclusion. This 
>> patch is a
>> good fixing for the perf running in root namespace to profile programs in
>> non-root namespace. Sorry for noise.
>>
>> Maybe it is good to improve a bit comments to avoid confusion. See below.
>>
>> [...]
>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/ 
>>>> drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> index bf01f01964cf..8365307b1aec 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>>>> @@ -695,7 +695,7 @@ static int etm4_parse_event_config(struct 
>>>> coresight_device *csdev,
>>>>
>>>>        /* Only trace contextID when runs in root PID namespace */
>>
>> We can claim the requirement for the *tool* running in root PID namespae.
>>
>>    /* Only trace contextID when the tool runs in root PID namespace */
> 
> minor nit: I wouldn't call "tool". Let keep it "event owner".
> 
>         /* Only trace contextID when the event owner is in root PID 
> namespace */
> 
> 
> Julien,
> 
> Please could you respin the patch with the comments addressed.

Sure, I will send a v2 with comments updated.

> 
> Kind regards
> Suzuki
> 
> 
>>
>>
>>>>        if ((attr->config & BIT(ETM_OPT_CTXTID)) &&
>>>> -         task_is_in_init_pid_ns(current))
>>>> +         task_is_in_init_pid_ns(event->owner))
>>>>                /* bit[6], Context ID tracing bit */
>>>>                config->cfg |= TRCCONFIGR_CID;
>>>>
>>>> @@ -710,7 +710,7 @@ static int etm4_parse_event_config(struct 
>>>> coresight_device *csdev,
>>>>                        goto out;
>>>>                }
>>>>                /* Only trace virtual contextID when runs in root PID 
>>>> namespace */
>>
>> Ditto.
>>
>>    /* Only trace virtual contextID when the tool runs in root PID 
>> namespace */
>>
>> With above change:
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>

Regards,
Julien

