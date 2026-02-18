Return-Path: <stable+bounces-217297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOYdEObClWmNUgIAu9opvQ
	(envelope-from <stable+bounces-217297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:47:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A26156D3F
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 14:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 517E1300D4C5
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66A32860B;
	Wed, 18 Feb 2026 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9oHy2ne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116428B4FA;
	Wed, 18 Feb 2026 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422426; cv=none; b=OYwfJv/MNwa8XMmH8rjaLjnyZjLi5nmkcHq3gwVv4/r9ds6TNtlw1vMD/Igj/awdO5ESOFjUZHXySq/MFrFYP+bqUmIAp+UINDoUx/kgfAGm8Pt5ZJ6s9F0WM3ufNvlOe1gSYInUraDDpfPbahpWU5PUmOJjGftVwiklIgOOsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422426; c=relaxed/simple;
	bh=g7xLnbWUtNkSyUhaZry6Tmd7Wk+eR8gm83r0+hOi7tE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=r6ZSGvLKLtmi1wrYS7msgjgupi0w+Y1Qi6tjuCs354JALZ8lGj25ZeG/pRj5rxvbLHHhF1O5l5gxT3uAEqaIKoDTdaldNscMUvlDNeL0i8JuFgtxheCUXbocwqsggdES1yGuG1dEH523E5Aq+oqXX+ocMf87EDkfHT5KTtCugiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9oHy2ne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985C9C19425;
	Wed, 18 Feb 2026 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771422425;
	bh=g7xLnbWUtNkSyUhaZry6Tmd7Wk+eR8gm83r0+hOi7tE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=c9oHy2neizExuvudX1M7U/XiymsKKkRPxTyGQH1tkHRWaUAOr7Qk+TBq4VUY2UOqc
	 O2VQA+6znhq+PGkCC8cBTQBwvxu27JzqESUXCOOYy8DJZ+GO4ox3e95HPDoNcRx1Tt
	 ZUpU5E21uFN069r2rGSKYE0pC3TGD0V8c2n4wWqiX4dRSfCQZKF7fYyY0WDt2YOlht
	 GWjU+o3BOjBHOXIHwdKW7EYYhk0RaRW47OnYIYuGASBV3Rcify/Mqs38SSYGa9IBEF
	 et5sP/x6FgfdFaROF47WjkZmqWDUSkIWzlqEUNRVrjJyyJ5fbymPOs37r0Wbej4ics
	 4eMt/011vFtYQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Feb 2026 14:47:00 +0100
Message-Id: <DGI4U9PY3B8F.37E697MM1LQF2@kernel.org>
Subject: Re: [PATCH v2 1/2] rust_binder: check ownership before using vma
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
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
 <20260218-binder-vma-check-v2-1-60f9d695a990@google.com>
In-Reply-To: <20260218-binder-vma-check-v2-1-60f9d695a990@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217297-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95A26156D3F
X-Rspamd-Action: no action

On Wed Feb 18, 2026 at 12:53 PM CET, Alice Ryhl wrote:
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
> To fix this, store a pointer in vm_private_data and check that the vma
> returned by vma_lookup() has the right vm_ops and vm_private_data before
> trying to use the vma. This should ensure that Rust Binder will refuse
> to interact with any other VMA. The plan is to introduce more vma
> abstractions to avoid this unsafe access to vm_ops and vm_private_data,
> but for now let's start with the simplest possible fix.
>
> C Binder performs the same check in a slightly different way: it
> provides a vm_ops->close that sets a boolean to true, then checks that
> boolean after calling vma_lookup(), but this is more fragile
> than the solution in this patch. (We probably still want to do both, but
> the vm_ops->close callback will be added later as part of the follow-up
> vma API changes.)
>
> It's still possible to remap the vma so that pages appear in the right
> vma, but at the wrong offset, but this is a separate issue and will be
> fixed when Rust Binder gets a vm_ops->close callback.
>
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

FWIW, in terms of my drive-by feedback from v1,

Acked-by: Danilo Krummrich <dakr@kernel.org>

(I'd offer an RB, but I did not dig deep enough into binder to justify it.)

