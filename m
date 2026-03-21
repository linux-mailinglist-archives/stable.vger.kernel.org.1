Return-Path: <stable+bounces-227788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKtILO/mvmm2igMAu9opvQ
	(envelope-from <stable+bounces-227788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 19:43:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FC2E6D5D
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 19:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2396230091C3
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC234753C;
	Sat, 21 Mar 2026 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="pyxHAUqN"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021140.outbound.protection.outlook.com [52.101.95.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BB32DF6EA;
	Sat, 21 Mar 2026 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118576; cv=fail; b=hCR7I89Vk3SfFuJ/36V/Oe0jJqVOCJYz40nG45fhupzRz8SuYJi69Bh6pQ1mja6lAS11GCyMKGdgE1tC1+n8piUekymc7GEyDUyefAvQp4kjZGdiH0QRh9YsLjNEGjrg24Ohl3/buwMoCgtghZqnuHPcZldn9k5BMcXS2EDaMNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118576; c=relaxed/simple;
	bh=VdZxCcA2xOv/rIoeUURL+sQcsSw/dQCGWpBnyizo0UU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ZF/yjZceuQspHfffZx1P/FfCyfc6GRfoxAdP/X1I6Be8A8r8HWzIW7jMBOKM2iIFlzt8snMXpYaaZtExn8GgIG6JylKkl0fJeyTpCw07/rFxniqTqHemmS+vtt8Xt6KDTOHqM/7ybOT09w45oL/2rlaoxJoIIqmLMLUGuNqsxFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=pyxHAUqN; arc=fail smtp.client-ip=52.101.95.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh7uZ9w+aM51hxF3Y9dfeWzeIdVGmT4O8WLEncOILeXPFJxHOtx5CZJTvqhRcENbP5NqG1Q16wzxPgWExceAfwWERt/seN/GikVqEdfhnpRQCCw3u8tUWEly3qfbZHWi8SpvoPifaSb2X2iYPKseucpuLmtNntY6Ovi3WEFN6qQFZDcQD3+MbrA1AG5VIHMV6Ae+rFDGt1zD/pwNcfkYE41+MscxliojxQBwBLfj8KAeNZjP2ugPJugWeYXTwEbDMI2TZT9Uy2Q/fGeLDnZuKKD9mD+8yaJdmRM7zhS6t1djogKSRCEn+KS9NKQqgKu9aAGoN4pvvvIzxKPp75EnrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9fJhrghQr09NyNQ8iUvScCcKXp0C4VHFCU593COJM8=;
 b=JAkApeYHFXjlIYEVlmXCW4yBqmuL70H0ebMSIbSVWb0YKj1zCOwr6n7kjtkjTsFLlMVk3pmktuQ63+GjFiMNoat0GbA/37q0xp5MzbxMP857UEI3kkZFpjBZPyGDXoQ2vfq/CZ8zlYRLHrTUEw6W7o+5N8l/zs2JYR+hkIBi59499WcoimqqqkpFrfNEBWsDGdqDSAU7njcsip/olTLhF5deIQ4xr3Zpr4kvKOslpIpXtTee3vxl8xbu3w8N8PvUaidQbet+r7faHGWS1dQZByGsWUC67FKd9AfnNawm2u2hJCLDvsDQY02BXxrvEDRfd+XJbqE6I7E0eQIVoZazDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9fJhrghQr09NyNQ8iUvScCcKXp0C4VHFCU593COJM8=;
 b=pyxHAUqNgsBFEB/noKGj1wogvJIrWOcMdLPnDY38YkDvoRe0K4ZBWg1scUEnoV52lybu/nyO3FynjyvLTD6NB4xfvnE7zdRlvBk4M2ZfktjAfnt8/1ZckHk4B1R1oz/mpkCasZnsqK75r9/wSCCI7hUpp3ZbI9msauIFjIGQ+ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5748.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.22; Sat, 21 Mar
 2026 18:42:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 18:42:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Mar 2026 18:42:51 +0000
Message-Id: <DH8OJO5R5X4N.3T0LD6QO3FEO6@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] rust: dma: remove DMA_ATTR_NO_KERNEL_MAPPING from
 public attrs
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
X-Mailer: aerc 0.21.0
References: <20260321172749.592387-1-dakr@kernel.org>
In-Reply-To: <20260321172749.592387-1-dakr@kernel.org>
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 181f8cc4-5e66-4bd0-0138-08de8779a846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|10070799003|7053199007|22082099003|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	ge6LzlRsr4gzl+YCbPNqYbgI8QUAMoojW5c1LdgwYAC0mcKVkr2C+pZq3TD0eNRGxzra94odXPpjTos55Tw7q1HFlfGnAAoWCu6GRvr150umFJBJElF/e0Za31oH+eu9AmTgLfiZamrglCsgSv9cdpOijFHUImQuYOSdRmKHRd38NmJMHyEmsHgJH3uhj02KRbrvIdiCA5O+hajDsKks+eEFJNMdQHMZViVukGsS1b1ZuxH0BODaWivpmALEnnMb+DiG5beTm7itvwIT9UGsqr0fENyhWXoLFBtGBTTt1s/9TaSGMd3QRU3rbjPzWirhAT2cLZRScVitgKNwxz/GDdQyjvTFfNr5KfYZ9dUjNTa7MscrwiZGP+UFkWfZEVQBg6JMcrq9Ihun221dcjf8PkDhBC7P/gclg+wgjMwSvQkVz1D4TfLgHpqbNi+Af5WWC8o4v4+NchqTsgNd8EI0EUANZGPOVNYgNWG2cmCw1/RwrPdRcskgKuwb2X+LZQ3djbQKyQ6J1tGom94sWT7vxadWPvwEM/hUuLCYbXBuJ3QjnOPRcfUSnD9SPcoXeW3ol+x5bqkJji6cgMnK0dqLhGZO09hBbi8MSUh2TW8xsxk2tpoV78E62NVk8lKjuFsUHX7clIiTQjCOJ5S25c38Rm/juIQ7urcwP8k8m41Az9X05EU9wXp5iYCX6393UsdvFq+OzqSw2gWWzrp9C+pCUuxvLzXEbFM9Nb9rMFD7ScB4UShy1tAwGDbm6vpUS6luLWYIqHIPGFjfXqHtd2K1Yg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(10070799003)(7053199007)(22082099003)(56012099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlYwMVA5U1piMy9ta05leGJ4V1lhMnhqUjJjOEptZTVFY2lzbDkvVWJOQ0Nj?=
 =?utf-8?B?TmJLMUY2Yk5lUTgwRFRGZk9zck52TlFPNnZiS1BuV3hSMWtSTDVXa1daKzE3?=
 =?utf-8?B?SDNZTCt6cEowTytmZUxDNWMrU3hQWmFWb3h0WWlMMUZ5U3lRUTRINWJEOWVL?=
 =?utf-8?B?OGpJRjRnQjJzZVE1MS82eGFTdkJlbU9nbnVVV0hXVWwvWXFJTzVoZWtCZTVo?=
 =?utf-8?B?MTdiTVRLVW5veXlMMGFLbkZCdWdEYjdnZnh4VEdOYlVBYncvcVNKNERCSEhl?=
 =?utf-8?B?OWxDYmJRd0dpMk1xVDhxZjZ5aUEwYnFjMng5T2VMVWcwM0JnK1d5Y3BLa2t6?=
 =?utf-8?B?cUtockd0Uk9kN1ZGand0WlFKdVVlNnhWaUYrc1RaSGY3NEsyU1REVzBEMGNI?=
 =?utf-8?B?c3g4MWxKc0t1NHk4L1IvUndSYVVDc3d4UWNSTGRWRHoySk90SnBQV1lrQVhw?=
 =?utf-8?B?MEtGTmwvcm9PMm5oT24ya1Mrd0ExaFZFUXFmVXVobVJpcWMzMTBtZ3hZVlR6?=
 =?utf-8?B?QWlaK0g4NU9IdlRNNjRqMExZRTBuUExVTDRzaTFqUmszbk1OYXpiUitIOTh5?=
 =?utf-8?B?M3JPdWpJNm13Wit1bVdDRk9ZSDZUcWM1ZkpSbXpvNURGRm5jM0JtSW85RW5I?=
 =?utf-8?B?dVVrWmtwMVRYU3U5TmFmK3dha24vYWNsZks0Skc2QWZlUkM2Ykw3UXk4TDhN?=
 =?utf-8?B?cTNwdUlMYjBzT0diZzY4c2xvb0FuTmgzZSsveFFLVDgrK1dTZytlSXg3Y2hk?=
 =?utf-8?B?Si9tcFFSNkRmelVBdVdLTUdMRTRHeDlDU2dSZkZac0pTbjRTT0p5eGtDNUxn?=
 =?utf-8?B?NjNFWlRuMWhhckhYMDdWQm41RVhpeVo4YnFxRnB4V1crTUEvbnB0SzFiSDFl?=
 =?utf-8?B?Z0luRWJsakg4WmpBY0tkbldxVEVwdmJscC9sa2xSdmtUclBHeXM3bWpYbWNG?=
 =?utf-8?B?eGFpWFFPNVZyT1QxdTlPazJaY1JqUkI1UHJybmlCa1RuZFYrVlBEek5jMWxt?=
 =?utf-8?B?b0lLemtqVEVDakt3QjVDZFk0czF1RDJZUHJvK3JRRzZ6OGt4RnBwZm4vakVl?=
 =?utf-8?B?R212RU95WWpGSURSSFVMc0NkWFdVWmZ3dllBYytMRnJWaE9QUU1uQjFGY2Zh?=
 =?utf-8?B?SW9uMkt4dVB1SlNyMjNuU0xmdTlCWkRlb0NwOWNaeDVtOEtPckJDY3lsa2Mw?=
 =?utf-8?B?ZmR0bFh2ZDZyR1U1aGJ2bk5qdUc4N1E5WmV3SU50SnpSNUkrbU5UWlAreDgy?=
 =?utf-8?B?WFE0VVNsbmVGN2xmZHg1Z1hUTXFna0FnNitjcjVqZnJtMStpMVlhckZSd0hu?=
 =?utf-8?B?bW5wVGFTOFdiMmxYRDhNaEJLQ0lNcFhaa2xOMTBvekEzVE9PRG1oZTNzT0cx?=
 =?utf-8?B?RTEyOEZNWWVHbFRKcVdFaDZ6Tlgva0NZZm5lcy9hZUNBZkpraFYyNGZrMjZV?=
 =?utf-8?B?cUZyZ1FXdkZKL243d0VTZVVDeG1lN1BtN2VMbUZtdW9vVkV4amFxY0RGbUlQ?=
 =?utf-8?B?M0NUTXJLUVFXQUlXeTJKSndEb1BUYTBnTzZWNXI5and4MjJ1cEtxUWs1aW8z?=
 =?utf-8?B?eTliYk9VaStWUUR1MFkwVjBnbDhhSkx1NEZjYjNRTmdtVThqeGFOV3BkR3M4?=
 =?utf-8?B?RmpQUUVXT2lkMWFLK2pCY09GTkxwVG9DbGpvYnJiUTVETngrVzFKaEVYRGpx?=
 =?utf-8?B?WWptbm9zcloyNjRER3FTUzkwYURNZ3FNS3luOVZMTEMrc2ovWnlQVXBHeU5k?=
 =?utf-8?B?OUp4ay9ieEY3amRxNlFxNlVya3dRT0VUSHRTSDFZMFkyaXhtSE5jaU40Z1Fx?=
 =?utf-8?B?Y3M3ZjNodUtNV3ZVTHExaWcyWHhBWGk3OTh0Z1I4RXpXU1RUWUVUckJGV3dO?=
 =?utf-8?B?a2YyRTVhSnNHaGpwdXN5NkNDUitlbkl6Y0toa1FxY1JNMHYvSVM0aG9ueHRi?=
 =?utf-8?B?LzBRdjloWVpkTEpUN003OVlIOE1YMHAxdXF5T3QwSXUrTGdxZTJFR3JvN2dT?=
 =?utf-8?B?UGRhSmxxWkVIVWVJYXJBNUltYnoxc1cvQXROdlJnUkJBN3VnVW9RWUljRllN?=
 =?utf-8?B?MWFwK05vUGkvVjJpTVJmMUh3Mkh6eDFaOGVjK3RvT1FLbjFlWkdvYm0rVW1R?=
 =?utf-8?B?d0VjbmNyTjJLSnpXaE0wdWpxWm9RYWI5WVYzMVpRS3pJanpZNjNrQXMvZ0F6?=
 =?utf-8?B?UXpYK2pMZjQ1WUREZ1NJa1RaeXZOWThwRWwyVm9XSmZPb1lvZVpxQ21sZzBT?=
 =?utf-8?B?RE0vVk9RVFUzeUJFMzltb1pNOWVCU2RNT1NlZTJzR1FpS1RmaFduQTZibWhu?=
 =?utf-8?B?WVRlK1VLMkMxLzFZczVpZmZJZnQwN2ljVEhzU0M3cjVMdk9DQjVtZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 181f8cc4-5e66-4bd0-0138-08de8779a846
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 18:42:51.7830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqz3Cs0ivX7ovjmHpaxtxhE7x3dyRbT2/KDFcm0Nu5ajzapnkZpj+kaoKcU6P2xAUO4OUr5nIzfiu4fmOJl0ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5748
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227788-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,collabora.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD8FC2E6D5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Mar 21, 2026 at 5:27 PM GMT, Danilo Krummrich wrote:
> When DMA_ATTR_NO_KERNEL_MAPPING is passed to dma_alloc_attrs(), the
> returned CPU address is not a pointer to the allocated memory but an
> opaque handle (e.g. struct page *).
>=20
> Coherent<T> (or CoherentAllocation<T> respectively) stores this value as
> NonNull<T> and exposes methods that dereference it and even modify its
> contents.
>=20
> Remove the flag from the public attrs module such that drivers cannot
> pass it to Coherent<T> (or CoherentAllocation<T> respectively) in the
> first place.
>=20
> Instead DMA_ATTR_NO_KERNEL_MAPPING can be supported with an additional
> opaque type (e.g. CoherentHandle) which does not provide access to the
> allocated memory.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ad2907b4e308 ("rust: add dma coherent allocator abstraction")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/dma.rs | 3 ---
>  1 file changed, 3 deletions(-)


