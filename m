Return-Path: <stable+bounces-202852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF33ECC82A6
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C4CC309C7D5
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8091F1302;
	Wed, 17 Dec 2025 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Yj0gUMdC"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6783A1E62;
	Wed, 17 Dec 2025 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980732; cv=pass; b=MK05EHsAupj2oiDlgGu9scc4T6GuNp7FFmIKdtdZlh2QCZW3suIMBxDxr7nzMS0Z3lU/tMrx+AzpgA8coMHguHteT4R8UJlvX61Ocj8/bNjnKabhkwPpbohlKYmxvjIBPTrglYATZ+ish15k4IDzTM+0WGDlIMR+6pDihliBS3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980732; c=relaxed/simple;
	bh=p+lVOXVaEGR+Rf1rDAMxlfJhtfZ9RgU9+EchPKsfEag=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YTCsfxOIbBL+UpiDQDf4HniaEu1JRFwbPKR/j4ik/bYI6xMmnv54SqfhBUES19P0IWOr3eXDVmqx/Ray4KCuDgYV9/O6j2Nd/uor5hZoOX7JzyKQuZxGOjLVmSkZTQfS/uePtW5lvxh32ECuoIQZ//nz2aGbFXQ9QKNZHb+UiB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Yj0gUMdC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1765980688; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FBptBmmkmPE6HFFbhch2bl97lKxB+Dr0T6UbgC+7IlbUUWxd/q2br5bZy4t9+HyaCqRoTJeYkjydQgWiiNdj4miFXSzl3IB+hk+YJI2aBRxhaHhONiqyrIkDEp/lqDLuRhcwASqyB4U1dSzc+ORwvrtJxFUhz4uJW1PPJtFQO1s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765980688; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fFCC+AzadfVlGXWre6gah9ux2PXfd4oGQ2inbMA+VUk=; 
	b=lAT6AyzS8y1fsxifcT8xKTCiWAddhl5MbkmGq2MgcAiJW7d4Y5Zkf8vhYLVJFCxbDr6DZfhDE9w76XC98aZqwhblUm/ATrHnJlc37wIL8Xs80BJNKBbuWHKRXoGh0OXZ9BFgN+xY6kZ2+Xzs6UrHPqxTaXyP4cEY0QSU/7UJgO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765980688;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=fFCC+AzadfVlGXWre6gah9ux2PXfd4oGQ2inbMA+VUk=;
	b=Yj0gUMdCzdatNdsJwNwXeYNUZuS4Y38rNE+DAf/YEex2XbyRDD7v0W27LZLAy1PK
	sLL5JYEBnczSYTUvWVa8v7yr3cU+QIDadSn1NBh7RFR3XhL94dqyHNdPOCybhtqNaaN
	w4xO/Ls1ifnoTUbE6kfw10BTA6EkVjtzNDFabf3E=
Received: by mx.zohomail.com with SMTPS id 1765980686277212.72937863971833;
	Wed, 17 Dec 2025 06:11:26 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] rust: maple_tree: rcu_read_lock() in destructor to
 silence lockdep
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251217-maple-drop-rcu-v1-1-702af063573f@google.com>
Date: Wed, 17 Dec 2025 11:11:09 -0300
Cc: Matthew Wilcox <willy@infradead.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Ballance <andrewjballance@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 maple-tree@lists.infradead.org,
 linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A20E6CF7-5ABA-46BF-8FE3-A3D1BF61F0A7@collabora.com>
References: <20251217-maple-drop-rcu-v1-1-702af063573f@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 17 Dec 2025, at 10:10, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> When running the Rust maple tree kunit tests with lockdep, you may
> trigger a warning that looks like this:
>=20
> lib/maple_tree.c:780 suspicious rcu_dereference_check() usage!
>=20
> other info that might help us debug this:
>=20
> rcu_scheduler_active =3D 2, debug_locks =3D 1
> no locks held by kunit_try_catch/344.
>=20
> stack backtrace:
> CPU: 3 UID: 0 PID: 344 Comm: kunit_try_catch Tainted: G                =
 N  6.19.0-rc1+ #2 NONE
> Tainted: [N]=3DTEST
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS =
rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
> Call Trace:
> <TASK>
> dump_stack_lvl+0x71/0x90
> lockdep_rcu_suspicious+0x150/0x190
> mas_start+0x104/0x150
> mas_find+0x179/0x240
> =
_RINvNtCs5QSdWC790r4_4core3ptr13drop_in_placeINtNtCs1cdwasc6FUb_6kernel10m=
aple_tree9MapleTreeINtNtNtBL_5alloc4kbox3BoxlNtNtB1x_9allocator7KmallocEEE=
CsgxAQYCfdR72_25doctests_kernel_generated+0xaf/0x130
> rust_doctest_kernel_maple_tree_rs_0+0x600/0x6b0
> ? lock_release+0xeb/0x2a0
> ? kunit_try_catch_run+0x210/0x210
> kunit_try_run_case+0x74/0x160
> ? kunit_try_catch_run+0x210/0x210
> kunit_generic_run_threadfn_adapter+0x12/0x30
> kthread+0x21c/0x230
> ? __do_trace_sched_kthread_stop_ret+0x40/0x40
> ret_from_fork+0x16c/0x270
> ? __do_trace_sched_kthread_stop_ret+0x40/0x40
> ret_from_fork_asm+0x11/0x20
> </TASK>
>=20
> This is because the destructor of maple tree calls mas_find() without
> taking rcu_read_lock() or the spinlock. Doing that is actually ok in
> this case since the destructor has exclusive access to the entire =
maple
> tree, but it triggers a lockdep warning. To fix that, take the rcu =
read
> lock.
>=20
> In the future, it's possible that memory reclaim could gain a feature
> where it reallocates entries in maple trees even if no user-code is
> touching it. If that feature is added, then this use of rcu read lock
> would become load-bearing, so I did not make it conditional on =
lockdep.
>=20
> We have to repeatedly take and release rcu because the destructor of T
> might perform operations that sleep.
>=20
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Closes: =
https://rust-for-linux.zulipchat.com/#narrow/channel/x/topic/x/near/564215=
108
> Fixes: da939ef4c494 ("rust: maple_tree: add MapleTree")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Intended for the same tree as any other maple tree patch. (I believe
> that's Andrew Morton's tree.)
> ---
> rust/kernel/maple_tree.rs | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index =
e72eec56bf5772ada09239f47748cd649212d8b0..265d6396a78a17886c8b5a3ebe7ba39c=
cc354add 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -265,7 +265,16 @@ unsafe fn free_all_entries(self: Pin<&mut Self>) =
{
>         loop {
>             // This uses the raw accessor because we're destroying =
pointers without removing them
>             // from the maple tree, which is only valid because this =
is the destructor.
> -            let ptr =3D ma_state.mas_find_raw(usize::MAX);
> +            //
> +            // Take the rcu lock because mas_find_raw() requires that =
you hold either the spinlock
> +            // or the rcu read lock. This is only really required if =
memory reclaim might
> +            // reallocate entries in the tree, as we otherwise have =
exclusive access. That feature
> +            // doesn't exist yet, so for now, taking the rcu lock =
only serves the purpose of
> +            // silencing lockdep.
> +            let ptr =3D {
> +                let _rcu =3D kernel::sync::rcu::Guard::new();
> +                ma_state.mas_find_raw(usize::MAX)
> +            };
>             if ptr.is_null() {
>                 break;
>             }
>=20
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251217-maple-drop-rcu-dfe72fb5f49e
>=20
> Best regards,
> --=20
> Alice Ryhl <aliceryhl@google.com>
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


