Return-Path: <stable+bounces-146019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF879AC031F
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 05:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DD31B66D02
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 03:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CAF4A21;
	Thu, 22 May 2025 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HFdc255G"
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89708195
	for <stable@vger.kernel.org>; Thu, 22 May 2025 03:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885678; cv=none; b=T2UnkNp/TqNadydjfOTDFRrUqRFZgcAv6KPNLWve/4o7b+R0gx+PO5LA+ec/Od1ZYLXFW+ITpeCptITIhYdg679m5m9TC+Nuq3yN1Fuv4a68BRjcf4gYGfMvAzRfjpF6d+160b5YgkyhKLTaJNu3iIGKMLcSolnO9cIriBHspUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885678; c=relaxed/simple;
	bh=h+FKSkVJoJLzHFqTiIazKO5seuUB04xC7a/m3H4dAqg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=W7Jd75wwCeG8jJjvuUiXCTFNLuHB/vEUVjqXNPdsUY41XW5Es2FKHQzncqaW8cLUjKBusWBqvAgOoZePnDrL/s8e4JYrUsemUadeE11FOiPx6QjkJqIYRBK8DTpKxXe9pLJY4Pv37Wc6vZatKRRbKZUu2B3NmGff0mPITVsTop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HFdc255G; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747885671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXXYi1vVEw7Vh0KRmb1QEzzCMPaHpSE9E8XA1i/G0ww=;
	b=HFdc255GB9u7lfA3f0vLiEbH7XqTxGC58vRB2WZ2AuOAwuLba4hFa0TmhWNJuYIJdBs7Io
	zjkY/HzfayV+tL/iqEy/Ft/VjbyteKKpa5NqtPw2Kj0hgSAzczZdNKE7pQO2D1ZQ0rJdV9
	d19dX3LzYVUEPCBjdsVCl/K1Nw+Y1M4=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <1747884137-26685-1-git-send-email-yangge1116@126.com>
Date: Thu, 22 May 2025 11:47:05 +0800
Cc: akpm@linux-foundation.org,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 21cnbao@gmail.com,
 david@redhat.com,
 baolin.wang@linux.alibaba.com,
 osalvador@suse.de,
 liuzixing@hygon.cn
Content-Transfer-Encoding: quoted-printable
Message-Id: <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
To: yangge1116@126.com
X-Migadu-Flow: FLOW_OUT



> On May 22, 2025, at 11:22, yangge1116@126.com wrote:
>=20
> From: Ge Yang <yangge1116@126.com>
>=20
> A kernel crash was observed when replacing free hugetlb folios:
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000028
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 28 UID: 0 PID: 29639 Comm: test_cma.sh Tainted 6.15.0-rc6-zp #41 =
PREEMPT(voluntary)
> RIP: 0010:alloc_and_dissolve_hugetlb_folio+0x1d/0x1f0
> RSP: 0018:ffffc9000b30fa90 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000342cca RCX: ffffea0043000000
> RDX: ffffc9000b30fb08 RSI: ffffea0043000000 RDI: 0000000000000000
> RBP: ffffc9000b30fb20 R08: 0000000000001000 R09: 0000000000000000
> R10: ffff88886f92eb00 R11: 0000000000000000 R12: ffffea0043000000
> R13: 0000000000000000 R14: 00000000010c0200 R15: 0000000000000004
> FS:  00007fcda5f14740(0000) GS:ffff8888ec1d8000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000028 CR3: 0000000391402000 CR4: 0000000000350ef0
> Call Trace:
> <TASK>
> replace_free_hugepage_folios+0xb6/0x100
> alloc_contig_range_noprof+0x18a/0x590
> ? srso_return_thunk+0x5/0x5f
> ? down_read+0x12/0xa0
> ? srso_return_thunk+0x5/0x5f
> cma_range_alloc.constprop.0+0x131/0x290
> __cma_alloc+0xcf/0x2c0
> cma_alloc_write+0x43/0xb0
> simple_attr_write_xsigned.constprop.0.isra.0+0xb2/0x110
> debugfs_attr_write+0x46/0x70
> full_proxy_write+0x62/0xa0
> vfs_write+0xf8/0x420
> ? srso_return_thunk+0x5/0x5f
> ? filp_flush+0x86/0xa0
> ? srso_return_thunk+0x5/0x5f
> ? filp_close+0x1f/0x30
> ? srso_return_thunk+0x5/0x5f
> ? do_dup2+0xaf/0x160
> ? srso_return_thunk+0x5/0x5f
> ksys_write+0x65/0xe0
> do_syscall_64+0x64/0x170
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>=20
> There is a potential race between __update_and_free_hugetlb_folio()
> and replace_free_hugepage_folios():
>=20
> CPU1                              CPU2
> __update_and_free_hugetlb_folio   replace_free_hugepage_folios
>                                    folio_test_hugetlb(folio)
>                                    -- It's still hugetlb folio.
>=20
>  __folio_clear_hugetlb(folio)
>  hugetlb_free_folio(folio)
>                                    h =3D folio_hstate(folio)
>                                    -- Here, h is NULL pointer
>=20
> When the above race condition occurs, folio_hstate(folio) returns
> NULL, and subsequent access to this NULL pointer will cause the
> system to crash. To resolve this issue, execute folio_hstate(folio)
> under the protection of the hugetlb_lock lock, ensuring that
> folio_hstate(folio) does not return NULL.
>=20
> Fixes: 04f13d241b8b ("mm: replace free hugepage folios after =
migration")
> Signed-off-by: Ge Yang <yangge1116@126.com>
> Cc: <stable@vger.kernel.org>

Thanks for fixing this problem. BTW, in order to catch future similar =
problem,
it is better to add WARN_ON into folio_hstate() to assert if =
hugetlb_lock
is not held when folio's reference count is zero. For this fix, LGTM.

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


