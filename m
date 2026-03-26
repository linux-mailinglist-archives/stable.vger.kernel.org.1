Return-Path: <stable+bounces-230467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K7pIoE6xWn/8AQAu9opvQ
	(envelope-from <stable+bounces-230467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:54:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB3F336560
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A8B730B9FF6
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E652DCC05;
	Thu, 26 Mar 2026 13:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaybKd6Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB812DF144
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774532835; cv=pass; b=jKGv5RcdvKB0Yo93txEPg6+G3MWehgiWKraHGLzJKNwYFCGc9q8uPBK8PAr+zixzGHLbwJR/tDcYDnNb8y93lXNS8u/QyYFrBDi7TrtIxmQZLy7lxMmAYmEoT5LNXxMNex92Mb5WeGw1ZDVc9IsFZvcQLoF1m9vItfAI7dnKPDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774532835; c=relaxed/simple;
	bh=rMelPe/euyNW3kD8QExA5nnOVYwZ5TIStJBpq44tDWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iC+gu+J5w4LfYohJeGwg42oFSru0cwJ7QobGXUNHaSrYQ6OohsgypSM9GscAOPPCSqwA1R9qiomUhK2o8RQzhupc3s54390/osp50rqPn+1EgM4YF7DPy5yXQiw0+eHLFJmox3ANbw9PlDFxQwQS7AxymhwvOHXM1Exov3WEn0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaybKd6Q; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-124a7216c9cso68172c88.0
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 06:47:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774532833; cv=none;
        d=google.com; s=arc-20240605;
        b=b37QTmOSBzIPCtSJVkWm68zw8vhOUt1Noyolt37Ohkg0sQzwxmYQdtd4XaLPyoxexM
         nE9a71awviFbkWf/2Zlv7+etOy4iEh5aI3zr13ZxYKqjRjwHRgQ1wNcjBxNh1JoYxtju
         1yVCPe8WgcQP9bKTnYsCtVWPNWeS0psOCZHvrE2ynGsXbmwA5LUGfwIbuflFHUH89hVy
         VOQ+3vUpSCXLVw/bBI6IO3Xpr7NZb3eemHFChpQpK3mdAaAsbv716W585UMomftNxa2F
         oKViQEueaWWNT5Fh8PcqDofpyHNpMvXrUqeivkb46ZDFCpSspzjSDPHap8ZDs9juq/XB
         Fdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jhgQIzT7uTXExNjxkHf9nhGfLv1V1ZXJvOpLwvnIT3s=;
        fh=jhzyIhnHD1UkbEah9vnUmdDEFK4B/Hqb8B+Cn+ZgJwk=;
        b=PcMsOp6r32rc6dR+lGuLIFiR4vzy7AAe2lpK2UR326oVW20vlUnDDg6TF5I7WtAaM5
         nid4PrArO8dBtMyML5cB7fEZ29USjcLmLB1FhPbJ1k/od4Sjrz0vzwF+2DEEGZTyAABU
         yvftc8xmHzpIXW4SFeFvOr/E0xPTZ4CsUOWVRtVEMPwLN/dQQhnRR1olj3Z3Rddssb4P
         RpvFV9tqhruKegaryk+A/FhhosJfaqTTQvfxEk6QgNr5i95lvcjyawrlDrb+k1O+KWgQ
         ea7XNmoxAVS8lNhZ8BS3Pumt2ZhaEtkgTB8k16KL93kx+j1fBVdZI5bOpXJv/9zrxMJ2
         yY7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774532833; x=1775137633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhgQIzT7uTXExNjxkHf9nhGfLv1V1ZXJvOpLwvnIT3s=;
        b=BaybKd6Q0v4h4oXZQD5bW+DwRAwE3Aa4O0WxhrcUcnXR5ih4JJkfY0FFUk88l3qEM1
         QGvxipL4FU65myjQeNKX/NukQXnqZiVaoZ0mgAI2ruOz98fp5hzVcnsi9dxP7HMi3L+p
         tzo0P7mdaGBEmHoiLblukFBvAe59mhbvDYD3q2mLohuwi+XmZY/i85Nuqu3pcGVLVRWE
         /L2LPEdpUc1whqak5wpb2FPef7bFpy2TaROi4R6nl5ZlZveDTLNd9le5Ur8bRPoF1kup
         9ZppyqXkC3fNwSV/IdWJmRiE4kpouy/CHBQ06tDahZ/elg6yplIMAYUMkOfn+PEhXNVI
         YOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774532833; x=1775137633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jhgQIzT7uTXExNjxkHf9nhGfLv1V1ZXJvOpLwvnIT3s=;
        b=HV7B317dbCJ4d+U3XxwhQYZyui1B+yGsA1kkBCO/H6L2reDUzkRlySpot7zl97uKkQ
         1ZpyDuBWpnKdUyCoO/dvnmy+5viy84DNJ1BxF4VmjOq5DiwY8f+l7UT4f3NZymoAZNLQ
         Bv8ENmFAFEIIXf0BhChZjzAOIOviC0V7rWTzP5SPfaAKNw09K8HaGXh4TfK0ULc6up+w
         LOBqtFskfUtCqHoEI4oE73bICA30myzP1umVSWzPInkCfXgLa6BtgXeZuqw2B3xQPb2U
         yoawb9lag9800eC7y/6Fkd5D0Ugj/mUC42msKwOaxjav5H8TmTRQzdGN4lGOvt2mi1NE
         7JPw==
X-Forwarded-Encrypted: i=1; AJvYcCVlSEHdSNJkhkkuoKAHkja9ZYUeRwTE34iRGzDL43tpkicIiYjg5zFdhIaqpj1sl6xKKvDuLrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNyNYCCEe4rwj/aDCwoWzhd9JioI6JT0nQTjerLmY4vygErZOa
	/vmXYgbki9UYDx3g0/3+SUkXdIt7874Z+Lha6EZPUMYsVh8rduPzIdQghs/tPIwACBE0FLwKxLs
	MIMuX4WcZ1SqL6HuVHxFY5tyc99czhOs=
X-Gm-Gg: ATEYQzxm+KrNOOkFLvzUAVDhLAAHnI3H8Q+6hIrYwsBWev0EPEcsL/dGzSt1100dh34
	9FBCnzMSds0Hf3QJueMxXoI1FizkZarxd83WuGYoO5TMnKrK/8KkBfL8WToI+efke89ywp29qc5
	81P3aR/aUoPo1cscW/yOKp+YXR39s2dY3h+TNu8k7uxbw4LB5oJddRs/P41wR2Mr77w7z+NrY1u
	dyrwZhdSDRNmNIX3ekk+OnygUec6GtwpF8cc7BX9vkSSPCZ7RsvbLzpnERR6KmhJO7Mo5VOZuJ2
	GoMibTzNsi59ic+opLlK1Xu63Ok957MY/ejaRP4d9Yb4LJ5bcImam1m/pZMIaHBrWTCPow==
X-Received: by 2002:a05:7022:ea2a:b0:127:3480:7ca5 with SMTP id
 a92af1059eb24-12a96e489ebmr2065500c88.2.1774532832955; Thu, 26 Mar 2026
 06:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1774521183.git.donettom@linux.ibm.com> <2e3d4c1dafc6d2780ca502c9d78e8ac250122d96.1774521183.git.donettom@linux.ibm.com>
 <9c9c73e1-abe4-4307-9d44-37544fbd1596@amd.com>
In-Reply-To: <9c9c73e1-abe4-4307-9d44-37544fbd1596@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 09:47:01 -0400
X-Gm-Features: AQROBzAi2u3zFQCvcBtSmJhCwRwwjEJK-8GjhvwYzcT4D-8lUu-0oxPp55FelBo
Message-ID: <CADnq5_NWkGCb_WtaOk6Q4T4eG4EZc8ZNoLtxQkXowhYh3NaCVQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Change AMDGPU_VA_RESERVED_TRAP_SIZE to 64KB
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Philip Yang <yangp@amd.com>, David.YatSin@amd.com, Kent.Russell@amd.com, 
	Ritesh Harjani <ritesh.list@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.freedesktop.org,amd.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexdeucher@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: CBB3F336560
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applied.  Thanks!

Alex

On Thu, Mar 26, 2026 at 8:36=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 3/26/26 13:21, Donet Tom wrote:
> > Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
> > KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
> > 4K pages, both values match (8KB), so allocation and reserved space
> > are consistent.
> >
> > However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
> > while the reserved trap area remains 8KB. This mismatch causes the
> > kernel to crash when running rocminfo or rccl unit tests.
> >
> > Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
> > BUG: Kernel NULL pointer dereference on read at 0x00000002
> > Faulting instruction address: 0xc0000000002c8a64
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D2048 NUMA pSeries
> > CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
> > 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
> > Tainted: [E]=3DUNSIGNED_MODULE
> > Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
> > of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
> > NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
> > REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
> > MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
> > XER: 00000036
> > CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
> > IRQMASK: 1
> > GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
> > c00000013d814540
> > GPR04: 0000000000000002 c00000013d814550 0000000000000045
> > 0000000000000000
> > GPR08: c00000013444d000 c00000013d814538 c00000013d814538
> > 0000000084002268
> > GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
> > 0000000000020000
> > GPR16: 0000000000000000 0000000000000002 c00000015f653000
> > 0000000000000000
> > GPR20: c000000138662400 c00000013d814540 0000000000000000
> > c00000013d814500
> > GPR24: 0000000000000000 0000000000000002 c0000001e0957888
> > c0000001e0957878
> > GPR28: c00000013d814548 0000000000000000 c00000013d814540
> > c0000001e0957888
> > NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
> > LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
> > Call Trace:
> > 0xc0000001e0957890 (unreliable)
> > __mutex_lock.constprop.0+0x58/0xd00
> > amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
> > kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
> > kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
> > kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
> > kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
> > kfd_ioctl+0x514/0x670 [amdgpu]
> > sys_ioctl+0x134/0x180
> > system_call_exception+0x114/0x300
> > system_call_vectored_common+0x15c/0x2ec
> >
> > This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 64 KB and
> > KFD_CWSR_TBA_TMA_SIZE to the AMD GPU page size. This means we reserve
> > 64 KB for the trap in the address space, but only allocate 8 KB within
> > it. With this approach, the allocation size never exceeds the reserved
> > area.
> >
> > cc: stable@vger.kernel.org
> > Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of =
VM hole")
> > Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h  | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> > index bb276c0ad06d..d5b7061556ba 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
> >  #define AMDGPU_VA_RESERVED_SEQ64_SIZE                (2ULL << 20)
> >  #define AMDGPU_VA_RESERVED_SEQ64_START(adev) (AMDGPU_VA_RESERVED_CSA_S=
TART(adev) \
> >                                                - AMDGPU_VA_RESERVED_SEQ=
64_SIZE)
> > -#define AMDGPU_VA_RESERVED_TRAP_SIZE         (2ULL << 12)
> > +#define AMDGPU_VA_RESERVED_TRAP_SIZE         (1ULL << 16)
> >  #define AMDGPU_VA_RESERVED_TRAP_START(adev)  (AMDGPU_VA_RESERVED_SEQ64=
_START(adev) \
> >                                                - AMDGPU_VA_RESERVED_TRA=
P_SIZE)
> >  #define AMDGPU_VA_RESERVED_BOTTOM            (1ULL << 16)
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/am=
d/amdkfd/kfd_priv.h
> > index e5b56412931b..035687a17d89 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -102,8 +102,8 @@
> >   * The first chunk is the TBA used for the CWSR ISA code. The second
> >   * chunk is used as TMA for user-mode trap handler setup in daisy-chai=
n mode.
> >   */
> > -#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
> > -#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
> > +#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
> > +#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)
> >
> >  #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE             \
> >       (KFD_MAX_NUM_OF_PROCESSES *                     \
>

