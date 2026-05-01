Return-Path: <stable+bounces-242462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNPpIGrR9GkYFQIAu9opvQ
	(envelope-from <stable+bounces-242462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:14:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 823844ADFF3
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 18:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54152302B170
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 16:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AB13F65EB;
	Fri,  1 May 2026 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pF9Oj0n+"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021141.outbound.protection.outlook.com [52.101.100.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E4D3F167E;
	Fri,  1 May 2026 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651641; cv=fail; b=nYeDUlu43MvClsJ27dAY7qqwzxDtuO3j18aTIX6nYPa8VIABpxokYky7To22PGg8NP2EsgP950MHlJe6+WTFhdjf3NW6Fk1aQsyKaXBiyFmh/bhKI/7FNLkqFELcUrYDvy08aqJUcm6tP6vbYbd7B8cSLjRMlpTVLJHvaD6fur0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651641; c=relaxed/simple;
	bh=2LKyjHblU1s/5Qhwbxn+SE5joHqtqeJs0wo8dlJXeZ4=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=VvzfWDIzpNDSoQR8Nai4FtiKWbLNGEvgqUGmsjF4k9+FGMvsff6V6mVMjv9G8PkUZu+B1N/ylWnxd7phsN3yQAp4dPU7y/CWukiSlJKeGK0/dU906VRoE5BzhDq6lbZRUFw1/fCljEiiyaLFPBaF6zvdBkCxcJxQ+iV/W+WvSgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pF9Oj0n+; arc=fail smtp.client-ip=52.101.100.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB0zA35H4w/BjFxgqUvB40nI2qJGhUhEWsq4uvKNO5mUr4W/BwLSFjRhk36VWxTMCdN6ILHwTmsHK271lmdBvtLxTXD5WGDK6umLJmkRugPe9hunpFd3cj9ALscIzfzgmajccRygxuJSEDZ54O+ayOYzhLyHrYWlNC1uvpNcKt4Q5jyoQu6V2VqxQwExq3kDu1W9W09evBz3FicTRT/SkjdGY+7rXrr14FuW5bg/8/C7s8CEngcdnWiMOfdY09bSgMN2kBS8QudGuu5nEXJW/P/lT2oHiMNeKm/L1IfbPf19kCHIP2sNSbut4EEzcr3x2fzDyy66jaLlc9M9uoY9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LKyjHblU1s/5Qhwbxn+SE5joHqtqeJs0wo8dlJXeZ4=;
 b=hWuhgbgbyXYXOs+Hctl3eVo9BX/jJex/ve3jSFEyMlwfmOgnkxdt9LvNu5x1dGq4vP/oa+BRn1mJlZzCzXNDYrQEJJ5HEK+bmVgTT7NE1PwKMGQWdzgyMpbagiHkXajgqTgBOJU+mUWgwQuAJ9wVIDa49TTmn9COg7OYwZU7MPvLm9p5jl0f9+2CC1GareCGz28ympj7dXMpQ71wUiGwqWP88HfN70IPykTTmdnszlP+FRucQO2PduEqALMP2CtpSv/jrY/WgNgx2V6zNPoWrD48qND229WyG/YMbd7vgZ+eZx7yiaw+hlNIQasBy3dtQX1dZINtdd0shH4I93Xe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LKyjHblU1s/5Qhwbxn+SE5joHqtqeJs0wo8dlJXeZ4=;
 b=pF9Oj0n+8q4vL0uhDk03JpXNcK6YEguIp/7aMjehv+RAgPRLhfFDDs2kYluq6tdOwkE0CO3xGtbzH90lSri9xqoEZNOVkG1qitl9Z0hZ+ouMeIpPqpEKcodDYV7ovOWF6FgqqQJPIKHWznWQ/CUUmCIjmMPNyoodIsbTd+Xw9gM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3314.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 16:07:01 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 16:07:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 17:07:00 +0100
Message-Id: <DI7GWONWAXEC.1V75GBVHHR7AL@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] rust: pin-init: fix incorrect accessor reference
 lifetime
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
 <CANiq72kyqd93wd4cNxRZmWyO7HnGKo31i57ouh5gV5n9jEdu+g@mail.gmail.com>
 <DI6WWCFCV9X1.3RUBYO7H8KBW5@garyguo.net>
 <CANiq72kbFoYqMP47=sb0QRpEz70osvHD0TzMVopbzQ_nXdYp3g@mail.gmail.com>
In-Reply-To: <CANiq72kbFoYqMP47=sb0QRpEz70osvHD0TzMVopbzQ_nXdYp3g@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3314:EE_
X-MS-Office365-Filtering-Correlation-Id: 562a61bf-b5ef-4e7d-5977-08dea79badc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nYRADiT1FJZlVBq/I2WLFXlB7nklvQrDApQQNNpbMtSH36KKrfwVRe1QxS29fx5zlxOlD78WLw2KzVS+6+dVNK4mLrMMrh/K4UQzlrDayOXvllY6aOrK7QWgZ6Ml2LvB/rPnWensiK4TnxhCCHMKGac9EX4xpNq2aPPWWFx5RjMNLWXfQEKaH8w8wj01lXd9EnLiVRs7QSds+T8uqHlwBp25pTFJX1cXTd45Hi0D2POVJhq/OmXp0WSXtiX1/zAfyinxRAVbcp7lZKw8r1B8GvNHkPFymSbgcrv8eOKZto83Q7++knfsKrLacxyDIz1ZzYAwsJIujqNCJuCxTHkH4bNA1Z9LuJz0GG96EUHMeB+jbhWrzYrnbiR2P6DAeHqNOCrJZor6cY3JMtAhPWV1pkQFv1fa0dkgxjaEGEuua0jczLie2PyCLM9rx+6vOQ/h5en/cS94vMiFssNW/OsBKXFcHzM3rf3FAV3pB1yrgRR63cA7qP+3yaD/w1SjGio/subg/cXpI9bbPvrbAH25i/sfUKmF2B18lRXHR1EfZj+intDkylJLzPxAhWZ4xulyGKYZljYqIKiuCat90BT2zUPL8c++gv2+9bY9xb8X3/YR3UTkCsimWTqKY0ftjXZl5rNoT+y5h/23zfWI8N2rCbpUllnq0KJbkGlpCn5tknM4+06UmCzLem96hzezY19B
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7416014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzFnV3UvV0F5RHhSVGtKSkQ3ZG5DSklHVzY5R3VJQm80cTAxNnFJdEZxOVVl?=
 =?utf-8?B?aWhBWUp2ZWpsZ0M3UGFGTm1mdHRPRHBSMjZhdVBpQjF2TmRhZmVrNTVic0dS?=
 =?utf-8?B?Y1lDVVVBUFNIQjJCZ0FSa2RCdlJZZGxiWTJFOU1GaTR3MWFLNjFVYktpWmpj?=
 =?utf-8?B?WHM5a2duN0UvN1NaQjM0aG5CTGV4a2JUSFo4OXBIbm9nd3hNY2ZqOWdPWjVT?=
 =?utf-8?B?bHRGTnNhajdMTlExWmdOWjRMZ1VKZmFPTEQvbWIvaU1ickFxNXJVdGFUSEN5?=
 =?utf-8?B?TnplVWozS0Q3bnoycmhLYzBUMUlpMG92OFVHWHh4K0hraWhiaGhQQ1hhbEJP?=
 =?utf-8?B?dnIvTEZwTU9mMFBKcVl4a3lCbG9qTGZwRXAwK3FPaENPWXRyelZyc09wbDJ6?=
 =?utf-8?B?MW9NSEtteitiTHFONGUzbFQzU3lDS0JXM0llTDFUZjJrYmVuU2piUVlUNHA1?=
 =?utf-8?B?ZWduWm5LNkl6RGJnckg4eDc1RHJ1bEhtWmk3WitmclFrNGxSaU43YWRSQlJj?=
 =?utf-8?B?bUlYVjdaR253MkFYd3ZHcHB5TDIvSm1EK3N0ZDFiREZiTXRwQjlwUjFFcWVq?=
 =?utf-8?B?Z2tINHdLWUI5RlVuVmdBOThDbW9XcUpiR3FleCt0amNSRVRZczZPcDUyZzZZ?=
 =?utf-8?B?MjBtZzFVZ2RzSTc1dmJoM0pTWEZPRjFKL3laMEI2RWdiWms1ZnNhbEFGZ21x?=
 =?utf-8?B?TzNveWM3U1NPOXdWenBINkQxcUFNVk00bEFMTFh5ekoxY1VIWWNGYXRvR2g4?=
 =?utf-8?B?NUtQUjlDZWRYU0JpZUhIL0xRMUxVY3NLWXZYdm5jSU5UOTkxM2FuWitlMHhU?=
 =?utf-8?B?c3ZKVlg0UzBGTnNHU1F3SVAvcTBBZEFrNk5YNWdjZlAwOCtqS1FVTFR1bjlF?=
 =?utf-8?B?WmQzNDBtVkMxeEwzbGY5ZDNHSjFUNHVHWFlrR0F5UGx6RFQzYXJhWlVKOHVv?=
 =?utf-8?B?cjlsYUxkME5BS2dqdUxFUmlSOFZ6ZlZXT3p2Y1NqMUdVWmFGV290Vk5iNnUy?=
 =?utf-8?B?VTQ1aTBtbFZXU0RFemRzR3pZUWtIVnBJYm5wTXkzR3BKOHlnd0tpamQ0YTRt?=
 =?utf-8?B?N3pxTWl6aVJhNGt2QSt1c2xHYVRWckNmZFVYMGpjeFV6eGp0NzdyaWlkWFI2?=
 =?utf-8?B?THRla3RTb3VUamJiaDd4TzBaVndSZmNPSFpyNTB5T0lvcFJ3K1ljdEU4Q3ZD?=
 =?utf-8?B?Nm1UbEdGR0NSTDdxK1NFVVh6eWI2YTJrN2R5VU1ObmVsSlVJUThJK1NOL0s5?=
 =?utf-8?B?eGNPNjI1NDk4dWhqTkQxd0lDS1Y0UGpPRHJhbUFpaXdmamhzVldwODRJT0NN?=
 =?utf-8?B?ajhDM2VhT3lGQnJTWEtyQktUcjBpZHpnZjdXTUNaRlROQ2IvSmdUMFJkQ3c4?=
 =?utf-8?B?T1lhWFVpVDVWWFg3UUFCSHlXd1pCUnc1QlFlUjEwZ3RsSmZLS3QySC85ZXJ2?=
 =?utf-8?B?WWJ5ZkRhOFdtUkJQdURBTy9zd21NYndTSFpGa01GZUpyOVpLNEN0Uk45aXZ3?=
 =?utf-8?B?dXhzSnNwYW5PODl4bzd4QTJJdHNPSHJGdldiSFBBMnN3a0NVb1VEUWlGWUx5?=
 =?utf-8?B?ekU5MU9IZExSeTlqRDRvQU8rVExNV2hiY29TSDcvM1R2dzNscUZZd3gvOW1J?=
 =?utf-8?B?STUvK1JqZnB3dld0RjlIbTVTNUFUTE43dlJ3N05MR3lQaXNSTG5QSVpoS1J5?=
 =?utf-8?B?VUpOMlQ2akUrbk5ZWkVDL1NPOTRTYWZ2aWdjTEJRTlRBRThsTnBHdmczNFlG?=
 =?utf-8?B?VFdBVTBGQUxTeFNwZkJIZTl2Y3gwQTN4SlJXbkQ5WG5aYndObkJhUC9mV2Vs?=
 =?utf-8?B?d01aU3RneUJGcTNXYXdDd3d6YkNVU1ZXbDU4N3pJY20zT0p4b2crOE1FcDBP?=
 =?utf-8?B?R2F3N01JWkVHOUM3UUdXOEdUdkdha0lrU2RQWkdQQ3I3Ym9GQ3VwUEpsU0hz?=
 =?utf-8?B?WDd4U0lFYlBrR2dtK2EybTRHUzI5b05RbVJrdWFmM1VJZkVUcXQ0akpTSzQ5?=
 =?utf-8?B?cGJWRE1pdWZRWlJzUFJaNVdTU2dkdnZxRDdaMjFseHdnN09yRGZUcmZCemxa?=
 =?utf-8?B?K0FvaGZEOFFjQUMyQm9sdWlIK2Q3cTg4czh3YTR0cU1ON1VuSVUwTkEyV3NH?=
 =?utf-8?B?V2JmRlhmRjNrQXYvQktlcEZGTnZGVk14M1BKaEdhZXo0V0NSbXlGNHJPN2ZG?=
 =?utf-8?B?TkhBWmpVN084UmRncDdsbmUxa3pJc3lKTnBCRmNBZXpNYy80T3FSWTk4QWRm?=
 =?utf-8?B?cmluU0llWHlteXdhSU5vQVBORmJBQ1hFa0tlbkhGSEdJZ1p3N1I0bkNteHN0?=
 =?utf-8?B?eFNnbU45UkkwbjFyM3FkcTA4NWpwTHdVYlJkNDQzU0RGL1BEN0haUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 562a61bf-b5ef-4e7d-5977-08dea79badc3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 16:07:01.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO/FoeRe4XeTALOIlHZdw8h/5t9C+6NtQZQ2wX8MRIfbT/SdGv/eqV18oPH1adyhRYDeVaDOb3xGfNmdzqy0Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3314
X-Rspamd-Queue-Id: 823844ADFF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242462-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,garyguo.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri May 1, 2026 at 4:56 PM BST, Miguel Ojeda wrote:
> On Fri, May 1, 2026 at 2:26=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>>
>> For this specific one it would be okay even if you fixed up the typos, a=
s I
>> haven't merged the PR yet (I hold up merging just in case you modify the
>> commit).
>
> There is no linux-next tree until Monday, so up to you!

I've already merged the PR ~3 hours ago, so it's too late now :)

Best,
Gary

