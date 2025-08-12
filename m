Return-Path: <stable+bounces-167155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D68B227C4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 15:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D2743A73D4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48A27815F;
	Tue, 12 Aug 2025 13:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H87I8mjK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8687276022
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755003624; cv=none; b=BL/+wseFOJsSm0VC/IQFi7lME2g7oWGLt1oCpxj21vFoOwzZQqjN/5IEya5BChWKq1tFQl/rmVigRYiIUUaFSLsizYnoAIXfEGTxgXp7T4ODTcJXxKYmqqkTgGwwdxNL32Fl1N2f3ddlXuNk9hHVsa6VZZm5p8NaE+NH9KLWs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755003624; c=relaxed/simple;
	bh=PG8hVJjep3gKKXlbagGMnZ0xM7MzoS5P57P2DRnxoek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd8i6mwlzNOzSehHxWGDGHlAJRUTi6cPkxjHyKhKSBSLHWyuxg4k9Hbo9QsRwwdWolbfeaixIHDO9WKwXkpy2Zdzp0mqzdXSICe1+tQCz3zSc4CrFAEwq2/3G550dNsSFaC0W3jLntuYPrtVHqEjL5EYWa73W6GURddejGDoavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H87I8mjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABFDC4CEF0;
	Tue, 12 Aug 2025 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755003624;
	bh=PG8hVJjep3gKKXlbagGMnZ0xM7MzoS5P57P2DRnxoek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H87I8mjK4BR3lRI7tKXcVv8B+87D+Mh5veIJIxIiTBgc+2ue679kYkJObF+8XMmm7
	 SqtRv9q6zLnyrpAFJaJvBftohGlDCMeFiHeXE7mktI3NWr5sj3qBJEHmEb7JfW5GgI
	 RPxSauy/knFEtTpnzgeO5iC6o6DuSXmUb43i2Xd0=
Date: Tue, 12 Aug 2025 15:00:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jimmy Tran <jtoantran@google.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight@aculab.com>,
	Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2 2/7] runtime constants: add default dummy
 infrastructure
Message-ID: <2025081229-unwound-palpitate-7671@gregkh>
References: <20250806162003.1134886-1-jtoantran@google.com>
 <20250806162003.1134886-3-jtoantran@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806162003.1134886-3-jtoantran@google.com>

On Wed, Aug 06, 2025 at 04:19:58PM +0000, Jimmy Tran wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> commit e78298556ee5d881f6679effb2a6743969ea6e2d upstream.
> 
> This adds the initial dummy support for 'runtime constants' for when
> an architecture doesn't actually support an implementation of fixing
> up said runtime constants.
> 
> This ends up being the fallback to just using the variables as regular
> __ro_after_init variables, and changes the dcache d_hash() function to
> use this model.
> 
> Cc: <stable@vger.kernel.org> # 6.10.x: e60cc61: vfs: dcache: move hashlen_hash
> Fixes: e78298556ee5 ("runtime constants: add default dummy infrastructure")
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jimmy Tran <jtoantran@google.com>
> ---
>  fs/dcache.c                         | 11 ++++++++++-
>  include/asm-generic/Kbuild          |  1 +
>  include/asm-generic/runtime-const.h | 15 +++++++++++++++
>  include/asm-generic/vmlinux.lds.h   |  8 ++++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
>  create mode 100644 include/asm-generic/runtime-const.h
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 82adee104f82c..9e5c92b4b4aaa 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -35,6 +35,8 @@
>  #include "internal.h"
>  #include "mount.h"
>  
> +#include <asm/runtime-const.h>
> +
>  /*
>   * Usage:
>   * dcache->d_inode->i_lock protects:
> @@ -102,7 +104,8 @@ static struct hlist_bl_head *dentry_hashtable __read_mostly;
>  
>  static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
>  {
> -	return dentry_hashtable + ((u32)hashlen >> d_hash_shift);
> +	return runtime_const_ptr(dentry_hashtable) +
> +		runtime_const_shift_right_32(hashlen, d_hash_shift);
>  }
>  
>  #define IN_LOOKUP_SHIFT 10
> @@ -3297,6 +3300,9 @@ static void __init dcache_init_early(void)
>  					0,
>  					0);
>  	d_hash_shift = 32 - d_hash_shift;
> +
> +	runtime_const_init(shift, d_hash_shift);
> +	runtime_const_init(ptr, dentry_hashtable);
>  }
>  
>  static void __init dcache_init(void)
> @@ -3325,6 +3331,9 @@ static void __init dcache_init(void)
>  					0,
>  					0);
>  	d_hash_shift = 32 - d_hash_shift;
> +
> +	runtime_const_init(shift, d_hash_shift);
> +	runtime_const_init(ptr, dentry_hashtable);
>  }
>  
>  /* SLAB cache for __getname() consumers */
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 941be574bbe00..22673ec5defbb 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -46,6 +46,7 @@ mandatory-y += pci.h
>  mandatory-y += percpu.h
>  mandatory-y += pgalloc.h
>  mandatory-y += preempt.h
> +mandatory-y += runtime-const.h
>  mandatory-y += rwonce.h
>  mandatory-y += sections.h
>  mandatory-y += serial.h
> diff --git a/include/asm-generic/runtime-const.h b/include/asm-generic/runtime-const.h
> new file mode 100644
> index 0000000000000..3e68a17fbf287
> --- /dev/null
> +++ b/include/asm-generic/runtime-const.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RUNTIME_CONST_H
> +#define _ASM_RUNTIME_CONST_H
> +
> +/*
> + * This is the fallback for when the architecture doesn't
> + * support the runtime const operations.
> + *
> + * We just use the actual symbols as-is.
> + */
> +#define runtime_const_ptr(sym) (sym)
> +#define runtime_const_shift_right_32(val, sym) ((u32)(val)>>(sym))
> +#define runtime_const_init(type, sym) do { } while (0)
> +
> +#endif
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index cf3f8b9bf43f0..66bfd3dc91a33 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -907,6 +907,14 @@
>  #define CON_INITCALL							\
>  	BOUNDED_SECTION_POST_LABEL(.con_initcall.init, __con_initcall, _start, _end)
>  
> +#define RUNTIME_NAME(t, x) runtime_##t##_##x

I appreciate wanting to do things in the proper coding style, but when
backporting commits, please do NOT make whitespace changes like this as
it makes follow-on patches hard, if not impossible, to ever apply.

This is doubly important when dealing with maintaining kernel trees for
the number of years we do here, tiny things like this add up quickly and
make just more and more work overall for everyone involved.

Same for later commits in this series, please do not add extra
whitespace where the original commit did not have it.  Can you fix this
all up and submit a v3 after verifying it works correctly?

thanks,

greg k-h

