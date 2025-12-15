Return-Path: <stable+bounces-201038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B47CBDC13
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 13:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EDD3028D9F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD42C15BA;
	Mon, 15 Dec 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="iZ/Nqs84"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020126.outbound.protection.outlook.com [52.101.195.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17902C11F9;
	Mon, 15 Dec 2025 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800791; cv=fail; b=bQGYmxsVpkgK2Thmjs5Hb12C8cShhFo1y9uSJ/hGjCtO5bcJ/+4JtpWfnCg7hoRvWYyOuTl2pJTW/1HOPeF3WQ4+3mOlNFAkgaHRfZlAxYyzE/FG0lAq/C2V3NZjm9IALvMe4zIn6CIqSX1TM1oHunrnP0UbNrCtYLxLTTfyi1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800791; c=relaxed/simple;
	bh=xBKTQOfyV8E0E9y2+QasSLc18f+fsrhS6rzUJmvLMjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LgapxS6o+bDgyCGmG8vb59/dZVtitE03+yDzwtAke9c888Q30ItRUrKLP+chaIfgYQuhZn15GvdUn1vFqQ7heRpYynUjNkb7fuS4GBQyAqQc9peckxqRCp+411y+LY8s7hSpYulab/2omRJxt1tEzKoyWRJuA1AXNmROIbJzES8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=iZ/Nqs84; arc=fail smtp.client-ip=52.101.195.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bumyxRd3K2ktGk/H4wds8eFC8HBJ2xaXUyjqyaZq3cuaaXutpYPfq0nwpCnShNtv/GyiyL2RHhoBWZEEIkd1ycCNMbsE9JZQFbquct2L7fP6uW9o519GHucXuB0UA9PkpIZQR3008jd4gXFyyZDBnZSsaUPZhogD3Csxq+cNITr6ndpmKrxj6z5PVZWoPLZ44Bh0qRKzSkuIcj7kRm7qfLdekC/OrVUFlew6sY4DXQh0FfzsuS3dHuZS9zo0X4LosFym+fjcPMKeO9TLFJE7I+C2oY3qSb85XAd/isw2OCBR7sowBxLnlOlSgSOYuzbtGBIvRLbpHHRr5+qcI63YTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMW0N+ebo/oGhyYfBOx8+TL0NVmP+COge0M64IDRDVM=;
 b=ecLErj4NZRRguojNPM5zZX8tXLd735AfnOFP74B3NieGbnQJAntrNyelYAMWRPwIp37UYR7Uk6OUBjv8cbNky13ogETwGq4jjInhwd7miYm+j32bhvFkfoFfOJ+88Mlbyz0Gmjay14m10i3lLwdwCJ+brScYH7NIU2Q848/7uOG+x0vMJJ3Wc5Zdo9OJfVYPRawp+I9cWESlUcgtDIEtsQUfdTTnQeZXxX0dKY1xTwF8iONPoYZEmsPe5mOUHlL46ZOMQFdYHPJb2OANx3oy3O1UKC7CWytAmawcDzSZYtdVLORy5Mu2yAsVi/0aXQUL5ZEUxyg80MWnZEPF1dM5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMW0N+ebo/oGhyYfBOx8+TL0NVmP+COge0M64IDRDVM=;
 b=iZ/Nqs84Cgac6csq2SoKBf0P9DK94PKHVXBTK8xK3BvZcMq8gr4ZnS/CYLszxvtKEW0uXTXT2mK3q3mZcCDuj0OY1ZQktTxN4as+1QgRwpzk+Gs4WxQkKye4FNjsJtC1dlvf7mSW9KadsSEZfOYPR82tr1eiUpZMZTt2U148Iw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6181.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:180::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 12:13:04 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 12:13:04 +0000
Date: Mon, 15 Dec 2025 12:13:02 +0000
From: Gary Guo <gary@garyguo.net>
To: WeiKang Guo <guoweikang.kernel@outlook.com>
Cc: <ojeda@kernel.org>, <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <akr@kernel.org>, <mattgilbride@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] docs: rust: rbtree: fix incorrect description for
 `peek_next`
Message-ID: <20251215121302.013ba3fa.gary@garyguo.net>
In-Reply-To: <JH0PR01MB55140AA42EB3AAF96EF7F3E8ECAEA@JH0PR01MB5514.apcprd01.prod.exchangelabs.com>
References: <JH0PR01MB55140AA42EB3AAF96EF7F3E8ECAEA@JH0PR01MB5514.apcprd01.prod.exchangelabs.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0304.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::28) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b7c619-b2f4-4806-9914-08de3bd34ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yww/vSLf7kn0GoNq8MXHs2KtR7dxLe9KZyg8rWWDbnjxiMB0Iwv41ptMBuu7?=
 =?us-ascii?Q?OsLN5KNa5RfDQA7gFfLQKfu6TuynZw3mYx3NwxrzijWPbZ2A9RPgWKQXSK00?=
 =?us-ascii?Q?ry7cHjhHeHFcKRWxRS0ArcSNUDv4gmP5blSVs3x3jGYxtMBrC+1v4fxBPRL7?=
 =?us-ascii?Q?cusf3c1yaW1t9AbNO2Zif8a2YZJVkytbptgS6YFLTVDLS0d3PKqbmWCC0SYY?=
 =?us-ascii?Q?OTxao3ROBvN9KU5BfHzaQzC2N3SN6q77SwUZgOGk6CQ0fRSiZcn+BrIsngsi?=
 =?us-ascii?Q?01mjvo1HNt5i38OflGqo5nO/mFTTM95iRl0/SIrHoxk7sv1VEZQ/fKuKBYsa?=
 =?us-ascii?Q?BkZVCLBFZdd85OpCCAghcDIgcVQj6JUcSpcyRxSeh59OZUIDSYINgTIo/lcD?=
 =?us-ascii?Q?0ICTRHv07jjc2i/XJqrWHH/kVWXKwNkEC+yqCDBfbblArF6HZHY7tB6gS+PN?=
 =?us-ascii?Q?HPhZwM/LQ6NNMxQFhpUUdJYLjRZQ7ZOLYAds8hqDfSER+B72rgSsweyY6Gw3?=
 =?us-ascii?Q?38IbdbIeCy+Aa339fwmWsxA12saVXuoloBf9NK6TPUeVeCE6P0geQyhHqVGh?=
 =?us-ascii?Q?lGBZ/2/aq+VKOBqOY0odP8l36IvHUNQVJ2cpuj0r5Fy1zkCVwqzJE6qLNWEY?=
 =?us-ascii?Q?Nu/3yqFEIN6ThNsor1XvBG4m1HY2fRT/10aKtI7GbyHfjAj+4CeAOMpPxScz?=
 =?us-ascii?Q?mqjEokJYmTpOTpAnXxMlnkZKpaeOYUv1ObP734fOY8KO9/0OIhd21O/xHXzw?=
 =?us-ascii?Q?rtAEHsSQudX2LdSsrX87p4FdT3prslcRu7nqbbAhN7flJUrTPTPEIhUfxq13?=
 =?us-ascii?Q?Py1mjkWVAJysnquClK0sGnRGUTOOGxZ4i4/2xsbC1EZh3eQ5IR1YwCdgvfwM?=
 =?us-ascii?Q?tVe+zuQ5mcLgt9/4dmkjFh0YLiGg/5P3FM5tgyYxJZOI1Hi0+hZuen17edsu?=
 =?us-ascii?Q?pIWRQ3vFaBU1iRsZmxC3v5iNA5Od2y5DuIH5L2lNgOuGXTdtjhQJMFl+GrHA?=
 =?us-ascii?Q?9ZUteRWuUmV0gjgYrmDlhbdLTuG7JSAubTvq7DP4PLdUmwBsRPMtEIxcKCEO?=
 =?us-ascii?Q?soU84p9EQdhhQx9dJqHTRpaDpte54qyoX8Y44dqNumdu1vaguiIu51Ga8PIK?=
 =?us-ascii?Q?2w7GjE/umH5aqECl7Pm/d6k/oGUYwIpyz/2INxPM5QwpSlfRQ621qz3ZA522?=
 =?us-ascii?Q?wVvrS7CxZM/gAPmfb5tkxRP6s5uqcDnidnRD3+uVuPtkPBIzUbfFqW90HYdS?=
 =?us-ascii?Q?bOJjURdEyW/lW9uWYfWRVvBP+cxWCgGfnZ/JLHd5ax/Ne2dFhpBi5Otycseo?=
 =?us-ascii?Q?Pg2TabYp1gi/8yODf9HRa6+nlv1a+2i00cWnN1x0aIaEILDFTNEamN/vKvUP?=
 =?us-ascii?Q?sIX1KtS7RUCcHGfuSiENiQJK3TSEnoYH9FL+Cw5l0RzHVZEzNikrAIPtnNlc?=
 =?us-ascii?Q?4gtg6WjcIyv9WuHeyB5bA+JHCX+yTSYdJqHALH3Tpr7T7RdkgqarDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8kQ1jh2TzqF//cwfwy9xi3SQJVyrx2h1tt+mIqic4s4NIPocTxEkDIPWB3q7?=
 =?us-ascii?Q?j6PeVetHbOIMYatBGB32rEFG9eazClx/HTmwxXpSGFZjjQo0ayhiY7OMABgV?=
 =?us-ascii?Q?hJuwpIGKYc5JwDTZFr5o4DUuhF0Tg4XPfsboe75ImGUe+GpGRyaLzN15ZxD+?=
 =?us-ascii?Q?AFJ+4ms9ujF6nma3ynskTNSxz9taf01ETied0sLn5F3kmMKdCNUQwpMBjNRK?=
 =?us-ascii?Q?Ut+kmp9gDT8uB+BnyvzYx9fBAYqFtJexI6eyKMLBi6LCX5QzmyNuF3eKpqJI?=
 =?us-ascii?Q?88SdqlPNtP8UTRWgn5l+hyZ9ZEmJXNNQ/PdATMK8ieWPA8np56H2sWcgy9KE?=
 =?us-ascii?Q?kaZTXkn4MUlmNQyrnNwuNHbdWE9+9P5R/Cqd7sCzdGL2JHinYxdLCPAgwGTN?=
 =?us-ascii?Q?1GljH8z0QAl/tDIGYNf3CFTmF9JonmNFnAzdERmW2NnSQqq+SYEE55772dWk?=
 =?us-ascii?Q?4kEs6ib/lCwdhZU3GGzmj5CDxyzBsslVtvfURfPAyQKXQ9nuxw1GxdZBlIYt?=
 =?us-ascii?Q?co9a9OtQDNTA2GWWsxkHWSnsplRuSDMOaZ+/bgzVNETcv+ab3EflyjAFPueT?=
 =?us-ascii?Q?Du9Cp2FGdto5HbXh2bl+ffN+6k6S2c5Z0Dg20v44sPgdFOaJm85coBIsmlpN?=
 =?us-ascii?Q?V4liMDDdE4i7BK8ib1Ns9SjzZ0eAj15b2Z4Nb41pZz71BIAoxr3mXTXzyAmn?=
 =?us-ascii?Q?cdjwX1jahrNMmDlpZ09LMouk9m+e0dtQsbwXEhklMLgXybNVaNtI6vF4bw0Y?=
 =?us-ascii?Q?WKvdlGckGcHzwsBIdzbohbOBX+KZu+O2HauOeH5DXAzgEOArpPPq/inQVh/y?=
 =?us-ascii?Q?JvQuqgP5NppHh4/ewO2gXp8hwfKdDXkcvWOXs61npsL8V5YhjXadaq8IB384?=
 =?us-ascii?Q?BUAHPlZyKZBFs8NjPLW6DkQL4iwXVk+W0LlnT1miwMk/asUizDxgvhCYCx1q?=
 =?us-ascii?Q?3UdGExdsrptTA46l9efsPG1fdvTyScxnhVSS+9Q0TgnQAZIZ/WaFYPd15nKF?=
 =?us-ascii?Q?JzwzInQ0oBUoqd6Xlu1LLJz2EJ7Y9QIf/NvwV/78C8T2d8qJ6Iw3ILbx66e5?=
 =?us-ascii?Q?fK72CTh8vkPGBrDez/Z5bSIK2sCtmJ9CdKcFS/Ig4tM++L+kXwShOU+8G2iH?=
 =?us-ascii?Q?OZ1NVKEjli56mfd8anodaVQCCp4HRPJbglzqZzvyVTOOeDvMs0I1wZbpNbqF?=
 =?us-ascii?Q?0THGfpKX7hR+B2Vbz6HD+igY03+KkYl9VJUdF+Jw+YfJnVXLE3a5sOczo/+e?=
 =?us-ascii?Q?fsybiNfbgpuvHxS2fX92V2nte3xAhudsQ0g3MfQfxQmTDG/PWCmxkJfZZrUg?=
 =?us-ascii?Q?5IosiY7lbuQYEN32XcXq2Pf7y8k/3v3SOD+bn/xYeYS6ES2gni5IFrAtPwAC?=
 =?us-ascii?Q?segVGyBteQZTDKHknx0vWEfikZQvT5+VZ+bssxu6KTjvdsO1RdN281pDi4/R?=
 =?us-ascii?Q?4+TYVaPT+2wuiqeiYgAd6+TxQ2OWnimqRBdjPc/hWK3rKFLBmVWKQksNrexO?=
 =?us-ascii?Q?HcerZ8KnBfF0SC7TZiiZFW15fl9YY1WlBYfE4E+HEfKWkYj+9RrxP7G6O4mT?=
 =?us-ascii?Q?KgDiHppLYV45jKbXPddWHCA9UoqLKoT9gNoioI6HjoP3e8x/7UI7bmJeBfeg?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b7c619-b2f4-4806-9914-08de3bd34ca3
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 12:13:04.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXNFEh5H139i5I9e1gs637rVRxNtysuobUS5nyLagQCYj2yHgWnYVk7G7gqkGCTdosF88cxqH6YGORrNto/xtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6181

On Fri, 12 Dec 2025 17:31:10 +0800
WeiKang Guo <guoweikang.kernel@outlook.com> wrote:

> The documentation for `Cursor::peek_next` incorrectly describes it as
> "Access the previous node without moving the cursor" when it actually
> accesses the next node. Update the description to correctly state
> "Access the next node without moving the cursor" to match the function
> name and implementation.
> 
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1205
> Fixes: 98c14e40e07a0 ("rust: rbtree: add cursor")
> Cc: stable@vger.kernel.org
> Signed-off-by: WeiKang Guo <guoweikang.kernel@outlook.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/rbtree.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index 4729eb56827a..cd187e2ca328 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -985,7 +985,7 @@ pub fn peek_prev(&self) -> Option<(&K, &V)> {
>          self.peek(Direction::Prev)
>      }
>  
> -    /// Access the previous node without moving the cursor.
> +    /// Access the next node without moving the cursor.
>      pub fn peek_next(&self) -> Option<(&K, &V)> {
>          self.peek(Direction::Next)
>      }


