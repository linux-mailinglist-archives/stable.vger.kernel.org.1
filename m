Return-Path: <stable+bounces-66269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA05294D138
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AADF1C22569
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 13:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C50194089;
	Fri,  9 Aug 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s+7W6tRD"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285C4194C65;
	Fri,  9 Aug 2024 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210098; cv=fail; b=Vc0/dW4i2vqqNkWltRVj+xTyFnLmBO8vKV+yX7IEz9ANGqmoB9kyuXt+g4HS2OLroGAlpX3D14LCD2uS0Ur57MI3z8d3YwdlYVCJq6gRpDcod6MR3kgy6TNw37TRf4fcvTP5thc1FJ6DwoRyZAHuygEAZai1JrTQmVHd99BYGaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210098; c=relaxed/simple;
	bh=5nUcCCME6b9iwVdE3kg00S91AK7wKiJHLFulA4anoHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fZAiKxL3qYOgtFsDcmBycG28FvZB9nD9wMEXjR42sJUIQ36GyA7WZN4wlwrhbqblsOX3guK9JI+LpDMHrdVXcH4s2KnwELi2xirTK/Y/mp+DbpFkTO4+xadaeLeiki2BxPgmmua1a9I1AHU4fKI4S3EeD37mF7G+075AK2Ig60U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s+7W6tRD; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhwGD0j4ObWHh17oU6GTlB40qRTiRFuhlmTKgATT3KA2BtBjRtgrW/JkGKeoGKRU6LWf/ALC/X6luiRfHeNrzBpo3vBjx99tllfwq8aOs+kXqeIRyFi83M3IRHMJqi5TrY2DXqXoITtMFjTkusPPqzdPjjXw1kkMCGgLetN39fc0exisDqwYIJQLeGAPXzuJkzxS/zpjgSPO7slrCoAkmfTy7SkMZnI/lRwyZ5HuMtH4VMtFcZrd9oMBNAWI6n4LBLO3GM1y05fzBovISHPadati+iAmUErBe8sP28sH7LE3l4AHV7B1jvb94CCGxWNgeJL+s3n+WO5JTqPJ73KIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEe2PXgJVnQJ0aGExnYLxDTLs+MsZ+BGS8SYZg2FKhs=;
 b=gNmWEf56uaLErmJFGk0EhqXTh7rZ3lwwnJthACpSDaNXgAMolgcU81mwdVp59aR4sjCnrtnD2k029uyyQnyeSP/GozRRU4ywBeV3jxRMQCKIp/KWRYRPA53keB1gyFBu1TBlYcW1aTHUKGGqeRSvpiDFRsKv4yrFg8x7vx4Qd+34tQ8X1Ba4j+OWbRaAc0emPtSpEnldTDdbFLZKflYTLReSmBQXsPwZuPNDW72GBIamthvPz+js47Rn38cz99HaV16rkpkpIbX3lAv+4R1JsUU1ftyBGam9tHazosHG+fRSgpWgd5HHNH13mSTqREOW2fPF1DjrwRsxdCpYyrzTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEe2PXgJVnQJ0aGExnYLxDTLs+MsZ+BGS8SYZg2FKhs=;
 b=s+7W6tRDLAfBpOP0XRmJ/SKayiLrC00sIUVCP2d8KSWCkzL1+9kxab0edZNvZOYrTvuzmdhR24kmtbmgtvk6xIfwlekg7D8Ej62SaZW9WStr0PNEKya/nwkohSxv+nFyziYIDyaXTgIm5dx01znv87eCMRVUqxjUda/yn1+FcZoWCrJpsGo6TOC9O9Jfb5oNq7jFS85PLqrQ2AVcvBc9SLe6xb/QNd3Qx3WUHIfkgWHShATIAyz+AWPXkGX/+jwgi5jVyzldkHRYkTQlqDbr5rf37TuCj7WgiuA4n6ikGYs5l8eG00+EhULAg3IT+a0b6rPcHqj/UbboYuQlFZeiIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 9 Aug
 2024 13:28:12 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%3]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 13:28:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Huang, Ying" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/numa: no task_numa_fault() call if page table is
 changed
Date: Fri, 09 Aug 2024 09:28:09 -0400
X-Mailer: MailMate (1.14r6052)
Message-ID: <6233DD66-9A2E-4885-875D-1E79179146D7@nvidia.com>
In-Reply-To: <874j7uyvyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240807184730.1266736-1-ziy@nvidia.com>
 <956553dc-587c-4a43-9877-7e8844f27f95@linux.alibaba.com>
 <1881267a-723d-4ba0-96d0-d863ae9345a4@redhat.com>
 <09AC6DFA-E50A-478D-A608-6EF08D8137E9@nvidia.com>
 <052552f4-5a8d-4799-8f02-177585a1c8dd@redhat.com>
 <8890DD6A-126A-406D-8AB9-97CF5A1F4DA4@nvidia.com>
 <b0b94a65-51f1-459e-879f-696baba85399@huawei.com>
 <87cymizdvc.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <03D403CE-5893-456D-AB4B-67C9E9F0F532@nvidia.com>
 <874j7uyvyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A3CB2FC0-4201-4104-B932-27110C45565D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0294.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::29) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 530f9216-340f-4f3d-27b5-08dcb8771e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjVwU1d2bUFyc2I5MFJQT1M0cTZpTEMzTkRLdGFkc3liU3NZajViMHZ2dkl5?=
 =?utf-8?B?a09pY3hsWU92Wnp0WUxnQ1N5RlJFMjhjN25BUDN5ZWpvKzA1UDZ0RW0wQVZn?=
 =?utf-8?B?em5PM1RpTnEzM2ZEQU53V1R0U3htbkxScW80ZElISHFhQjg1UmxlSDR2T21z?=
 =?utf-8?B?bEVUd3RIMyszbW0vSUR0SDlsT0xLWW5mSUN3b3hTdWFmSTJBVEEzcnllbm85?=
 =?utf-8?B?cXZ2QTBWVng2WU1QRmtyY0VQNVpzcDQrT3RhbllCWm5mdUphWVNLTjVMU0ZV?=
 =?utf-8?B?WFcwMWQyQVpqeDMwL3NHc2IxeXhzWWhkZlFPODZhbEpZMTF4RDZMNlJoczZ2?=
 =?utf-8?B?RjNCUEEyMGIwM25SbG5XeDNrQ002c3U2Zm1MTjkxZGJVclFlUHNjdkdaQk4x?=
 =?utf-8?B?RXJWWG1rVmVrUDlSSXYyZDhEM2ZJQWxKekIvMnhzOGxnbTl4QXROdytDMmxw?=
 =?utf-8?B?VFA1ams5WWFnVWcyL0gwRE04a3liS245YVE2VmFJbmJvRVhyaEdJai8wNUxX?=
 =?utf-8?B?OWF5bDlvTUloRHNXUHNLZ2V2T0Y1bEdCeWFBM2k1SG1qdjJxQmJvR1A4OG11?=
 =?utf-8?B?SHZQRkhIU3RlRlh4dWZ0L1E0L0NjSUhvZXhLOEw2cDBiaUNuVW1lanNXUDRm?=
 =?utf-8?B?UmlVRnEzUWdDbmFFeEx5RzFMOXN5bm9Bd2RvTlI1MDBUYUtIa05pNVQrWUNl?=
 =?utf-8?B?SS93cXRaekQ5Y1Qza3g2WnMxWHZteXJJZWh2cWRCWVEzRmh6OVQwWXdUUEwy?=
 =?utf-8?B?blpVNWQ5VThwZHZ6WUM2Nk9nZ1VEcTlBTVhsb3B0aEM4TUJmMkh3WUVFeU5Z?=
 =?utf-8?B?RWRZSkdHanpXWnJ6SFhad0pBSHp4OC9sbDBHc3QvK2VGZlRtOUVMOVdwKytr?=
 =?utf-8?B?WHQ3MUFrNVR5MkRmdGZjZ2dXdzAwRC93MlgyeHJQOXg4bnhwbUJ0b0pkb0l5?=
 =?utf-8?B?WFV1cUdWWWlBNmNjdWg1RkdBbVJaTWVCWHRYTy9uZzdxRTRWNGlreUVaNkFV?=
 =?utf-8?B?Y3B6eXc2Tk5zVUxiYVlWakVkUFloaFMrNUVZOFhjaGJWSE15TGxwLzhQTy92?=
 =?utf-8?B?VjhuVVRPdGdObGRWbUJyNHR2aEZXL0Y4cUVRbjBUWnIxcGF5QjhRdHl1UzA0?=
 =?utf-8?B?SVdUSk5JUGhCWEp1SjZ4YktrRlR2YWhDUUZvY0ZMTTl3Y01DQS9aNVZDcVZP?=
 =?utf-8?B?SzBoNDhSbkhDR3h0V01IdnU2N2syTzlFNWRQVUhMNFZOcTl4Ym5vUngvU0Ny?=
 =?utf-8?B?eDM3YjFKM2FWSlNZQlRuU0NGWXFRK2dNaUVnUThHVGtpMFFXaVhRVFZaVEF5?=
 =?utf-8?B?S0VlalFhS0g4Q3o3czlrZDJ5bVV3RlI3eUZpQlBMQ0ZqYTd5d1BqQmRUajlk?=
 =?utf-8?B?K1FjajZ2aGRacFE2UXJYcFlRZ2VJQ0plbFRRSXVLYldKTG5FN0h0bVlBaEp3?=
 =?utf-8?B?NHRsaVlldDN6MzFoTnRiL0RFZlF0dDE4aTY0aEY1WlA5NjlhYVdwbG8yN24z?=
 =?utf-8?B?UTdkTE52MndEeVlCOGU1WVc4VTVyQ0kzdGdYd09lcVZRT3E2a2lBZWZJWlY0?=
 =?utf-8?B?YmhpT0R4L3pkazhIamcwbnYraC9YWWdET3pBejlaRk92VWVhNjJMb1JYRk5M?=
 =?utf-8?B?RFRNbzIyZEdUMk9rQWkvdlp0Ym1KdjZyQXpQdjF1bEd0VDlTaU45cklsbXlV?=
 =?utf-8?B?clVwYnBraVpKbjhIRjB5eUlpaVhtemRvR0tEZjhOaGk1WWV5b2IxRWR4bms4?=
 =?utf-8?B?WWJXOVF6VXN5RmdsMlZpQjg2RUFWWXphOFJtdDVXSWVOeVBNR2paMnJqMm0w?=
 =?utf-8?Q?UPOTuQ9LC91TCnGkV5YFmoMwkKbD0PX5bcIew=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEVHVVM4Q0xEWXV4ZkF3WHcvZThrSGxRaVpzSE9OeEJwa1JZS0YwRGlISkhp?=
 =?utf-8?B?eWhzUGtZSmRXd1ArUks2cFQwNm82ZDJMcU1LY2J3b2VaVEQ5eDh0dFc2Z3Q3?=
 =?utf-8?B?emVVQkF0aTlqVVR6ZmZ2L1JLMlBTeWR1blFVeEl3NXR4YnAzT1gxR1JhMVRW?=
 =?utf-8?B?NEIwL1JsNTM3Y0VHdVV1aExSUnQxVEVMOEY5amdXLy9iRFlrZENWa0tINmls?=
 =?utf-8?B?MncvTmpJVUQ0dzQvZjN2UnVOeHFQL2thSDE4bkQyenZnL2tvUkFkbUN0U0JN?=
 =?utf-8?B?RG5qZ2RaejRHeXlwZHBRc04zWW05MnZXK1ZZNDZwQXdKYkgzblJmVFhzYTVy?=
 =?utf-8?B?N3hSYUdkOUI1c0FZaVZYRktkckZ4cGhYNS9paVpoaWZFNHJTM1N4cUdUOE56?=
 =?utf-8?B?OWJWQ1E4bmtTZ1NwbW9lVGhzdHBsUm5lcHlSaUt0WUxSSXVDUWxveUl0TFdX?=
 =?utf-8?B?YVU5NE1QbGQ5K0dRY2pKWHIwSGJmM0hzQUI1NDh4VFJxaUd3dGgrQWljejRH?=
 =?utf-8?B?WmZaamk4bFByS3FTcnZVbnNLRXdSL09GcTNoa3dnSWhVcSt3OW9ycWN0dUFG?=
 =?utf-8?B?RGNwTS8wWEZoVWluMiszek9ScWVZN3RVYnJOOFRwVEdDYzREc0x4bjZ0R3kv?=
 =?utf-8?B?emdHdHNiQW9hVzVwcGZIYmpjS1RXb2pFUkxWdi9DdWpJTVMrMTdvOHVyVzQ5?=
 =?utf-8?B?L2lQcXczODdXNmxlQXhEM04rWnhFc1NxMDlZSDVQanpVQ2N2dlk2UTdxZzVU?=
 =?utf-8?B?RDBuSzdMN0JycWF2RUdwT2JzSU1PMVppTW1CakxiTTJNMitEQWZxd2xzSndx?=
 =?utf-8?B?VlhTSkU0QVV1ZUFDUmdDNm9kejZLdzlLMUlPeTZ6TVhoMlJPVXhseDBlNDJ2?=
 =?utf-8?B?ZFkvNkV5a2c0Skl3djdnekNqZHlSNGxSNWcyM1NLTFJFQmpia3Q2Ujc0RUR2?=
 =?utf-8?B?Q0xCbnBqWm1MT2kxRU05cUJvWk9sMVk2eDhOdDUrSjNYcHZibEl5WFdMT1BF?=
 =?utf-8?B?aEZtZ0p1TlU0Z1lkV2ZtWGJQd1hqTkV6VXlTR2N5bWdmTVBsWm05YVRFUldh?=
 =?utf-8?B?Tit2Ui96SmJ6VkZNTlkxY1A3Wk9GMW1mcjEvWHdIK1pEVmlVTzkrd25BbHdY?=
 =?utf-8?B?dmdDb0RERlo0VXVUTlVRV0p2ZXplcmxpc1hWSGN2TUNPN202dVdheFNMK2Ji?=
 =?utf-8?B?dlZkQUN4azVOekd1aDlQQWdnU0Q5c1ZseU5Ic0xBeEVaNnVoVkNpYS85Z3hT?=
 =?utf-8?B?TkxSSys1VDFpV0d3ZEwvTGhJM3NDWUZlaGZNVnMvQkV3b3hKSU90b2swZkdW?=
 =?utf-8?B?ME51UUdtOWtjSmVBNkM4b2huSytUYlJpUFlRRzFTT3ZQQjZPenJoVGNqR1Nm?=
 =?utf-8?B?OEYzM0hyWllBNVZ6Z2s3WEJWekJuU0Q0L0Z5aGg1K0tBY04zSnppM2hxS2tn?=
 =?utf-8?B?Rm11NUxLUGpuU09HYmVwY3dJUEM5Q3dRR3pKdjRDNzRtbWZuakZJU0Vza2I5?=
 =?utf-8?B?NUZhZTQxTEVpZnBtLzlqd2lVTzVpMGVhbDMrbzd1NUZidzY2WG56eWJVY2dS?=
 =?utf-8?B?UkJtTVZ4OVFKdHFVMnF3NmRwK2ovUXo0aHFYRW9VTEpRUmdBUkZ0VWh2NXdF?=
 =?utf-8?B?anFpb2N4SHBGM2tkTFk0QkdVdmlsdzVsQWZTQTRtRWU5YjY3eHNZd2VkSUFn?=
 =?utf-8?B?Y1pSOFIrRm0vWmlSaGhybkZtVmxGZEk4NXhSSUhJQVJMWGZwb3hlbGxyM0cw?=
 =?utf-8?B?S0FZOEZ4dExBa0IxbWFmRmpKMW9HTW92SGN0cmZlR2h1Y1E1NmwwcWVxSEN2?=
 =?utf-8?B?ckkxUjY1QnBDNkdnOFE3V2I4VkJSUWNmVm0xZ21SV0wxTWs5V3NoSm43U1Nv?=
 =?utf-8?B?alVzc3JmNytqQXpNSUtZMEZOSDZPZTJzbmpzd3JqTTBUL3ppdGFDWHN6NHdM?=
 =?utf-8?B?SlpVeGt6MFc2T1JTZkpNY2d5VzVTVEovQmJQNnZwbk1kTEFoN0dEbzBIWmZP?=
 =?utf-8?B?N3dDQUZDUU8wWnl2dDhLbm5WUnVwSEFuc3J1UjJRYmZlREFTTlBEcS82K29r?=
 =?utf-8?B?aE1SdHNGZmVmYmY3SGZGTU5iZVFzQmorUHQ2Mkt4ZDh4bnVyRW5sQlNmdWU3?=
 =?utf-8?Q?eEPcy8QOCwgswXpNKoLW8tR1Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530f9216-340f-4f3d-27b5-08dcb8771e1f
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 13:28:12.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVbuY3uv5r//6IyDsPOMaN9WmpUNLOyltTtQ9JpUi3K8dVF7gQI8hBW2QKMauUQE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107

--=_MailMate_A3CB2FC0-4201-4104-B932-27110C45565D_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9 Aug 2024, at 3:52, Huang, Ying wrote:

> Zi Yan <ziy@nvidia.com> writes:
>
>> On 8 Aug 2024, at 21:25, Huang, Ying wrote:
>>
>>> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
>>>
>>>> On 2024/8/8 22:21, Zi Yan wrote:
>>>>> On 8 Aug 2024, at 10:14, David Hildenbrand wrote:
>>>>>
>>>>>> On 08.08.24 16:13, Zi Yan wrote:
>>>>>>> On 8 Aug 2024, at 4:22, David Hildenbrand wrote:
>>>>>>>
>>>>>>>> On 08.08.24 05:19, Baolin Wang wrote:
>>>>>>>>>
>>>>>>>>>
>>>> ...
>>>>>>>> Agreed, maybe we should simply handle that right away and replac=
e the "goto out;" users by "return 0;".
>>>>>>>>
>>>>>>>> Then, just copy the 3 LOC.
>>>>>>>>
>>>>>>>> For mm/memory.c that would be:
>>>>>>>>
>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>> index 67496dc5064f..410ba50ca746 100644
>>>>>>>> --- a/mm/memory.c
>>>>>>>> +++ b/mm/memory.c
>>>>>>>> @@ -5461,7 +5461,7 @@ static vm_fault_t do_numa_page(struct vm_f=
ault *vmf)
>>>>>>>>            if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
>>>>>>>>                   pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>>>> -               goto out;
>>>>>>>> +               return 0;
>>>>>>>>           }
>>>>>>>>            pte =3D pte_modify(old_pte, vma->vm_page_prot);
>>>>>>>> @@ -5528,15 +5528,14 @@ static vm_fault_t do_numa_page(struct vm=
_fault *vmf)
>>>>>>>>                   vmf->pte =3D pte_offset_map_lock(vma->vm_mm, v=
mf->pmd,
>>>>>>>>                                                  vmf->address, &=
vmf->ptl);
>>>>>>>>                   if (unlikely(!vmf->pte))
>>>>>>>> -                       goto out;
>>>>>>>> +                       return 0;
>>>>>>>>                   if (unlikely(!pte_same(ptep_get(vmf->pte), vmf=
->orig_pte))) {
>>>>>>>>                           pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>>>> -                       goto out;
>>>>>>>> +                       return 0;
>>>>>>>>                   }
>>>>>>>>                   goto out_map;
>>>>>>>>           }
>>>>>>>>    -out:
>>>>>>>>           if (nid !=3D NUMA_NO_NODE)
>>>>>>>>                   task_numa_fault(last_cpupid, nid, nr_pages, fl=
ags);
>>>>>>>>           return 0;
>>>>
>>>> Maybe drop this part too,
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 410ba50ca746..07343c1469e0 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -5523,6 +5523,7 @@ static vm_fault_t do_numa_page(struct vm_fault=
 *vmf)
>>>>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>>>                 nid =3D target_nid;
>>>>                 flags |=3D TNF_MIGRATED;
>>>> +               goto out;
>>>>         } else {
>>>>                 flags |=3D TNF_MIGRATE_FAIL;
>>>>                 vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pm=
d,
>>>> @@ -5533,12 +5534,8 @@ static vm_fault_t do_numa_page(struct vm_faul=
t *vmf)
>>>>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>                         return 0;
>>>>                 }
>>>> -               goto out_map;
>>>>         }
>>>>
>>>> -       if (nid !=3D NUMA_NO_NODE)
>>>> -               task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>>> -       return 0;
>>>>  out_map:
>>>>         /*
>>>>          * Make it present again, depending on how arch implements
>>>
>>> IMHO, migration success is normal path, while migration failure is er=
ror
>>> processing path.  If so, it's better to use "goto" for error processi=
ng
>>> instead of normal path.
>>>
>>>> @@ -5551,6 +5548,7 @@ static vm_fault_t do_numa_page(struct vm_fault=
 *vmf)
>>>>                 numa_rebuild_single_mapping(vmf, vma, vmf->address,
>>>>                 vmf->pte,
>>>>                                             writable);
>>>>         pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>> +out:
>>>>         if (nid !=3D NUMA_NO_NODE)
>>>>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>>>         return 0;
>>>>
>>>>
>>
>> How about calling task_numa_fault and return in the migration successf=
ul path?
>> (target_nid cannot be NUMA_NO_NODE, so if is not needed)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 3441f60d54ef..abdb73a68b80 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5526,7 +5526,8 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>>         if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>>                 nid =3D target_nid;
>>                 flags |=3D TNF_MIGRATED;
>> -               goto out;
>> +               task_numa_fault(last_cpupid, nid, nr_pages, flags);
>> +               return 0;
>>         } else {
>>                 flags |=3D TNF_MIGRATE_FAIL;
>>                 vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,=

>> @@ -5550,7 +5551,6 @@ static vm_fault_t do_numa_page(struct vm_fault *=
vmf)
>>                 numa_rebuild_single_mapping(vmf, vma, vmf->address, vm=
f->pte,
>>                                             writable);
>>         pte_unmap_unlock(vmf->pte, vmf->ptl);
>> -out:
>>         if (nid !=3D NUMA_NO_NODE)
>>                 task_numa_fault(last_cpupid, nid, nr_pages, flags);
>>         return 0;
>>
>
> This looks better for me, or change it further.

Thanks. Will put a fixup below.

>
>        if (migrate_misplaced_folio(folio, vma, target_nid))
>                goto out_map_pt;
>
>        nid =3D target_nid;
>        flags |=3D TNF_MIGRATED;
>        task_numa_fault(last_cpupid, nid, nr_pages, flags);
>
>        return 0;
>
> out_map_pt:
>        flags |=3D TNF_MIGRATE_FAIL;
>        vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>        ...
>

I will send a separate patch for this refactoring, since this patch
is meant for fixing commit b99a342d4f11 ("NUMA balancing: reduce TLB flus=
h via delaying mapping on hint page fault=E2=80=9D).


Hi Andrew,

Can you fold the fixup below to this patch? Thanks.


=46rom 645fa83b2eed14494755ed67e5c52a55656287ac Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 8 Aug 2024 22:06:41 -0400
Subject: [PATCH] fixup! fixup! mm/numa: no task_numa_fault() call if page=

 table is changed

Based on suggestion from Ying.

Link: https://lore.kernel.org/linux-mm/87cymizdvc.fsf@yhuang6-desk2.ccr.c=
orp.intel.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 5 +++--
 mm/memory.c      | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 4e4364a17e6d..0e79ccaaf5e4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1724,7 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		flags |=3D TNF_MIGRATED;
 		nid =3D target_nid;
-		goto out;
+		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
+		return 0;
 	} else {
 		flags |=3D TNF_MIGRATE_FAIL;
 		vmf->ptl =3D pmd_lock(vma->vm_mm, vmf->pmd);
@@ -1743,7 +1744,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *v=
mf)
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
-out:
+
 	if (nid !=3D NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index d9b1dff9dc57..6c3aadf3e5ad 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5523,7 +5523,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
 	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
 		nid =3D target_nid;
 		flags |=3D TNF_MIGRATED;
-		goto out;
+		task_numa_fault(last_cpupid, nid, nr_pages, flags);
+		return 0;
 	} else {
 		flags |=3D TNF_MIGRATE_FAIL;
 		vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
@@ -5547,7 +5548,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf=
)
 		numa_rebuild_single_mapping(vmf, vma, vmf->address, vmf->pte,
 					    writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-out:
+
 	if (nid !=3D NUMA_NO_NODE)
 		task_numa_fault(last_cpupid, nid, nr_pages, flags);
 	return 0;
-- =

2.43.0




Best Regards,
Yan, Zi

--=_MailMate_A3CB2FC0-4201-4104-B932-27110C45565D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma2GWkPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKrsoP/j4BgZXpqJ+NDOaQPoGNJETi/87Bac1XTAeo
A0DhsevlhJql7TuX7nNmLoZmF8gpvWKLxpp08PJLfDuATol0thcjrvDC0cg2eJ8m
S6SKGFxmjBiwNDpHNSlK5do3VXlSaCSqj1RQLvnyg+umXwFRqybyr3fhepxOayFK
DcvQ8kMz4vbrwLMFxJvNLNzTC3tG+x/3kbh8qC3zWzN44rfjpn6MffJlv01jDP+D
h3W8kpc4BTUs+FmgBHj9E3X1Az/Q2GatC5yWbvZEIGUM7KKxAfZoKo+7hXZn1sPp
FkXZUVvCfL2PQ+Lc0SQKwnSz9J20UiLRoYO/REiIyhGzZnmtLiuiBhDAf6u6kVwU
TZSG/fmgiIZToyjB+nkoucu6E86BHSCXQb7uI7VQ5e/xT9w3YQhOrbJfsx3qouBs
zFacOvNfDEDDjSs9YA3feACD0JCXTh0hijioLVHlkFZlI2TzUMNIMX38+JKnPEjS
QMIKFb5Gz1cvZWXqCfWbR+C/Y+2hjNjIsDCDuvuUDeCDXsf/J4RTdL8fV/FpJnhR
h5pr3GxNj/pGGzkJmc1A/fowN3nALvpJxFsPTwKnxeh+nlf5XnnIIrbJeCkdoffz
DeEKJLGAV/44Ilhw5Sg11Dt2QqVUl60RgIET8PYXMCm7BzlyAr83YFGCQpYMEBpm
a2Rew4Mm
=YdDV
-----END PGP SIGNATURE-----

--=_MailMate_A3CB2FC0-4201-4104-B932-27110C45565D_=--

