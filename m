Return-Path: <stable+bounces-76157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C761A9796DA
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 15:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA8F2814D0
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 13:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93021C688E;
	Sun, 15 Sep 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="I0vJHZsH"
X-Original-To: stable@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021109.outbound.protection.outlook.com [52.101.95.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB478DDAB;
	Sun, 15 Sep 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726408165; cv=fail; b=Ebmbqu2vtaA59uor9CWDKBPQirhyET8VyPcTW902NOeWAf5E3T8M90jynSrjm6LQhljQe8QK8dQI4M/Jd781KxOdNAJZRTnfaeT2/w+5o7lKMQK1VK4+mcFm7T8YFsFuZOUkxjdEMYWwt87tHDBg2B7wHtlcKVDf4qJKagTiTk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726408165; c=relaxed/simple;
	bh=Q5roRW6wyTmXHOqLMaRYF5OcmYah7BM3D6/zfUp8Ojo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kfqi/iAleQ6Wkl3mjd4lylPlq7EA6Ibo9Dm3jkc6/WRJzNKxNzi59vnscCUbh5I6QV7DRp4WTbiiZok3DnTpD1QihrXzBi+vKhQ1PsvxK+aNFJqhzQg6p+5Nzc5GwgTfpqJDLH+/XWfkitXegKY5q6eP4ZUNw8MbFd9TUNyPPrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=I0vJHZsH; arc=fail smtp.client-ip=52.101.95.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGjNU4sU/YERdiupb13oxdcSoS0THYciUpynVko972eyV2Hoh+yXghn9h/aiJ8FLZYphdhPir8yKdmTUsY50pdnWkAHGGNFb3pG5YCFYCtdFiYqPPsnO8VpWcLW26uhnNGZW+80uhNQYevutnKQ6VKUIQrXjwKeaPf5ON4uocnfMkWRtPSTbUYt6U05yafjOAd6tyo86R7Ny8gRT2mJYUsUlQHguoga5XdcdyK9g4E6NIpPlXkzVfA3JlXCp98GeKRrLQVlUo7VzJwDPTzjjQBqMUQPss7TUEQtQOmj+1YKsVS+7WfA714C70HWH9D3mBPZjqA1qn9Q5a7F14guVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/p4j+Om7FeTKntQHnDrhWm4peC6kPeGJyEaVNa49vQ=;
 b=HL1dwssG0mE20g/YMBhP2EqyVmLZavXzNeFu7GnZOisg2/6UOQZ50/ROI3uBr08AOjbzJqdNcyqYNiG+zl8HdXXsb3zwXRZKQCEqYwKgp/Y1KcmR21Q5bYlKFx4dzmrAVYZrRbd2kk3UXMhye69Y2hwfgoNOFdFh5PT6hcRG18U2Xa7y3TkpyskU+VpdmLXQJ3G9XvyjppsdIyu5Hgx/Ol5+yZCjWNp3gtQgPvfDvFf1wa1yh5AkTUccXz9XvzLgZP4+I15m8IXj0vxq6A3FhVaaDCFpaJMnKUT3eJscGgGf/lezdBYzT1HIsTGr53WYF77qbOYcSQWFM+GX4sidiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/p4j+Om7FeTKntQHnDrhWm4peC6kPeGJyEaVNa49vQ=;
 b=I0vJHZsHOBcMLKEJmJQzYDnoBQC5JV60hn3r+QGfkRt8KWBBJ51vFTeFhTHWolzsj+8gTNtDK4bmJ8tLYOBAGS5n967efH6f5RxZGII2CvkroKI4iNuoSW54jMDjVyaMhLVUczfXInHrED37sQ0qCGYP64FzEjJoEmCDP5sXl6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO6P265MB6750.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 13:49:20 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 13:49:20 +0000
Date: Sun, 15 Sep 2024 14:48:53 +0100
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Trevor
 Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] rust: sync: fix incorrect Sync bounds for LockedBy
Message-ID: <20240915144853.7f85568a.gary@garyguo.net>
In-Reply-To: <ZuUtFQ9zs6jJkasD@boqun-archlinux>
References: <20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com>
	<ZuSIPIHn4gDLm4si@phenom.ffwll.local>
	<ZuUtFQ9zs6jJkasD@boqun-archlinux>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0587.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::15) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO6P265MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f21bcf-5289-481a-4b38-08dcd58d324f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yjqo3eHlK2WUiQoeMnvDe6MSTVa1I7b2LL4ACWziRDxr0bcyFYQ+lrLGN3dv?=
 =?us-ascii?Q?NDM6OY8U8uHu35EaKT1ZWgcaZygtEVbRwpfSBK6WRxAj6vEKE7Q714nR92ZK?=
 =?us-ascii?Q?U2LwRWeYwjzHBsr+tNNyt3cs5SIAbG1St+iV29Q3LeZ9dNekunGGAXNvRVmt?=
 =?us-ascii?Q?WQOMWGfJRKcCDaVbs2hB8LWosCFWBxCfoRuknL3fPrqaXtZcQxNHvTvgztGk?=
 =?us-ascii?Q?nfISMQrV4bf65E/rhbba0UUtT90VEHldCvmSbAE+ESrk+bjKzG17tvUEp4LS?=
 =?us-ascii?Q?Di+RVS4s+zSp8MNq4++75xAk5rbqzzoJ9OfR3GwXZD0GLNwjsQnNEI+/Vxsg?=
 =?us-ascii?Q?m1qhNkuqBZUEpwA9ku6nveprEAZCC6STsjQpjT5Pr0S6HACj8pPHdOL+d6ro?=
 =?us-ascii?Q?hyaDnSBUE8gUew+Qbj8c2pjpO0WD+NKR4QF6rVyKSDBMcWJ5c+7s0T3Hgskf?=
 =?us-ascii?Q?pu6w8uRXK9GjB94UDn3tOEsOxP8Tnikwkk4VQdB1haw6TFzFFDLOjFNfKGJq?=
 =?us-ascii?Q?30Th2ZFVTzMgHWqJAlRxOCSguTj2FQgu3VoIsG1W8Vo09jnfJcrO3bws2tnS?=
 =?us-ascii?Q?jyk6g6FVtuzVx0wipdLiY3M2b49FUy0Nsc6yc2t7UnfyNOoM/M/h2E8wltJW?=
 =?us-ascii?Q?pZNSZqNiO76AiIMvg4Kg7x45H6ZQJJvWP28sHk9GCP5LYa+Yw7gKzd+ouMeH?=
 =?us-ascii?Q?UA44tIsbk/0cSSFCaztLtJLWI90EMD1/bHL5JPqqVe1+rmruwk0lvoX/IrbF?=
 =?us-ascii?Q?5yc1akQr1gNMmnuXVzNSkDxywRQOIXyXADljl+a34PJhSG2fg+zNO3U/ZA/H?=
 =?us-ascii?Q?7BI+Dfv13WnWWdMdDUyfDg7gzSLQBcp6Clf6gH3H5N4/MjRzgfIfQeWvNTmN?=
 =?us-ascii?Q?UUK7Atb2SJRu8qkVBfKobPLfsiI/Da+mUlg+kt6KFhQq5ITiGmNb4FETpsfd?=
 =?us-ascii?Q?cz+NqD/J9FjHtQjXEuXRQTWJ0MEAocjLM9PhfACaIY1275T7JgsAZaqWeQ4l?=
 =?us-ascii?Q?VzAWdFl/4frvac1dpMZmsRe+77DgpCUI2a/binTCje/BepcIKqB2aLZuYgiC?=
 =?us-ascii?Q?hecCPPqqLpfG2O1S7/lY7+4c2lSInvN0iNfxlAJ8F7BDV3zXvDMpv+bHzhaB?=
 =?us-ascii?Q?nFnW851E9lKZtX6uremx6JgAmrbRguNtE0tqnkTncGp0njEsZXLaFtyWwnpr?=
 =?us-ascii?Q?JEl5QKyzi0iSnLwsn7Bo4lnT5/UrjW1KO+uOxf4PntEDlPPo6INNeIdM+EfN?=
 =?us-ascii?Q?oQbsvuiaqFGsjXHN3URynzHhtE6CUYOPr04Chydps+J2lIRKRhEO53Y8aRsV?=
 =?us-ascii?Q?iz14ee8qgIzL4sIaA13GiA1qOep1/ghZ9iP9XYyrMnpVlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nnIQz8FCvqH1kPLNxqwAF1q2WLIap/2Nl5w0ngzCaAzvI8v0f73/+6TNYgSD?=
 =?us-ascii?Q?dDT9YOqe9R2rQGl2rYAAF0D9Vda7+xljFAjzb3+TQ66LFCAK+sUua3znXdZM?=
 =?us-ascii?Q?O1dlTGvTpCJn9/28deix2SCJxGKHcT22yFCv3tQHPjdibhiNUwzcj95J1c2v?=
 =?us-ascii?Q?fWyoJPZVOD3upjtDOiYpG/76fwlDKicPzXoJ6ZmJXJIUpOCRPgIRAqmAA8hc?=
 =?us-ascii?Q?E0IR0PiRTnYWtkMC4vXv/5K+424s5xcH0ownLqK3GepesV8kNEb/JSLdjge/?=
 =?us-ascii?Q?wbFkX8FRYfjWk3WYPcwCeJHpT67pU7DrMvITIBSG28UyA7o9KciBHHDhDQxg?=
 =?us-ascii?Q?IRndCv0UmXkkNt9RvNGlDMwyYMxcdgRAEKZ14iLzmgBpkd9VmSe7ywLv9PPF?=
 =?us-ascii?Q?CO15VFs4/vNTa0zJNepOM91ujmumw7vI3Knvg7AxCgJGibHR7idqjfT2k+4u?=
 =?us-ascii?Q?B8AzcV6sc3vPN3aCsaWP/XWLOauQdtFBxhRFIJTa1jOGL19o+3V4vlGhKbhS?=
 =?us-ascii?Q?UL0qe0+etQ6JPTI/5kP9unaVN/mB31fWh7UHlXQhqFyh/xu8sZ6se0fHwsh0?=
 =?us-ascii?Q?l437s680USMaVrLumuCqubn4JkM9IIIxyfCXEidlauG4boj6naaVFi2V70B/?=
 =?us-ascii?Q?maV80QRMlTNTvu/ovzmcKNo6oRLOv8O05yZx5IZ3b6AjqmiPz9a6YIYay6Yy?=
 =?us-ascii?Q?9/XkPfee6Xu/QTlZcc9INzMFIplE0V+hKvix1N0CN9pbuPSXfjOm5QgphTAK?=
 =?us-ascii?Q?F+txgODjJ2WJN3dPOa/Xyl0aCdkX0EA0DaE17l12s9P7QWz5WKeiuFGLoIt5?=
 =?us-ascii?Q?XylLrdfKtgMv59tbETR3rEtGDFwdurFQRrEhCkrA+xIw3hQfkSvZbLi7LpaB?=
 =?us-ascii?Q?JkCWmhgx37BW6q5dQs5duznQdsPyw+YjCfdd5dPgStNBQDeIpt3RDs5zg3w9?=
 =?us-ascii?Q?EDUsrp85ZBkd00ZjETk7rBgD7U7V82VwuzlVTXY+lJrs9KzFmOlNUEcb8koy?=
 =?us-ascii?Q?I/uXn4DFUJMPNGcZr8xPtk5K69IyWPZP/vyw8t2ix8noF4+bdsrvC7yBVClP?=
 =?us-ascii?Q?B2oDtkZxxL+4rnWhusA2YGMQsr6Vm3VYZCamqp4yw1irml/taqY7EZKgyOhN?=
 =?us-ascii?Q?7qXzwYkgq0q9uaw4TBMmyutiQ8ZZKuj2ok9aohliUiN467m/WrZUTREuf3kt?=
 =?us-ascii?Q?Bs4ol8VRqTFJx4j0GHsNdVsZb2UNByHdeEuajYlk97BYvbV6GAmPMvRKJWM/?=
 =?us-ascii?Q?p2caE+YjxyooMbZ7d+uFKhxy/roEtk2cSBg8SYaCjXbQJEkB7xQiwjCVQgKH?=
 =?us-ascii?Q?5m0DK/CtDDZ/58Bc3R3Dni4BnmvZOuMT8mAtrmQRJdfNfK/i1Q0JB6L0HOky?=
 =?us-ascii?Q?KffVmJ9i0q1kx8ZUzbjdBV4egKBbACMdRZy577eeox0aALL4fOPfkrNsbcIp?=
 =?us-ascii?Q?Dwl3J4bg1bs0uXioovz+AGepsqFlaio7vs4Rqf6BsRmvza4KC6DRMUHbZYmS?=
 =?us-ascii?Q?1SsVl8v9oUg0J6W0RdYzPe+MkmDXnDUAc8e8uVRIroYXX5PXGiTESZoJAF+0?=
 =?us-ascii?Q?LQl09FUulJ17KCgTc5muwY01XnM9zILF82HfsDzY4XjEFnDYLGQoY27GnZK2?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f21bcf-5289-481a-4b38-08dcd58d324f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 13:49:19.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ms+xClzRAy7iPtlsofGlvpTx+2LurHsnYeL8tLoPNpAjxOAx8Lq/2GaD/XAmgDMK2zR6dk8j6GWjKpnvdWAXlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6750

On Fri, 13 Sep 2024 23:28:37 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> Hmm.. I think it makes more sense to make `access()` requires `where T:
> Sync` instead of the current fix? I.e. I propose we do:
> 
> 	impl<T, U> LockedBy<T, U> {
> 	    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T
> 	    where T: Sync {
> 	    	...
> 	    }
> 	}
> 
> The current fix in this patch disallows the case where a user has a
> `Foo: !Sync`, but want to have multiple `&LockedBy<Foo, X>` in different
> threads (they would use `access_mut()` to gain unique accesses), which
> seems to me is a valid use case.
> 
> The where-clause fix disallows the case where a user has a `Foo: !Sync`,
> a `&LockedBy<Foo, X>` and a `&X`, and is trying to get a `&Foo` with
> `access()`, this doesn't seems to be a common usage, but maybe I'm
> missing something?

+1 on this. Our `LockedBy` type only works with `Lock` -- which
provides mutual exclusion rather than `RwLock`-like semantics, so I
think it should be perfectly valid for people to want to use `LockedBy`
for `Send + !Sync` types and only use `access_mut`. So placing `Sync`
bound on `access` sounds better.

There's even a way to not requiring `Sync` bound at all, which is to
ensure that the owner itself is a `!Sync` type:

	impl<T, U> LockedBy<T, U> {
	    pub fn access<'a, B: Backend>(&'a self, owner: &'a Guard<U, B>) -> &'a T {
	        ...
	    }
	}

Because there's no way for `Guard<U, B>` to be sent across threads, we
can also deduce that all caller of `access` must be from a single
thread and thus the `Sync` bound is unnecessary.

Best,
Gary

> 
> Thoughts?
> 
> Regards,
> Boqun

