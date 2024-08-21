Return-Path: <stable+bounces-69844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DC195A478
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 20:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7AF1C22A4D
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD68D1B3B27;
	Wed, 21 Aug 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="NMufYbyg"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859D1B3B15;
	Wed, 21 Aug 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263844; cv=fail; b=aeBJ/wKcRonl7CJxnLubz87q6UIs3u8l7EmytT3VQqR6NEYv/kewySCQcuMT6sihuxt+A9DYVmyE+1p7/sT/JX610ZOJU97PgjyQWjckLhrkzo1tf4b+4aUPtjN80ojOnRsWx8PBCL9OqQy/NqfTuJRHANeSXGP7K3ASUKy6fU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263844; c=relaxed/simple;
	bh=mQWgCDicwfO3Szk3W0oBFrVbaP8TZWSpdlAmedoP9Wg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UpvKGLAn77uSzMUAvSek2qTPI4v0P4pIoniRZazexjgWidsHkiKA6oV85/vtXRvJd29DkAhew0VDDdqgrMWhlwFs7wFmk3BQcpyCFbqlz8B+qrgvXP0gGtK9XB7x3642Vc0RzQSTLFAIqNxR3I6DmRfp2tCdyJyDvSfsMLtaZts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=NMufYbyg; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqZIbf3b3Qb36geOfJ/BfKdSotuK4VBu6iknWDPOxJEhAu9sFvA09ozHHAsUA6XWc/ycGG5zfrTxX2XAT812qj08xumeefWKDoCyBUpZsKqppmV45Tyax5ppHa2BTNam5xaADG+3hmeVjJLI2EAJN+VwpB2K274BTC6pk8NI36rpgdbPY75JKLWvFBjvaUOEwi/yvMSVRGJ4taRSt29vITCLdrLTHFimcKAQI4YG6IValeN858qGZ+YtTWLgy9Mcg2tTqv2qYaMUk158my+KIEcVJVwP1U+2P2DXLE1uXmF1MX+oIdSXFt7nfHWNVB//cyrxLIOd7wRhFftooBroPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUl2FSia/hYbYTKZ1qKw8paU9nW2Dz6/9d4kbIcA1H0=;
 b=kHp/Ei4VLktLCKz5tf5iRIf/3qih48iYlS23wLfT7YYKt+FaeHfZm2i9ZVpyp581FBGCm/9KhMvXye8IVrkA9YR99AxILfOwb1EeVTt3ACQ9gp8lZFOau+cb+dkawKEaj2MkpmrhG1RrQ3u+1sYZahfcj/ikdq6Bmuy2hioPbPmK2ov/r+sfv/R23fEb2KDFc8eYky1fjIhv4kF9m0tN2jBJ4sBS1GJTW0VrzBpLRryqUnqDtivE6JBkSTxye9d+ACTjolfiPQL9/h7V2hxhmCgCcYdzz8RF/c1VYFo7lV7/Ohl4ALt622u3zAhSXg/3smAOe1MWkw89xFqpr4TijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUl2FSia/hYbYTKZ1qKw8paU9nW2Dz6/9d4kbIcA1H0=;
 b=NMufYbygPUPS2cRI4MmKOlfS8nYks5ebaQrLqF72yFYhom2q349E7ZPvqhqA3XIq3UNwZ5W5jiT9XjaBU0jffE2ZmZ09Urr4wW6y073Ux7P2XfPmSu+HlPESgMuF/99E4/KyO1GerQsnKbtyXWAn10Tv3x7Mo340I79YRrnOx2DecIkDQSd7w8iNrIT5nUUXYhQJFT2ivazuM66AT26x5vzf2Yw7DqgzhP7doGc9EiJ8P/YbB7Y90b16Vghnk5z4gFFgXOxgy9PMs8OOjnP3opy0UxG/geMku3BDb8SdPm8SuL7H3R1HO5vTR5C2FXl4vvsgwzknbW56U8TIl1KgYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:49f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 18:10:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 18:10:38 +0000
Message-ID: <3c8844db-0712-4727-a54c-0a156b3f9e9c@siemens.com>
Date: Wed, 21 Aug 2024 20:10:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix error handling when power-up
 failed
To: Beleswar Prasad Padhi <b-padhi@ti.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-remoteproc@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Apurva Nandan <a-nandan@ti.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <9f481156-f220-4adf-b3d9-670871351e26@siemens.com>
 <cf1783e3-e378-482d-8cc2-e03dedca1271@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cf1783e3-e378-482d-8cc2-e03dedca1271@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: f9258338-8123-4f3a-93fc-08dcc20c8f8e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blZrOHJpMnFWY1JjZTg4N2FhVDB4eTk1MXdYNFNueTNyb2NFUDRSRWI5OEIv?=
 =?utf-8?B?a1ZRV3ppTEtGNjIzOVNhbnEzUXAveWxLNm9OcHEraFJGOWZ3WVhWQlpVVlh2?=
 =?utf-8?B?M0Jwd09hU21rbnNFVjBhSnR1aUNtaDI2Y0pDaVMrY1E3TVdxVVU2NDhWUEMx?=
 =?utf-8?B?RlNHeU5GWUJxRmhWaXV3ZDZ3Tk9oczZXbzhWUkFBU1pEOHE4VkZwN3dVT2lz?=
 =?utf-8?B?VklobTJteW1wcmhuYkJ5WDRJRWdhMU9sYkJhbmhkSHRBb0R5aW1aM2dxd2NC?=
 =?utf-8?B?RXd1Rlk0VDRITFM0UFVxc1JOOGtEZ0JRYlgrb2lvbjhRTENuaVQzckpYWXds?=
 =?utf-8?B?KzBwbFd1anVZblVmc1NhZlVvcTlXKzVuSDhhV2hac2VXTkl0WlNsckF3cmVD?=
 =?utf-8?B?TXBBenlncHFva2JSREMrdlZNUzNZazJNUkZJb3dZL1ZCV2x6VWFPSDFoMDQx?=
 =?utf-8?B?TXYvSFd2bVZSMDY1cTg4cXlUZjBpcFNHdDJpU0dFTTgrRkdhbDhQRmhXcVMv?=
 =?utf-8?B?bWRscUFyQldRdkp5MFJqNlB4b2NvQys2THlnK2Z4RzM1bDlZU0ZCUncyRU9j?=
 =?utf-8?B?QmhOcVNwRkdvU3kwRWxlSnd4MGxLM29Vbm0wQTdrcGF0U2tPYVhUWGp3Z2hU?=
 =?utf-8?B?SWNsSkl1d3MwcWZVajhvb2c4YXNQbSt3TVFOdkg0UDBrUEpzWWZMSWJxbzV3?=
 =?utf-8?B?K1F0MGhzTVE5MVJQTUg0d2pXZ3BYR3JuZ2VmcjlyOUE3VWQxZ1R1VkF2Yytk?=
 =?utf-8?B?bk05dE1KWTlvQyt5b1MzREUyc096OGpLMkc3aDRXSGJXczNibGpjWUNoMnpN?=
 =?utf-8?B?OTI3c29ZM2NSSFdST09DWkxIS2ZTYTVrTWhlVmgvWitXUDlXNGxhbnMwNkxm?=
 =?utf-8?B?dUFWd0RUemtqaTRBbFhpS0UwZXg1TG9DejFaelZXSDZLeHFFZ0ZKK2V0YUhF?=
 =?utf-8?B?THVyOVRTVXlqdFlQaU54MzVKOStnUm5nZE81U0VJcXlqZk44N3dHWW9Yd1FH?=
 =?utf-8?B?bkEybXdvbzg0ZHRGeUV3WW91SWh2WUs0ZGYrOEpQeXpxZ1VNc1kxOGs0Q0Zs?=
 =?utf-8?B?b3FPNUJBbjlETEdCL3YzU3dkL3NaUnFGNmtYVU9YSElmbm90YmRseVc0c2F5?=
 =?utf-8?B?L1JMeHdoMHRoM0s1VXY4ZnF5SS8xRjBRRzBGVk02YXVmU2QyYVJtanIyWHVx?=
 =?utf-8?B?aU9UcFVmQW41SnR2OElNZHp2YWU4R00wTlE5TGpiVEo0WlVXUmIybFBqZlgw?=
 =?utf-8?B?OFB0cVAzbWFqY0ZlbE5nWjdvN3FkOGZGVVRldzYzNGJ3TWoyR2ZtRk5QSmov?=
 =?utf-8?B?YlRWc01GYVdrSXFBZXd4R3RWUGhlRXlFTy9sYnRzRCtpTFdsRDE4Z2I0VGdN?=
 =?utf-8?B?SlNsa3dQZTQ1TjE3TkZGb0FJT2hvYml6L3hYakk4SVhkNjQrdUlmU21zY3lI?=
 =?utf-8?B?SGsydVpEQi9KYzgxWEZTWGFxSGsvSmV6TEVMZ1Uzd2MydnJXdjIyU1VlQldQ?=
 =?utf-8?B?NUZGVGw0TWorbC9pSWNkRGJDdW82akpqbWRGb2F1aFltNTY0ZGFySXR5Uk4v?=
 =?utf-8?B?UUtHYUJoOHBuZDlSeXNESjFwejZzN1lDWENFWXkzSGpzOFZjSnlYTElBZWh4?=
 =?utf-8?B?V1lsaStkYkU3YUw5NjRWRHRqS0lra3ZVVTJxWjFPOTUvYlhwbWdTcG5BTi90?=
 =?utf-8?B?UlZlTnlrVlBYOHNJR283RnAvTXhKa0EyZjM4clc2TTJFaEx2dUZhTDNwc0hw?=
 =?utf-8?B?V1ZSMVFvd2QwL1R1S0JTa1kvSG8yUjhSTWRhTTdlaG1KTmFmSlZVV3NSbTRL?=
 =?utf-8?B?d08rNzdsNmd6QTJvTDFhUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHBWeEVDS256VWExTCt6QnZaS0FJejFsS29GUEtqRHV0UTdXbk1SMWl6Ujl4?=
 =?utf-8?B?VjNxeGRDdVNscUhPbGxGejNQbHU1bmpBdWc4MzNXTHdzRW14MkVZMXdCOE5H?=
 =?utf-8?B?RURMdWtURUJYd083d2poTXNYZDh1RDFrR3QySnB4dDZNUEVoNGRaanRrTEdS?=
 =?utf-8?B?ZjRLZEZVbzlZa00vQTFTYXg2aHE5Ui9BaFdjSm4zOTlMczZtbnhleE5TTGtO?=
 =?utf-8?B?Q1BlM0VBRTJ4QVFWUFdlUDdSbGRUNjg5eEZYQW8yd1RaS05mbXJ1clh4NmUz?=
 =?utf-8?B?bDQrUi83T1ZML3RwMm5qSXhVcDdwTUlvUkI3bERxT1p1UDFYOXBJWEE0S2JP?=
 =?utf-8?B?c09FV2lZUldVSHpKeVRiRVlDNkZPMU96bVJzRHltUnJMQnZHNVo0OWFuQ2JS?=
 =?utf-8?B?VWxiRXJyUlAzazlwYWl0Y01mbVRBZ3Z6dUZjMXJ1V3p1N1R5WnhneXlxejVz?=
 =?utf-8?B?cGhRUUtwdndvV3c1SXM1cmtaZXIrT29YOHZBV3JqVWVZMjRIb0lsVVVHdWRP?=
 =?utf-8?B?aXd4K3BjNWNsM084bE5mQ2hTcFpJTTFMQ3JnWUk1UG5EWk44U25QZy9TdjVX?=
 =?utf-8?B?ZHNPcWJLWThjYjBmRFh2enBsQ0xBUExOTFJUa1dIc0hSUEY3R0M5Tm1jOU1V?=
 =?utf-8?B?S3AvUlZjQ1kybFFVT2twNHBvMzRvYVc4QUFXRmoxNWdPYlFyak81eVR0dUVw?=
 =?utf-8?B?TlAvODFsaVpBVjFkcWlhbVhrd0tBR2tSWWsyTWdIOWNWYmpweEZJNlBjMGlT?=
 =?utf-8?B?dFU3enViS3J2eW82Ly9LakRVYlNVMXRPaWdXMWczMENNeVgwV0Q0dHVzZTBS?=
 =?utf-8?B?TDk3b1QwSWtmMFFmRTdvRlJabjFGZHozajNaUDFqVUNjR0ZFNitNN25ZM2Mx?=
 =?utf-8?B?aWtCOU9odjZsK0JGZVZWcm43L3F3TUV4dE0xcDd5Z05vbTVzU3A2bDRVSFZw?=
 =?utf-8?B?S2RQcDNMb29TQmlpWHpkUnlXNGRCYTRWUDIyU2M3Vm5MVE5QSTFpZ3lDSGFr?=
 =?utf-8?B?cTJ4T2RHamZzSzhIWTdYcWw5bEFnNWZrTEIyUmFlTHpUVXNQWlhleC8yNUZm?=
 =?utf-8?B?bHJIZDBzVTQxaEFqSVlKZ1VPN21OT3VRL2ZVNEl3UlhFZW00U1FmNzE5czZ2?=
 =?utf-8?B?UjVVNW9pU0lLODRkK1I3NllEVC9nazhMVVRjN0tmRUpRUkZ5UFdMWGVGbFla?=
 =?utf-8?B?b0tMaGdTRnZSeitxdVo2ZE9aZ09KZCs4NVdJUksxMEdVQklyUVFrL2xVQms4?=
 =?utf-8?B?UWNDZ2s5aCtsSDNJaDlvbmwzcnJGeWVlTVRrell5cVp4QnY4SUtGaWpsNktj?=
 =?utf-8?B?RXlSbDBLN1NvbjhjbzhrRmpFNmhMNFFHZWlCSHpGN3UramVIc3NNeFFZU2lj?=
 =?utf-8?B?VWJjNnR0NTVnWFN5cThVejUvT2hlckNCVDhmNmZXOWo4Z1M4WTlmY0pPaWNC?=
 =?utf-8?B?UytQRDRuNU40Z0J2U2tEWWVTdVlISTdURkpEc0RQWUp3akxYR2F3Q3BMcEIy?=
 =?utf-8?B?QmVTQ0hmQ01PTzhKa0MwMU1MbkRwQVZxVzhKZjJ3dkR4dWJ5dEtXZ3k3L09m?=
 =?utf-8?B?ZDhhL3J0WlV3QktQTWlpbExiNFNSM2x5TFNyT1Q2UUp0WTFsQnlnMVRDeUxC?=
 =?utf-8?B?S2xoMWZ6Ujc5RlRWV3RGVGdIMVJ3dDFhVllyOVd6dWpaNFljZm9Qc3UzMGVa?=
 =?utf-8?B?N24yQXlvb1hPc0hnZDI5N2swNWdjV3BNZWIwL1cvMHYvZXp4M2ZZVzJ3R3ht?=
 =?utf-8?B?TWdZM2llbjRiUmZsMGtXSytMOCtKNS82UHhMNXltM1hxN0dCMnBBZy80RDN6?=
 =?utf-8?B?YlFBU1Z6bTJMODQ4bkg0SERQcWMyK0VJVkY3OHZiNXN0bys5bnU3b05Od044?=
 =?utf-8?B?VytqQzIwdFprajdQYkNIKzFQM25Cdm51elZXVVc3MUEzSXJPT25JTUZXTEZW?=
 =?utf-8?B?Y2ZrbXJLTVl1MUtVZWNsMk5OZUVZL1BnUGVneG9NMUdUZzdkdWlOQUdlaFdG?=
 =?utf-8?B?MjlXdEppbGVwemN4MzY2QkFCN2NaYllISDRmNEdhTlp1MXl3UVNQZGpMYXVI?=
 =?utf-8?B?aVRvR1Z0ZTNqQkR1YW9HckI5UUtyUSs2Y24xNTFCb2xPdmxmZnlydGNQbllD?=
 =?utf-8?Q?YsfDwyNX99O75hu5g0zMLkfz3?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9258338-8123-4f3a-93fc-08dcc20c8f8e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 18:10:38.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qPXDDWhOlZb4T9jWKB7TLbCSwkb6rdmc8mY8Pl5fI8npaQ9G4t2kH7lkFXyq19kmJL7SxOZrT+G223L2L4o4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7815

On 21.08.24 07:30, Beleswar Prasad Padhi wrote:
> 
> On 19-08-2024 20:54, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> By simply bailing out, the driver was violating its rule and internal
> 
> 
> Using device lifecycle managed functions to register the rproc
> (devm_rproc_add()), bailing out with an error code will work.
> 
>> assumptions that either both or no rproc should be initialized. E.g.,
>> this could cause the first core to be available but not the second one,
>> leading to crashes on its shutdown later on while trying to dereference
>> that second instance.
>>
>> Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up
>> before powering up core1")
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> index 39a47540c590..eb09d2e9b32a 100644
>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>> @@ -1332,7 +1332,7 @@ static int k3_r5_cluster_rproc_init(struct
>> platform_device *pdev)
>>               dev_err(dev,
>>                   "Timed out waiting for %s core to power up!\n",
>>                   rproc->name);
>> -            return ret;
>> +            goto err_powerup;
>>           }
>>       }
>>   @@ -1348,6 +1348,7 @@ static int k3_r5_cluster_rproc_init(struct
>> platform_device *pdev)
>>           }
>>       }
>>   +err_powerup:
>>       rproc_del(rproc);
> 
> 
> Please use devm_rproc_add() to avoid having to do rproc_del() manually
> here.

This is just be the tip of the iceberg. The whole code needs to be
reworked accordingly so that we can drop these goto, not just this one.
Just look at k3_r5_reserved_mem_init. Your change in [1] was also too
early in this regard, breaking current error handling additionally.

I'll stop my whac-a-mole. Someone needs to sit down and do that for the
complete code consistently. And test the error cases.

Jan

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f3f11cfe890733373ddbb1ce8991ccd4ee5e79e1

> 
>>   err_add:
>>       k3_r5_reserved_mem_exit(kproc);

-- 
Siemens AG, Technology
Linux Expert Center


