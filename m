Return-Path: <stable+bounces-206192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E90CFF7C0
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 19:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F1973218924
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892133C18C;
	Wed,  7 Jan 2026 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xo4l3SzU"
X-Original-To: stable@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022137.outbound.protection.outlook.com [52.101.96.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8872A1BB;
	Wed,  7 Jan 2026 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807086; cv=fail; b=elKjERpf7OKASirAUy4Qc30UcxxzEwJqEK9hm0D0FM1FzfX5enAmteu17blOBc18qttZAh3HxN9kzUs5yjSSkfepZpgWbfYtpRILi7bS6uvUn4GyJIefCfxGK1R9W/FpnE87z/WkwdpLB5HmWrC0lmLnxDtvgm7HAlqFTbgZFCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807086; c=relaxed/simple;
	bh=WE522NROzOFvnmLK7woBWIUSkS6F7ealTFfSzMjbid8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CmqaIMxSlj1YhErHG+CrkUx6CkyHbFos4opOtWjyy1/f5Ct6Dz7NHSV+uXQ5j71y9Lfbt7/Zbm8WEdMcfNPxGqFzbu8sPtfustdt5jw24WBglUtSYn0IsheY9J4DkBkz/LIYUSTGRIWVcwZME5JlqTPaHZ2tw7uAqSy3pjzWWWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xo4l3SzU; arc=fail smtp.client-ip=52.101.96.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnYOYzaBfoh+wJ+9l6+cor+PEZeKvfDy5TxRi/DxD+HSQxLMxptCwGwovPBuZtvgvr0TFugEm+nhHyEpFw3F4ktQEBT2fqLkO2w1BWE1vd66RCqhsi6NSC9UoS6Azhlqq++Q0DNWAgIS80u34P710pFh7q2jB0uc9LNRVElUiz8gyMoGjId+7tK/M480tJBg/f83zHYCDevFPDpuQPzsH7sbfzr2dIVAAITivuiHkPOq1tGLGEYT4NM5MjCOC9I91MC/qhKFk1WAYAVl+NxRp+XU43A3XTLkIq3g8UXsuIg1tKs34ezz7L/1reZJrZUgfcTWpjoL6k3e5PNH3GefwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69QxVAR4MPVUi3Hkz3uaJC6ri1nJoDRWh6oF4oaL4cc=;
 b=HyMrGYssOVdXWtKDvkDTb9aP6/r5nYIboMOvuSNCFXwzGmZu3zkwu4MflJ/Du9812eaDw2LRHcS3fzXZiBtrXypezJ0Bo1lLTVzEhG/HNPmZOUCNR305LicJ0MgJKh/IAOTdL/ADFhITE4gmwuIbM9eYiEXFmiXfw0Xqc/M05mYg0MztlAMsR1Zp6jwZ6Ub0AVaB/5gFjfzWhcA3CRPpyCe+HCLnNC9IX8dttdDSseqveeofLejv9zSaeHvoD0eeZuIGe5H7gUSjmBRm9iALYgLkzU0o7+TwpYugFjjpPzyqpebeP4Lfxf+CaCR+JJ4mdnTKfzqofhlr87h5Ts4lHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69QxVAR4MPVUi3Hkz3uaJC6ri1nJoDRWh6oF4oaL4cc=;
 b=xo4l3SzUsQfEhAErEZHN2/OmN43Vrosho33tYBUH7Cm86+tigJU0u+EpUAX9PKW0PzTF3hiDzKZ11vF3BtZAjJxKLFh0ascemfcrENgbGz1dKGS9mNX+Jci7VzdIZNpHq2fpXHrz/XxJZ8NcoIikVZ1DX7OCzXWbxe+gieN+LYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:31:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:31:15 +0000
Date: Wed, 7 Jan 2026 17:31:12 +0000
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, Christian Brauner <brauner@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] rust: task: restrict Task::group_leader() to current
Message-ID: <20260107173112.19b7f5ca.gary@garyguo.net>
In-Reply-To: <20251218-task-group-leader-v1-1-4fb7ecd4c830@google.com>
References: <20251218-task-group-leader-v1-1-4fb7ecd4c830@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f71ff8b-055c-4d9e-918a-08de4e128f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ey3OSUEHaBFc2u1dQmojxrOrxwzEtOLe8aOstAfr7itDdjJxtF56bU2dxFoi?=
 =?us-ascii?Q?YZ7zevmyaa4amFJ9fBlo2PJg8x5VbaYLcJVRVi6u4hGI3BaujUt93kkIWaeO?=
 =?us-ascii?Q?7Bp/7rJJyvEs6js3SzsSUm6tXseZ5s6jI+2mihNoJAMO5nLthH9zq/+llPG0?=
 =?us-ascii?Q?z6x4b8/PqUPq+Kw58zlPpG3TI26ikLxMeYcYM7TWABW/t52KmOy7VmgZimYl?=
 =?us-ascii?Q?Y5ldF5xM/3v1MIC36/BiZiY20SSx38N1kosVTbaOkLZ3eEYz17SsFzmk7+/7?=
 =?us-ascii?Q?rqS99UcbABTaSFrCiOTermvCls9rhOU2FElomfV9WwZ6OoilgSFqvWTGoIN5?=
 =?us-ascii?Q?BVBG+tIPzlaFz3gX89FNeT/+PlLBkN1GwtOkUHGH1VbdEzXSx+6FXlkCXg6Y?=
 =?us-ascii?Q?wu5NN40vCJKkNFW1xVGNVnSY1UXiZnWVg6GUiHoI+0/YFKwg7LOcdHum/UFe?=
 =?us-ascii?Q?s6BurV5KcSE9eaWzZndmm/oXp/bWiiKeoh8HAxFNtraBzxR+VKzyXOWnyl8p?=
 =?us-ascii?Q?YAMe+hpmGHMyyLJKHpb7hR43BiFJh+nAxnotFEvz38+E5z8okeeHuhrRzkMa?=
 =?us-ascii?Q?kinxqdHhvtL7C/aXIYBejHMsubETB4u8wH2yTK/VfmzFWleleWuIZ7WzPi5Q?=
 =?us-ascii?Q?YVuwjux2p57pK4lLC96yXPBIMFxuAWyMhUzqvF2lK1UmVuckCe1EuXZKD0Mt?=
 =?us-ascii?Q?tbCidLVuyTyplA92SDdtC2dlkr+GvmVvo7pP3RcV3sACLk7aG84z6m0RxiQs?=
 =?us-ascii?Q?FIVUOhPz9y10Z91sWnrH4hQG+e8gfwgApAgoIMWQtxtuoBJR2Nyfi05p+hOH?=
 =?us-ascii?Q?EFK70FbGtVOIIQvu12f05v6MrYOsgSa1WPGADwOP4irD8JQM5dqU+oLa/XBh?=
 =?us-ascii?Q?UQrGvsUr3V75fWH+AsO4MHsDmMYR5jkZR7BW9ak6QtoOllrCMlpNLrBWpB6c?=
 =?us-ascii?Q?RZn+XP4VERP3GLjgI1ff3Ws1be4yHQqnoCFWpZnQcqdY65WUYiMLLLYrktHj?=
 =?us-ascii?Q?ipwZsQekVCtr5FoTY84UStr6ww9vpK60CxTqeEh2oPUH6DKyGzkBATWDSiKh?=
 =?us-ascii?Q?dvmuI5f9vrrWHsPWTjASgYf+YmfoVRBObWLk4dfMLtEFbvf6T0zv4BCnDFq+?=
 =?us-ascii?Q?zJWNzcfOl8yzf7Imcu7tGIlGKM31GB/h7g7+AEV1wnZGENfAX7awFqC9Lttk?=
 =?us-ascii?Q?mvC43ek8kUXEYIifbmjKnYk2olcQc6Q1CIxG7oFTv7sKRY3xrbg4Ifef85Jm?=
 =?us-ascii?Q?pmcPYvJm2zvdoKGZWM272zHCaoqi2y/Ddxl+jgrETvQlBwyTL1d0v5jt19t9?=
 =?us-ascii?Q?WL5Goylphm3fcHyJ8+1/JtZ+6zhPot2I+cepEx7PnCLCWEh4N1CrWMyKwg5H?=
 =?us-ascii?Q?6vieYxbAh9mQMDsMEBapVRuXhp9H73eF5em5mAYO2hzE3HTOc86Rhp/tLE/P?=
 =?us-ascii?Q?WLG5yTuCOeTk6nir1T/sMV0WY/TZ2Tm6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Qv+el0nUQDb4AF42bRL4sGU20YO4cuA0mdvWUkcOkpTkcNkOBYAmxhxc6Ki?=
 =?us-ascii?Q?nBtJb4/ub/JJy8evoe/Y/MpQCciDAm2FJnmdRUt+4K12ChYOalsij5UhBcqN?=
 =?us-ascii?Q?6sJ40nVF4w6mPrh7xpDM3MnonFffn409gXDj8REeVxoBrPL5zUw26jV0OQnR?=
 =?us-ascii?Q?pZOQ8kD1aS+L22Q3zF4VF+i3qlAz23GGJejPj220dIQ2AJKikdiNbycKQmFV?=
 =?us-ascii?Q?KBPPE8l3QZlop07jEZDwaPcFfM1qxnbyKKBwk5eYanaL8q9miRqlpC+Cw1Y2?=
 =?us-ascii?Q?5CtaR3/gkL/lFChm0sAMN/yT9LHcy+2A6w5cBdSyEADHpAbC7Rtl9/w4sHpf?=
 =?us-ascii?Q?uGIJ5jzen1Du74j5iJ+IPw3cOsMlMqNCAghr24l+t0COCNuMgxE1cLOtUUyZ?=
 =?us-ascii?Q?YMPjU3rHzU5CJ3hrD3mozfOtCk0hlMAO3y4IwOXq2asK/HZepdhV6BLvMonb?=
 =?us-ascii?Q?4Qduy/su+bGVZcCAoGO3yviytlHLWDECJSucYom2IY8l7pNe9qvHHm8+1LAZ?=
 =?us-ascii?Q?3MM23KLjpDLXgLznPQ/kzfQQDKjgi70lSRoTxE22prUbGkesvntuaq/TNlD/?=
 =?us-ascii?Q?gGV69Cu4/hIiGsgOP8NzUkTaSmg4wANbzAsTTrAXvhiMc4TSmj7eR/peEX5S?=
 =?us-ascii?Q?U+6Mj2zbwSmF+wypz9Gk53GTRZCP6DdY0P2SpYExusqGcB2u8tcSfnJunVb9?=
 =?us-ascii?Q?joF9bD7F44Ik5QfNd4NgTWrBTKeJj0KU81AYWQTnEkYBoYlkWmh4tfqE0azi?=
 =?us-ascii?Q?N3CrAb5Gs1JR+1pt0dW+2iLC8+9RCyx99V5bp1g6Kv2t9Mb8SVuK45kJg0o6?=
 =?us-ascii?Q?7EL+l1Wvh8BduTRNti7g2Qu6j0XD9QDAxqlu1sRQG4i0HDlNQJIFfyeCFevr?=
 =?us-ascii?Q?AtbVivxK0wPVDy4NViqR5Mrc2tfEDs2ZhDAR0pytI1xKhC5H78b0txnPdZpu?=
 =?us-ascii?Q?yLDgYyRrr1M0LkmTe1yjB+vW3le+qqwFhXWiN5kCDGXP9jmOeBbmrYV0At+/?=
 =?us-ascii?Q?EuZXVlSLZTQ4wj8g1OQ6/BnEuIdDyMaRliRVdNkQrD/N7zSGSVy2BAes+PQP?=
 =?us-ascii?Q?GVBvJugHTC442YI0Z3RmrQrK3dmbqyeR6Dnklde/USQ/doPwh55bOdc4OkUE?=
 =?us-ascii?Q?4lQ+QG1R3rphc8B6TayXo+vCKXErKfdY1UePMYaN6clnVVVAi2zIbwbvml1Z?=
 =?us-ascii?Q?JFCr3nYKu5pNQTDmG4uDkmeyaktIVuZBGr0izPWOcPdN4H3soOGC+Tbl8ZY3?=
 =?us-ascii?Q?jQ3HN6ch9PXiK6vxBtv8vtR2Q4Xz/MjYhKN92QfwN4TFb+HVZV+wQG8KQbRS?=
 =?us-ascii?Q?5D3jALy/0JvOIDAv+0uhtvVV4N05DTJMDMrKh6IvwkEzk51crHA8OU8w8+F8?=
 =?us-ascii?Q?fA/Y2dJ4JksB3Da1kCgAoJ/v0kjLYmaK2CGSqqGx9B+IC9nTHVOEK6XoKmUV?=
 =?us-ascii?Q?Vu2eTkjQF6Xvwar2RhgrrAAWlalNDhlfyFtJ0LLBEz351pne7AcNuM1PKyUX?=
 =?us-ascii?Q?a6TMqNQTFtedooTvBbyzMbQfpM4T1mVEhe6qYcr5qc2q2iUs0tYJ24LUVqJi?=
 =?us-ascii?Q?D+9+ON0NR8UbQZ/W0Taj4IotvyF8AaYOg9lD1SPrP2xu7MSa1ASg/X24T6Gl?=
 =?us-ascii?Q?23umZYy/3SlSBjelbfyDiY7pgxjNGGGQXMR5Yf6AYqL6WwXdZuhs6ldw0g2Z?=
 =?us-ascii?Q?8YTi5JUgWRiNnELT+UCw+7zINMCdeXqXFkrjK0QW7gRQgD6Tp6kIpDboBXkk?=
 =?us-ascii?Q?4P+FlpzKCw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f71ff8b-055c-4d9e-918a-08de4e128f1f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:31:15.1757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 892b/7myKW3NdWwgGa8COELHsyjQa1GYfbArCJl9N3Mzi1bbp3EKrio6oMthN+7yLsdrEcANo9lcTVfzHvIkuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7054

On Thu, 18 Dec 2025 09:41:00 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> The Task::group_leader() method currently allows you to access the
> group_leader() of any task, for example one you hold a refcount to. But
> this is not safe in general since the group leader could change when a
> task exits. See for example commit a15f37a40145c ("kernel/sys.c: fix the
> racy usage of task_lock(tsk->group_leader) in sys_prlimit64() paths").
> 
> All existing users of Task::group_leader() call this method on current,
> which is guaranteed running, so there's not an actual issue in Rust code
> today. But to prevent code in the future from making this mistake,
> restrict Task::group_leader() so that it can only be called on current.
> 
> There are some other cases where accessing task->group_leader is okay.
> For example it can be safe if you hold tasklist_lock or rcu_read_lock().
> However, only supporting current->group_leader is sufficient for all
> in-tree Rust users of group_leader right now. Safe Rust functionality
> for accessing it under rcu or while holding tasklist_lock may be added
> in the future if required by any future Rust module.
> 
> Reported-by: Oleg Nesterov <oleg@redhat.com>
> Closes: https://lore.kernel.org/all/aTLnV-5jlgfk1aRK@redhat.com/
> Fixes: 313c4281bc9d ("rust: add basic `Task`")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/task.rs | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

