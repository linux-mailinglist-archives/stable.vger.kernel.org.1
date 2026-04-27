Return-Path: <stable+bounces-241364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF+pLj+H72ksCQEAu9opvQ
	(envelope-from <stable+bounces-241364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:56:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F4475B7A
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9590C306BC7D
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5733F5BE;
	Mon, 27 Apr 2026 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oUr5/ptO"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021091.outbound.protection.outlook.com [52.101.95.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143163370EB;
	Mon, 27 Apr 2026 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304595; cv=fail; b=kDph1qeW3u1IwaBivce4RBS2bHkVdfEcI1O6oMxaHEo2M1BhfR5gZnFSSPBFjYgMIWXESykUIvvQ8ksi3UZEuhRnpLaBAyP3STAqWL3efqrvfRVB4zH7GCDAWtO3X8E6BZjsax3QUJOgsM/M2kgNikJbk4fAUgdnFIdYyBr/5oI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304595; c=relaxed/simple;
	bh=kY3RzqRFp56wXDcW5mFRDjlfo15G6k05By1dMrFL/DQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=gjG/sNkGsmj7OpyffX2F9wj1lz0u8RnxM+hmp2dcyVrE11wBMCPTts5G+CWESa+w67dX89RzYiGseklurmfj/4LcbxmdVxpew1l6TKz9HoWFpy8MeLMNS/nr/cIUP6UaiomRyJtjDtie1Csvip30VgtRzv2qYufGMpNr3WUjSFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oUr5/ptO; arc=fail smtp.client-ip=52.101.95.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2SolJwGqWM7KOVo1kqT1d4Rq9XfH31J+SRPnpK6C2GA6hyCIjFGH/3rwni15CZzq0IyEVU9I90rRZJNlaapKRHGQE9NVRBhuxkNcWIYDzhoOY8QxzJJR3Prdfqtch1uJ0Nx3UlHJovngM/jx5zTAcOfjdsd2h5NmjYpRApk2Dd8VkNqvV4OwQVseQ6q7VpWuqG0QNTHtaBzLQu+RTVIIzuVu1U7sumtBsgQLBdNDrpFV1WGBEAaKsfeVHXNBYQNteWavkFQXRkyHZz8hXdeorEuAe4gNDpcfjRtiQXvfUJe+Er2szIhDINpJeUYdMofCRs/eE7833S9GGUAPSWveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH2fapYLm/B3wKw+CO6DK+ziX55sbwH1AYH55ZQClGY=;
 b=XDzxe61BflNXbnnewxrbl48Vz5QR2tAQEN2qbOXSS6njjAplXmufMZri7tsDWfLbU3CbQNF7Y/os/Wswhy6EBUVWu3erYEdGptCG+FoLss9ksiwGna/WahH+JVo0rlpkqwwccKCK8WQ6N/nDLYd1rRylOIED4+ygK70JZvI4faEEV8o5CFjR7WIUjP9+ftyQ4CFy1iatEV2rgygPQfFYfHEqXnGOWFD2jtlVLHJm8JtyIUPWZ8wPFiRv+2X0iiPVJyNpL44oSPohbpoDCgLY9rA5xIeGDU+b43KaHINyIUF0IMNnMqnKHzfSwRe6A0uS8i3MR4ik4aBk/ftfMgyafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH2fapYLm/B3wKw+CO6DK+ziX55sbwH1AYH55ZQClGY=;
 b=oUr5/ptO47eSEWoqjv37C3JPdlIIjNp7qlgWUz6QLeemrxnFDCTGH91qP9JtEXi6B4PB9gdb6UqoPBmhlKWiGB7D6zOcRgyxbA7tjF/QMWQ6DUAX1aE/aQskSK0ckJs1XZJQwLM+Hgn5e22YNt2kLwfuVU1kqNwVdW6IzD056M0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2114.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:43:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:43:08 +0000
From: Gary Guo <gary@garyguo.net>
Subject: [PATCH v3 0/2] rust: pin-init: fix incorrect accessor reference
 lifetime
Date: Mon, 27 Apr 2026 16:42:59 +0100
Message-Id: <20260427-pin-init-fix-v3-0-496a699674dd@garyguo.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAOE72kC/3WNwQ6CMBBEf4Xs2TW1JRU88R+GA5YtrIdC2tJIC
 P9uwbPHN5l5s0EgzxTgUWzgKXHgyWVQlwLM2LmBkPvMIIXUopQKZ3bIjiNa/qCxpa5Nr+29kpA
 ns6ccn7pn++OwvN5k4uE4GiOHOPn1/Evy6P1RJ4kCiZSobqJWnaBm6Pw6LNPVUYR23/cvOmfNU
 LwAAAA=
X-Change-ID: 20260423-pin-init-fix-cf469cd6f782
To: Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777304588; l=1702;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=kY3RzqRFp56wXDcW5mFRDjlfo15G6k05By1dMrFL/DQ=;
 b=rRVX+lJ/ooidOjpRfXQ4x/C3kBlDOFLJGIItvUZQ8xn3KMji3geU6DxOyKJE2+3Aw1oEu5mba
 7RB3txwqZpyDApxAEhQbHhRunsMXYhOkTIm91aUGq7FThP7cTlImga0
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0224.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2114:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d70c8f-5f5e-4af7-f1b2-08dea473ae44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V1U6jlWXEqHjRbWAgLYwaSB8ghFTMTwnGgCYtl71sGL+aj77QwhKs/6EMUlZIAypGNjH090aonWc5ELXGX35+a+l5GVHn1pDI39NuUuNxJrz9RmCI6VYgZWb3sK9OPaouAdUYwHDFKKLaHUi6TMAcM4VuBXlY5BIB3L4uimpsBDNg02AxA8AGFZe8ZJC1AMk+ZQFqqec/RHxGMqaVAtktX3X47TlgdtKmt4jXTIx0/x1M0R/1HQ5S6XEy/b0ySHjTp4PAdREUlWqrmSulc1zlO1lSpwZ1LtA7vTponL0NYhLfDUwKt0zrd6PR3V0I+jiJ3Aeb6sImMKtHXb+f5ZlID+Hhh3LB626aP8wsB03uPdlVWOlVxpmzg+RjIAEYY4L6MpqFzTWW7PZ2TqfWNN+OQK9PhGA2D2jlOsW/9kuNBF+y1QN/7t+CfBdMBa2eanX/ogHr+kFO6H3QJUom3V+A7Do+KpHzDGOxGXm82eMY+rqiQpzXn21wvxLJzVpvf3Kl/krA6CR8Sp3tnshdDf297NnAiCKzXaNOvF9nPSm6vDMFA+/OvSE/HyWSKsjkhHHhT8Mi67NiIy3igCEzYGJd3YOEyWzLWQJhWgZ/Ac1ooXFgGOsoJpv6/a4zXdKRpzbUtwtgY+X2bH6l3nC99ZxLgOToikvv8ZvKtxUJ5vPg/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anREbHF3akJjZC9JQ09rR3FuZkJzdVNmbVMrNEpkejNMbmk2bTVuME5jTHBk?=
 =?utf-8?B?cWhJbEFuUkhRVWJ1cTZQc3RVUnZXSzROa0NSKzRYNnhEeFZ4Z3BBbHBpZW02?=
 =?utf-8?B?a1pkQTdlemVPbEdGWlhFTmlNVk5mNjdiRmxSa0s0THRqRFEwVHJxS0VYUlJG?=
 =?utf-8?B?VGJETlJCUUN6OHJhQThkZVFGZUhMRFBxOEhNLzBlVjh1YlRGT1NhMmg0VXBK?=
 =?utf-8?B?bklVeTJGc0FHeDMzWDR3Y2s1eTE4SjZYVVF0TlV1RlRoU3NTM1ErV1RoSFdl?=
 =?utf-8?B?M2owZEtmNDlORjB0NkdENEtkMTNNbTZjeTN5bi9uclUyWjNSSGtCVDBMRVI3?=
 =?utf-8?B?ZWgwT3Q0Y3FqQm1hdWVOQ1c5T2VuZ2lxY3B2YTkySUVEQU42Yml3NzdpSDNi?=
 =?utf-8?B?N3gwWjEybzhLNlE2dytCdDV3QUNLeWFZeGk5SXZBQU02Y3h6OHExbEZ1Tml5?=
 =?utf-8?B?Qi9HZFd4TThLeU1VVlI3TUtVa1lMNDM1cFVLQS91V2UzUHdXWWY5LzZOcWhw?=
 =?utf-8?B?QSsxSHVubytnNkxwdjdGeFdybEJiRjdubERQK0hzVVZFcnYyNjV4bmlrS1Nx?=
 =?utf-8?B?Nk1kWCszaVlaU1IyU1hXY2JoL09haHZxaFpUUzBPcGd3L1g4Ry9BTkdUOWxS?=
 =?utf-8?B?MlJRQzNMM1JFSC9sN3MrMk1oamVEZXhCV2UzaFNSaTU1dTdqeTBEcERsWHgz?=
 =?utf-8?B?NXhlVGV2d2pJUTZMTUQ5NkRJUE1GeDY1Q2xveGJsbEE2NUFwRFFKY1VydUtF?=
 =?utf-8?B?N1JmaURDNEcxblFPayt4VTNFM0ZQNTRWblFVeE81dWVUc2s2QllmWjhZTXRY?=
 =?utf-8?B?K1VBME1OdkJJdjFRUGsvUkFqR0hBUXdkMkltQ0xBVmdEWE1rMmZhTTBQWFZw?=
 =?utf-8?B?azczb2hvbFR1cXhPNHpiWC9Bc0x5c3o1T3BZNkt4dUNTT3hiN1l0MFpGM0I3?=
 =?utf-8?B?ajc5QmErT2dlb2Qxa2Y4UXdsaXMzQ1VrNlpWUC9oNmVqSEx1djVDNXBiV2Zs?=
 =?utf-8?B?SEM1TXRJWjI1eE9ENVZLazM0SmtEZTREb21nNDlZNjJrbjFDamVObXplaXl4?=
 =?utf-8?B?T0lxSm94TGlscWlXSVBpN2dnZ25yYkRxMDhtZXFPeUo2ZFlBRzZ3a2t6SEda?=
 =?utf-8?B?b3dqM29MUU9wWHFjdmhhM2NxS1M3bW1EUUVJMVFkZzkyTnBWNXgrblVOQUZI?=
 =?utf-8?B?dTkwWUNFR1lnS0ovVXZ2NXdDUWxRQituY0RxbVVhKzBxU1I3S0ZqU2ZWVmE0?=
 =?utf-8?B?WHFNektCN0FjTWRQUk9mNElvTWh5RWZZV09CcDJtUEpaQmR1Yml3aTdsVndX?=
 =?utf-8?B?QzJreFBLNDNpMWtMUXlNUjNCaHQyRmxjdjIvb080dWxrbXh6dU5CYlg0RDg2?=
 =?utf-8?B?b3JtU2VCK2llbC8yQWZoak9qWXc1UzJDMDUzcGdPK2d1WHVRNlduM2VJc3NW?=
 =?utf-8?B?R1dkSlZESjNnTGFqSnVZRXNUS3U4NFFkRTg0aUhXcnhrN1dUSk5hZkhQajE1?=
 =?utf-8?B?bzlWUzFqTHVqR1krdS9pUnZZaFdyMHMzeS94V3FIcVVtOHhqKzZtM0JFWkR2?=
 =?utf-8?B?SXJjSmM1ZmIwTk42eVpTNjRjZ2NwR0lJM3pWYUsyYlE0N3BaK0txdVUweXBL?=
 =?utf-8?B?VDMrYkFFNk56SHNBZVN6YkpvZkpEcUpoOVdOUlMzS0Q0aTU5STM1d0grU0lk?=
 =?utf-8?B?alNmTHRnMEVGNXdCUmE0dklKNWNQUmQwZWJQMFhqVXlCQlBRZ0VkYWRFSTVi?=
 =?utf-8?B?WGZkcnVaN1lkZnIwVnJ0MFp3aTNrcFFxZU5ITG0xRTVzc25keE9SbFFFKzYw?=
 =?utf-8?B?OExDODJDeXpqdlNVbTIyYkUrWTNnbnpsaytaSFcySThiVEsrdW55T3pzYlJE?=
 =?utf-8?B?cERZa3EvRWhZcGhCYjFHd1pYS3NnWnpWR3NwTUxOTEZiVG90Rmg3UnFtb3ph?=
 =?utf-8?B?OFpsbzg3Q3NINGc3UkdtdVhkZlcvelhiR1k0Y2F6N2Q0ZG9zYUo3T2pTWDR5?=
 =?utf-8?B?c1FoeHZYT0d1N2dGWTByMC9LKzBqbWRYcFpjZ1RmSk1wQzhrQ3hnZC91cTBN?=
 =?utf-8?B?blhpQ09VMzFjaGJMQURhNVZvOHhGK0J5YmNEV0JZRGFhelY1MnpwZ1l3MTl4?=
 =?utf-8?B?ak5JbFgxOUhra2RSZVRHOTF5eDZoMFlhYXpLcXZNYkN4VUxDL1B4d2JwTk9a?=
 =?utf-8?B?NG9jd1BxT1c0bkpJSEpGeWFSbFQzcHg2eEdkZ3IvZEpwdFhKT2ljOGpxMHoz?=
 =?utf-8?B?aFRUejhkQWkxLzQvakJ5bWR4L2NOTGxrSGVnMHpNQVJLV0o5RGcvTGRmL1Rl?=
 =?utf-8?B?c2RIMGZLTEYrR2xnTkNGbnozU3lmNVJMRGVvQ2hNcVdwVWdLZjZ3QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d70c8f-5f5e-4af7-f1b2-08dea473ae44
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:43:08.6027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLjKBf1H0XNKiPXCTtCXbPFGXj1ynK3h/3goiEA0t8p22avowPXYJQxO7JW0ZmvKDUP3cDuksXfkOVIhR5x05w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2114
X-Rspamd-Queue-Id: 3F8F4475B7A
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-241364-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]

When a field has been initialized, `init!`/`pin_init!` create a reference
or pinned reference to the field so it can be accessed later during the
initialization of other fields. However, the reference it created is
incorrectly `&'static` rather than just the scope of the initializer.

This means that you can do

    init!(Foo {
        a: 1,
        _: {
            let b: &'static u32 = a;
        }
    })

which is unsound.

This series fix the issue. Details can be found in the second patch.

---
Changes in v3:
- Reworked `DropGuard` to still use pointers and related safety comments
  (Sashiko).
- Link to v2: https://patch.msgid.link/20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net

Changes in v2:
- Moved the field alignment check as the current dual-purpose reference taking
  for guard and for unaligned fields cause trouble when refactoring.
- Use a method instead of `DerefMut` operator as we don't need the `Deref`.
- Reworked `DropGuard` to use a reference to capture the safety invariants
  (Sashiko)
- Generally improved the safety comments.
- Link to v1: https://lore.kernel.org/rust-for-linux/20260420172302.1843752-1-gary@kernel.org

---
Gary Guo (2):
      rust: pin-init: internal: move alignment check to `make_field_check`
      rust: pin-init: fix incorrect accessor reference lifetime

 rust/pin-init/internal/src/init.rs | 184 +++++++++++++++++--------------------
 rust/pin-init/src/__internal.rs    |  28 ++++--
 2 files changed, 103 insertions(+), 109 deletions(-)
---
base-commit: 97e797263a5e963da3d1e66e743fd518567dfe37
change-id: 20260423-pin-init-fix-cf469cd6f782

Best regards,
--  
Gary Guo <gary@garyguo.net>


