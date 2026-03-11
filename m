Return-Path: <stable+bounces-224686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCClHUxlsWnsugIAu9opvQ
	(envelope-from <stable+bounces-224686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:51:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ECA263E00
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 13:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 996A33014694
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F6253F05;
	Wed, 11 Mar 2026 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Z/zFeNCm"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022136.outbound.protection.outlook.com [52.101.101.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE7326B756;
	Wed, 11 Mar 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233481; cv=fail; b=YMDAR3luKvCD/nRLGR3XWTygVEjvzSuZw4oKEda4J3iUG4CtokYv9rY0bBtKNrOCU9qlTVhhjvEmZDqgnsg5or3eAbCJR2wChliyfJHtvdVzaaicNz7Prxw9v3IG7cGV61OnH+R6c8w/lc1nOH6UXHeIWmTI1veE9TXabTdRRGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233481; c=relaxed/simple;
	bh=4b7GpyRX+ODq2tUMuS0IVSm4ky3yVsjkjPMjVK3ES44=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=VBp1fLI0dQAntgqGxMjO2f634M8SX+UVNOYHdBqEM91u4Rl9F8aqPV+iR6Mdp56kZNFMGreCipX3mzvFovSkeX9SXNmjq9qJOCrIrdlnwNEnUTxDoXH7VGFtGZEr/D6MvlU7vwf0t7VjFFraW6Lh3vM3SRLW5xQjqiBVoH9Mk/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Z/zFeNCm; arc=fail smtp.client-ip=52.101.101.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xexBDu7L1fiQlVnOSx4dKUwCmgE95LWYF7FlGQJovGPNWh1xX9V7tZ0i6ZX3wM7sIa8LoaCECUDRme48K9uy86GpQHQBlHqzUgws16xg0qTcCxpNjfRkpOAChT/qDMuVJ3KZ0k2YdMdV/looUS9m2wijs9LaqFj9ljaW78nMQtd6jlU6T8DcD1U9ddCqH87WtPhIaAPtrDU4Lep13PkTnz/nAb5KwW0im+QjblVdGWX87ZMQyfKfV+PGPi/G1tRFyyHbg3VA8XRCqLJcWyEGQLPn+VKORPVQQPE65e8dUOLEnMAu0w4wtkODSQNx8rQw/3kIeG0sDy7/YJ5RPqLxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wirAHAaiK55HwRjeiVGTKenArCZ+WuNEq72QIag/kpI=;
 b=avj309wpLD//d2l1MLdkClz2A+006GekWu6cXsfeGaXpnMaoWMvn7f89WSInqyAvLw/rR3hvWwrE5uyHatEzw2VdrJL/lzGGOdvn+hoY0stMXdCETIWWwu+cZnnJ8PKbL4xVcB+8cGm1AkGeI6oSDRw1RMUtzfXQdR1NqStb6rSTIlJDSy05U2YhLJNQ2fUKmWx7KP9BYpdLbuCXqfXIDXdtu6uOFpYUlxibUF30Wsg99EiKNuxXhK6tRLqhC/DfpzhTdqRWBkpJxWWRfENjVLLG6//s+4Bgp5PUzBGagh5q8Rkyd0CEAARYz7wh9Uqc8R8QsnT+mnckixgYiDxVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wirAHAaiK55HwRjeiVGTKenArCZ+WuNEq72QIag/kpI=;
 b=Z/zFeNCmEvUdF8TIThhfIpGSltKY+2qAyvc8OFAdWf6sWpTvaQkaVvGDxi0H299M/hiaGPIYzrh1qmM71/Tyj5D5H7LzCChNRRSoEKOVy2vzxx96f52jnl2Ad6s1825VTuNb+9CX2pgCQLktGxgc3fKy3g0G+DqSOfzWmAf5Pgc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB5995.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:51:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:51:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 12:51:12 +0000
Message-Id: <DGZYSZBDNC6K.FG32N978X29A@garyguo.net>
Cc: "Tim Chirananthavat" <theemathas@gmail.com>, <stable@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: pin-init: replace shadowed return token by
 `unsafe`-to-create token
From: "Gary Guo" <gary@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Fiona Behrens" <me@kloenk.dev>
X-Mailer: aerc 0.21.0
References: <20260311105056.1425041-1-lossin@kernel.org>
In-Reply-To: <20260311105056.1425041-1-lossin@kernel.org>
X-ClientProxiedBy: LO2P265CA0101.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4a7e28-f6b0-48cb-22a2-08de7f6ce03a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|921020|22082099003|56012099003|18002099003|7142099003;
X-Microsoft-Antispam-Message-Info:
	yecECtaD7yD28r6MzelO3WamiSXJnWSKAnPD/oEirG8Ka04peOvAyGAC5YLqZbvzLMKt4c2JjUsjrZ3lY/kJyur4PEItc80i/3q9zmTeS3gh2r8yx7hIAxdX+dmhfVQMXSINLOqg0Rz6Sr9Oc1roa0Icj3KC6RZF3Ka1FG7z5E6/nQOlZE/ktgTJtKaooKq64Fi1vi4XlSemJfHntpkHCyjKVC5C5kWkSoJ3g0a6as/6fGpqATiXdVjm89vJtd5J0EASVp1C3bqXI0712kGWCVS2VP9sO6Zg+PDbc6S3lxbWuPyBxMM5+co/NnG5lUvbbEbYvNAK9AaiPlcKmoOV8IuP7vAOiuAZvjB6zNj5z3ARBOPLdCuAorM1ToiEF4Yl5n7QFiZ1Sb9fPgcWpican7ZCYItLLLYqzGqNjYYXyMwFodXC3TP87mrywjPyKQNO8oUYg3W6CbxJsCzdXUzmul0HhMBihjqsFIyQSPTZXcq04KliCHDdNehtmAIhglpCL0leWU/tHg5WdiRjWjXdIGgc2z8L0kWRacRC7z3xOpCoCHBc3EHfyCKIOU3Xmm7ZXkSoOVgDFx987xhjKsKJvh2gjmlLkHfz/E8D4LzORRCsnQ9cvBYmJmZ8NdjA5exazyDDrc6dLgpsfd2KTIRFe2Q9frEhayhbKo0RnjIx9l64M5CD2FZLCMcd0C3vvW6KVfEjRzHJgR6NGgZPXjcEnlgAvNmHY5q1BmJC3OkDxtI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(22082099003)(56012099003)(18002099003)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDJhY2NKNmhMQ1gxSzFSblJWbXhQSkY4aDVXbDBmUTl1UGFRT0R0WnFWUUI0?=
 =?utf-8?B?ZHRQSldwVXVXWlViUGVvNWF6VkljSi9VVjdySUUrdEovdmY4Z0lVZmY5NWNO?=
 =?utf-8?B?bzJQcGNmYjRTVTl5WjFoWHNNMU05T25kMHVtaEozMkY1bHc4eXFxbTI1MjJa?=
 =?utf-8?B?eFdqOS95ZDRLRUg0RWVuNkpEaldIc0V4WFRmZU5XeGJlWW5nU21RQ0tmQnAx?=
 =?utf-8?B?OVkyMVlhNjB3eFVLVFBoZWtsaHR3U1doSWc4ZURQU0FpNWN3akhTemhFZHFZ?=
 =?utf-8?B?MVNYdnZ2aVMzY3o5b1o1QmtOYk1DcU9rYUxJbXB4MXRNQ2hPWjZUSVI5WEdn?=
 =?utf-8?B?MUxyZXBHa3BMcmN1Tlp2emRqRmtzaXZWUnljM2l1dllOZkYwTVk5NkVFNEpS?=
 =?utf-8?B?T3EvcEtBSVV0RXVCWTE2MXcwbW5GaVlJcHBSR052VFFXNGpDTVdtaUdpTUhh?=
 =?utf-8?B?cmJKeTNYUVVrdmN6THBjc2JOS2M4bjJpd3ptb3diaDd5alNScHBkV3AweEt3?=
 =?utf-8?B?WU9SS0prTVU4SDRjRytCM3B0TlFiT1dCSnRBcHY1K3lZcWpjWFV1d2VBWHJo?=
 =?utf-8?B?M0JlLzM2NFk4WDdTVUtDR2FKc3V2TjF4Um9ORm1FQ1pzNHNmaldVRE40dXhv?=
 =?utf-8?B?c1d1d3ZuUGw5bHZXNzhXYjJ0NG81YnFidTgxbFJBbVhsTW84cHlRbk5RSXVG?=
 =?utf-8?B?NHhueEtIR0NGUndBcjRIc1o5TlFuSzhkc0VxRHd2UzFMY0g2N3N6UktXeEF4?=
 =?utf-8?B?QzIzSXJNdnY4WUhUbEE4NENMZG1hSy9MbEZEYTk0NVAzcnFGcEJKK2o5NWFO?=
 =?utf-8?B?c2s0WDJibmI5MXZDY1JjY0FBanNwNE9PL2QxdXluVFFrNUpkaXF1cDBrTjU2?=
 =?utf-8?B?d2dmYWdPU1hWVk0xbklnZmJjbDVEY05ncVBMdXZyYlkxQVJQRmU0elArcVlP?=
 =?utf-8?B?VlNZVi93dWtsbHgyNTB6V0dtY3BPaTJncEpZSVlRd081UlV2WmZjMEcvVzJt?=
 =?utf-8?B?R3VoQkc0V0UzNE16VHBZbGIzSEplZjFpV1MzMlM0ZGdrSTdFTUo3YVZCeFEz?=
 =?utf-8?B?K2xENHZ6Q0F4MDBycmtQNGlTSkYxdUxaeXRuUkNZL2d6aVBHOWpIUUpoR2VI?=
 =?utf-8?B?V05JclE2YUE1OVhOTGRubHFCVjlZYzBoNW0yZWxmTm9IZjNJdm10TDBEUENN?=
 =?utf-8?B?WHpMazFZUVFPc29hMEJnZlFNU2JMUmd6QS9PL1Q1aktXQlIxc053djV1WEUr?=
 =?utf-8?B?d2JtakhsTzFXSnBHZU9tQlNKNXhsMlVlaWQxZVpzekE0WDZNYWcxaFBTZG9O?=
 =?utf-8?B?dVJwcStsektVNXZUMGl4ajFFeTcrcmQwL0RrZEdsR1I2M2s1Tno5VEtWVVk1?=
 =?utf-8?B?SUEyVE1OS2pjRUd3VVRnV0RvSWdpNlU1Wk5LQU11NjRTQmEwMzBNNWZQUDJ5?=
 =?utf-8?B?TEFtOWQrMC9GYzNVbW9uaDI1d1NuUmREWDN4cjlSMEcyMVRielZwbmJGd1g0?=
 =?utf-8?B?bjlkRnZzTElKVG5mN2pQNjVrZExxeHA1a3FOcmFHMEk1R2E5V01DMU9KT3Ji?=
 =?utf-8?B?RjZ6V1paUG5hcVRBYlBPQUFjdFRCSGV1Q3JSZUdaR2dkOEVPQUw3cUFOc09T?=
 =?utf-8?B?M2k0YnZrSHRQelhOSjBiOHE2WEROdi9FWUlXNVYyMnhzYU1FUkRxVFJ3SWlk?=
 =?utf-8?B?MVN4OVQ1ekFRRFV3bTRmME1QZU4zbDh6aTI2ODRDcHV4U2hCRzdUV0xuK0ZT?=
 =?utf-8?B?Smd5TWxOVkpXdi92VHNUalQybWpkVUUrSURnSlFyM2xQK2xVWm5xL2E0ck56?=
 =?utf-8?B?cVRlNEtUU2NqQlNmd1FsdVcxSHBJQ0w1K1hEUmdzUUNzU0wwTDRIOHUrVWtL?=
 =?utf-8?B?NVdDMjdGcXZ1NmxrYm1oek5aNGV3alV2YW1xZ0tUTXVHNGh6UjNQWW4yTk1B?=
 =?utf-8?B?K3BhZDV5YzZVREczM1FDcXRzU1FTWklPTDBkM3JYYWl0WW4ydEpRcTBqS3lC?=
 =?utf-8?B?NWhYN2pxVlZHcnZLS3V0YUFnQ2lRTFUrV2VmbGhDb2xkYlhQbzJpeFVJMUxv?=
 =?utf-8?B?cnV2VW1QWEFzdEpQaHB5WndNNVVUbXhqaVk2aGZiUFRDV1pCc2V5NG9FYWht?=
 =?utf-8?B?TWpqVFZ5NTA1bG1lSFdaWUQ0UU1jdkxqcFFIeFE1YXBTOEZ1YkxLaFB2UFE2?=
 =?utf-8?B?QW9BMldQaW1lZkNEL3FNTHgxMU5EL3hYa1Bhd1RCUkcxNXdSaE53UEdqVE9M?=
 =?utf-8?B?SlVoSmlRVVpVYkdJcnZwbGNka21yV0RHWm81WTlvM2pySlZyZS9EYXhOcjJx?=
 =?utf-8?B?akJGa3RoaGhGL25KQlBENWg3TWZxeld2TDdNd3YyRGJvWFVwblY1dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4a7e28-f6b0-48cb-22a2-08de7f6ce03a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:51:12.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4II5PE91oAwHhRS/jgtoW9iuQ3PzOVuohSRntHTMJxubph25rIHhdGHIvteYJWRL0K4pj39tf+7pdrhBL9DvbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB5995
X-Rspamd-Queue-Id: E6ECA263E00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224686-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,kloenk.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed Mar 11, 2026 at 10:50 AM GMT, Benno Lossin wrote:
> We use a unit struct `__InitOk` in the closure generated by the
> initializer macros as the return value. We shadow it by creating a
> struct with the same name again inside of the closure, preventing early
> returns of `Ok` in the initializer (before all fields have been
> initialized).
>=20
> In the face of Type Alias Impl Trait (TAIT) and the next trait solver,
> this solution no longer works [1]. The shadowed struct can be named
> through type inference. In addition, there is an RFC proposing to add
> the feature of path inference to Rust, which would similarly allow [2]
>=20
> Thus remove the shadowed token and replace it with an `unsafe` to create
> token.
>=20
> The reason we initially used the shadowing solution was because an
> alternative solution used a builder pattern. Gary writes [3]:
>=20
>     In the early builder-pattern based InitOk, having a single InitOk
>     type for token is unsound because one can launder an InitOk token
>     used for one place to another initializer. I used a branded lifetime
>     solution, and then you figured out that using a shadowed type would
>     work better because nobody could construct it at all.
>=20
> The laundering issue does not apply to the approach we ended up with
> today.
>=20
> With this change, the example by Tim Chirananthavat in [1] no longer
> compiles and results in this error:
>=20
>     error: cannot construct `pin_init::__internal::InitOk` with struct li=
teral syntax due to private fields
>       --> src/main.rs:26:17
>        |
>     26 |                 InferredType {}
>        |                 ^^^^^^^^^^^^
>        |
>        =3D note: private field `0` that was not provided
>     help: you might have meant to use the `new` associated function
>        |
>     26 -                 InferredType {}
>     26 +                 InferredType::new()
>        |
>=20
> Applying the suggestion of using the `::new()` function, results in
> another expected error:
>=20
>     error[E0133]: call to unsafe function `pin_init::__internal::InitOk::=
new` is unsafe and requires unsafe block
>       --> src/main.rs:26:17
>        |
>     26 |                 InferredType::new()
>        |                 ^^^^^^^^^^^^^^^^^^^ call to unsafe function
>        |
>        =3D note: consult the function's documentation for information on =
how to avoid undefined behavior
>=20
> Reported-by: Tim Chirananthavat <theemathas@gmail.com>
> Link: https://github.com/rust-lang/rust/issues/153535 [1]
> Link: https://github.com/rust-lang/rfcs/pull/3444#issuecomment-4016145373=
 [2]
> Link: https://github.com/rust-lang/rust/issues/153535#issuecomment-401762=
0804 [3]
> Fixes: fc6c6baa1f40 ("rust: init: add initialization macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> This is not yet a soundness issue, but could become one in the future
> when TAIT gets stabilized in a form that allows the problem described.
> ---
>  rust/pin-init/internal/src/init.rs | 22 +++++++---------------
>  rust/pin-init/src/__internal.rs    | 28 ++++++++++++++++++++++++----
>  2 files changed, 31 insertions(+), 19 deletions(-)


