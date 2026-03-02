Return-Path: <stable+bounces-222611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJBYJImdpWlrCAAAu9opvQ
	(envelope-from <stable+bounces-222611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:24:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 101EA1DAB7C
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3AE330D0F7B
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714B3FD12F;
	Mon,  2 Mar 2026 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="D2KahejX"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021121.outbound.protection.outlook.com [52.101.100.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FE364927;
	Mon,  2 Mar 2026 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460866; cv=fail; b=DV51TkMbdogdIo4vZYCKmo5jdKQJwuyuCT92YUTgFqGP+MZqezQNLJ+NgQLwVJOX7lHCiAPyka7n0vIBYMHUEXVfcObGXOCLq4mODouhjPBuShptqsMFctxhB9P/U/YPnVncvffwmA7M2Y9K1egtYtc0s9jjtdcr0ZwUtBZ9A9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460866; c=relaxed/simple;
	bh=rZZUkMO2DBZwVb17uW6aYB36hE8IngMozGAzpIGH6ss=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=JeMSVIrLQvqUp6rxAAvKEU4JGMHSGpaJFj1/gR34HgNfkCQjvRLfaKJdxZrHktSUAb4KOwSYDwKsUctKnTnLbsUzC/zHAGWlE/G9NCjGGeXcwASTV0AGfoYagyZxW9Nk0Hc2zKMs7YDlci2aVYUsd6x6qi910Tqphp6MmsvFGxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=D2KahejX; arc=fail smtp.client-ip=52.101.100.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X49sag0N0XkGmCQVbvGUpWAGWi8bGJrtgCWpO/Te0kJm4uCTB1rI3lZypeWtAnfcxREvUAWpUxXVbDr5CdMOLRQm+qUg5IAvgcLrMSw+wEODHsWIRE+OYQ5zhdb2Y9rJ9VcDX6XqXqhLAfOGuqZpnn6vEajr9btdKX/b/pn7G2joribjg7KQy74bmOhxTj6tDxHNrcxlccQhP+Aq/BuEhkndDJRZvjIad9LDle3SKE2PXsQ71UCBotNhEHv1m3GWagmTGxEjIAAtWOy79xc+deM8I1YyrHI9rg3nMOY/84ZoO9a87QCxSrGFnuOnICpUTmOK15B/Cr+amASK40v/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1Da3Xw0/nfji/3A0lp+mD2oAhd3ABUCeNJ4ZAemtjI=;
 b=oWWWygIyy72BXTSmJrIDOdFfYWwDIgL7CpCdFvxU0pAmLTrlqaN5m0nCt0hMhQ3VEOK52FOXqQ1Tli//uegJFAHPmJ2SwFZCiBboG2KIkV2m3mIUOV24rkUS9WGq7yNQ/0Ep0ZWVXSUVlIjTrYdr47nAcAcO9Q1CXY9jkcQR4yJ8E5u//MxB2Fz57E+U9xDm3225W/KnWWZqe5uq3D//sTSOzY3wYPts2o5gj+2xADbZzgYUP0jVCxN67xIa7kmCWoISDdja92PwRYA9XezkCrhVDPFMXKF3p8OdP1wCfsfVrZa2sK7/wwixK0QOEQ9Pn20I/KLIyw1wgdezFBOV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1Da3Xw0/nfji/3A0lp+mD2oAhd3ABUCeNJ4ZAemtjI=;
 b=D2KahejXSMbCFTo7Ue0YSjJheaKpWN7SvRVfzinryL7ijxQsWsBYWAn1RCpBN5PfrdwWEkhlHvsqvdFDGysEVs99olJIKDADHw+/e9LnJXkEjGkW1nNWoXdWPQXDIM8zSkzA5oEnbT9ll1CfP0n4puRyrAnvvyiVo5dpu3v6tHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5887.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:14:20 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:14:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 14:14:19 +0000
Message-Id: <DGSCXPXGW2SW.D8VR5QI5OVNT@garyguo.net>
Cc: <stable@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] rust: pin-init: internal: init: document
 load-bearing fact of field accessors
From: "Gary Guo" <gary@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260302140424.4097655-1-lossin@kernel.org>
 <20260302140424.4097655-2-lossin@kernel.org>
In-Reply-To: <20260302140424.4097655-2-lossin@kernel.org>
X-ClientProxiedBy: LO2P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::34) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: d37feff6-cf27-494c-6fc8-08de7865ff1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	reo6gLwTo3BAd7l1lS8i1s9WmPZqdgYq/KSUVMAjQyRXadkA0mJux5p096n0pFxs0PMUBl76fgB+fLPY19cpxr0KbYxIjQik5yV+zyx9LaeBortd8v2RaIXjEx4K8Ts1N9scWzrJUaVWaKoCRBLcBYRbXuudjHxbsOt0O789S7aKlna1aqmwGsQeISRuj94CRZkuFOSabLd3FYNUvWpOU0xoaRvlyypVrz2CuI6K4d3fNt8yASCBMDPG6s5+IUf/s6VJKabWrq3VG+GaBF7GtPK7S9g9PmJ8vN218Blf+YSRdWYwUxNDd+CBpP+Xr5PViNhSa3PopThRqTA9NRnv4H3pMmvXFWbCzm9vnZo9Dv8RI5ALX9OdnETYQ5cdPgRQ66FxWLVXQZoVej0U6uWg6pr2Z1HqmM4ojpSRx2jv3mCeVkPumX+jELA8kbYM9/4I23oJnAStBPVanSIlSlnagazsta8GbKNZ0onZcKftRAFym4O5sMXD819WEClf10Oq17148tdCSi4P+2o1DZyFYkHkvZkiYaET8NoFXSnz8ABt39CL1B6TD4FNOa1wN2Wz9mYmPprXt5Oj5LeFE2FVBdSjFZZKy+MEzVTRTSZerMrQ5j8BhdukmM12+S0Gdh4KT0oYkBvpoIQxlRhJsWLav5mR5QpguLTWdHVWfvO+fIc1mvP8ColOM/JPWcHsWYj36n6OAPHu1/Sl8QJdCgLKPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1VpWXVlSlkrZU8vS09PTFdhNERDRGZicnFFUUdXdk5UeU54dklTa2phNjhT?=
 =?utf-8?B?U2JXSjhMZzhvYkVYOU1UOFRER0Fmc21TeW8yMS9jTGxDSkNCSmxHaUdNd3JG?=
 =?utf-8?B?eStudGhnR2xQTEFqSUVCekZGUXJyNUM4c2xFdm5YcXZ0a3NiQkpuMGtBTkI1?=
 =?utf-8?B?V1JnOGZuMUI3NWMwenNQL3FhUmp4cFgxNlpkbzZoaTVXQmdYTCs2YXZNL0tp?=
 =?utf-8?B?M3MxcmRWR1RWN0dLbVBFRE0yYStTMENOYXZMZVJiTGpYNzE3ZkF2L0o3MmpJ?=
 =?utf-8?B?TWdTcVdnRWx2blk3WmVLV1c1Q1RLWm9mRGcxZ2dWd2J1T2VTa2hCdytOb21B?=
 =?utf-8?B?blZmUXA0azRIbFJtdTAraEhvQUovZ0xEMVdEYkV4TkVTazBBZlJ6d1hSbmx6?=
 =?utf-8?B?M2ZIYTNiSlU0TXpuajdFdXVFS08rWkZOS2RZTjVmUnkyVjhHNEFLcUtaWnlu?=
 =?utf-8?B?L0ZUdzV3L1BJYUZmR0gzUk5lT3V1d0Y4SXoyYVAxcEVPbllxaVNseWZvWjh5?=
 =?utf-8?B?bVNVVllweE1oSlQ1bjJBcndwbzJwcjh3ZHBvdi9JZDFERWZpNk90TjZPbDA0?=
 =?utf-8?B?bldsMm5BTWNLMDl2dDhSMk1OVE1zTWQyQm9oTlV3aUI4M2JkZnVOU09kVHJG?=
 =?utf-8?B?UHlsdUxLNGFqUXFOWFUxRTJUc01NT2dtODlxempya2RYUVB1dTJRYkhYMmNJ?=
 =?utf-8?B?V1ZGaXMxb2F1aWtSeFVMMFJ4bEI3M2lYQU92bURuN3d0SHM4blJFV3JHK3d4?=
 =?utf-8?B?b0x0RUtRZERjL0tkMHhhZHVlQVUwU1V1QW5KT1A5UGpobmZuVDVmajU1OWRB?=
 =?utf-8?B?WWtic0I1SUVKMGprNkNENGdtRDhvL0hwTGpmTzBWdWMvbG0yNXdKMGF6TjZ6?=
 =?utf-8?B?TjFvTmphMjI4VTdGYmx4bHdhQ2NTQU1tM2RmZVd4eHdBNlFzRXlnQnA1Y200?=
 =?utf-8?B?UEY3ckRRM1J1K2FUanNyYVF2MEc4T1ozUjJ0cnZPbFVnaGNqREZRRzZna2NO?=
 =?utf-8?B?NjdyVXlOSHR0NWJpbWNRa3BMdnAxQzlhZHBSNXlTbUJ6T3NKNEo0aUgvajV4?=
 =?utf-8?B?VnlKU3dPMUpQVXJJY2x3UDBXRjVSUkpUZlBjSFNGR29TMWNqa3ZKMXM3d3l3?=
 =?utf-8?B?dHRZQVZ6K3hpdzBCcVVJNUJSbEJPNmxvMms3Zjh5SlpmOHdpU3VIcWlIKzhV?=
 =?utf-8?B?ZHp0ZnpDblRUZld4OUhqQ0FHNHBqTW9GZmZFY3BOR090eUZ6NFg4V05LSzRO?=
 =?utf-8?B?TFIrY1h6NlZOY3ppQ3oxV1VQZUVESE9GNWxHcnpYQnFHRDR1SkNFOWNwOUY2?=
 =?utf-8?B?dUZGb3FBbjBJdWgwN3QwZ3Y2QnZzY2xuZDE3MnB3Q2xmSEo2c0g0NGxEWlpw?=
 =?utf-8?B?T2lqL3VMd1JZalJzbmJWTXJhRjNXdUVTOXhTTTg3MVc0VUg0YllicEJCWWpm?=
 =?utf-8?B?cHdVK2w0YmdjZ3JJRDVaS09uM1pnTUhQNUpDREI3R0hleHh3YUlHRjRna2J2?=
 =?utf-8?B?Nm9mOTdYOEFqYk1wMVk0RlhGYzZRVll1VmZhNEVVQWdyRTBLUnJlM000d3FJ?=
 =?utf-8?B?MGlDL09lb3VPS21iV2JBRTlaeDU4Q21HT0RaQUNlcUNoVTVLK0pIMkFTc3FD?=
 =?utf-8?B?TW5lNERyMXB3V3NQNVhpdWVJbVlnR1U3YW92aEo4NzBuVGpHQjFNc1FKZ0tr?=
 =?utf-8?B?STUrVzBtbGJGa0JEaFlYRmU0dDkvNG9UeTIvL0pDYlYyZ256WVNBNk1nRE8r?=
 =?utf-8?B?M1paSUVVdmRjQWFQWUFVTXpwcXBJdTNqc3BxaVYzVVFaVk1NdHRRM1l2aStx?=
 =?utf-8?B?eEFMa04rU1hUejM2UnBpTjN3MEZEbmtoNEw0cGtEVWxVS0FiaUczK2poN3Ru?=
 =?utf-8?B?Z09Nc041RDAvTWpaMVEvTjIwdzYvcG5YN2EvTUR0djJBTnlUMzI4VTZ2MU90?=
 =?utf-8?B?YnZ1YkJIZkR3aWRKaG9MWHJHQkQ0dlNMMCtYVEhKVS8zSW41c1QxOGl1Rktz?=
 =?utf-8?B?QnM0N3JLV3Q1Rjh3UHlJT0IzUzJLdDV5MGtORGpTYnprM2xZeDZhL1VYUGJV?=
 =?utf-8?B?UW9aTzVwMXZFSFNUNEx1SHF4MDZxRDNnYjN1MHoxcjZZOUgyd0xncStOblMy?=
 =?utf-8?B?T0U5eUJWWXA5N3NtUStBdWNUYjZrVUI4eWxSbnVpZForZ1JZRXNRbW9mMnQx?=
 =?utf-8?B?TXgxWTRDeCtFM21FY0Rsb3ZncGIwaVJLSnNDN0tPT1IvZENjMnlLZ1B3ZVVu?=
 =?utf-8?B?L0MzMHBkR0l5eHhlOTQrTEp4U08wb2NPR1pMazhGYmlZR1FQZExpRU5vb3F0?=
 =?utf-8?B?NFV3SDAvVFd6UnBPcGtRbjhJWnZBTC8xUmZlWWpyampJcHJ5WmV4QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d37feff6-cf27-494c-6fc8-08de7865ff1f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:14:20.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO8ucnBz7c+ymF+kZrJLDzv8B7Wwk2ue2+wqFUyDlqAjZ1ixBEcK45FEgKqgAQnTV2QV9Ie5G1HX69/oW8EQaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5887
X-Rspamd-Queue-Id: 101EA1DAB7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222611-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2600:3c04:e001:36c::12fc:5321:from,100.90.174.1:received,52.101.100.121:received,2603:10a6:600:488::16:received];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DWL_DNSWL_BLOCKED(0.00)[garyguo.net:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,52.101.100.121:received,2603:10a6:600:488::16:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,zulipchat.com:url]
X-Rspamd-Action: no action

On Mon Mar 2, 2026 at 2:04 PM GMT, Benno Lossin wrote:
> The functions `[Pin]Init::__[pinned_]init` and `ptr::write` called from
> the `init!` macro require the passed pointer to be aligned. This fact is
> ensured by the creation of field accessors to previously initialized
> fields.
>=20
> Since we missed this very important fact from the beginning [1],
> document it in the code.
>=20
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/561532-pin-ini=
t/topic/initialized.20field.20accessor.20detection/with/576210658 [1]
> Fixes: 90e53c5e70a6 ("rust: add pin-init API core")
> Cc: stable@vger.kernel.org # 6.19.y and 6.18.y: patch should apply withou=
t issues
> Cc: stable@vger.kernel.org # 6.12.y and 6.6.y: need prerequisite see belo=
w `---` for more info

Hmm, if this patch is applied as is, the --- below is going to be cut out a=
nd
this line wouldn't make sense.

Perhaps we should just put

    Cc: stable@vger.kernel.org # 6.12.y and 6.6.y: need commit 42415d163e5d=
 ("rust: pin-init: add references to previously initialized fields")

Or leave this cc out and ask for manual picking?

> Signed-off-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> ---
> As already explained in the previous email, we discovered an unsoundness
> in pin-init that exists since the beginning, but was unknowingly fixed
> in commit 42415d163e5d ("rust: pin-init: add references to previously
> initialized fields").
>=20
> We introduced pin-init in 90e53c5e70a6 ("rust: add pin-init API core"),
> which was included in 6.4. The affected stable trees that are still
> maintained are: 6.12 and 6.6. Note that 6.18 and 6.19 already contain
> 42415d163e5d, so they are unaffected.
>=20
> We still should backport this piece of documentation explaining the need
> for the field accessors for soundness. For this reasons we also want to
> backport it to 6.18 and 6.19.
>=20
> Note that this patch depends on 42415d163e5d; so the only versions this
> patch can go in directly are 6.18 and 6.19. I will send separate patch
> series' for the older versions. The series' will include a backport of
> 42415d163e5d as well as a modified version of this patch, since this
> patch depends on the `syn` rewrite, which is not present in older
> versions.
> ---
>  rust/pin-init/internal/src/init.rs | 8 ++++++++
>  1 file changed, 8 insertions(+)


