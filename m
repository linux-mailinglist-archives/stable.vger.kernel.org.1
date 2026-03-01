Return-Path: <stable+bounces-222437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IwZFaILpGnuVgUAu9opvQ
	(envelope-from <stable+bounces-222437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 10:49:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F601CEFE2
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 10:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F1BA30156E9
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877CF23535E;
	Sun,  1 Mar 2026 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlAgm+XC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2252D430B9C
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772358557; cv=none; b=G+Lu2+Kde79yhWls25/Bt0rKP6TSxzrBr7Gimw0dALj4ccDQW8gFfWDG+X288WxjLcbRsp3f8xS6Dupp9qEAXV0LfppwXAWYDsN+J6bEcm+IKpxGrHje4QwWGHESMamw2+7W2q32onSohhV36vOItWFmcGYYGtvutfVYnaD809w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772358557; c=relaxed/simple;
	bh=czlcyJif4hIvmSBqNY1oqumI6EAeK7N+DhNHrN6plqk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=W/QRfn5cq7q/w1AoJyQRX5hQgEt4LWw5X/0P8sa7LX3mOp532iQen0mcIr7ntbQ6HjithL65aq6gK2JtxOuUhhO5xyzYYjPWo8lD67lZcXQgVVh8QEnmXzUxob4oeo0WLJdET9u4ouEzd1LdMNnX0je8U1LYYzQKi57pBY7Tcqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlAgm+XC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2054321a12.0
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 01:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772358555; x=1772963355; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iCLOZRRXSXIjx7C97yXLhOFBL26dMS/YptDYJoFDbmU=;
        b=DlAgm+XCRuE1g6NAAxu+8ZCZYYj/vEm2f3vfdQ2xGxT9FBg9Zm9kmP7Qtj5lZinW0y
         bQ8OIJeZNs5lRb66jd+kHpS6KBpX9CqlPCMsyoimq+VgNILFleXSVlFA6Z4TPdtn9Ddf
         qrHGUjpKn9QF4TnrdFObgyjauhu/zdO+iU8AbKLIiQc6GId/jsJIz7uSOJ3mYdM37ddy
         eynKs2DUTI4wEJDMMce5rF5PKZg4VOYifZ8e7+8GlKC2vxxlWSgjgDvKwhbNZxiOB3nm
         pCDRqNgsv3sWtgO8wyyX6erIub/0CT6DfzT1g+BiW5MH+jJWEnCj7IVoB7x1jCq16I/0
         hFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772358555; x=1772963355;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCLOZRRXSXIjx7C97yXLhOFBL26dMS/YptDYJoFDbmU=;
        b=bLfXUc8R39hfXIUJ/6R0FmjZrtauxbiQOvMH4YXKEoG34sQBHBmK9cNFPBVt0sWurV
         DM0k4yQ1RZEr79zr3lXQJKVGMKTZ2pnVQwhCQqT+PUCk7lqEaaploUh+zUzu4l/4Kdt4
         4apbiMGLpa8snKkYQ3f8c0mZvgtCBTxy71NpuwETkcP7q7PAVwrNITPbruCxYVq20BR4
         2Oha/IewNyFBfOlPNvPs1934DRCuyVO6/39nK0jltjo3cQ4frthhE8KMBOL36YBoV1LK
         fd3tQLNcFf/Yju4xDhOTd6/JibEMeW/d6ySaQn3BMmGTM74fsTkvGKTzeSN0dmq8zXSZ
         omzw==
X-Forwarded-Encrypted: i=1; AJvYcCV5WAwCDFqvo57Hea+vaNO8aJASCKFS67qjs8CZe2jIFGHkFKTkLy17jg77C8rV3IXWl+xWhM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtdCAQCZV0Ly/6vJYjz5x6pG8opW2cEWpYH/0qggE7SXhXBAd+
	RcnqkEkG/dvxvpnbsdCTNgzci0WUmjeG2RIf50uxUvsfMqVdHkn8XmnjS/SoTw==
X-Gm-Gg: ATEYQzwokQHNY9mE19dBM4YCBG7Ui8LKmgqWLehKcPfU4brM9ejlBB1uX0i4e8r3tgy
	/u2I/cvVuL2dpy+gqcTmSaAeM6I5baRtoXOd3LuSm4Z1FdQjWKkAsPgV5+aEL7z/vydbOJlb6LP
	yuKtPYb4liOLD0KSt3BViDg8V5SCTYWNOxBNTQyIGBvQYkopc6Z7Jyq5xu7gbXMfpmKoEkJiQeq
	VDT5JHa9TAJNJhyULFL6tE0QxAdtDuF2h1eNtffOL/YbO423wuus2er/h3jIigW0y7dTVg/EheR
	p1Oi2+TyHPgEWfkWk1qpfNE6Snd5GFYJ+r7e1Yx8usCI9EasgLfVqqxkg1xvO8a7suxRUh+pAAt
	uUcMZvg4yOVBMXfRP/YTmHa6mdzIVgcTfCsxMUc6K7BMvNlIAMX4f96CNxpvToq2oOxF9hW6pY5
	MQBZRwU9hPo6Cd/d9H
X-Received: by 2002:a05:6a20:3d1a:b0:394:6344:e5c4 with SMTP id adf61e73a8af0-395c39ef08fmr8489416637.3.1772358554761;
        Sun, 01 Mar 2026 01:49:14 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6d1ba9sm111528955ad.76.2026.03.01.01.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 01:49:14 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>, christian.koenig@amd.com, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, donettom@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/6] drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
In-Reply-To: <f6b7f3e49ea54fc9c5c3f8dae607382ba9d6f58e.1771656655.git.donettom@linux.ibm.com>
Date: Sun, 01 Mar 2026 15:06:10 +0530
Message-ID: <87seajj3hx.ritesh.list@gmail.com>
References: <cover.1771656655.git.donettom@linux.ibm.com> <f6b7f3e49ea54fc9c5c3f8dae607382ba9d6f58e.1771656655.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222437-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,lists.freedesktop.org,amd.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4F601CEFE2
X-Rspamd-Action: no action

Donet Tom <donettom@linux.ibm.com> writes:

> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
> 4K pages, both values match (8KB), so allocation and reserved space
> are consistent.
>
> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
> while the reserved trap area remains 8KB. This mismatch causes the
> kernel to crash when running rocminfo or rccl unit tests.
>


#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
#define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
#define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
#define AMDGPU_VA_RESERVED_TOP			(AMDGPU_VA_RESERVED_TRAP_SIZE + \
						 AMDGPU_VA_RESERVED_SEQ64_SIZE + \
						 AMDGPU_VA_RESERVED_CSA_SIZE)

#define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
						 - AMDGPU_VA_RESERVED_TRAP_SIZE)

In kfd_init_apertures_v9()...

	/*
	 * Place TBA/TMA on opposite side of VM hole to prevent
	 * stray faults from triggering SVM on these pages.
	 */
	pdd->qpd.cwsr_base = AMDGPU_VA_RESERVED_TRAP_START(pdd->dev->adev);


& In  kfd_process_device_init_cwsr_dgpu()...

	/* cwsr_base is only set for dGPU */
	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);


This shows that it expects KFD_CWSW_TBA_TMA_SIZE (2 * PAGE_SIZE) size of
region, from cwsr_base. However the AMDGPU_VA_RESERVED_TRAP_SIZE only
reserves 8KB. This would work on 4K pagesize systems but on non-4K
pagesize (say 64K), this would fail, since it could overflow into the
SEQ64 region.

Hence the fix in this looks right to me. Although I am not an expert on
the amd gpu driver side, so I would let the experts review this as well.

But FWIW - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
> BUG: Kernel NULL pointer dereference on read at 0x00000002
> Faulting instruction address: 0xc0000000002c8a64
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
> XER: 00000036
> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
> IRQMASK: 1
> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
> c00000013d814540
> GPR04: 0000000000000002 c00000013d814550 0000000000000045
> 0000000000000000
> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
> 0000000084002268
> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
> 0000000000020000
> GPR16: 0000000000000000 0000000000000002 c00000015f653000
> 0000000000000000
> GPR20: c000000138662400 c00000013d814540 0000000000000000
> c00000013d814500
> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
> c0000001e0957878
> GPR28: c00000013d814548 0000000000000000 c00000013d814540
> c0000001e0957888
> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
> Call Trace:
> 0xc0000001e0957890 (unreliable)
> __mutex_lock.constprop.0+0x58/0xd00
> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
> kfd_ioctl+0x514/0x670 [amdgpu]
> sys_ioctl+0x134/0x180
> system_call_exception+0x114/0x300
> system_call_vectored_common+0x15c/0x2ec
>
> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
> ensuring that the reserved trap area matches the allocation size
> across all page sizes.
>
> cc: stable@vger.kernel.org

Cc: makes sense. So that the older kernel versions would get this fix too!

> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 139642eacdd0..a5eae49f9471 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_SEQ64_SIZE		(2ULL << 20)
>  #define AMDGPU_VA_RESERVED_SEQ64_START(adev)	(AMDGPU_VA_RESERVED_CSA_START(adev) \
>  						 - AMDGPU_VA_RESERVED_SEQ64_SIZE)
> -#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE		(2ULL << PAGE_SHIFT)
>  #define AMDGPU_VA_RESERVED_TRAP_START(adev)	(AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>  						 - AMDGPU_VA_RESERVED_TRAP_SIZE)
>  #define AMDGPU_VA_RESERVED_BOTTOM		(1ULL << 16)
> -- 
> 2.52.0

