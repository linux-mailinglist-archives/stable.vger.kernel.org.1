Return-Path: <stable+bounces-103970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 749719F0566
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 08:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A824618841D2
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 07:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1218BC3D;
	Fri, 13 Dec 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s5oEFtIX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897881552FC
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734074473; cv=none; b=K87N6Zv58xbVY3wB/DmjPBEEPABruEC09noptLg0zvnq/xhTarHGeNp1YVZyVBVhbKA+yJAO+74cXb2+9b1ziB/z3IIZibR5KYivU0Af90H4WYWfu4liNwVeguNbkC3z404xGhixEPXxCtMaDOiGglS/lPg8QCXXnT4AdCiw/nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734074473; c=relaxed/simple;
	bh=D00YNVaarW3vo7navvgOw+W96oC5Ktk9l9p8wmXRn8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgsXhmfnuGt+dA451HJOI6P+1uIGv4x09/3GRSyd9NQDFzO/9uiwKTzcHXL4TqSOiHDJ3TFPR9Y4Z6HDewfIenn1DuESH5voe53huPrj5CsPYLOyytNLLxzKgr1tZk2r+BkDaWTI3lnXgIzY8ouxiI4LUwqzmlAD1oZgR4rnqFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s5oEFtIX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9732CC4CEDE;
	Fri, 13 Dec 2024 07:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734074473;
	bh=D00YNVaarW3vo7navvgOw+W96oC5Ktk9l9p8wmXRn8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5oEFtIXk5d/t6CZuh/l1/BjHnyO0RPKCJESEZL58BM7iYJm6bOYboWYAU4WjFO1d
	 lOAJSoHOvUonjskba6ajP85CorJ8fIJk6CGoR398cnOgmbsGlEH8WtKt9uDIrWMzJf
	 lefMgq8oYzziAm4f6nXmR8Sz/LBoGQn7+2Rsq8b8=
Date: Fri, 13 Dec 2024 08:20:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: stable@vger.kernel.org, mschmidt@redhat.com, selvin.xavier@broadcom.com,
	leon@kernel.org
Subject: Re: [PATCH V3][5.15.y] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
Message-ID: <2024121304-doily-knelt-6193@gregkh>
References: <20241213034620.2897953-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213034620.2897953-1-guocai.he.cn@windriver.com>

On Fri, Dec 13, 2024 at 11:46:20AM +0800, guocai.he.cn@windriver.com wrote:
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
> Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
> ---
> This commit is to solve the CVE-2024-38540. Please merge this commit to linux-5.15.y.
> 
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> index dea70db9ee97..82d7381dbd6d 100644
> --- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> +++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
> @@ -1013,7 +1013,8 @@ int bnxt_qplib_create_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
>  	hwq_attr.stride = sizeof(struct sq_sge);
>  	hwq_attr.depth = bnxt_qplib_get_depth(sq);
>  	hwq_attr.aux_stride = psn_sz;
> -	hwq_attr.aux_depth = bnxt_qplib_set_sq_size(sq, qp->wqe_mode);
> +	hwq_attr.aux_depth = psn_sz ? bnxt_qplib_set_sq_size(sq, qp->wqe_mode)
> +				    : 0;
>  	hwq_attr.type = HWQ_TYPE_QUEUE;
>  	rc = bnxt_qplib_alloc_init_hwq(&sq->hwq, &hwq_attr);
>  	if (rc)
> -- 
> 2.34.1
> 
> V3: Cherry-pick not from 6.1.y but from upstream directly.

The "vX" stuff goes below the first --- line as the documentation asks
for :(

