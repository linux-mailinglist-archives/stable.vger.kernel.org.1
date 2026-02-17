Return-Path: <stable+bounces-216865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEAbKoidlGmrFwIAu9opvQ
	(envelope-from <stable+bounces-216865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:55:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6014E6F6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 17:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0199A3007B05
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9C736F41F;
	Tue, 17 Feb 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yRlyzAVw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F6B36D51B
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771347328; cv=pass; b=PGSKxEfG+2B8oYYZLA0ar5b9iDPUwd5/oKY0/kCXqUHTrTNpmAZkcaQ2XbEfMJulPDyq81OdYgkLB6uqRwaDHygLwJj1QxIxEMTByUYKbgXBEXwixU2VcFrbXzx5pD8yRvIEsPRbLLEms5rJm8O5KDz//S9w9U6sOvcBmylqR7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771347328; c=relaxed/simple;
	bh=sBmFCIoWaZ2j7z14S+ATVAcnlO28ckHXldqUBaTsEi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQutZtCG2DXmsNFzWYzH0nWUqEL1J7A+shejts3uY/plJ39AKYVRbrfpV81P7Aml0xVupaeCrGFNUdhGeKCN1gS7u6TwVnyvKLg2eZFWLE3IjM7k33d0LmGeYEk3xi6OE1hBB6clk8AB76aRwqqmItURugM4Xewuec3M+lc/srY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yRlyzAVw; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso23012a12.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 08:55:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771347325; cv=none;
        d=google.com; s=arc-20240605;
        b=gz3kOWyOON3pTe1vcvGu7R8HrEBbV2yKRXjjc9f0vPbqpleXw6J6she+5KbZztRW/8
         3dhCHQR2R7ch2jz9grqgD1amRfvwN2944r6wXWr1InqH9Mics/4uABczs+gQfjoMwFfn
         n7Rf8otTTKSxnc2Ekog5QpI0vandgx9u8YVvmSNSEfYRAmtenGwzZFkK84mq/RBhKMJz
         KUrE0ETJZwNbtGyyntxOoo0e2pjKzZpQ6M2DoHAnWl/7A7pXfg9S/c6VbCnesC6JG4ui
         wu5+hUNO/XtKzpadba+t0Nd2JcUfiPJGQzVgfxUFs3im98cIMpDgVEZvm6lbwYt3NzkI
         NhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJ2rqxYuKMwKtIc1bHNkX7YmlF2LDfgfhBLsz256tX0=;
        fh=7vilwubAP8o3E8+KASiaQtJYD0f3jIhoq5CI/LsApPE=;
        b=c4GC7WiQ2rg1I32MIvCjh9DlQuV8B86mDMovOfwsYZ9ihl3vwVQJyvgwU+HB2pQZlV
         Cex5jc6h+jGMrlAsOav3G3Na9Pa5V0aHsMo9wKDewox5N290uXoND78P0uQw6ICEQFIM
         FoA6c+hyb1vfdDIXi1DdlF6qd2qZszyu3gDd3K+0e3SpJaDDwwVcglTxXPIyZx3iKtRu
         K9Nx2u4vC9vFmnBu/6T4SPzqayXMeRAuI4Bk61BeDMDKlLNo9AQMlMNHoINJ8HOJe077
         d4snYbVfx+NW0FEIdruNjtzphfPYmjWn5MxIpvoWXLruqMZOPlgRjGsJgP9FzETGN9hH
         2N0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771347325; x=1771952125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJ2rqxYuKMwKtIc1bHNkX7YmlF2LDfgfhBLsz256tX0=;
        b=yRlyzAVw4X6QX5IWf25oEupHdEdCscArql7+zV1MHwcsocf/JEN0hBKJrF2tAyO0dg
         DTUO7yveurNZxHBWchp/F3/1LSWBbxRL8sGVQ6zZCo85l0zE+61GItybsJx3nK/f0BNh
         lUzLI6K110XrQRdseWyNw62OkAH1A/45v9c3ycUcpTS1PwH82XHfXpoIRFaXNFi7naq6
         uufqyCmGVf5QBbsi87cLvLs9m98DkCWoeLEgdv30jUQ/KqlcBR2yub1zb5j4o004Ltsb
         n/0KydKTGDM8tI0h6BIKWNMTCeEazdteUNXgG3WFiRZh4zxZqj8mkK5Y7mUL/K/OzKxl
         sjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771347325; x=1771952125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJ2rqxYuKMwKtIc1bHNkX7YmlF2LDfgfhBLsz256tX0=;
        b=SLyGDqRmP9uJGiZVTooS2i8hhRDWTeYhSaodUmkxKDA0REA5HZCKiN/RqsLDKIqHza
         rHIY7DcRzJjRgBDWi13NJlLmkGHZzdRC7JpGnIiiFQL/CvCyN12nut1214E0G5gQV4gM
         H38lDvr8gb6bqOyY+HPAHduRnfCyjMz7Qu1E8nYqK6SWohKH8E4WsGjsVJQJ99Kz8IWc
         SGn6/WwZhf4AD9bEoKJU6ql0VElECsTUfQDNerevvKRqV2YE38AgyxlVG2zMP2iOU/vM
         2aOksfZVCY+GKTIsQxqPAkpGpoObqIgN98YPrOxg/nyyEhsVXxLpu/Mns9xZHq04DW7L
         c5PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlaHb1BuG6V+pwIVSko+8xqblozmPSMs36r//SzGh85jm+Njr+NRNg128b8MoJAtc4ATM8R90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKZ4klpdvD2PE8T95e9XmyhKZ/wkwNaoW4XificemIZQEADjI
	b5XZ8IVhCJQU0F7WmH24oIdZua2htf99iuZF2GFWFBR6kJDAFytg0mhFnW0c5yQJBGxBquVRIbr
	Pogz34sEaqnD5BW1o9KHrz0lmMhzOuVvg0UPIFoxR
X-Gm-Gg: AZuq6aLwNS1nD/DcIUUFefp4KyzgobgputYJm3zzi74mCAeKRDFWfQnfFsZYRZ3mS3T
	drWIKSGANodtXMZ2zIfzQfN825YviICd5o64KlXg1h3ThgQEKOAqjhn5VFNlvO9exTIicQl8oX8
	LSeyQV+gSeVcFztlGwOEoEJMLmXztT+oMWMkAEGImp3VId0WqG+ZhBpFWG5QfN9Tv8y07giXXZ8
	ts+NHKLJO+yYV9gn8Zoi4ykbxFLCEDKT4AGK5YAQhFetaoYeu8Ck5GwBY53zxebKD/QanJGqPdQ
	Y3jxro7qmLp7r7U0w6mKmnV8gDv5S9+z0p3Z+Q==
X-Received: by 2002:a05:6402:b18:b0:658:1d3:33c3 with SMTP id
 4fb4d7f45d1cf-65c14a4fe33mr56118a12.8.1771347324036; Tue, 17 Feb 2026
 08:55:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com> <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com>
In-Reply-To: <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 17 Feb 2026 17:54:46 +0100
X-Gm-Features: AaiRm53xdNxP3D4hVKWPqXGAMAozDOb21HTNRGps1S3nOEwdUFrseEV130fDG9Y
Message-ID: <CAG48ez2mUQ-D3jpPbvdZzcOz16LMXRnzcudOZsfdoftBF5yvPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust_binder: check ownership before using vma
To: Alice Ryhl <aliceryhl@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216865-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 72E6014E6F6
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 3:22=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> When installing missing pages (or zapping them), Rust Binder will look
> up the vma in the mm by address, and then call vm_insert_page (or
> zap_page_range_single). However, if the vma is closed and replaced with
> a different vma at the same address, this can lead to Rust Binder
> installing pages into the wrong vma.
>
> By installing the page into a writable vma, it becomes possible to write
> to your own binder pages, which are normally read-only. Although you're
> not supposed to be able to write to those pages, the intent behind the
> design of Rust Binder is that even if you get that ability, it should not
> lead to anything bad. Unfortunately, due to another bug, that is not the
> case.
>
> To fix this, I will store a pointer in vm_private_data and check that
> the vma returned by vma_lookup() has the right vm_ops and
> vm_private_data before trying to use the vma. This should ensure that
> Rust Binder will refuse to interact with any other VMA. I will follow up
> this patch with more vma abstractions to avoid this unsafe access to
> vm_ops and vm_private_data, but for now I'd like to start with the
> simplest possible fix.

This sounds good to me.
(Userspace could still trick Rust Binder into accessing the VMA at the
wrong offset, but nothing will go wrong in that case.)

> C Binder performs the same check in a slightly different way: it
> provides a vm_ops->close that sets a boolean to true, then checks that
> boolean after calling vma_lookup(), but I think this is more fragile
> than the solution in this patch. (We probably still want to do both, but
> I'll add the vm_ops->close callback with the follow-up vma API changes.)
>
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Jann Horn <jannh@google.com>

> ---
>  drivers/android/binder/page_range.rs | 78 +++++++++++++++++++++++++++---=
------
>  1 file changed, 58 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/android/binder/page_range.rs b/drivers/android/binde=
r/page_range.rs
> index fdd97112ef5c8b2341e498dc3567b659f05e3fd7..90bab18961443c6e59699cb73=
45e41e0db80f0dd 100644
> --- a/drivers/android/binder/page_range.rs
> +++ b/drivers/android/binder/page_range.rs
> @@ -142,6 +142,27 @@ pub(crate) struct ShrinkablePageRange {
>      _pin: PhantomPinned,
>  }
>
> +// We do not define any ops. For now, used only to check identity of vma=
s.
> +static BINDER_VM_OPS: bindings::vm_operations_struct =3D pin_init::zeroe=
d();
> +
> +// To ensure that we do not accidentally install pages into or zap pages=
 from the wrong vma, we
> +// check its vm_ops and private data before using it.
> +fn check_vma(vma: &virt::VmaRef, owner: *const ShrinkablePageRange) -> O=
ption<&virt::VmaMixedMap> {
> +    // SAFETY: Just reading the vm_ops pointer of any active vma is safe=
.
> +    let vm_ops =3D unsafe { (*vma.as_ptr()).vm_ops };
> +    if !ptr::eq(vm_ops, &BINDER_VM_OPS) {
> +        return None;
> +    }
> +
> +    // SAFETY: Reading the vm_private_data pointer of a binder-owned vma=
 is safe.
> +    let vm_private_data =3D unsafe { (*vma.as_ptr()).vm_private_data };
> +    if !ptr::eq(vm_private_data, owner.cast()) {
> +        return None;
> +    }

(And the ShrinkablePageRange is only dropped when the Process is
dropped, which only happens once the file's ->release handler is
invoked, which means the ShrinkablePageRange outlives any VMA
associated with it, so there can't be any false positives due to
pointer reuse here.)

