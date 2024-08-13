Return-Path: <stable+bounces-67485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25FB950584
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751B11F23360
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A3D19ADAD;
	Tue, 13 Aug 2024 12:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C9jbhGYG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA07E2B9DB;
	Tue, 13 Aug 2024 12:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553297; cv=none; b=LYHXED+NXGhfuv19WehDU1c15HzZt22lY7c/yxirs7gAcZq/Ek5cw+68yUey18iUKG7BwTxZLJla8deKIzuY2Qy7RolM8wv+fzY7Gx3JNgVRSRt/QsSI6ajPgUhNnPpjnHHvIgIDtHx29ORC6XZNcSYgo9DBKLMAzhFZrnI94Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553297; c=relaxed/simple;
	bh=RziWQbGPcphT0DheUuaZXAysq9JFjHQrRNJwB3unbyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PVJLqfT+LhXo+4zXfP6nF21ymaC//0dd2W1KwyeF8VnL6+UcjG/ZM+W/ZFANv4Zln5l5j4BUg1pOaR2Fu712MMcSGIsgufYTABG31OxJaiKRKtYVS5Cl1Kf4SyU6YzY0MCP3s0+mkMRMZXsSN9rIRORkBaaYBi5F1MViWA0+S2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C9jbhGYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9137CC4AF0B;
	Tue, 13 Aug 2024 12:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723553297;
	bh=RziWQbGPcphT0DheUuaZXAysq9JFjHQrRNJwB3unbyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C9jbhGYG344AISh8pnaHlo0ATw6yrcbWL9eCLADvEQNpV+Ov7YmTCCHT6jxxyWxW6
	 arz9IojhXJYtNzh6LVpNWDMgoO3ctvmNg9s2FLGl9BLYMh6S7eVGM+9m4r6t4l+qop
	 y+tIY9N90Rd2Fx6lJ1v4WhLxzawiJI64uxlFNlBc=
Date: Tue, 13 Aug 2024 14:48:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: dennis@kernel.org, tj@kernel.org, cl@linux.com, mpe@ellerman.id.au,
	benh@kernel.crashing.org, paulus@samba.org,
	christophe.leroy@csgroup.eu, mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5.10 v2 RESEND] powerpc: Avoid nmi_enter/nmi_exit in
 real mode interrupt.
Message-ID: <2024081306-pointless-pacemaker-32b2@gregkh>
References: <20240813113344.1837556-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813113344.1837556-1-ruanjinjie@huawei.com>

On Tue, Aug 13, 2024 at 11:33:44AM +0000, Jinjie Ruan wrote:
> From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> 
> [ Upstream commit 0db880fc865ffb522141ced4bfa66c12ab1fbb70 ]
> 
> nmi_enter()/nmi_exit() touches per cpu variables which can lead to kernel
> crash when invoked during real mode interrupt handling (e.g. early HMI/MCE
> interrupt handler) if percpu allocation comes from vmalloc area.
> 
> Early HMI/MCE handlers are called through DEFINE_INTERRUPT_HANDLER_NMI()
> wrapper which invokes nmi_enter/nmi_exit calls. We don't see any issue when
> percpu allocation is from the embedded first chunk. However with
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there are chances where percpu
> allocation can come from the vmalloc area.
> 
> With kernel command line "percpu_alloc=page" we can force percpu allocation
> to come from vmalloc area and can see kernel crash in machine_check_early:
> 
> [    1.215714] NIP [c000000000e49eb4] rcu_nmi_enter+0x24/0x110
> [    1.215717] LR [c0000000000461a0] machine_check_early+0xf0/0x2c0
> [    1.215719] --- interrupt: 200
> [    1.215720] [c000000fffd73180] [0000000000000000] 0x0 (unreliable)
> [    1.215722] [c000000fffd731b0] [0000000000000000] 0x0
> [    1.215724] [c000000fffd73210] [c000000000008364] machine_check_early_common+0x134/0x1f8
> 
> Fix this by avoiding use of nmi_enter()/nmi_exit() in real mode if percpu
> first chunk is not embedded.
> 
> CVE-2024-42126
> Cc: stable@vger.kernel.org#5.10.x
> Cc: gregkh@linuxfoundation.org
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Tested-by: Shirisha Ganta <shirisha@linux.ibm.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Link: https://msgid.link/20240410043006.81577-1-mahesh@linux.ibm.com
> [ Conflicts in arch/powerpc/include/asm/interrupt.h
>   because machine_check_early() and machine_check_exception()
>   has been refactored. ]
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v2:
> - Also fix for CONFIG_PPC_BOOK3S_64 not enabled.
> - Add Upstream.
> - Cc stable@vger.kernel.org.
> ---

Both now queued up, thanks.

greg k-h

