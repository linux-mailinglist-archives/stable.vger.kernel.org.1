Return-Path: <stable+bounces-246858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJuAB3iCBGrVKwIAu9opvQ
	(envelope-from <stable+bounces-246858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:54:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 966A55346E9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8A433B4C64
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F79A31280C;
	Wed, 13 May 2026 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Fk6ywTBn"
X-Original-To: stable@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022086.outbound.protection.outlook.com [52.101.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA50030EF89
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678782; cv=fail; b=lajhc0/PwUytbr6hDSKkjHSQAT3IJv9Vo6Ah7Dwl/FRfzmgsr1YFWoUUcdNRvlCdXdRBfFtZcCw2/iGPiHqvZF5pVhf+T0J3sh0sz02mzkb8ZrQx8vYVXXtSWNFEschqcKdJQYNDaQVfYjZB9PieqV2gXHm9a4+Nc01qYrS8tLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678782; c=relaxed/simple;
	bh=WshAKsdMFlfcvuHZ+el8sJ3YXVj8BOGQslG9AlhDgLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XeAybuZ9I9BU8OIfbKmyNS+NjqoRKSHz0nO88kgSxjfr11DLHEhk1QiAmeFOGYoTFEXpV3y4Bumf4TFI2JRErJYGi7spgbJ4Ohb+488hF3eEArOhnc1eOzWCSRv3Sb2m2QxAUKDTETjdYDBU7TxeqOgVsCjMI/0j+ZJoFuSrsWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Fk6ywTBn; arc=fail smtp.client-ip=52.101.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+syr42Ztbt+hHV7NsSxPnBXaefuFMICSUXiaV0FYoH3J2aY1EQdlO9oOVW58FWgPVgzO75drT7srhxEzrBVnMLYCunSGXPltcf+VSJbswpyWMGEYv0rLq00QhUFXr0oSYOpjnh0yR7lIbPUuNJSzUByTNlxV4XKtbRHpssuNOxj42uRj24k2WTBf6OwYTYBr+2LjguDSiEKLqwfW0PBUnJEJCPmXWPx4oZt/PlTe8iDUjJ5jL60RaNwBs9WHWez5RpdKq0sg/fUF8q/2cAr4wmZu/ctNl6QfrreEuc/aydAR8fFRGTzYigA5qwgVpjfreaxyoo1BV1tXRR0FwRE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNdOeHZj2IG/MMOtD0yEgI9YWDrx3UJZm1nry925I2Y=;
 b=RMPNnzATp2ebktcu4xU4dGfcxfxVzoiuK+Rq+IQtF7MYAeliGkpL+DgawyR5YjtDo1gt/oAeyPmxJhLy4Wf0pxgoM/iNMHKwYV1LNH/7zi/oFrcmKVk55R4zDRNGtaLehch42N9RhB+j2zJmpg+7T3r1zJAp2ekBcavTpjWmuPwrUQzkj6/QCKOaV51oxcVffpJCFF9ZZ8qyqyVErpGZcKAA+AcfmsdFy73BPZ5F7SZ1pfn9Y52Yf74YSz+qrdbGui5yN2tJAGA0JUcSwo5CWjoqvMjaGbn31BOdKo1/9MdXQlmeUIljeS6/2WLnU+OkHtSDu+OrI29/9v3dq4lhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNdOeHZj2IG/MMOtD0yEgI9YWDrx3UJZm1nry925I2Y=;
 b=Fk6ywTBnFYIbsPO6mutNFbzTed6MyFeMVD5vZjHTplb5UTHW66pj41by1uj01OTEt3JnU9WE+coNq1HTAblcSzBuwb7JG5IM6tTkVO8uceuRcz9+V9KGYX6YkiRu/TxF1bNILwKLPP5Eu3/sv5C1cy/rC/fUkP4CnSDKq8ziplY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6302.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:185::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 13:26:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 13:26:14 +0000
From: Gary Guo <gary@garyguo.net>
To: gregkh@linuxfoundation.org,
	ojeda@kernel.org
Cc: stable@vger.kernel.org,
	Gary Guo <gary@garyguo.net>
Subject: [PATCH 6.12.y v2] rust: pin-init: fix incorrect accessor reference lifetime
Date: Wed, 13 May 2026 14:25:36 +0100
Message-ID: <20260513132535.3822518-2-gary@garyguo.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <2026051333-fiction-plug-9076@gregkh>
References: <2026051333-fiction-plug-9076@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3d50e8-2cd4-4300-d353-08deb0f33513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jgsselcFlj7mcm0aXnaMX7WnP9vgdp6lKY3lv7+K9ZQLDAD5SFtsKOrmavAB1mh2b5xY479odNVYwBNnsiJptKkxchUrfftGe1BaeJWmxCmCc4UOfYAkkyP4F+hZWgOT7OfRfHwMXilMDY3e3kn6AR47rde7hxORfQmoXHkmHPitZ8CvVTRaQ/SqkGKbx/NKuwBCvfkScG7gg4mbeRX6AmumiFc7gU50FcL7u5MhWw4W8z82+Eezc1wNQr/ad5CW9ymf6FMVd8ySB1X/3j6VcRrgmi9/tpEKl2fxxdY0XXudJ8al8En0UQX5o/Vkp0O+xbg2JwGwjid3H/WeeiuQPtG6GI7n/jGNqeDJnTplDXQG+u1TUWvz2T87bERkxATUZVvrhTieLktTzFGC+rHAZpcrfmC7Pish2GZ0DNaxHq553B7N9hKJxKPCDdwMvQ1A9FfoX1J7yKS9x3uJj767xIx71GKhk5aIUX1mEEI0W7/CCiqKroUDrOFefTekxT2oqlmtHOOKv1ivyfhMCxKhYkchmWmi9Ovzm7OoJby6DkDfm8gCNsqc8+nQlR9pecjPnpki/d9MsvcoQrz4DIn2cLHl/b/3S9nHx+fzRHDecivSJWfbXp0Fd0XzNb116Qet4f/E53nh26XLuAAFWo52WgPyvPD9cLZJf1cc3wx+dzHyt5ocE2ijBEB94OlxuvA8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0LpUiEITjqRvToeKjXA9p8T8JmL3yzXlcamYW1lKoIVLcsAfNXfiI5/HlQ9x?=
 =?us-ascii?Q?4vh1XLzSJpJF4y5DZysLDbrorUozd3zKzCTOd/vgmpQYrWDNYgK3IkYxkFFe?=
 =?us-ascii?Q?iD+tiL9XI4JhWYQrjzayCtJmV/5JMruNxjGQkzGqEfOkskG1MdlNpzmd19Wo?=
 =?us-ascii?Q?EH5T1bLf3W75QBWRGGmrOy9QcMJWNuo80epxgYM9ygGN27bELOxTu0pdQi7X?=
 =?us-ascii?Q?VoSlnk6izo74OVJYLc/ShKRA51dV+FvKRbrR5bLj5VKHVDWO3CoEWlPchdCX?=
 =?us-ascii?Q?8GUuuEYDVtGSx+9VVb8bSjw7Y96folkettrOSde0ZU+iZVm6t9pah+WkHfCp?=
 =?us-ascii?Q?GzIOwsm+yBG6y8hNX814rY7YPTogVT5mTavzunXCjcj+wKNDt+VJ5+2zZmrX?=
 =?us-ascii?Q?iPpQJnxvK4ERHUkrxGgbkxQzKC7e90YAD7gI1NvwbGbk3Z681WmkMuRo1roo?=
 =?us-ascii?Q?xlUR3ADz3aaXEPlAlyY0RLLZAyAjdgIs9C6kpIdItHVUdC1qcLK59EGI0c3O?=
 =?us-ascii?Q?69Tfk5rKatkCXzh0D0emtJ9ve+VIJKGPsWPeQHsX9jnQkv/bq9nq0rs35JeO?=
 =?us-ascii?Q?eox504BgFnJ2w6PpruC0Eb21v9hVe5HhjudhZy1XVTr6eR7cWu7dAE4SrNur?=
 =?us-ascii?Q?OjT+G24mAE1KoCdxUAvo06DdkKlVgtFMj3TJS41Q3BGh/QuMuDAYxhGb0MMX?=
 =?us-ascii?Q?98mSJBOqSLeB6uu4LXEEoBE/nVMDS/Qhgvzqcmbric+vQB9rUtJfsoLehNY1?=
 =?us-ascii?Q?hqz3v8cGXfgUhbe+9ZVo7yxU5s8UspjPrIcKrhiLpmGA+N+coK37pJSDuMJ/?=
 =?us-ascii?Q?PWT9K2UBsUsP2ZbjI7QE5LXkgtV40k7ydjNSmij0DhowySyBsuk9PI/K7Jy7?=
 =?us-ascii?Q?gLDQ6SBGjaAWiF2LfTnEpW8B4y2glnirvdpwXnDzz9oAqCcEoD5e5CVEAhVp?=
 =?us-ascii?Q?1QiR5JMvoEBMf6edZ4e2kAZXZqPy4S49zq35m3/WbV08Kcy/Fa3Z4PIXkB1e?=
 =?us-ascii?Q?4069shFFIjy5P3dMyDAs49xd5RJxAfr5GxLNc4MJWf5ju+eJajaG5loHzfKB?=
 =?us-ascii?Q?MHJOhtd/fGjIxml+9h/CkRiuNMq1+qCsQiU8vL9hWpAq+MPZAuDNyGQUrx0H?=
 =?us-ascii?Q?pmF7oa095B513guJb4iIyzBFrR9TrGV1PRh+6/pZkHUYXvt7WpG4EXvFxCMs?=
 =?us-ascii?Q?+tmfJpClstfV7DMymeTFAO3FyaGFuts6nDWVWlncSrc7wfBAz0ioHWY1Xmfx?=
 =?us-ascii?Q?D31yRubdRNaWLpFwIOiTdLQoeejzA9tgi+KaGSQJWttikfgpNrorB8l9MSxr?=
 =?us-ascii?Q?gilH9yxCaiWkdhwHGSoMvGgXOoAMrLUc6jfpeIiNWLYgrfvUn2bGxgICGruf?=
 =?us-ascii?Q?R18ET0WaC35P4t5AimcAplqVllin3gjBQ6bAdMAFq36VEXKt6ou+V4GPuJul?=
 =?us-ascii?Q?xQ8RHUAYHCtsLvxfgF0DiYZjC7VyNCkpOt3wAJMnPo4Myxx14NT77EyUEspT?=
 =?us-ascii?Q?o5gsto/Tf6yJoktmPgb/ig4BalgQJmFTCo3TFURSvrwYSx+xTqvjLbLkz3BE?=
 =?us-ascii?Q?rrb60+p/0L3RKfWVo0RaY+2lNC/TEE69vAq/Te5iAIQPrjjMMtPAyVZN4xDk?=
 =?us-ascii?Q?wiBp3dEbTFVVJ5l0V1JbvuteSU4i9Ptw/LAWozHyG4vdoY6Mga/A0bEUdmaG?=
 =?us-ascii?Q?Tor3gF0Bc4gTfsCEAhzb7PJ5LGZoHWnzF0f3MI6v9IO8iPP++ImGR6rnj7pg?=
 =?us-ascii?Q?2RUgPQFuLw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3d50e8-2cd4-4300-d353-08deb0f33513
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 13:26:14.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xX9b0LCmStF+luVyMrDWjX1JLydAfDkhuGBfi07OGOcZIidA6v6d0jk3u6y6bD3tvD9Q4Fn8lGNaxtnBHIJ0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6302
X-Rspamd-Queue-Id: 966A55346E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-246858-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

commit 68bf102226cf2199dc609b67c1e847cad4de4b57 upstream

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

This is caused by `&mut (*$slot).$ident`, which actually allows arbitrary
lifetime, so this is effectively `'static`.

Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime.
This results in exactly what we want for these accessors. The safety and
invariant comments of `DropGuard` have been reworked; instead of reasoning
about what caller can do with the guard, express it in a way that the
ownership is transferred to the guard and `forget` takes it back, so the
unsafe operations within the `DropGuard` can be more easily justified.

Assisted-by: Claude:claude-3-opus
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/init/__internal.rs | 28 +++++++----
 rust/kernel/init/macros.rs     | 91 ++++++++++++++++++++--------------
 2 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal.rs
index 74329cc3262c..93809ebaf252 100644
--- a/rust/kernel/init/__internal.rs
+++ b/rust/kernel/init/__internal.rs
@@ -189,32 +189,42 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinInit<T, E>) -> Result<Pin<&mu
 /// When a value of this type is dropped, it drops a `T`.
 ///
 /// Can be forgotten to prevent the drop.
+///
+/// # Invariants
+///
+/// - `ptr` is valid and properly aligned.
+/// - `*ptr` is initialized and owned by this guard.
 pub struct DropGuard<T: ?Sized> {
     ptr: *mut T,
 }
 
 impl<T: ?Sized> DropGuard<T> {
-    /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `ptr` when it gets dropped.
+    /// Creates a drop guard and transfer the ownership of the pointer content.
     ///
-    /// # Safety
+    /// The ownership is only relinquished if the guard is forgotten via [`core::mem::forget`].
     ///
-    /// `ptr` must be a valid pointer.
+    /// # Safety
     ///
-    /// It is the callers responsibility that `self` will only get dropped if the pointee of `ptr`:
-    /// - has not been dropped,
-    /// - is not accessible by any other means,
-    /// - will not be dropped by any other means.
+    /// - `ptr` is valid and properly aligned.
+    /// - `*ptr` is initialized, and the ownership is transferred to this guard.
     #[inline]
     pub unsafe fn new(ptr: *mut T) -> Self {
+        // INVARIANT: By safety requirement.
         Self { ptr }
     }
+
+    /// Create a let binding for accessor use.
+    #[inline]
+    pub fn let_binding(&mut self) -> &mut T {
+        // SAFETY: Per type invariant.
+        unsafe { &mut *self.ptr }
+    }
 }
 
 impl<T: ?Sized> Drop for DropGuard<T> {
     #[inline]
     fn drop(&mut self) {
-        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
-        // ensuring that this operation is safe.
+        // SAFETY: `self.ptr` is valid, properly aligned and `*self.ptr` is owned by this guard.
         unsafe { ptr::drop_in_place(self.ptr) }
     }
 }
diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
index d6e27c522115..bd9a7fd64d86 100644
--- a/rust/kernel/init/macros.rs
+++ b/rust/kernel/init/macros.rs
@@ -1232,27 +1232,33 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         // We also use the `data` to require the correct trait (`Init` or `PinInit`) for `$field`.
         unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field), init)? };
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the project function does the correct field projection,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+        // SAFETY: the field has been initialized.
+        let _ = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            // NOTE: The reference is derived from the guard so that it only lives as long as
+            // the guard does and cannot escape the scope.
+            #[allow(unused_variables, unused_assignments)]
+            // SAFETY: the project function does the correct field projection.
+            let $field = unsafe { $data.[< __project_ $field >]([< __ $field _guard >].let_binding()) };
+
             $crate::__init_internal!(init_slot($use_data):
                 @data($data),
                 @slot($slot),
@@ -1275,27 +1281,30 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
         // return when an error/panic occurs.
         unsafe { $crate::init::Init::__init(init, ::core::ptr::addr_of_mut!((*$slot).$field))? };
 
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the field is not structurally pinned, since the line above must compile,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = unsafe { &mut (*$slot).$field };
+        // SAFETY: the field has been initialized.
+        let _ = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            #[allow(unused_variables, unused_assignments)]
+            let $field = [< __ $field _guard >].let_binding();
+
             $crate::__init_internal!(init_slot():
                 @data($data),
                 @slot($slot),
@@ -1319,28 +1328,30 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
 
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the field is not structurally pinned, since no `use_data` was required to create this
-        //   initializer,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = unsafe { &mut (*$slot).$field };
+        // SAFETY: the field has been initialized.
+        let _ = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
         // We use `paste!` to create new hygiene for `$field`.
         ::kernel::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            #[allow(unused_variables, unused_assignments)]
+            let $field = [< __ $field _guard >].let_binding();
+
             $crate::__init_internal!(init_slot():
                 @data($data),
                 @slot($slot),
@@ -1363,27 +1374,33 @@ fn assert_zeroable<T: $crate::init::Zeroable>(_: *mut T) {}
             // SAFETY: The memory at `slot` is uninitialized.
             unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$field), $field) };
         }
-        // NOTE: the field accessor ensures that the initialized field is properly aligned.
+        // NOTE: this ensures that the initialized field is properly aligned.
         // Unaligned fields will cause the compiler to emit E0793. We do not support
         // unaligned fields since `Init::__init` requires an aligned pointer; the call to
         // `ptr::write` below has the same requirement.
-        #[allow(unused_variables, unused_assignments)]
-        // SAFETY:
-        // - the project function does the correct field projection,
-        // - the field has been initialized,
-        // - the reference is only valid until the end of the initializer.
-        let $field = $crate::macros::paste!(unsafe { $data.[< __project_ $field >](&mut (*$slot).$field) });
+        // SAFETY: the field has been initialized.
+        let _ = unsafe { &mut (*$slot).$field };
 
         // Create the drop guard:
         //
         // We rely on macro hygiene to make it impossible for users to access this local variable.
         // We use `paste!` to create new hygiene for `$field`.
         $crate::macros::paste! {
-            // SAFETY: We forget the guard later when initialization has succeeded.
-            let [< __ $field _guard >] = unsafe {
+            // SAFETY:
+            // - `addr_of_mut!((*$slot).$field)` is valid.
+            // - `(*$slot).$field` has been initialized above.
+            // - We only need the ownership to the pointee back when initialization has
+            //   succeeded, where we `forget` the guard.
+            let mut [< __ $field _guard >] = unsafe {
                 $crate::init::__internal::DropGuard::new(::core::ptr::addr_of_mut!((*$slot).$field))
             };
 
+            // NOTE: The reference is derived from the guard so that it only lives as long as
+            // the guard does and cannot escape the scope.
+            #[allow(unused_variables, unused_assignments)]
+            // SAFETY: the project function does the correct field projection.
+            let $field = unsafe { $data.[< __project_ $field >]([< __ $field _guard >].let_binding()) };
+
             $crate::__init_internal!(init_slot($use_data):
                 @data($data),
                 @slot($slot),

base-commit: 8bf2f55ef536982e44802d99340119dac6f50636
-- 
2.51.2


