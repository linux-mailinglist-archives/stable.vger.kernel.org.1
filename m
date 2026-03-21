Return-Path: <stable+bounces-227799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qApoOm8wv2mXyQMAu9opvQ
	(envelope-from <stable+bounces-227799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 00:57:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C6C2E7AE4
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 00:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A0A2301A436
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669D02E6CCD;
	Sat, 21 Mar 2026 23:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+4dhaM2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E755280037
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774137446; cv=none; b=Svo7etF9kuO4UkCvlAUv4e6gM7a438fdPp0hYoZodSqUDrIrpf4WoBF6nmCvS2Td/5BLdNpIPi8o6cSXFxbitDDOlL5hC6okWhJr4NuAdLbk4lGR9uj/OHGOR+ixgZa4ZRq8/Kk7T2fNh0mgqfQxCDSrOdF32VmTajq5TJ+T6S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774137446; c=relaxed/simple;
	bh=lkV68X9LxcNUAchAI3reSRnd3whbyecpsJN6/wyT/Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY21qRKOEBClNA2dKZsJnrSjRf3Ww7eJ2JqTBJTnnkD6eY7Ws4+kv2prRdR9UpmxEXieN9ho0zKsoa7HV0oqR8Q2Y3W1yOip4UUkltbwJpluB4KjbTp0QmT/aQu/+KD9gRxvlrihRNKPLVlZoLk62C9gUxKNdHHHHfb993ztMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+4dhaM2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9f316d68so15200975ad.2
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774137443; x=1774742243; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fien3WBzKEP70100CMVx+hvZzy3ZitaPZv79bCUSu/w=;
        b=B+4dhaM2cxBaVTcbc7bjwkETFyQBeTo2ro6YY8RWpp4eo8JULgr3TShOZbGrG15zA9
         g4WN6RtU3+E52CQiDFk/X3EkMCbs+GzfJko1d4N+x4W0naLCjdoViPh0hUcHdN4xfU/Y
         ACyp8FjIJ9v2kwoP6+XD68z2l3c2cUSOXJZy/2rmCZKwG1eUmvEifHI5nDyyrmFqFsEO
         5JsJA8D/eGIZgt7HmAvZh94JHG8IU+NliAqbT+MscLqmOrAU9Lxm4JLE6DQL5rO8tdlg
         qbbI6hYAZlLD0qOVBz7kBkVR+nTAi+qnO9cjbZj449HGpfPIY7gua7Oa+3Wx69ZCI2T8
         aqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774137443; x=1774742243;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fien3WBzKEP70100CMVx+hvZzy3ZitaPZv79bCUSu/w=;
        b=PpWXgx1qE2xMKNtOtNLssg38ivRW26K7m4wf3ZhhATbPM14coSxi9lnAlX5eJmN24x
         YByWHKDRjBAAgBx+tDxc5CaE6F9ieFPH7zpiuATJWQ7pBvaiTOxknLXORqdcy8NBouIE
         Uh/vRDURRlHhcJtjxaDMqRcBCSEKLhsPXBpBuRj9dVqepq22btKeZuear78P+yWGzPUL
         /Fd+I1aGIdwpqBjL6IsPYMy/76jSLI8z3Nfnxvv0C+2JmkANBHoIEPEvanh1R1FauWRx
         UNGNVVYzsg7zSwHTf9UMsw0Wx8hIVbX8B0K5QgXmcWcFxEi8oSkqYJzdsdIbfpDUScGq
         dXkw==
X-Forwarded-Encrypted: i=1; AJvYcCXDtGJz2vgultPlZtzGuUnhWk7tAMvP/8n+VCoLrtCyFpui7cACM2l8igWJTZLDftUS2sTqskQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAnqYw3xVm0K/tJCx4RhTiHDk36Zpt9u5Tw26kvFGDCTeItmcf
	quHjQC6K2YCUCJxJHKE88FwEu4xyxeykdU0lnnFYMsQnE+IGOV8vRVUChk8zg2NX
X-Gm-Gg: ATEYQzw11ecxoSnIofkCGgwmh7sZvh3HpteCrpfA24OCIkN1Nj6Bil6/S/VSEs9oGY8
	zTx5itV8LvP0zfxpz/m5zHlJonNy8pjM4yOSJDtQnIFyAE5Hq8tdXAyC5zNoFyF11r5+xxV5Qjh
	U7WFpPzKb8pZjpSESF+Cz24mWK8vu2MGQ8aGklwigAezfxg6ydpahn2OGKeNl1or/xkl79NOIa4
	rqxn1Co1FmovHFtZ+cA5oetTObWnCHu/Jhe3cGpVYezTHLNp0NaOXD6Glx6TroBXhd8Cueciy3a
	pbso2nzGwoY/otF6ybYVd83x2OQWc1HbTK/R/8HgLHEEKUH/chDj+ymLM62jt0KqfCV4VJnh4X4
	SbD/Y18+3cCOZhVx38H5vVAbVhuuNNDdBLfCTtfpU7KTJkbx8ULKMkPtAgNxCkDmoDLA4XWaQZO
	FYkVRqVPI3DObcQ3G7+gh0kWKNkB19xR3nbv2hnm6ThtbDYZ6A078OeC07Rpmuq3XkMKJh9JR5j
	7LvIUbVxplJ
X-Received: by 2002:a17:902:f685:b0:2b0:4a1c:b847 with SMTP id d9443c01a7336-2b0827d55dcmr71320455ad.52.1774137443412;
        Sat, 21 Mar 2026 16:57:23 -0700 (PDT)
Received: from naup-virtual-machine (114-36-250-67.dynamic-ip.hinet.net. [114.36.250.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656b67sm80649985ad.38.2026.03.21.16.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 16:57:22 -0700 (PDT)
Date: Sun, 22 Mar 2026 07:57:19 +0800
From: Hao-Yu Yang <naup96721@gmail.com>
To: security@kernel.org
Cc: tglx@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] futex: Use-after-free between futex_key_to_node_opt
 and vma_replace_policy
Message-ID: <ab8wX/vk3An6bFA8@naup-virtual-machine>
References: <20260313124756.52461-1-naup96721@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313124756.52461-1-naup96721@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227799-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[naup96721@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 77C6C2E7AE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 08:47:56PM +0800, Hao-Yu Yang wrote:
> During futex_key_to_node_opt() execution, vma->vm_policy is read under
> speculative mmap lock and RCU. Concurrently, mbind() may call
> vma_replace_policy() which frees the old mempolicy immediately via
> kmem_cache_free().
> 
> This creates a race where __futex_key_to_node() dereferences a freed
> mempolicy pointer, causing a use-after-free read of mpol->mode.
> 
> [  151.412631] BUG: KASAN: slab-use-after-free in __futex_key_to_node (kernel/futex/core.c:349)
> [  151.414046] Read of size 2 at addr ffff888001c49634 by task e/87
> [  151.414476]
> [  151.415431] CPU: 1 UID: 1000 PID: 87 Comm: e Not tainted 7.0.0-rc3-g0257f64bdac7 #1 PREEMPT(lazy)
> [  151.415758] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  151.415969] Call Trace:
> [  151.416059]  <TASK>
> [  151.416161]  dump_stack_lvl (lib/dump_stack.c:123)
> [  151.416299]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
> [  151.416359]  ? __virt_addr_valid (./include/linux/mmzone.h:2046 ./include/linux/mmzone.h:2198 arch/x86/mm/physaddr.c:54)
> [  151.416412]  ? __futex_key_to_node (kernel/futex/core.c:349)
> [  151.416517]  ? kasan_complete_mode_report_info (mm/kasan/report_generic.c:182)
> [  151.416583]  ? __futex_key_to_node (kernel/futex/core.c:349)
> [  151.416631]  kasan_report (mm/kasan/report.c:597)
> [  151.416677]  ? __futex_key_to_node (kernel/futex/core.c:349)
> [  151.416732]  __asan_load2 (mm/kasan/generic.c:271)
> [  151.416777]  __futex_key_to_node (kernel/futex/core.c:349)
> [  151.416822]  get_futex_key (kernel/futex/core.c:374 kernel/futex/core.c:386 kernel/futex/core.c:593)
> [  151.416871]  ? __pfx_get_futex_key (kernel/futex/core.c:550)
> [  151.416927]  futex_wake (kernel/futex/waitwake.c:165)
> [  151.416976]  ? __pfx_futex_wake (kernel/futex/waitwake.c:156)
> [  151.417022]  ? __pfx___x64_sys_futex_wait (kernel/futex/syscalls.c:398)
> [  151.417081]  __x64_sys_futex_wake (kernel/futex/syscalls.c:382 kernel/futex/syscalls.c:366 kernel/futex/syscalls.c:366)
> [  151.417129]  x64_sys_call (arch/x86/entry/syscall_64.c:41)
> [  151.417236]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
> [  151.417342]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [  151.418312]  </TASK>
> 
> Fix by adding rcu to __mpol_put().
> 
> change-log:
>  v2-v1: add rcu to __mpol_put
> 
> Fixes: c042c505210d ("futex: Implement FUTEX2_MPOL")
> Reported-by: Hao-Yu Yang <naup96721@gmail.com>
> Signed-off-by: Hao-Yu Yang <naup96721@gmail.com>
> ---
>  include/linux/mempolicy.h | 1 +
>  mm/mempolicy.c            | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 0fe96f3ab3ef..65c732d440d2 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -55,6 +55,7 @@ struct mempolicy {
>  		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
>  		nodemask_t user_nodemask;	/* nodemask passed by user */
>  	} w;
> +	struct rcu_head rcu;
>  };
>  
>  /*
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0e5175f1c767..6dc61a3d4a32 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -487,7 +487,7 @@ void __mpol_put(struct mempolicy *pol)
>  {
>  	if (!atomic_dec_and_test(&pol->refcnt))
>  		return;
> -	kmem_cache_free(policy_cache, pol);
> +	kfree_rcu(pol, rcu);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(__mpol_put, "kvm");
>  
> -- 
> 2.34.1
> 

Hi, I’d like to kindly ask if there’s an update on when this patch might be merged.

