Return-Path: <stable+bounces-217310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLreK3vrlWkXWgIAu9opvQ
	(envelope-from <stable+bounces-217310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:40:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6486157CEE
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5319300DF71
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F9344D84;
	Wed, 18 Feb 2026 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLe3U+hy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424E31D371
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432786; cv=none; b=ijCUWxn8ehbbjk1WKDj82Zi+6Ep/YeU3esy49m495AR4LC2nbiQLlXlxorrN5h6iyRUigSrvAYrbTJjY69vQUglS6TyY6giKeTpIt5YIQ70Lty52OUk8nBonQNCgc3sYUfVhhQdB7A2xISou4B8eR9Ol/3xUz7b+2q/SroD+iNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432786; c=relaxed/simple;
	bh=r8ir3WPu7EOGXd+9anzul085BmDhS+72++kZpDpn9pM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VnZSBtyXUnpkm+ZeFsF/kv+MB9oo+9VoPBDy2RJ02xsuehzN9yJ5CDyow4aA13EeXs+n4ejWzdCaZqJPrw8qbD1PVEAUdCYGq5lNb0EZS/je0lsvtI3pSSEHThjKD38bcVR+P5nvUtpQbEsWfZi9EPpoL3DPQyoR7zIstqaE+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLe3U+hy; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48069a43217so260535e9.1
        for <stable@vger.kernel.org>; Wed, 18 Feb 2026 08:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771432784; x=1772037584; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0m3FE3NLfAZuYbLihlpXnQVS0zlKL81UVUgeOf6oH6Q=;
        b=lLe3U+hyajgtfSb2NPBuihimkkrSRWGR0s6VMYvpvSIq0xT+ohzRCe8/dWmW9xJek8
         RNnkxKfWqyhVM8MLPkE5DIUxYEOtWsp7PH4F/tGuItPRALtRQzG6UNvmaHNmkSbxSn9E
         qGo07r2d/SF8mtnCqvpuzzQm61FMfRqGIFZPkHk+OAoCflRlx154+eremW61l+0PIDpP
         8kl61hhpXmHBEy/oFBlbOQ5cOF2gPA9ZHbKCMCffdqBTOyQTX/uCB/vLFsIPg1wDv/pz
         tpsZzMQnxE7dJ+bolgsUzds1lIZBuu1xn8pcQ9xgQ0WuIt3o/gcTG90015xEq7d0cNfl
         fVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771432784; x=1772037584;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0m3FE3NLfAZuYbLihlpXnQVS0zlKL81UVUgeOf6oH6Q=;
        b=rA+WKEXg60V7hoc31F7vLVJHOlaI7p+N3WZZwySNlBV4JuZY3ObAZZhc2dG5ypdTD5
         NyfFSN5QdGjdNinDGk0kG9C+k7JBn7f3GmX91P8TNaEDyZ6GBanJy1nsB28trcwlPYoy
         0cb4QhDRS9MWykYa1cU79hnWzIqKqDri3Na9kwo6xMHikgNQaZrAQ4xrvYF1/y4A5Clg
         tnnBxAvqxLQqRXuBQlOGVJGNotubSgUZVNbpeOSjGQQQaBqPkMlA+qdSaz4qe5ConOV6
         gg/zc52sQ3wH/V1eh30dlU/s2ekL1mjz81/VgIKJMRp0we4T8vijQTDsyyTsNKgMctq3
         7zYg==
X-Forwarded-Encrypted: i=1; AJvYcCVCPG0Vx5cPvYuva1y4zmvGUOz7FffYtWh+Ek6o5dMRE5NP8uPcbb8voiqLbkrHkqywAqEgQ9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzejsin6qbQkynvkk9otq/G0VfoTAkhBbL/vBVmlROw8wByANxK
	tcFfIlbSV/cHdKQgw5LebqZzxNoJDx8WhAtUljQh4cdwJGdGlbNXIN4VJAn8h9h/YJxKw0xDvWJ
	+9Ijw6HH+ZDUD8beMKQ==
X-Received: from wmben5.prod.google.com ([2002:a05:600c:8285:b0:480:69c2:3949])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8444:20b0:483:7813:90d8 with SMTP id 5b1f17b1804b1-48379b8c02emr192248545e9.1.1771432783657;
 Wed, 18 Feb 2026 08:39:43 -0800 (PST)
Date: Wed, 18 Feb 2026 16:39:42 +0000
In-Reply-To: <n2nq4aypj6hgafy36z2527tyvetgcypcrn2v3hvs6dws2mtwnl@jiszbxj4mrog>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
 <20260218-binder-vma-check-v2-1-60f9d695a990@google.com> <n2nq4aypj6hgafy36z2527tyvetgcypcrn2v3hvs6dws2mtwnl@jiszbxj4mrog>
Message-ID: <aZXrTlNHyW-HZs1C@google.com>
Subject: Re: [PATCH v2 1/2] rust_binder: check ownership before using vma
From: Alice Ryhl <aliceryhl@google.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Jann Horn <jannh@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217310-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E6486157CEE
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 10:54:46AM -0500, Liam R. Howlett wrote:
> * Alice Ryhl <aliceryhl@google.com> [260218 06:53]:
> > When installing missing pages (or zapping them), Rust Binder will look
> > up the vma in the mm by address, and then call vm_insert_page (or
> > zap_page_range_single). However, if the vma is closed and replaced with
> > a different vma at the same address, this can lead to Rust Binder
> > installing pages into the wrong vma.
> > 
> > By installing the page into a writable vma, it becomes possible to write
> > to your own binder pages, which are normally read-only. Although you're
> > not supposed to be able to write to those pages, the intent behind the
> > design of Rust Binder is that even if you get that ability, it should not
> > lead to anything bad. Unfortunately, due to another bug, that is not the
> > case.
> > 
> > To fix this, store a pointer in vm_private_data and check that the vma
> > returned by vma_lookup() has the right vm_ops and vm_private_data before
> > trying to use the vma. This should ensure that Rust Binder will refuse
> > to interact with any other VMA. The plan is to introduce more vma
> > abstractions to avoid this unsafe access to vm_ops and vm_private_data,
> > but for now let's start with the simplest possible fix.
> 
> You probably already know this, but there are a list of ways we can
> ensure the vma is stable, listed in Documentation/mm/process_addrs.rst.
> Check the "Lock usage" section.
> 
> I'd feel more comfortable using one of the described ways to maintain a
> stable vma instead of rolling your own here - we may break your way by
> accident, or it might cause issues with future changes.
> 
> When do you think we can move to one of the standard ways of ensuring
> the vma is stable?

If you're referring to the fact that the vma can't change while you hold
a lock, then that doesn't apply here because this is about finding the
vma again from an ioctl or shrinker callback, not keeping is stable
during a single function call scope.

It would be nice to get rid of all this special mm logic in Binder,
though. For the vm_insert_page() call from ioctls, we can replace it
with a vm_fault callback (pending perf analysis). I have no idea how to
get rid of the zap_page_range_single() in the shrinker, though.


To give a quick recap: The basic idea behind what Binder does is that it
maintains an array of nullable struct page pointers. Each page may be on
one of three states:

1. In use.
2. Not in use.
3. Completely missing. (Access is segfault.)

Accessing a page in state 2 or 3 isn't legal. Pages may alternate
between 1 and 2 in very quick succession, so for perf reasons we do not
free or unmap pages when they stop being in use. That happens only in
the shrinker callback, which is when pages are moved from 2 to 3 by
unmapping and freeing the page.

Binder explicitly calls vm_insert_page() to move from 3 to 1 (from ioctl
context), and explicitly calls zap_page_range_single() to move from 2 to 3
(from shrinker context). This way, the vma reflects Binder's internal
struct page array at all times.

Changing a Binder vma after creation is not really supported at all.

Note that vm_insert_page() is called from the ioctl context of a
*different* process than the one the vma is mapped in. That's because
it's called from the sender process, and the vma is mapped into the
receiver's address space.

> > C Binder performs the same check in a slightly different way: it
> > provides a vm_ops->close that sets a boolean to true, then checks that
> > boolean after calling vma_lookup(), but this is more fragile
> > than the solution in this patch. (We probably still want to do both, but
> > the vm_ops->close callback will be added later as part of the follow-up
> > vma API changes.)
> 
> If I understand this correctly, setting the boolean to true will close
> the loophole of replacing the vma with an exact duplicate (including
> private data and vm_ops) but with different write permissions.  I assume
> that is why we want both?

No, Binder clears VM_MAYWRITE in mmap so you can never create a writable
version of a Binder vma.

> > It's still possible to remap the vma so that pages appear in the right
> > vma, but at the wrong offset, but this is a separate issue and will be
> > fixed when Rust Binder gets a vm_ops->close callback.

The main thing a close callback would give you is ensuring the Binder fd
becomes unusable once you close the vma.

Alice

