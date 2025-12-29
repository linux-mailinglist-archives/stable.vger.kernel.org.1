Return-Path: <stable+bounces-204110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 806C2CE7B01
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2060301177B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0C32FA2D;
	Mon, 29 Dec 2025 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="DAz/9s3D"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020136.outbound.protection.outlook.com [52.101.195.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A40F13B58A;
	Mon, 29 Dec 2025 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026754; cv=fail; b=r7zdVEqGi0m/jZD59FpUEKp2KScmCDRLv7+kJe5LhxoIPzG/wsePc0fTDQeLu+RCtK3QTSzwfnWyER+dhK1VoIeKLGyPa1rhY1Bh4g72Pv4Ply45XzBhCgQPVVWAd/naF8EpoHmtYIs19UG/sdD5FyLDrqZyopLjOG0pvow4CLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026754; c=relaxed/simple;
	bh=ruHBA+2IZDgcPpiALuxHxYNPV6bGHEwuBI3IObJtwz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h4pVHbAwsQ0pj9ym/WBCyOsZXbjePiyhh4xecNmfhScDclAt39WlXU6o6PTGBY3oaPyrSmPXhQeIhnSxsMG9oO84SDMNcryoWESZ02oRLPOclgvtox0mzrJCUh5TkIpZZmG9rQ5PhyZjPpshavzlM5qfo8YglWxdSh3ABLqA4Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=DAz/9s3D; arc=fail smtp.client-ip=52.101.195.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAihihJruW+qeqLX28oP+SHzIrnwf94YP9jNd+5pVeHqkyG1FiFqPhDc9xVXjaxF2Dr8e7olepLPmRAlqXHqgWCB/4azPK1vgN6/foNTSyB+DOWYjDzx7u6V9vp/XuyDbtaq+8u7A0dQwIviAvC+PM24AEs4AmHWpZYjjvAsiSfiMQYsSzIVeVTMDFVuvA4vRtUmyru9V6K09dOWdOybOmA+qB1Mmq0ZvYdBw/klUDoC1POhor6TrmymHY+CmxN+HRDmB4inhaRq2ozL1iesSETK4jwm6t1Xa45jTLrseHVuCoXRlX6o2grgvJtKnIAsOQF8hqdRP3G2sJbENYZx/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtWdj4VfGdDP1nmXDyMSq+L04e4STxfTERqiEpWBozk=;
 b=MXR7a5SZZXzvPEuNZXIfWqSXxQJp4d/X6fi6fj0OMoUrFmlAEqV+tRlpzMJ9wITNl7n2hi94phWILtletqAU6NErRpAA9rHjOH9HnWzxY4KXt5hvE3ggx1USusOVH2JjZkEvHVlh/cbwqauEqOG3m6o0vhytCeRXAlaQq+UGTcuvuPlS1Np/bIswj2UDeSLjmHqF3xIbREOUNTd0aQbCYoAtCtewwQfzTC+kIGoVTqOeELor79KKq3KHjI44k5KBgICHhhaI+AfIh9u//ulSbFO0jgMa4AO2trKUFA3BZBmayIrNP+FTWwcHT0lDSJyOdeR53VPxVOt9wm5L+bmrow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtWdj4VfGdDP1nmXDyMSq+L04e4STxfTERqiEpWBozk=;
 b=DAz/9s3DikvGbm63QSK5q9x7AgPSQzUWyS9wwerg+X4TDZwuEJwVt94yTAh2Cenuo5ajuHNT8KeRedvjplkeI5lnuE4+vui4YkDjAuFqQrXFI+/5MyniXYXbS11R4mmZVt+QJyI2j6eH0tVIQ2yKRFZS0I92LM/x+9M2y2egSkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3178.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:15c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 16:45:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 16:45:46 +0000
Date: Mon, 29 Dec 2025 16:45:44 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas
 <cmllamas@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org, DeepChirp
 <DeepChirp@outlook.com>
Subject: Re: [PATCH] rust_binder: correctly handle FDA objects of length
 zero
Message-ID: <20251229164544.1baf659b.gary@garyguo.net>
In-Reply-To: <20251229-fda-zero-v1-1-58a41cb0e7ec@google.com>
References: <20251229-fda-zero-v1-1-58a41cb0e7ec@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::8) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 537c5503-3297-456a-6b32-08de46f9b73a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t197rQWfzEZDQl/sMZI4KmadFC5c86oaXTW+/AO89W6e4Q3CbXeQHfqbXg7y?=
 =?us-ascii?Q?DQ9QB5u4UVT5hnC8fAkYN/MbMic752n7b72dyfcTdJnr/iDYDs+X0skVl6LO?=
 =?us-ascii?Q?oXai7NHeQK94XYBS5HRI43SvvXdVuRNQVNDhtRaPzKzjAKlAIXJL05Jkdo4/?=
 =?us-ascii?Q?dWDCgeiyUMe4tbKwe3gmso963sHuC44PxtEsj+RMYj0mefU0ALCVU9rYI7Pc?=
 =?us-ascii?Q?EfC/eEKVT5k3k3hLftYL51Xn9grhX5vAPwjayS+cJYvkaTOnqCqvKBN2/Hq8?=
 =?us-ascii?Q?IyvTvVrsHvg3eTjxpD0f9w+y+wqoBkCzw3fC+IjEnSZ4fjgoDhGm1WZzdgDo?=
 =?us-ascii?Q?hQTi2KTWKYEIb2vXx+QIHhnFNRkrXcBJQRomKvf1EAW2KddF/M3+f3Nn1TAG?=
 =?us-ascii?Q?errGC8sLzRjlHFPM0D1VzgFiryI3AFzSo3hR2XOz/u08oMd+9Zxu6hwcz4lb?=
 =?us-ascii?Q?tvWd0+Kjr11XRRLrFGFpXA1H1jWzApccakJQ6b62BpAvdx57w/9SLLlJrmrD?=
 =?us-ascii?Q?wuxtxNV0+tKOFFFwnsnVL2uuIfyYK9WqOUJBywjujfKpKnqE2Z67kv4fol4Q?=
 =?us-ascii?Q?HlmK6rrEyI3DeHLHKS8Tb+zStc+ti0I4eaIK+H6cbmsEWQVIy8MaWgGq+uDA?=
 =?us-ascii?Q?QWDiOz8W7eooDzNmEjxQHOYWSnFL2aasXYf4P3Rx/QoIWX2Oikct7nQLD3cF?=
 =?us-ascii?Q?59XJQU0N54H+1j9BDvv2CNg/aMDgQ9PY/eCZg3DX3tgxvSYPDOec/n0nZwpn?=
 =?us-ascii?Q?C59/20YZO1ar1EmcEVynphgTCFrRGeL39rz/dg/e7wHWAS5papfW91gzyk9H?=
 =?us-ascii?Q?yRsrxdTBlJaqAFC0ff+JWlzBXU7kRo3Yt9QpJDx31pasp9S0/kc5s38lY6M3?=
 =?us-ascii?Q?HHAj4udlZFeHTD94FUMVXcKEpBJ6jmWfkR7mCnC8V3UXaSDg7tk7o9WBTKHK?=
 =?us-ascii?Q?ZbjsG1Zo5/6Rc2HhAMH5lQdhSjZOx8caAUG0uvyRD6lqB4do6mIGO2RKcUMO?=
 =?us-ascii?Q?fT18IOc/pnOIhYAi62PRd9s5mgLCMyTSLOZZpWOz2fuyVrvPHDGTE00s1i5K?=
 =?us-ascii?Q?daVsut63fu0SWyvn4UafoOkhKYgHOCLEm/BoEBiu4pi7KXB3s5C2XL69/JGP?=
 =?us-ascii?Q?NrP8G7IGWZ/RRu7GipuzyciGKacSSA0xusZ4InehEIVVlpc6v/jtNrDMahVC?=
 =?us-ascii?Q?xALFNCOjJRl/dDBQhWJAydbGv+5vRyBql/LWGJlnsKsS2Euiu0FIhOgbR0Gw?=
 =?us-ascii?Q?QlCJgyv/eJIWXGFLFIxDhAejg5Fml8f/8Z9Ky2GmnIgPxQSWxKg0jaE6y6JJ?=
 =?us-ascii?Q?a2oG8bWip1vK9GecNNIgRlZKOIJTHuHpvYGsUTlxWMWH+asztP5hkRumu2j8?=
 =?us-ascii?Q?57232yHPROPrEn8X7pIZgivT2YvGPpQorMdLS6vhLOSbwcs+Ynv2BsyWH6O1?=
 =?us-ascii?Q?iqXYHCDzqO79V6sthBn2MNPdr53oHKneP2NKPk4IjGtXKvAM6lDKcA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0v7Fq8PoNa30GYftJgWsaG251DqlWV66w/CNoOcY8+MPyhZDn+BUYlL+mz0f?=
 =?us-ascii?Q?O05GRtsivXSayFGhpSCj2mwWi/Ekiv96CwLOfp8aPfK2LVytbDgjJWG3D3Ad?=
 =?us-ascii?Q?pV67K2ehauwiqzHkVrt38szskxgPlFtrDleR9SR9XjZIC4GjsdGbsBeKgKnd?=
 =?us-ascii?Q?K3wLI7cw2cy2G4L05nDzQm8a9zxoDjJzKjnYvnCR1Wo0EUpiTpzC0vZtRHLm?=
 =?us-ascii?Q?WI2dJ/nfgEvWaBau6ZxVIoDpQS3Li2suQpu/r1upjDRIGF4vIo61SNX6X+IQ?=
 =?us-ascii?Q?n1M+TTqDV9A6qFZbr7JOSz+o1/H235w0V36SEC4HYrmHs8mwiLyrWcEOOxll?=
 =?us-ascii?Q?1JTIBVv3fBOYa0LlqVnyzt1wpz1CAY9M6pqSMHPpb5aqaoWc7lQikbdL0vDI?=
 =?us-ascii?Q?SHmEeOx3t2Zc6sqkS60r9lSMGsbzG68BoVvPhVcaR2d6nKEi2j9B1zgaw+D0?=
 =?us-ascii?Q?DGBRTpU3kZfYgxrzm7c5G3QekxfXQnofofYJ1fTP+a4WX/gA/jdEb+s4rShm?=
 =?us-ascii?Q?wlx07L4HUAXvJ9KER3QBcNij7yLGD3JlxFK1iuePtbPM3q/sLGwsWhn1xF/F?=
 =?us-ascii?Q?nGHQs56IiVA2Tv6npVzP51ejEMWL2QXVfguOG16h8gBQ43DNwQcARYZdEOcu?=
 =?us-ascii?Q?MBfbUH9zmN/RiswqCxRtnXj9pSMEa68xbnAue9txOXoVFckyBhOn5RkMzSwo?=
 =?us-ascii?Q?GJOEl3kb7ieTRRh4vSyjw/U80NEaA3JtYpChjslBOrNbTV9vEcJUzKjT7ere?=
 =?us-ascii?Q?g0JBPkxPnRUelcXspTlf6z62K810LWT7dBu1Rds7qCof82MlG8tED1dr3n2E?=
 =?us-ascii?Q?E6nSevtHG1XtQXLj3lyv3rMFabhrZrc2OJrikxsPBRxAdiGL5lYffY2aCfi1?=
 =?us-ascii?Q?T2iHIIA7RGsXJWNA4ooJYPZO0e6txU8hDaYUJ2pePY6j2HK9jG7PkdwsU9Gj?=
 =?us-ascii?Q?vdFoAVIBcegwo7p9RC3wVyqwUwEaRuECtoYs37y50jfGlsyZCc/VkXYyTKa0?=
 =?us-ascii?Q?DHYX3HxiREvgJMAwYSQ25zYYViBQBLLemzqIrNP8Ul/0+I2wdxyD92WSfOu9?=
 =?us-ascii?Q?UClea/SZ/UcHQqTE5mi+J+k6VOyhUr9BU7RbIh/rMBxYhs+PttlifSS3UvAB?=
 =?us-ascii?Q?zbwOpdp7H4ZlVxwnaBvUSUL3KRdvrhrg+TQl7i5TgznAWkLZuudm0zoTGdXT?=
 =?us-ascii?Q?I3KU8FXF3cu3wFpBjM/yx0HnqW3ueHY26CkFU0y95BRPdqqY3r5r+B6KE0rI?=
 =?us-ascii?Q?bgINR6HoghnIha7T9g4/o8qQ/X2kYUj9elMZBxyUEKGHpBogbbSHPnhVWX67?=
 =?us-ascii?Q?YQpYqUzGjvqCanYhWv2UX8eQP7gxX3lkNkyoFdvYDxrIXU8qGr3tq0jjp2BR?=
 =?us-ascii?Q?CKHskgNVYBm0smHVtv12Qdnc77hJE4O5GuGtrkJdcGoezdChAC5/gCx+Lp//?=
 =?us-ascii?Q?lDQWuPqRI+7B3Qi+ApYFeV9UXUXEhaxnzQn13s6MVHUqhSpv0Pkt+nGYpR/L?=
 =?us-ascii?Q?2Eun0vEy4xaXB2iBktB2rHiAlo6f0Ee9Kci/xdzsT3LjTM+I4bhinPG0NI7A?=
 =?us-ascii?Q?alVkY+ww5fL+spP5O200rlUcSAEs0F3ywibBJukzlNP0f3G9O+0hcy616AxI?=
 =?us-ascii?Q?B4Eyw8QOy/j/a/FqXipxpCNlgWhRiNc6tMhDEOwqlAWF1hM9cdIPAl4MCHQX?=
 =?us-ascii?Q?rlIgJxrGFFsqPHV2N+C0a0UkNqPEVKVEOAOPA79HnOP0eabwOdhTwZ4MiZZO?=
 =?us-ascii?Q?XnPE+VwU3g=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 537c5503-3297-456a-6b32-08de46f9b73a
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 16:45:46.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msgtrL+lwaW7/tnqVXuYjLaJINk7YrMLF+hJn75kJMIHMc6efSfRcdHDY2JNpFA1Yz23tUIXVheBC9xDB5WdOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3178

On Mon, 29 Dec 2025 15:38:14 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Fix a bug where an empty FDA (fd array) object with 0 fds would cause an
> out-of-bounds error. The previous implementation used `skip == 0` to
> mean "this is a pointer fixup", but 0 is also the correct skip length
> for an empty FDA. If the FDA is at the end of the buffer, then this
> results in an attempt to write 8-bytes out of bounds. This is caught and
> results in an EINVAL error being returned to userspace.
> 
> The pattern of using `skip == 0` as a special value originates from the
> C-implementation of Binder. As part of fixing this bug, this pattern is
> replaced with a Rust enum.

I was curious and checked the C binder implementation. Apparently the C
binder implementation returns early when translating a FD array with
length 0.

Would it still make sense to do something similar in the Rust binder? The
enum change is still good to make, though.

Best,
Gary

> 
> I considered the alternate option of not pushing a fixup when the length
> is zero, but I think it's cleaner to just get rid of the zero-is-special
> stuff.
> 
> The root cause of this bug was diagnosed by Gemini CLI on first try. I
> used the following prompt:
> 
> > There appears to be a bug in @drivers/android/binder/thread.rs where
> > the Fixups oob bug is triggered with 316 304 316 324. This implies
> > that we somehow ended up with a fixup where buffer A has a pointer to
> > buffer B, but the pointer is located at an index in buffer A that is
> > out of bounds. Please investigate the code to find the bug. You may
> > compare with @drivers/android/binder.c that implements this correctly.  
> 
> Cc: stable@vger.kernel.org
> Reported-by: DeepChirp <DeepChirp@outlook.com>
> Closes: https://github.com/waydroid/waydroid/issues/2157
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Tested-by: DeepChirp <DeepChirp@outlook.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

