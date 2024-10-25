Return-Path: <stable+bounces-88187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A489B0C4D
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1D5B1F26568
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E021F76A9;
	Fri, 25 Oct 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="I12aFXH2"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018A18787C;
	Fri, 25 Oct 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878969; cv=fail; b=hYQY8O4ZqO4bp88eemH6eyyV7IQOA6eQmGxpFjxjVdlPCU6vPcZZ4X940D6ijc22CNpGCIYYPulZSNxznp10NxpFQU1MQhPokRPIhSGoQDjVlmvuOsKAJmBdaV22N74etw9IrsjbAbdgOujWhJPSkZtpAwHGnuP5To34GUk2INY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878969; c=relaxed/simple;
	bh=6aOr5tlQykbYJ6tC/l7DSH4qIdO/sAQglFs3Uu5uotY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mCp53f5T11wZT042/GfZfk1FG+61WhpLufB+FS7QEKlR42AUYEgJI906Ho98GdtO2qdkP7ObTJnVIPJUJb244g4Q1kSR3mKQHID+x1WGvpCpNyskALiMS9FBVww5xke9+ymrIVm2CVEjpJj2bTMlMEJGAlS7KN/fWOxKwNdsVkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=I12aFXH2; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjRBRpevpsqVaQmfD1W7HtPPkY26HOKnWfus8iISOn1akKkZyzqjIoCXsM9U1K1HsBuN0PdbA7WVrCtcGjWalYRoM0gIy63m1xQAhFvyazA3VdFktTXPsbpCeQdtY4f3o6Q8st2M9b4/Veid3MLw58sq8DW75/l04mSThlKbY9iV0TQ6MBcjXPZ+Ts8OzIzCZBEFONffNXVwCpy7PgyCAmx3apUvs6eAs9dlg0a4h3mZqi8i3UvjsJMYr27SjHow+wfTogFV30FQV9ggZYApWfhVQT+0o4PLzLsj4G40/2x/xX/o9B1tpOhk81XTPfklsLPRfcMUwzI5sPp7RIIXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c72SiBLt0tBuPnOw8Bs7K/LpjWQt7+kt3UjKDT8o/Js=;
 b=REw+0v/JdaPitQVqoFXrYB6jUV3DriTyG7KJotOPvRhC60sixn2vIRID4lo+bMgtNHyuIJ6btnA+FzlGN+mxgwMjRlIrAG5WdkhM8bCh+Sjgus1GHh0lKQsxhJgk5RwgCwHHaIZZwuVWPMEofGbx6I/uyIaxFovQnqB0VGP3vLQAMlZ83pZkvb7tSSfKQ51/E0am1epVGwaeJ/fyiaOXEe5GpAhdK5UQdRz1ytzKKePHLpgZVuz5ljehorzHAWKjtvMdh4xk3aM+2gjSZVP9i2W9oFItI9NqCNjaiANLGyvbXPphJmDoacYEovKHGblL4yx41h4pTyQh7YBzIEJiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c72SiBLt0tBuPnOw8Bs7K/LpjWQt7+kt3UjKDT8o/Js=;
 b=I12aFXH2SYupWzpakyAwlv9jv9q/S6T08p5zUjCgDOBo2yBfwJ3516nQf7JiZkEoodzRWmNM7qCNkUb6lOuUVKV9SwyjjKEHICuFxwV3g+1wTQpczWYL6iLYlqri9+bUXrK5j54koFDycHYQ+U4qwHHS3gZhJBvJIzXNlK19FhXVdhU/GD4mmXubDRl2ef5UsKvVaCosGrRz7yR6wrD2+4g9dqv+XBe0Q8Y9sDoge6gNY2zSfUccvVfSV1Rs2Xjw3GpQt5OrDreP8yzoleZUzQ69RP6uYQvTtlwXd2gArMjjslnooBL2NtXXYJQOzf4t2oGgSUXqXu9TISXLrYnmJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS4PR07MB8707.eurprd07.prod.outlook.com (2603:10a6:20b:4f1::7)
 by GVXPR07MB9984.eurprd07.prod.outlook.com (2603:10a6:150:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Fri, 25 Oct
 2024 17:56:04 +0000
Received: from AS4PR07MB8707.eurprd07.prod.outlook.com
 ([fe80::887:2f82:171e:f1ca]) by AS4PR07MB8707.eurprd07.prod.outlook.com
 ([fe80::887:2f82:171e:f1ca%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 17:56:04 +0000
Message-ID: <33988463-9168-4ac5-9061-8bba6e2eda37@nokia.com>
Date: Fri, 25 Oct 2024 19:56:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight: etm4x: Fix PID tracing when perf is run in
 an init PID namespace
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Leo Yan <leo.yan@linux.dev>
Cc: stable@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240925131357.9468-1-julien.meunier@nokia.com>
 <20241008200226.12229-1-julien.meunier@nokia.com>
 <b1b17552-646e-42e8-bd00-9c7ae6835612@arm.com>
Content-Language: en-US
From: Julien Meunier <julien.meunier@nokia.com>
In-Reply-To: <b1b17552-646e-42e8-bd00-9c7ae6835612@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::12) To AS4PR07MB8707.eurprd07.prod.outlook.com
 (2603:10a6:20b:4f1::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR07MB8707:EE_|GVXPR07MB9984:EE_
X-MS-Office365-Filtering-Correlation-Id: b4d54e90-b1a5-4dc1-bf7c-08dcf51e4b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkZhc2FtQjhVUmYxWWdXQXM0RU5CdnNZLy93YWlWb0FMUUNUUjd6WVM4cXhr?=
 =?utf-8?B?OEJTMHg5STc1YTE3ZEVjRFpwMGg2RnRyRHJ2MEtPU3ZxWTJhcmZrZzg3OVZa?=
 =?utf-8?B?MnN2aUpublFoVUovZnIrTjdJeDVmTXpGSzZPM1BuOHpPQmpDRnFjTXBqcWg3?=
 =?utf-8?B?bGtWWVdCdXBRVDcvaWNZeTVvOTN2RnNMK0dnUGltOENpaHhvNUN4WVo1L2lj?=
 =?utf-8?B?VDRSUm1tdDRVYUVORHIxa3N1YThyb09nVnNHOEdWYVAwc2ZNc1cwcUVacjU3?=
 =?utf-8?B?TEh0dDFDZjk4eEZmMDhmYTJTcUk4L1M5Nkg0dTg5Rjd2L1ZvdFF6UkRPTUsz?=
 =?utf-8?B?TXdZYjdhanZrUzJYb281MWpzaTFJMkdsd05FYmFOQ0hVVFpRWUhyS3JObWsv?=
 =?utf-8?B?TE15aGdBUEdXMnhWZkUyeEIzN2RpV1U0TzNpSERjZVdEYWVFb1VBYy9uWGZF?=
 =?utf-8?B?SlJmZUhJM0F6cENlenZEZ1VVRHpDRUlvYnpreW8zMnVaMXVkc1R3Sko4QTZt?=
 =?utf-8?B?VWYrdG54NVRtbmltOG0zU21RYS9za0JjNFYrZDByRWx4VG5IVlE3c2Qyc01Q?=
 =?utf-8?B?WVJmYlg1dTZ2T0lleWRrTldJbUZaSjdDckVDdEwvWnFlY2s3azJkT2lOTEdG?=
 =?utf-8?B?QUlZUUlOc1hDcWIyUWdvaUJVRk1pNVNBeTJ4Q2IzdWQ0NEw4YkhLVE9kYWRr?=
 =?utf-8?B?OEY5b0hFU2FlVnB4bmp6SGJCaU9XVkJBUitBcCszOS9zQjYrQlI5OVlRWU1B?=
 =?utf-8?B?NFpFVTF6SzFPR1lubGF0VFIrbHNHb0IwUzlPVTl5ajJKRlBiaXBKUWMrL042?=
 =?utf-8?B?WnBUdWllVXhRU3FubG9odUxTME5ibGJyeERZcHM5SjUwdXhDUUhiazVXQVJX?=
 =?utf-8?B?WkFRNmU0N0pFdVNRZFlOYmdXaU1KUGREeVU2OFh5Mkg1SUxTQTRCQng1WUho?=
 =?utf-8?B?WUFMRU1zVk9hRTVGdUpUT3BURHdHY29vNndQNG9RQTg2SENGK0JabFZZbXdL?=
 =?utf-8?B?K2EvcTcxbmticDBKdy9iaE1ZeDR2UHBpNDhHYUZRQzhMUHB5dHFZWWxyZG83?=
 =?utf-8?B?ZzVnRVRsYUcyY21HeGVlMUFFdnVqeW8xaEZSMzlHNlFXOXkvQkJVYXFLQXRJ?=
 =?utf-8?B?SStNaHpYTDRoQXlzeXhlME43R2VUZW9YOTNYTUpteXQ0bUlXN0FGMm9OcEJ3?=
 =?utf-8?B?YkgzNXJPY1d0SWhIdmJ0WnNsOHdHMy9HM3JBRlV2YW13UHhSUW56QXZ3TXMw?=
 =?utf-8?B?ejJrTEVTNG1EcWxrOEpRY1I5NXBzMUQ3anMySzJvUGdjS2NDbTJpdXJBVDVl?=
 =?utf-8?B?cHZkOGx0T2lNNWFlY0tlOFY0cFlabWprSCtCU3MzL0U3c2JreUw2UTkweFF4?=
 =?utf-8?B?K1dxbUtLWXk0SHZvVWRIN1VPN0hwUmxiMG9wWlVkSC9oK3J5MFprcmI4SVpu?=
 =?utf-8?B?T25VWXNTYjlmRWRFOWkxZGFJMjRUVngyYUNvWmc0SWVMUUQwNnBtNjZQSFZZ?=
 =?utf-8?B?Z0FQQjFiMjRrYU9hakx0L2VRaVRKdWlVZHhFYVVoYklxSHNaTm43UU5XR25t?=
 =?utf-8?B?dFN0MFMzRmdFeWRaOEg0SFZyMDJaYXROcmloek9TMlJMUWFJWHE4OUVlUEF3?=
 =?utf-8?B?Ylhsd0ZwWFNESm5DTnBkNXVqU1hVUk1HUTByVzZRQ1BCTnFxYWR6TUoxTjl6?=
 =?utf-8?B?bFZqTHE4V29MczVQOGVLWHcyUktINVhCODU0RDVYYzZrVE5OdWRFVTRCc2JO?=
 =?utf-8?Q?S7a+2VMQ0CHIHzRd6UPCam8EVe31UH+ZuF0Aygt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR07MB8707.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHJubnUxanBvSjJnUmpVQjNZdVZYd1YzZVRGSTh2WG9Pb3dpQ2ZsUDF2a2dC?=
 =?utf-8?B?NmczNjZsRkR6TnFHcGlkQ2VOTWxiWXRGNVlvTFFBdDRqWEo3S0h0ajJxRzdC?=
 =?utf-8?B?VjJJQlpPRjFOM0pCWkpla1ZKWFhtN2tCTnZiRzZNOGZVM3I0RDJpanZkWjRJ?=
 =?utf-8?B?SzN4VnJTVDdGbmRJSllUYWY4eUZneG5XdnEyNnMveDJucDhyQmxwOVhPWkdK?=
 =?utf-8?B?UFJCTkZ5bXBPVEZBOCtVakFYU3F4SU5sVmNNL2JIVEpIaXlDN2Y2UWpuT2VZ?=
 =?utf-8?B?VllzOGQrcTFWR0Fqc0RmMUc4R1U2SllucmwyY3Q5bDdFUmlLQlNockR1SUxI?=
 =?utf-8?B?NTM1azNoWEd6cHRGQWlVTFByak9TM0RUY3RuRTEvM3FtTDJOckhYMmQvbXNm?=
 =?utf-8?B?Qm1ibDFSQU15WU9icm5JNEpkYlR1RkJLUmZzNEdlZWxDZU00bFZPNWF4QmQ3?=
 =?utf-8?B?TTZIUm13dUE4elFkNWROaHNRR2FLMFQwTHNWV0N1eklxRGVvWDlhSHBKeVUr?=
 =?utf-8?B?Y0lYU2R4RFBiVThSV1d2VmRFWWtNWm9CemdFaE9vOWxmTUFwVSt2aXBBdkpH?=
 =?utf-8?B?dnpRTkg4VlhhODRYOWZiYXlLV29zVGJYK2ZNSnY3eVJnVWV3TUNhT2ZMT05D?=
 =?utf-8?B?UlU3MlgrUTVLa0Znc1libTZzV090R3R1aWZsRk5rMFcyb2RabmRFSjFFcTZj?=
 =?utf-8?B?YmN3dUtOSHdQU0VyWi96OFltQ3c1em1nWmQ2MjdVanVuK05GTnVYNVNXZVlU?=
 =?utf-8?B?UWUzVyswWi9NUjdMMjFQSjF3cm12MnpiTDZHUnh5SFhWeVIxeEk0NkZ2UmVS?=
 =?utf-8?B?a2prdmRvR1JQaTNNNWtvOVUwNXF3TmNqMkhzekhlNjJBSGxUeDZpeUozbFVL?=
 =?utf-8?B?Q2x2bnBITkJJZWUzRVUxb3BuOGIvZTg1N1dPSGJwQ2lDQy9Cb203bkxsK3lj?=
 =?utf-8?B?NmRESENOOEJxRkdtZU9pd1F2TEFWWGNxUVZkZXlIb3NTQ3NsVktEZUdjSTFO?=
 =?utf-8?B?ZVZ1OTdxWkVXTVBiaVIyLzMwczcyQ3liakVyQkhTZlJSMFJWZnc0QUpaRE1K?=
 =?utf-8?B?TThUMVZ5d21EbldhaDVuRm9JTkFteXBCU1hveWF1R0NOMXVsZnd2TnIxWGhG?=
 =?utf-8?B?YkpKU0pJZ1NhTDRJMkgxS0d5TFNWekFySWttcVlqYXRoQlhabW5jQitVSzZl?=
 =?utf-8?B?MXdHaWx1dkhiRTlCMVVIOUErOTlKZ1ZUbVZNM1dvZXBKUGdZdXZQZXdGRkxi?=
 =?utf-8?B?YnJrVzFleEZ5aGNmdkFBdC9MQzJDYlVwL2RESFBkYVlvVWdzTXJQMTljS1Rj?=
 =?utf-8?B?d0RFcmtheGJwbCtiTjNCaDJLcmllbGJ4Rm54WklVaGduUDdxTU9yUzZDUXV2?=
 =?utf-8?B?c205MnZ3V09oTkdwU3ZxUnI5cEY4Vnh3ODlHZ0RId1dxdEZyS04wUHBQdGE0?=
 =?utf-8?B?bThpSnRabTArUStsdkY0a0l4aDBkTk5sTVZ3MlhFQmdqV3lCNUdKdzlKWTJW?=
 =?utf-8?B?WE9acTRpczUrQXlkSnhjMWtaQXFnMUdjV2ZkRlR0WHYxOHlGOEcwakppR0k4?=
 =?utf-8?B?WDlKMnQ3Y2NZbGRCWWo1dDJmWWd6UTJIT0JrdUtBU256YXMvY3JycEtQT3Fv?=
 =?utf-8?B?RFlYWXpzdXJXdzJIRU00NzF2cDYyc1B0WDduZlE2MHRCZWQ0MzRNSUZQbUlN?=
 =?utf-8?B?ZGhIMS9BeHlISHJRa3BzUDVQcEswNFI5OU9VRXdRRnZpZXhaV2F1dnNDVkx3?=
 =?utf-8?B?QWJIZmNLbkZCY2hXZm5kd1U5N0djNTZPZmVXeVhLeGhLU3p3Mlk0S1o4cW50?=
 =?utf-8?B?elc5b1lHQm8ycmR0SFVPR0NXMHFhQkRWNGlOWlJ6OHhwbnNHdUk1Qk5vM1kr?=
 =?utf-8?B?OVdGZTB1SHpGU1hHa2ZoaFBoZUV6aTlzUFB0YXFYVkVFdkpUakQxRXN2UWNv?=
 =?utf-8?B?elFIcEI3amNnbWhmcW16TmJTbHVTVDQ0Ni9laDBsT3IyOXQzRWFlZ2RWc25r?=
 =?utf-8?B?NGNIZmQ2dm92ZTRQK08yRU5kcE0zaDZuak12RWxPR0ZiNjhRTTRlMmtnMUw4?=
 =?utf-8?B?TU4vZmFzZUxjRjVDRWo4OGRzTXdzamV5ODMzVVhUVDB2eTJMejVVdkF6d2J3?=
 =?utf-8?B?WnhmM2hvR2wrdWFyZGV2RHN1WmdvZEtKb3h0MmhHbTZPMTdkVXJUZkoxNHFL?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d54e90-b1a5-4dc1-bf7c-08dcf51e4b2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR07MB8707.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:56:03.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+FGaYOEKFvlX+pqHKPY93eCEU1M6TBz2N2IqIR1CjuhFNwm+yXfqoUjj57S9iKdmWtT8Rt3fiF5CG9H1qK44sb38vh6Yyk19MqiO51bUWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9984

Hi Suzuki

On 21/10/2024 14:31, Suzuki K Poulose wrote:

> Hi Julien
> 
> 
[...]
> 
> Unfortunately this is not safe. i.e., event->owner is not guaranteed to
> be stable (even NULL or an invalid pointer) (e.g. kernel created events
> or task exit raced event_start on another CPU).

I expected that event->owner was safe, but you are right. During my 
tests, I essentially attached an existing PID executed in an container 
(lxc), so I was not able to detect that race condition. I miss to 
re-validate all the other usage of CoreSight.

> That said, one thing to note is that the ETM4x driver parses the event
> config in each "event_start" call back, instead of doing once during the
> event_init. If we move this to a onetime parsing at the event_init, with
> additional checks in place (e.g, !is_kernel_event()), we may be able to
> solve it.
Thanks for this suggestion, I will try this approach and provide a v3.

Regards,
Julien

