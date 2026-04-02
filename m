Return-Path: <stable+bounces-233011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGedECttzmnxngYAu9opvQ
	(envelope-from <stable+bounces-233011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:20:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04B38991D
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9746430D140B
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128621FF21;
	Thu,  2 Apr 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxqM3FmK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AFA3DD505;
	Thu,  2 Apr 2026 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135187; cv=none; b=nK9E4wYLyoRF8SvndJ3QEWzSa378kGRfjbmrMz1a09u9qgk9LlEC2LjOnkZZFDv1iw6/OD9CrTVwkDiXBmhz4eWrDyZdkwjYJIeODPFd4R5KOPKSRwCMbnRgQQpwT8JMkOMuaxsLbUnmZiJnNiwYi5LKOQ5Jk7UGMqwFaIDyeS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135187; c=relaxed/simple;
	bh=Et+I+O2edoOZ5oB6D/WOoAz54w335+zHcEaDAY9X5tM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ4xgYnfn0J2d6flt6euiQ/LpLBpQpXlI5uO+V4bq+Uf0jPe7IN9uSEDgsu2gQwze55V53xDIkBxisH356TxFgPcyj5Gu5st+g2KZfMUES6XwM0O5YJKSPBjW40rf2iVhmN+ULjloojbvJb6Q9VPbYNA87xBCiUXXN+rgr5Aryc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxqM3FmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5430FC116C6;
	Thu,  2 Apr 2026 13:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775135186;
	bh=Et+I+O2edoOZ5oB6D/WOoAz54w335+zHcEaDAY9X5tM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JxqM3FmKZ9GDcV7cvx3LvE9j0EXyIPp3+zt9SGuj8ayT0oDZpSlUtI+nyZsv7LDKb
	 gOsA6MfrMT6BMVqtSy2go8fkxhtBK0/YocX0zNHhD7noizqoXQtKgqhRWOVFY4serG
	 GNrGmr+xpWrdvEP9KdSomKoT2ZBV5PAmD00WuRMdfd24OZmu6LFUm8aOvzoXn3sFux
	 gGrGEqh2m6jF1cKPWksvlztB5+um79vipdokP/JahG47JOSNsSnuhupSYlb7g0Ddcs
	 hBSrL8GKi/ej82r5sGbryTnLIe74Npv4ttkkmzx2soEmjomdW18Pbq335gfJ6icqS6
	 0eub2hVg2UFew==
Date: Thu, 2 Apr 2026 14:06:21 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Qi Tang <tpluszz77@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Cyrill Gorcunov <gorcunov@openvz.org>, David Hildenbrand <david@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for
 PR_SET_MM_MAP
Message-ID: <686134c9-c2e3-444f-b83a-dd229c7b0102@lucifer.local>
References: <20260402111332.55957-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402111332.55957-1-tpluszz77@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233011-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lucifer.local:mid,openvz.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F04B38991D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 07:13:32PM +0800, Qi Tang wrote:
> prctl_set_mm_map() allows modifying all mm_struct boundaries and
> the saved auxv vector.  The individual field path (PR_SET_MM_START_CODE
> etc.) correctly requires CAP_SYS_RESOURCE, but the PR_SET_MM_MAP path
> dispatches before this check and has no capability requirement of its
> own when exe_fd is -1.
>
> This means any unprivileged user on a CONFIG_CHECKPOINT_RESTORE kernel
> (nearly all distros) can rewrite mm boundaries including start_brk, brk,
> arg_start/end, env_start/end and saved_auxv.  Consequences include:
>
>   - SELinux PROCESS__EXECHEAP bypass via start_brk manipulation
>   - procfs info disclosure by pointing arg/env ranges at other memory
>   - auxv poisoning (AT_SYSINFO_EHDR, AT_BASE, AT_ENTRY)
>
> The original commit f606b77f1a9e ("prctl: PR_SET_MM -- introduce
> PR_SET_MM_MAP operation") states "we require the caller to be at least
> user-namespace root user", but this was never enforced in the code.
>
> Add a checkpoint_restore_ns_capable() check at the top of
> prctl_set_mm_map(), after the PR_SET_MM_MAP_SIZE early return.  This
> requires CAP_CHECKPOINT_RESTORE or CAP_SYS_ADMIN in the caller's
> user namespace, matching the stated design intent and the existing
> check for exe_fd changes.
>
> Fixes: f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")

We've had a gaping security hole since 2014 and nobody noticed? I find it
hard to believe.

> Cc: stable@vger.kernel.org
> Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  kernel/sys.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index c86eba9aa7e9..2b8c57f23a35 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2071,6 +2071,9 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  		return put_user((unsigned int)sizeof(prctl_map),
>  				(unsigned int __user *)addr);
>
> +	if (!checkpoint_restore_ns_capable(current_user_ns()))
> +		return -EPERM;

Hmm there is already:

	if (prctl_map.exe_fd != (u32)-1) {
		/*
		 * Check if the current user is checkpoint/restore capable.
		 * At the time of this writing, it checks for CAP_SYS_ADMIN
		 * or CAP_CHECKPOINT_RESTORE.
		 * Note that a user with access to ptrace can masquerade an
		 * arbitrary program as any executable, even setuid ones.
		 * This may have implications in the tomoyo subsystem.
		 */
		if (!checkpoint_restore_ns_capable(current_user_ns()))
			return -EPERM;

And you're proposing _adding_ this check on top of that? Seems super
redundant.

but also, this seems super-specific buuut... Then again #ifdef
CONFIG_CHECKPOINT_RESTORE around this. Ugh.

I _hate_ this inteface. HATE HATE HATE it.

Anyway, does updating _your own_ auxv really require elevated permissions
like this?

I don't think so? Couldn't you go and manipulate that anyway without
elevated anything?


> +
>  	if (data_size != sizeof(prctl_map))
>  		return -EINVAL;
>
> --
> 2.43.0
>

This all seems unnecessary and in fact, surely would break userspace? Am I
missing something here?

Thanks, Lorenzo

