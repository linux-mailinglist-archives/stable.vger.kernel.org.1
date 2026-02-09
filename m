Return-Path: <stable+bounces-214872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEAeEEE9iWmu4wQAu9opvQ
	(envelope-from <stable+bounces-214872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 02:49:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3124C10AEB3
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 02:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B56BB30097F6
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 01:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A48626ED3A;
	Mon,  9 Feb 2026 01:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="L51enPCW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F542A80
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 01:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770601788; cv=fail; b=Gzlormj8c5qrXnYbp1oFaRU08UctQ3bYAt3vj7slL9ub+kjEQseZ/ew0ZJXNjSDeeymYUVwsSAmzta319Rj/nV2cCZF2JXF2FNVldPXIRdeo9neMMQR1zFPpAqJFMA1r8Dk96asParIYA6xMYJOAIrPvGy+13Ow05sZyzLu7V4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770601788; c=relaxed/simple;
	bh=xrzF6cA0UrjsC6ZC7MKILB/a0u/gRJg8koaGpslFc28=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=olvjJiCwWeouJQcIeHernUJtdT8vQ441ztsIfu6HiE8tbLQVHNYLvqLg8J0OD47c+kEbX35ug0jgUQRScCN4FS+DGT9iyWqY5iAiYfRXf+ptHDBhq5KVqzuvcdouu0o9UQe7okgRUd4AYdXIhpJSKGze5ZTMnyV0wyr8mK9k6XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=L51enPCW; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6191Qqwk2756475;
	Mon, 9 Feb 2026 01:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=RFg22jhIP9ehQNiJfKaUN96pRpnTfdLq8VPybK4hPcU=; b=
	L51enPCWUUO9P1rWa2o5ygjP/64fy2nUJPT0yE9HzCzyxNBIhkneVbBMzQibzP17
	5rIGl20I6CJjL6ITknqFnuE9Kx2jKEFSfpC5jGoTNLkJP5UgIudNbFLNvze2qomi
	2jRU9m6UCxVvgr27PhnKC6RD+TEJhEIL/YDdYd5iy/b2Wjaic5JtYw6q7Jz/eirH
	UrdydukJHvgIeOOGUFo4hQvYvy0PZmYOulqHDElB/W849eoDfQF95sdMntrQ23P7
	19vbHLi7TTaIDsXaIheVqpBP3JgW9+GBa6DyMnBj3jPQKuuG/ppmEl3Iul28TeR6
	SzwNQMcDQBfqclCpyzBqww==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012069.outbound.protection.outlook.com [52.101.48.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4c5tkwhedn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Feb 2026 01:49:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tc3eNuPh3lIvdC9voGWWMy1YmzHBUdDysTrbQogXEwMYGJNe3uG8eBW6CsMve9/x0PYHbuVLtpB7HB/NYtaJB6wIr92tZ4/vSzmGjHr3ObPWvy/JuzSIDuNlk0e35YBe8zapYUA8jto2wkpNpOAi7eJnLdTvlwy9uGeS1FPoiiTK240NNOjFanxZycOApmxw1p33vgcEWPc0kJKmdB98w73bV8Suc3denaoAFUdAkLGR1NJcY4kVCsx+A3MR3mZQpVjW8I+Q8rELbcbA91EAWWdRCjoaTuuONHh9vQaVwbXFpwjl8HhUD92cW6mEZL/HNyElIpXw/93a35wOsu4TnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFg22jhIP9ehQNiJfKaUN96pRpnTfdLq8VPybK4hPcU=;
 b=EOrhAc5oy/4FkJ2OjN66ba6XwWMLKO1VJithak2iMkuyK8JPuwLVO6t5zPMEEQMAh5SIxMiEQ9Jb6pL2qvGEYR7AWXufx4WMMGNBp40cgEA6od4CZ7cTtoDI56vk2rqaFKGhl+mrLihXSKEyOPvBRcvCh0p/h8/3TEE7DOdlRSZGFfqi8y9r+PiWoY77Fzt5w7BDt7jzxa8qJ7wYGvaKyor95eB5zCxGZxisECw2aFwVnMmuWun0BhdU+dmOgKCmxo5u3jJMmQqKdB4i7QvwDlS2sYsK0EuvED+Fwft32+af9NQ9nDNCgBc5xLMVoO1jF2aiD/9OmL0N4Pb1BzJKfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7736.namprd11.prod.outlook.com (2603:10b6:8:f1::17) by
 SA1PR11MB5778.namprd11.prod.outlook.com (2603:10b6:806:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Mon, 9 Feb
 2026 01:49:40 +0000
Received: from DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68]) by DS0PR11MB7736.namprd11.prod.outlook.com
 ([fe80::f7c7:f271:a7b:7a68%4]) with mapi id 15.20.9587.016; Mon, 9 Feb 2026
 01:49:40 +0000
Message-ID: <55cfd4dc-3545-4824-845f-13c1c0bc3518@windriver.com>
Date: Mon, 9 Feb 2026 09:48:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "net: enetc: fix the deadlock of enetc_mdio_lock" has been
 added to the 6.1-stable tree
To: sashal@kernel.org
Cc: stable@vger.kernel.org
References: <20251025224340.3962503-1-sashal@kernel.org>
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
In-Reply-To: <20251025224340.3962503-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0249.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::7) To DS0PR11MB7736.namprd11.prod.outlook.com
 (2603:10b6:8:f1::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7736:EE_|SA1PR11MB5778:EE_
X-MS-Office365-Filtering-Correlation-Id: ea61cf3b-948a-46f9-e878-08de677d7ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmV4QzNGWnBFOGY2a2h6RDB0Z1V1eW81OU1QQkMvSUQxT2NyOTgzbFpmZCsz?=
 =?utf-8?B?TVZoREwwK2NyQmxJOTZXWDI4WXF3Z2hKei9XS1NkY3o1MDI2em5vR3RHSmlH?=
 =?utf-8?B?dmdJZ1duWmVHRVZYbU1YYlhGZVVFTlBmaUZuODBBRGhTY3FBVWJHTENwR0Nm?=
 =?utf-8?B?UmZmajBaMkFwMjZ0RkprRkloUzRIR0pyMkYxVGZwNXdDLytrT2d3bUEwTmZq?=
 =?utf-8?B?S0xhY0hEWnlMUFdnOERhZjVoaDRXank0VUV4NE0xQlJuWmtDcWlVUDBGaDVU?=
 =?utf-8?B?SERqb0ZjNGVRa0J2eGRwZE9lQkUwbS9zUXNWbm5pWGI5WVU1OHBVQ3BiQ0xh?=
 =?utf-8?B?aTY4SlRZcmNqSm1kL2dCZGtoelFTaWswaFpPMW9JVUhHY2Z3M3RBVVdla0Fo?=
 =?utf-8?B?NGtnM3MwVzM4d0hmQ0U3L0NoTkQySWVhZUhDTC9PZkYxTHFzbW5iSWNhQUtp?=
 =?utf-8?B?dDEvVndRZEVUbFB5ZFRUT01YRVVTZkJ4OEdJbkZZOUNsQlFlb0RHZkNiZE95?=
 =?utf-8?B?V3RVaTdIbU10OU1maVZqN2xzVzJmeXlERWFtNkdwRE1hMzAySEZ1ZU1scnll?=
 =?utf-8?B?blhkbkhGSlNqQkVPcDN3TnRMY3FmYnlQc3lVdHNUdlo5cFdYZndKVXJXWHhK?=
 =?utf-8?B?M09Ob254UzRIQk1FTE81ZFRrdnM1bnBBYjVJbkJPeHgwWkpaUmkyOHR6YUpM?=
 =?utf-8?B?VzJiWVJnQmkrTUhwcmVuTFZmZ3FaQVFUSXFtaG5jdVdYTW9JSWVXK2JQZkR5?=
 =?utf-8?B?ZW02YWkvb0xCZ2o0Z0JrQ2pwYkJOVlpVOUZWUFhhS21EdVpiMDE2dVZnQnpu?=
 =?utf-8?B?b21lUTNqajBlZW8rZmNTa2NPSGlWM0hNVVNXeTUzTGE2eFFVazg4eHFTMnlG?=
 =?utf-8?B?NnJid3oveHlMcU94MnYrQm0xSVc3TFJ6MzE5UWZWQ1BLWWdOVmM1TWpRYU95?=
 =?utf-8?B?V1ZYZ251bVRuWEQxTGdXZEtmOGhIVk9CN05UczNjZmF0aXRneVhtWXhjZUVH?=
 =?utf-8?B?U1FHNjJObzNlT1RaSGpuWXdReHgyMXpZWTFLd0twd08xSUs4UE9Rb0x5Z21B?=
 =?utf-8?B?akNuV3NSQnBuZkdqT2lOMGlKK0h1cUNnVUI5c2ZlTStSa3VUT1YyRWcrYXZ6?=
 =?utf-8?B?djRUL0JaRzJvOUdGcFVUYXF0d216czBzQWtVKzJXM2FXb1NhV2RxOGdyQlQy?=
 =?utf-8?B?Y3hlOXJaZVpodVl1YjlOK2xJd3Y2UlUwdkJZbUt0dkR1cE41dE9xeHpPdUdZ?=
 =?utf-8?B?cWFlU1FjbXE0dFlmY1hwbmtIYUsyb3pFVVg2S3lSc2tVL2FEVVNnWUcyYlZs?=
 =?utf-8?B?YTBoQ25rUERDWXFZNE9lRmZlQ0FmamNPTmlBdGNLbUZLZGt5VTJodmNaSnNM?=
 =?utf-8?B?YTROMERGd3BBejZvV1E1QlJXcGZTZXNzN2w0Tjh2YTZlS2RJR2hHWGY1TXM1?=
 =?utf-8?B?M3hUKzArMTZVWHBvYTVadHQwQTMwZ2t0cE5VQXdQNG92N3NXVGhJZHBpazNz?=
 =?utf-8?B?ODZISzRzTmFpdkZpemcvTndSVTE2cnRKSUU2akNUS1NYVm4zOXd4Tm5wUS9n?=
 =?utf-8?B?VFpiZDYrZXNadXpjeTQ4WHhsQ05oQnBzM0FYQVEyZ2pyTk13UG1KblQzTmls?=
 =?utf-8?B?UEVSbGova05QMmxSUFp1L2Ivd2xoUkZpMldqYktYZ1JWeEZoTENlVzVuVWhD?=
 =?utf-8?B?Kzhqcklld3ltNTFXQThlNi83Mmg4MVlCT2dMV1pYVFhibGFiSnJYRFJuR2ty?=
 =?utf-8?B?YTNSeWI2N2FYV1pVb0VmRHJyWTdYR0xTaGFBcFIramNzdXRqSlFpK0t6TEU2?=
 =?utf-8?B?aXFpak52TmR6UWtFeUY0TmdrWnVmdEhvMU1hcVlEU3JIdnB5ZGh6bm4wcHZt?=
 =?utf-8?B?eHcyWlQ2aG9kMUNMaDlVZlpFbWRIYzNZbnNqdlArRldNM09TWTB6WEpac0hX?=
 =?utf-8?B?Qm1pZFJCZ3d4bG00N2xDazVqQit6RW9QcUlWLzlWTVhXRGFPbHkyU3ZzWnhC?=
 =?utf-8?B?WFE5NUswSnRqaC8yTEgvMWlwUnp0UWdtcHhZYUxzdWEwQUozYWw3ZEc4NVh1?=
 =?utf-8?Q?K1/0DE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFJIdldKcGhoeTJxZnp1dWsvZ2grUHdlTVlOTkVKRm5NSlJRVlVvRExJbnFr?=
 =?utf-8?B?YVEwaThvbVlqL05VcXdVWGlsd0NnYlFnMHFMRzQ3VkFmMGZGWHY1cXR4bU92?=
 =?utf-8?B?b21aeXN5cStqVFpWb2xsUkFudFRDckVMNVcrK1ptRnRyOW1YQ2tnemJTK2VF?=
 =?utf-8?B?bFNZUHVPekllVHBPaTk3ODhYeWd4bjh2S2RNMHpseVlaQUJCMlVVck9yUGdW?=
 =?utf-8?B?YmxlNDlVa3FQY1Q5RnIrL09TZnluRFdZMEYwVFFmR2JXc2JlUk9OQ1U0aURk?=
 =?utf-8?B?dEV4L3JUaDdOWkc5S1lkSVNteGd3OFJ5eTd4NlloWGxSbi8vRkdEV0JkOEpP?=
 =?utf-8?B?cWRmeU1YTCtFQ2h6NWt1NHVpeWxtSjF0TExiSjU0SGlmbmxBTnRhSWxMdzVm?=
 =?utf-8?B?ajY5VkNFcmZlaEpubjFQMGZmSnFLRVB3Znd4dWd1NDcrV3YxM2pSRWRtYk1Z?=
 =?utf-8?B?L2R4eisrWXlEeXlheXJWbkovWFFjM3RicVBWZDBPZk9xRUFtUHJ1dDlaZ2VJ?=
 =?utf-8?B?MmpreWZNTkhiSUdsb1g2T2YwM2FjYWxseUpZMVI1Y2xzWUxPeGJJSDFSMnRJ?=
 =?utf-8?B?MnJjYUNyTTU2ODRxUDIzRGlwV3BMZWtIcHJUNkprdHBWSFFUS29URzVhTUFN?=
 =?utf-8?B?UUhYYXFrUm40TTJCdDdHL0d4bHNLZnNjcnR0TEVacnlQZllHa1NUZTR3bEtr?=
 =?utf-8?B?NzhwRElSclhEcXVyaUUrdjNwRDdVRGpMc2tlMFkyeTcxZGt5cDlGVTR5VDFU?=
 =?utf-8?B?L3hhUlB2OGhueVBZRWJjWjdWTGkvTG9zSkxxT1paVHNoVjFMOGNVaVhQTzhq?=
 =?utf-8?B?b2dhbEhZRnYxZHR5TzB2OUsrRFhtL242NXRIN3AvOEdRekRMZW4ra1dQN3M5?=
 =?utf-8?B?aFpnaGJ2VW5JaXZGTkhWYVA5TXlDUlpNMHBRSFZnWVIrSExJNmtOWjBpKzZ5?=
 =?utf-8?B?UzA0U05NYXZDMWxFNm9LSXd4dE5mVFJOdFh2VVRnczRIQjNpRDQzMTZkcHBx?=
 =?utf-8?B?QnA0VVZ3OU1mVnMyeFFmNmg1NmFNeFQ4aVFCZW1HL2FFTkZGN21ZUHpTODcy?=
 =?utf-8?B?WlRTUWh0dUowaTdvdS8zbmtBOHVLTTh1ZDhhTkpPQVJKUGJpMGtFNHJuL1Zt?=
 =?utf-8?B?L1p3SjNoVWRteU1GbE9zQ1JWcjVXY2tHQjdwaW9FcERYSEFEdTJXa0dTSjBO?=
 =?utf-8?B?QjdtVGNyNkJDYzF0d29oSzU0QytTR1lBcG41Qm5MQSs0MW96YkVMTldQd1k2?=
 =?utf-8?B?VEZFZU51MDlDRmpBRUlNdTNZdEJwcWRocms5cmk2YjZqdmUwN2EyLy8xZ1gv?=
 =?utf-8?B?bGhWeE9hMyt1TENncEpxRy9XUE9CMHFwcFBiWDNWbnNSSmhpeXN0NXRreUx2?=
 =?utf-8?B?UDZQRGhuSHlQb2o4M0NtbDBYZmVoaFR6NDRVM2kyRDAzQTFYQklJaXR3Um9U?=
 =?utf-8?B?SW9XREsvZHpTVEVEb1phSXM3ZjhMKzM2aS9kTXZ2eS80bzdxa29TSkxFVGdG?=
 =?utf-8?B?QXQvcHZQZUNEM0w4SVFNaVFRU2VNRGxtU1RCVHF6YmQ0cXdOOE5paDhMTjBr?=
 =?utf-8?B?MVJDWkhYVlYrSUtvUVpoK1Mrb284RDVKbXRaZWZRc1k2ay91TzlKZUZyMm8x?=
 =?utf-8?B?OWFubTh5M3BtSFh1UlErU0EzWm5RNk83ZE8zWHkxUmFaKzlpWE5KUXJ5R2Vt?=
 =?utf-8?B?Z0tTemRwTmttbTA2WXFWSktMUlBSZUt1Mk1ndGZOZFRoZTZUSjlmVXQvbk9G?=
 =?utf-8?B?WTlwakJVbVpHV0lDd2xyTUkxdFRhZUdsSWMrbFJ2cDJ2OUdxLzMrbkM2N1hG?=
 =?utf-8?B?V05idnovU1VVS3B3Zk9JRXhrQjlmM2RzSDBSNnJvMXhyU1lkZGpKS1pPRElj?=
 =?utf-8?B?M1BmUDhxb1k0STN1Q2k3ZWc0MXhWTCs2cXVYVGlKM2VXTFVKZmZwUDZsZCsr?=
 =?utf-8?B?dnc2Tjh6QUNxQ3Bva01CVkFZVVM5ODcyTnJya0tRcmxFd2lZMVczVTdHYkRh?=
 =?utf-8?B?ZE1lMG8zVlloZTBMRnBUanFzblMyZHdyWFgzOEk0cVMwVFQ4VFBjOHU2NWtK?=
 =?utf-8?B?aTVVRXg1NWRscTRqNHdTMUFTeVR6K2VReXVvZ2RJY0JHclJsbXVRUjhqOW9a?=
 =?utf-8?B?dWx2NE82NHg5aXVnaTI4dzVoWWN5Zk1ZUGdxL2FCWFdLSU0zVGV6VUpJeSty?=
 =?utf-8?B?TmwxemQxRG9FNjhKdVZjM3UyRG5zelh0cndNNjdJaWszYzQ0OWtFSmZiR3Zh?=
 =?utf-8?B?Yys3WUU1ZXZaeUdoUDVNb243WmlQQzIxV2t5Wk5iSkxOdGRvZXo5V2kzZkxG?=
 =?utf-8?B?eTQvTjRuRzN1cUQ5cHZzQUNHSDZCSm50T1d3eitlUzBNTCtVQStjMzRRNDNs?=
 =?utf-8?Q?UwmakJFTJYHK70/8=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea61cf3b-948a-46f9-e878-08de677d7ce0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:49:39.9453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hotp8u9oBR1bQKig5nDB+s1/99JEZQfQtyCsaTDtvXIHmpRv8He06y1oJB29dTozpCYYOcDLii6aZPmfmpQHaDiO9hGxvyK8HNqP2rvIP4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5778
X-Authority-Analysis: v=2.4 cv=bvBBxUai c=1 sm=1 tr=0 ts=69893d37 cx=c_pps
 a=fm8IUWXzr0h7QqFIpCBYEQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=GoezNifpR33j21mC:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=bC-a23v3AAAA:8 a=t7CeM3EgAAAA:8 a=8AirrxEcAAAA:8
 a=zdxVlP9R5F_1BNKJVlMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: GVT4bcyR3m4EBDItpTv3jzBzDI5tRh5w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDAxNCBTYWx0ZWRfX6NmZL4Go6CSr
 +k0+cukmmvgiq2f6ITPjy/gHghvJwNhMQ73rHqJw3ZiTLl/KbX2htohzvbW0RY3PONtSIyiXW8r
 k2CZ+4zrIkcVdi31NG+1BfNbP9mhBD4n5guf5H3/+REtSaRTABAhvQucMcZl9ovwg0JlESzPne/
 kx+olU9Ru23Bq06za8PooB/z8SKuCbMrtFlfNF63wWzm5ax/4RH9Dc/FTk7K7co9bM5E3X5AM5r
 et/jvN90Sx1l/Gz5ibA4x1FzcCOT9Uo0u7mLLb6iXRVvNBKazDBIdmSENF9FZVPTao/14VvTD1T
 s2CGL/WmKJXPdnC6kNZjH5zadwArnYmrJtDqAjx87ui+t60NJrjEfbIGDlzJi0ozSiyalE66B9C
 y4ZHfXuqdELlL2nqZtxXEp0F+oSwB18tyPJxDnPekIR/FysOYj/rQY3TiQufwD/BDuOotY4IoiU
 1F5hoCbfPugZnI7VUQQ==
X-Proofpoint-ORIG-GUID: GVT4bcyR3m4EBDItpTv3jzBzDI5tRh5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-08_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602090014
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214872-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:email,windriver.com:dkim,windriver.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianpeng.chang.cn@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3124C10AEB3
X-Rspamd-Action: no action

Hi Sasha,

3 months have passed and the patch hasn't appeared in linux-6.1.y, 
though I see it has been merged into 6.12.y, 6.17.y, and 6.18.y.

The patch is also no longer in the stable-queue/queue-6.1 directory. 
Could you clarify if there was an issue preventing it from being merged 
into 6.1.y?

Thanks,
Jianpeng

在 2025/10/26 上午6:43, Sasha Levin 写道:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> This is a note to let you know that I've just added the patch titled
> 
>      net: enetc: fix the deadlock of enetc_mdio_lock
> 
> to the 6.1-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       net-enetc-fix-the-deadlock-of-enetc_mdio_lock.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 18c00ec29df3d353de5407578e2bfe84f63c76dc
> Author: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
> Date:   Wed Oct 15 10:14:27 2025 +0800
> 
>      net: enetc: fix the deadlock of enetc_mdio_lock
> 
>      [ Upstream commit 50bd33f6b3922a6b760aa30d409cae891cec8fb5 ]
> 
>      After applying the workaround for err050089, the LS1028A platform
>      experiences RCU stalls on RT kernel. This issue is caused by the
>      recursive acquisition of the read lock enetc_mdio_lock. Here list some
>      of the call stacks identified under the enetc_poll path that may lead to
>      a deadlock:
> 
>      enetc_poll
>        -> enetc_lock_mdio
>        -> enetc_clean_rx_ring OR napi_complete_done
>           -> napi_gro_receive
>              -> enetc_start_xmit
>                 -> enetc_lock_mdio
>                 -> enetc_map_tx_buffs
>                 -> enetc_unlock_mdio
>        -> enetc_unlock_mdio
> 
>      After enetc_poll acquires the read lock, a higher-priority writer attempts
>      to acquire the lock, causing preemption. The writer detects that a
>      read lock is already held and is scheduled out. However, readers under
>      enetc_poll cannot acquire the read lock again because a writer is already
>      waiting, leading to a thread hang.
> 
>      Currently, the deadlock is avoided by adjusting enetc_lock_mdio to prevent
>      recursive lock acquisition.
> 
>      Fixes: 6d36ecdbc441 ("net: enetc: take the MDIO lock only once per NAPI poll cycle")
>      Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
>      Acked-by: Wei Fang <wei.fang@nxp.com>
>      Link: https://patch.msgid.link/20251015021427.180757-1-jianpeng.chang.cn@windriver.com
>      Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 44ae1d2c34fd6..ed1db7f056e66 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1225,6 +1225,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
>          /* next descriptor to process */
>          i = rx_ring->next_to_clean;
> 
> +       enetc_lock_mdio();
> +
>          while (likely(rx_frm_cnt < work_limit)) {
>                  union enetc_rx_bd *rxbd;
>                  struct sk_buff *skb;
> @@ -1260,7 +1262,9 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
>                  rx_byte_cnt += skb->len + ETH_HLEN;
>                  rx_frm_cnt++;
> 
> +               enetc_unlock_mdio();
>                  napi_gro_receive(napi, skb);
> +               enetc_lock_mdio();
>          }
> 
>          rx_ring->next_to_clean = i;
> @@ -1268,6 +1272,8 @@ static int enetc_clean_rx_ring(struct enetc_bdr *rx_ring,
>          rx_ring->stats.packets += rx_frm_cnt;
>          rx_ring->stats.bytes += rx_byte_cnt;
> 
> +       enetc_unlock_mdio();
> +
>          return rx_frm_cnt;
>   }
> 
> @@ -1572,6 +1578,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>          /* next descriptor to process */
>          i = rx_ring->next_to_clean;
> 
> +       enetc_lock_mdio();
> +
>          while (likely(rx_frm_cnt < work_limit)) {
>                  union enetc_rx_bd *rxbd, *orig_rxbd;
>                  int orig_i, orig_cleaned_cnt;
> @@ -1631,7 +1639,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>                          if (unlikely(!skb))
>                                  goto out;
> 
> +                       enetc_unlock_mdio();
>                          napi_gro_receive(napi, skb);
> +                       enetc_lock_mdio();
>                          break;
>                  case XDP_TX:
>                          tx_ring = priv->xdp_tx_ring[rx_ring->index];
> @@ -1660,7 +1670,9 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>                          }
>                          break;
>                  case XDP_REDIRECT:
> +                       enetc_unlock_mdio();
>                          err = xdp_do_redirect(rx_ring->ndev, &xdp_buff, prog);
> +                       enetc_lock_mdio();
>                          if (unlikely(err)) {
>                                  enetc_xdp_drop(rx_ring, orig_i, i);
>                                  rx_ring->stats.xdp_redirect_failures++;
> @@ -1680,8 +1692,11 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>          rx_ring->stats.packets += rx_frm_cnt;
>          rx_ring->stats.bytes += rx_byte_cnt;
> 
> -       if (xdp_redirect_frm_cnt)
> +       if (xdp_redirect_frm_cnt) {
> +               enetc_unlock_mdio();
>                  xdp_do_flush();
> +               enetc_lock_mdio();
> +       }
> 
>          if (xdp_tx_frm_cnt)
>                  enetc_update_tx_ring_tail(tx_ring);
> @@ -1690,6 +1705,8 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
>                  enetc_refill_rx_ring(rx_ring, enetc_bd_unused(rx_ring) -
>                                       rx_ring->xdp.xdp_tx_in_flight);
> 
> +       enetc_unlock_mdio();
> +
>          return rx_frm_cnt;
>   }
> 
> @@ -1708,6 +1725,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
>          for (i = 0; i < v->count_tx_rings; i++)
>                  if (!enetc_clean_tx_ring(&v->tx_ring[i], budget))
>                          complete = false;
> +       enetc_unlock_mdio();
> 
>          prog = rx_ring->xdp.prog;
>          if (prog)
> @@ -1719,10 +1737,8 @@ static int enetc_poll(struct napi_struct *napi, int budget)
>          if (work_done)
>                  v->rx_napi_work = true;
> 
> -       if (!complete) {
> -               enetc_unlock_mdio();
> +       if (!complete)
>                  return budget;
> -       }
> 
>          napi_complete_done(napi, work_done);
> 
> @@ -1731,6 +1747,7 @@ static int enetc_poll(struct napi_struct *napi, int budget)
> 
>          v->rx_napi_work = false;
> 
> +       enetc_lock_mdio();
>          /* enable interrupts */
>          enetc_wr_reg_hot(v->rbier, ENETC_RBIER_RXTIE);
> 


