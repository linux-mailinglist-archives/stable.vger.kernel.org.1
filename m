Return-Path: <stable+bounces-247383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKIVNHCxBmpInAIAu9opvQ
	(envelope-from <stable+bounces-247383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:38:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710A549A00
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FED43025A73
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD7735F8A8;
	Fri, 15 May 2026 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNWRyG/o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1AF35F195
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823533; cv=none; b=R9hbJ88RGpvYpM6CfadwRZ2T7UmAo0GFOwBoAuPO+AFpUKImWq7FsYFaGTp7NdabA5fFLYs5ZzWELSmy5cfAibsVJOrZbMWG2z3coWVreDfJRYbbEwqjGwPNOa7s+D1EfPnrrw8+M4hpLHMx67IyxDKVgNsemsXBW1C3B7wb1ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823533; c=relaxed/simple;
	bh=3/HuDKB1F7gNIQxks/roKfN8/dVFZ5QEQF7ozAdegvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rd1blONvpUP3wOhYPor5y5ZRJz0Mxt15GFgcYQK1qkeIlla1X8dh0aFFkANGxP3d0MalTr/MofZbQh1A0gecoN0HWDTckCS/D0L8uGqkAaAr2pDNx/6I1zPYfvbVEpDhC5s7nGHhU9n/VjohqFYSFSr+0CsQTSEnWZnwef3nyjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNWRyG/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638ACC2BCC7;
	Fri, 15 May 2026 05:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778823533;
	bh=3/HuDKB1F7gNIQxks/roKfN8/dVFZ5QEQF7ozAdegvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNWRyG/oN0/YA3bYBjadRk/rd5eXqHGcSIoYUyYEi9lZMYhyq8oGByJKhDRsS1q0R
	 iWhTYM0Whc6K1L5qNaPm1hZqt0kUtQZ6Z9poTatdQRCHomv45zuqEdY3wMpQ/SsHiW
	 6XjyHLM+GvvwKNH9kV98CIt4s7gPSi+k/mwdWeUsr9lw4dL+PLm6takBeg6WPppgFB
	 KC0bHPKtHTONTNd+Almr7mCzrv6mTo4QccCIznslUN+I7cLr+/50FmF+YZpFv2S/SQ
	 U45+XVtVjnl3nmAO0cGA13awuQabnNe4SgaJoQOXqQ+gRw2wrK3kjAKRUoq7wl0uLe
	 B8vyJyIruQG4g==
Date: Fri, 15 May 2026 08:38:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7.0.y] kho: fix error handling in kho_add_subtree()
Message-ID: <agaxZgzfomonva8O@kernel.org>
References: <2026051212-boil-trivial-8d5e@gregkh>
 <20260514192553.1255751-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260514192553.1255751-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 4710A549A00
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-247383-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soleen.com:email]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 03:25:53PM -0400, Sasha Levin wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> [ Upstream commit 9ec95329894864170a1a7685b9a11b739393131a ]
> 
> Fix two error handling issues in kho_add_subtree(), where it doesn't
> handle the error path correctly.
> 
> 1. If fdt_setprop() fails after the subnode has been created, the
>    subnode is not removed. This leaves an incomplete node in the FDT
>    (missing "preserved-data" or "blob-size" properties).
> 
> 2. The fdt_setprop() return value (an FDT error code) is stored
>    directly in err and returned to the caller, which expects -errno.
> 
> Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
> out_del_node label that removes the subnode on failure, and only setting
> err = 0 on the success path, otherwise returning -ENOMEM (instead of
> FDT_ERR_ errors that would come from fdt_setprop).
> 
> No user-visible changes.  This patch fixes error handling in the KHO
> (Kexec HandOver) subsystem, which is used to preserve data across kexec
> reboots.  The fix only affects a rare failure path during kexec
> preparation — specifically when the kernel runs out of space in the
> Flattened Device Tree buffer while registering preserved memory regions.
> 
> In the unlikely event that this error path was triggered, the old code
> would leave a malformed node in the device tree and return an incorrect
> error code to the calling subsystem, which could lead to confusing log
> messages or incorrect recovery decisions.  With this fix, the incomplete
> node is properly cleaned up and the appropriate errno value is propagated,
> this error code is not returned to the user.
> 
> Link: https://lore.kernel.org/20260410-kho_fix_send-v2-1-1b4debf7ee08@debian.org
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  kernel/liveupdate/kexec_handover.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index cc68a3692905d..479c42e08b74a 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -757,13 +757,18 @@ int kho_add_subtree(const char *name, void *fdt)
>  		goto out_pack;
>  	}
>  
> -	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
> -			  &phys, sizeof(phys));
> -	if (err < 0)
> -		goto out_pack;
> +	fdt_err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
> +			      &phys, sizeof(phys));
> +	if (fdt_err < 0)
> +		goto out_del_node;
>  
>  	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
>  
> +	err = 0;
> +	goto out_pack;
> +
> +out_del_node:
> +	fdt_del_node(root_fdt, off);
>  out_pack:
>  	fdt_pack(root_fdt);
>  
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.

