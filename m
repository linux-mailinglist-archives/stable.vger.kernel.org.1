Return-Path: <stable+bounces-76159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4C897971B
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 16:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C07D1C20C67
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 14:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964B1C6F69;
	Sun, 15 Sep 2024 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ffXkUTi0"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020099.outbound.protection.outlook.com [52.101.195.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FD61C6F62;
	Sun, 15 Sep 2024 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410366; cv=fail; b=GEtwRIL+aN9ludzPFr317gvaJuEXaonFFxkwxzNBZQ2ZtFHod5goJmvbz7y1vFuJDfSSq9QwpV92SdS4z+V3RrwfThumR7IpQvEk0lHN/SSD28D+Y5wOmA9WOcTlAgeDItjJ73Y93KXFMRq8ydyt8dgAt4xjRvQFtKVTzCWZsKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410366; c=relaxed/simple;
	bh=Z4iRfYI4sxlzAOc0A7pS26qJlR8VltLflm+w6bhJ8qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r7y/ErsiSsv2/J3zg3mPucH0JXt0Ve8Ty2Vsxe6yKSpRFuLrEpc8l48FKO0lzMBEVbobGpOiyqJRgt1PxAUE1qYdPDKa/PR/xV7r7ZxvYhBZtlPl7tAOr5x1DCk4344RspyjB8HlKFXCD2H1uHMKZJtG4P2AAAr/KrwqA5X0zB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ffXkUTi0; arc=fail smtp.client-ip=52.101.195.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKS8R+ip5r+PxfK1w4VHZZdtj16vc+MBT8k/XvXInqB1SNrzz8Tv4oysfyffDF25GbDf8WNfLl1y2qG0qhUqRsrovgXnaZZtWHW69Diby8EDQroNxGWFmEvv520eIIVEsWwvSr7p0FGb/bq7dz02mJHahG3tuzhbbFNrJKd23YzcJVOlIItI0sUjiZUIwETZHrwPSpWw1wcMvEv3YrNVSZMirzwU6To3cGpvgT0hXeDZ+d68JcSSfhRjgAhd3phLhNBc9inXd+i8zf6v4/65EQnMWSaP+I/N8uUUFJVw2Y6Qh2G2a5LUiXLoTIZR+zEIvdfagtH2+71i8RFTzBOWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1XruB9OQ7WHv7k6ijkrb4ZL7CJf5Pw56L3BZ+QMv2w=;
 b=f8Ob273PykzvGXOPSLeOELHm7oLuEN644juQgoFJ0sSTrAdLutUfDoSME/2MzljeOAnMBLMB+GcmY0aOoEq/wpGL0UAPtNhn2IqZMSAM9gE+9HgtvlJOmVf2Zpsz9DEjqxelJkesozqkK0zS3+p6zrtTtnfjODGUd5uiGl9Hw8ymK3aDfTcPl1eXTa9yk6KPWGKXeVo+24TG1/4qtqFwaIi52vyCe22nXouBlXvSYwocQO0lh06jrv1ZTZDAa+Sl/VLmep5lGRd9d2VUtjX8fPG19XQcm38Sn4yDnUNfXI7I06vIhALYZ4z+Ky5YkJoQuT7WF+tL8WQu0om3QNDcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1XruB9OQ7WHv7k6ijkrb4ZL7CJf5Pw56L3BZ+QMv2w=;
 b=ffXkUTi0NBn3pr5YBtQkVtOPZ69THmzg++3QS3mDbBCtrQPseqPEAojLIZxph8+43DgKIwAxO2KsDJxOOwNt6HUhXd3R0YXc5Ekq7ESN3RKGZEernFJrDOh8Lma9WNrab+yEH9EzObYSEr8whqKeJuSEMEnErB/M8djVX8TXqVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2808.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Sun, 15 Sep
 2024 14:26:01 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 14:26:00 +0000
Date: Sun, 15 Sep 2024 15:25:58 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Trevor
 Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] rust: sync: fix incorrect Sync bounds for LockedBy
Message-ID: <20240915152558.68ff5675.gary@garyguo.net>
In-Reply-To: <CAH5fLggoz5gdgOpEiXu7u9hPXjLLeSv9An6jaq0am0-dG7+ohw@mail.gmail.com>
References: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
	<ZuSIPIHn4gDLm4si@phenom.ffwll.local>
	<ZuUtFQ9zs6jJkasD@boqun-archlinux>
	<20240915144853.7f85568a.gary@garyguo.net>
	<CAH5fLggoz5gdgOpEiXu7u9hPXjLLeSv9An6jaq0am0-dG7+ohw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2808:EE_
X-MS-Office365-Filtering-Correlation-Id: caac1f00-5401-40ce-8f67-08dcd592528f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDBpZ2ZzV2treUZxQVNQUkNscFQzM0tnVDZRVDJhVlFpMjJ0VG1OaDlDRVNM?=
 =?utf-8?B?ZWs2eEt1d2dMQ3MraUJFeHhrNEtnSGl0bVhPd21ZMUNkUEQ0WWlMSWVTQXVI?=
 =?utf-8?B?eVUvam5DTDJmeFVTaTgrc0EzMUdWczRSV2I1QWRyOW91bCtiNHVsV0h0KzA3?=
 =?utf-8?B?emlwZTlGWUF4R21LSnhnaEtnNmx3Vll6TzhUUi9Hem5rMzgzYjM2Z1NyRlVX?=
 =?utf-8?B?MDV5cjBkbUtzbG1QL3drK3FiYVRvRGdLNWFjd3R1VEozc0swZ0x4cEdvYVp4?=
 =?utf-8?B?dTJjZG5SN25MOGx1M29QdjFsMDlwcFZIRlRKYzBxVmxqRC9RZksyQ29Cemta?=
 =?utf-8?B?N29qbkpMbHdFZytpbzVBc3pDK3FKYnpsZm1vRmJQU1BjL1hoanJJOCsyNGpr?=
 =?utf-8?B?dTJMRGlSVzVRcW9VOHVUb3p0a015aGZ1dmZ3SlVZUWN6dzl4akptRm1XWlBM?=
 =?utf-8?B?ZmFLSURFYVNXd2pxVGtBVE1qL204d3NxYWpKOXZLVjlweWgreWJjRVM5dmpX?=
 =?utf-8?B?T0JqK1F3VlE1ZEI1NVlIVnd1VmVROTVZbGltYWJLeEVWdVRhdWk2NDAvV3hm?=
 =?utf-8?B?M2kwR1R0VFJRdlNQNE1GRzdYZ3Z6Y1RSbVcySUVaaVFKdiswNWNuK09BZzJi?=
 =?utf-8?B?dmI4TFJ4NERoV0xOMFdsT3kvcFlDQTl6a3Q0Sy8zdWlTaGJNWkltcUxjY0Mv?=
 =?utf-8?B?a1Q5LzFtVVhiSEM4Y1Q2bFUxRjVNc3FLb1g0b0xrWmxTRlRUWUd1YkdhUDVD?=
 =?utf-8?B?c05JZ2M2SW5MSTFpNTI4QjFQcTlXZEVtUHlOQzFaaHFlb0EreUl2cVlrdHZ4?=
 =?utf-8?B?clRRSzJMUi80eFEyVC9sY2NYMzVYRkNUS0drNUlIYThVcjV2NlRoMUcrR0xK?=
 =?utf-8?B?R1ZFNlFaaGIyL3dEd1NqWm10ZWJleTZCd2d6QU5xczA1M0QxSXBaTFNZRG9Q?=
 =?utf-8?B?NGxIYW1iamZBd3duUWdqTWJXMVMzdmVmUjFEcWZWdU5BaUNtYkgvMjQrbXdP?=
 =?utf-8?B?MnAwbStkTm4xVjhNNllvL3VtUyt5VWc4NzR5UVMxVFowd0pSY2FZRVZvSWQ1?=
 =?utf-8?B?b0REWlU5NWxqL3JPUjM5aThUR2FyajJ2N2xVNGE0SFFhZFUvWTkzOXMwZGR4?=
 =?utf-8?B?Q0JhTnZjMUQxSi96LytxSE5PRVBLNXhWQkFZQlBndElNaG1jbUJvWTdZRWFo?=
 =?utf-8?B?ektNL2g2b3JpUWNNVHFVNHNWTkpWWlpBWis5YlgxcGdUSThrNEwySFF3OHpM?=
 =?utf-8?B?cU03c05ZdSs1Wlk0dW5YVGlyTEJ2M0JYUE11aVdBZTh2RUt2THZrYjdDaU94?=
 =?utf-8?B?cWZvK1lyMWpCNDBneGYwaTVoTWcrYXlHeEwrV2dyQVhJVEVaV0owVnlnbTg3?=
 =?utf-8?B?QUdaRjIvMTVFa0ptRTlLTU1zZ1M2akYwSGRpdFZtdVdJRGpDTUlnWGduWWFZ?=
 =?utf-8?B?dzBkNjJRaVhjKzJvSzFwRGwrTWZ5bFM0Q3NveGN2WHZuQXlWRE1CQmNiZzJI?=
 =?utf-8?B?R1FwUUNLTXpYZVlmM2ROL1psOE5RN01mMVNnUHh6R09XWEVBNTdpMzNIMkM1?=
 =?utf-8?B?TlJ2aGpOVyt6eWthVis4R1RjcWRmdUpoWVBHYjE5N2lQd2pETWJ2ZTBEaEFl?=
 =?utf-8?B?aUMyQitUbWxRanRKa2FOSHpGV1YxTi9STEtEUCtkUkxZS2hnZEoyVjR2SjJU?=
 =?utf-8?B?clE0QnB5WVNBOTdPSlplTW40NW5Xa2ExQWh0ZE1nSE1ERXRHNUY2OUt4SmxP?=
 =?utf-8?B?YXZRaUtoK2ZSRGJZcFRaR0tSNERhcThvNlVrYXd3Y1pJdzRzMStDNWVDNDlr?=
 =?utf-8?B?Zm9kaDlrT05WUEpLZlROZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0JZTjJzcTBKT2pMVWNGUVdRY05TRVFNdU5aNTZwOHpDc2lNdWJKeVRLcGZH?=
 =?utf-8?B?bHBkaFRNaURwMGp1R005YnNpTjVRcGFuRzVKaDRvTitwR2lWendlZ3ZodXB2?=
 =?utf-8?B?Q05tUlFveGZiUDBQcmxRakVNSUZzYXZyNm56Qy9teXkrMDZOdXRXNld3U3V6?=
 =?utf-8?B?OTdKSTlEME90VmdESnZiei82dU14ck1lM3g5c2FpdTRZaXBhVlBVSUlReFla?=
 =?utf-8?B?bkY4bmZDakthTUV1MzBUNTEzTllmdUQ4cUR1NkVzOHZWRWdKOW1saFhCcG5v?=
 =?utf-8?B?TlBOVXFZeDAxbW9ub1JnNHpnZ2IwcVFiTXNKMUlXODUzblg4aXVsaVdyRm96?=
 =?utf-8?B?Nk9LSmtRekVRUEd2bTQ3dzNPOU1iOWwyU1ZLS0pvNGlhMHpWNUtlcExTOU1W?=
 =?utf-8?B?TGd2K3JmZUVWS1ZmQXR6LzBlMEV4UFhSSXZ5VldJQ2JkWHA4dnAyc2VXbkxu?=
 =?utf-8?B?amxYUDg5QUlVQ1VVRzRVZWRSbUlabzM2aFJqRU0rc041Y3gwZG9EZEJTZmVr?=
 =?utf-8?B?a3JvNUVJWUY2Mm5hOWNVa0V2TTI5RFNUTlZ4RW9kQStmSEtCZ25Jd1g5K0ZS?=
 =?utf-8?B?a3Nhb084UUJnMFdXd0V6cE9KQzlXcDAvWjY5YWpIekxQZHdZS2JHc3pkc1VN?=
 =?utf-8?B?Y2JJbnVhcklkM3dCdG5yd1ZEWmVaenFBenJDN2VRai9OaU9TR3N1cThSZmZK?=
 =?utf-8?B?MFRlTWV0TThmOXo4RlAwdzhiZlRjK1U0cjMxSGt0ZlJvWlRWVnpIVUZMSHVt?=
 =?utf-8?B?cVVicG9aNnlmeWVzOWFQejdiYVRZRUdWRCtxY0E3SlhzRGJXVUh4Yjd5eVFj?=
 =?utf-8?B?RmNDdlBNMjZXcDQzdmM1dy9mbFdLSlNHWmhzQUtGak5BeGUxVVE5cjMrU04r?=
 =?utf-8?B?dmxoYks5NHE1RW96ckxFUHlVcFdqbFBIbEtJUjFzNCtrQm5tdHQyaGNLdlkr?=
 =?utf-8?B?cEJuRzRQaFQ5bk9aZG52OHpPMURDbWJpMTVGclozQnRUbnJJRFFyd3FnRjky?=
 =?utf-8?B?QUVTRVVES2g5TVFWT1cxaGZ2cUhSbUhzYUJHMjh0Z254aXZFbWNEQ0w3WEZ5?=
 =?utf-8?B?VFJMNXdXS2RwQnlTRFdVL0EydkZ2R3NVZ0RuYjFPaEVJaVlqaVNLT0VNRHJW?=
 =?utf-8?B?OXZDNExjNXQwckJvSnRGMTFOSzlZT3k3amUxb3NubncxZVAyNVRpWUlpQmhB?=
 =?utf-8?B?NlVoTmZUR0tCWWlmbGM1M3k4aVlBUUk3SFFpbU9aWEl0ZnhURVJaQW5vSHdI?=
 =?utf-8?B?SXZmeEl5b0JDWUU3NlhpVFBqSjBhTWFpWEk1VFRBL0pGRnkxWkZRa0tXclhG?=
 =?utf-8?B?NzBGOUZFMnZuVFh1TWZtRU1GQTRWNTBQQktQeFNjc3FLOTBBenpyeEFBbGhm?=
 =?utf-8?B?cnVndzBRR05BVkZkV3lERy9zNjMyNkJjS0dXUURyQVV2SjlUT29oM0VlcVRu?=
 =?utf-8?B?dUJGSlBMZm9kaWNuV3JlUFR1MlpJcGcwQzBLbllNVmZVUGJLajJsN3VjRjV4?=
 =?utf-8?B?dTRYWXhhVmdwckFVQjBGeEFuSnB2bm1HbG44QkprZFEyYXprRHppRkNXZ2Fa?=
 =?utf-8?B?aDhGWkpzOWY3YXpxL1A2dXdoZWNyYjhRYXBlaUZSdFU4bDJRVU1MelVGcldD?=
 =?utf-8?B?dDltSTVLNDhlSThNZnAxRjRDUDQvN3FBZkovcGRRYjI2SU9IUjljTUFPTElP?=
 =?utf-8?B?RXk4V1Blb3Nqa3h2V2tYTStHUmhjZG1Ua2Fwb1JQQzFoZVBjcmkxMU12cG1x?=
 =?utf-8?B?OFk3OFZWN0E1TTZpSmVHaWUwU08rOUpnYTBOeDhKNkxBb0hkM09uZTRyRnZy?=
 =?utf-8?B?dlFHVXE1WGtqVSt4N3l2ZjcvbkxxeDNmTzdyY2tkSXVwNEttejRwWWxsejlZ?=
 =?utf-8?B?cGdiL3dKbDhDTG5tOFY2b0NDTVF2VU9CMk9sdDNRZkloZ0N2UldzQzc3S1pI?=
 =?utf-8?B?SlJqeGJ4Qk9VYU53K2hKcVg4YzlaRkNDbHd6cVl2aU1LQXlXSjRsMXhmWmls?=
 =?utf-8?B?MTNIeTRxK3BMTDQxb2NpZXBBWWoyOStpSThVSFhUYkcreGk5SGMzT1dEKzlr?=
 =?utf-8?B?M0lMbWpTVlF2TmVWcjFncHNqSEV1bW5EMnRLWWpHYldwSTFqdmJPR201MCtn?=
 =?utf-8?B?dzRFZDh0dTVUOWZBWGt0SHFidkZGRjhhTHJsNW5aZUFHTTJvcVVjWnBoVlZj?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: caac1f00-5401-40ce-8f67-08dcd592528f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 14:26:00.8711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykydYw1rPnQtgMB7vLgvG9gz67UMftSL7QbO5+Y60iSgg77h+bd0oUpLK1iiuQeUqal3AviqNCLbPtXP3bt+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2808

On Sun, 15 Sep 2024 16:11:57 +0200
Alice Ryhl <aliceryhl@google.com> wrote:

> On Sun, Sep 15, 2024 at 3:49=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
> >
> > On Fri, 13 Sep 2024 23:28:37 -0700
> > Boqun Feng <boqun.feng@gmail.com> wrote:
> > =20
> > > Hmm.. I think it makes more sense to make `access()` requires `where =
T:
> > > Sync` instead of the current fix? I.e. I propose we do:
> > >
> > >       impl<T, U> LockedBy<T, U> {
> > >           pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
> > >           where T: Sync {
> > >               ...
> > >           }
> > >       }
> > >
> > > The current fix in this patch disallows the case where a user has a
> > > `Foo: !Sync`, but want to have multiple `&LockedBy<Foo, X>` in differ=
ent
> > > threads (they would use `access_mut()` to gain unique accesses), whic=
h
> > > seems to me is a valid use case.
> > >
> > > The where-clause fix disallows the case where a user has a `Foo: !Syn=
c`,
> > > a `&LockedBy<Foo, X>` and a `&X`, and is trying to get a `&Foo` with
> > > `access()`, this doesn't seems to be a common usage, but maybe I'm
> > > missing something? =20
> >
> > +1 on this. Our `LockedBy` type only works with `Lock` -- which
> > provides mutual exclusion rather than `RwLock`-like semantics, so I
> > think it should be perfectly valid for people to want to use `LockedBy`
> > for `Send + !Sync` types and only use `access_mut`. So placing `Sync`
> > bound on `access` sounds better. =20
>=20
> I will add the `where` bound to `access`.
>=20
> > There's even a way to not requiring `Sync` bound at all, which is to
> > ensure that the owner itself is a `!Sync` type:
> >
> >         impl<T, U> LockedBy<T, U> {
> >             pub fn access<'a, B: Backend>(&'a self, owner: &'a Guard<U,=
 B>) -> &'a T {
> >                 ...
> >             }
> >         }
> >
> > Because there's no way for `Guard<U, B>` to be sent across threads, we
> > can also deduce that all caller of `access` must be from a single
> > thread and thus the `Sync` bound is unnecessary. =20
>=20
> Isn't Guard Sync? Either way, it's inconvenient to make Guard part of
> the interface. That prevents you from using it from within
> `&self`/`&mut self` methods on the owner.

I stand corrected. It's not `Send` but is indeed `Sync`. Let's go with
a bound on `access`.

- Gary

>=20
> Alice


