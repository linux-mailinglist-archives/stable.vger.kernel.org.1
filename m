Return-Path: <stable+bounces-216845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG0WE5GFlGlBFQIAu9opvQ
	(envelope-from <stable+bounces-216845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:13:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF4B14D7AF
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 16:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FF4B30247E8
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506136CDEF;
	Tue, 17 Feb 2026 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnqbbF+9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64336C0CF;
	Tue, 17 Feb 2026 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771341194; cv=none; b=ag8ekIWSVcQw6zEOnmg4QC2+uVkaYfUdfihsG7WTbCc/lKgTGe9AmxHVOl0ROKtC3d9sE5Mfjb2fgBURxpTSEcVnLpOHvYMnr7RbEDHkyjgo/aK1F4B+K1tHW35N+9qaRB7OkLmdWSTQSJp4Bl8GmEG4hBkA5dBR9c6eYbRM+m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771341194; c=relaxed/simple;
	bh=q4lpe0QHbE4GGbcGYoiqsGdbAX3UVPzDsH/s+Fwz5I4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=a294EuQ870CC4KctUAFin2CMGQbfhOHovIWDWCVJ//6XiMsKoa02+OAUkc3LFCH41k9OydhYECe+i2SsmqGNfyE713ikhPhtpIpB6e0yf0fzSu3JSGgIh3sgYQ++iaD1HfilbEtA/YySFvS8z1vIUtnM4AzLFb1H1+8MvuGJnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnqbbF+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28159C4CEF7;
	Tue, 17 Feb 2026 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771341194;
	bh=q4lpe0QHbE4GGbcGYoiqsGdbAX3UVPzDsH/s+Fwz5I4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=VnqbbF+9M1KozvnJynWTRyiwnmd/bz3qGOF+wNTRpsj/o6hVklSmzdEwa+L5Gq0SL
	 VMauwQDNwgydoo5TUdMDL+5/ENQvyE6lwgJKcQrW3Tpr7PpBQaYrc8NAPdh+Uw8Sxq
	 quzTc9Z83wPZVS0BQSCIOiYX0vdT2vaEO88/9weIzA3Qm70l6OcVE3BtI+HldcrbHm
	 qAxZUU8xowd9rWZe4oaaJ3RDzctOWV1r8QNXafUrW9yNSKOULwgLs3RQRNJf4kZwwN
	 7RqvjVOXbBuYrSgjDyNsT89aig5ykpzYwPyx/DTj/G/4FRHgl4ftx0NdZRBxwX58ow
	 7xd2KJRVaaYyQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Feb 2026 16:13:09 +0100
Message-Id: <DGHC1OLDIXC7.Q4IAOOSMHIY@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Carlos Llamas"
 <cmllamas@google.com>, "Jann Horn" <jannh@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-mm@kvack.org>,
 <stable@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 1/2] rust_binder: check ownership before using vma
References: <20260217-binder-vma-check-v1-0-1a2b37f7b762@google.com>
 <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com>
In-Reply-To: <20260217-binder-vma-check-v1-1-1a2b37f7b762@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216845-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CF4B14D7AF
X-Rspamd-Action: no action

On Tue Feb 17, 2026 at 3:22 PM CET, Alice Ryhl wrote:
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

I suggest to use imperative mood instead.

> C Binder performs the same check in a slightly different way: it
> provides a vm_ops->close that sets a boolean to true, then checks that
> boolean after calling vma_lookup(), but I think this is more fragile
> than the solution in this patch. (We probably still want to do both, but
> I'll add the vm_ops->close callback with the follow-up vma API changes.)
>
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: Jann Horn <jannh@google.com>

If you have a link, please add Closes: after Reported-by:.

> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
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
> =20
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

Here and in a few other places, missing markdown.

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
> +
> +    vma.as_mixedmap_vma()
> +}
> +
>  struct Inner {
>      /// Array of pages.
>      ///
> @@ -308,6 +329,16 @@ pub(crate) fn register_with_vma(&self, vma: &virt::V=
maNew) -> Result<usize> {
>          inner.size =3D num_pages;
>          inner.vma_addr =3D vma.start();
> =20
> +        // This pointer is only used for comparison - it's not dereferen=
ced.
> +        //
> +        // SAFETY: We own the vma, and we don't use any methods on VmaNe=
w that rely on
> +        // `vm_private_data`.
> +        unsafe { (*vma.as_ptr()).vm_private_data =3D self as *const Self=
 as *mut c_void };

Maybe use from_ref(self).cast_mut().cast::<c_void>() instead?

Please don't consider any of those NITs a blocker. :)

