Return-Path: <stable+bounces-216903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJNYAN3LlGluHwIAu9opvQ
	(envelope-from <stable+bounces-216903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:13:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9815814FE29
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F36763003802
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D22C3255;
	Tue, 17 Feb 2026 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lgG/VSW7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E829AB02
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359192; cv=pass; b=DcJUL1fyrAcP7cJy+/g34W/UrbGWSVWBl0dCs9wNdReoKH2vwvjpUqa6rvMHudbH3Vf7O6FkbvuJLKhr1N7UD7xxVIGXDFWJYWFvgL9DvyeYyOej+7VpgMof+xk9z0Y3//n1cnCamuJXGYqXleLNHWCPdJi18wvJxWEgeSGuJfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359192; c=relaxed/simple;
	bh=p4esf1iN4S1z1tKjNoPQadz/D3/X8dM90mV1Gls+vg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcYY4RADYjlLceRanw7Y38mykB9oEN4nz42DgYKTDqpoW3ztEF4PcnovvfADAs3HGUoCJNt/B+GIvAroZhnP3zsIYI+IYjmA0qfJB/b9OzR5NUuUj+CP7e2blGsPx5dWz4K5gqw9zrfQiuGKIb121KVe9N6Ua6V18qNe3mnezDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lgG/VSW7; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48371bb515eso52557725e9.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:13:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771359189; cv=none;
        d=google.com; s=arc-20240605;
        b=anlmQs7nQLsz568b5rbtyJrRG7KJyS2zoGMjqAr5lgNsoQI7VSwK+VS1vadk1VkLPU
         3jJVJMxoqpnchMoVYcHzJ0cm7PMT54Bdiq4V+qIJ51i/uuOQhy4cgpcR4DUiQsRB6kW7
         U7VTa/Z8wrYnTeoDVf9nLqQr0mXxs4APHmZDqN0AK394qQa7o51ELHxcPP6M3BtUop6K
         gbi75jtlTpvtqFkoAbf2jVTBCB80FLPKsamt4uKnHZFPBdtoarr4IlNPAxNCS+Ig5kYQ
         WVwiyS/tipJ4okNPCdAA/HzI5YY0g481oE5PyuA8YxADtRf5B87PgYTpBIVhw1va2/VO
         SG1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CvSItU0sreEL4B15MgR7qAnJZMB2EOXjlw60m4SYry4=;
        fh=oi80svDV0FgeerhRJ6dCZJHrCEtVDXu/NKhYffM4CGE=;
        b=dPZ1NYH5vhSkdAwg5xdJlje1p4JwziYC/YYfnvFFbxIdNGb8Hz4d1GVGt1hyTdtazG
         UiU0wAKSTHWONmpwFj10zThBhbbUuGxgIAujY4cP96LCz1FkZvrUO3IWw0k/bvA99PxY
         wpRfd930XBn1fg63kH90Vryt2Jr1G4eInKIfuZaYz5/QnvPaiOKPunoiH359t+F5RloU
         ShlaR3CQhvkalCU3yCv3RP7MapDhEere+NqsYKBN7T+NdcoJNBtUOubNL3iGTBtUXTCw
         7Hig2tSYxckfy0D0goR3Zqfii5N3VYKotFT4RNQewuadQ3auQ6AThpj01O+EhaDk4fPV
         1bVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771359189; x=1771963989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvSItU0sreEL4B15MgR7qAnJZMB2EOXjlw60m4SYry4=;
        b=lgG/VSW7/2qyGe1oJvJZV4wVwr0KjhgvhlcGdZIGz99UmEQM8HBv9dfs7qBTwN+PH3
         nwd3FpZCBJqWQnf51JIbiJidAx8chKs9vE+7oZU2mG9oIshLsiQMfrcXBBHZ1uP9j6Em
         Pt6nrYTL7zHN47ul8CXkCTPf2ktG5j3JDERUBMMYezUJDAWYx+WjbleHhmaDWHnVfAqH
         l0yiThp/ksJrw0xTm3LAJcnecQXVw1q3iHSy+0m1sIQ1Diw5+/O/vN331+4DyYDBXnvf
         3nbmUtv+Eg/qyZ0ef85L9C9i0K0Ejl8u4nvcnfhD5ZLfnpjJP2NZ2P3ZDyEQVW2VJN5g
         8IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359189; x=1771963989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CvSItU0sreEL4B15MgR7qAnJZMB2EOXjlw60m4SYry4=;
        b=xHaIMCfnGrr8uy9LY0H5PuIOypzk9GJmb/iZUyEwIzmOOkZCxaOPPDVg1O/gMcTkTV
         FaRb89+MnT9aJixSVwgIY1Edt9wxQVI3rxl0J2c2UiFaxD7d8aWDEDGOjlHnOBz04Wks
         WxaDgJgVdn7Ei6CHIhL+8JxPN4x9enBr/8AQYMlZoi+u1vlAaNiXAWPZ/JRRTcZSw37p
         dhPtoLt6eMy9hh2fLzUi0vZt7s5Hr5cinyVBwXxtZHcNaQxzcV2WnKd9aqer8bXWDVCI
         qa8MQr3CPUVlRcOj25mBgGfm67EhNbrDlKAGD0XHeNQL6krwDjuA91EIdMis0Ffb4TTv
         KUow==
X-Forwarded-Encrypted: i=1; AJvYcCUgBM8Fng2nQLwKg6QwUY2YvMx6Yb5kWMHOr1jXjLj7ar7AWPUC0jUzvQHCeWoaS/4WLhNtA9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/A2R0pgtGAySr4YcIyCasqGTS4uC+YzKzewc2BC/+W+7+3wVj
	xaCMftxqwTke6zFDubiXm3s5sBdVj2XbSOfrP3JF5IvQwqxNcFnK4PbAgnk/2feVxH7897ph7Kc
	k6To8CBhD/qNFB5WnQ5KLbqaMErbp8RXG6qnP3C7j
X-Gm-Gg: AZuq6aLvgoz1MqPSglNgf5PsezOJFvC5I+2fR46sKYoa1GzzU1M5AHap5AXaRkIZ4C0
	HRQbtRdEbg0cVdXmyBobgd9U5jqIG+d4O7cblTC7UHbT8pCowPRNq5UxcOqRtnkqvE8oAKfw0c7
	AKgN0IZV+t6lwGIejAE1+OmsER5ZmrHz5RPxgnEcHmHDvCz8Gd8gpKWQf8wMVMahqhkn6WToJiy
	+ZxjAaDmKeXjEL4VZaOUPMMpNsSPMc7tVHA+nUfc3nJJxQtag7s8IJevuHTkWRLDq349SQ0mng8
	MAMiEDRGmmYT5LmdwpYuK1YKVyhkKJVu4MfHfnOjouLajm7e
X-Received: by 2002:a05:600c:3496:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-48373a5ba90mr257612055e9.17.1771359188669; Tue, 17 Feb 2026
 12:13:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
 <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com> <DGHC1OLDIXC7.Q4IAOOSMHIY@kernel.org>
In-Reply-To: <DGHC1OLDIXC7.Q4IAOOSMHIY@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 17 Feb 2026 21:12:56 +0100
X-Gm-Features: AaiRm53IBeHjKaJgOILHNfxfP3AsdI88i44Wfx6908SXCYMlXXgAxRb7b8ZWSRs
Message-ID: <CAH5fLgj2+XUzsuAnvwL=dc=5yOZvXCapBWRbFGwJAX2v5Wk4dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust_binder: check ownership before using vma
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Jann Horn <jannh@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-216903-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 9815814FE29
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 4:13=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue Feb 17, 2026 at 3:22 PM CET, Alice Ryhl wrote:
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
> I suggest to use imperative mood instead.

How do you propose to reword "I will follow up this patch with"?

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
>
> If you have a link, please add Closes: after Reported-by:.

There is no publicly accessible link.

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
> > +
> > +    vma.as_mixedmap_vma()
> > +}
> > +
> >  struct Inner {
> >      /// Array of pages.
> >      ///
> > @@ -308,6 +329,16 @@ pub(crate) fn register_with_vma(&self, vma: &virt:=
:VmaNew) -> Result<usize> {
> >          inner.size =3D num_pages;
> >          inner.vma_addr =3D vma.start();
> >
> > +        // This pointer is only used for comparison - it's not derefer=
enced.
> > +        //
> > +        // SAFETY: We own the vma, and we don't use any methods on Vma=
New that rely on
> > +        // `vm_private_data`.
> > +        unsafe { (*vma.as_ptr()).vm_private_data =3D self as *const Se=
lf as *mut c_void };
>
> Maybe use from_ref(self).cast_mut().cast::<c_void>() instead?

Honestly I think this one is easier to read as-is.

Alice

