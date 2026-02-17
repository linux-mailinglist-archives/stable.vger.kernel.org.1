Return-Path: <stable+bounces-216904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PKTM/vMlGluHwIAu9opvQ
	(envelope-from <stable+bounces-216904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:18:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAD014FEC0
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526AF304CCE0
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E09E3783AB;
	Tue, 17 Feb 2026 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tI5Dth2d"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55B29B8D3
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359318; cv=pass; b=QjOvrpjQFHi2IL+Wu5QcQyokVtX9R8UgMQv12FroDE8qHFvqDY2N8yT7lJDzevHKRxUFXwTHC5KyONYidtNGANDXIp+bbSDyfV6RP4sNe9iBj4Sep7ZmQXwoIlFZnPPSvr1pCyx6cLNME5pn0gqdmmtr4khE0N6zXXO0GF+FjEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359318; c=relaxed/simple;
	bh=N5ehEfbNmaxsIIR8T/bjRK1FaxAJ8SmNoujSELJvGq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inEvACT+S/Md+brWNG4KPhAS1cCGVeruXHRyDqKaFUzjk6siaViNRR7U0uirlFhsZkTZrFaC29gHY8Y2SfBfts79YP1l0b9rClxcdub2fCGNsW2CqHdjIgM2jaRauW1yfJ2RxaC9upzCBNaA8Z8WmT9bvhhD/hRE+JaDkkmTXBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tI5Dth2d; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-435f177a8f7so4986931f8f.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:15:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771359315; cv=none;
        d=google.com; s=arc-20240605;
        b=N/kA1MXOla/IHjKmshPSqLpOyhbUbRdSW9YPK5OK+f2C2rQz9NgWndQ7BpPMTaa+PJ
         6g7KsmuklSgkj5mmNPc2svdU4OwhFvAp+C585KY+xQyif3wDUXGzKaPW92RPtNToSSXM
         xr55R7EqEW8dXrQpkAc+qqLPu7+QZ8wnKCjNEEcUwEnjDIoS5EpvT5CC2u5ik759xJzC
         kLqY7jceIj4WoZkF3OYkh2UlZUnjRjyrKhbJ8bn5O7tdXOMqSONu4bjhdfhqHQCzjv5X
         mWYkvtSBXFG1TjZJ4p9Fx3ElJozq7KW9mIoxP+BE9ch3v3z4D26UquumG3HJePzHbdHY
         rNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zMl2Yu1W1bveqwK3ZOC1P/exlFIcqbtGooOQsCvJX8=;
        fh=14LZZQ8pQ53nxYxCDKOff1gxZW/IQXfyGRqi5e3jaBs=;
        b=Y9y1mRFvlZrDOOqUOuyQYs91LYD1gOffmrwfeMDREMZ/LgJyN5HvTnOS3EH6BFB0xD
         /jWAlNYEavHli4jPIc/0kkMcPLAk9kYP8HQPSdgNcY66yLolhqmG6zbuQSC7N5BNlMnf
         YO647I7vCglNsB5e58+gJ+i+zGV8cExTSJAIWqBR/5NKDl8aumRjBlqr182zKh7LXUQJ
         ljbnWQ44EcwEKRCkHXl9YLa2/Ob3XF4bzI2pGagLQ1HbSaxwrzhc34AqgD1G5KSemiVm
         XIpx7zxw2Gc5aqcIblIu9g0jgLHXOhn1B4/2sqr5ZfNxKXay7fRt7vVWMS3wmr66qgWe
         Gbng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771359315; x=1771964115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zMl2Yu1W1bveqwK3ZOC1P/exlFIcqbtGooOQsCvJX8=;
        b=tI5Dth2dSriFi3vgPTwoUYG39+oTsDv/HNXmkm+d0EOf8WvNbv/Qyn0hft/bRnM8fe
         20IMUA8ZezN68hFN8NVJ1ruzv8lBM+lkcT2wCt2bCwiUZXV5hCaQIrHvIb1R0zIDtTru
         xXf8JJU9Y965GCI5pzdEeMuVj5bW0/9U0UeJc4qns1itIa7W8zAs37eSB1uT55CiIb6T
         c/lQCx12xPk/Lgr9ZmM8quc//16pHSXDnSw8jgVLNfVUAz53qDtJ4czwGlTnnaKRwWAJ
         PZjl016HNoNCHsNVWzP2E0jTVSK72u8Y2kroA5mozmKw19AdVqVNuVo3yZKt0gDQJifQ
         Qkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359315; x=1771964115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zMl2Yu1W1bveqwK3ZOC1P/exlFIcqbtGooOQsCvJX8=;
        b=DXkQW/7aLAJpfqRpDj2zWTbwGLvdXiStb+RUnuso6uy4qFYwjtMBc183Atdomqb2Vb
         lTngRXNeKCw9NJ1j3Bk7bxP5nzJx0LVqTSSZYWxxEIzXQVzroudXISu0sAcMqDwsEzzY
         FBq2ctavkBv3KYfENKXror47moVWm+VLKqmHWVYiTBrQiyd6Nm1himuc6SbtOXZhUTSu
         ksa89b0mgHwFBeWGHKsGcoFhFGpqLRfOxQOBreXFeQdPJ5hVyofwOwWu57S+WlgG0S7N
         QiIZFxl21MfnaE1YMaNzmV/MjlOhVEnczj9saoA3OfEm+Ns4YF3+V1G6EmcRstPJ/gIB
         boEw==
X-Forwarded-Encrypted: i=1; AJvYcCWf4W7G46hv1fU655Sj1AX47q7SJJVHO+7mH996JaP6OblrYmyfCLabZErozFHhlzUy4Zn0fMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk+qaOFinLJWPvybQOirWyqwrgLouIgZyLzkk2wJgHJEOZnrS6
	v5O5Ocl6kPGV5Qd3uqXPkSKoDcyiK7KfxSsX7e4aew4h8BpGjO64nDrIUYRQZqI7puv3qOduTfn
	oxtuUoDwg0Vr+IcHi/2pYMuGZZvb1yzy+xUKJ5ebj
X-Gm-Gg: AZuq6aLb7c4ygeqvIE1NvYRKEq88u0bc/CSqPjl3L9ZX7qhN8qOUy83Bx8VykI1HA80
	ShTgArYS1xEMuTlxP29IG4FLKPktsTyJFVPEc2o72u/5wX8lckA6aIOpnXjdzQBdpCteB7gUKr6
	2rJsaZMpZtlu5q5a5JIY4BZGVDcCvb/4VoTz0YjAd3MhwySNKVemIQudMOAcESMlLJpigvFurVE
	gjuuftZcUx5R8F5wzaDUGgM/2YwZbTrpuim3pcUqkX1tv1gnfoDHb3s1w9JiTyQIf7eciQOiVKq
	YkNfGGxzF7+wn7+d6Y80PGHaeK34d8AMfvUl1w==
X-Received: by 2002:a05:6000:2906:b0:435:9d3f:92eb with SMTP id
 ffacd0b85a97d-4379db31ac3mr21538377f8f.1.1771359314340; Tue, 17 Feb 2026
 12:15:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
 <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com> <CAG48ez2mUQ-D3jpPbvdZzcOz16LMXRnzcudOZsfdoftBF5yvPA@mail.gmail.com>
In-Reply-To: <CAG48ez2mUQ-D3jpPbvdZzcOz16LMXRnzcudOZsfdoftBF5yvPA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 17 Feb 2026 21:15:01 +0100
X-Gm-Features: AaiRm52lAtTK24I1jWSIFWbocsxLAqep13HDwqT0r-mfbjL1WzrnLQsvrZePKok
Message-ID: <CAH5fLghCCAvOi+xRtPnD4ToQmyignjkn-PJ6xG6Y1DAUHgBKVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust_binder: check ownership before using vma
To: Jann Horn <jannh@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216904-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4FAD014FEC0
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 5:55=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Feb 17, 2026 at 3:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> > When installing missing pages (or zapping them), Rust Binder will look
> > up the vma in the mm by address, and then call vm_insert_page (or
> > zap_page_range_single). However, if the vma is closed and replaced with
> > a different vma at the same address, this can lead to Rust Binder
> > installing pages into the wrong vma.
> >
> > By installing the page into a writable vma, it becomes possible to writ=
e
> > to your own binder pages, which are normally read-only. Although you're
> > not supposed to be able to write to those pages, the intent behind the
> > design of Rust Binder is that even if you get that ability, it should n=
ot
> > lead to anything bad. Unfortunately, due to another bug, that is not th=
e
> > case.
> >
> > To fix this, I will store a pointer in vm_private_data and check that
> > the vma returned by vma_lookup() has the right vm_ops and
> > vm_private_data before trying to use the vma. This should ensure that
> > Rust Binder will refuse to interact with any other VMA. I will follow u=
p
> > this patch with more vma abstractions to avoid this unsafe access to
> > vm_ops and vm_private_data, but for now I'd like to start with the
> > simplest possible fix.
>
> This sounds good to me.
> (Userspace could still trick Rust Binder into accessing the VMA at the
> wrong offset, but nothing will go wrong in that case.)

Vma is tricky stuff.

I think if I add the vm_ops->close callback this one isn't possible anymore=
?

> > C Binder performs the same check in a slightly different way: it
> > provides a vm_ops->close that sets a boolean to true, then checks that
> > boolean after calling vma_lookup(), but I think this is more fragile
> > than the solution in this patch. (We probably still want to do both, bu=
t
> > I'll add the vm_ops->close callback with the follow-up vma API changes.=
)
> >
> > Cc: stable@vger.kernel.org
> > Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>
>
> > ---
> >  drivers/android/binder/page_range.rs | 78 +++++++++++++++++++++++++++-=
--------
> >  1 file changed, 58 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/android/binder/page_range.rs b/drivers/android/bin=
der/page_range.rs
> > index fdd97112ef5c8b2341e498dc3567b659f05e3fd7..90bab18961443c6e59699cb=
7345e41e0db80f0dd 100644
> > --- a/drivers/android/binder/page_range.rs
> > +++ b/drivers/android/binder/page_range.rs
> > @@ -142,6 +142,27 @@ pub(crate) struct ShrinkablePageRange {
> >      _pin: PhantomPinned,
> >  }
> >
> > +// We do not define any ops. For now, used only to check identity of v=
mas.
> > +static BINDER_VM_OPS: bindings::vm_operations_struct =3D pin_init::zer=
oed();
> > +
> > +// To ensure that we do not accidentally install pages into or zap pag=
es from the wrong vma, we
> > +// check its vm_ops and private data before using it.
> > +fn check_vma(vma: &virt::VmaRef, owner: *const ShrinkablePageRange) ->=
 Option<&virt::VmaMixedMap> {
> > +    // SAFETY: Just reading the vm_ops pointer of any active vma is sa=
fe.
> > +    let vm_ops =3D unsafe { (*vma.as_ptr()).vm_ops };
> > +    if !ptr::eq(vm_ops, &BINDER_VM_OPS) {
> > +        return None;
> > +    }
> > +
> > +    // SAFETY: Reading the vm_private_data pointer of a binder-owned v=
ma is safe.
> > +    let vm_private_data =3D unsafe { (*vma.as_ptr()).vm_private_data }=
;
> > +    if !ptr::eq(vm_private_data, owner.cast()) {
> > +        return None;
> > +    }
>
> (And the ShrinkablePageRange is only dropped when the Process is
> dropped, which only happens once the file's ->release handler is
> invoked, which means the ShrinkablePageRange outlives any VMA
> associated with it, so there can't be any false positives due to
> pointer reuse here.)

Yeah.

Alice

