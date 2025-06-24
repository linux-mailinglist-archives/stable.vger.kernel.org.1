Return-Path: <stable+bounces-158423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F25EAE6A1D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 17:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8646B3AA6F7
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 15:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1D22C3278;
	Tue, 24 Jun 2025 15:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2cEgtmq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5C2D29D5
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777500; cv=none; b=LF9EmNkBYeyUqElFP4Pm+ZwjbIuUoU55fgif6rUNDW548ZNazWp9YMttJGzURn2lW4uIULwTFfvMEA4oOvhl0jn1ncQIPWxxumZ4bBcSFEpCYDhPW4ue+ilcWqlRTzRADT4OBnCVZpd0BFzWqc7hDp7B6Bt+z09Fiko80OgLGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777500; c=relaxed/simple;
	bh=+J1kZdY4HRW/a8I+cCzU8z2W/yiqc/+LwnTEmvg3sKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzvAtSNpi9GD+QPmC2+dhF2UWY55Wu1AhX8DzfmIGJAC1EG8ceGad9o6k3Ei5WszGiLQg4r9TLjHWZDC9MRHz0qmpQQXYE/NL+ZxyZ1aJWPxYswlRmKUhg3BWT1ZWihJKrIqyBf4VAHu9bqXZ+J/nm9MKYo7souuy0pTO8aLgPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2cEgtmq; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-47e9fea29easo430451cf.1
        for <stable@vger.kernel.org>; Tue, 24 Jun 2025 08:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750777498; x=1751382298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9WoruwnEHNHjMXeNCepBTbJH+NjDxdugDzTFkKaFF8=;
        b=n2cEgtmqBtCJAl/WpeC0z4vwjzKMgGIAJsR1PYjN3agEvA2EtHuN/iknA2LZCDC8ei
         4r9341ByWS6K+XUC6T5GJxStWBf1VX4rxpbxeozRY5ffY+Y4lci+osjfCSF5lXPBOZDS
         HdZe4wdo1kOve2GlaHDGZJHldMDTBcrYHiieBIl9JbJYvW10yKWbiFtEuFvBStysha+b
         yYcbajYTA2m9huCW1ELXvwZF6kbV8URKxiKM6lvSNUN8AghZjY3Yyzmh4lqk6mMu2PSF
         cYnhB2VTSUzGQZo5iVxkrhUEGCQnKQkibg6PxsTRDxP4xRjLjgKXEWDE9zAWw2rJQqn1
         rpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777498; x=1751382298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9WoruwnEHNHjMXeNCepBTbJH+NjDxdugDzTFkKaFF8=;
        b=mFudm6WJGEOuBpKjt4QUVJwBy5tauDe8jdJsOOcUhmJLohhsN8Um0wI/FLiGN2On1B
         NIIgFIKpV7nPwNZF//a63SFsPHV7TgT+TWn+4lfF51SinUImz2Za2dMTUzfytSq4kjPy
         U48TFqv8s+6TRp9jtU2VDdH92y2K4s5nd/V/0NsdptOE7LlU4uqa5Mq6r5x8RFD2ktjf
         ADKSqI9nWSnzoI4j4c0i2wxqg2bDB/RLmUSx/qRndq0zul23LSlVxw9+q4gyZpdqGPYh
         xevk5zc/becUz9sv7PuPjG35S8+0/XtUq1BR57Q7dpHWuaUraFR2VY56wkF3d4A/70gF
         ER0g==
X-Forwarded-Encrypted: i=1; AJvYcCV1KbEWRRjs2EwyeMoxq3VMUVAoKMz0pYhBFihtlYdvr6P3HDj7WVr543xW3+0QW7dEO2pEmLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws7LTGPoyifQKT380uVJg0CzF5j9iCiUrbWZm8dni970QxdKzM
	jM6Z1z50SCj00Y5x+QjnaFumQbG0NF4t560w4a4l2NG4x2WhWuwWuJq010Ad+A48z7X+HR+l8g2
	H+rGLjbWqnCtR3LKpsA6WVVh55D4EHO5hgNX/pHd3XgedGXTWaTiwmnD3tyI=
X-Gm-Gg: ASbGncv8s5oyCSUagX+EkpgTEvUScaGPYx+IIxJ04w2fX5wYx0NTYusPLiAyvMsyOLq
	kv2j/tuu9IztevdSMwQCYDk+3T5kKGZdW1IZMVStGIwbWrRMSxrNa1Zry5CC8vVofNamKxnktFd
	MoJM6PmzxR0bz+Cr8qo6wnsnwP1K61HztmGIi2pmHAQlzH1+GMmImX5MQnbb308zG6ctKQvugak
	A==
X-Google-Smtp-Source: AGHT+IFJW4BtSO/bSihtdYdjhfZKZmsP2ulrjB5JbxIkGFbl0rprSrQmc7hXZNHQ9iRs7NYERhrUNxd2ed52mCtNRNs=
X-Received: by 2002:a05:622a:8d06:b0:4a6:f577:19bc with SMTP id
 d75a77b69052e-4a7af8f8579mr4957171cf.18.1750777495153; Tue, 24 Jun 2025
 08:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624072513.84219-1-harry.yoo@oracle.com> <4f12c217.7a79.197a1070f55.Coremail.00107082@163.com>
 <aFprYu5H_ztouxw2@hyeyoo> <23eb5af1.9692.197a145e5c2.Coremail.00107082@163.com>
 <aFqFKLpkfbduVoAy@hyeyoo> <f7aa8d6.a294.197a1b22d4e.Coremail.00107082@163.com>
 <2476d504.a5b0.197a214b322.Coremail.00107082@163.com> <aFq1IcKFzZvc5Vp_@hyeyoo>
 <44eb4892.b434.197a2681c42.Coremail.00107082@163.com>
In-Reply-To: <44eb4892.b434.197a2681c42.Coremail.00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 24 Jun 2025 08:04:43 -0700
X-Gm-Features: Ac12FXxB3rlXTxkFK1VeEe2nh9BjrwEX524EpTjaWlnRSeuU_Tz8zE4xXbWze8I
Message-ID: <CAJuCfpHVP16=uvE8OHpUo5+k8EOGo=fzHUZffTVbDoYW92L_EQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/alloc_tag: do not acquire non-existent lock in alloc_tag_top_users()y
To: David Wang <00107082@163.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org, 
	kent.overstreet@linux.dev, oliver.sang@intel.com, cachen@purestorage.com, 
	linux-mm@kvack.org, oe-lkp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 7:47=E2=80=AFAM David Wang <00107082@163.com> wrote=
:
>
>
> At 2025-06-24 22:24:33, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >On Tue, Jun 24, 2025 at 09:15:55PM +0800, David Wang wrote:
> >>
> >> At 2025-06-24 19:28:18, "David Wang" <00107082@163.com> wrote:
> >> >
> >> >At 2025-06-24 18:59:52, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >>On Tue, Jun 24, 2025 at 05:30:02PM +0800, David Wang wrote:
> >> >>>
> >> >>> At 2025-06-24 17:09:54, "Harry Yoo" <harry.yoo@oracle.com> wrote:
> >> >>> >On Tue, Jun 24, 2025 at 04:21:23PM +0800, David Wang wrote:
> >> >>> >> At 2025-06-24 15:25:13, "Harry Yoo" <harry.yoo@oracle.com> wrot=
e:
> >> >>> >> >alloc_tag_top_users() attempts to lock alloc_tag_cttype->mod_l=
ock
> >> >>> >> >even when the alloc_tag_cttype is not allocated because:
> >> >>> >> >
> >> >>> >> >  1) alloc tagging is disabled because mem profiling is disabl=
ed
> >> >>> >> >     (!alloc_tag_cttype)
> >> >>> >> >  2) alloc tagging is enabled, but not yet initialized (!alloc=
_tag_cttype)
> >> >>> >> >  3) alloc tagging is enabled, but failed initialization
> >> >>> >> >     (!alloc_tag_cttype or IS_ERR(alloc_tag_cttype))
> >> >>> >> >
> >> >>> >> >In all cases, alloc_tag_cttype is not allocated, and therefore
> >> >>> >> >alloc_tag_top_users() should not attempt to acquire the semaph=
ore.
> >> >>> >> >
> >> >>> >> >This leads to a crash on memory allocation failure by attempti=
ng to
> >> >>> >> >acquire a non-existent semaphore:
> >> >>> >> >
> >> >>> >> >  Oops: general protection fault, probably for non-canonical a=
ddress 0xdffffc000000001b: 0000 [#3] SMP KASAN NOPTI
> >> >>> >> >  KASAN: null-ptr-deref in range [0x00000000000000d8-0x0000000=
0000000df]
> >> >>> >> >  CPU: 2 UID: 0 PID: 1 Comm: systemd Tainted: G      D        =
     6.16.0-rc2 #1 VOLUNTARY
> >> >>> >> >  Tainted: [D]=3DDIE
> >> >>> >> >  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.2-debian-1.16.2-1 04/01/2014
> >> >>> >> >  RIP: 0010:down_read_trylock+0xaa/0x3b0
> >> >>> >> >  Code: d0 7c 08 84 d2 0f 85 a0 02 00 00 8b 0d df 31 dd 04 85 =
c9 75 29 48 b8 00 00 00 00 00 fc ff df 48 8d 6b 68 48 89 ea 48 c1 ea 03 <80=
> 3c 02 00 0f 85 88 02 00 00 48 3b 5b 68 0f 85 53 01 00 00 65 ff
> >> >>> >> >  RSP: 0000:ffff8881002ce9b8 EFLAGS: 00010016
> >> >>> >> >  RAX: dffffc0000000000 RBX: 0000000000000070 RCX: 00000000000=
00000
> >> >>> >> >  RDX: 000000000000001b RSI: 000000000000000a RDI: 00000000000=
00070
> >> >>> >> >  RBP: 00000000000000d8 R08: 0000000000000001 R09: ffffed107dd=
e49d1
> >> >>> >> >  R10: ffff8883eef24e8b R11: ffff8881002cec20 R12: 1ffff110200=
59d37
> >> >>> >> >  R13: 00000000003fff7b R14: ffff8881002cec20 R15: dffffc00000=
00000
> >> >>> >> >  FS:  00007f963f21d940(0000) GS:ffff888458ca6000(0000) knlGS:=
0000000000000000
> >> >>> >> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> >>> >> >  CR2: 00007f963f5edf71 CR3: 000000010672c000 CR4: 00000000003=
50ef0
> >> >>> >> >  Call Trace:
> >> >>> >> >   <TASK>
> >> >>> >> >   codetag_trylock_module_list+0xd/0x20
> >> >>> >> >   alloc_tag_top_users+0x369/0x4b0
> >> >>> >> >   __show_mem+0x1cd/0x6e0
> >> >>> >> >   warn_alloc+0x2b1/0x390
> >> >>> >> >   __alloc_frozen_pages_noprof+0x12b9/0x21a0
> >> >>> >> >   alloc_pages_mpol+0x135/0x3e0
> >> >>> >> >   alloc_slab_page+0x82/0xe0
> >> >>> >> >   new_slab+0x212/0x240
> >> >>> >> >   ___slab_alloc+0x82a/0xe00
> >> >>> >> >   </TASK>
> >> >>> >> >
> >> >>> >> >As David Wang points out, this issue became easier to trigger =
after commit
> >> >>> >> >780138b12381 ("alloc_tag: check mem_profiling_support in alloc=
_tag_init").
> >> >>> >> >
> >> >>> >> >Before the commit, the issue occurred only when it failed to a=
llocate
> >> >>> >> >and initialize alloc_tag_cttype or if a memory allocation fail=
s before
> >> >>> >> >alloc_tag_init() is called. After the commit, it can be easily=
 triggered
> >> >>> >> >when memory profiling is compiled but disabled at boot.
> >> >>> >> >
> >> >>> >> >To properly determine whether alloc_tag_init() has been called=
 and
> >> >>> >> >its data structures initialized, verify that alloc_tag_cttype =
is a valid
> >> >>> >> >pointer before acquiring the semaphore. If the variable is NUL=
L or an error
> >> >>> >> >value, it has not been properly initialized. In such a case, j=
ust skip
> >> >>> >> >and do not attempt to acquire the semaphore.
> >> >>> >> >
> >> >>> >> >Reported-by: kernel test robot <oliver.sang@intel.com>
> >> >>> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe=
-lkp/202506181351.bba867dd-lkp@intel.com__;!!ACWV5N9M2RV99hQ!PxJNKp4Bj6h0XI=
WpRXcmFeIz51jORtRRAo1j23ZnRgvTm0E0Mp5l6UrLNCkiHww6AVWOSfbDDdBwKgJ9_Q$
> >> >>> >> >Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe=
-lkp/202506131711.5b41931c-lkp@intel.com__;!!ACWV5N9M2RV99hQ!PxJNKp4Bj6h0XI=
WpRXcmFeIz51jORtRRAo1j23ZnRgvTm0E0Mp5l6UrLNCkiHww6AVWOSfbDDdC-7OiUsg$
> >> >>> >> >Fixes: 780138b12381 ("alloc_tag: check mem_profiling_support i=
n alloc_tag_init")
> >> >>> >> >Fixes: 1438d349d16b ("lib: add memory allocations report in sh=
ow_mem()")
> >> >>> >> >Cc: stable@vger.kernel.org
> >> >>> >> >Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> >> >>> >> >---
> >> >>> >> >
> >> >>> >> >@Suren: I did not add another pr_warn() because every error pa=
th in
> >> >>> >> >alloc_tag_init() already has pr_err().
> >> >>> >> >
> >> >>> >> >v2 -> v3:
> >> >>> >> >- Added another Closes: tag (David)
> >> >>> >> >- Moved the condition into a standalone if block for better re=
adability
> >> >>> >> >  (Suren)
> >> >>> >> >- Typo fix (Suren)
> >> >>> >> >
> >> >>> >> > lib/alloc_tag.c | 3 +++
> >> >>> >> > 1 file changed, 3 insertions(+)
> >> >>> >> >
> >> >>> >> >diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> >> >>> >> >index 41ccfb035b7b..e9b33848700a 100644
> >> >>> >> >--- a/lib/alloc_tag.c
> >> >>> >> >+++ b/lib/alloc_tag.c
> >> >>> >> >@@ -127,6 +127,9 @@ size_t alloc_tag_top_users(struct codetag_=
bytes *tags, size_t count, bool can_sl
> >> >>> >> >     struct codetag_bytes n;
> >> >>> >> >     unsigned int i, nr =3D 0;
> >> >>> >> >
> >> >>> >> >+    if (IS_ERR_OR_NULL(alloc_tag_cttype))
> >> >>> >>
> >> >>> >> Should a warning  added here? indicating  codetag module not re=
ady yet and the memory failure happened during boot:
> >> >>> >>  if (mem_profiling_support) pr_warn("...
> >> >>> >
> >> >>> >I think you're saying we need to print a warning when alloc taggi=
ng
> >> >>> >can't provide "top users".
> >> >>>
> >> >>> I just meant printing a warning when show_mem is needed before cod=
etag module initialized,
> >> >>> as reported in https://urldefense.com/v3/__https://lore.kernel.org=
/oe-lkp/202506181351.bba867dd-lkp@intel.com/__;!!ACWV5N9M2RV99hQ!J2waTUro8o=
waYlpAZJ6fnrHZvcGMbY6qAO5QvvIGZzUv-ryWjCjhO-maTOolfpPvPSr6CpqOgkRalCwJow$
> >> >>> where mem_profiling_support is 1, but alloc_tag_cttype is still NU=
LL.
> >> >>> This can tell we do have a memory failure during boot before codet=
ag_init, even with memory profiling activated.
> >> >>
> >> >>Ok. You didn't mean that.
> >> >>
> >> >>But still I think it's better to handle all cases and print distinct
> >> >>warnings, rather than handling only the specific case where memory p=
rofiling
> >> >>is enabled but not yet initialized.
> >> >>
> >> >>Users will want to know why allocation information is not available,
> >> >>and there can be multiple reasons including the one you mentioned.
> >> >>
> >> >>What do you think?
> >> >
> >> >I am not sure....
> >> >I think most cases you mentioned is just a pr_info,  those are expect=
ed behavior or designed that way.
> >> >But when  mem_profiling_support=3D=3D1 && alloc_tag_cttype=3D=3DNULL,=
 this is an unexpected behavior, which is a pr_warn.
> >>
> >> Put it in a clearer way, so far we have identified two "error" conditi=
ons:
> >> 1.  mem_profiling_support=3D1 but initialization for alloc_tag_cttype =
failed,  "alloc_tag_init() already has pr_err()", as you mentioned.
> >
> >Yes, and this is helpful because it is not expected to fail.
> >
> >> 2.  mem_profiling_support=3D1 , but codetag module have not been init =
yet.  I  suggested adding a pr_warn here.
> >
> >But in this case, I'm not sure what's the point of the pr_warn() is.
> >"Memory allocations are not expected fail before alloc_tag_init()"?
> >That's a weird assumption to write as code. I'd rather handle it
> >silently without informing the user.
> >
> >Yes, we've identified the error condition, but it=E2=80=99s not an error=
 anymore
> >because this patch fixes it. If it's not an error, users don't need to
> >be aware of the case.
> >
> >I don't understand what makes this case special that the user needs to
> >be specifically informed about it, while they aren't informed when
> >memory allocation info is unavailable for other reasons.
> >As a user, I only care why there is no memory allocation info available.
>
> My point is just that we are not expecting anyone calls alloc_tag_top_use=
rs() before
> alloc_tag_init(), when that happened, measures, such as late_initcall if =
possible, can be taken
> to fix it. and a warning message is easier to catch.
> (This is not just for explaining why no memory profiling information show=
s up)

I wouldn't rule out the possibility of
show_mem()->alloc_tag_top_users() being called during early boot and
before alloc_tag_init(). Such a thing can happen during early boot,
however I would not call that an error and if that happens and
allocinfo data is missing from the report I don't think that would
surprise the user, so not sure it's worth detecting and reporting this
case.

>
> >
> >--
> >Cheers,
> >Harry / Hyeonggon

