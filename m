Return-Path: <stable+bounces-132649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F55A888EB
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 18:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C83B1899D07
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462BF27B4E9;
	Mon, 14 Apr 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uANEefC5"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322EE2749C0;
	Mon, 14 Apr 2025 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649443; cv=fail; b=ezjbMq0awrpfw/I4Ps76tabl65ibuj1yUubq3FWLVkCrwgZ6PgQhOtSPNS1REzpmmOlINq7Qg2gd8rh0ZEraiuxgBNMjgjyRLZ4Mwmasyb9WUqH03LVP5vc8hIIgBq2uMqVdDskedS00bwD7GIsWqc7LhwwegKlCcHDZkDI1Dk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649443; c=relaxed/simple;
	bh=jfRHpUm2Zd0L52w3k/QSMIGin9dVrAuFeOoLSjYUFRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=deQXQfZIX9pH7CNe9QTprWfsGs9WWrWu9tfHbhK/dVgoRVdCHxDHZ6vK2ITIzjoELfg59+X8zhpys8zle8xJZkJ+6hOmc3Hk4h9cemteqsBDhP51YyEfrhwGcQkcaWW+s80oOlVfRNXJS0vp20E7UOoxfC+P36QcoL3I9m0jNhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uANEefC5; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gX0eRXalpEx3curk1ApKx3RGrJhRuztLI+dDU8gB/DymxM/spFG+NjSAPmrPJDo0Qy9M7KFyUaZZtuoCcon2l97TZLpwlnF46KZTaWZpUhgluvJRQ/oStrGUYIRtOUJEQeBRpiPJ03NtH2zN4sIBk0Ki5zIgwrQnKlGY5LJwq/AjojCOhUmpBE4TQZqsc/Fr8vQs1z+bgQ1girg/cK3f1hJQ+CpfBNJ5RprPablPjsMMM5yTlrgSdSaQj9dmFyXhM7so7bvtLMJ7OgHZXJSIM6VtQoK9KfveHZL1GlrF15J3zgfleKPksfFIi3INLpTdNShKR/1xx/orPmZXbwzjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyairMpFevCy/DGCGzaPQKzQ0aBS6Qiv68hovwOWb4M=;
 b=rirAh6pxhlKXkllrC0/Av+fJlgpcuc5jyTmcozlv2oCMtlBlxP68IQF+Pp9ATEHFd5r5pZ3DPwqetWOSlxeppftxslFtwsVv0uIrktQPTYqEY55f6lINiaaeRpTY7U9GJzE8qOur+3O4ovdoVyr+smF0P9/1/gSp4Az8tdFQ8eF8fpomDdMV3SPAr2/TxHGEtgjZvGuh4m9CKaTnEITKigTL/iwUHJo7O1wSAse/UbAb8E+uqffoyn6pWJOO0fJ3yiGqHzwUd3R7/cX845y1TDjSfdyvbt9jn/H0kxssP82HNY5uSUx0iU+WgwHMz9QNu2sLGcWNDbOTPSKIPs2uKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyairMpFevCy/DGCGzaPQKzQ0aBS6Qiv68hovwOWb4M=;
 b=uANEefC5FqLQTYoY8Jx1rF3qa6r2S34l2wGDlVVY7eA9yFZJY6G6kmMvIYtY39s+4XukUfBlD5QSYl2xnRkfSGOf0W+jIje95ca7Ezd7y/o1Mf3LgHmatJTpmIAuR9rpMaTP3K2u5q0iaQjZ5XBMBaAihgzcFhXVZMA3EFKIB2Xl42aF5I1gznbTvWlQwTOU6c2biKcra96fnmWtlX2d6Ki6lDEhy7SR0vu/PVmsVQskWwp5vhzzSDtn+wApitPrWeG1TMCkeD6ne6LeJPEpXbbT7t+UKOLL4hwXwYUHWBhy0ysTgZ7oefuT1RoHoYGq8m0iEbzjVVpQngx1fps5Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 16:50:38 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 16:50:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gavin Guo <gavinguo@igalia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
 linmiaohe@huawei.com, hughd@google.com, revest@google.com,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH] mm/huge_memory: fix dereferencing invalid pmd migration
 entry
Date: Mon, 14 Apr 2025 12:50:35 -0400
X-Mailer: MailMate (2.0r6241)
Message-ID: <A049A15F-1287-4943-8EE4-833CEEC4F988@nvidia.com>
In-Reply-To: <20250414072737.1698513-1-gavinguo@igalia.com>
References: <20250414072737.1698513-1-gavinguo@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::10) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa7240b-bd3a-4dd6-663a-08dd7b747bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGdjaW5uNExOakVxMmkvT0t4NU92SW81ellGcER2TENZVjM0MWVYdHUxV2Y2?=
 =?utf-8?B?aFhRWldabW5tbyswZ1BjSktoMWY0UzZjb1E1R1JSZG8zSndUOWpJR2JQU3RR?=
 =?utf-8?B?dU8rNHZNTy9lZWVNY1U1dlZBdFR4TStCWmcyenZxY3ozZFFFTDZwaG9hZUoy?=
 =?utf-8?B?SndJckJRWWJUOVJKeC9hYnEvSXgvTUlUU1RUZmh0K2JVSTV5Mzl6RVgwTGdx?=
 =?utf-8?B?VTNBVEUzNjA3TWhCQXNZRXprM1JtSGJGSkUyQzEvVm1EaFAvWE13RFNlbVJR?=
 =?utf-8?B?WE9JMUZOYjR4bDl1SWRwbE1NY1dzMUFDZGdlTTVNNlY3c0h1Z3U0VlN3bnJa?=
 =?utf-8?B?c25xY1UrTHorS00yNEdXRFFWejVaUlY1Z0x1bVRRcUgzTTRxd2dCUXBwRzNH?=
 =?utf-8?B?Q0RTRFNWQXhreFVJTVg2WXJ6c0ZSRU5taDgwaE5CMkF2QkN5SFBaWjlnMWU2?=
 =?utf-8?B?UEhWYlZuTjdRMjhTUXVKNHJOaEdMdGhPRGN1SkZrRFdsSDRFMVZCOU80bFRL?=
 =?utf-8?B?UlcrQ2ZkbElUaFAzQjF6OVdBeEQ1YnZsRFdrTzRRN2xmT0Qrb2ZIQWZaNUJl?=
 =?utf-8?B?aDlPTHIwZlh2SFBFRlBiMk5DOFRvTDBHbHI3ZC9xWisxeWRNOWEydk9SMUo2?=
 =?utf-8?B?MHVRb0I2d0VGaHUvUmdxTnY2eHByNGRjUmVGYnBrdzg0SFp4N2EvbHN4UWRx?=
 =?utf-8?B?TDhsYnUzWDB6RU5XUXRxL09ZaTBtaGVNRVRsbS9KZVBla1lwdCtVSFkwOHNs?=
 =?utf-8?B?M1pqd3IvcHZFNDA1OXhUdm5wRy9rUVJmdTl0Q2wvLzJJMWY4bXE5NXRSSW91?=
 =?utf-8?B?aE5LMUdwcHZZQU1QRG5aVTIwNE15Sy9BNTk0ckU3dWF3YlllTWU3cVJ4ZmV5?=
 =?utf-8?B?SmRlbFN5bE9pSFhpRVBaMXdyajJIaGoyNFhTQmlzOHNCNDUydDd6SjdZeEto?=
 =?utf-8?B?WXpXcXhUbXQrRGJ4MWlxRHB3WkppVTdNVVZTOEluSG9LV2JVV3ZSYWZ1SzBo?=
 =?utf-8?B?Z29BOXVScVhVMU91VWZ5UkFveGpiby9rQ1pVT1pOeUFvZjBtUjU5SDFkNmF2?=
 =?utf-8?B?U0kwRG1sZnJKa1JHTnBHSDU5VUMvdjV1bEtiOTUrbVpxcW91K2NjeUdLcElM?=
 =?utf-8?B?YlhsUXlxbWIvVEk1RGt5R0FpS1UrbnhTR2R0ZVFCYUEvdlNzdHhHTk5xa1Rv?=
 =?utf-8?B?QmFCbnVHK2FqK1R1Q2ZUZDdhQ2JvdnhlUWkyekVUWG9YSjdzZHIyY0l0alow?=
 =?utf-8?B?ZHZTWDF6aWNHZDBqalRoODR2dDdaYkU2cFQ1VG5xNXhtU3d1RTJBdU02NmJ4?=
 =?utf-8?B?TDVRNlkwZ3dtOE9yZmFuSWpkYVBnQVh0NlRsd0pvYm9SVU45T2JvZFFJV09x?=
 =?utf-8?B?UnNDYmc2T1BlMi9XbGdlM1NrNFhVcEdKclpNeE9RaGRhaERaTlBZWFJGanFD?=
 =?utf-8?B?TXhrRU9lWmtmZ0hiUjl1QmlucE80cEdsbGNaWC8yMlBRb3czY2RZZlpQeUx5?=
 =?utf-8?B?OGZkL0JKNW4vSW00U0xKV1d4ZzcwUEtxODJDWHBTRXBEU3ZpQnIxY1RkY0U2?=
 =?utf-8?B?KzR3MXFKanZ0d291UU1uMHRZeEJuUWkya0NhNFFBbDU2ZG5CVzIrZ2JWUUlW?=
 =?utf-8?B?ekdXWlhoQk13Q0VDQjVIcklTQ25vOXB3aE9pUVVvbDExcjRFMWpNYVIrUnM5?=
 =?utf-8?B?bE5FdUVqMWowQkYrT0ovOVJtTllIOVYxcHByMDlWb0hsSkZOSGhDWDZaWUxX?=
 =?utf-8?B?UlNMVzVQMXRQU0FNZlEralEzSXEwMDM4YnpJQ3orZXBLSnk1amFreDEyRURR?=
 =?utf-8?B?cW84b05ZOEJwZWJCVU96WW5OaUUzSlZwY1BqVEhoMEY1K1VVSE9pVnNrZGJo?=
 =?utf-8?B?RUhkSTJVKzNIeXlpcklGeFNmVTh0Y3pZRDRYY045RFJ6T1B3VDZDRFZzSHRO?=
 =?utf-8?Q?o3tJJVL9XDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE5KdGpIMTdOVFVnbVZYVmh2d085QTgvbzRKYmxEVk5RZi9Yc1BCZzg5dTZM?=
 =?utf-8?B?RUtrMHdaWVVwYXg3aDdCYzJTR29hL0N3S1pVckVMaFZ4d1VOKzkzbVB5YUhr?=
 =?utf-8?B?NnlBcFlqb2RsVGxFbGJ2RDhHcEdFcGVHaDdSTkJFdmFFZUhEb1NQK2puZ1ZL?=
 =?utf-8?B?VEFqeWU0T2JOZGhTbEdxdUJxQW9LMElpS3lXQXhhSW9wNzErelZScCtjUFl6?=
 =?utf-8?B?WjdUclVJWDBKdGdYTGdRTXB1ZlFqdTdTV1hoVDZRd1pqSDFUdzJpdnIxRkE1?=
 =?utf-8?B?ampXU1BIVDdXR2dBenQ5TmJENU43L01NL1hvSTNpK0tTd1BBYjIycFQ1eEFk?=
 =?utf-8?B?Nm0yMXV5Qi85SHNsVXZVK3JwNEttcDNmK0hqVHBubUNTK2VDTWZhdFZEcHk5?=
 =?utf-8?B?YlFqeU9mSHNtOHZURTZ0dDBCOVhXYS9JakpKby9rM0tWSTg3MVhKVVJJTmxn?=
 =?utf-8?B?QVQ0TEVNUnRlVDV3NUczbmlXcmlDZnpzM0JES0dQeW11djEyUjNqNVkzaWtM?=
 =?utf-8?B?Tm5qeE82STdjMDRQU3hqUDJKRmk4Z0NJc1ZzMGVLbHBuY2IreWJvWlNMRmR4?=
 =?utf-8?B?MFBkMTJ2WG92eEczZkpwTUdIelUzVW9DUHMyY1hCOWRtakpIUkR1NzhjeFdm?=
 =?utf-8?B?bERncTk1dWNjOGRjbmY5UGRlamFtMXp2c01PbHdHWUNFSGU2V3JnOUJoRmxj?=
 =?utf-8?B?cmg2NlpCaVVKSEtQRVZzZGNTSlV0UWJTYzN5eDVUSFdOdlRYUTFIVkQ2eDlo?=
 =?utf-8?B?K2xrTXphenM0aUk0VGpnclpLb1lWelZNT0pQdS9nMlc5NlhVamFmTHlncm9F?=
 =?utf-8?B?ZCtlVWRzaG1MRnZhTHBsaDhoeGc5TWtDNm1tUmxnenJqZktlVjQ0NU4zSEkx?=
 =?utf-8?B?VU9FZXhOQjJORlJ6SkhYS2VZQUhnR08ydFJlaVQ1NTdlVUdTWHBXaHFicVo3?=
 =?utf-8?B?MUpVbE1LcE5YUnI4Z2thU3hJMmMyUjZCeHRzZWl4T0lHNllISUtoVzZoUU1T?=
 =?utf-8?B?T3JEL1lROUR2Y1VFRlhyalhpcm0ydXdBak9DQXhxa01BT04waVFmWFJMT1Zh?=
 =?utf-8?B?eW54aFVZME9TdUw3Yy9ZVEN6MjU4OXk4ZUlOK21NZnRQQVk5Nkx4MkNRNU5u?=
 =?utf-8?B?Y1NCSWx0ZWdKeTZ2U3ZYYXRTWVgyUWh0YWpzVFBYZUhRSVdpeGRmVmZhbnhI?=
 =?utf-8?B?WUxBekZ1elNRS282b0FSWnQ1eTJ3YTlkK1g1RTd0ZDFyT1FMcE5lT2lFZEYv?=
 =?utf-8?B?L3lNSHJqNlh2TE05cjYzTXdpbG1ydEFqM2g1bEp5RXpyazlOYXNMRnJzTHZB?=
 =?utf-8?B?L216aExPdFE4QWthNkRWbnVieERDdDdLMktCeWthVk1RWHFMVzFwUmJhTHZq?=
 =?utf-8?B?RkNxRkRJbmx6VmphdWliUzJYcWlxQWY4eGN4K3BrQnVGcTRCSmsvTUNMNFdT?=
 =?utf-8?B?S1VxSlFmZVVFUDZ1ajlvbmFPVEZJSFB2QkFYZng3UUx1NHphbXMzR200QVZh?=
 =?utf-8?B?cUk3ZElIR2VrM2J0VmNycktxek9uZjdCYjByOUt5U1o2RTdQOWpiVFplak1v?=
 =?utf-8?B?V3RTRXF5TnVJcERvektudFpPUnQzNmhxZTFvcEdDQU50ZDhudFFLcVN6bnZP?=
 =?utf-8?B?OEdvcTNPWUxXd3JhWnJQZGtSWFk0Nlo1U2Z5bU9RbGdvdkZreUdQY3JuN1pj?=
 =?utf-8?B?VzQzdWJZOHZodys3eUhFeTQ0TXJxTzdtYmcwaHlNRHBsdDFhMFhBMnJWOFM1?=
 =?utf-8?B?QkdJaWkvYnczUkM4d01ZVGhtQjNpYXUxd0htUFJPUTYxSWJDTnRMclhLRHZy?=
 =?utf-8?B?UFlWL3Jrb1VnT2phSjI1WWQvSHQxeDB1TVRZd1hCSTVsWExXemJNWXJYdkUw?=
 =?utf-8?B?MU5MYTJQUjdyMlVRQVJNdTB6VXlkL2QrSWd1aHlKd3RQdksvQ2VCeGg5MHJn?=
 =?utf-8?B?VTBMVVdzeFFsQnNkdFoxZHpVeGZDT1Zmb09XMTB5ZGgreXJsWHV3TUdUdGh2?=
 =?utf-8?B?WU54eFRzQ1JSZTZEV3EwM0NnNGViNmJMdVMxNFl3VnpYdlZBS3hxaXRnRWNW?=
 =?utf-8?B?eGc5UG91ZXVzZ2lRMU9sMUUvOW9ZeW1KRCtXOE5FaGJjMHRNbW9IclY3QTc3?=
 =?utf-8?Q?IPBgGzttJzxllFGtizPIy+bcU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa7240b-bd3a-4dd6-663a-08dd7b747bca
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 16:50:38.1177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8GvIH9KNMwZLum+MbpLHzy5JPYlUPAM7PVvCt6CVgYhY28fTkUNovAbwHxzgGpJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547

On 14 Apr 2025, at 3:27, Gavin Guo wrote:

> When migrating a THP, concurrent access to the PMD migration entry
> during a deferred split scan can lead to a page fault, as illustrated

It is an access violation, right? Because pmd_folio(*pmd_migration_entry)
does not return a folio address. Page fault made this sounded like not
a big issue.

> below. To prevent this page fault, it is necessary to check the PMD
> migration entry and return early. In this context, there is no need to
> use pmd_to_swp_entry and pfn_swap_entry_to_page to verify the equality
> of the target folio. Since the PMD migration entry is locked, it cannot
> be served as the target.

You mean split_huge_pmd_address() locks the PMD page table, so that
page migration cannot proceed, or the THP is locked by migration,
so that it cannot be split? The sentence is a little confusing to me.

>
> BUG: unable to handle page fault for address: ffffea60001db008
> CPU: 0 UID: 0 PID: 2199114 Comm: tee Not tainted 6.14.0+ #4 NONE
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> RIP: 0010:split_huge_pmd_locked+0x3b5/0x2b60
> Call Trace:
> <TASK>
> try_to_migrate_one+0x28c/0x3730
> rmap_walk_anon+0x4f6/0x770
> unmap_folio+0x196/0x1f0
> split_huge_page_to_list_to_order+0x9f6/0x1560
> deferred_split_scan+0xac5/0x12a0
> shrinker_debugfs_scan_write+0x376/0x470
> full_proxy_write+0x15c/0x220
> vfs_write+0x2fc/0xcb0
> ksys_write+0x146/0x250
> do_syscall_64+0x6a/0x120
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> The bug is found by syzkaller on an internal kernel, then confirmed on
> upstream.
>
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> ---
>  mm/huge_memory.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2a47682d1ab7..0cb9547dcff2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3075,6 +3075,8 @@ static void __split_huge_pmd_locked(struct vm_area_=
struct *vma, pmd_t *pmd,
>  void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long add=
ress,
>  			   pmd_t *pmd, bool freeze, struct folio *folio)
>  {
> +	bool pmd_migration =3D is_pmd_migration_entry(*pmd);
> +
>  	VM_WARN_ON_ONCE(folio && !folio_test_pmd_mappable(folio));
>  	VM_WARN_ON_ONCE(!IS_ALIGNED(address, HPAGE_PMD_SIZE));
>  	VM_WARN_ON_ONCE(folio && !folio_test_locked(folio));
> @@ -3085,10 +3087,18 @@ void split_huge_pmd_locked(struct vm_area_struct =
*vma, unsigned long address,
>  	 * require a folio to check the PMD against. Otherwise, there
>  	 * is a risk of replacing the wrong folio.
>  	 */
> -	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) ||
> -	    is_pmd_migration_entry(*pmd)) {
> -		if (folio && folio !=3D pmd_folio(*pmd))
> -			return;
> +	if (pmd_trans_huge(*pmd) || pmd_devmap(*pmd) || pmd_migration) {
> +		if (folio) {
> +			/*
> +			 * Do not apply pmd_folio() to a migration entry; and
> +			 * folio lock guarantees that it must be of the wrong
> +			 * folio anyway.

Why does the folio lock imply it is a wrong folio?

> +			 */
> +			if (pmd_migration)
> +				return;
> +			if (folio !=3D pmd_folio(*pmd))
> +				return;
> +		}

Why not just

if (folio && pmd_migration)
	return;

if (pmd_trans_huge() =E2=80=A6) {
	=E2=80=A6
}
?

Thanks.

Best Regards,
Yan, Zi

