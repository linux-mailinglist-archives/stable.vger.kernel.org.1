Return-Path: <stable+bounces-241250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE6QJM8T72mU5QAAu9opvQ
	(envelope-from <stable+bounces-241250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:44:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3207446E879
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7DFC3008335
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4DD38911B;
	Mon, 27 Apr 2026 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXDmLILn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3965382F0D
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275842; cv=none; b=DHEktXsDviap+nEvWmWWURZyIGLn5idblKKfcCoBpAMoRFZZWfok7t8G0VqlxaUB32m+zgkHfIQyxcM+dfWxCOICAV8WlTJQWnAMmz5ywOJfVJ8eHNr3Dz+f9Rz0VYAK9/X1W5e5f26w1xaXw6ihyVoKUOuGr4bZSU6ooPTNJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275842; c=relaxed/simple;
	bh=ngGhTLrAa2xhHWxg5GW3kgiBaJKdXzM0OPoINUWOGtQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=POabhf0QWczPAto0eqlRWfb9p1RnG/AHbIYov2bYe3yKLy5qNAxkvIGTRcQhKcvwYFSAViDzZz052UQCn5F31rNgb4qZTSmZiWL1ISY9UxBhIJD9ipxNamExy1ntevCsuX7Xneuka7xsImw320Yk7YMOMx1ncWuQZxMx4Vn0k6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXDmLILn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-488c2a4e257so74444685e9.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 00:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777275839; x=1777880639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SBH1hhOOZ7xyNlk8eBq3uH3FO3jhxPNEB22rtUlbovw=;
        b=TXDmLILnDp/okmDbAkb0L9FWfcMy9riFdJfbdQgO3bltiSuBNBXjwW27fjLL3bM0Yn
         yfnlVE/mLaaSFNwfBrHOFHVwsQF9HFYkkNP1jjYeUNPPF4FqbdYMyZ1pd/LZFt6eUC3A
         YdLoAdWkB7vnPgckeGzDTL4Ej+aa+PLAfZYim/8puPekoKn0UT6r/llYtziwJ1bdM8B0
         +nhSC8fiWFs84cS6q9u8jcBWIbmrCz40ahY1frc1CuEFRxswoqXn1aWJmKljL9MN54Gl
         U8Sn5jyX864zedS0H+xgQ5kVjLKLPZAV9hFZTRnvGYO05LY1bEvlRlE+GVIZ/dxNLwLM
         ThJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777275839; x=1777880639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SBH1hhOOZ7xyNlk8eBq3uH3FO3jhxPNEB22rtUlbovw=;
        b=bLgNAlvWl3G6Om3UuqYhFC9MlgCn6S2FajJHD0qq4xsEz36R7SksNshO6Mn225IypW
         uJSx9Vg3v8PIwgY6k6qqbuNiXAPpQFwr+yybS485yKwUqiQJ3qoRqRhlfeTCN5jEX0J7
         zjEP9sXKS/wmbZ0gmR5EvYyw4qnaAmJyqRbvPpTEcmDzp31GV4VoFWfqSAcdJ1LBB4Ev
         ozdlWJ4TXsAfCqy+Vl8sxAdmcSeTQrOQoTDLCUg6dYgK9now1gXWIfJfRVZ9nh0I1Whl
         Mk4HnyAY+iRef8XVsTeQhaD2csXSK87HklTJQkEyon6B0urD8FlLq1HPl82KhxO/cwsT
         Ez+Q==
X-Forwarded-Encrypted: i=1; AFNElJ/KyXbHIHQf1bBtsO0ybX/KTUwy3sNO7gt7SOLf1+BHTXDxWamdgp7WpzCOKWZcSOOZvakt/KU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Xz3GAXrdarqwzLZ268AH57olwtTUqtTC0SfNlSKw/eRiBvWI
	UP9akFL5f6rHoRvCozE2NbGfZ+1/Likb66jKoK3HPihY5JNUWRB/b3MJhJa9Vl8s4u3Q6blU85Q
	m3Ko40/4CdUkveRvSUA==
X-Received: from wmxb6-n2.prod.google.com ([2002:a05:600d:8446:20b0:48a:73ac:6247])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c4a6:b0:48a:761:57fe with SMTP id 5b1f17b1804b1-48a07615be4mr454202875e9.0.1777275839215;
 Mon, 27 Apr 2026 00:43:59 -0700 (PDT)
Date: Mon, 27 Apr 2026 07:43:57 +0000
In-Reply-To: <DI1MF28YGPFP.IMX7LYPV6A8L@garyguo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423-pin-init-fix-v2-0-ee3081093a0e@garyguo.net>
 <20260423-pin-init-fix-v2-2-ee3081093a0e@garyguo.net> <DI1MF28YGPFP.IMX7LYPV6A8L@garyguo.net>
Message-ID: <ae8TvUuM7iZZY4GS@google.com>
Subject: Re: [PATCH v2 2/2] rust: pin-init: fix incorrect accessor reference lifetime
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 3207446E879
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241250-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,umich.edu,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:email]

On Fri, Apr 24, 2026 at 08:10:06PM +0100, Gary Guo wrote:
> On Thu Apr 23, 2026 at 3:51 PM BST, Gary Guo wrote:
> > When a field has been initialized, `init!`/`pin_init!` create a reference
> > or pinned reference to the field so it can be accessed later during the
> > initialization of other fields. However, the reference it created is
> > incorrectly `&'static` rather than just the scope of the initializer.
> >
> > This means that you can do
> >
> >     init!(Foo {
> >         a: 1,
> >         _: {
> >             let b: &'static u32 = a;
> >         }
> >     })
> >
> > which is unsound.
> >
> > This is caused by `&mut (*#slot).#ident`, which actually allows arbitrary
> > lifetime, so this is effectively `'static`. Somewhat ironically, the safety
> > justification of creating the accessor is.. "SAFETY: TODO".
> >
> > Fix it by adding `let_binding` method on `DropGuard` to shorten lifetime.
> > This results exactly what we want for these accessors.
> >
> > Fixes: 42415d163e5d ("rust: pin-init: add references to previously initialized fields")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > ---
> >  rust/pin-init/internal/src/init.rs | 104 ++++++++++++++++---------------------
> >  rust/pin-init/src/__internal.rs    |  31 ++++++-----
> >  2 files changed, 62 insertions(+), 73 deletions(-)
> 
> > diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
> > index 90adbdc1893b..c3fd7589fd82 100644
> > --- a/rust/pin-init/src/__internal.rs
> > +++ b/rust/pin-init/src/__internal.rs
> > @@ -238,32 +238,37 @@ struct Foo {
> >  /// When a value of this type is dropped, it drops a `T`.
> >  ///
> >  /// Can be forgotten to prevent the drop.
> > -pub struct DropGuard<T: ?Sized> {
> > -    ptr: *mut T,
> > +///
> > +/// # Invariants
> > +///
> > +/// `ptr` will not be accessed or dropped after `DropGuard` is dropped.
> > +pub struct DropGuard<'a, T: ?Sized> {
> > +    ptr: &'a mut T,
> >  }
> >  
> > -impl<T: ?Sized> DropGuard<T> {
> > +impl<'a, T: ?Sized> DropGuard<'a, T> {
> >      /// Creates a new [`DropGuard<T>`]. It will [`ptr::drop_in_place`] `ptr` when it gets dropped.
> >      ///
> >      /// # Safety
> >      ///
> > -    /// `ptr` must be a valid pointer.
> > -    ///
> > -    /// It is the callers responsibility that `self` will only get dropped if the pointee of `ptr`:
> > -    /// - has not been dropped,
> > -    /// - is not accessible by any other means,
> > -    /// - will not be dropped by any other means.
> > +    /// `ptr` must not be accessed or dropped after `DropGuard` is dropped.
> >      #[inline]
> > -    pub unsafe fn new(ptr: *mut T) -> Self {
> > +    pub unsafe fn new(ptr: &'a mut T) -> Self {
> > +        // INVARIANT: By safety requirement.
> >          Self { ptr }
> >      }
> > +
> > +    /// Create a let binding for accessor use.
> > +    #[inline]
> > +    pub fn let_binding(&mut self) -> &mut T {
> > +        self.ptr
> > +    }
> >  }
> >  
> > -impl<T: ?Sized> Drop for DropGuard<T> {
> > +impl<T: ?Sized> Drop for DropGuard<'_, T> {
> >      #[inline]
> >      fn drop(&mut self) {
> > -        // SAFETY: A `DropGuard` can only be constructed using the unsafe `new` function
> > -        // ensuring that this operation is safe.
> > +        // SAFETY: `self.ptr` is not going to be accessed or dropped later.
> >          unsafe { ptr::drop_in_place(self.ptr) }
> >      }
> >  }
> 
> Sashiko mentions that:
> 
> > When ptr::drop_in_place(self.ptr) is called here, the value is dropped,
> > but the DropGuard struct still holds the &'a mut T field until the
> > drop method completely returns.
> > 
> > Would it be better to revert DropGuard to store a raw pointer and use
> > unsafe { &mut *self.ptr } in let_binding instead?
> > 
> > The lifetime-shortening effect is fully achieved by the let_binding
> > signature taking &mut self and returning &mut T, which ties the returned
> > reference to the local borrow of the guard variable. This avoids the
> > potential validity issues while fully preserving the bug fix.
> 
> which has a point but not totally correct as the code is not violating the
> validity invariants of references, just the safety invariants. And since no code
> executed can observe the violation, the code is not undefined. The code passes
> all Miri checks which pin-init CI runs with both aliasing models.
> 
> I only used reference here because it's more convenient to do so (less safety
> comments to write), but if the effect is that it's harder to justify the
> correctness (and apparently Sashiko got confused here), then it's not worth
> doing and I should just spell out all safety comments repetitively.
> 
> I'll send a new version with the approach reverted to pointers. PATCH 1/2 will
> be kept as is.

Sounds reasonable to me.

Alice

