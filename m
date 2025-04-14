Return-Path: <stable+bounces-132643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AABA8879C
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323A0189EF7B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083B11A9B48;
	Mon, 14 Apr 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nwBQzkkO"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1918DB02;
	Mon, 14 Apr 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744645160; cv=fail; b=Rtpto+2JJbALSQo2ytcpt6tDLGi6QmD5f8YkD+Ypeqrk5sIa5gqbi5ebpbN83j0ygH/QRfnFVlj0p84ypck9onYbpkshxSQ7f2isBVJ3/AMmjNXQI90TwMIMZmSceQLCp4QzrPbIk09ExfWv/CEqbp+79KGm8Hme2pz5Lovjn38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744645160; c=relaxed/simple;
	bh=4D/ZJK90Qqaei43Yu5c+2Ie0uTLEDOm7AmP786nCq3A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U22+bPWTR0sn5QlUaLBCl+7lJwxeiqDvXKSmrSR5vkzr/FE6Jk7d0ObQeaGY/yhriTF2myo92bhmOCLgTjs79oyDHbN1yMcQq5T9mdIcsUbydZYtirthRyTo+b5Oq+Jp/IdlQLWAf01HMBK18LjObKthoJIrCluElctiiMcyofE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nwBQzkkO; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EEDoFH020522;
	Mon, 14 Apr 2025 08:38:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=sCOejKCsQ4YsovftTau0SdeVu3FCOd2vnN8583WxFd0=; b=nwBQzkkOauG6
	Nxxh+I+SNflwu4HSCsGPChParJqvmWBeVGbZHwDmHbyAQEG/r6hPCeW+LpJ7vWTR
	D8p2lbcD0CqHiMN19NOMqWW7K0CJAreXHuLtHhq9E+/JG/ZyPn6I0wWz+0JKCnqJ
	V1+hNpwuGXL2pzcvzD2aAwKlKgD6h4j7WgELaTkBLoWfzPedLaZeCoZ2znC65WcX
	rAK6E87/9uBjP5gh8i6j2dahei6xv19T0LqpCWaGmrAyfHIx8SSLB9fti3tpN3Di
	3vzkXnUTZpHqF+X3Qf9ZuIum4jLHHMOJm5UaJOa1lUCSbwQnPiebFrzlssUkLWOM
	0xdDUQZpEg==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4613xj8jvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 08:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBE07vff6KNg8HJGZAztvWU+hAF4BuoxSD9U5VaSK94hO6DtiqKD4gdvvC+tYaPzG81L4ol9fxpvtCtSfiEgDiUblMuoKH0nxq45KsBKuZrURLhU7Jcw5YoJtptBkOAN/1kU9ecssBDix/qHrAzmy1Bxy3xa0oUYS4PpvFR6pKHF/ITJDW8Q+vIQLpLdR5bgOLlOoIetOtah8DO/sd4o/cgZnHWVzvpNVz2/bONNR+APoEghhNkAMbGz7uwGlVzEy6h8yDoqIagU9EpFlIMfLKLWFrClwv0XmSqKzErLUu6FZHDDYOWiMZzNSZi1+29CiBFAIsjHmcLmv98Qd2AdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCOejKCsQ4YsovftTau0SdeVu3FCOd2vnN8583WxFd0=;
 b=M678cLBayebl/7GuB/jUlsXz4DBCSUtqGemW2la3wbCG+dm7YyeMLdjkQncI3cv7yws5jaXC78d86fVcaysa1G7lWquab4wXoNHICjtgQskd56g0XwNBxXB16JmACGYw1iwL68AxdWboVIGcCs0KvWszM4VDLE9vXRAMesCYgkV2MftXWmNOZ7ybWO66FpY7zcZtak768ZQDZB95tEvECTxIKxYrgmHpSfpvebzx/mpwiaTzizgTUSt0BDi7GjOqxHI0nmRfkB9NNZM1c+fEwwWGrYa60gOOMHxawJhsK5L91+sZFY8W2rBv4MQf2NDdx72t9hxMWVkmR27mp9TlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4482.namprd15.prod.outlook.com (2603:10b6:806:195::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 15:38:24 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::32d1:f1b2:5930:7a24]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::32d1:f1b2:5930:7a24%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 15:38:24 +0000
Message-ID: <0049c6a0-8802-416c-9618-9d714c22af49@meta.com>
Date: Mon, 14 Apr 2025 11:38:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
To: Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>
Cc: Pat Cody <pat@patcody.io>, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org, patcody@meta.com,
        kernel-team@meta.com, stable@vger.kernel.org,
        Breno Leitao <leitao@debian.org>
References: <20250320205310.779888-1-pat@patcody.io>
 <20250324115613.GD14944@noisy.programming.kicks-ass.net>
 <9d38c61098b426777c1a748cf1baf8e57c41c334.camel@surriel.com>
 <20250402180734.GX5880@noisy.programming.kicks-ass.net>
 <b40f830845f1f97aa4b686c5c1333ff1bf5d59b3.camel@surriel.com>
 <20250409152703.GL9833@noisy.programming.kicks-ass.net>
 <20250411105134.1f316982@fangorn>
 <20250414090823.GB5600@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <20250414090823.GB5600@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::34) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f29e61-1b0f-4e67-2470-08dd7b6a647e
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OStGakVDYXdJR2x5c1BmVVcrYTlrL08vRXFEQ3pQVjZHZk5CSTBxaDdJeW85?=
 =?utf-8?B?Tmk2Z0oxWXhoSTZRMUlOOWNiOUczNDNqUDU1TUQ2TC9pMTZyUnhRL2laaTd0?=
 =?utf-8?B?U0xtUm1qMUs1VzlLbDkxb2JSejNuMlJtLzZPRWV5a1pmMFVDOTVWZWZHTUJU?=
 =?utf-8?B?Nmc3UER3VkpjekF1cDBQRTR5MGI4azlDYmcrdURrUDJva3U2dHFETTJQZGZ5?=
 =?utf-8?B?MzBYN2UvakNOU3VOQmJPN2MzQzVnQ2c1UDh3dWZDMnpvZjJaalVrdUZVaURB?=
 =?utf-8?B?b1V3bml1SE9JckFhcnhWNHQ1K2FSYVR0MkdSNUU1SmRGK21QVWZDV1dJRFlY?=
 =?utf-8?B?VVNUNzU3OWhLcHUzOFl1MU44M0V5K2JzVGlBRkRwSjF6dUxRbjlLb1QwYjMv?=
 =?utf-8?B?UCtJd0dBcWpwMkpNaG5tNTVnakZxQjFKNDUyZk5EZGVPdFI5VXBxTlRoTDhV?=
 =?utf-8?B?WFpmcHpWZktQSklmRVFHL01XR2RHWi9KL3lTcTlWRjdtcE9nMXlEay9Kd2Rz?=
 =?utf-8?B?cXJzQWJMRTJKOHg1ZmJpRThGRnN2K1JCVFBia0EwU1BXVnJZL3hPTjFSM25G?=
 =?utf-8?B?WnBYMHAyYlF1MzQ2K01iMmVJTTR2S1hOLzQ0M0praWhjdVpJTytrZXlyL3VK?=
 =?utf-8?B?S3JUNUpib2lQbkVpZDlZbitwTXlTN1BrWlZNVGdJa2FMZ25wM0lJdEhPckpu?=
 =?utf-8?B?dmhBajdyeHVhd1dOcDNGSzFFdm1IY0dObjN3cjNISU1qZ3BwaWxFR25neWZB?=
 =?utf-8?B?Rk8weVd5dHpaZUh3aCtxSXRNcVAxaWhpU0ZlNzErYnZJYk04SzZpdElMZ0FP?=
 =?utf-8?B?NWZOTE15QitueFpjbGFaWkJPWGJpd3VhSi9IejhxOG1heDZ4OUllQlUwZzBt?=
 =?utf-8?B?aW1WYkRLdDNCZ1JweXNvV1pzOGt4aXJmYXp3a24wL0FzRDVHZ0ExTUswSzhl?=
 =?utf-8?B?ZGNrYnpGN3NHSldwYkpQSnFYSlJ6Z3FPaGE3MWJYeDNyVlphdUpGeXNKTkhw?=
 =?utf-8?B?cU9ML3FmYWZJM0paMzdmdGoyNDhodStmSjNzRGhvRE5DT3RXczdXTi82TWV4?=
 =?utf-8?B?UGkwRWVFWVB4Q2ZSZnlGNk54MHR3dFNIVklCTDNVY1JJZ1M2N2hEQzdkOTJX?=
 =?utf-8?B?aS9IeElicUVlUkg5M1hCRWhxM01PZDRSejhPU1FYUVo5VDcxTFBSQlluc3BM?=
 =?utf-8?B?OCtPcWpGT2lkandCSUc3eGUzNEwxTVZkMElYOFpqZkxjQ2xUV2o1TUp1SSti?=
 =?utf-8?B?UTgxZ2NnM0hIYktMTnkzZDhOTU44clgzN1B3OHR4NzVNRlo2R1lmOERCd3ow?=
 =?utf-8?B?MEh5TCtwRHJGSFZma2pIOEF0cTAvUHgxc0xMbVZJb0xzLzV6NDlSN3pkbE10?=
 =?utf-8?B?MDR2MERPVk1pbU5ITXRrTkRxc1djRXhvR25odkdWN0cvVGtYeTlUVEk4SkVi?=
 =?utf-8?B?YkNNUjBzVjZyTGhGTlgvTDduUk5Za1dOa2lsY3ZJOHlENXBjYVpzcFFEYnh4?=
 =?utf-8?B?KzdEN0xZN0JudDFKU2h5NTRRN1hrbzE4UktjQVJJTmtTUnFPM0tSNmVCdDRR?=
 =?utf-8?B?MkxCSEFxT25lWWFIWGYvTVN1WjVEWXBSaGZ5S0dGc1UzOW1iUUN0UVNzNlds?=
 =?utf-8?B?RFc4OGpqbHBhdWlyZnhsWmJyYXNQemJZa1gzUHRQRVF3b1p6MTVoMzRaZ00y?=
 =?utf-8?B?endVcEtTOUVZSjAydWd5elVjcjdzdlZJV0dQVzhkVHNNQlhiaDB0eXNad2FJ?=
 =?utf-8?B?aEJwOE84T3dJeVV6Q2Q3eG1BZjRoNUplbGRTczh1MWU4S3gyaDJNNFVhb3JN?=
 =?utf-8?B?VzN0aWNmc0hoK0Y1eHc0a2RKRGwxNlpnNzhKYXZiVnAzUFVhSk50MGcxK1d4?=
 =?utf-8?B?TlRjT2FUZWNxUUI5RXlqVCtoSWExVCtBUGlrbkN1RmlCL0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clI3ZS9kOWNFcWw1cm5mZHBRUUwydW52cFR4eWJJVnFWUDJXS0g5bVFKTURC?=
 =?utf-8?B?eDc1c2R0YVkzbFh6VkxJcE1hRWhPaXJLNXhBNXRhWElLcWowQzk2dXpNVVVv?=
 =?utf-8?B?TGdETFJUa3ArVkVIOEI3d1V2N2FZTTQxdmRzbExibDlZbnk1OEU2c243SWFt?=
 =?utf-8?B?K2lSOGRrMHA3Ym1MRGdHWXZkdVpWNnBMblA5cU1wQmt1YjJLcHU5UHlVUERE?=
 =?utf-8?B?VlM5bHFuZXhncjBoTU1JMTFlZjFUNUx1bGkrZ2N0MzhtR0s3SWl6QVJhQ2FS?=
 =?utf-8?B?Vy82UVhQZzBmdkdPY3F5aFNobnRjUCtoUnVLM2xxSWpNdzk3bFZqWlJIYTlm?=
 =?utf-8?B?dDliTml3dGRzRGpXTERxeDRaZHdWYytjYUxiOVdiTGtLYVJWMGJLUmNraWRi?=
 =?utf-8?B?Z1pEc0tmSFpweUVqbjNUaFBuL1VSNjVrMENUYUpCV3JMMjJsNis3OHk2N2Zy?=
 =?utf-8?B?UXZSaWRPd2ZPYmRJYjh0T3FrSi9jTWxWWWFPeFlLTGxxenA3SFRDb2t1SXAy?=
 =?utf-8?B?QlJLQXZQZjhheHdFZG5TL0FBc3pRY3hMR3dmdUNNNU9GRy9uaDhpK0gzQ1Np?=
 =?utf-8?B?M1VjQzdsenVpUzlXTU5TV1hjbFIvcGJIWTRjekpYZWRBb0NOWHdZUkJJNVVE?=
 =?utf-8?B?S3pQcDFBbGgzRU1TYW1sa0M2Q2pCOVB5dXZWbnl0a01YRG5ISVNaVnFkbC9o?=
 =?utf-8?B?WXZOdGZITmdCcW1ybS9VdHBDTmdLelJUK0x2YjZIaGp0YVF3VWpWUzdTTWE4?=
 =?utf-8?B?TzNiN1p2VENCMnpQUHBzR29QaVVVREJBTlNiTldqN09haEhrNCtDQlZIL3Zv?=
 =?utf-8?B?aXlBcGRCdkJ4VTJYeXJOSlpERURiZ2EvUVFRcWhRNEEzOWVnZEZRL3ZYVVRI?=
 =?utf-8?B?bmxSdnY1Q2pLLyt4SEpWUWVWbWF3RzR6Q3REYlowVDVVTHl6VXd4ck1JUXVQ?=
 =?utf-8?B?dHQ5ZlF3YmswVm92bXpSaHFqT2I5UTFWOHlxaHY2TVg3M1MrN3Z0UTdnMjUr?=
 =?utf-8?B?dGM5SEdyS05taUh3NHhlenRPWkJvRkZYWDZSb1dobm15cXhvNDgxYXNxOElx?=
 =?utf-8?B?djM0Yjg0elQzVXpNQ2RPcDFVaXdSeGUzK2FvWWJLeGsrc1RWblJWTmRGQUdD?=
 =?utf-8?B?NXJQNW9JdWJTbXJob3RFeUkvL1ZSOEZEOGtld3ZFMmVZRkpjSmdQaVFWK2x5?=
 =?utf-8?B?bnZIOEFsTXdldG1lRHdvV0crUlBBT3BGV3hGalljSTYrYTFVVFljVUpUOW16?=
 =?utf-8?B?cjVWVlhpQ25vRWVUUzNJVkdSNm05aVlnRk53cDlqOGFBT2xleFNTeWhZWnEw?=
 =?utf-8?B?dzg2dE54cHlUNndHYjRGZWc0U09LSEU5a2J6MDE0WUdWaktBanJDRGJsdDY3?=
 =?utf-8?B?MnZDdDJYQ0huVWVRRVV6aTlMckdtNzFQQWUzRjVuRXorRUtCaHZTNkdzQitO?=
 =?utf-8?B?dHNWN1kxdWJZUHVLRy9kTFR3TWlFY0NCRkdHK0JJczI0VGFKc24yKzBOclZT?=
 =?utf-8?B?eWJsSjRhSERuMUQ3YWgzVFZvVk9QOWhEQXY5dEd6S2IvazVpTlUwV2lzdlZF?=
 =?utf-8?B?SjJicEZydDcwejFDR1F4VStHTCsvaTc2Y0J6ellZOStDNElFU2ZiU2NHZGtR?=
 =?utf-8?B?Yzl1WUhYWDBScXNKM3doZTJNcVpHQSswUDQycGNVcWYyR2gxUWVqczJsQ3h5?=
 =?utf-8?B?RTllR0VYUXRwQXdybHAxY1lXNGliWThzMnZKNEVOblhYbmpydTA5anVOU0py?=
 =?utf-8?B?Z09QTjJwSXhYaG94czlmdzdQWkVjVUtSbjMyNWVhaWZFdU8zTkZrL2Q0Ulgz?=
 =?utf-8?B?QzYrbkw1MVZybTZNaWE4WjB0RnZLMngxalVoSkpHVGFBZ1VmZ2lrcm41Ymxz?=
 =?utf-8?B?WnpQQjlhMkZuSVVUMjNzQ3pWYTVuaHBFWHdnTlFaRms2UmYwbjF0YjBtYmxh?=
 =?utf-8?B?NURjaERBRmNqQmF6ZVdkWE93eE5jeW8zOElybVhNNGJwWTg0Qkh4VXZpaFFp?=
 =?utf-8?B?djlrU3FSSis4cjZWaW51cGFYaXNETC9pc2g2bXA5clBoQUtlb3JTQ0hETkRt?=
 =?utf-8?B?dEZicDBwWlJHclZIeGJpcmRNSDBEcW9yRDBJNk1QbVBXUWdyNDBEWTExWmJk?=
 =?utf-8?Q?rjfQ=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f29e61-1b0f-4e67-2470-08dd7b6a647e
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:38:24.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IsRadmYQSkgCBksFi7bYoGS6E8nfTAmI4PvT7XU2Q+Lxw6BqX8cv/MbrHdu51AMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4482
X-Proofpoint-GUID: ZUrJ6C8zqjsGAYXuZgD-XCNA2RQWvpzt
X-Authority-Analysis: v=2.4 cv=Hvp2G1TS c=1 sm=1 tr=0 ts=67fd2bf2 cx=c_pps a=GDxOUaUasxmcDRSC7gC2IA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=3CnnKAi2kPp3R8SXrNkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZUrJ6C8zqjsGAYXuZgD-XCNA2RQWvpzt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_05,2025-04-10_01,2024-11-22_01



On 4/14/25 5:08 AM, Peter Zijlstra wrote:

[ math and such ]


> The zero_vruntime patch I gave earlier should avoid this particular
> issue.

Here's a crash with the zero runtime patch.  I'm trying to reproduce
this outside of prod so we can crank up the iteration speed a bit.

-chris

nr_running = 2
zero_vruntime = 19194347104893960
avg_vruntime = 6044054790
avg_load = 2
curr = {
  cgroup urgent
  vruntime = 24498183812106172
  weight = 3561684 => 3478
  rq = {
    nr_running = 0
    zero_vruntime = 505000008215941
    avg_vruntime = 0
    avg_load = 0
    curr = {
      cgroup urgent/-610604968056586240
      vruntime = 505000008302509
      weight = 455902 => 445
      rq = {
        nr_running = 0
        zero_vruntime = 12234709899
        avg_vruntime = 0
        avg_load = 0
        curr = {
          task = 279047 (fc0)
          vruntime = 12237278090
          weight = 15360 => 15
        }
        tasks_timeline = [
        ]
      }
    }
    tasks_timeline = [
    ]
  }
}
tasks_timeline = [
  {
    cgroup optional
    vruntime = 19194350126921355
    weight = 1168 => 2
    rq = {
      nr_running = 2
      zero_vruntime = 440280059357029
      avg_vruntime = 476
      avg_load = 688
      tasks_timeline = [
        {
          cgroup optional/-610613050111295488
          vruntime = 440280059333960
          weight = 291271 => 284
          rq = {
            nr_running = 5
            zero_vruntime = 65179829005
            avg_vruntime = 0
            avg_load = 75
            tasks_timeline = [
              {
                task = 261672 (fc0)
                vruntime = 65189926507
                weight = 15360 => 15
              },
              {
                task = 261332 (fc0)
                vruntime = 65189480962
                weight = 15360 => 15
              },
              {
                task = 261329 (enc1:0:vp9_fbv)
                vruntime = 65165843516
                weight = 15360 => 15
              },
              {
                task = 261334 (dec0:0:hevc_fbv)
                vruntime = 65174065035
                weight = 15360 => 15
              },
              {
                task = 261868 (fc0)
                vruntime = 65179829005
                weight = 15360 => 15
              },
            ]
          }
        },
        {
          cgroup optional/-610609318858457088
          vruntime = 440280059373247
          weight = 413911 => 404
          rq = {
            nr_running = 1
            zero_vruntime = 22819875784
            avg_vruntime = 0
            avg_load = 15
            tasks_timeline = [
              {
                task = 273291 (fc0)
                vruntime = 22819875784
                weight = 15360 => 15
              },
            ]
          }
        },
      ]
    }
  },
]


