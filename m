Return-Path: <stable+bounces-158422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFF0AE69E9
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C63D67A584B
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2411EE03D;
	Tue, 24 Jun 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dLL1h78I"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4024A061
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777074; cv=none; b=PF0kNYdy1OQAdyFiEm+5M+217PtKfcFVSg5fyzBFCWffSL76GTMQxM9lwJrr/hq1dND475al69n1ISX2ISldvurSSOT6NOlQpOXPdOmHutnt7jKEYltekpicxqVgjAOfgR/oW7FLDnpFzAqoC+yafaPbO5Wvh+vZfrKxxPlIz6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777074; c=relaxed/simple;
	bh=WPDhqX4daqvKvjLlcBeojPBuDicSG3tnkwlBoBq6u0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2rIhINK0bshkln+KDwEyyKHmwxHMOlFlj8fr4o6P847L1qFHUw5VGFb9J96Ppi4izUyxvIIB14UiAm8h6NBJ09Jwhx3d0obaAx9CG/XAuAzNziJgKaVU2hWeNYnkFs6Hh2lcTrLjmzhLFuUVJyl9piFqRdjhmOUyFtky0aiqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dLL1h78I; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a5ac8fae12so492331cf.0
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750777072; x=1751381872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3PeI/4aDsKXp+ZVEGu/5dLCW8wfvxsS+RZNNnOopr8=;
        b=dLL1h78IvjYHSdVDwCO1iKXjVBLYlKjMMRZPnURTegv25ErZUQlp5BAoqPv2d0nWnb
         1WRKIG70ySu3sTUCrBQwQRMdvfWlHwraBn6rj+KSLEypFfHaXgo3THBGWD5xf6/03Kzr
         /5KEPv4fVBUXzBB5kNYldkB85TnMmDPHtP4Bynhte6L8ZDUL8kymr4tU6YGq0oJLXT/V
         6RfAadOqxlYejv2hKSRmC3l/TQ3YJ2eRXcrLFZs2c6gzFqb/ruPI6H1LgTZ6P3S5HrIo
         I+RskLVRulQU8XsnXRRAmhE4KnBeez63x4G1CcRdjG8KwtG8zXkIPhyDGi4Su1QaILy7
         FR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777072; x=1751381872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3PeI/4aDsKXp+ZVEGu/5dLCW8wfvxsS+RZNNnOopr8=;
        b=nRKwDOSSemJlbaljEH+eORizq1KQ1EwWS+n7cj3zUjxHD1XZACQ3BDyxl0jzk8HY3q
         4MzSSFF8b4aXu3rkQvKvY5YwAhgvQnfzxI77DQKELKCTkgnEk2cID27WuJNoz/oHR2xc
         I8SUPu0uR/l4vMdZsUy9iywP/N0VGbHVb80wPKvEsot7nR8GoyFvLbeRslsczesFfwgh
         zIsYQIB3j6txfplCs70y2UUvkrVAECn4mpYaEK8A4PT5J3ismcKxSOoOYOdrR8VTiIkn
         Z2pqGqJIhZHrSIdBYLqk1VYSECueSHHt+3cO3gNa2XNviS5i+OguH+FAHkwXPA4lsoRQ
         0bXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP6YkWPZ9PkIMl4VDoomeLHuRWoDI6oO+wE2mN9z5y3pC7q759/QnOi67OsEJgZxbvMyksqKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwW0Ex8WEfwptEPTIgTjodJtjUjd1T1FvDVzlzIMlL4iNchZEd
	uC61eRDc04opQhDRmBwsuk0LDgH8nVzX8bBa9PydgpmbZb8nVzo9PSLHRtDTpfqGn0ccfBTCtNN
	r3YcOpaRIgTz9I0nUfqtSrckB0fKTWvQOijAet/9Y
X-Gm-Gg: ASbGncvt/t/6w1ZjzrM2w0bVgNkfxbKG23yq3teXCIR44v/iNX03/J5qf5G72kamiSI
	WXSv1xuIgFmcGneowgmZhCReEBwYqBIaXwB+kaOJqjPWGJSEaPksA8lSPb6/blVRe55NMs1U+SF
	o/D8yCS43vTu0wZwM+bT2rIEp6P37Nb6lxH2zEdOROY7labVkKQc1B2J0xf7LWQ8RF2UIQROFqc
	A==
X-Google-Smtp-Source: AGHT+IE/8EKQLg3rDLzXEyGk8O9aooPX+CVFWWHBn/u+kyuJsVd/1VbvNQvmvqIwO+mdR6WZAO0VlZLUuWDIC1e0wOw=
X-Received: by 2002:ac8:7dcd:0:b0:4a6:fc57:b85a with SMTP id
 d75a77b69052e-4a7af56fef0mr4289511cf.14.1750777071405; Tue, 24 Jun 2025
 07:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624072513.84219-1-harry.yoo@oracle.com> <7f2f180f.a643.197a21de68c.Coremail.00107082@163.com>
 <aFqtCoz1t359Kjp1@hyeyoo> <2dba37c6.b15a.197a23dcce2.Coremail.00107082@163.com>
 <aFqynd6CyJiq8NNF@hyeyoo> <3942323b.b31d.197a2572832.Coremail.00107082@163.com>
In-Reply-To: <3942323b.b31d.197a2572832.Coremail.00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Jun 2025 07:57:40 -0700
X-Gm-Features: Ac12FXy_yceQLqTPpBUjK-UH9noWkyxq_rmHu2wNxXxhQRvpuqB3eo42d_2gwEw
Message-ID: <CAJuCfpGd+jHoCdyuEbk5h-dbQ7_wqgX=S4azyb6Aou8spzv0=w@mail.gmail.com>
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()
To: David Wang <00107082@163.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, oliver.sang@intel.com, cachen@purestorage.com, 
	linux-mm@kvack.org, oe-lkp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 7:28=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
>
> At 2025-06-24 22:13:49, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >On Tue, Jun 24, 2025 at 10:00:48PM +0800, David Wang wrote:
> >>
> >> At 2025-06-24 21:50:02, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >On Tue, Jun 24, 2025 at 09:25:58PM +0800, David Wang wrote:
> >> >>
> >> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_lock
> >> >> >even when the alloc_tag_cttype is not allocated because:
> >> >> >
> >> >> >  1) alloc tagging is disabled because mem profiling is disabled
> >> >> >     (!alloc_tag_cttype)
> >> >> >  2) alloc tagging is enabled, but not yet initialized (!alloc_tag=
_cttype)
> >> >> >  3) alloc tagging is enabled, but failed initialization
> >> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> >> >> >
> >> >> >In all cases, alloc_tag_cttype is not allocated, and therefore
> >> >> >alloc_tag_top_users() should not attempt to acquire the semaphore.
> >> >> >
> >> >> >This leads to a crash on memory allocation failure by attempting t=
o
> >> >> >acquire a non-existent semaphore:
> >> >> >
> >> >> >  Oops: general protection fault, probably for non-canonical addre=
ss 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> >> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000=
000df]
> >> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D            =
 6.16.0-rc2 #1 VOLUNTARY
> >> >> >  Tainted: [D]=3DDIE
> >> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16=
.2-debian-1.16.2-1 04/01/2014
> >> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> >> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 c9 7=
5 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80> 3c=
 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> >> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> >> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 000000000000000=
0
> >> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 000000000000007=
0
> >> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dde49d=
1
> >> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff11020059d3=
7
> >> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc000000000=
0
> >> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:0000=
000000000000
> >> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 0000000000350ef=
0
> >> >> >  Call Trace:
> >> >> >   <TASK>
> >> >> >   codetag_trylock_module_list+0xd/0x20
> >> >> >   alloc_tag_top_users+0x369/0x4b0
> >> >> >   __show_mem+0x1cd/0x6e0
> >> >> >   warn_alloc+0x2b1/0x390
> >> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> >> >> >   alloc_pages_mpol+0x135/0x3e0
> >> >> >   alloc_slab_page+0x82/0xe0
> >> >> >   new_slab+0x212/0x240
> >> >> >   ___slab_alloc+0x82a/0xe00
> >> >> >   </TASK>
> >> >> >
> >> >> >As David Wang points out, this issue became easier to trigger afte=
r commit
> >> >> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc_tag=
_init").
> >> >> >
> >> >> >Before the commit, the issue occurred only when it failed to alloc=
ate
> >> >> >and initialize alloc_tag_cttype or if a memory allocation fails be=
fore
> >> >> >alloc_tag_init() is called. After the commit, it can be easily tri=
ggered
> >> >> >when memory profiling is compiled but disabled at boot.
> >> >> >
> >> >> >To properly determine whether alloc_tag_init() has been called and
> >> >> >its data structures initialized, verify that alloc_tag_cttype is a=
 valid
> >> >> >pointer before acquiring the semaphore. If the variable is NULL or=
 an error
> >> >> >value, it has not been properly initialized. In such a case, just =
skip
> >> >> >and do not attempt to acquire the semaphore.
> >> >> >
> >> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp=
/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ=
4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi1MlgtiSA$
> >> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp=
/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!MADvGKtvTvlLXNxlrJ=
4BdOSnbsJlyrSroPUGJ3JQHs_IF-gxxqfQ89OTZ21aN96DbmjG9qH3Wi0o2OoynA$
> >> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support in al=
loc_tag_init")
> >> >> >Fixes: 1438d349d16b ("lib: add memory allocations report in show_m=
em()")
> >> >> >Cc: stable@vger.kernel.org
> >> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >> >> >---
> >> >> >
> >> >> >@Suren: I did not add another pr_warn() because every error path i=
n
> >> >> >alloc_tag_init() already has pr_err().
> >> >> >
> >> >> >v2 -> v3:
> >> >> >- Added another Closes: tag (David)
> >> >> >- Moved the condition into a standalone if block for better readab=
ility
> >> >> >  (Suren)
> >> >> >- Typo fix (Suren)
> >> >> >
> >> >> > lib/alloc_tag.c | 3 +++
> >> >> > 1 file changed, 3 insertions(+)
> >> >> >
> >> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >> >> >index 41ccfb035b7b..e9b33848700a 100644
> >> >> >--- a/lib/alloc_tag.c
> >> >> >+++ b/lib/alloc_tag.c
> >> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_byte=
s *tags, size_t count, bool can_sl
> >> >> >         struct codetag_bytes n;
> >> >> >         unsigned int i, nr =3D 0;
> >> >> >
> >> >> >+        if (IS_ERR_OR_NULL(alloc_tag_cttype))
> >> >> >+                return 0;
> >> >>
> >> >> What about mem_profiling_support set to 0 after alloc_tag_init, in =
this case:
> >> >> alloc_tag_cttype !=3D NULL && mem_profiling_support=3D=3D0
> >> >>
> >> >> I kind of think alloc_tag_top_users should return 0 in this case...=
.and  both mem_profiling_support and alloc_tag_cttype should be checked....
> >> >
> >> >After commit 780138b12381, alloc_tag_cttype is not allocated if
> >> >!mem_profiling_support. (And that's  why this bug showed up)
> >>
> >> There is a sysctl(/proc/sys/vm/mem_profiling) which can override mem_p=
rofiling_support and set it to 0, after alloc_tag_init with mem_profiling_s=
upport=3D1

Wait, /proc/sys/vm/mem_profiling is changing mem_alloc_profiling_key,
not mem_profiling_support. Am I missing something?

> >
> >Ok. Maybe it shouldn't report memory allocation information that is
> >collected before mem profiling was disabled. (I'm not sure why it disabl=
ing
> >at runtime is allowed, though)
> >
> >That's a good thing to have, but I think that's a behavioral change in
> >mem profiling, irrelevant to this bug and not a -stable thing.
> >
> >Maybe as a follow-up patch?
>
> Only a little more changes needed, I was suggesting:
>
> @@ -134,6 +122,14 @@ size_t alloc_tag_top_users(struct codetag_bytes *tag=
s, size_t count, bool can_sl
>         struct codetag_bytes n;
>         unsigned int i, nr =3D 0;
>
> +       if (!mem_profiling_support)
> +               return 0;

David is right that with /proc/sys/vm/mem_profiling memory profiling
can be turned off at runtime but the above condition should be:

if (!mem_alloc_profiling_enabled())
        return 0;


> +
> +       if (IS_ERR_OR_NULL(alloc_tag_cttype)) {
> +               pr_warn("alloctag module is not ready yet.\n");

I don't think spitting out this warning on every show_mem() is useful.
If alloc_tag_cttype is invalid because codetag_register_type() failed
then we already print an error here:
https://elixir.bootlin.com/linux/v6.16-rc3/source/lib/alloc_tag.c#L829,
so user has the logs to track this down.
If show_mem() is called so early that alloc_tag_init() hasn't been
called yet then missing allocation tag information would not be
surprising I think, considering it's early boot. I don't think it's
worth detecting and reporting such a state.

> +               return 0;
> +       }
> +
>         if (can_sleep)
>
>
>
> David

