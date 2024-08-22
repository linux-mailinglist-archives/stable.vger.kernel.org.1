Return-Path: <stable+bounces-69862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCB895ACDA
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 07:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C18B21528
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 05:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF68524C4;
	Thu, 22 Aug 2024 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="JGIwF+ae"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2063.outbound.protection.outlook.com [40.107.247.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A8836B11;
	Thu, 22 Aug 2024 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724304473; cv=fail; b=IEygO3NwohNQohCiShQDn7Mi0N/lGkjCp2IAe1eEo6OiZ/5L+W7pXT0l6Zrcvt1gIwu46kqAeOTth53B569IPzD072BJHPVpHM2pAaI0XxRSvpp3n5qwoFGeUpyCmHUhT/Ue2+hPlXSx251O6W7BBSQr6xCYT9RcV9qfEx79QCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724304473; c=relaxed/simple;
	bh=hnZx1rpBzoKoTzsUnFHlIUIxJrG+EZ+pKVCv1SIILBU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q4AtIph9Sa6cWqpYARZHEJMJeBTFsZtDHHVceJOl+n1y1UmVSB/sdJUcub5cIREUTRxWdV7k4cAaKMt6nhpCIAjwxXJMolNdOlgoLkHkeoMxCk//uApjBKP1Rnc5a6xmH7nOcnCaC6uG12PAPr0zIJK4JZGi8/130rmcthD/ycI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=JGIwF+ae; arc=fail smtp.client-ip=40.107.247.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsfkYKih3mbhL6Nkp6GCY8rXuSC54Kok+Fjj3VNnJhnVHVW3QS3BtWLeX369Vz/GM6BwwjMjVY3WmqdnrA/1KNAJXd7KsG/4uErvONjt9O/Idigrd6YATUcVzrcI+aXNekHzmtOYr/wT/CgbEiVW9BzFAigZUADbqRI6Q233aH65d7oHm2cT/Ty1jNPgtm+CZ8/iSPYU6r1yDoQ2LwpoQnvdRkQ3mdJXV2tKqwo93JvRTUmLNrqVNg33JBpzQOpKljlaKVmozQP/U3/sfcin7so5eSZ3QFUGVb/f3X/eU3nYtbJFAbfWqwfIFLpOoGvg+vIZiNVMwmYzKw3x4N/lsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw9ZDJeDrY4dUAqBfRnhNGwUStGITmo/rsmHDK+6+Aw=;
 b=TWKnHjFRGHBtQMA9xVXuopndFvGn9azxe+kr5JVVcE4b0rQJTvRu6DCa5TvT5nCzeuTGBzD8iwWSkGS8k5RsNwuR8W3InLJSgb6a4WCi3JYTuDSXO6LP7yWOnFXImOovNncyy+0vJ/NwzyhIu7oa6b5+q1aIAxt5qv7EFNU43RCWdsscQpvWCYK1WnHLtbECl/ViBWxD44SdfCXHMXh+moGfZzWQqKp13Jg9YGdxbQp4V5bpCb70trRgqrLmwqI/Xm60pbVJ8SBGWOfe+m54R9gEBAZ1R8K7BfU7ehtZe7qs2E3n+a0iwiM2KhVnzuqWxILui4f/xVi4c5Zbu3x1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw9ZDJeDrY4dUAqBfRnhNGwUStGITmo/rsmHDK+6+Aw=;
 b=JGIwF+aeMQSUVMJwHKTT4qeyf/fhY8mTNHwTiqNZEPbzVowCBGxk3bQCskgDBWrvZxrW2QXluAaRjKlf0txuvK4Z70h4NbGjsWuhyPYTWFQOEqjyI102IftV6OrfobU6IAb/sp0eXziHb6uDfcjWHHTNWwLnDP7/S2U+FIOgeQPQ9RWM7vm42C8XcdP1RmNz5iBr27ht2OS3BW8iy4nqm9PUBr6lyOaeBDnCQ/KiIr90KJxVYwtY+s8syCT7Y2BP9mHon/84bXFKdZ0rXbZhkBqt4Eig92vjDQFhZa2oC5B6dKW6N2S0x9TyHi5ympwPByKOpjhWe+blFI0LMSz4cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB7423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 05:27:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 05:27:46 +0000
Message-ID: <eaa07d0d-e2fc-49f2-8ee6-c18b5d7b3b5f@siemens.com>
Date: Thu, 22 Aug 2024 07:27:44 +0200
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
 <3c8844db-0712-4727-a54c-0a156b3f9e9c@siemens.com>
 <716d189d-1f62-4fc0-9bb5-6c78967c5cba@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <716d189d-1f62-4fc0-9bb5-6c78967c5cba@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 376eab8c-4a6a-4ab4-d129-08dcc26b278f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFJkVFBwV1pZT0RIcVNCaWhSanFaa3Z5MVpHeTRGSnZjK2VYU1B0a0VHbXdX?=
 =?utf-8?B?WGhWODZodXZYQTNvMGFneHd1YU1qdmtxcXhkVjhiMXZjZmQrdzlpbUt1Qy9y?=
 =?utf-8?B?UHdubDV3SVdqNjZESFJ1Wmg1RXNnbm0yNm83WW53TGh6YjBjTDF1a2p5Tmtk?=
 =?utf-8?B?UDV3TEZXdEIzNnRRYmUxVTBQS1czSzI0VkhlOWUvZGI3Si94R3VZMWpRYkFN?=
 =?utf-8?B?RE0vcTBnQ0hRUE9keG1JSU9NNnBuVERQZmxHNTVqTkJZQWVCWit6dGlkMkht?=
 =?utf-8?B?ZWl2UDFQU05QcW4zSEkwM0g5aEdydTlMa01JSExrN3k0YmJuSCtMS2JzZFNp?=
 =?utf-8?B?NlRkdUNVWVFTMGM0RW80Z3oxRncxR3V0d2tpRExMMEMrazdMTjZnSndDMUlL?=
 =?utf-8?B?S25XY1VBUDVnbDlLMHkvSjArNWxuUmE0cjk2bWM4dkRtY29vZG54RFpZcSt1?=
 =?utf-8?B?dXlaaTVSWmRoOC9wa0xFdkFzbVFwV20zSG85WlNDc3FDYy9wcndtWGdEZXZI?=
 =?utf-8?B?aGRLNlRtR0J5Njg1YnU2QzZzYVh6YldZdzZNcTU1Q0hKVjdqMDhUNHRoeVA4?=
 =?utf-8?B?am9oVThONjJGd3ZNaFM4Wk9JSUZ4UEVFV1FWYlI5bDdXMGk2OEZHOHdpRU0r?=
 =?utf-8?B?Q0tMZ1RWYkRuL3gyUE5OZ09mQWo3THgwSllma1pGV1ZTWUJIcmsxdi9QSVIx?=
 =?utf-8?B?Q3hoVUYwQlZNSXFQalNqdXVSRFRKMWxKV0Z4SFFoTGlHMG5LZXNyUEZ6djdQ?=
 =?utf-8?B?VzVTUk1IWHB6M0lqS01vSEJCSk84T1hSNWhNQ1VseitRTEV0cDVsSXlqZmEr?=
 =?utf-8?B?RTBFanFBRmVUQ1dKWWFjZCtGMEN4NG5jTTgxd1Z2Z3FEZ1I4SUYzaDFQUTdp?=
 =?utf-8?B?ME95bGZFdHRyM0tuank4SmxyMGQxZnRDeVR3U28vZlBhaWZ2enRMU0FNNWpF?=
 =?utf-8?B?YWNITlBSU3ltSzBFUGtWSUZJam1RWjFpejZZK2ZlRVUwU1pENXpJaG9wOHN6?=
 =?utf-8?B?K1d6RHlKVG9DWm8yTHAzMDVjT2c5TzhyS0NlWGVSYVlTOXRYOEZuS1JVeTZB?=
 =?utf-8?B?RU52ZnlZdUN0bHpqL3dkNm9BVUg2dmhoNER5L0NSOEN4SFEvZ25MWmpQVUFB?=
 =?utf-8?B?RThldFA4TTBHRVRLR1RxcVdTbVc4dVZQdEV2S1hqTEFoOStYbGxxTkdlQk5x?=
 =?utf-8?B?d3YxOGxMdS9HM01jNVVKWmtrdGZxNVBIcjFFM3lzRTJhelNkejFaajFRRnVT?=
 =?utf-8?B?eUhsOWlTbTJKdjhjdWR0bkViYkRXWEQrNXdkL3c5Y0NpNkF6NFN6RWJwSmpG?=
 =?utf-8?B?amJqZGZiV2xDQXJiZWdhTnNkMEdObkc2aS82S1o1eTJZZlpaeUdOZXhQVG92?=
 =?utf-8?B?TmpCdlQ5T1N6ekNoemxiT1Rza2ZvQkFpVzlOMEVsbUVvMHRkdDhQTnJpdDV1?=
 =?utf-8?B?MTVKMFhzNmlCWFJNV3FhVHQ3NUlubHZmbVl1TEFKalFTOWxJRWFPTVhxeXpI?=
 =?utf-8?B?SXd1RVVpWlVnTFBHTnFHQ2FaQUtpNEFPMlpNTVo0VW5lTjlDdEdvSmVjd3JX?=
 =?utf-8?B?dnM1bXg4WWdlMjNMbkdheWZoY3NTNSs0MzRyWitMbDVkN3VERUtmajZ1MDEv?=
 =?utf-8?B?Z1dVU3FCV3U4aEVsOWZiQU5qd25ubng3Mm9XazlzTHNCRFlQRjZldjNtS0o0?=
 =?utf-8?B?My93YnkxZHlLcjNZQmQ5Zk1oRC9BNTl2VFRjYkpQbXB1OTJjT2ZCRitLd0Nj?=
 =?utf-8?B?WUlFWE0zdGE2dno1ZGNhWFlseUU1NjUzcHV1Yng0ZUVraUVLcmRvdVFMWDRQ?=
 =?utf-8?Q?pmXRrYMcD/J24vrTIhTTLgb7b9oyymsmUyUgw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlA4RCtsTWVnTVZmeVpUajZFK2xCT3Y3NGQ0YXVTcGp6NG9vVW1uL2pxSEt3?=
 =?utf-8?B?T0J6RGNpS09sU2IvREhvaWFMRlJXTEY1aVExREYwQUp4NkdNYXcxOWltR1JI?=
 =?utf-8?B?anJkRmNxK1UrUUFEbWpSMU5yelg4VkM4TTRZNGFEMjQxU1Z0THJaQ2k5cENJ?=
 =?utf-8?B?Q0FFajRGb0R4SGxFY0RBRkZyMTZVNGRGUGlXMGtFbmZyT2w4NGUvb2w4MmhH?=
 =?utf-8?B?UGNaUG1RU3BJK1lmeHBQaklNZVJuUUg1a25rTm9Gd0p1T3RLTk5ZWlBxMm5Q?=
 =?utf-8?B?RlRvdmlUWGpXYy90eE5ZOHFldTluVTEvYSs1UWpJKzVzT1p1OG5CdFRxamFR?=
 =?utf-8?B?OCt0RVZwQ2lRZHExcEI0MFJ0QzhSMVpBdWU4YmJnOGhQU3V2Y21Yb0N0U1la?=
 =?utf-8?B?UHNTdGFyQ2dkV2ZkeGdqb201U1JjczRYWlFIRHBQUzJRcjJ6S2ZZYjg2OGcw?=
 =?utf-8?B?cHNnQmlFMVlIYjVydzRtOVFIOUtOOUp2M083R3ZheUs1d1g5NTdtaFh3di9E?=
 =?utf-8?B?VTgybUZiaGJ5Rlo3RERmK0ZPdWVhbFpWVTlFYTRVVldaTVZHUXUvRDhrcnk1?=
 =?utf-8?B?MWwwUk5uRXhlMGNPSEY4Sk1uV1VwRjgrditGOWx4bFRtM0djMmpMaWFSUmM4?=
 =?utf-8?B?VHpEQzQycnlPUWVITGlVRUZ4eHZQcVBrbnUzN1kvVnpDVUhXMDViMzF0cXdS?=
 =?utf-8?B?bW5NMS90YnI3cTJkWkRHNzRvM284S1ZBbDJaSHF4aldWQzVuQkpCelFHM1JS?=
 =?utf-8?B?RVB3dmY2STZBR25WQ2FkSTVPcmJjb3pKWjRCdGZYeExDVzBmVVNzOXhRejF1?=
 =?utf-8?B?dCs5K0tRMnVKbXQrNE5Cb0ROalFZTld2OStiZGl4dHVuUlVJcldTQm5VR1Nq?=
 =?utf-8?B?eXA0NEg4RktyNGRGSEJoQlJEQk93VmltWWZyV2RrZHgyU3BmczRYMHVpc0Uz?=
 =?utf-8?B?RkE3eDNyNS9LdHdxS1ZXU3NqK0w2dC9xakRhMG8welBJZ0s1dHJzb25QdHVz?=
 =?utf-8?B?dHRraHJ5UTJwTGdXN1FsREZId2Zpc3FDL2c0S2FzVFNGcVROQm9QQzRUQkE4?=
 =?utf-8?B?ek9LZmNKYkdobVczQzdydThNNVhDQi9nQ1lZbk4xdW8wbWo4b0IxM0h4blpP?=
 =?utf-8?B?YU1YU0p6YnAydTgvY1lOTkxsckJpQTc3TzRwV20zaDc3RWNyQ1djR295a2hY?=
 =?utf-8?B?UVBpOVlpcnBCamg5eDRMbEpPdDdLeURJaWRkL1BJbHdUamMzL1llMVlnSUJa?=
 =?utf-8?B?U3o5L1R6U3UzYmhNYXRXN3FYTytaN2MvTDlmaW5ORjBjdkU4RnNUVjFySVIr?=
 =?utf-8?B?WTVRS0xaK096WmFjNWd0SFRnTk1VcldRc0dzL0xPdTFtd1B2MFFwWGJPb3Vh?=
 =?utf-8?B?cGU3c0lnUjdlN2FqZUtvbkNLMkozMlB4ZDNjZWh6VXpKVENyS1J4M005THJO?=
 =?utf-8?B?eFFSSlF4QVozK05RdTkwNVR3MEFJNldnMGpDd0o5MmV0ckkrT2YyQXVTdmdv?=
 =?utf-8?B?L3lIcWRGM2wxeU5EUi9nMVZTTTA0YkVyY29HZTJzZVl5bHpMdnY1b1NacVM3?=
 =?utf-8?B?L29pelNoODZBSUJyQUJ3czArbWRqamFVL1Roby9xY1RnU0dHWUo5dkE3UDk3?=
 =?utf-8?B?dGpoTmJTMW1CT1VNM1RMRlhWQktZOGpWaWlUKyt3RmdMaytRNUIxWjd6YUFl?=
 =?utf-8?B?dGdPcllndUEvL1A1RzhXQVZuZU1RVW1xOTYyVDNBVkJCZU9vcVlSWlFCYVlv?=
 =?utf-8?B?a1lEWGIrenhUVGp4UGtSWHBnMDhjZitMdElwbHJqRUVsWFA3QytSakpabFUv?=
 =?utf-8?B?RnVWdDFkZkhieFJjZDN0MTMxZHFsaHRMME5ycjl1TTNWNkpSU0dYQ2tEb1lM?=
 =?utf-8?B?eTBOdGRDWWVBOWo4R1ArNGVXWFRDaktTaFUrWURVNUVHSFFrOEYvQlR3Mld2?=
 =?utf-8?B?LzNYaEtiTnJOcHpkQ1M4SzNzSFk4OTNRcnhwY1NuTXQyd2NoZGxYenZEa0xD?=
 =?utf-8?B?U2Z3bVpVdHlGSCtDL25oUExud3ExRGh5Wi9ENjhzVGZKamQwcVR3K3lXUU9w?=
 =?utf-8?B?QmdNZzVDZk1LYTNXWTBoWnA1MzFidlhRRDU2byt3bmVXYnE1MnpUQ1lMaUNt?=
 =?utf-8?Q?lQu516Ua6jyil2/3eiRR3OVXb?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376eab8c-4a6a-4ab4-d129-08dcc26b278f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 05:27:46.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: do8UOr1eR+cdkTin5qmGRwFMPh03bs7fxquhg9rTrPwM0ITfK3JL9DO0dBR08jrIloa9bw5K8vAyHpyxJUIrzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7423

On 22.08.24 07:22, Beleswar Prasad Padhi wrote:
> 
> On 21-08-2024 23:40, Jan Kiszka wrote:
>> On 21.08.24 07:30, Beleswar Prasad Padhi wrote:
>>> On 19-08-2024 20:54, Jan Kiszka wrote:
>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>
>>>> By simply bailing out, the driver was violating its rule and internal
>>>
>>> Using device lifecycle managed functions to register the rproc
>>> (devm_rproc_add()), bailing out with an error code will work.
>>>
>>>> assumptions that either both or no rproc should be initialized. E.g.,
>>>> this could cause the first core to be available but not the second one,
>>>> leading to crashes on its shutdown later on while trying to dereference
>>>> that second instance.
>>>>
>>>> Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up
>>>> before powering up core1")
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>> ---
>>>>    drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>> b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>> index 39a47540c590..eb09d2e9b32a 100644
>>>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>> @@ -1332,7 +1332,7 @@ static int k3_r5_cluster_rproc_init(struct
>>>> platform_device *pdev)
>>>>                dev_err(dev,
>>>>                    "Timed out waiting for %s core to power up!\n",
>>>>                    rproc->name);
>>>> -            return ret;
>>>> +            goto err_powerup;
>>>>            }
>>>>        }
>>>>    @@ -1348,6 +1348,7 @@ static int k3_r5_cluster_rproc_init(struct
>>>> platform_device *pdev)
>>>>            }
>>>>        }
>>>>    +err_powerup:
>>>>        rproc_del(rproc);
>>>
>>> Please use devm_rproc_add() to avoid having to do rproc_del() manually
>>> here.
>> This is just be the tip of the iceberg. The whole code needs to be
>> reworked accordingly so that we can drop these goto, not just this one.
> 
> 
> You are correct. Unfortunately, the organic growth of this driver has
> resulted in a need to refactor. I plan on doing this and post the
> refactoring soon. This should be part of the overall refactoring as
> suggested by Mathieu[2]. But for the immediate problem, your fix does
> patch things up.. hence:
> 
> Acked-by: Beleswar Padhi <b-padhi@ti.com>
> 
> [2]: https://lore.kernel.org/all/Zr4w8Vj0mVo5sBsJ@p14s/
> 
>> Just look at k3_r5_reserved_mem_init. Your change in [1] was also too
>> early in this regard, breaking current error handling additionally.
> 
> 
> 
> Curious, Could you point out how does the change in [1] breaks current
> error handling?
> 

Same story: You leave the inner loop of k3_r5_cluster_rproc_init() via
return without that loop having been converted to support this.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


