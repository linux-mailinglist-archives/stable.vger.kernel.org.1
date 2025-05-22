Return-Path: <stable+bounces-146038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99210AC056E
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 09:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AE499E2AEF
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 07:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D426A221DB7;
	Thu, 22 May 2025 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="pNQrx5Av"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2048.outbound.protection.outlook.com [40.92.91.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3259221D8D
	for <stable@vger.kernel.org>; Thu, 22 May 2025 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747898135; cv=fail; b=ayT/y8jTp0cMPbka/UOiR/qQig1ZgU7MY4wWfZ4YRFAPhwFU0fgG/cRcL5biuTrTTiWTuyLm2i0ej8jkbKqztTNOm8ej6AFN1fILDaSSIN0PnYuJ5aa0Z9q/PDW85yqj6tJr2OtlK+OQtO611Pn2yJMErkkzW8whWpW+T7rYv9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747898135; c=relaxed/simple;
	bh=pXNTU0nx8QusByO9gI5ejDVG0dF306PoRqRHz3VC3Tk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MW++FKwfAwfOmHuRjPcr7RSVK980zpGygup7Guiv6kKVRJSR4ueALAJDpC18ZMzI0/FaKAz/W84D/VBlbDE28k6KavD3c5QP50v4PWuAAqa8X6iaHN+rzAy6jF99B6XXF7OAjfsvuXfENWeT3hKlO3e3Z1E8I/lHtA4/oxlEOHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=pNQrx5Av; arc=fail smtp.client-ip=40.92.91.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0L6ggc9YZ4+oMgewqS6+XTv8uykGqvmoXK5P7I0cbZNCn+mF5Tll7bRHyxLQFnwqJYeN7Gla8EAYK3z8kpp6r72+cPJx58fai/ah7JJFlGczn+Gm6F6JeE4KTBpIJRGJiKYbXGFiTwiC5q0WmPrxhE/WdUMD4RFkKEHHalw6vycSZOyCFq/AQV6hBZnjltUQG74stPcYrXgaPeZCPbVCp1hhRe4E9L4wliQ2wBLeLmOIbLQOeXM6/k6PPrKNHuSfb6sz55O2iyTgJ8scsaCLYUEGVGrPuCIT6PuomMIJQ48z1MmWeb8KIdUkYNMPYK967CRhYR17gN1ArnjBwuIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKcAGksxqYJJM+jEMfUus/Dyy1dvz48yF/0WajgVQuI=;
 b=TibMcUZ637BFPxTJ+wDM/9gif0/hd7/8q3Ldpw/pSkouvB/b7cGK+Rkm8CK+8N06SHEYuZAf8LySpm257eMyU60Y3pz/YV9FdnLklchY6FXRbNWIgUxSL13n7dCjkpMdzWeaWW3fnZOx88etqZtnqVtVoo0ta38hVv+PkyWMTcitiipUv9G8oRyjvJsMAX7d05ZOzvV7zWRhU0XFFXSQL7ALJKKYbSOm2FVM4qrZ6b96Tq+bffeujrCZ406nmSskoOOvpvIWn/f2Lk5Ul7sYEXom8zNeXyVD0hhvlgKzBLj+Bzp79L/VKAJljiI2hebbG7yqSC0mXn6UvQMbxAoyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKcAGksxqYJJM+jEMfUus/Dyy1dvz48yF/0WajgVQuI=;
 b=pNQrx5Av4bS/GtemWVy7vPTN7nsSvAhsuRlv2S4AztyuMLenuJeZEbSSi3hVnm2JIRCw7o8ATLnI6XM3YjQqp19gyFqty/ibQ4NnvCDv2mQ8iWHJDNCbUKvogJnxSAhDG1NgO0O+xRqymt8ev++9RekTsUhbujgUSuDQsnf0rpAo6DP8fJ/R2xWudjC1RUFsBwUMJtcw3G9CnSYPYZlMsFY3HDjahJHFQvKnpzBlBL+b2S3Kf8zfDX1sp27ADJ8NvSbrFwu1kW5iB3ecBJM6hsM1ARfS0khi03SODGNgx5jhksjCl3spLA2howXrEmLIgzNSexBCsbdNp+L1UsXJlA==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by GVXP189MB2104.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Thu, 22 May 2025 07:15:23 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 07:15:23 +0000
Message-ID:
 <AM7P189MB100943AF796568B45AB7099AE399A@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Thu, 22 May 2025 09:15:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Panic with a lis2dw12 accelerometer
From: Maud Spierings <maud_spierings@hotmail.com>
To: Christian Heusel <christian@heusel.eu>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 linus.walleij@linaro.org
References: <AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <8d249485-61f6-4081-82e0-63ae280c98c1@heusel.eu>
 <3352738d-9c0e-4c23-aa9a-61e1d3d67a50@hotmail.com>
 <AM7P189MB10092C41B59EF58CBCB290A2E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <60a9ea8a-edb1-4426-ae0e-385f46888b3b@heusel.eu>
 <AM7P189MB1009A8754E90E4DE198DAC32E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AM7P189MB1009A8754E90E4DE198DAC32E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::19) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <90bab23a-f4ca-4c28-a46a-89236ae5f2b2@hotmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|GVXP189MB2104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1882d539-c1b4-4b75-ae90-08dd99006aa1
X-MS-Exchange-SLBlob-MailProps:
	F3kBGFPBgzZx5fYXqP7epOz858UK+BQTP2cYx25HPPHmZ6CTqk+iiprwHSdJBRwzRU9rmXQ/ML5OVQdAAvdcUa02zZFPZOLG6afr04JcNkV1v4w1iSqEnwmYeymoneRX5xerKXqvrXw02U+JsLOA754Im36bXoYsVb7O0LFAR3iM7WgVbbNgp2tD27WQcLFptAmrsxitbQjMdlxYejlQS+tcYWUcOQUK5Q3TOLPAxJa/36p/yBT1MONICD59Miaa3S6Lbr6F8UeT4ycBvZRbXR5/+r8yC+zEPnvXd+yPrZ/z65CG0lwa6NCFzuvG3ukkNBH7IoOX5+pdOjKkhbK/dzlQRcBR5jT/DrK3K5aZEBFRC6sIPuTeETxVPztDnUbFaV5ETjaM4tDe+2C4LiQxsaImKSU2uNOHVxwue1up0sokjCVrJL8G6szGXGcNUckr4zN4AsBq9/43QO58Tj14gvMFuykhw9DgE17NCB5g7717Hi4xhQSTWlxvdu8rDLiEB7uJi/e3jde7cCl2Ensf0w4GNH4Oyc3QvKOqVdley75Xf8pq0rwbsGiOA9uuaT3qR9v/leaNAtW6aoS1OyDdrX4UbAZ3BbtjlDIYBq9nC4X0v4xmaDeZzLqm5eOrGOX/+mNNZzwOzp8DahzQvTHOGLoGKAldxybD9VS3mD5AFgcNVygFeGhwA34uAkDE1jHFCqKBoNtHMEzvS4kySQK3Vsi1AH4Eq/nYdRqrtYf+szdzGe9j2BBdJdIgOR+QB/bBYT3MO5UHBg+6YRqO2TQ1d4EBSNX5QrA7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|461199028|8060799009|15080799009|19110799006|6090799003|5072599009|56899033|1602099012|440099028|3412199025|4302099013|10035399007|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sng2ZkJ5d3BHKzc1NldNWEFFTkY1aWdab1ZBUFh4dnpVM0x1MVBncTNaWmJQ?=
 =?utf-8?B?dlZuK2JlczZZN2FhanZIUjJGM25LWVUwNGcxUUJpK2FXS0M5ZW80dmNyM052?=
 =?utf-8?B?cEVkaW5MNVpEOXBBTHdIT2QzSGZXM2VQZ1pmcVplTmhpaCs3U3VHSVFzMFBN?=
 =?utf-8?B?Z2I1bWV6WEM5MWZhaEpVREszK3NUN290Uy9vcGQwOEtBZG55U3I0RUMxZm16?=
 =?utf-8?B?a09pbVhLaGY2M2JIVENvZ0F5Qkgra1VzU28vSjkweVhpQ2tMQU5lQUsxVnk3?=
 =?utf-8?B?UW1TSlN0RUg4dUhyVUF4dkxmU3EyN2JBZWhoWkNrOUFJOFpFakFtbGZJWndP?=
 =?utf-8?B?elBYckdqOXl5cGU4MXp2S0U2SlV2YjYzSlM5RXMvdjhLaU9GQWhGSnlsMzJV?=
 =?utf-8?B?ZFloazFzWG9MNGR2T2NZYmhtbWdDUmpHYnRpM3JOY0tPUjVxRXhFWHFuYTBQ?=
 =?utf-8?B?b0t6NW96SlEzMzFtQVZFOE9aaTQ1aytoNE9XVWFBZ1ExSVlwdVlQd0Jpdm55?=
 =?utf-8?B?aHV4bVlZVEJNcndKSkxtVjhSK2o4blpjaHE2c3BaWDJSeW0zL043UVBUQ2g0?=
 =?utf-8?B?UTEzNkxxQXhXUmhXc0VjY09tY0pJalpjZzJXVjNURCtlMzkvanZPYzhGNGZy?=
 =?utf-8?B?VDYyNVVDYittUVI4Q29wQ09KQklGY2c0Y2hvVGFHU3ZhS25jdlRta1lPdHRD?=
 =?utf-8?B?YW80aEhpWG5QYldIM1dPUkNVdUN0d3dGQ0Nmc0dhbXNMZ3RhNmhnWjArUlNV?=
 =?utf-8?B?ZmRjc1B5ck93UkN6b2xMazcybnFoN0JLams5YVFTd0dkZHVhd1l5dU8rTTZO?=
 =?utf-8?B?M0ZkeU9rNXZaR0RTQ0dPcy9rditJekp0RU8wR284QmdwbUhlUjlsWHdsUUdo?=
 =?utf-8?B?S3A2d2lpZlJUUnlERlZPZzY5eW4xbGtqdFB4Rk5Ca3dLRU41WDBpU0lQRTRS?=
 =?utf-8?B?dGZlbHJ4MUxSRi9vWnJJYWEwT2E5Q2YrZ2N3ZktEb09keTl6VEVaVUZDNWtj?=
 =?utf-8?B?eXBFbVRlcmltc3BuL3ZSWEI1aGdMaFB4bnhyRXA1VjVDbElwcmc5UXBkdnpH?=
 =?utf-8?B?cGxObnRvRy9wR0UyQzFDWHpaRmh3bzVBTzAyUnRUMUNnRTlUazUxaEtVbmlu?=
 =?utf-8?B?QVNPK25ZRW9HYU41M1ZiVncxU3BsR00wcnQwU3h4ZEJBclRDQzhEQlNObDFS?=
 =?utf-8?B?aWJOMUpzQzRxcDg0RVIrcWliTnBqMHMzOFUwZFJjaG5teGNDaERQdTlHMXAw?=
 =?utf-8?B?UGFPS2V0a1RuSHFscW5FRFdGT0dOdEkwUWNPejJ2ZTJhWFVxZ2N0dloyKzdY?=
 =?utf-8?B?akNWcVBrQ3AxMFB5bUE3d2Z5Y1VKRGV5eEl1dHd5a0orS3ZLS1RVL3BNUGhh?=
 =?utf-8?B?MTREcm9Nc3Z1RGJTa2N2RWdvVjFSL29lSHFJMmZZUTJ3N2NqSkFzbnMvZzha?=
 =?utf-8?B?bVNBK2NEQXhNOE1NMTBmcVJodi8wRkNyYVJrSmxRdEFzWkJXcWh0cGI2RmdR?=
 =?utf-8?B?VmJTclFVY0J2N0U0VTN2dXc2Y3JMSnNIWXZ3Qi9MT2Y4cFNLOWVwc1JQNTZn?=
 =?utf-8?B?TXprdUk2YVFoRWRDWk9VQWdjRHdIYTVkdngvSnFtM2xiaTVyKzhmYzFnbnJ1?=
 =?utf-8?B?K01SMmUwSi9mRmhuYjZ2QktmR0NqcjE2dHJCQk1za3BPYUd4a2ZnOFd6M0oy?=
 =?utf-8?B?TUVpdlIwL0tOaENvQXErY3F4ci9lMlZTWUxLWHM2aU5sMmpIdlNiSlN3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE05aE5hT2ZOa1FPT3hXNEJEMjIwRENFTG43Nlg0c3hkUEU5WGNXaW1vQmxx?=
 =?utf-8?B?VjdyY1J6ckVqa3c0Y2F1bUVLQkZoNG9Bb2o4U2JXN3pxRjdIdVZ1cFg5NVI3?=
 =?utf-8?B?Mi8wRXYreEpUeFNYL25EbnVITDNyODR1R1lsbnMzTnRXeVZpZHg1UEthT1Zh?=
 =?utf-8?B?dzhHd1dPWEdwVVdaY21VWGI3Vk9iN2IxSEFSUDduaTFpQkdoMW5ocnBUWGdD?=
 =?utf-8?B?cTArSUltaU1mTSs4SUgzbUFUMC82MnRsVjRMTUdyeWtBcDRvcFF3aVA1V3l6?=
 =?utf-8?B?YWw3ZFJlbkNvbU93QitSQ0diZnhqZzljYUg3VFMza014QmMweDVqS3F4ZVlH?=
 =?utf-8?B?NTJReGpEY0tFVzJIbTZXc0hDTFh3Y3VUdlMzYUljTkVINDVtaG1xdGtCZ0Mw?=
 =?utf-8?B?cGZzU2QyK3hqTEhwRzZDbFNFZzJXblhxSUVnQVZWdjQ1MVExTEQzRVVrUXRD?=
 =?utf-8?B?YXBIeXdIb2pYNWQwQWFKcHVwM1cyK2JUeWl6ZFdnY2o2ditvazgxRVhla1Rj?=
 =?utf-8?B?RGxES1BPbHBGc1hpSG1RQUkybDFuK1Y4cXFmSkRyT0dkbmVNUk9SUXptM1or?=
 =?utf-8?B?T281MzF1Tk5vSWNqQVk1c3djc3I4ekNWOFlDSVFxUHVFU3loZU52eU5CTUdX?=
 =?utf-8?B?QjNDbnJJM04xWVN6bkxUb1FpalF0TXFGOUgyS2xucVNQeUlmTmk4MjBmbFNu?=
 =?utf-8?B?RlFkZ0ZkaVVKMStUbHpFUkRieEdDZ3hZNHNoNHNoWFUwUXFIbnhUbjFIZS9X?=
 =?utf-8?B?bU13WnhXRUZsVDVwdjZJVm5qc3d3R212NVpPTGUrRDRtdm5jclVvZ2o5MHMx?=
 =?utf-8?B?dG5HSFRUWmxqNlRvdjZ1QVdOYjFBT1BpS2Qxa2FkOERrUnVqaDA3Tlk3UmhB?=
 =?utf-8?B?R29ZaENqbGhzemtIQmxQeWxqQ1daZkhjeGQyZ1VuQUEzdjRVRDJaY0hvV1o4?=
 =?utf-8?B?UUtQNHE1ZDJma0hEOUhYYWRXTkJzL0FGUVpnejRrU3I5WTU3REpOQm01aXZw?=
 =?utf-8?B?U3VoYnAyQXU4T29zQnQ0Y3h5aDB5bmw4T0NYUEFUWTgxTmNycWJ4K3ZmcGFQ?=
 =?utf-8?B?OWV2Si9qdzZzdUFSZTFuWXEweFNycEpseHd0NTU1R2N5dk45b1NXRlkwWHpJ?=
 =?utf-8?B?dys2aFRnR29EaEZOYjk5WFc1d1dqZ2tNOHp1RS8wdVVkMlFOblQwQmdROFJu?=
 =?utf-8?B?TSsrMk4yMysrNVg3ZktHSzZNcVFCL0dqZ0xUNjRtck9Oenhhekc3VWEwZkF4?=
 =?utf-8?B?RnJYYWJ1eDRHT1V6eUI3OHdGZlJBeWdEOUd2bVpUckovakc5WWlGL290TTh1?=
 =?utf-8?B?UXJjNXQvdkpBcTZvWENNM2l5cmdHTXJoR2k4NitxbmlXd1lXQURUMEU5VWVu?=
 =?utf-8?B?NmFlekYwcmhBbVZTVHF3ajMxWlBodERSckFveUxLL1VQWVUrQXpEaWR4eSto?=
 =?utf-8?B?YVllUUhuckxlbVJUWVc2QldpMGs3L1hHdWtkMHVqcmpOT3A2ZmJvK3R1ZGV1?=
 =?utf-8?B?NDF5blhoZ0lqeDFmR2RvU1dnb1hCdTFEK2J5L1lHNmliR3Z0Q2lqamh1S2hs?=
 =?utf-8?B?RERLNWozalE4WlJScDIxamFrUW9tUUplYmhxOXowQUtZdU01Wm83Ui8zOTlX?=
 =?utf-8?B?V1RPK1dJNWQwbkhELzJuWnNhTGhnbkl6Vm5rMmJqQjdkaUt1T05naDgyb0Ux?=
 =?utf-8?B?LytqMDJ1c0dCUUIrRm9wMUhSbTdpSFBnbTc5UnhEQm10N25FLytKZVdLTng4?=
 =?utf-8?Q?kmc+FDR20odYFwb8GQQdJY+/h1mFeJ9WYobHObP?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-2ef4d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1882d539-c1b4-4b75-ae90-08dd99006aa1
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 07:15:23.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2104

On 5/21/25 13:05, Maud Spierings wrote:
> On 5/21/25 12:08, Christian Heusel wrote:
>> On 25/05/21 12:03PM, Maud Spierings wrote:
>>> On 5/21/25 11:48, Maud Spierings wrote:
>>>> On 5/21/25 11:29, Christian Heusel wrote:
>>>>> On 25/05/21 10:53AM, Maud Spierings wrote:
>>>>>> I've just experienced an Issue that I think may be a regression.
>>>>>>
>>>>>> I'm enabling a device which incorporates a lis2dw12
>>>>>> accelerometer, currently
>>>>>> I am running 6.12 lts, so 6.12.29 as of typing this message.
>>>>>
>>>>> Could you check whether the latest mainline release (at the time 
>>>>> this is
>>>>> v6.15-rc7) is also affected? If that's not the case the bug might
>>>>> already be fixed ^_^
>>>>
>>>> Unfortunately doesn't seem to be the case, still gets the panic. I also
>>>> tried 6.12(.0), but that also has the panic, so it is definitely older
>>>> than this lts.
>>>>
>>>>> Also as you said that this is a regression, what is the last revision
>>>>> that the accelerometer worked with?
>>>>
>>>> Thats a difficult one to pin down, I'm moving from the nxp vendor 
>>>> kernel
>>>> to mainline, the last working one that I know sure is 5.10.72 of that
>>>> vendor kernel.
>>>
>>> I did some more digging and the latest lts it seems to work with is 
>>> 6.1.139,
>>> 6.6.91 also crashes. So it seems to be a very old regression.
>>
>> Could you check whether the issue also exists for 6.1 & 6.6 and bisect
>> the issue between those two? Knowing which commit caused the breakage is
>> the best way of getting a fix for the issue!
>>
>> Also see https://docs.kernel.org/admin-guide/bug-bisect.html for that,
>> feel free to ask if you need help with it!
> 
> Thanks for the link, I had heard of it but never done it before. This is 
> the result:
> 
> ed6962cc3e05ca77f526590f62587678149d5e58 is the first bad commit
> commit ed6962cc3e05ca77f526590f62587678149d5e58 (HEAD)
> Author: Douglas Anderson <dianders@chromium.org>
> Date:   Thu Mar 16 12:54:39 2023 -0700
> 
>      regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.14 
> and 4.19
> 
>      This follows on the change ("regulator: Set PROBE_PREFER_ASYNCHRONOUS
>      for drivers that existed in 4.14") but changes regulators didn't exist
>      in Linux 4.14 but did exist in Linux 4.19.
> 
>      NOTE: from a quick "git cherry-pick" it looks as if
>      "bd718x7-regulator.c" didn't actually exist in v4.19. In 4.19 it was
>      named "bd71837-regulator.c". See commit 2ece646c90c5 ("regulator:
>      bd718xx: rename bd71837 to 718xx")
> 
>      Signed-off-by: Douglas Anderson <dianders@chromium.org>
>      Link: https://lore.kernel.org/ 
> r/20230316125351.2.Iad1f25517bb46a6c7fca8d8c80ed4fc258a79ed9@changeid
>      Signed-off-by: Mark Brown <broonie@kernel.org>
> 
>   drivers/regulator/88pg86x.c             | 1 +
>   drivers/regulator/bd718x7-regulator.c   | 1 +
>   drivers/regulator/qcom-rpmh-regulator.c | 1 +
>   drivers/regulator/sc2731-regulator.c    | 1 +
>   drivers/regulator/sy8106a-regulator.c   | 1 +
>   drivers/regulator/uniphier-regulator.c  | 1 +
>   6 files changed, 6 insertions(+)
> 
> bd718x7 is the PMIC on this board, and one of its regulators is the 
> supply for the lis2dw12. However I feel this regulator driver is not the 
> actual problem, but the actual probing of regulators in that driver just 
> doesn't work well with the asynchronous probing.

I have found a fix but I don't know if it is correct to do. This deals 
with the deferred probe correctly, no longer panics and registers the 
device properly. This is the patch I have come up with:

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c 
b/drivers/iio/common/st_sensors/st_sensors_core.c
index 1b4287991d00a..494206f8de5b0 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -231,7 +231,7 @@ int st_sensors_power_enable(struct iio_dev *indio_dev)
                                              ARRAY_SIZE(regulator_names),
                                              regulator_names);
         if (err)
-               return dev_err_probe(&indio_dev->dev, err,
+               return dev_err_probe(parent, err,
                                      "unable to enable supplies\n");

         return 0;

Kind regards,
Maud

