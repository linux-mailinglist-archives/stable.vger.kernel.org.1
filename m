Return-Path: <stable+bounces-241025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B1TKSvB62lLRAAAu9opvQ
	(envelope-from <stable+bounces-241025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:14:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AD462BC6
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66F00301227C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7694F3FA5D0;
	Fri, 24 Apr 2026 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mQjXiei2"
X-Original-To: stable@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020076.outbound.protection.outlook.com [52.101.196.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE313E5EDC;
	Fri, 24 Apr 2026 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777057813; cv=fail; b=NjN/SC1uPvUqpdPEQjoEVqqRRUbJA6VvDQHplcHlBbYoGg1srvR+1B7Z4cjH9e0cygeD3mMTf9ZuHu++Ty7gdRSLLvlJ1qeDzgKVGRmFBfGOECRqhGWo+GZcIzJEUYzqM8Kvd+V3bWQ6988LMGblRAmzxlffxjyL1agoW3OULHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777057813; c=relaxed/simple;
	bh=dHj1QMHOYxWleKZs2Pist2kV1RFfqM97Azi6fDoJ/NY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=pNTSdgUGuFlnbayUA09CN3I33Xy5GtEjalZwnEUZjTNzrkK43NkhmYmnuk/6/T7a04N2ghCVg6aBmPBRzbMK7l5fv6we23ZGQeLOFcWn1X5Wt7gX8IlVGGcoPE5n67h7/J9sQEiADnfRWMk07hfTWPJQXS3nZnjaPZ0Al/AH3e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mQjXiei2; arc=fail smtp.client-ip=52.101.196.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxRLHwA/IA9uvNm7DLGecj/ooghKUU948AsraPnTIMPSO9Wpzxoz/O/jNKYV/huNmMudMt4MHTfJjv3TcYNGvreRDh/XAdvTO+2gKo7TMxi2tJ+ndzfOu0Yhnbnq+B6VmGHxalr3/A8MgezdUnjvPc4qr2+NUmwi3V/SU70s099G1naOo+ivOAACZ7DgFV1cdg9tOoyCQ+hsys+k3UehdEV7m+r7vp9KAdDNgDK87nyrB3y1aasEbPqLRjvySell+5jLqFX5kqu/CGF0svwpDnCeYaOOxnL2WJ/CLdfJk+ovxTn3MpkSy/kT7G+c2wqpi/7bd51Ah6fhg+26jEHXUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nlx3W51ClrVm4nKot7thkjf0UhvU3dYLh6+sHTdC4Ug=;
 b=Jnv1f3w8BdLMWReDiWk43AK+eZVnZOL8M+rII1MekyI8wVDnrZECWKJKuLrSRSbVM854XEurMgMkVZBr1I9qRaK9rr9wnTXx71E/srWGQZFPj2aeESHF621zrQa2eGOuxQG5brDKwHwhurvzf+3lAmvzqqp6Ku72kZr9+L5rl4Rra6yBwo6UaP1GHPHhywr5V/IL4/5M2dgow0nktXN/rDeaO5RQrOaLGKq4os1X1OPspzvvg49lDijF1jyBTTGGM+8bv4Fu4DACu1Bcci8upkWT0N0rO+yfZwUFV8rY8ZZdrbSb1U9BvhauEgSZYWfgtfNN9PTwwk5W5mR10xVbmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nlx3W51ClrVm4nKot7thkjf0UhvU3dYLh6+sHTdC4Ug=;
 b=mQjXiei2uVMVyvbhql5uSUkJbqRSh79gWoIR8Zij4nYTQLAFtSNcTFKK3pdUMhZqXybBR91F5a9mUccvW/8KXLVFOwIgYnR7OFCxIOi0RMvcmZbBkbpOhlLz4/F/om3Ov/qj+ZBxW8DCDbeeyflpRUGkc9sDN3Z3SRbgtVkxPGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB5899.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 19:10:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 19:10:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 20:10:06 +0100
Message-Id: <DI1MF28YGPFP.IMX7LYPV6A8L@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] rust: pin-init: fix incorrect accessor reference
 lifetime
From: "Gary Guo" <gary@garyguo.net>
To: "Gary Guo" <gary@garyguo.net>, "Benno Lossin" <lossin@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net>
 <20260423-pin-init-fix-v2-2-ee3081093a0e@garyguo.net>
In-Reply-To: <20260423-pin-init-fix-v2-2-ee3081093a0e@garyguo.net>
X-ClientProxiedBy: LO4P265CA0276.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b14b14-e4bb-4de6-a7c8-08dea2351909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099003|22082099003|18002099003|11006099003;
X-Microsoft-Antispam-Message-Info:
	xQkaFNpwYXxGzghEe8dVI4EdJcOXRTntnOcKjVHKKA8FS4fINgxaJAWDCIIlqn39NLoNjYJfiFb49UK1viWA9MJinf5xhMmorCW/qxF2A/+WfUDrh4f3Wfjd/L3ryiX9ZScfOCiWtesObWBfzh9CkeaZkjDXHqWcN4AoIIpjOgMoPQdJzi5PvBX3QtSj6V6DBQdGbLqV0i4TY+prAHkRvlKru6r+E+h/Yy1mQPAMKysXEUc8um7ulR9JBOQPDjbHXunRXGV8qQFXxqmOMpcWNas3D8euj/P4188/SWWEnOYtWW5zXpss65rfTXQYEAHThmqYblKYKgDXoW8CByjXtzLdxhtJrDdZCgNgv5FlnWanonlzsyIIrBwexnvTkvnPMFbUYCrw0hZFp3X/4PNUmx0dgAPkf+Y6vjpexDwJ4bBfDBAW3zjSleOFXPDMsO2+l3uGe25F3P9niBOBLxC3euO74WYcKgjP2NHH6x7SZMsCmfDLoDL0fXDj+1YtsPI/WClvhTWsAxBVFJqBtEe4M9/N7MQ5GvmDZTRIPONgEpIjenONqYhssgAjAcjxUpghnyxbsaKDs0aBpaocZ7R7A0C1V6lPatBGw7CykekC+6a+g2EsfDNEGt8fXThWj1jMOdt5bfxd7lItulVWEjF/7he4KxEej+dy001srlbZ/XCUw0rmQYpitou0rVtwKg+IPk9CPdHOSCGShRoIkSiyaP+7QsbEQoax68qU4jmzZW8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003)(11006099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjIzQWJ5azlpZ1VHT29EbWdiQ25LQjFjM0hhU0hBZjN5UnlOV1k2SjR1Q0p3?=
 =?utf-8?B?VW80VGZOM0pmQXhLYnZJTUlsNFVsNU5keHhtaXliYnVGRk5aeERocngvdWtT?=
 =?utf-8?B?VzZkQ1NvdVRQSnZaUmJLcXY3eWhJckxnZ3J6OVlDcXJETlZ6cDFjZXlUWHlK?=
 =?utf-8?B?Y1NnVlg2RHZ3dUhrenVmRlh1aDBEZDV5N1V0TkJ6bFdJZnI4Y2xyUVpGQ2Zk?=
 =?utf-8?B?eCtlSFRMV1NxSGk0aHVib3JOR1RkQ3JZc0pIOWhJZHo1S3BVWHFNd1RCeHpk?=
 =?utf-8?B?cU9UMVpQdTd2RWRXSFdsWDJqaWQ5RW52Q1hGQ1VFd0JrUEFwQXZ5SkhXLzZ5?=
 =?utf-8?B?emJaRGJaWnhCQzhvamYyY2drak12OVJqcjRpWUdUVHpURmNxOFFTWTNGNVFH?=
 =?utf-8?B?QXZod1hhSmNlV1FqdEtiNi8zZjdBNXlXMmYzd1BTUkpjWnNBcGhpOFhYbm5C?=
 =?utf-8?B?Ujc2cmcwdHhObTByKzdYbU1palg2ZVJRb2oraXhtdHBSNlpoR0xvQ0JzNWNT?=
 =?utf-8?B?bzVWQ3J3MHVSZE43ZFpBVGZNVU1IcVR1cE9yWGlwcGVsMGNqSm1lemtnR3hQ?=
 =?utf-8?B?UUxaaGhxRDFTZmlxeGhJSXg0Y2VSbE8xdUNqdWhLVUVOS0huUHdGMmtFMDdU?=
 =?utf-8?B?d1dIQVFKT0s1bE5lc2pWaWNSd0krRzl5L01rMGhuZlBlMmFrMHg1amUwdnBC?=
 =?utf-8?B?Mncva2crQzg3cWMyNlkxenJHRTBEOXE3OElJTGN0TTJMc3g3QlRid21peUts?=
 =?utf-8?B?VmdnTWFVWmRKbDJXMGMrMHp6Y3pUeGt5b081dXpWUU9NcndQbFUwMjVsZ1h2?=
 =?utf-8?B?eWszVEpxWTJGcGhZQ0dlMnVBZFArWVNvSE8yQ1RRdkhSMThDWGx6K2hVMm9H?=
 =?utf-8?B?UVBWZGx4VVRsbUhFSzVzM2h4ZXBGYzJJbHltQVVBazdFUWxjSTBESVkrdEhJ?=
 =?utf-8?B?cFZoUU5BNmRGL2lIUnl3RXlyV1FEM3hQbDhBd3RVcmNVMzdEeUFRWnIxK0Zh?=
 =?utf-8?B?akxId1lSNEZmT2RHY1VlOGhnQXMzMWkvTExFVGlZTDZwRU9ZU2h0WTAra1RV?=
 =?utf-8?B?TTdMQ21MM1dQbU80TUM5S2hORmFISm9KU21IVllxNFMrTVM5cXQwbVpRYnJt?=
 =?utf-8?B?Y0RZSnBFS0JaVWFqTUlpVXVtSityNHRmTXF4V2NWOHozMDZTNlFTeTVIOGRM?=
 =?utf-8?B?K1Q0SEFYUkcraFJ5N3J6a0dTbTRhckkwY1lHMkVUVjVkWllYYWhNd0wwZUVt?=
 =?utf-8?B?QVp6T1FsaGFlbXlkcXdGbDJCKzI1eFZEd3lKdmRjd2FMbmh6TEVYU0FmdWVP?=
 =?utf-8?B?RTI3dS9mdTVEdW9STURzb2wxaXpEZ0lacUg0V2x1eWFBNTRJRVhYVzhtdUV3?=
 =?utf-8?B?RFdDcE1saGdmYXF4QzJYdjF2TGZISnRXNVFHL0dCRGVqYXN4ajlYaVRndEhu?=
 =?utf-8?B?d1l0bXhHZXJrU0lEa1hFaklnN3dpdGpiZGRPSktncWhqNE15anBCTnRHc2VJ?=
 =?utf-8?B?WEI1a0ZSL0dXZ0hvWHNRcElxdjNzTkdzZzdHR3FodGFWVXlEdWpFRWoyWG1Q?=
 =?utf-8?B?MzM4WHl0WWd6cy9lVjlwRG1mZ2ozR21rbCtDZEhmRCttRkp3bHF1Q3RlbG9p?=
 =?utf-8?B?emF5Qllxa1ZPbEIwNkluWU1mZ2p6NC9xQXRISFZyTU9lSzJ3RDJOazBoVFVn?=
 =?utf-8?B?NXBwMDZFc25acS8vMDNXK1RsMTd2eTVPQ3U2SWFKN1lJd2QzVm1UOU1VMFRB?=
 =?utf-8?B?S2NBSGF3WTZGQTUzQkM5VFBYTlJRcHJlOG9YS29ya2poZ3J1clNnRFluMXk4?=
 =?utf-8?B?VWIrbEFablhRYzNCb1JlVHZoRFRFd1JxbGYySVF0RC8rZXJybldFZXh3b0ly?=
 =?utf-8?B?a01SblkrNlF5aVd2cWNROHExWDlrOVl1K0FiekRrVlRIVXloY1VzdEpHMFMr?=
 =?utf-8?B?K2tSb3Vzak5kYjMra2szU2NPTDdvSkpZZmhVNzdRUjVtcU5kaTFBRnRWSkJo?=
 =?utf-8?B?MGdZLzZUNnVVdSt5cnZCN3dRS3hya1hhTUl6T2hhNXJCV0YrcWdVYkdGaFNS?=
 =?utf-8?B?Zk9TanlZZFdwZW5VUXFuRE4zRWMrbjkrRmlKWjNVSXJjMnJKR0V2bStBUVRt?=
 =?utf-8?B?dmZubGw4UlpqVzBySzF5OVN3djM2ZzRIdEJlcG0vbzJrQ1JjME4wTWFuWU9v?=
 =?utf-8?B?clJMRzVlaCt2cmVJQ2ptSG0wVnM0SmE3WVl2SHBXVzdneFM0NGNHbmJ1ZEY2?=
 =?utf-8?B?OVNSLzYyYy90WXZnTFRsVTVhL3hhNjFpbmhraWlSTlYrR3hnSHZMQWp5TzNJ?=
 =?utf-8?B?SWNjNFI0TERRN3QzODVFOG45WFFabnNzVlhvQ2lFcUQxaHF4cmZwZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b14b14-e4bb-4de6-a7c8-08dea2351909
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 19:10:07.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jt7dyMUBiW5BWka4jjp38sVOy0aJ56YCGISU3qQ4CmM9htMYRDLNHdJt9VCS+nAArJCbpd69tN/1yBZs6tEg7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB5899
X-Rspamd-Queue-Id: 083AD462BC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241025-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[garyguo.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]

On Thu Apr 23, 2026 at 3:51 PM BST, Gary Guo wrote:
> When a field has been initialized, `init!`/`pin_init!` create a reference
> or pinned reference to the field so it can be accessed later during the
> initialization of other fields. However, the reference it created is
> incorrectly `&'static` rather than just the scope of the initializer.
>
> This means that you can do
>
>     init!(Foo {
>         a: 1,
>         _: {
>             let b: &'static u32 =3D a;
>         }
>     })
>
> which is unsound.
>
> This is caused by `&mut (*#slot).#ident`, which actually allows arbitrary
> lifetime, so this is effectively `'static`. Somewhat ironically, the safe=
ty
> justification of creating the accessor is.. "SAFETY: TODO".
>
> Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime.
> This results exactly what we want for these accessors.
>
> Fixes: 42415d163e5d ("rust: pin-init: add references to previously initia=
lized fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/pin-init/internal/src/init.rs | 104 ++++++++++++++++---------------=
------
>  rust/pin-init/src/__internal.rs    |  31 ++++++-----
>  2 files changed, 62 insertions(+), 73 deletions(-)

> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__intern=
al.rs
> index 90adbdc1893b..c3fd7589fd82 100644
> --- a/rust/pin-init/src/__internal.rs
> +++ b/rust/pin-init/src/__internal.rs
> @@ -238,32 +238,37 @@ struct Foo {
>  /// When a value of this type is dropped, it drops a `T`.
>  ///
>  /// Can be forgotten to prevent the drop.
> -pub struct DropGuard<T: ?Sized> {
> -    ptr: *mut T,
> +///
> +/// # Invariants
> +///
> +/// `ptr` will not be accessed or dropped after `DropGuard` is dropped.
> +pub struct DropGuard<'a, T: ?Sized> {
> +    ptr: &'a mut T,
>  }
> =20
> -impl<T: ?Sized> DropGuard<T> {
> +impl<'a, T: ?Sized> DropGuard<'a, T> {
>      /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `=
ptr` when it gets dropped.
>      ///
>      /// # Safety
>      ///
> -    /// `ptr` must be a valid pointer.
> -    ///
> -    /// It is the callers responsibility that `self` will only get dropp=
ed if the pointee of `ptr`:
> -    /// - has not been dropped,
> -    /// - is not accessible by any other means,
> -    /// - will not be dropped by any other means.
> +    /// `ptr` must not be accessed or dropped after `DropGuard` is dropp=
ed.
>      #[inline]
> -    pub unsafe fn new(ptr: *mut T) -> Self {
> +    pub unsafe fn new(ptr: &'a mut T) -> Self {
> +        // INVARIANT: By safety requirement.
>          Self { ptr }
>      }
> +
> +    /// Create a let binding for accessor use.
> +    #[inline]
> +    pub fn let_binding(&mut self) -> &mut T {
> +        self.ptr
> +    }
>  }
> =20
> -impl<T: ?Sized> Drop for DropGuard<T> {
> +impl<T: ?Sized> Drop for DropGuard<'_, T> {
>      #[inline]
>      fn drop(&mut self) {
> -        // SAFETY: A `DropGuard` can only be constructed using the unsaf=
e `new` function
> -        // ensuring that this operation is safe.
> +        // SAFETY: `self.ptr` is not going to be accessed or dropped lat=
er.
>          unsafe { ptr::drop_in_place(self.ptr) }
>      }
>  }

Sashiko mentions that:

> When ptr::drop_in_place(self.ptr) is called here, the value is dropped,
> but the DropGuard struct still holds the &'a mut T field until the
> drop method completely returns.
>=20
> Would it be better to revert DropGuard to store a raw pointer and use
> unsafe { &mut *self.ptr } in let_binding instead?
>=20
> The lifetime-shortening effect is fully achieved by the let_binding
> signature taking &mut self and returning &mut T, which ties the returned
> reference to the local borrow of the guard variable. This avoids the
> potential validity issues while fully preserving the bug fix.

which has a point but not totally correct as the code is not violating the
validity invariants of references, just the safety invariants. And since no=
 code
executed can observe the violation, the code is not undefined. The code pas=
ses
all Miri checks which pin-init CI runs with both aliasing models.

I only used reference here because it's more convenient to do so (less safe=
ty
comments to write), but if the effect is that it's harder to justify the
correctness (and apparently Sashiko got confused here), then it's not worth
doing and I should just spell out all safety comments repetitively.

I'll send a new version with the approach reverted to pointers. PATCH 1/2 w=
ill
be kept as is.

Best,
Gary

