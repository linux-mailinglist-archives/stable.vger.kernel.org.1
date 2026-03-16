Return-Path: <stable+bounces-225691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNNkGD9guGlbdAEAu9opvQ
	(envelope-from <stable+bounces-225691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:55:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F347D29FF01
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E5B304926F
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5A3DB64B;
	Mon, 16 Mar 2026 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/kjkEYN"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458B3ED5B5
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773690821; cv=pass; b=f9imaWuBqSq61yFhCeMKXhKyA/nswSITGCvgiUS6mf8huZqv3nL4YSwMIxlGwekWvYaEnHtaauMpR82Oq8f+lJsWr6YPuO+73XplEG4vrhm/FlOlpt8fwV3lxyyZ6ahigmSMcv9n9KkdvvaZLbUoHcL/PwN4E0rCnRpAtkblpyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773690821; c=relaxed/simple;
	bh=VY7/ARQ274h4uKfie1OktnCkIxcE/wgH7GGSyqdtydE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tsn/fE0TW4NOaL798JXXLs9s3kcExa/hg11vIVd8R9rdr4Jw720thFPPnsRemR7ykuiGBUNO53KnRVywGhf+YlbkbnDZMiE0jGHFb4IkxPM3dqaLp71Z/gwd4UJai2qv+UDrk0z9sgDg8lTD1eEFNajM8HTK5Or+NfK6T7OJgAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/kjkEYN; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7927261a3acso40182917b3.0
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 12:53:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773690818; cv=none;
        d=google.com; s=arc-20240605;
        b=XGOsPaaYPoZ+2jw72cccw5Y40f295VRXzE4ymv1qvAVFwA12mC+uM5tcRbLQd+d5Op
         gCBlcGUnJamhyTZoCaKSFuoRVt8U7eIy0xsB2vhZbG/fI7fiWpMNkur5oUT9uBEWoy1e
         gfuOCSLp5TyXJDID3xvGVLnorBkxQXzeMEzNgJg1Ze2LDqqzDYK6qHBOLGT0GrnOJEj1
         4knSfACwWCrvmEwJK1aHUHIRbu3nId5rGHpGXOdajl52nkPvADe3snhhH0soZyBpJcDz
         5Bhb9U6M1VKVhyBtKk3tNQPGqF5gxfKkZGogcyBypGoxQvDlEaQxxIQgRKzWu2CcfklL
         yZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        fh=2GtsKwzmwEnZahBmj9mP5j4uLnjU6Zb/RZqReMWfmhQ=;
        b=JHgdiCdP+TCKRS7M4pvPlmUai/TyXP1OaenMS2VtG3XhK6v87B7mH3kPCgmw00JR6w
         rFO894E9ZM8GU/wSZvTZpz6xnNBEGW6rB03Kcfrw0pBcBBB8eJann9Gw7DSjY9juH1XL
         +E+/l7RdEOJ/LUp25z8D3itrlc0RbVWk5I1MhQoHWFHa2H5TTn5OW81bh3ePesjfF5up
         1ar5fVFjuXjpnklq76zotqkxC/508+T2oCTArNCUkelHWl6f0rWdNhfvVAFE1w34AsGq
         ID3xjzmAIQYOVdNme9qtRf3IVnCmksi8dgvKtGFjBq8sIFidWFQaJMdtPmcTh0cGteBC
         308w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773690818; x=1774295618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        b=c/kjkEYN3oBorrXhP4wUvrrlFlAEgUgv6mZICv0wTLd3Dg6GwDE1PStnQQ70b8nlmX
         +lRI7ZL7OyGshmCQ3mNL4Bjypn6+2hV2m0tJVMgIG7EJAyoxI0sM4zSuKRLaItSg0RPp
         34OVwOFOPl45i6ASkzCqC3I1C/g6oIwfiIIOJqMDuxdZt8g1OqADU/DOTrHV5vniTg8j
         NV/T/sfOWT9wapsnCCquzHghKsuNARxerYCY7FExT3F2FUTYjVCCkxSdQcd8oMpED5pL
         GInqJGmcQrELNrFEJQshbpbxERVxHcRDq8mZjMvrxu7ZeqH+JYSSmW2g8yi6rrr0zLYi
         ccAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773690818; x=1774295618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cfr/+KdWaNG7d26GP7p0CvuBKTKufLHHRbtv8HCrcI8=;
        b=iUEP1uxsUq3WpE7ReNsBB2uqZqK1QFTygsZ9j6y1pz/m5Cjn6/thKS0u4AXLjzZC9u
         hV4ENK1fgqzNnV1QeKa/hJl35hZGO8wlwqLpdZ+G/tiKoCv7eao1fmXq5juIfMtUbk4P
         lPAF9Gi6LGtXpOxNdvrJIiv9ifhnmSNcZm6e3Cv8TE52hAKQRUfFhsi5eYzXXTVwDGMj
         96+xxDUszistT9lqcj9A+WRy0l2qwO7Txm9PerLXDP76fw5+ktayZP4OKfIazhiISTkx
         dNp2LooBoM2oPJqwQVi1SssTjL5q4iQV63V2fSKF6L10Cib3TJplfEuQJfOGto+zJLj2
         XkpA==
X-Forwarded-Encrypted: i=1; AJvYcCVqI3H/L0OJ9LJ8R7lr+v2objDpFlSozFDLegUl+Y1Ffdp9kkt22i+lzcaMaJjCv7C24Jgb4YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmdqc6AQxoTzWTWbXEHp7ACvEmdSrzbzLAFLBA92lVsDCeyifS
	qak3P0ab9tfr6KMLganiWERZTCtxQALvNNEWOZr8+O5hBO3qBdmH52PFYr0xwU7YtnusUefaUjP
	SLMImTzY+hcDk/c3yg9tBjgPKEx3TdDc=
X-Gm-Gg: ATEYQzwYTd56Rghry13fme8k44kQDZ+I3hTYLl0aV9Xl7aykOs93uLx2iFxAVE99YLr
	KQFRoysocIvO2PeNsuZKRBCd040aTeqRahx4foeknI3dGhCm1LeB01W+S1XuOgMxOYDh3FaiqNh
	bv1cHKGTGY2OO+Zcz0Ip7ksI9gNgFMgpISRH8kScm2HCboCPenxU/DztJ7RkLLb0eGb1ZjhuuvU
	4yQOjolGyI7RjY6cps4ttBzZi/eKCxbBPaMiDcbZ+kC5VKVIKJqUrK3sdUUFAD9nv5KipcrOsUd
	PQhzwdCya6oyqbx92ifbyac=
X-Received: by 2002:a05:690c:6c0b:b0:79a:4317:395a with SMTP id
 00721157ae682-79a43175384mr64466277b3.2.1773690817924; Mon, 16 Mar 2026
 12:53:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
In-Reply-To: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 16 Mar 2026 12:53:27 -0700
X-Gm-Features: AaiRm51TRiU_TdEe_xqQj-pB0MImfrzcDdg1WNNiYNlT_5xOuouk70K7fxXMtb4
Message-ID: <CAMB2axN9xYPzAJVQVywx3sxYa5ViRxt2oktt1LFXsSD_XsuJrA@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when !HAVE_CMPXCHG_DOUBLE
To: rsworktech@outlook.com
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, stable@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-225691-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,goodmis.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,outlook.com:email]
X-Rspamd-Queue-Id: F347D29FF01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 9:02=E2=80=AFAM Levi Zim via B4 Relay
<devnull+rsworktech.outlook.com@kernel.org> wrote:
>
> From: Levi Zim <rsworktech@outlook.com>
>
> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> For example, this causes bpf_task_storage_get with flag
> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
>
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> for correctness. Add a comment about this limitation that architecture's
> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> bpf_local_storage_alloc always fail.

Let's not do this.

This re-introduces deadlock to local storage. In addition, local
storage will switch to using kmalloc_nolock() entirely.

For riscv hardware without zacas extension, I think a workaround with
some performance overhead is to enable CONFIG_SLUB_DEBUG and
slub_debug options.

>
> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolo=
ck() in local storage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> ---
> I find that bpf_task_storage_get with flag BPF_LOCAL_STORAGE_GET_F_CREATE
> always fails for me on 6.19 kernel on riscv64 and bisected it.
>
> In f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock()
> in local storage"), bpf memory allocator is replaced with kmalloc_nolock.
> This approach is problematic for architectures that lack CMPXCHG_DOUBLE
> because kmalloc_nolock always fails in this case:
>
> In function kmalloc_nolock (kmalloc_nolock_noprof):
>
>         if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>                 /*
>                  * kmalloc_nolock() is not supported on architectures tha=
t
>                  * don't implement cmpxchg16b, but debug caches don't use
>                  * per-cpu slab and per-cpu partial slabs. They rely on
>                  * kmem_cache_node->list_lock, so kmalloc_nolock() can
>                  * attempt to allocate from debug caches by
>                  * spin_trylock_irqsave(&n->list_lock, ...)
>                  */
>                 return NULL;
>
> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> (But not for a PREEMPT_RT case as explained in the comment and commitmsg)
>
> Note for stable: this only needs to be picked into v6.19 if the patch
> makes it into 7.0.
> ---
> Changes in v3:
> - Use macro instead of const static variable to avoid triggering
>   warnings.
> - Wrap lines at 80 columns
> - Link to v2: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v2-1-=
576e33e4fa67@outlook.com
>
> Changes in v2:
> - Drop the modification to the PREEMPT_RT case as it requires
>   kmalloc_nolock for correctness.
> - Add a comment to the PREEMPT_RT case about the limitation when
>   not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
> - Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1-1-=
24abf3f75a9f@outlook.com
> ---
>  include/linux/bpf_local_storage.h | 1 +
>  kernel/bpf/bpf_cgrp_storage.c     | 3 ++-
>  kernel/bpf/bpf_local_storage.c    | 4 ++++
>  kernel/bpf/bpf_task_storage.c     | 3 ++-
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_=
storage.h
> index 8157e8da61d40..d8f2c5d63a80e 100644
> --- a/include/linux/bpf_local_storage.h
> +++ b/include/linux/bpf_local_storage.h
> @@ -18,6 +18,7 @@
>  #include <asm/rqspinlock.h>
>
>  #define BPF_LOCAL_STORAGE_CACHE_SIZE   16
> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBLE)
>
>  struct bpf_local_storage_map_bucket {
>         struct hlist_head list;
> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.=
c
> index c2a2ead1f466d..cd18193c44058 100644
> --- a/kernel/bpf/bpf_cgrp_storage.c
> +++ b/kernel/bpf/bpf_cgrp_storage.c
> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *map, =
void *key, void *next_key)
>
>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
>  {
> -       return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> +       return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> +                                          KMALLOC_NOLOCK_SUPPORTED);
>  }
>
>  static void cgroup_storage_map_free(struct bpf_map *map)
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storag=
e.c
> index 9c96a4477f81a..a6c240da87668 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
>         /* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
>          * preemptible context. Thus, enforce all storages to use
>          * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> +        *
> +        * However, kmalloc_nolock would fail on architectures that do no=
t
> +        * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> +        * bpf_local_storage_alloc would always fail.
>          */
>         smap->use_kmalloc_nolock =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? true=
 : use_kmalloc_nolock;
>
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.=
c
> index 605506792b5b4..6e8597edea314 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *map, =
void *key, void *next_key)
>
>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
>  {
> -       return bpf_local_storage_map_alloc(attr, &task_cache, true);
> +       return bpf_local_storage_map_alloc(attr, &task_cache,
> +                                          KMALLOC_NOLOCK_SUPPORTED);
>  }
>
>  static void task_storage_map_free(struct bpf_map *map)
>
> ---
> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
>
> Best regards,
> --
> Levi Zim <rsworktech@outlook.com>
>
>

