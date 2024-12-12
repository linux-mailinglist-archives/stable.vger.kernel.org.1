Return-Path: <stable+bounces-100834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C026A9EDF9D
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 07:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C83282281
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 06:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426B204C24;
	Thu, 12 Dec 2024 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0bkgDYMi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F217084F
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986498; cv=none; b=Z3h6FC3RpvtCYsYOtgSTpLks4Bbnw/fn3YA+RwfNU3FvVAcdy4XhNSZ+PDBIFwedLQOE5ewnl0jEAVHt8rgL6vx40DLY/F03z/K0HHxoEjIEvnZP47HJe781dHUXGejRGxCWJMuqYFrGHo0SyfUpt41BbNe4bfZoYRvSGdrAUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986498; c=relaxed/simple;
	bh=gn7VzkkWr+pTqO59IvU7KgfrYTDg92Nu/OjZXlTGBnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCixIXT5CDBRCkIQRMey2HOXcJMcEGRctqS5+xaqApbB7aa8N7CcYoDybx6vt1qKJmZw+/Mtgc8EhwOXDg/vRiH7Aaa3NB0ETH+Vb/GgiPe0scmhubYL37N0uYtdoSKZ6FkeMIbTeO+dZlKQVpVOYW4sSZz9UuOePzBHXOeD1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0bkgDYMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A414C4CED3;
	Thu, 12 Dec 2024 06:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733986497;
	bh=gn7VzkkWr+pTqO59IvU7KgfrYTDg92Nu/OjZXlTGBnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0bkgDYMifkuobBA2lpnxlSVuvR66CqT7+zQ3rQnI6ckqNv5tn3ijOZ3hbJ2usPKNh
	 w+zySdLxNEB9P+X8QdkdpPwZq4Fj4Om6n4RW7C8z0TfJI2XF/lxivcB9Vjr8m91lVt
	 qLHbch+stQayUppxurXHCXvSc5TA60fd6WssEfg4=
Date: Thu, 12 Dec 2024 07:54:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: mschmidt@redhat.com, selvin.xavier@broadcom.com, leon@kernel.org,
	xiangyu.chen@windriver.com, stable@vger.kernel.org
Subject: Re: [PATCH V2][5.15.y] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
Message-ID: <2024121257-enticing-uncolored-fe71@gregkh>
References: <20241212064846.1079097-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212064846.1079097-1-guocai.he.cn@windriver.com>

On Thu, Dec 12, 2024 at 02:48:46PM +0800, guocai.he.cn@windriver.com wrote:
> From: Michal Schmidt <mschmidt@redhat.com>
> 
> commit 78cfd17142ef70599d6409cbd709d94b3da58659 upstream.
> 
> Undefined behavior is triggered when bnxt_qplib_alloc_init_hwq is called
> with hwq_attr->aux_depth != 0 and hwq_attr->aux_stride == 0.
> In that case, "roundup_pow_of_two(hwq_attr->aux_stride)" gets called.
> roundup_pow_of_two is documented as undefined for 0.
> 
> Fix it in the one caller that had this combination.
> 
> The undefined behavior was detected by UBSAN:
>   UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>   shift exponent 64 is too large for 64-bit type 'long unsigned int'
>   CPU: 24 PID: 1075 Comm: (udev-worker) Not tainted 6.9.0-rc6+ #4
>   Hardware name: Abacus electric, s.r.o. - servis@abacus.cz Super Server/H12SSW-iN, BIOS 2.7 10/25/2023
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5d/0x80
>    ubsan_epilogue+0x5/0x30
>    __ubsan_handle_shift_out_of_bounds.cold+0x61/0xec
>    __roundup_pow_of_two+0x25/0x35 [bnxt_re]
>    bnxt_qplib_alloc_init_hwq+0xa1/0x470 [bnxt_re]
>    bnxt_qplib_create_qp+0x19e/0x840 [bnxt_re]
>    bnxt_re_create_qp+0x9b1/0xcd0 [bnxt_re]
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __kmalloc+0x1b6/0x4f0
>    ? create_qp.part.0+0x128/0x1c0 [ib_core]
>    ? __pfx_bnxt_re_create_qp+0x10/0x10 [bnxt_re]
>    create_qp.part.0+0x128/0x1c0 [ib_core]
>    ib_create_qp_kernel+0x50/0xd0 [ib_core]
>    create_mad_qp+0x8e/0xe0 [ib_core]
>    ? __pfx_qp_event_handler+0x10/0x10 [ib_core]
>    ib_mad_init_device+0x2be/0x680 [ib_core]
>    add_client_context+0x10d/0x1a0 [ib_core]
>    enable_device_and_get+0xe0/0x1d0 [ib_core]
>    ib_register_device+0x53c/0x630 [ib_core]
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    bnxt_re_probe+0xbd8/0xe50 [bnxt_re]
>    ? __pfx_bnxt_re_probe+0x10/0x10 [bnxt_re]
>    auxiliary_bus_probe+0x49/0x80
>    ? driver_sysfs_add+0x57/0xc0
>    really_probe+0xde/0x340
>    ? pm_runtime_barrier+0x54/0x90
>    ? __pfx___driver_attach+0x10/0x10
>    __driver_probe_device+0x78/0x110
>    driver_probe_device+0x1f/0xa0
>    __driver_attach+0xba/0x1c0
>    bus_for_each_dev+0x8f/0xe0
>    bus_add_driver+0x146/0x220
>    driver_register+0x72/0xd0
>    __auxiliary_driver_register+0x6e/0xd0
>    ? __pfx_bnxt_re_mod_init+0x10/0x10 [bnxt_re]
>    bnxt_re_mod_init+0x3e/0xff0 [bnxt_re]
>    ? __pfx_bnxt_re_mod_init+0x10/0x10 [bnxt_re]
>    do_one_initcall+0x5b/0x310
>    do_init_module+0x90/0x250
>    init_module_from_file+0x86/0xc0
>    idempotent_init_module+0x121/0x2b0
>    __x64_sys_finit_module+0x5e/0xb0
>    do_syscall_64+0x82/0x160
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? syscall_exit_to_user_mode_prepare+0x149/0x170
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? syscall_exit_to_user_mode+0x75/0x230
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? do_syscall_64+0x8e/0x160
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __count_memcg_events+0x69/0x100
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? count_memcg_events.constprop.0+0x1a/0x30
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? handle_mm_fault+0x1f0/0x300
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? do_user_addr_fault+0x34e/0x640
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>   RIP: 0033:0x7f4e5132821d
>   Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 db 0c 00 f7 d8 64 89 01 48
>   RSP: 002b:00007ffca9c906a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>   RAX: ffffffffffffffda RBX: 0000563ec8a8f130 RCX: 00007f4e5132821d
>   RDX: 0000000000000000 RSI: 00007f4e518fa07d RDI: 000000000000003b
>   RBP: 00007ffca9c90760 R08: 00007f4e513f6b20 R09: 00007ffca9c906f0
>   R10: 0000563ec8a8faa0 R11: 0000000000000246 R12: 00007f4e518fa07d
>   R13: 0000000000020000 R14: 0000563ec8409e90 R15: 0000563ec8a8fa60
>    </TASK>
>   ---[ end trace ]---
> 
> Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Link: https://lore.kernel.org/r/20240507103929.30003-1-mschmidt@redhat.com
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I have not signed off on this backport, why did you add this here?  You
do know what this is saying right?

Please work with your other kernel developers at your company for you
all to come up with a better workflow for doing all of these backports.
What you are doing here now just isn't working for us at all, sorry.

greg k-h

