Return-Path: <stable+bounces-226683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KMaEwuRuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:36:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 558982AFD6B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1481330A44D3
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3D02DF701;
	Tue, 17 Mar 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDZdws6o"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF0E1A9B58
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767804; cv=pass; b=nQejEEXaXiHp3z8jmH5PXQkirYiH5aLLl6vJuAJH3l00zZByYFIB2mrrECrsNFxMpFee1kHw5LVqyLvyRV2YJeolvUtzCU3G5KUICHd8GfR4pQ10VV1ro15xPSsLxBaW66BGZNGINMYOBgN6S80reiNRwKV4lLwmeYKhcYTP+S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767804; c=relaxed/simple;
	bh=sNoN/Xh8CUgNjwW3bTkJAIWBkTvsjLmibZC6m+YJO2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ughyWEVAvA063tH00f4hYIYEnDQ+ZVZeaGO2YxQuKPgoJoBAyXosHBYDAtRbJIWTRbe5N77Bx6QtUJV9971NkIY2BbcLsikFFhcNM+X8pt/qKYa4bTJTkpPQ0Rm7FnWcl2sC+9hxi8YhiipavOf9BUP/sJPMELYuW6ziM4nhkxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDZdws6o; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ad46a44easo5814797d50.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773767802; cv=none;
        d=google.com; s=arc-20240605;
        b=NYp32XocZhpoFzUe6mXFTjJPVB1jJyKM64Wbd75gm/m8bM6ILfhWK8ULrIJoSo3RfD
         vnwNdSUu9U/JZWaH6SkVoNH8l5yEbw3PYJmC3Q0jatUHxsei45wFgqxa2ZA6zMuUGf2o
         W4l4UeSoFNQFdii/hj8u29LpFsYT+mN11LrhRCKhh+Y4ylryXmyO+8nS6uHCxXN14LuR
         6reWG46FbuTs8EZv89/Z4nXJKYp1V/4H++/X5dI2uekcrdqHY2HFanQtIpm7R6jdEMNg
         WlRTnqASt8CM6bPZ4/IVfvBu/YvpZR161QqwbP8sUJJ5mqcHSD+GCNrKDw6sy9/gkR6F
         UFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        fh=26qpZgdmBTqf9rVy6boG4MyjUn5xmx5xISTRHpeUM6g=;
        b=dly1CPzkg9G6QUgBCSFQIvbQdfedtQVnWw5bX9Y8+yLmlu255JBEmpOq6VwowvPxed
         UrFMKmynScK+Qo5oZ/CcEKQPxaXBo4vts7xxoDcqst8xSaBY9zodpuZ00v5Cxp7Q5yl+
         uIjyMCKO0Em7tZcWFQKULos/KPGaetcEOSnRa22bK5xWJl2vfwhahlmOUpjidFW3GXXG
         ayQuo8Cxgwv83N1EiUZyzKptcRcSKwCKXHvDQqrega010Ps1ugLPfGK9M5lk++xH4gD+
         rKS2SvLOMKclfHs38rTtfbMRzE/jFBuXn1qLjJEtlEjTdDMlzZmLyzz8M2GO3CReXwA7
         UcTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767802; x=1774372602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        b=WDZdws6oWYibPv8VCzNsED4TQ3bvSZKG1FPSWVALzrEK94AumASStnR3Y/5H6Ep+oe
         TMLNDjLxtYz8W2Wl/9Ek+o3kjMKzUw0WbbnfWZZ+HMSvG7GJbnyrtFrx7238XdJ02Vxq
         9JXeKCQoKHJ1AFlpqSCXIUIhdL365yGnFI5qkPhXPscH1+Nh9SrhCkkunYNmnz67ICxG
         mdQ+sYL/bXC36O1wyH9tB2/2gD1fqhJDqidmMXB9WNUM4PsjyNOFEB/GMY17HyP4Pmzc
         UVImJWPJHEbsngz5n/YcloejxX/AOsEu3sSg4YhRGEPShejurxuI/zO0+4VrmS/8BvmS
         vtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767802; x=1774372602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q2zAeBs9zo2lv0T0WIuTbdsujf/BJxEymoy13o+3BzM=;
        b=TFnMMD9dvw7indoZdFJwxnxN8rEmFX5c2e36EP3+qFw4fSGVnE4SBxC1idlMmXBFrI
         9bRdKlcPWUhO/5wv+vRAVL7OIrxzLnmkGifGgcwbBELV+PQtyXTtYSbRg/tCRwrzuXeK
         naOcU7rDkBrMFr4o1Q8udUfT5AIh7Fy8aNNooqQOUdlDkpj3idOaMEhX8ztGIwrAYeeL
         Xt+TlhK/tBIIbklOaA5dcnpJwcx81/nrhPFDQq9wax50+wGq8XsykWtLDTvZSeyCFJsE
         mBLdzHLXnvGlw835eMuRy5Zo4oXozB1iXANW5muOCaldrsbHIH37F7v9/ElMtxmDqOjM
         HOSg==
X-Forwarded-Encrypted: i=1; AJvYcCU/LwGhKMK7DuVCb6LPfkehnnAsX4gFq8ha4nZbKZA9yk7m9Y+XygGAFlvdwc/su1YVlg+xzHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl34a8hUfY4+qsC7ssbVSR3sG0ZFQicKaZpBXuNqBh3/3jFhFb
	8Mmgs6d70h2teDcXuxPf8H1AmCtvh3N4lhuQ1bH572QvGkvrqpXCQl3WtKjEViMg1+UT7dl1WoF
	MKgP9eUCyV8Q+30gEW7ixw9V3sUjS1tA=
X-Gm-Gg: ATEYQzy4AfkLf7FZujmFZvvcHE+QMP2UEnCIyXW7X5k0msSmvzeXtmKYKk7b4hC85Md
	SKkiyyfSHgQEmcfk6Siq66bhqt65qE6hxRpMS/m7LC4YiwdcvsX/4tfufFBJn1cp/FATTD4Xngt
	mmjxG1RSNN51/dVbn6p4ox0Qd04eX3/MSqlv+JBQV3SLUw9RpRFw55/SnxxrLFaS0PD4SMM7VEr
	gzm4/oa0kA6iCQ9micZbFQCNF7G880wt1zcDKA6oKDj4TWlCZawGuYidVd1yw10rqJs2rTirE0s
	Yq2AVv0vA/mFaJI2hhVl
X-Received: by 2002:a53:be4b:0:b0:649:b31e:8f4e with SMTP id
 956f58d0204a3-64e91619389mr343424d50.70.1773767801490; Tue, 17 Mar 2026
 10:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315-bpf-kmalloc-nolock-v3-1-91c72bf91902@outlook.com>
 <CAMB2axN9xYPzAJVQVywx3sxYa5ViRxt2oktt1LFXsSD_XsuJrA@mail.gmail.com> <SY0P300MB07691E08E5283FE074C81BE2C641A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB07691E08E5283FE074C81BE2C641A@SY0P300MB0769.AUSP300.PROD.OUTLOOK.COM>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 17 Mar 2026 10:16:29 -0700
X-Gm-Features: AaiRm51gOU8njsC2VoBSF2OL4VzOChb4st-LR63ZRP8xg4-IJKtd30ho-twlx18
Message-ID: <CAMB2axOw_qZQ2ksTPSVb7LqAGv1sxjA9u+EyfE8ygd4Rxa9BGw@mail.gmail.com>
Subject: Re: [PATCH bpf v3] bpf: do not use kmalloc_nolock when !HAVE_CMPXCHG_DOUBLE
To: Levi Zim <rsworktech@outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-226683-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,patchew.org:url]
X-Rspamd-Queue-Id: 558982AFD6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 5:40=E2=80=AFPM Levi Zim <rsworktech@outlook.com> w=
rote:
>
>
>
> On 3/17/26 3:53 AM, Amery Hung wrote:
> > On Sat, Mar 14, 2026 at 9:02=E2=80=AFAM Levi Zim via B4 Relay
> > <devnull+rsworktech.outlook.com@kernel.org> wrote:
> >>
> >> From: Levi Zim <rsworktech@outlook.com>
> >>
> >> kmalloc_nolock always fails for architectures that lack cmpxchg16b.
> >> For example, this causes bpf_task_storage_get with flag
> >> BPF_LOCAL_STORAGE_GET_F_CREATE to fails on riscv64 6.19 kernel.
> >>
> >> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> >> But leave the PREEMPT_RT case as is because it requires kmalloc_nolock
> >> for correctness. Add a comment about this limitation that architecture=
's
> >> lack of CMPXCHG_DOUBLE combined with PREEMPT_RT could make
> >> bpf_local_storage_alloc always fail.
> >
> > Let's not do this.
> >
> > This re-introduces deadlock to local storage. In addition, local
> > storage will switch to using kmalloc_nolock() entirely.
>
> I noticed the PREEMPT_RT case needs kmalloc_nolock for correctness and di=
dn't
> disable kmalloc_nolock in that code path when !HAVE_CMPXCHG_DOUBLE.
>

It is also not correct to use kmalloc() on !PREEMPT_RT. A BPF program
in NMI or tracing kmalloc internal that tries to allocate memory for
local storage can deadlock.

> But in the original series [1], It appears that switching to kmalloc_nolo=
ck
> is purely for performance benefits and not for fixing deadlocks in local =
storage.
> And I didn't see any "Fixes" tag in [1].
>

There is no deadlock issue with BPF memory allocator and
kmalloc_nolock(). For context, the patch you are referencing is part
of a series of refactoring to
- Move from BPF memory allocator to kmalloc_nolock() [1]
- Remove percpu busy lock [2]

Please refer to the cover letter for the motivation and changes made

[1] https://lore.kernel.org/bpf/20251112175939.2365295-1-ameryhung@gmail.co=
m/
[2] https://lore.kernel.org/bpf/20260205222916.1788211-1-ameryhung@gmail.co=
m/


> Could you provide a more detailed explanation? Thanks!
>
> [1]: https://lore.kernel.org/all/20251114201329.3275875-1-ameryhung@gmail=
.com/
>
> > For riscv hardware without zacas extension, I think a workaround with
> > some performance overhead is to enable CONFIG_SLUB_DEBUG and
> > slub_debug options.
>
> There is a patch [2] that enables HAVE_CMPXCHG_DOUBLE for riscv so I thin=
k
> it will not be a problem for riscv in the future, even for hardware witho=
ut zacas
> extension because the kernel has fallback implementation for zacas.
>
> However, this would still be an issue for other architectures. Currently =
only
> x86, arm64, s390 and loongarch have HAVE_CMPXCHG_DOUBLE in 7.0-rc4.
> I don't think letting users enable slub_debug would be a reasonable worka=
round.
>
> [2]: https://patchew.org/linux/20260220074449.8526-1-mssola@mssola.com/
>
> Best regards,
> Levi
>
> >>
> >> Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_n=
olock() in local storage")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Levi Zim <rsworktech@outlook.com>
> >> ---
> >> I find that bpf_task_storage_get with flag BPF_LOCAL_STORAGE_GET_F_CRE=
ATE
> >> always fails for me on 6.19 kernel on riscv64 and bisected it.
> >>
> >> In f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_noloc=
k()
> >> in local storage"), bpf memory allocator is replaced with kmalloc_nolo=
ck.
> >> This approach is problematic for architectures that lack CMPXCHG_DOUBL=
E
> >> because kmalloc_nolock always fails in this case:
> >>
> >> In function kmalloc_nolock (kmalloc_nolock_noprof):
> >>
> >>         if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> >>                 /*
> >>                  * kmalloc_nolock() is not supported on architectures =
that
> >>                  * don't implement cmpxchg16b, but debug caches don't =
use
> >>                  * per-cpu slab and per-cpu partial slabs. They rely o=
n
> >>                  * kmem_cache_node->list_lock, so kmalloc_nolock() can
> >>                  * attempt to allocate from debug caches by
> >>                  * spin_trylock_irqsave(&n->list_lock, ...)
> >>                  */
> >>                 return NULL;
> >>
> >> Fix it by enabling use_kmalloc_nolock only when HAVE_CMPXCHG_DOUBLE.
> >> (But not for a PREEMPT_RT case as explained in the comment and commitm=
sg)
> >>
> >> Note for stable: this only needs to be picked into v6.19 if the patch
> >> makes it into 7.0.
> >> ---
> >> Changes in v3:
> >> - Use macro instead of const static variable to avoid triggering
> >>   warnings.
> >> - Wrap lines at 80 columns
> >> - Link to v2: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v2=
-1-576e33e4fa67@outlook.com
> >>
> >> Changes in v2:
> >> - Drop the modification to the PREEMPT_RT case as it requires
> >>   kmalloc_nolock for correctness.
> >> - Add a comment to the PREEMPT_RT case about the limitation when
> >>   not HAVE_CMPXCHG_DOUBLE but enables PREEMPT_RT.
> >> - Link to v1: https://lore.kernel.org/r/20260314-bpf-kmalloc-nolock-v1=
-1-24abf3f75a9f@outlook.com
> >> ---
> >>  include/linux/bpf_local_storage.h | 1 +
> >>  kernel/bpf/bpf_cgrp_storage.c     | 3 ++-
> >>  kernel/bpf/bpf_local_storage.c    | 4 ++++
> >>  kernel/bpf/bpf_task_storage.c     | 3 ++-
> >>  4 files changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_loc=
al_storage.h
> >> index 8157e8da61d40..d8f2c5d63a80e 100644
> >> --- a/include/linux/bpf_local_storage.h
> >> +++ b/include/linux/bpf_local_storage.h
> >> @@ -18,6 +18,7 @@
> >>  #include <asm/rqspinlock.h>
> >>
> >>  #define BPF_LOCAL_STORAGE_CACHE_SIZE   16
> >> +#define KMALLOC_NOLOCK_SUPPORTED IS_ENABLED(CONFIG_HAVE_CMPXCHG_DOUBL=
E)
> >>
> >>  struct bpf_local_storage_map_bucket {
> >>         struct hlist_head list;
> >> diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_stora=
ge.c
> >> index c2a2ead1f466d..cd18193c44058 100644
> >> --- a/kernel/bpf/bpf_cgrp_storage.c
> >> +++ b/kernel/bpf/bpf_cgrp_storage.c
> >> @@ -114,7 +114,8 @@ static int notsupp_get_next_key(struct bpf_map *ma=
p, void *key, void *next_key)
> >>
> >>  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
> >>  {
> >> -       return bpf_local_storage_map_alloc(attr, &cgroup_cache, true);
> >> +       return bpf_local_storage_map_alloc(attr, &cgroup_cache,
> >> +                                          KMALLOC_NOLOCK_SUPPORTED);
> >>  }
> >>
> >>  static void cgroup_storage_map_free(struct bpf_map *map)
> >> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_sto=
rage.c
> >> index 9c96a4477f81a..a6c240da87668 100644
> >> --- a/kernel/bpf/bpf_local_storage.c
> >> +++ b/kernel/bpf/bpf_local_storage.c
> >> @@ -893,6 +893,10 @@ bpf_local_storage_map_alloc(union bpf_attr *attr,
> >>         /* In PREEMPT_RT, kmalloc(GFP_ATOMIC) is still not safe in non
> >>          * preemptible context. Thus, enforce all storages to use
> >>          * kmalloc_nolock() when CONFIG_PREEMPT_RT is enabled.
> >> +        *
> >> +        * However, kmalloc_nolock would fail on architectures that do=
 not
> >> +        * have CMPXCHG_DOUBLE. On such architectures with PREEMPT_RT,
> >> +        * bpf_local_storage_alloc would always fail.
> >>          */
> >>         smap->use_kmalloc_nolock =3D IS_ENABLED(CONFIG_PREEMPT_RT) ? t=
rue : use_kmalloc_nolock;
> >>
> >> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_stora=
ge.c
> >> index 605506792b5b4..6e8597edea314 100644
> >> --- a/kernel/bpf/bpf_task_storage.c
> >> +++ b/kernel/bpf/bpf_task_storage.c
> >> @@ -212,7 +212,8 @@ static int notsupp_get_next_key(struct bpf_map *ma=
p, void *key, void *next_key)
> >>
> >>  static struct bpf_map *task_storage_map_alloc(union bpf_attr *attr)
> >>  {
> >> -       return bpf_local_storage_map_alloc(attr, &task_cache, true);
> >> +       return bpf_local_storage_map_alloc(attr, &task_cache,
> >> +                                          KMALLOC_NOLOCK_SUPPORTED);
> >>  }
> >>
> >>  static void task_storage_map_free(struct bpf_map *map)
> >>
> >> ---
> >> base-commit: e06e6b8001233241eb5b2e2791162f0585f50f4b
> >> change-id: 20260314-bpf-kmalloc-nolock-60da80e613de
> >>
> >> Best regards,
> >> --
> >> Levi Zim <rsworktech@outlook.com>
> >>
> >>
>

