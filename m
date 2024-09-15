Return-Path: <stable+bounces-76164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B57979797
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9024B215A7
	for <lists+stable@lfdr.de>; Sun, 15 Sep 2024 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC711C6F7A;
	Sun, 15 Sep 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="y3iqsZ9p"
X-Original-To: stable@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020076.outbound.protection.outlook.com [52.101.195.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1135B42065;
	Sun, 15 Sep 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726414589; cv=fail; b=AFavnHDNOWYKs2S+VbqQ3BzdcBySjutI+FEXc59nJ/Uz97zi1j3y/DJ7bDOZtZm2R3d9nCjqBJxk4ukmzvrnk4vRiJ+KVyaETd4Ftp4COvG+XudmNauYW0v05aY6GWno3+qgbKKmWUz2E8/3+/y3v6RwL/xJcJLjYSBuFIkrvR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726414589; c=relaxed/simple;
	bh=sKKWig14A3B6UPJuaJk1iZqxWZAkUiSAFcftlUYrprc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=drLhXcgf+9BIhaaeUtNRw/jxqqX2J7wTGhmWRZ2GPzrfGJpn3TsEMwuw06t+yFMp/fuHj94ZGQ3fExXyvzzbX96uNF96pHjk36HhkxOVy2INl2MJZO5NzcPXB7AN+U1qVyLV3NYb0Ltgs3v2ZVRKilvxh11Mok26Do+FzC0OAto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=y3iqsZ9p; arc=fail smtp.client-ip=52.101.195.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDvxuvtZkg9LdFm0U/VS5Y4WPFRmySrqKmlxaKLRPUlEk4++5I8mNyfCIXJE0F6ULp1i0MMlR16vkmmFh3leL25OhN7Apw6UysrLZWWEWto0nwJCWWWpWfVcrmf2p3HWXDf/fEVej3irME2DpKiCaMI/LZNZLQc6zF8guBzW6jsHbeY41UjOaXU/MVyd4tXmF3dUqu1YYE6JKiNF9s6nvS2u3GxhTcCMOrvh4pZMBJ55i5Ga25OcvMVoVCpAS/7aNZWCCs9sBuRmlITrbWpZMVnPmRQ8zI3yAZVtCiRCFT+r1gpNyUdRXB2txQr9x3d1ixbgvyWV8ygCmWV+t14iyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zgcql/QK7X1M8XCCIrw5pkDAf/bojtxOwCiztvVjos=;
 b=ZFhzpJPamHgE68lZLvfa4GTLCqyz11cUBrjwFc8wJXZH3BAJur65p890V/yQiNPNB8hMZsl9IRxHsHU4wg/WNrIi+mibDARYddYx1zcYe7ckJ6tbj07dQo5OwV1QeaPCdtCsXOZDwt05xAck6yqvPudGT6QS6ZMZ5C5ojhX1OkfqChXtRC6QA5UfRahxMbwMVzk9ISzDo56lWZEPk09GfmoU3CAyixyD8D7fS3+4Z0+0sDWlES9AdBM9B82dxfxyHtnqfwywcWgs2QRTVsoKfWAaRBkZGHo3+lXCqWCeHeTApYHU/tsvydfbBOsSY63+Uq8F3oVhfh/wRtEIqlfT3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zgcql/QK7X1M8XCCIrw5pkDAf/bojtxOwCiztvVjos=;
 b=y3iqsZ9pxN+5j5d9muy2sObx1LsPTJTIXUoMANV+H9ShUTC4VUddliF9L6WHK8gBFfpkJT6g0Kwsu+cpLRJq8SL8toyXB14yMvfCj9PgsEFQ2UI+iOoZHFxeVopUtHqu4RCJzMu0+ETyYAQU1bZns1vguEQW45uWssw516LmzPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB3192.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 15:36:24 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 15:36:24 +0000
Date: Sun, 15 Sep 2024 16:36:22 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Trevor
 Gross <tmgross@umich.edu>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] rust: sync: require `T: Sync` for `LockedBy::access`
Message-ID: <20240915163622.5f3365fe.gary@garyguo.net>
In-Reply-To: <20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com>
References: <20240915-locked-by-sync-fix-v2-1-1a8d89710392@google.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0356.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB3192:EE_
X-MS-Office365-Filtering-Correlation-Id: dc15c631-25b0-4384-d6f3-08dcd59c2842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h6QBqj4KWa0WibANf/nKJiBiR7xpt3CqPUjKhqmTJna12znwGD5l/K8j/wGm?=
 =?us-ascii?Q?VwYa9K9NIJT4ubzp4yGlbrtC/JjnwZxel0PF9hXj/jDHHlIBSnnP35Za/MC6?=
 =?us-ascii?Q?V9/wBEpZ9tXglHI3fNKUbj1Eux49CkCPGPJaHhHjagg+QLIUEDMuCZRIghyK?=
 =?us-ascii?Q?LOJgDWcOqyyqzZEe0imNfW79l+PE36g6vLMSHxYmUqfaKVmhHEfTkTDwUkIu?=
 =?us-ascii?Q?MIqqtcPvheo7iXob9pd5xzJGSVFSi8VVnht3cfQMxvkQtLJNT/iMjKvnT8bE?=
 =?us-ascii?Q?NpJAaTHaT4PjLhole9a7Fcfa5LbX4GBhzDh4LUVtuTEvPuKa9BLJOvrBpKq4?=
 =?us-ascii?Q?16UJHwrCQweJjf6952rhcVjUvy54XpJySShDNHkn49C0oJSZAujndz9IN6b4?=
 =?us-ascii?Q?bwrt8EwXHw+HXNtrjtgkmgCrsYYKAd1mujipOce/TbqxZ9HbUm/qlGTdXdO2?=
 =?us-ascii?Q?61aY6M82S/q3t6mnMtNAhLAB+1QfJ8gyujfBXgmnz/C4A6RnAHwqeFlLImTe?=
 =?us-ascii?Q?L6SLuBBbTZOfMBO6PTirrV2HLsVN1uuI+J45ASQLpJMe8nZ98N80ReVd0Ctt?=
 =?us-ascii?Q?aTGPoc22kopCTgnHz0xG3qrkEWmy6XXzn/UE6+VWFuwT8H5KGtJj8AkNRR+R?=
 =?us-ascii?Q?UzseLe3OslGmITtaUgQFDEJDvhqsXyAnwbWiEr5q5LvUb+jDNL0l/fAb8ulm?=
 =?us-ascii?Q?KqqDeNeJ+eenWTo1cdwgHVbGZ5hLgZnVPMSp7TzygZDdXudfmCzGb9JXW5Ty?=
 =?us-ascii?Q?8MvegojR650eWp/SH2FxVwpQbmL9nhRogbcPurZ4iB1KXX0+fURWOTU1K9Zb?=
 =?us-ascii?Q?JvvXZ+1kx3X9jdrzHUIIterdLIS4P9SLhK70xzVkQtZ/byN9Ji4EdwjInbIN?=
 =?us-ascii?Q?LsLWseHOhEKwJmNB/HW54IMJ5nU4dJkbtDG2zqq8OxYQeotOJot/ozy1EnIC?=
 =?us-ascii?Q?SEDQHwbXd1wVUplPqA8kgc0UbrqnmuSLYBlse7xwn3TBZmL+i1J8QlFScHhW?=
 =?us-ascii?Q?5aCKRUByxpPdJojg7lelYkdrCyI3pfOE1UHMzEie++6bQACIY5nxClUY324S?=
 =?us-ascii?Q?ISEtS8iqB8d6S/KfU5PZ2yMa0n9fQ0r/9VtMWB229Gs8f46EmXya/YlDzwW0?=
 =?us-ascii?Q?RHYhE6QRdMya4W3VY5tzIqxDTrDzQ1Bs5AZ6Uxen7LuzL8+J/wXkEFvAJe4D?=
 =?us-ascii?Q?MNFwyrRvUejhbkm0UHGtPj3n15mJuwKx5JfpNmvu2U/XHNTjDTSi1Dx+6+2u?=
 =?us-ascii?Q?JZdV0jKG0rw8jnEyURWn/9eiIoNiEw0wV2JPkjTwby6ffQq1xEfJqErFnww4?=
 =?us-ascii?Q?OjdnjZC/97+4Z8/nRqzgqhU5diXteXJaNqPozrYXxQebk/JOFYZaa38TnYUX?=
 =?us-ascii?Q?U9YXPE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D5U5o3MaHipp6jDHPBxnRjRQswV4qaHelvAz567ES9IRb8S4RAieFOmYOAFY?=
 =?us-ascii?Q?2WhMfILy31/wSJXAU+W1/iwY9xOcq8oPKqiGj2Tky0muK3vn4lJ36CPpBqUQ?=
 =?us-ascii?Q?aTKED5PXXUNJOZ/r8Pyhp4Fj4T6QvWwUFvhg+FLsVd06MUBfyhSgomY6enNM?=
 =?us-ascii?Q?KwFN1ZfEWxb/3YubGdJFhJm3O94OFWUEGEYVZcI9/LTat24nuwV+zRoYePye?=
 =?us-ascii?Q?H1u+s8WJMAnCs6ev84usShgAF1Z9WhL1cqgJJjJ4LUOaQJHPDc7VFXpXm/Gf?=
 =?us-ascii?Q?N/uR/lPfSxE/4XQ46lD2raPVwLkAoS/uWsRSWSbikuoi/Yxrs3PFo+sP+pjN?=
 =?us-ascii?Q?jiSUajoL3WxxvMETXx4nCchfPlFxsF1T0nd0Qhzt+A7UzmaAcZL5aACe0qk8?=
 =?us-ascii?Q?4dcd2R5FJUFo+Bl2M0/ccYHRVP/77+mSHVIj1DEZa8sW8TBghVwpQTX+M72R?=
 =?us-ascii?Q?n0qCq96rcvS/5GNS1uYnz+1VJ//Y4JI9FpuN9+bZxAKIxBOoB0JigaO04Qzu?=
 =?us-ascii?Q?hHY88vDVG3aW/V97E9dpgl5hc8XVZCSmXD5PRRrj78LUhLZotP1AEVwxRvfK?=
 =?us-ascii?Q?MsyF0gWLGcZua7t3x1SqgrGrcPe6sVdRvtJUYVqR8gMGJ9thjJu0lX+MkGDv?=
 =?us-ascii?Q?NsaCjEsOGPq7MSavjSfBa8soaNlx3vQzcz+lU+ARjP9F0oNuR7i6B9InDbvm?=
 =?us-ascii?Q?MecKXU7yF3I5l6oenJhHH7G7+1NlvNimgHm1ySxE1zj2K5DgSz+955tIys8f?=
 =?us-ascii?Q?/qIkCkUKeJA2351w/XsYOr01Z8BGrqWsZRsTAzaFOPXHn6hfKdCDwDujSCYi?=
 =?us-ascii?Q?1bBD9Pf8zUKCz19VxrGYhiB4Tr4JoeGYwujn6UCLrvKNEaDdyvXHE2tt6C/q?=
 =?us-ascii?Q?ETPIHi+oNU1h6iZl2Htj6m/hUV+YWbSYR1JZtzyXyBXir1hnhDrCEknw6DqW?=
 =?us-ascii?Q?SQvN6Tk4m2WcIWJlPthPNl9K9UD+ojCMZUwQQqhLTmIn1U8hiKJRAjEg5Ymp?=
 =?us-ascii?Q?TtaEE2gtXNd38QmFD/qOIRj0IVQ5IcNacKs13QR+B202CmTHCGGRyR1/U6ra?=
 =?us-ascii?Q?WzHgFGVUvEyhdSLIJVb5J7Jd1NduEKqQsl8LlVJZavMTQ0lCK8xyedqTtcyW?=
 =?us-ascii?Q?drnX6cWru4UMMDu6k1Uk65XhuSY6sB9OnAZ1YRGyRZiXZ+rEDTslMH4Pe11s?=
 =?us-ascii?Q?Y3q3Uw9to+4oD7anKqD5Kgt1pKZrfNFEhGTg37IwCbb6sfpH5iXVXaRkTjru?=
 =?us-ascii?Q?glGUyfriFJc/L6gkGASmL7ukgge8IFjQnicNNooDsWv1hzwYcciKgPsQoee5?=
 =?us-ascii?Q?t1KJOkTgPyMKaIjWiyQNqNJaQFO+sA3R6MUetEheOTtFNG2xzBcaERqVAnd2?=
 =?us-ascii?Q?zXDJ5OvhhdPqQRd9O0hS1x/MN9F5RrNO5L95uLCZAxyzE8QNZGGgwJbVghMF?=
 =?us-ascii?Q?w3smhmCprcBs68Qj1iMqxtJnfDcLU9ju29VBKnKDUGGihBRi4QDbzpi6x+5a?=
 =?us-ascii?Q?xW37yWT3Keu8QZJGZWpQVvsAzJYnFg5Qw04ZeejOAmZgYoXPI/pukDm5lXkC?=
 =?us-ascii?Q?Ud8bV1bUV/X1iCElIFBVXNgessnHJjJpAdmZmms8RjNWg80TBe05XJVQqkL9?=
 =?us-ascii?Q?Qw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dc15c631-25b0-4384-d6f3-08dcd59c2842
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 15:36:24.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlbDd0HLAtdg26+QLtaSoxUtqACba/YHRWCcALGf417URm2zsI0fPZIGgThAqlajWC4t18dl6uY4RwN5agJP9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB3192

On Sun, 15 Sep 2024 14:41:28 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> The `LockedBy::access` method only requires a shared reference to the
> owner, so if we have shared access to the `LockedBy` from several
> threads at once, then two threads could call `access` in parallel and
> both obtain a shared reference to the inner value. Thus, require that
> `T: Sync` when calling the `access` method.
> 
> An alternative is to require `T: Sync` in the `impl Sync for LockedBy`.
> This patch does not choose that approach as it gives up the ability to
> use `LockedBy` with `!Sync` types, which is okay as long as you only use
> `access_mut`.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7b1f55e3a984 ("rust: sync: introduce `LockedBy`")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

You probably also want to have a Suggested-by to credit Boqun for
suggesting the current implementation.

Best,
Gary

> ---
> Changes in v2:
> - Use a `where T: Sync` on `access` instead of changing `impl Sync for
>   LockedBy`.
> - Link to v1: https://lore.kernel.org/r/20240912-locked-by-sync-fix-v1-1-26433cbccbd2@google.com
> ---
>  rust/kernel/sync/locked_by.rs | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

