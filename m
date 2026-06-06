Return-Path: <stable+bounces-260835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U9w5HTGDI2pquwEAu9opvQ
	(envelope-from <stable+bounces-260835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 04:17:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D76C064C350
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 04:17:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T3DWM4Nd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260835-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260835-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0FF73016290
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 02:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838C22068D;
	Sat,  6 Jun 2026 02:17:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B9B18FDDE;
	Sat,  6 Jun 2026 02:17:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712239; cv=none; b=P8HdVL2AzggLIkBGWe+gKGLILmA6mYL3SJqFvYVfgcixqlvdVKwLsx3hAIzD8MT5QDwZPxeUpFTjsvsDdkzfi5qUh0Va1z215Lt24bj5KU2MYyQ/fWZu/SHJg2I8gwEiRlTFrkDQIsImx7X463xG4hK+fkwOcLmA9e9vB5Yh0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712239; c=relaxed/simple;
	bh=4PYcPlBuopRQJ/M7A1ZOntsm/pQ6Pdl6RGzjAAczD3c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RJRoYsyJhtoxSoKhWnfK/0TxsaL+AsKJK39BQYvduOomf4nwUVxQBHaL51H0W7SfpD4QgfO2Mkj+24lkeoz8HA1p4rOkK3u7s4hxrOipmHkgveod/EmAcB0ehCMqWOr1axJz0NkNFY0I9yJ4OtinoRprwpUy6JVHdGM9sGyvht4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3DWM4Nd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74B31F00893;
	Sat,  6 Jun 2026 02:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712237;
	bh=ztGn2nlySXSFbh8NnrJd3rQnSeLfdguQBF//iLPQjnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T3DWM4NdDiExnvViBz3etB+xH2qubwa4eatNE71v8bDi1elQFi1GZJo9hqG9XqHy7
	 NylGpFn3v3RQSch+RUQJC7IeZ3tWn0nStceGwquUpksdPHROq4Y9mYP6N8Eme6/9OA
	 yWXdJJJEvDR1+vIjOGPx6QpMU46p+cibPlT3QBuz9d3Mxc1etdJW2FMQPudTyna7Eg
	 XkFNM5oO/IXBU4NVWUEHtS1IyxJmS5rTOyQSBdKNTeSpslUvUjrghEuESHHMw8wtYh
	 7wzgtQWyQ9z6Af2cKPfAyucRSjCtfZ1MYJk2ylYLlQO8DGJBGgzb6ft8Au2jwVgfqR
	 tp0A/nfZvGvMg==
Date: Sat, 6 Jun 2026 11:17:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sami Cclvanen
 <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Eva Kurchatova
 <eva.kurchatova@virtuozzo.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cfi: Include uaccess.h for get_kernel_nofault()
Message-Id: <20260606111712.c004ecfb4a590a20b4ccb909@kernel.org>
In-Reply-To: <20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org>
References: <20260604-tracing-fix-cfi-h-build-error-v1-1-b27015390901@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260835-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nathan@kernel.org,m:rostedt@goodmis.org,m:samitolvanen@google.com,m:kees@kernel.org,m:eva.kurchatova@virtuozzo.com,m:mhiramat@kernel.org,m:llvm@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D76C064C350

On Thu, 04 Jun 2026 17:33:21 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> After commit 0652a3daa787 ("tracing: Fix CFI violation in probestub
> being called by tprobes"), there are many build errors when building
> ARCH=arm multi_v7_defconfig + CONFIG_CFI=y like:
> 
>   In file included from drivers/base/devres.c:17:
>   In file included from drivers/base/trace.h:16:
>   In file included from include/linux/tracepoint.h:23:
>   include/linux/cfi.h:44:6: error: call to undeclared function 'get_kernel_nofault'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      44 |         if (get_kernel_nofault(hash, func - cfi_get_offset()))
>         |             ^
>   1 error generated.
> 
> get_kernel_nofault() is called in the generic version of
> cfi_get_func_hash() but nothing ensures uaccess.h is always included for
> a proper expansion and prototype. Include uaccess.h in cfi.h to clear up
> the errors.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0652a3daa787 ("tracing: Fix CFI violation in probestub being called by tprobes")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Oops, good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> ---
>  include/linux/cfi.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/cfi.h b/include/linux/cfi.h
> index 1fd22ea6eba4..0f220d29225c 100644
> --- a/include/linux/cfi.h
> +++ b/include/linux/cfi.h
> @@ -9,6 +9,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/module.h>
> +#include <linux/uaccess.h>
>  #include <asm/cfi.h>
>  
>  #ifdef CONFIG_CFI
> 
> ---
> base-commit: 0652a3daa78723f955b1ebeb621665ce72bec53e
> change-id: 20260604-tracing-fix-cfi-h-build-error-36c2becf7d15
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

