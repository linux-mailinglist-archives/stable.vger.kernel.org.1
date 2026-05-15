Return-Path: <stable+bounces-248903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKHzAo55B2oJ5AIAu9opvQ
	(envelope-from <stable+bounces-248903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:52:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFC4557224
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51CC830419C8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4428D384CF3;
	Fri, 15 May 2026 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkPUbcm8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61953806BE;
	Fri, 15 May 2026 19:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874007; cv=none; b=Ap704TyjAeD3egosiQZInkzfSgA/Jr8dlPiuwHDhfeg7VT6UDoV2RY9nnDQg5hrISxN84Z8voGXRYaEPcvr2J2noyK8L1nn1+ChTavsh55TdnloYHkmPMdgZlxRVBtyaWy9cczTDygsgPlWUI6l6aDDVtwetSbsMryUt3wG7HH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874007; c=relaxed/simple;
	bh=3yyQkYdxChwarAweftCvJrPicHgtEMSdTY4CgyHFHQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjJenMvGfmhFKd10u7hiXCBAhLsm2X33vd4Pa+NNq+e1i89eDpTaGuqNXkXt5mxLQw4Wmw3O/5huaGHiA1dGxtxDthP/EJb7zEbrghdcww2G6ReEe1fGKiZh4i1U9X2W0TEZbfw1CO1jtmTTN2QAaiK5MB/OFu3b2eYc7Z9SXAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkPUbcm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4EBC2BCB3;
	Fri, 15 May 2026 19:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778874006;
	bh=3yyQkYdxChwarAweftCvJrPicHgtEMSdTY4CgyHFHQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkPUbcm8VX6YlsCEuEPuJrnYm9SbKuyFOtePI+sU8nRJRhOpok/mJB1eLpXLAQdEt
	 jJog4xlA8nxDF0OlC+YML7KHZVAFB2QwcTEE671syL5xPhEP7O6nYh7WWjely9B9zf
	 +c4a9GATU5oaP8k+gzAh0wGrpYnB/CcpNydmOhX353a97eP7o16Fvv+kpD0Y33v32y
	 c5fZskya4WtVGUOF9KVfzXFDlYWgSpzupIsgr5CIbUNsRgKGrLD6PfOyXL6ldxTIb9
	 8w1Uo91Bfhrexx54X2rzou0gZODnS86I+a+tiD6nfpaQLfsWH16/RsNljP3ESb5yjX
	 WLuPE3BOIQMKA==
Date: Sat, 16 May 2026 04:40:01 +0900
From: Nathan Chancellor <nathan@kernel.org>
To: Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] Disable -Wattribute-alias for clang-23 and newer
Message-ID: <20260515194001.GA3434682@ax162>
References: <20260515-syscall-disable-attribute-alias-for-clang-v1-1-9a9d95d41df6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-syscall-disable-attribute-alias-for-clang-v1-1-9a9d95d41df6@kernel.org>
X-Rspamd-Queue-Id: EAFC4557224
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248903-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 07:35:18PM +0900, Nathan Chancellor wrote:
> Clang recently added support for -Wattribute-alias [1], which results in
> the same warnings that necessitated commit bee20031772a ("disable
> -Wattribute-alias warning for SYSCALL_DEFINEx()") for GCC.
> 
>   kernel/time/itimer.c:325:1: error: alias and aliasee have different types 'long (unsigned int)' and 'long (typeof (__builtin_choose_expr((__builtin_types_compatible_p(typeof ((unsigned int)0), typeof (0LL)) || __builtin_types_compatible_p(typeof ((unsigned int)0), typeof (0ULL))), 0LL, 0L)))' (aka 'long (long)') [-Werror,-Wattribute-alias]
>     325 | SYSCALL_DEFINE1(alarm, unsigned int, seconds)
>         | ^
>   include/linux/syscalls.h:225:36: note: expanded from macro 'SYSCALL_DEFINE1'
>     225 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
>         |                                    ^
>   include/linux/syscalls.h:236:2: note: expanded from macro 'SYSCALL_DEFINEx'
>     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>         |         ^
>   include/linux/syscalls.h:251:18: note: expanded from macro '__SYSCALL_DEFINEx'
>     251 |                 __attribute__((alias(__stringify(__se_sys##name))));    \
>         |                                ^
>   kernel/time/itimer.c:325:1: note: aliasee is declared here
>   include/linux/syscalls.h:225:36: note: expanded from macro 'SYSCALL_DEFINE1'
>     225 | #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
>         |                                    ^
>   include/linux/syscalls.h:236:2: note: expanded from macro 'SYSCALL_DEFINEx'
>     236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>         |         ^
>   include/linux/syscalls.h:255:18: note: expanded from macro '__SYSCALL_DEFINEx'
>     255 |         asmlinkage long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))  \
>         |                         ^
>   <scratch space>:16:1: note: expanded from here
>      16 | __se_sys_alarm
>         | ^
> 
> Disable the warnings in the same way for clang-23 and newer.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2163
> Link: https://github.com/llvm/llvm-project/commit/40da6920a0d71d49dfa2392b09153600b0759f5e [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> I plan to take this via my clang-fixes tree for 7.1.
> ---
>  arch/riscv/include/asm/syscall_wrapper.h | 2 ++
>  include/linux/compat.h                   | 2 ++
>  include/linux/compiler-clang.h           | 6 ++++++
>  include/linux/syscalls.h                 | 2 ++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
> index ac80216549ff..366a5354caa5 100644
> --- a/arch/riscv/include/asm/syscall_wrapper.h
> +++ b/arch/riscv/include/asm/syscall_wrapper.h
> @@ -32,6 +32,8 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
>  	__diag_push();									\
>  	__diag_ignore(GCC, 8, "-Wattribute-alias",					\
>  			"Type aliasing is used to sanitize syscall arguments");		\
> +	__diag_ignore(clang, 23, "-Wattribute-alias",					\
> +			"Type aliasing is used to sanitize syscall arguments");		\
>  	static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong, 	\
>  					ulong)						\
>  			__attribute__((alias(__stringify(___se_##prefix##name))));	\
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 56cebaff0c91..a1ce6d559db9 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -72,6 +72,8 @@
>  	__diag_push();								\
>  	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
>  		      "Type aliasing is used to sanitize syscall arguments");\
> +	__diag_ignore(clang, 23, "-Wattribute-alias",				\
> +		      "Type aliasing is used to sanitize syscall arguments");\
>  	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
>  		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
>  	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index e1123dd28486..527e4e136020 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -131,6 +131,12 @@
>  #define __diag_str(s)		__diag_str1(s)
>  #define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
>  
> +#if CONFIG_CLANG_VERSION >= 230000
> +#define __diag_clang_23(s)	__diag(s)
> +#else
> +#define __diag_clang_23(s)
> +#endif
> +
>  #define __diag_clang_13(s)	__diag(s)
>  
>  #define __diag_ignore_all(option, comment) \
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f5639d5ac331..97e3411b49d2 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -247,6 +247,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>  	__diag_push();							\
>  	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
>  		      "Type aliasing is used to sanitize syscall arguments");\
> +	__diag_ignore(clang, 23, "-Wattribute-alias",			\
> +		      "Type aliasing is used to sanitize syscall arguments");\
>  	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
>  		__attribute__((alias(__stringify(__se_sys##name))));	\
>  	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\

The kbuild test robot pointed out that I need

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e8fd77593b68..369966598a2c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -711,6 +711,10 @@ struct ftrace_likely_data {
 #define __diag_GCC(version, severity, string)
 #endif
 
+#ifndef __diag_clang
+#define __diag_clang(version, severity, string)
+#endif
+
 #define __diag_push()	__diag(push)
 #define __diag_pop()	__diag(pop)
 
--

for this to build properly with GCC, which I will fold in.

-- 
Cheers,
Nathan

