Return-Path: <stable+bounces-194550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389B8C501CE
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 01:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCD23B212B
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE8B1B808;
	Wed, 12 Nov 2025 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mcn77Ai1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F1EACD
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762906257; cv=none; b=q1iLDMgQZZf/EOKdrjap4ODxNVehJyKr245JZRUKdxUSZgrTuhvlfFjs1A3HHEbVlk23iL48ENpEBCHp1fpVSp0e+zm/Ks7M+IsdNDGH2GzogD/e9qu36vBGxkJ+f59nvKBXT+xk81H8n+GgeJXDgD2+9o0LaD94cA97LGXGyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762906257; c=relaxed/simple;
	bh=DN1Fe5een/t3qa9Cu485Iq092WLt4D7xS4UEK4Wo+l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0usnkkk7SgdwKTBgDzndNY/H57tfw9jnHdMCiLJ8xcf4Ip6pTtxhx0Mk6tkBhu3OyyvVYvcu2+h50vCFY3N2L4Igb7f8xolsS6gV0ML4zxL6dBSUr0AOCIYKgWN0jCEKnhgHsaD0qghnFfujougxYVD9DTsd9F1JYtuwMcCbds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mcn77Ai1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed67a143c5so123321cf.0
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762906254; x=1763511054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TofOimS+W4wPqm1YozjJKcKMNkewdNdNRtQ6Og3Qixg=;
        b=Mcn77Ai1GprVUyaVgJ7yuh4ywK9CRmtpJ+sS1ivK8jPxVH/EtzNpAitfvi0o5JJpom
         LBlgaeuyzQ1m9KdvWy38V1SnffZjGk3BZ8S/CJPQ/ckANzDbUQjqX+2icvkYBKHbcABG
         rnsi3Rrp7rbmoy8ne0m78hW3tcza3YAsZJXdXRV4a6pGxDVJDh4DN3DtikEMR1/1mhmj
         1XY5HEw1vXfjNru09R8DzdLis9fvzr4HBp8e46sFkX1w+kKgtWSI7NlnVtjOii9t+vmd
         zQl87oYWeyJjFonuu1pdO6RRii+MoNgVhJJPw8iMeybkXnrZwduEOgl5Xfu4+XYd5783
         MQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762906254; x=1763511054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TofOimS+W4wPqm1YozjJKcKMNkewdNdNRtQ6Og3Qixg=;
        b=fHmEcDSnolN0swieF1CLiN4w2g6x3E3Ax4wO4laNp0gfTfFf0xAK2MNkK7YRb6POIW
         45yL2MrWfoYC96+Sa6jOxPB27JxL8nGZlCvgVrMh+aeBBNkWD+1FAAMhCsnmWObsR75w
         FzVB+WeEbpsx63QZOiIKzF3Er04U37j8gWQa2WZ3FWj6Lzx02rMiNtwJDeP113fMgSql
         BzrgIHUydjfusV88R2t9VNKgCSfky8vhpN/OKoXQzIuOu9PQFkhFL7uHsmU4Oqcm3ih3
         l0mMnT1s03YoFDRq4VwIPwyT5ki9hdZv0bsmZaLnnkq2Vgxjgp0yesY4T1H2i3qQJLQA
         OveA==
X-Forwarded-Encrypted: i=1; AJvYcCX8dF+nK9JnYXF324ibDAIx13ilryq/BouXhaI9gfkSIeS1Yphu8w2a+lK90pVpo/9HTTnVmL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEJgnYzsDi0sXTPX9KkWO70E63zhMIS/7q7Z1e/HZx0zJF56n
	K9/UF+dWn8zq3YqmUr56gBIlS4njqjMkaGswIa1dnT2iZqseHOcUr3NZjg0QpBl0FYRcIXBzvTU
	lz8a4/aywzn/lUPmZpmiedmcq8pWdKxrt1CmRapKS
X-Gm-Gg: ASbGnctaNJRQr2LvTRmBGNKGP+RJSX8ErmfOCpabwKpfnxV3DrsGbzdAOuFg7Xckm99
	Gtx01LDfpds66lWwzwxj7RMqCL23V6qON78I2p/4MbPp61qsV4atIskL8Yg+5DnP9RtJqwZyNbo
	q0aegIPJr2eqKv8/QPrtPj++Yn71kossidAss0yfjAiW1cJNA9T7qcRqV+Qr+mETixgp/Kaiul1
	mRWVFnkYBxebTwemo0af/ZJoWD7RQRtEzza6kIOIMSJwIeHxfiE/fGy5kAzaQHC4teG3UlOU9/r
	R7rgzzKRfGSmcTxVRzV/to4364JWVPh1vik=
X-Google-Smtp-Source: AGHT+IG1ecyNEMTs/bPngxeeJjhChHGBg4qLSCj1E5+5//1j9A4bIiyry1IsaHfEA9GI8rjBudj4rW/glVxvWiugGjQ=
X-Received: by 2002:a05:622a:2d5:b0:4ed:7c45:9908 with SMTP id
 d75a77b69052e-4eddc1171d0mr2843151cf.10.1762906254090; Tue, 11 Nov 2025
 16:10:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com> <8219599b-941e-4ffd-875f-6548e217c16c@suse.cz>
In-Reply-To: <8219599b-941e-4ffd-875f-6548e217c16c@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 11 Nov 2025 16:10:42 -0800
X-Gm-Features: AWmQ_bkHdozyKSgPF1d5Bsi9z5t37_9KCgiztdRPoTJRYXVkpDN0VkjU8MHCXMY
Message-ID: <CAJuCfpESKECudgqvm8CQ_whi761hWRPAhurR5efRVC4Hp2r8Qw@mail.gmail.com>
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu() retry
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jann Horn <jannh@google.com>, stable@vger.kernel.org, 
	syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:18=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/11/25 22:56, Liam R. Howlett wrote:
> > The retry in lock_vma_under_rcu() drops the rcu read lock before
> > reacquiring the lock and trying again.  This may cause a use-after-free
> > if the maple node the maple state was using was freed.

Ah, good catch. I didn't realize the state is RCU protected.

> >
> > The maple state is protected by the rcu read lock.  When the lock is
> > dropped, the state cannot be reused as it tracks pointers to objects
> > that may be freed during the time where the lock was not held.
> >
> > Any time the rcu read lock is dropped, the maple state must be
> > invalidated.  Resetting the address and state to MA_START is the safest
> > course of action, which will result in the next operation starting from
> > the top of the tree.
> >
> > Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
> > lock on failure"), the rcu read lock was dropped and NULL was returned,
> > so the retry would not have happened.  However, now that the read lock
> > is dropped regardless of the return, we may use a freed maple tree node
> > cached in the maple state on retry.

Hmm. The above paragraph does not sound right to me, unless I
completely misunderstood it. Before 0b16f8bed19c we would keep RCU
lock up until the end of lock_vma_under_rcu(), so retries could still
happen but we were not dropping the RCU lock while doing that. After
0b16f8bed19c we drop RCU lock if vma_start_read() fails, so retrying
after such failure becomes unsafe. So, if you agree with me assessment
then I suggest changing it to:

Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
lock on failure"), the retry after vma_start_read() failure was
happening under the same RCU lock. However, now that the read lock is
dropped on failure, we may use a freed maple tree node cached in the
maple state on retry.

> >
> > Cc: Suren Baghdasaryan <surenb@google.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 0b16f8bed19c ("mm: change vma_start_read() to drop RCU lock on f=
ailure")
>
> The commit is 6.18-rc1 so we don't need Cc: stable, but it's a mm-hotfixe=
s
> material that must go to Linus before 6.18.
>
> > Reported-by: syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D131f9eb2b5807573275c
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

With the changelog text sorted out.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  mm/mmap_lock.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> > index 39f341caf32c0..f2532af6208c0 100644
> > --- a/mm/mmap_lock.c
> > +++ b/mm/mmap_lock.c
> > @@ -257,6 +257,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
> >               if (PTR_ERR(vma) =3D=3D -EAGAIN) {
> >                       count_vm_vma_lock_event(VMA_LOCK_MISS);
> >                       /* The area was replaced with another one */
> > +                     mas_set(&mas, address);
> >                       goto retry;
> >               }
> >
>

