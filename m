Return-Path: <stable+bounces-67464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDAD9502CF
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 884CF283399
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA3195F3A;
	Tue, 13 Aug 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r3l1+fhI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB876025;
	Tue, 13 Aug 2024 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546068; cv=none; b=R8o0ob2LL5zRb2OU+/+2TG9bDBNsDUE5PNPZiRkQTKoyggatVOQrrtdZFJOweRt14WxR+lRLiZXdqLlK9XL/DYkVuPpG0Vcz2z37EAqLFKw+V95rvMJgKG0nqM2C06SWdSzdyFkfsCcbnCk4w8n47Z+3S+U2sbLUs8JuIZiFha8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546068; c=relaxed/simple;
	bh=Ushq3yq7eWPKyCu11/TlftefcEeOEHU4isTbb6y9I+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toHK916jyhqlT82zHzWXk8ZYdm2JYVfM46TPeiE2Y7bZ5GwPE4EeVhnqjrp35sflCew7TDrqgEkkQHi/dxRdSp+i9aCvjG9tN4Ag5REdDj5NRwKxN9kj7L8D/qIQrMv6w2dWm259GnfEdo4SpiwNaA3qxc6eRjnMuz/0q2UBFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r3l1+fhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A2CC4AF09;
	Tue, 13 Aug 2024 10:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723546067;
	bh=Ushq3yq7eWPKyCu11/TlftefcEeOEHU4isTbb6y9I+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r3l1+fhIRmS9mVp9YWscCFT0O+MMtFftrTyItd37qVs5e8+2XwFCbwuB6TvXljSfa
	 IP1Scsg6cBjg3zWrUne6jNxPwG1JNQsnKaT0JkRQ1mcbCZji01evJYP156ZxJXo2IP
	 f7lcKvbRAFa8yVN5r2qYVLRU3zy45mkz15IyKHWw=
Date: Tue, 13 Aug 2024 12:47:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: dennis@kernel.org, tj@kernel.org, cl@linux.com, mpe@ellerman.id.au,
	benh@kernel.crashing.org, paulus@samba.org,
	christophe.leroy@csgroup.eu, mahesh@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5.10 v2] powerpc: Avoid nmi_enter/nmi_exit in real mode
 interrupt.
Message-ID: <2024081318-onion-record-fdc7@gregkh>
References: <20240806071616.1671691-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806071616.1671691-1-ruanjinjie@huawei.com>

On Tue, Aug 06, 2024 at 07:16:16AM +0000, Jinjie Ruan wrote:
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

You forgot a 5.15.y version, which is of course required if we were to
take a 5.10.y version :(

Please resubmit both.

thanks,

greg k-h

