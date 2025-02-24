Return-Path: <stable+bounces-118781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FBEA41B8A
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5031F1891C7D
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792F194AD5;
	Mon, 24 Feb 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="SKLzL1/s"
X-Original-To: stable@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE2202C47
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740394022; cv=fail; b=GdUdj7tMz3KwRcrmYfBXzZ8eVY1LlRz+PK64zUYcBG0CerSfUXVpYtpyx1aPsind9BIAa1nH90vfkNEyQne5xm9QNQC2OkjtG10+SNLnpPZRn+03mNCP6HGsWXud3TCkLDJrMQk9+zM1mAB8vhsAdyCRQ/h2TGbYp91fqB7f1RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740394022; c=relaxed/simple;
	bh=2HCELV2/n3KK01A28ORDHZm+ze8DirWnHe02JB4LG9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JTjKJOGIOFR2cekifNwtqszodpWx1kFWMmOTq+YKBd/xYSjyf/TQ6+eIALlH5mbQTyy8VjvF1+lun7agi2dMJ/bOYAZzxXbdstzZeTKJbl2f9DANWs/FzuWTIXeBCwuOhxyxxFTZLDkYC+chzkwZo+rhRlMK/sd9WwHWlgJH5eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=SKLzL1/s; arc=fail smtp.client-ip=40.107.105.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ST5JdHCthhk2fsVP7H9OzfTypkezLzw+C4iiSmfC71LWC+/JruX6k5+m68iNXu5Wton7kQ0MJgxqAHlvxEfS1nDJI6xhiL6MmqU6mXcJCQmiF0U5a/oHiDL50fFO4R9s0F2qaudZ3kniM9Fei4nWDFBRJNiRb3Y2tqiwkOkz0UAO1Iw+o0Kzvf29EL+D+CseNFy9mVh+/gwB/JQ8aLwHJ9WByWCQDC+QxkE/tKD+pDu33gLsXjQRbGDVzNVMg1GOXv9l3rxVIMFqJUim6VQGHIsdcNeA9g2XTHUtUp/EhL0VXwrtN9ugKNTJ1ZgjJzRb/dfAlyxyQjTaDFyc5GQCjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkZ9ocwIfAZLlWTPyEjZGRO/+9myED1J9wKQdMvtdXs=;
 b=jwaA3uN3ObPeoiYeM8ShojuSQsHXTWwQgmAQUP+Rj9gKbDhSCUbdh63e/4kin9x3IqwHtPtS2jXPdBLWzjcryALr6BtILGdT9J6tTL+1YBIf8jMoSgzl4krm8t845LnHjucpxdfgMHag1hB8epJ+sgQNeevO1pEYzCZoZjBFCRlZNyHppeuXSy0asuojhiBDc0P0WDE1RHnRXdyqKiy4+uP5RQFWL+z7E53ZzrwDUafLy0CYqinBa5hupyTv9WP0f9PUhpXAhtOHUVmDH6CC0cR8sjCpDqVF0Xnuz/dIy2OvHiam3AgEUIlN6+BeloVy8b91gVWvIFSgrp3BSh9ZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkZ9ocwIfAZLlWTPyEjZGRO/+9myED1J9wKQdMvtdXs=;
 b=SKLzL1/sk0oCwuAcM7w8WbHmg/g8wViLXBw02X+3PfsCBhcU0W+dvEuuqVRFAe56VqUsC30sqTkwlXmpQoujqxVgl8pMNj8m9c+Y5F9WkupjA9L89UDMmH7hVtOu4t5sKJnhbMovbXIbGzHsOCqvxEsrm4+JQ5vZu238dh0DFaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7540.eurprd04.prod.outlook.com (2603:10a6:20b:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 10:46:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:46:56 +0000
Message-ID: <ff3a6ebe-1723-4879-8c17-561c9ea5b9c4@cherry.de>
Date: Mon, 24 Feb 2025 11:46:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] arm64: dts: rockchip: Disable DMA for
 uart5 on px30-ringneck" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, lukasz.czechowski@thaumatec.com,
 heiko@sntech.de
Cc: stable@vger.kernel.org
References: <2025022438-automated-recycled-cc12@gregkh>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <2025022438-automated-recycled-cc12@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: 66547904-a511-46ae-f8bc-08dd54c08ebb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFpsdmVhV25SazV3cmhLZkpuWWdEdzFwWU9wcXIramJPNUowSkdab21zUWNq?=
 =?utf-8?B?Rms0ZjVUMHpsMVpaV0VFakRkN3VuSlZmQ1JJVVg4QnViQUFTbkFaeUNIRTZY?=
 =?utf-8?B?TXdhRksyMHRwQU02cTN5WXJyRlBrUUs2UXNWTnJRR0pYeXpRQW4zeDJaOEVt?=
 =?utf-8?B?OGNJMUxaYmNYRDFMK1NJM1ZiR1lnbWYySFVoTXdmeHRaQktoYUZzcTNxTDdL?=
 =?utf-8?B?SDdRdUplejgrMHNnU1E3cm5DUklzbEp4WmJUMTl0Tjc5anUzeHVTK2FJZ1VR?=
 =?utf-8?B?WmQyYzBKdGMyNzJyNjRpWjJpYXh4YmMxdGs2MXNXNzhFelVMb1B0MFQ5ak5D?=
 =?utf-8?B?RVpJQlFkem9WTlBZc0IxdGRQaTZNQWpEVk9MM0JqYWg1VjlSWkx3N0pDMkMy?=
 =?utf-8?B?WERpNHpGbzZnUzFxeURrekVJR2lPR0tQcEpySXdvaFZTajdsREp4WncxdWJT?=
 =?utf-8?B?c2hiOEM0UlNaUzZJNkJwc2dEaDhkdlh2VXFleFhKSktudU1ibDNTeEsvZ0lW?=
 =?utf-8?B?TnlOOVhUTFg0ZVNqa1NYSHVaVmNMb3ZPMjl3M0NscnJkcHNyN0F6REZYbmJ6?=
 =?utf-8?B?Y0xidThOcXZGWnZxQ0lRa21mZUJMUEl0SFAvU1RMNVhZSm1xb1c4QTZMeUhX?=
 =?utf-8?B?c2hDNXpINnE0Y1hYOEhQU0xtb0V3bTQzMGgwK0srMTBZcVlza0dxWUxROFBp?=
 =?utf-8?B?UldjWmMrd1pmT3l0RWVmRFFwWndTUk16b2dwUzdGZmJVVHBnRGFuUFoxUk5F?=
 =?utf-8?B?UzhlYXVnVmNkWldPOFAySWdBYUJUYVZXazAzMFNoZFZDc2ZRSU5UbHRILzJP?=
 =?utf-8?B?OUNrb1QydlIwM0d2Q0V0RmtVUG9FcS9xVW1Rak1tdjJUUFZzSDhyZmgxYlgz?=
 =?utf-8?B?OXNISFprNkNHY3dGZCtoMWpjNkYyV3ZJeTJweDV2VlhyTDloYWxIbXYrSUhi?=
 =?utf-8?B?RG1YRVhDeE83ODg0M2VseXdQeFcyaGVjUU1JcVR6U3VoS3FLUDdjVnlLbXRQ?=
 =?utf-8?B?UUk4WHJBWnRrTGtWM1F3OVJ4VWNYeStZWDJaVEp6MjFqbjRoSCtyWW5adHc0?=
 =?utf-8?B?NnYrNC94aUxxWTlsSWgwUUlGOTkyeGFtSC9PcWJsN0J6MUNPYmd4ZkhwMmpn?=
 =?utf-8?B?WmszcWVLcitwVTk5R2h4M0FBb2E1a2dDSlVHQXFLQmVicGIvZDlwamlITUU4?=
 =?utf-8?B?ODVJWE5SNmROY3RxbDBtQmxTVEhsekF4cmRLMHFzRkd6bk5uMzExLzNFRmZT?=
 =?utf-8?B?bVgyWlhZNnYwTkhFSU93cGU4dkdSNGNPREVlbHAzOGNPcWhoMG1RK2xrOUJn?=
 =?utf-8?B?UkFtTmtjRStEdXBqMnBiaXFBT2ZrTjV3VG9RQ1FvbngvbGRkcncxdkR1VjJ4?=
 =?utf-8?B?MnlKZkpKeUJoQ2ErNzBoazFadFhmaFJ2dHN6RnFjRFV6VjhGL3BUN3BROWYx?=
 =?utf-8?B?VmFWaUZOUWs3cjdkUUtjS2ZwazhyY1k4azZkNUJmYlVHblpraFRldmxmbHc5?=
 =?utf-8?B?V0cyZjg3cmd0Nk1UMklOYWlMZU5DanJ1NmQ2a3JRdVdSRVUrU3BNSWVsQ1JI?=
 =?utf-8?B?eTJxNnowalBDdUJWZjl0UmhOYWNWQllFcS92UHdLZnpTS0JIcTY4UXdyaXY0?=
 =?utf-8?B?S2xUOGNaNFc2aVU2OFFMYXJlK2U5VXBnSTZpRFZwS09Ed0NTQ1FTcGM1UWdT?=
 =?utf-8?B?c0dHSG5Mck1LcnlnajN1QTlHUU1MQU5YVWVBMUNyVzFNRk9qRHR3cHp4cks2?=
 =?utf-8?B?cSsxRTJYZWFHWi9iTWkxc1Z5M3Z6VUJpeDVTT1pSK21yZkhkcXY0OHFIQXZp?=
 =?utf-8?B?NmRBNnlJY1laZ0NyTXpWTlViL0ppcnkvaXBKUXFTTGJxVmRvWVNuWXNOaG1I?=
 =?utf-8?Q?9Xx2BbuFLf7cd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0Y5SEFVK0s1VXBRYUxTY2lvbGpyK2JBd0xJNWZ3bFBMZ3ZTbWtVN2p2OWtq?=
 =?utf-8?B?VFBiRXVEdWRLcWhZdjRUKzNwRzFncGdEZEZDZTQzWkR2YldpejNhNzNpTU9Z?=
 =?utf-8?B?NWNOU0EyK0QxUHZFSjVsdVh0RFovdzNUeTF1TkZYdTg3NlUxajliV2NlbFZm?=
 =?utf-8?B?VEJpRWRyMjMwQm8vRExQU01SVEs1dURGMlM4L3h6OTRPclRxMm1nV0F1UURn?=
 =?utf-8?B?eDRhNWU5Q1N4YTZnZ0NzOWw0Y2QxSUtId3lrRzNTNkh2dkpEOEwyMHdPQ0pu?=
 =?utf-8?B?SjFNdkxCVm1xeFI0TVJVOGRtWTNEQWZKODRvRHVhRy9qNmozcjZCa2RCcDdZ?=
 =?utf-8?B?dHN3ZXRiM3pZbWQ1WnhkdGhwTVN1NVVEMU9TaVpnK3pQMVpybWZSeXJ2eE1l?=
 =?utf-8?B?ZGhBN3BmUzNmUzk5RUxzKzJZeXUwUUVXSktrd3NTRzJLWjNTYnBLK2pNdi90?=
 =?utf-8?B?Uzk1aFh0dzBxMDNXTDhTb0Y3RFVVWFhsdG1zOGh6dDlpdWZEYkU0U3pwa2Fq?=
 =?utf-8?B?Y3RkQTduUHR6V2oxK3ZueHgzVzhTdVU5Q0RZSGk1dVNJMWFzckVaYTN6Q1ZB?=
 =?utf-8?B?Q21JWDdtcitRYmNTZmZ6WXhoSE5WRjhmdE1KTlJxd0FoYzMrbXJjb0lPZ0ZD?=
 =?utf-8?B?QnZUQmNmM1RBbVAxclYwNEUrY2d6T0R5eWM3YnN6NVVMSnVzTWN3R0Y0VWZy?=
 =?utf-8?B?UDF1d2loTXBYUHFsMUI1UFYyUk5YY0d5bHM3WkpMNjk5UWU0a25hclRLNXUv?=
 =?utf-8?B?WFprV25hNWRzcG9KeUh3RjRiWWVyQS9QS21ZNDJoUWRUNmFSNTA3ZzNmM003?=
 =?utf-8?B?a3RrMFlsUENVOUFoMGdobjE2YjJZRlFaVjNDWEk4SE5YS1Y4SUI5YlVVY2JR?=
 =?utf-8?B?SmF5em1waW1jQW1sNnZqNjNkZWIvQ2d1OUl6UFhnTGRtc1Q0a3JZTkRXZDBi?=
 =?utf-8?B?UXRIVkJCc1BKeWxDblBtYTVHR0pqNjNKYTBiSE5kVncva3k2N0RSQTdXUWll?=
 =?utf-8?B?WUVvaTAzWGltZGZDcWIvY1hXK3k2TVJ1bjl3MlZNQUNvMFhib2Q1TE9mcy9R?=
 =?utf-8?B?SStRM1MzdC9ybzEySTFWT0lkZFFEV1BoSlgwd28yTzVtaVJSNVdMeDFnTjc4?=
 =?utf-8?B?a0Z3UkxxWkxKUGtkMlg3by9SRFd2cXN3Um5ERHN6WS9rYy9ldTRIU1lvdkJT?=
 =?utf-8?B?VTJiSEUvdlNBWUtqMmtZak1yeGNCWHB6Mkdnd29YQW1YUG5BNS9TWGY2cVN3?=
 =?utf-8?B?MEF0Lzc4eEVVZko3NFVjd2FrMDBVQkVYdjZGcUVRM2Z2QlRxeFJTdTUrYUJn?=
 =?utf-8?B?WGgrczBrR05MamlhNGl1SzF5QmFiV1N0N0hHcjdWU1ZXdVY5YlFoQ1VpU2R6?=
 =?utf-8?B?bVhWNk5BaFVVZkppL2dxc2Z2QTQ0Y2o0ZEdIN29QVkpRUzg4emJSNzFxQ1Bi?=
 =?utf-8?B?SUlNYjJvSjNPaWVTL3ZJMjEzV1UyeGdKcTUwcWFqRHBFNFFUVkJHTDYxeGVN?=
 =?utf-8?B?UFNjZmdXYUNXUnErSTk1WmVRKzR2RzVpY2Uzd1Jwci9xL0E2ZldyV1pCK2g2?=
 =?utf-8?B?bTRES2JCanVHZW5TTm9pN2h6Z1NhbVd2UGFlbVhWZGVXcjZ0anhwVngrUmEz?=
 =?utf-8?B?Wlg1ZVdxckMrYko2MlhzRnFoYmVCd3hpUW9WQVNXbVhGRVpBWXJuTWRKSm12?=
 =?utf-8?B?UlM3MDVFa0dlZzZLcHBKSVRTWDZsblhPd0k5REdvQmk5RkxWNU83VUh6dXJX?=
 =?utf-8?B?U2NRWHJpUVNwYTN6Z2x2UVlEaURkaVIrcDdWQWEzb0FXZlhUK1ZvTlFQNlRu?=
 =?utf-8?B?amJCc3hLSVJmcTFoTkZ2OVBDa250RmZ6MmZGQWdRS3RiRVF3TUxoWGFVSUsw?=
 =?utf-8?B?d1MyZUR1MVVGS0VLS2xpME9vVGgyZGtJL3c1cEZheVlKY2Y4WXNHY1oxa1V6?=
 =?utf-8?B?dVZRcXg5c05VMk9RaDJaaXBaVitxVDluNW4vQzFvNlRGUWUvS05CQVBxRzB4?=
 =?utf-8?B?OXhtWFBGeU5rYnlqT1FyakQ4dzZnV3NLekdWam9CeThpS01CMEUwQWpqV1JM?=
 =?utf-8?B?bWtnWkltWVUyMFpJR2thWDcyOFpDK0lJampWWW5ENHFWWFdpYXNtQWM0clJ1?=
 =?utf-8?B?eCtoaUNuL1BWWHZLSHVQQkl6bWR4bEFkMEFTTTFiT3M2b0YrUXZueU1UazVV?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 66547904-a511-46ae-f8bc-08dd54c08ebb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 10:46:56.2558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTeTcgqKBG5Ce6/4HxjC7qhnRG4aipy67lQqN8oQgti4zlnuWb5OB2NtWQJIdPElss+JQY+aG/Mxxdpa2nUfegxAWZzKM0rndRORsRSv/I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7540

Hi Greg, Heiko, Lukasz,

On 2/24/25 11:27 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 5ae4dca718eacd0a56173a687a3736eb7e627c77
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025022438-automated-recycled-cc12@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:
> 

Commit 5ae4dca718ea ("arm64: dts: rockchip: Disable DMA for uart5 on 
px30-ringneck") depends on 4eee627ea593 ("arm64: dts: rockchip: Move 
uart5 pin configuration to px30 ringneck SoM"), both slated for stable, 
so I'm surprised this patch is the one conflicting and not the first one 
(because it does conflict too!).

An option for clean application is to backport 5963d97aa780 ("arm64: 
dts: rockchip: add rs485 support on uart5 of px30-ringneck-haikou") to 
6.6 first, and then 4eee627ea593 followed by 5ae4dca718ea.

Another option is to resolve the conflict for 4eee627ea593 which is 
simply about the git context (rts-gpios can be removed if 5963d97aa780 
isn't backported).

@Heiko, @Greg, a preference on one of those two options (or a third one 
maybe?)? I personally would prefer the additional backport so we avoid 
other conflicts in the future (I already foresee one with a patch I 
posted (not merged yet!) last week).

Cheers,
Quentin

