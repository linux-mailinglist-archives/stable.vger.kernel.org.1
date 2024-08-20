Return-Path: <stable+bounces-69722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441719588FE
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 16:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92992B217E6
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911EC4C62A;
	Tue, 20 Aug 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="dWeApOsA"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA66E3D982;
	Tue, 20 Aug 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163641; cv=fail; b=Kwh3dNW6rGcUOCmxo3/AeutmyLUOrVf9cv9B0KJtzUyEWcJvGlOMy2n2OPGOA0a2cUHmGHG8LcAVotdWycVptJiySM2lOMUrBK9SQjyzVXi8PMnJPsCoINT+tqhBsR8LRz+GaVnRdyyy39YZdVuQVkRnnaez8UA4jNqwW//zUG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163641; c=relaxed/simple;
	bh=0o9kvKyh86z9jO8En686iA2ip/0NQ2dUrJYGUEkQAZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kJIi0Fp3rZXNv9npU03yePZhTtIXaKWlSm/NCna1jL6D81Pes98XWQ7FEmTkbePWTDF/dVrs1hLV9eloRsk/cd4rbOOqTKwotzY1V2wTRBXUU4JwE05Hz8y3a4HL6nHX4uEKHcAOyWT+Z82ZuTDonAi+v9OmfE+aK53YDfhfGo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=dWeApOsA; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIuXz4bl+dfD/a/lA3Pzh6nCRMvb5d3nbllF1ZdjwdVzS9KHHOuerHn2uRfhNiATHB+HYU+ycsc1jfyoiyp1KzqxKEC3hXMBmNWy/SOWlH5dZHc0nwVcE2MQWW8YUXdcZk+ESK0Pf5yUNcvVMP35dJPNdxsslXn6YDKgVX720ageiLlVPWsHojAji2LaeM70amGpCWJ1I3els0xuDkxkrGPsUP7fp67lnOrfVgMCr4LRemseDbOU+WmsPhGM7gPc7C+4gwWmHnkpYkGJkHaR7D0O2ObY3AiggBoXaEuFiQMQL2bSEA3OS81MtpSAf2VVBbJFcRlRgutmZX8ik4dpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQKs713+hqUroCGQHv7YrxQo5R4ecQT+7XW2ycnZkHY=;
 b=VMaHd6aPpZxdfCTaCI+3JRSzFp/ljX2CLCUlNNcIf8zM/KmH1cfzOpObdEhAs+ZFeEB+TkvfF+dxEqllM32KRhSZGoddjGuZN4FDnG6RvRQQ10VDcT8HTislcMHdADtPQO0GIKqkmU5Tms5MA1A/ykdu2rGx1VkQSxL72ckkMilzilzTFbOj89lY9MpjlThDOii5VpjBuioXOUaMfm9WNIP6r8kTlYkxCApJw8O36nBtgkEeUTnxIIbdtwUIG9ype2pCmnk1Hrpz9L93S/8gCBUl5sQShbfZqKXazkR5pj/zuBwb6Yn+zVPKvIaWyNQBiLgSd8BM/mbVB6kJfuxVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQKs713+hqUroCGQHv7YrxQo5R4ecQT+7XW2ycnZkHY=;
 b=dWeApOsAGS63FP8iHTXwrx/HMOrmXOWuXLe0TLQ349k1ycLfZL/RIjuD/R8IrW+Ew3iHPyHsQmbXjuV4LKhxJxCsqty+G9+UwUTkBoerRJs/PSUT5qjOPqOi5PbFMndmN1A9RPpnd0f6sumW3QvBd2jCwX3bCLJqbUhz7Zr5KSP0Sr7u5sVClYZ/Dh+mKLGDuM/2LbEoZVIJGPpk3JCS6uc+LAw1AcYTHn8euPxe+A0kjftqbK8FUeyosOvOc6onLKBbrUuP5d+zsQ3ag/AxT2yzWDBpDo3PAaQ7OMbDZDJcGac8098ENtx/HNeekKXhbi9VdR3YWh3a2MIR7QK1bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5199.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 14:20:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 14:20:36 +0000
Message-ID: <7ffe0f80-d4a2-4d6f-8c45-5a407ac2e584@siemens.com>
Date: Tue, 20 Aug 2024 16:20:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix driver shutdown
To: Beleswar Prasad Padhi <b-padhi@ti.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-remoteproc@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Apurva Nandan <a-nandan@ti.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <bf2bd3df-902f-4cef-91fc-2e6438539a01@siemens.com>
 <3e6075a6-20a9-42ee-8f10-377ba9b0291b@ti.com>
 <9ce9044c-085f-4eff-b142-ab36d39d90b4@siemens.com>
 <2bdd6000-82b4-4f57-a950-e9378c321154@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2bdd6000-82b4-4f57-a950-e9378c321154@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5199:EE_
X-MS-Office365-Filtering-Correlation-Id: 34a4bad8-0885-4a3f-d5a9-08dcc1234259
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NWprVEtjNERwK2FoY1htNm5ndWgzbjF2eXFvdUF0dUxKYUxTR2IvUGtvbWxw?=
 =?utf-8?B?eE9HM1NHRG9YNzNkU1R6eEtuRzNwdnE0ZDliQlMzbEhBYXJMOG04Z2pNMEtV?=
 =?utf-8?B?Yms2VUozeFNpVFdLaElTdDBuSVJoUEwySXJmanNWZDhCRS9DUTVSQlF0OTFz?=
 =?utf-8?B?SHFMNGdzUCs4NEd4dk1McWpIUG0vb2VtQm1TWWtVbHRGS05PclltSmoyU2sv?=
 =?utf-8?B?NEhGTlNuZ0lWTW4wdWRieGc4ZGJBNXBQMWJoRkFVRE5qcGdlN1E0cmU0WVUw?=
 =?utf-8?B?OTZQQm4rYmxrV0ErdWZudjlBRVJGQ3E4dXF1SldZN20ybWFlTnREdzRZdzI4?=
 =?utf-8?B?NDNreUtzUDJTeThvMTFhNHZuQldjd1o3UElHek9CbnpoR09aejBhRCtiSVVy?=
 =?utf-8?B?d2ZmVUc5a3NpWVExeXV4TGp3OGtTQ2FJSW5rb0VYcGc1UjdEWXZHY0hsSkpQ?=
 =?utf-8?B?Z3I0RGltWDRYeHpROTN1bkFsR2RJa0FWWkhQSnFMeFl4eTBDRitDNzdtTjVP?=
 =?utf-8?B?KzM0NGJhNXlLYmQrUDRSMkk5UDhEeERYYXlOajlucjI0SUwzZS9IWU4wR25O?=
 =?utf-8?B?c3JaWU1oTUtybU9tdi9pajhkRmF3TnJPZkxqOFF3NXJUNVdnYlFsTWpPcFBI?=
 =?utf-8?B?dzlUZldLNjFyb3FoNGNWMWRyeWFRWDBva2hNTUhva01EQUVTQm5yVEZkRG10?=
 =?utf-8?B?TndOVFF6UDVjRmJ1WDFnSTBuRlNMNXorckxqakw4Q2VXbytrZUlZazMrOXdM?=
 =?utf-8?B?ekk2dnR0Ymp5Myt2bFpRZXlYNm1Gdmg2aVlYQVJZcFJMMzhKYUNKYmtIU3Zq?=
 =?utf-8?B?VHlyRVVQOUJIdjhCNnhwRUZiTFNtWm5VeDRnSUxVejVubnVjSENBTUd5N1Vi?=
 =?utf-8?B?c2xMSm9sbWxlRHBvZ0EyVjlhQnBhR2Y1QkhoVFBMVGJzNzNONHg5RU9FQTZH?=
 =?utf-8?B?Skd5UWVLR01wU25FR0RVdVZybnE3VHBYUElRVmdoNFBLMTRHcmlvVUtiZW90?=
 =?utf-8?B?WHB5OXJEM2t4T21NV01JYmhEazB1UnR1WHpHNjlWMUt5cGh6Y25sQlk3NmZw?=
 =?utf-8?B?QjZ5emwxZGNMZVVGbVF1SEN6eEVHNVpNbGdiRlphSXVHaFZLWnJJam44c2tS?=
 =?utf-8?B?RXB0OVBmVHg5SnRnU0RpNGtEeVEzalRTaEpUd21zSXpGTmZWOElkKzJNaG5X?=
 =?utf-8?B?K0FlMjRvR2VVbnAxU0d3MW9ldStNREpxS3Z3VlRXWUtkQ1JLekU3VzhFRTIy?=
 =?utf-8?B?TTZuSmE2NGpVajVhYStzT3FsVkZBOWFrZzYvQk5EOGNQTEdNZTFOSS9JMXlq?=
 =?utf-8?B?ZHhxVUdvRTMvOUwwQkRxQWJtZjhpUGlyYU1iaTJzT3VZQmxvY3J0eUxIaUJZ?=
 =?utf-8?B?Z3YrTUk2Rkx5ejhBUVpCeXU1dWYrZGFaYW1EcTF3S0lrUTI1ZkVRSWsrWEto?=
 =?utf-8?B?WXpqV216QTdUdUhrV1ZoS1lERkExTnpKWkZTREhsM3VsSGFqbDRkUUpWMW1s?=
 =?utf-8?B?UklKWFcxd1VjYW5qeU1Nd2hZcmpYc0w2RTN4ZlNTdExoUFhZWUY0d2M3UFBl?=
 =?utf-8?B?Nm5lRGlGRFFJd1IvSXFTYVN4NEJyWTgreWxXeEo3WTdzWWNnSlZySEFmS3NY?=
 =?utf-8?B?NU5ZTlRGdnZlNjBpUjl0SHQxS0xHWXkxVU9LTFFVY25leWptVnVDa2pIMjRW?=
 =?utf-8?B?ZmV0UFhQZytiSElaT1RlWTAyZXBzUHdqV2ZSL0ZwMTNnK0FRZm0xOWFKMWlJ?=
 =?utf-8?Q?JsqzwjX7EWXl6ehVow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmJaWm91MzBhSmJWclpHQXdGYytISWlEWkJBenNaUVJTVDgxT05PUEgxWHRZ?=
 =?utf-8?B?SEdhMjhzTEdqdlF4YllLQmJQT3VGNFZaUzFSWVluaWwvcDcwd0VrNXRFR0VZ?=
 =?utf-8?B?R2orOWdXREswVElkRjE4STlCdWVTbm9udDEwR3c4UzdaS0VkSnlBbXdVQi8w?=
 =?utf-8?B?TkRhQzVodnFUalc4SHJ0WnFGQ2xBTlRCWHlCK3ZxL3JzTWoyYXRmbFBwaHRh?=
 =?utf-8?B?eE0yZEVCWUZsT0VhaTY1Rzl0aWxMSlBJamNRUklPU3dxNGV4Z0N3RGZCTjF3?=
 =?utf-8?B?Q1N4YndxZG95WXQ5dW5jMnpoMi9BMUVqQ2FpYnZSR1JQSEFrT04xR3g3RVJU?=
 =?utf-8?B?eGdIVFU5STUycWh3T1UxVmVqa1ZTRHNKUjB4bWJUQ3hzOXU4N3VhYzBQWEpL?=
 =?utf-8?B?S2ptUEZDaVNmc2Rya1RkNzdCUDJFQkZrYWNkNlNlbWc2dnVaY0hlbk5ibVIw?=
 =?utf-8?B?VDdsWW1BazhORjc3M0dpOUJQSXhVTUlXcytYUzlTQ2xGcXNPMm1rYmRMVHhs?=
 =?utf-8?B?aHlWaXZNcGRqQ1ZYWEpYTm9XRzFyUC9RejNIdU9GNlpSc29yaEtNdDVhYUZ0?=
 =?utf-8?B?cFR6TEowazc3QXVzZ0NseXNkMlVCSFNxd0lxVHZWVE9nZGs4Umt2YUJzSERa?=
 =?utf-8?B?bm9WeFExSnBnQ05nWUMwUk5xbERWeXkrQm1PajRDNzZoZkhYdjZiYlczaG1K?=
 =?utf-8?B?bUNpSHJDM25XZC9UNUowSVdXTkNPeUVJN1dkMUcrdXNycklyOWdYVVZXOGFS?=
 =?utf-8?B?YVRMeEVmVWV5OXBKVENJT0s5RDN2Z3NDelVOR2xZOHRwMzRPeUlpVHFxcUNI?=
 =?utf-8?B?c0F3VUhhYW9tMW0vNXJCMUZ0TFZlMUJqNFllWXBJUm9wbVpUYldFMkg0ODBB?=
 =?utf-8?B?c2Z3a3R4TWtBTHdJQWFKcVFMS3l4VmpkcHZTc1VFWmRDMk5ucG1OaXcwODBh?=
 =?utf-8?B?NnJwNEJOdU5HbkxObTNGQ3ByWXI1V0NZWHlXdXpjd2F5MjAzbzI0YUp2QTdv?=
 =?utf-8?B?YmFBczJ2dGxFQjNrTXZOZFNZazBNNFNjaUV3SUtzaDBtQ3J6aERLcllqaUY4?=
 =?utf-8?B?dmVwMkloM1FzOGNZVVl6YTFERU9ucW5HU20wb3FUK1Z4aklTc1ZVd2E0d1RX?=
 =?utf-8?B?Q1ZkWmZuLzFZSnhkQmVHT0FRcS9FdmtCY0t2N2NicFhENVdmS2Y5RDNGRDNx?=
 =?utf-8?B?Sk5TMzBHQnZTSDdkY3NTRTZZMjRGZnBFN0k0L2VGZmVBTFN5d280MHFHeXFo?=
 =?utf-8?B?TXJRRThtcG9HOTA4L3JoclM0SkM0ZWRYdVF5NFFCMjdsaDNGd25XakJreUdF?=
 =?utf-8?B?ZVEwWFJ4a1I4Z1dHY3N6UTYzRStFUXRvRytiLzBCYWQyQS8za0ZvWHdIYmk3?=
 =?utf-8?B?WUxqdStYZ1pqcVdLbWtLMGxHc0FqTWM2VENpUFZvQndFcmFMQ3RONXNZOGND?=
 =?utf-8?B?QUQ3VlNOc3EvM2NDNlJwWGx6UUxwSnoraFFxcWluMFdBR0sxMlNQc1NCRU5C?=
 =?utf-8?B?R2NGa3o0Q093cEpvbmpacHplS1M1YWVZbU1DWHdqSGdGL1NlZjlWbGVNUjhV?=
 =?utf-8?B?Uy92N2ZuM2c1ZlFDN0RxSG10TVptSXQ5ZzByb0FpNjZxQmwvUDZMdUMyd1E0?=
 =?utf-8?B?YUI4UzA5T3BOdjRnRUdUUG5EcHQrTTB2SHlPTUN4WnlkRmZucDk4QVNqMEo2?=
 =?utf-8?B?UnA0NVFic1hLVU9xaXFSWWJCUUhvQWM2S2g2OUVzdi9hUmdrZkNvMWhzY1FW?=
 =?utf-8?B?bDgyU2twbkZHeDdvOTJxZGVjMFNUREkzZ0hqTEVSMWt2Q1RnOEsrVVBjMnNP?=
 =?utf-8?B?VWl2c3gydkk5WnJRcElGcnZuTUtNTEFvc1EvZ0FkL3o5ZXF5Tk5jb0RETG43?=
 =?utf-8?B?ZVAxWkpiTFRENHVQRytxTDhXazFOMWxMc2g4Nm9Md1RhbW9kL0NsZk9CaU5y?=
 =?utf-8?B?bE14SEpsU05ZK0VIRGUva2xlYTFqT2tPYzFzdU4xYzlyMis2RFREMlh1VXR0?=
 =?utf-8?B?alUzSUh6MjdwcWQrdUVLc1FOQWM3RzNtV2RQMHpvRWIrZVJ2SG1peC83T2I4?=
 =?utf-8?B?VXFVa3AzcGd6NVhIZkNCZmtzRTVSaUhFSnFvbXpJOGtpTUFLaGJ4allLbVl3?=
 =?utf-8?B?QnNXeEI0TGRrMGpMZWRZd0RJSlBtVWZhSjJtOGhCakg5K2tvaWNMeTNpZWxa?=
 =?utf-8?B?QlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a4bad8-0885-4a3f-d5a9-08dcc1234259
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 14:20:36.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4KEpQRZJuF0ZLgyMgAc8N2wup0F4x84TBmoyP/bW7ql+5TQlexdCFsSo3AMcZkMDQjILxRqMG6z6UAH4+XzcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5199

On 20.08.24 11:48, Beleswar Prasad Padhi wrote:
> 
> On 20-08-2024 15:09, Jan Kiszka wrote:
>> On 20.08.24 11:30, Beleswar Prasad Padhi wrote:
>>> Hi Jan,
>>>
>>> On 19-08-2024 22:17, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> When k3_r5_cluster_rproc_exit is run, core 1 is shutdown and removed
>>>> first. When core 0 should then be stopped before its removal, it will
>>>> find core1->rproc as NULL already and crashes. Happens on rmmod e.g.
>>>
>>> Did you check this on top of -next-20240820 tag? There was a series[0]
>>> which was merged recently which fixed this condition. I don't see this
>>> issue when trying on top of -next-20240820 tag.
>>> [0]:
>>> https://lore.kernel.org/all/20240808074127.2688131-1-b-padhi@ti.com/
>>>
>> I didn't try those yet, I was on 6.11-rcX. But from reading them
>> quickly, I'm not seeing the two issues I found directly addressed there.
> 
> Check the comment by Andrew Davis[0], that addresses the above issue.
> 
> [0]:
> https://lore.kernel.org/all/0bba5293-a55d-4f13-887c-272a54d6e1ca@ti.com/
> 

OK, then someone still needs to update his patch accordingly.

>>
>>>> Fixes: 3c8a9066d584 ("remoteproc: k3-r5: Do not allow core1 to power
>>>> up before core0 via sysfs")
>>>> CC: stable@vger.kernel.org
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>
>>>> There might be one more because I can still make this driver crash
>>>> after an operator error. Were error scenarios tested at all?
>>>
>>> Can you point out what is this issue more specifically, and I can take
>>> this up then.
>> Try starting core1 before core0, and then again - system will hang or
> If you are trying to stop and then start the cores from sysfs, that is
> not yet supported. The hang is thus expected.

What? Then the driver is broken, even more. Why wasn't it fully implemented?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


