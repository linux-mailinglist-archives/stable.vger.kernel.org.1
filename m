Return-Path: <stable+bounces-219159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIwpBc5mnmmLVAQAu9opvQ
	(envelope-from <stable+bounces-219159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:04:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA3119119A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6603B307D81D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657B929B793;
	Wed, 25 Feb 2026 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="UWVMBR4q"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022095.outbound.protection.outlook.com [52.101.101.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432CC27280F;
	Wed, 25 Feb 2026 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771988680; cv=fail; b=DoCDn0FSSVEdfpsY3/5R72S8eAh7S2ptFGL5z7A5FrkXRQib4mYnkuJDjJTpW2Hq7TZI++kFJZBh8Gz51IxYsca/DWIEiaEWjPnUlsEc7SlO8YkbjyrHJ3xv4+JSyiXWWW0x0lVOPfGP4YfTQqt64EwE1R3DgGAEYUiAzhx+q54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771988680; c=relaxed/simple;
	bh=s1JUw07YA1YHnAXlIgG4Zs5mPB8sKgZrFvqqncC+1Fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=Ht4D7xpqosJlw5s2Zi+FCb2/NbXG44bgEbmT5By9G8bXZIFj8mWcO1I3xScg1iTAN1QSBzLoBdMXWkA1ib02HHHE37teTjGQJgaQF76wLPI69sSU40LTQO9/ibYhhPzxanKKzyVG8yz3PMReKXIb8uXmtX1DuVmRZkEhXrS81s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=UWVMBR4q; arc=fail smtp.client-ip=52.101.101.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUDGRe7Uquc3Q6Yjky6iknwJaTcl6gZQcgy7bofIDZ2pn7qV1ctcXGnn3lu0H9ZoQTWmiD2rvgwB6zK1lPFEecKavUfI8bHCT5vqL0YA5Hywt4CQRnpaZzMe6Lf/gFC54NhHwKC/Ozq7bA1KjXyPV2bueiHQlT4Z1mP3brQPGDALL5RvW9D6h6fvujs6HY9Y3y2osCD2YvPZgf4XovEUKVDRqmifXz2piqD3mPG6zXvlJ9H7DwFvirZsx2SOaV67nxYf1qWx1fcqmLY0DTp7aPMNHZC8NvBlijHq3bQT8MyLakRLD1MTtuXkVqb6771aIZ3Qob+tl4aDJ4T9dAM6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nD6b7mCa78GexLBA7Dt/xCAyPEHG9ftxNcx92giRvc8=;
 b=O30Dsyjv6Y4aAH529dUHBGNcp0ry731GxW3YQv9RIobxpyPmc13vcz9dBv2bZHcI5LduAP0EfJnism7faWTrqOGxfQ8FrJ6WsaFKrptAqiamUm2MlN/CnegmQeHK683aA63PRyBluPTiwoA4x7gcWTeW01i4Nk9KxJSgbKKcKj3MBlFDtYYB898cRV5GIfbKm0wnWwPQFIyCtXBeX3b+/viWUjTEFIasp+AZJdtR7ZprkWI0Vzcznj9LTv9cyWnMW+LPkAI9uNGBAkBE1ja3bFcVhaEGoSHDiSJpRUyo/40RfLj+915arSZL1vxe9ZlCOnDgUPra91rKsAxuxJylSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nD6b7mCa78GexLBA7Dt/xCAyPEHG9ftxNcx92giRvc8=;
 b=UWVMBR4q1ok4/OchscxM0QcZDW7TVQWShcWNDvYZBIgH0969Eut18BMY+nJ0w5p9nklykqZNBuoXlTkMHbsShaGOcFU40LluqB+CUowl0T1NA5kKhd+hAvxez6rgPm99BCFo/IFRy1i9NKcEJQTjbOXbrm5T4+7JJKouEQLeb8o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7624.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 03:04:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 03:04:35 +0000
Date: Wed, 25 Feb 2026 03:04:34 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas
 <cmllamas@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
Subject: Re: [PATCH] rust_binder: call set_notification_done() without proc
 lock
In-Reply-To: <20260224-binder-dead-binder-done-proc-lock-v1-1-bbe1b8a6e74a@google.com>
References: <20260224-binder-dead-binder-done-proc-lock-v1-1-bbe1b8a6e74a@google.com>
Message-ID: <620c1601449f88af696563e62d05c98f@garyguo.net>
X-Sender: gary@garyguo.net
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ed2b33-5b85-4697-6305-08de741a9ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNkYAXoqFBFvyRhUKyEzsca9mvngQc4FvK8pxxbCrSGe4+nco8L3sSKwE1pN?=
 =?us-ascii?Q?LZ42ZjoZa62hloOUG0seMsJCBD+kmQIq5k0rnPTNFFDHtvigKpEKqlfBuiO7?=
 =?us-ascii?Q?nrQKmw6vL90ZgWK9TisJS8Snjo6Sr1uyw4K/MNcq6v7AB60qiKOMNCW1hawa?=
 =?us-ascii?Q?y+osld2uUilHFvNi1oCe3G4hmuRPS8gSxC+pdm8l3LoPN1OU5jRTV8ex9Yoj?=
 =?us-ascii?Q?fpj5K+5GtVa9bqJ3O3ik6eAQOVBUibIwgNUK6+kpy4y0lzfcqjNj8R7rgBOT?=
 =?us-ascii?Q?tJDFWSfZpcrYTXhIcyG0utG4ULfSd5Hbn21AxqRXwfTPXHEVLtsmEY8zHUtL?=
 =?us-ascii?Q?0x3vhGWvLH9WLZkg+2V5bSC7rl0AUoM5tAz3W1Bw4HSGzsjZx2HhJ8dvE+qF?=
 =?us-ascii?Q?vPrg3+RWoYlfOrNMP9xIBiOdYB1HN1Rqp6evSNoN2HbmNT/QAVs5NS8y2DbU?=
 =?us-ascii?Q?+snJgUEvIARfQJGKt72mIJII3RHzh+G9gxLFxc2oi11+6c5H7MYFIOmjJ26O?=
 =?us-ascii?Q?3m+CCaacPeVsM9tqASTucQ1F9iYXE9hdV2OSo5C5WjH4IWd+09KbO2IwSuqv?=
 =?us-ascii?Q?avlfRAVWOaAXpMMJofiC5K9chtWGSLynqhvi3FuAP64z0lTpP9fIiIlRuoAz?=
 =?us-ascii?Q?aVgf56urIpD91OgIfCOi8kpdwdN2E4321QF0Et8CNaBb/sABIn6zNAOpgNRA?=
 =?us-ascii?Q?AANvXGfyDfr8qwgFnQ9O/0kLFHQyk+BSmZNU4LPGHAO70efkTOrW0qMSUwvP?=
 =?us-ascii?Q?yIojCBLy+kafIaeZ5SEPbBUG9GmK3htd6tLtrhg3sLSlaPKCBfTA7I/CAoQl?=
 =?us-ascii?Q?0VljZbJIesebK7n+I8Y4ROgxmDI+JocqDg+Z7sZmCIPsFsf98odk8UeerVTG?=
 =?us-ascii?Q?b3OUCIm4x+X2kdfoBPRBBkjTMTX7ZJR1RU5SASvhwJzXM6RxlEp8HTBM7Z+v?=
 =?us-ascii?Q?opDNJaxeTDJOFaHApF/ZEDL/wWd7qTw6tOSWa7KbcRX2XnBBLrVVZygDrrgZ?=
 =?us-ascii?Q?qVMuxqGs7TE+yfst0FWiSIOaGMApZ8/VbXE7yzslMs/hmvcIFOf+bru/MsB+?=
 =?us-ascii?Q?ksqQC0mbhN+xIQi0DYMuiH8ZLIPNbRaC2bXc5FKylHjk+6AjI2YZaDgS3a+K?=
 =?us-ascii?Q?T0AB4o2o877GgIjd64GM1dRuXKmie/eyYW3WX2HxRfOTKKMrPFM4Xu+fc0/C?=
 =?us-ascii?Q?5w6l6KTvr+4lmJmMdciM5uLFvMkjpeNekFt4/2Bc/ZcK/cJKWS7QqmzR+VEG?=
 =?us-ascii?Q?N7CrJV5m/waClynwgA8msedgPa7LLx3UaPCTu79G1LrlFaLffGw1ILItp0ms?=
 =?us-ascii?Q?Xgqh9Ii6g0hzGu0V4LZZ1nenT+wI35+lc8dQ4F1gU+OOVom9HHxlE+TqdI3t?=
 =?us-ascii?Q?fGSsZHfnWqJHwA/joF2s9EkU2mQnCd3oN4yF2OEzbH03gp6WKxkxzoYH8Epc?=
 =?us-ascii?Q?+Z/WybWfP4V777Jwd/fS2/nMghPj/TEO76ovM4i0sxSsb5bjI/ECACGzppAd?=
 =?us-ascii?Q?mbcCGGW9V4puensYICYhIRyGB7y4HZpGiezOvOvGa7t2rBjmh24u9xYIbAD1?=
 =?us-ascii?Q?HsrChr31i24yVEGUKaQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?io58jvjJTaTY9T6oIAubOJC8cU47RcRjd0+Cyp665I6+rFBiRp77VXj786Ey?=
 =?us-ascii?Q?gdclanMa03Y82XezLE5NXqAyQgIZjjj5as1dSZkKLrqx9GFqWC8rIMTwNbUl?=
 =?us-ascii?Q?JniP5803rUDazXhdx9OFwllgJMQhIXVNnSnNH8HsnEFxAc4Yr9mzpgTf1zOw?=
 =?us-ascii?Q?E3S1qVEpFtFAJdNLH7XkTac3Nte92xiXC7GWNUpEVzfhVthFkGFkUpj0zo7I?=
 =?us-ascii?Q?bVHFGgp7tYlWh25RuPxzg/7EyBV7FpwOarWIoktH+ror2pDU6rsnRWdaCGVm?=
 =?us-ascii?Q?73HCQGF65kMoBuub0k4OIpiLjvmpJ4UzjBhNMOsNhHLlIrr91l2LaDjk2G7r?=
 =?us-ascii?Q?iFHouEld/nn3gHZ1M/aZJgmYtRVkTvZCOUneoB+N11a1sBat7Q/SQkc34uXk?=
 =?us-ascii?Q?3xq9YGyCIVIb9m/MTL7wEfYmgCuzNDUcwyjiovS8rla6N1LyHKwXUellR4CV?=
 =?us-ascii?Q?ezYzvrt4xrAm7X9RGkHOi9avfeUvcAE+lE0lBmhaEwv2CopZ5XaAO1MyyPjm?=
 =?us-ascii?Q?v1ITY9G5bRJkaAVHUWptIbr+CyRnaGh+A/2iinLLXHyTK6mf01/HnEkWhDh4?=
 =?us-ascii?Q?b3gmjOe71J01ZMCNHKoRoEAbsxmd0CRBPMGxvvILYqTsV8IyhnOdk78FfgO1?=
 =?us-ascii?Q?RGWqgdocTylySO6lLR2IviU6jFVG3FTNrvMYaZlad+juK60ID+9fb9qz49GZ?=
 =?us-ascii?Q?ndGzENHxZXhWoRYJpfIm8WZjwQOqyC4ZJ8qoZslPE2gjkE7RHPA2Y6T18+Je?=
 =?us-ascii?Q?fjeUZ9yQAo5eZEPDWTYcCBoVNMsY2fQyCkoRWl89c02EvJfA1MbMnQUr/5u/?=
 =?us-ascii?Q?CAQ5S9Kr93+5MYLL5WWJ1RFB4ZuqekN+lSd8qlQ5BapOF90CfKfP90JpaNli?=
 =?us-ascii?Q?sU6txe668JGpcQJGaTbohT3+Pb2n8cBaVXp1Id2zBpTJzAlZsLLFvdK/nGvK?=
 =?us-ascii?Q?lN5a4TQFJua4UDCtC7j/M23YTSZYSyoLwGuu9MrEz2bmBg/qjPxcfasNA6a9?=
 =?us-ascii?Q?ime/lT7dbe4Ss1lKof14xwIY65NK6C9H4I6VcAn3UbHXSccvgmEoj006H3SL?=
 =?us-ascii?Q?58bz7brxXomaij+Ifyi9MJyRzbun7Np5fPQg8sueVWND7jdLSXIvl+Z/ywf2?=
 =?us-ascii?Q?DKBOxrDXxjuuhdM8VRy2wHO7e5Uid5fdZzBFfXBQ08sysp/Ep40waIicjNTM?=
 =?us-ascii?Q?IY7GNlBthEpUuloXYRFWvdKr3dij3D5nehoqccK/v6X8LozZfdGSzSkxRh9b?=
 =?us-ascii?Q?zjrKclZlvskBYwAMgWyAJMJIQvrdvMU7jafLsCI92Na57/HEA94MrX7NJ3NQ?=
 =?us-ascii?Q?6X0FPo/8660Cva8Cg3M3HPzIjSMd0AUIXlQXWq7KFJam3kGQbUBlMeqROwkJ?=
 =?us-ascii?Q?g6sCA2IpsWYTVDbMpwXV1UIhIxWVHk9Y53IPhj2+OrzO+RragNwOVjofNL/L?=
 =?us-ascii?Q?Ik3VYybCNTfhagK0HZp6PjwQgf/lHQ40qRr613h8wmEkd/cQ8OEiRrTl5bpj?=
 =?us-ascii?Q?qaWwhiibNPAjAdYy7Lxwv7gNP7mgTyi4hDczcxQmDgaj7R5A7DS1dadXo0jp?=
 =?us-ascii?Q?8EspIXRklv0enMc7n2F0hAJkGozhI/hQNrPrvvH0Ycum182ka7g4o3seJhir?=
 =?us-ascii?Q?JNssBP8FyLmrHpMrU50Z8rM+F3x6pWWs6Jc9snyXle4IrMXFUFE311I0AHMM?=
 =?us-ascii?Q?/C5+NIgFaXm94Y207ZxTbhKTjmRuVNyisLgH3mPmuViuX6S0IlJ5QYiUbTWp?=
 =?us-ascii?Q?TXfrhScHLA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ed2b33-5b85-4697-6305-08de741a9ae1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 03:04:35.0382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jVZCHTvQl6bZzWUCkFRosA7B9JfTn7f30OISnqydnuzsWjum8rdFnu/9/+0YMCqrMSKZELqMhpHo9vjcngxIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219159-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,protonmail.com,umich.edu,vger.kernel.org,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,c8287e65a57a89e7fb72];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AA3119119A
X-Rspamd-Action: no action

On 2026-02-24 18:16, Alice Ryhl wrote:
> Consider the following sequence of events on a death listener:
> 1. The remote process dies and sends a BR_DEAD_BINDER message.
> 2. The local process invokes the BC_CLEAR_DEATH_NOTIFICATION command.
> 3. The local process then invokes the BC_DEAD_BINDER_DONE.
> Then, the kernel will reply to the BC_DEAD_BINDER_DONE command with a
> BR_CLEAR_DEATH_NOTIFICATION_DONE reply using push_work_if_looper().
> 
> However, this can result in a deadlock if the current thread is not a
> looper. This is because dead_binder_done() still holds the proc lock
> during set_notification_done(), which called push_work_if_looper().
> Normally, push_work_if_looper() takes the thread lock, which is fine to
> take under the proc lock. But if the current thread is not a looper,
> then it falls back to delivering the reply to the process work queue,
> which involves taking the proc lock. Since the proc lock is already
> held, this is a deadlock.
> 
> Fix this by releasing the proc lock during set_notification_done(). It
> was not intentional that it was held during that function to begin with.
> 
> I don't think this ever happens in Android because BC_DEAD_BINDER_DONE
> is only invoked in response to BR_DEAD_BINDER messages, and the kernel
> always delivers BR_DEAD_BINDER to a looper. So there's no scenario where
> Android userspace will call BC_DEAD_BINDER_DONE on a non-looper thread.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
> Tested-by: syzbot+c8287e65a57a89e7fb72@syzkaller.appspotmail.com
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Sorry, no report link. Was reported via internal issue tracker.
> ---
>  drivers/android/binder/process.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
> index 41de5593197c..f06498129aa9 100644
> --- a/drivers/android/binder/process.rs
> +++ b/drivers/android/binder/process.rs
> @@ -1295,7 +1295,8 @@ pub(crate) fn clear_death(&self, reader: &mut UserSliceReader, thread: &Thread)
>      }
>  
>      pub(crate) fn dead_binder_done(&self, cookie: u64, thread: &Thread) {
> -        if let Some(death) = self.inner.lock().pull_delivered_death(cookie) {
> +        let death = self.inner.lock().pull_delivered_death(cookie);
> +        if let Some(death) = death {

Reviewed-by: Gary Guo <gary@garyguo.net>

This is quite sneaky. I wonder if this is something that could be checked Clippy.
If a lock guard has lifetime extended and the final expression does not depend on
the lifetime of that lock guard, then a warning could be emitted.

The general case is probably very difficult to implement as it involves resolving
lifetimes. But I think a specific case where the final expression is `'static` is
easier to implement.

Best,
Gary

>              death.set_notification_done(thread);
>          }
>      }
> 
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260224-binder-dead-binder-done-proc-lock-e2d4825b2965
> 
> Best regards,

