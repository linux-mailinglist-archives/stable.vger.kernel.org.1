Return-Path: <stable+bounces-214724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EsIK2hAhmmFLQQAu9opvQ
	(envelope-from <stable+bounces-214724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 20:26:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1446A102B5A
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 20:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 391133063B7E
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 19:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B0E30649C;
	Fri,  6 Feb 2026 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2t9KC/k"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF122FF161
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 19:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405554; cv=pass; b=r+bDZbHapMeV8vdA5GqBGYZxXG9aBZYIoW6Xh36movGxxQgpuCR6hBunRzT2Jh1GYC5GTIjzNh+RpjRmRIpz0lybkAs9IqH/t4Xr72/N33J3nGKiAbj0BmTuzud4Og7ks/IRj3dOpy7UQ14mOpzpY3uhZfG7digVQPWuXo+EcEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405554; c=relaxed/simple;
	bh=8rnsjteWqNgEKS4ck2l7RQkyQJPRY1LgHDc7jaFq98k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNt4bx1lwHrCURPRRgC1AAkD3CS7JN0t3mSTowAR3X82hdF/2CFQuaB55hUBdZP1gR4OlWnKNRbzlO/iA48j8Ysr5/zDC5wto9i8iXPMCFJrwtZnGFTnBSopPetqDNcLpVuHtJk8MOlBjZulfaCwiDsGo3ncbphHlyh5GXjVNXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2t9KC/k; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4359a302794so731129f8f.1
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 11:19:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770405552; cv=none;
        d=google.com; s=arc-20240605;
        b=YC1zZz9UGHu0Hq4pja13d+qmlNZ9SLJauNu9CnCd1bXAE2zGkifn/9BznfZCRNgKLj
         bDhmJoR+mx2ilKYJ/Bm8txwZdp0RytEtRuTtChHfJ/lz3h7vtQjfZpwH3whSoPReHMs9
         8LxefORZ7FHViLFfaEwoGU6NgHOeF9dKHJo8YfCOUHwZCpXz5XU2e+T/+iKajuCrSFiQ
         NhQWIcMD3JlAghea3ZLnTVRmz0HBy+GoRl6urEg3dvbshLu+k2jbxS4ksUpu4Og7ql7+
         y2BDF1k5ue1DK7AmGR+iDFB+yFcugve+GTpDcjsxbEjJUjsxsHFwxam1122IHK+NdkCb
         N2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvh5DMP0qO3wt6PHVaJkcnU2bdJYis/SM/P7hxyNSCA=;
        fh=/MidIX0LfeGpvuZ+ga96ghErR0rUYUcFDFeR8MDfpds=;
        b=DzqFiCQTg8kjezupfUTjLXF3F4cMce6d2RrdcBZLEX+VROrj+qxa3r7V0vtAenl8TB
         SdV0KfYMdV5PcbOoisr7HznPnhOPMrjwf2YrEU8kukzWzRN36FPGFnXeFHLHAz73jSfn
         68svhmxPDBGWQE12XETSvCLLsuilGCVabAY0eBKGabn1tJgpj5UijarM1XO7JvEsTL19
         WFJSJSvEO5TZhF+i9PoDTVCRZznQpcSNAfS1zZ1wNv2TL7dLvo/kWfcGcvfUcxCiA/Zf
         CtFrVayLVGHKxG1Qh1bKv5YXtTzJSmU7MQ3pApFqZQXRGzJPmrUh2Bl+ODOl2xEAn0ht
         nY9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770405552; x=1771010352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvh5DMP0qO3wt6PHVaJkcnU2bdJYis/SM/P7hxyNSCA=;
        b=J2t9KC/kuoLNsuNFhcV67w1r/q/z0FR1Fg/wBA+KuMV52mqJYRn14miMWoyK+Ddmow
         RGarlKerYeBSmhezHNS8elqx0Dkc/4Mt3FUqWgeZwRUH0SCOfCG5uL677MfiPm7KpLtP
         yTHgNJJe5KGAuFz72I5QQ05EhNyK6GIfFuR5V4EWPMjoWyY1xX5aGiy4wdrP+umI86Mx
         Vq1elMJBfqpKrs9Vpz+QLXBTbkOjEDMnPwjSEHNW4YXHDKBGFQsr7fSrjIrQIKdyHjIL
         hdbtiOLLMbKP6U/5pS60xMEFHNsu1ueNjZ9VFDj/u17VG6/AzcFz3/npL2eWC69BnPlX
         D+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405552; x=1771010352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvh5DMP0qO3wt6PHVaJkcnU2bdJYis/SM/P7hxyNSCA=;
        b=SanxXQ2UdaMyIszzYMocd+qX9Shfle1ewgwoFuB4rTCFcplxjkJc3mlDvX9d2kDe2K
         OV6sn/sq1NpYjoUPlFyhEMxeWp5D0n8lROARap/rfco3T24doPx/Fq3zGnPjN5XjK9m0
         65RC4wl9fkXgnwxLC7prkvpGfkEed5de9k43ImgmlPBgf0xV0pYP8IiOg5ULGpVCX7lt
         H6ElAu57CD5k1FZFZOX3GlQ22oWT7E5QsbiRnzJ3LEJ40eXk8mdZSvvPi/p1okmM9nU2
         g70TWVl3TvdpGkDQiGxC39h3RaDybaExVDZg9oGKBQO2mafUJc8r7Zru0jJlKyOHBZyD
         hBcw==
X-Forwarded-Encrypted: i=1; AJvYcCUXeH87r9GZFMsHR3K7eTxYEoiWsEukY7kR1/Dbb/4kecWWC7Cs5pC3C1+kASkzfkv8sswZ7fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSKO08VwIUDWaBKp5NrFaI6o45kb2ratI1cuMYQLTi8hegmn1o
	5nKyYT/o+ynyfMVNmXW/d1d5EBGLwXjQfDP0Ladf35TYhsafS3QyYjiKnzAx0HWIkc1g5H3J7R/
	1LGylfvimtRamsViJ7tlMGHkGWHQtVdQ=
X-Gm-Gg: AZuq6aKVAC5YQeGErcZUEqFPiJiJZWW30kXD3/CSnTg2WbiU8ns4LG8+PGAvNDEXXPg
	P+13DnDwnypypSq5vOKlzdgrF4MjzoMr3L1pmCQSGX+onogCAjoJBZVmrS6l/bG9lsWWdYoxql8
	5WYhHrlTLdY4StrdttbaCwbwqmL9PL4G5LECgUyh0tyXeNtHnhyMFfs49P0MSl8l7QlQZla/rmE
	gUFMGMI0YRvow9OCRIV9CUuF/sQjewZA0rk0eGsziDxSHd2VJ75uP6NKAwQd2pjogGao7aUIHqi
	oyW8yt8GJ97HUKdPCF2TDLpvieCtM9AC/O8gajWTFcjBZPVuo5Xk/G06DRZ+ousRMNUlOfrFhfs
	5kbCrl8c4MkOxlMbe6dovcyFu
X-Received: by 2002:a05:6000:24c6:b0:430:f985:a7b2 with SMTP id
 ffacd0b85a97d-4362938a74bmr5832110f8f.51.1770405552209; Fri, 06 Feb 2026
 11:19:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206171348.35886-1-harry.yoo@oracle.com> <20260206171348.35886-2-harry.yoo@oracle.com>
 <2ce1eac3-98fd-448f-8a73-01bb3cb5a7d5@suse.cz>
In-Reply-To: <2ce1eac3-98fd-448f-8a73-01bb3cb5a7d5@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Feb 2026 11:19:01 -0800
X-Gm-Features: AZwV_QgOmEJlQPiQCkEAMnSvrww4GS3Jp7SWFouow-nGLlJkXss3_AON0w3rSVU
Message-ID: <CAADnVQ+1RBXBWNQtshEfFNZEp0tDZOFKf_vedyjgdz=wqWdG8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/slab: skip get_from_any_partial() if !allow_spin
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Hao Li <hao.li@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-214724-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: 1446A102B5A
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 10:10=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 2/6/26 18:13, Harry Yoo wrote:
> > Lockdep complains when get_from_any_partial() is called in an NMI
> > context, because current->mems_allowed_seq is seqcount_spinlock_t and
> > not NMI-safe:
> >
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   WARNING: inconsistent lock state
> >   6.19.0-rc5-kfree-rcu+ #315 Tainted: G                 N
> >   --------------------------------
> >   inconsistent {INITIAL USE} -> {IN-NMI} usage.
> >   kunit_try_catch/9989 [HC1[1]:SC0[0]:HE0:SE1] takes:
> >   ffff889085799820 (&____s->seqcount#3){.-.-}-{0:0}, at: ___slab_alloc+=
0x58f/0xc00
> >   {INITIAL USE} state was registered at:
> >     lock_acquire+0x185/0x320
> >     kernel_init_freeable+0x391/0x1150
> >     kernel_init+0x1f/0x220
> >     ret_from_fork+0x736/0x8f0
> >     ret_from_fork_asm+0x1a/0x30
> >   irq event stamp: 56
> >   hardirqs last  enabled at (55): [<ffffffff850a68d7>] _raw_spin_unlock=
_irq+0x27/0x70
> >   hardirqs last disabled at (56): [<ffffffff850858ca>] __schedule+0x2a8=
a/0x6630
> >   softirqs last  enabled at (0): [<ffffffff81536711>] copy_process+0x1d=
c1/0x6a10
> >   softirqs last disabled at (0): [<0000000000000000>] 0x0
> >
> >   other info that might help us debug this:
> >    Possible unsafe locking scenario:
> >
> >          CPU0
> >          ----
> >     lock(&____s->seqcount#3);
> >     <Interrupt>
> >       lock(&____s->seqcount#3);
> >
> >    *** DEADLOCK ***
> >
> > According to Documentation/locking/seqlock.rst, seqcount_t is not
> > NMI-safe and seqcount_latch_t should be used when read path can interru=
pt
> > the write-side critical section. In this case, return NULL and fall bac=
k
> > to slab allocation if !allow_spin.
> >
> > Fixes: af92793e52c3 ("slab: Introduce kmalloc_nolock() and kfree_nolock=
().")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  mm/slub.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 102fb47ae013..d46464654c15 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3789,6 +3789,14 @@ static void *get_from_any_partial(struct kmem_ca=
che *s, struct partial_context *
> >       enum zone_type highest_zoneidx =3D gfp_zone(pc->flags);
> >       unsigned int cpuset_mems_cookie;
> >
> > +     /*
> > +      * read_mems_allow_begin() accesses current->mems_allowed_seq,
> > +      * a seqcount_spinlock_t that is not NMI-safe. Skip allocation
> > +      * when GFP flags indicate spinning is not allowed.
> > +      */
> > +     if (!gfpflags_allow_spinning(pc->flags))
> > +             return NULL;
>
> I think it would be less restrictive to just continue, but skip the
> read_mems_allowed_retry() part in the do-while loop, so just make it one
> iteration for !allow_spin. If lockdep doesn't like even the
> read_mems_allowed_begin() (not clear to me), skip it too?

+1
Just unconditional return NULL seems too restrictive.

