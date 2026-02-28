Return-Path: <stable+bounces-220063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBm4F9PXoml06AQAu9opvQ
	(envelope-from <stable+bounces-220063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 12:56:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0731C2AA1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 12:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5ADE3017031
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550C943C076;
	Sat, 28 Feb 2026 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZXd0sONF"
X-Original-To: stable@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020109.outbound.protection.outlook.com [52.101.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652602652B0;
	Sat, 28 Feb 2026 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772279757; cv=fail; b=YFpX+C95FHHfZMpiqlzUQtIW0tcRW1pyrz5t9Vyp+GX/vai0Wmvpzj9gSIfRFZ7YWRgwplN/gHXxsteGAYpEo6ZxFGSgs9R+zm7lPip6PSUp+KTsUug8b5tRKtnDSvy/EItlvMAgTena762A7Eg+3GXCWiBef47U3j5IdWTjc8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772279757; c=relaxed/simple;
	bh=MMptO6gVEEurNF9JriDQscVYsDbByN6NawW9cBQaH1M=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=qlhTdfNbfo50EWFAvZLnGEf15RR8/iTnjvQxhYKp9sTz4AdIjF78kJMH3p1/E3rbeDoNpDwlEiqDGc3eMWYStRXb0ifedTUTyLY/2RatlJSXHHo9TWAFMW1Sz8kXgEFpA9n56SSr0KnjNXPwEKpVqqWCs1Dhjy+cgUicSk0TYhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZXd0sONF; arc=fail smtp.client-ip=52.101.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyzO8+OHD///4pIJMZaV7HnkCTY7FNfZIcVCevdDhiOAm/eKnmvqGO1/wRtrK+sSthdYkOPCjDU7Heopr1xIFsUMsZ4NvEUBo5utolNBw59NiCMzqEooCATjRP7SHLbgmcSSmZMIDYApdbwLFvtTzCW6cWXXbQSk42rv8oDq6+ZuHppXBreEzFY0Hak93RzfV0NBvkbAxrh0ObL8su6wqckrLX4bUuEpWF88oksciu+HUQvrA2ocxQ2hKJKXoCekTOKnYf0qZF4FD7zi7KGT7Qn5NFrFRs78frHGXRU7Fw6hh/SyRQlNWiBaGkcYI+V2hyg+kKLe7miRFeTkT6204Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKrlxmpRBKglYMFBa6qdtgaW7VWdTCF+/qlvO+w3DXI=;
 b=e3nwtih4T5ohaOdbC0FLEk0BG7K84UcY986LPp2ug5Ji+brLsHSCztb8yHX0IlTBFejMM75/ZSJ6LS/UGr2AEjkA3uMUIbXzxq5DknEaKz66+gaSyuGyC+Ggn0vNCZUoZSkEqbE+0ciZl6L7Exj9Cpzog5JHGGSqWGAlBxUsjKSxZxvIn67nDgIBpkxbv9q5M0HmbSp1ZLG1y5KBuy3J8OYDsY7HcbrKfIySp9nCE30wNMeifSusfcgtUiSR+sF0VX2PNHQ8GOsRhv651mi2swLoJ7ncm3RWq+mKa5/tuDF/M+yX0InoGFEzkBdZtTWWXL9tjEbbbZLQoMomiNkcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKrlxmpRBKglYMFBa6qdtgaW7VWdTCF+/qlvO+w3DXI=;
 b=ZXd0sONFUyxY6Akt7rL0VpUGv0rCLbpdD9B5lfYCUxvYebmRAgORH4YJCgu/PFVQmUV61hZbh22yGFlo4O6N8TkJdH+D/f5gxMlcqM+jRzJVUWw1yzer+ZhSLAB86R7a4ZHExspvKUbQWlAuMENFxcUG1vDIU4s8JW16l/Ymdoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB2718.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 11:55:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 11:55:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Feb 2026 11:55:51 +0000
Message-Id: <DGQKQM3UOCTG.25ULNY22EYXJI@garyguo.net>
Subject: Re: [PATCH 2/2] rust: pin-init: internal: init: document
 load-bearing fact of field accessors
From: "Gary Guo" <gary@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>
Cc: <stable@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260228113713.1402110-1-lossin@kernel.org>
 <20260228113713.1402110-2-lossin@kernel.org>
In-Reply-To: <20260228113713.1402110-2-lossin@kernel.org>
X-ClientProxiedBy: LO4P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB2718:EE_
X-MS-Office365-Filtering-Correlation-Id: abac7576-6728-4196-ae98-08de76c05265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|13003099007|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	05bTXzUOH8PhbL+31qG1DYJUkRNFvjTEMI1CL4uBtWWVLbsgsR3MIEzGBzxz1vSnB6e5HDITCihdPnmifEp9WWOT2n2dzz5T7HPQ3F9WjIZPaJV3yKmsbiL8qvlVk0NgGA5/X0uhXngHtdxp2nGMs0Fdxo4has2yRGt3XElYIkrgISRYUfHFtEsA1gR74v1ZZ693aWerosRr2pEJaYaNMZEmGZixmnxtPqdClq8JuMgz7d0XJzFBz43r1mdFUJczE2LXn2/bipvZQ8FNUypQnUdm69F0qR9jXN9hLk9006RLJHEA+h5gfSJOhLGgNNw2sH8ALCSoD2SPvZglbroM2isL857Ec6bviDKHz6+UJW9DMgUhOk/30fdxTBC63yds+5yjlJJNzVcRwN9H0TUgCNWhTsVmNtYRrXHKXDZEnEGABPSyssuBzmojhPPeC79Ake6Brq0N+DRjGOF9CLI0Hs/moaPulhln2dpkYKqH6iZjERaC4SftJuMCsbnyXP99sKX0f20qeykI+MENsYurq7vel0xRMcuOMnSak31Yf2ZH7/Qz5VW1geTK8ZUEftZDjKkVAumHLr97nAmSWlwbzs1OYS00Zz0biV8+64oeV7l1sNpQoE4MyF2cAHsh7ZMio3qsjANUm0Lh8DddVQzReZaS8CH1pH/8DaaOEhc2wx/MryQGKnmwyiR6zTwKZPojfnbYG/3TJh5x3mvKDkcWbQfEpdtvWN/fkAFjHmdgbTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(13003099007)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWQxQ0tDUjREdXpLM1JtR3ovZ0Q2VHFJY3ZJK0U1S2FNQTluNUpQWkJLR1R1?=
 =?utf-8?B?Z3UrZG5mMDhtZVZRbG5RNUNaMUdMWlh2WDV6N1FvY040SnZ4T29jUlRudXU2?=
 =?utf-8?B?ZmhLeERBNHNBOFJUK1A2eU14QU9FNjVxY0g4OVE1SzJ0ZkUxMVRBblBMbE56?=
 =?utf-8?B?T3FTcDk5V0ZTUDd2KzlTbVd4ckZKWi9CR2VHL0kydXBxT0h5dEY0cTdqQi95?=
 =?utf-8?B?dUxMZUJyT1VlenlxQWZSeW9VWElQNklHM2JFOXVJNlVheWxyQlhLcmZUQnd0?=
 =?utf-8?B?MHdUNEdGYTk1TUJQbEhmZWl3VE9CcFgzdkxVS3U3M3FCUU9peHJUdVByQmt0?=
 =?utf-8?B?czlSL0VoS1NMN2N3bHoxUXd5VmluVnI0V3c1WXppRVFjRktya2dMV2NCSEtH?=
 =?utf-8?B?VXhIYytiRVB4UmxVMkxnUWx0SzNpQVJLaFFrNy9qL0ovaXVQdzZRTkpTUDc1?=
 =?utf-8?B?OHEwZXVxMldEY2RDSWZOQ3RLSDRuWlhNcjJLRjRqRlhQR3RBdk1KWjlMcGh1?=
 =?utf-8?B?OTNadkRzNytraE42OUdtV3lEVGZuWHdVWUpSbitXa2psMGU4U1J2RUwvSXN6?=
 =?utf-8?B?dVZJb1RYR003MElyNE9Wd1lYWTFPYVZ6UCsrMTBFQ2JZdkxSQSsvNjk0dWV6?=
 =?utf-8?B?Z29KeEdMNHFxVXcwb09JSWxkS2owZEQ0VGc3d3JJYVRRcnA2cFJhVUhhNjEw?=
 =?utf-8?B?QjJJMlU4ZFdhbzVhcEJwZGxVRmZKUGhIZE1UUkd3Z1lXVVRhcW1KcTlLTmVu?=
 =?utf-8?B?RGgzQTh3ZTNnUmlVbituMVhqZFZSdGxYMjBpQTl2QmE3TnhtSjlSV0JEMWNY?=
 =?utf-8?B?YzdDS0NyU2ErdUF0bGI0ekQ4QnhBZ1NIUWpjUllzQnF4TElMRjRJc21iSFc0?=
 =?utf-8?B?QUxXK1BZajg3WTBkbG9sbVNYcWdtMlBIMFQ2cUdmL2JwaGxyRXZCSGZYdzJG?=
 =?utf-8?B?YUphRVpLOXZ5V01RYVowWktvdDVrQkU5R2kyZjVJT2ZBNUU5cm8wdkkvQXRE?=
 =?utf-8?B?aVcxc0Z4SHBzMC9hZjFZNXQzN2UwYkZpc2pXcGR0blFwdGl6NjNndWpRbzdU?=
 =?utf-8?B?UjhRVGRTNmZNNFB5Ymd3aWphZFZCTmRaT0JQM1JRK2lPU2RqU3pxa0I0YnpH?=
 =?utf-8?B?ejNKbmptUHZOTG9qTUZ2R1MzVDl4TnRIMmVSY0hUcTZTUjBWWHN5VGVDd0hv?=
 =?utf-8?B?MWZyMDQvY0JUQ1V2RnFqdVU4QURkN0JSNkhpSnQwRkpIU1FublFYMzNkcm5x?=
 =?utf-8?B?RUVGT3VoUlNHTERIRTdSTG40MHVSYkRzTzE5RTU0aXBaZmM0Y1pBMUhCM2ZK?=
 =?utf-8?B?d0lIb3Jibm5lWmhheUNyVHpjYk56SGlRam9aUFdkbWdEWEpRTXZSWU5UdEhC?=
 =?utf-8?B?RnZSREVEVksvU2pnNjdMOURpVjhNZDdKQ0NicjRndzM0eFFFaTlIN0dSYnRM?=
 =?utf-8?B?N05MbW0ycWlGVGFxSG9lV0cvSTJEK0I5bXhnSS9jcWJCaWJveWhZcldiSml5?=
 =?utf-8?B?MGUrNW94b0VSWm9mUTBWQWJYakMyb2J6aG1yY0g4NFFhZkk5dFVrN1QrYjZI?=
 =?utf-8?B?U01KYUduUmRaSnEwSlE3dGhhanJwYmp1UlBwRTgvQjgxQWwrT1pkU0NqcnI0?=
 =?utf-8?B?YzF1WlpWWWdGWWxrMGxCOVhGdGxrUExJVFJOTWZIT2pEeWJIWmx6aFFPV3lo?=
 =?utf-8?B?N0k2TWhZd2NwN0U1QjlxVzFIRzJIQ2s0OHI0UHY4dHVOSEZvd3BWVWQwR2ZE?=
 =?utf-8?B?NGllOWxZeUd0Qy9YdkwxMWlCS01ZQkpZdmtpQW9UelFHQ0pMQkFBOS83VmdT?=
 =?utf-8?B?ZTRhTy9nMEhyYno1YjJVRm8ydVFBcE5jdC9XZHRYQ0ZXT1ArbDJpK2tyQlFV?=
 =?utf-8?B?NVNrazIwYnc3eFJFT2gzV3FydWV1R2IrVDA4dFBRbm9nSXU0OXBvaEN5M0V2?=
 =?utf-8?B?bHRyWjF4WlpTTzVoWmVCZFphdXRsMFNUbFJUVTkxd05wQmRoN3ZTZUllVjFz?=
 =?utf-8?B?NXgzUDFXTzAzUk1oZkRTZVRIY1B6Qk9jeXM5bG9tQTNwcnB4SDhGWGlmN2FD?=
 =?utf-8?B?ODBhcUdldUxuRTdnUEpIcldmaDI0bEgzMDJ5bFdMUE5pWnd5RHpNa3FMVVQw?=
 =?utf-8?B?LzhWWnl0RHEyUjZyVmZ2amdKcEc2eE50ZUdqRmlYY0ZlOW1Ra3FqSXpGV1Fs?=
 =?utf-8?B?Z0NIVXpocG5Ka2dHazJ6aElkOUJvUURIWUR4cVR6SWdxbzRxOEMvZ2ZoWXU0?=
 =?utf-8?B?MjlmM0JBdlgzT2FBcE5lWURBVzNmN2ZZMFUzR1VOeDRST1ZUNlRtcFpGdy8x?=
 =?utf-8?B?WHdDcEkxS2FMSmhrMnVLakZzU01EUlc2MWVrZ0UvWm5iM3lBVjNUQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: abac7576-6728-4196-ae98-08de76c05265
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 11:55:52.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SIkwBeZSfETXv0Kgme+HQH1dgkX3pL3aInaEiotJdyfg0DmOCWcYzdnC2eOBoadzsTaeaobdXWfnwofxuvysQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2718
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-220063-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D0731C2AA1
X-Rspamd-Action: no action

On Sat Feb 28, 2026 at 11:37 AM GMT, Benno Lossin wrote:
> We cannot support packed structs without significant changes [1]. The
> field accessors ensure that the compiler emits an error if one tries to
> create an initializer for a packed struct.
>
> Link: https://github.com/Rust-for-Linux/pin-init/issues/112 [1]
> Fixes: 90e53c5e70a6 ("rust: add pin-init API core")
> Cc: stable@vger.kernel.org # needed in 6.19, 6.18, 6.17, 6.16, 6.12, 6.6.=
 see below the `---` for more info
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
> As already explained in the previous email, we discovered an unsoundness
> in pin-init that exists since the beginning, but was unknowingly fixed
> in commit 42415d163e5d ("rust: pin-init: add references to previously
> initialized fields").
>
> We introduced pin-init in 90e53c5e70a6 ("rust: add pin-init API core"),
> which was included in 6.4. The affected stable trees that are still
> maintained are: 6.17, 6.16, 6.12, and 6.6. Note that 6.18 and 6.19
> already contain 42415d163e5d, so they are unaffected.
>
> We still should backport this piece of documentation explaining the need
> for the field accessors for soundness. For this reasons we also want to
> backport it to 6.18 and 6.19.
>
> Note that this patch depends on 42415d163e5d; so the only versions this
> patch can go in directly are 6.18 and 6.19. I will send separate patch
> series' for the older versions. The series' will include a backport of
> 42415d163e5d as well as this patch, since this patch depends on the
> `syn` rewrite, which is not present in older versions.
> ---
>  rust/pin-init/internal/src/init.rs | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/rust/pin-init/internal/src/init.rs b/rust/pin-init/internal/=
src/init.rs
> index da53adc44ecf..533029d53d30 100644
> --- a/rust/pin-init/internal/src/init.rs
> +++ b/rust/pin-init/internal/src/init.rs
> @@ -251,6 +251,11 @@ fn init_fields(
>                  });
>                  // Again span for better diagnostics
>                  let write =3D quote_spanned!(ident.span()=3D> ::core::pt=
r::write);
> +                // NOTE: the field accessor ensures that the initialized=
 struct is not
> +                // `repr(packed)`. If it were, the compiler would emit E=
0793. We do not support
> +                // packed structs, since `Init::__init` requires an alig=
ned pointer; the same
> +                // requirement that the call to `ptr::write` below has.
> +                // For more info see <https://github.com/Rust-for-Linux/=
pin-init/issues/112>

The emphasis should be unaligned fields instead of `repr(packed)`. Of cours=
e,
unaligned fields can only occur with `repr(packed)`, but packed structs can
contain well-aligned fields, too (e.g. 1-byte aligned members, or
`repr(packed(2))` with 2-byte aligned members, etc...). Rust permits creati=
on of
references to these fields.

Something like:

    NOTE: the field accessor ensures that the initialized field is properly
    aligned. Unaligned fields will cause the compiler to emit E0793. We do =
not
    support unaligned fields since `Init::__init` requires an aligned point=
er;
    the `ptr::write` below has the same requirement.

Also, it is not immediately clear to me which one, buyt one of the two occu=
rance
should be `PinInit::__pin_init`?

Best,
Gary

>                  let accessor =3D if pinned {
>                      let project_ident =3D format_ident!("__project_{iden=
t}");
>                      quote! {
> @@ -278,6 +283,11 @@ fn init_fields(
>              InitializerKind::Init { ident, value, .. } =3D> {
>                  // Again span for better diagnostics
>                  let init =3D format_ident!("init", span =3D value.span()=
);
> +                // NOTE: the field accessor ensures that the initialized=
 struct is not
> +                // `repr(packed)`. If it were, the compiler would emit E=
0793. We do not support
> +                // packed structs, since `Init::__init` requires an alig=
ned pointer; the same
> +                // requirement that the call to `ptr::write` below has.
> +                // For more info see <https://github.com/Rust-for-Linux/=
pin-init/issues/112>
>                  let (value_init, accessor) =3D if pinned {
>                      let project_ident =3D format_ident!("__project_{iden=
t}");
>                      (


