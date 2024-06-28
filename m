Return-Path: <stable+bounces-56104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D1E91C772
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 22:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29969282595
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 20:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F4D78274;
	Fri, 28 Jun 2024 20:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qrP9bV/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38754D8BC;
	Fri, 28 Jun 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607362; cv=none; b=j+4M9Tvm4zFL14YJVm+yvlb4TvRaqaxx988yYBcmn5/aX+WXkgskFc0GLxwcgL4sQTK4wWW3dri/lFrSIyuOM02uv1ZstEKVWtLwC2EbxwohAUxhWws+3sL56jX1HmmZcdv5K4JdgfOUMc0g8twCH4Y5FxB2JrUIpf3zYCHciLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607362; c=relaxed/simple;
	bh=sC5/XjAiHZDzOKF4zecBptmEbklTx74wU/VV/LkSRnw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MzPMY7hnxWDhy2sEndY+LPdoSAXi9MMIUyLHAE+wbvpKDKY2BHbL5hmjaEIv4FIahC/bxgGw+6xE1JkWvNkJBIwdYfTZzvqtD0bHHLSVtb6eYN3EE3jl7WvqVyUhe4mcNLiNtfOaVuCaHlkSuy4C5hq91Di2VZqnK68CzJ4wWwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qrP9bV/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227F7C116B1;
	Fri, 28 Jun 2024 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719607362;
	bh=sC5/XjAiHZDzOKF4zecBptmEbklTx74wU/VV/LkSRnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qrP9bV/90gz4EOySJs+s89K63a+KU7/tOJYGmIh8CD5h6ETR+GklndnjiEGnKJ1R8
	 M604UOHtSmzC1HeNySuPnqGBSkZTXXyMTW67OXeNjWW91KP1aDjsJtlmh0/Eq//E+l
	 QM/coZ2FsdKZ3ICWX4GgLz/5fbxT5MLuc29dxJEM=
Date: Fri, 28 Jun 2024 13:42:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: yangge1116@126.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, 21cnbao@gmail.com, peterx@redhat.com,
 yang@os.amperecomputing.com, baolin.wang@linux.alibaba.com,
 liuzixing@hygon.cn
Subject: Re: [PATCH V2] mm/gup: Fix longterm pin on slow gup regression
Message-Id: <20240628134241.53c5f68f936efe0aa8f0b789@linux-foundation.org>
In-Reply-To: <1719554518-11006-1-git-send-email-yangge1116@126.com>
References: <1719554518-11006-1-git-send-email-yangge1116@126.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jun 2024 14:01:58 +0800 yangge1116@126.com wrote:

> From: yangge <yangge1116@126.com>
> 
> If a large number of CMA memory are configured in system (for
> example, the CMA memory accounts for 50% of the system memory),
> starting a SEV virtual machine will fail. During starting the SEV
> virtual machine, it will call pin_user_pages_fast(..., FOLL_LONGTERM,
> ...) to pin memory. Normally if a page is present and in CMA area,
> pin_user_pages_fast() will first call __get_user_pages_locked() to
> pin the page in CMA area, and then call
> check_and_migrate_movable_pages() to migrate the page from CMA area
> to non-CMA area. But the current code calling __get_user_pages_locked()
> will fail, because it call try_grab_folio() to pin page in gup slow
> path.
> 
> The commit 57edfcfd3419 ("mm/gup: accelerate thp gup even for "pages
> != NULL"") uses try_grab_folio() in gup slow path, which seems to be
> problematic because try_grap_folio() will check if the page can be
> longterm pinned. This check may fail and cause __get_user_pages_lock()
> to fail. However, these checks are not required in gup slow path,
> seems we can use try_grab_page() instead of try_grab_folio(). In
> addition, in the current code, try_grab_page() can only add 1 to the
> page's refcount. We extend this function so that the page's refcount
> can be increased according to the parameters passed in.
> 
> The following log reveals it:
> 
> [  464.325306] WARNING: CPU: 13 PID: 6734 at mm/gup.c:1313 __get_user_pages+0x423/0x520
> [  464.325464] CPU: 13 PID: 6734 Comm: qemu-kvm Kdump: loaded Not tainted 6.6.33+ #6
> [  464.325477] RIP: 0010:__get_user_pages+0x423/0x520
> [  464.325515] Call Trace:
> [  464.325520]  <TASK>
> [  464.325523]  ? __get_user_pages+0x423/0x520
> [  464.325528]  ? __warn+0x81/0x130
> [  464.325536]  ? __get_user_pages+0x423/0x520
> [  464.325541]  ? report_bug+0x171/0x1a0
> [  464.325549]  ? handle_bug+0x3c/0x70
> [  464.325554]  ? exc_invalid_op+0x17/0x70
> [  464.325558]  ? asm_exc_invalid_op+0x1a/0x20
> [  464.325567]  ? __get_user_pages+0x423/0x520
> [  464.325575]  __gup_longterm_locked+0x212/0x7a0
> [  464.325583]  internal_get_user_pages_fast+0xfb/0x190
> [  464.325590]  pin_user_pages_fast+0x47/0x60
> [  464.325598]  sev_pin_memory+0xca/0x170 [kvm_amd]
> [  464.325616]  sev_mem_enc_register_region+0x81/0x130 [kvm_amd]
> 

Well, we also have Yang Shi's patch
(https://lkml.kernel.org/r/20240627231601.1713119-1-yang@os.amperecomputing.com)
which takes a significantly different approach.  Which way should we
go?

