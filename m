Return-Path: <stable+bounces-220001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0C1NAG7uoWlDxQQAu9opvQ
	(envelope-from <stable+bounces-220001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:20:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 696421BC98A
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 505DA3055F8D
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FE3D410E;
	Fri, 27 Feb 2026 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cl7d0obZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A409B3D3D1C
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220003; cv=none; b=gQKWahjokW5wEBBuV/UQFRaBCoHBZmY9PNuJfunD4Nwq75S359vbrJemA/vK/ZAVQSrN8rksZIHOKOHdw0uKIpq3ycIfK7rzHDNiKWRYOpT/aBrWaZ7WiO0nsktF3Z+0QNPuCmIlfb4mKdTfAMw9gwL0wyo9n3xYQa/e1g9UyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220003; c=relaxed/simple;
	bh=L8FJABVHFHSCFveVLUCxW+JYK5AyBjBR4VFqAhgVR9I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iNR47lObuPP/VoCM26o/RpLE9dkFhPcEzrBKkcirvfHXTjJHBhnu+7LGDMOR3xQMisHdIuq+297X0wjEe7PnXNQnBFTxggeEDRYXUanNrYZQFNZSxeSo5VupWYEQl+DDi4BHSlCGrYFBehWJHKvCrL/Dkc85R0g+s3BoTEJ3pTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cl7d0obZ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836c819456so16197345e9.3
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 11:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772219998; x=1772824798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WBgwzx0zzY1/PqSKldnWCeFUNyWLZOQM8NUJjdzdoSI=;
        b=Cl7d0obZjC+dnlEIxVUSlNuNlspjAbPahotYuolNpPMY6pDbh7/lWFcprc0eWp/r8u
         /Dkosoiz9/Mfk6qX6nhW+1wJITTpY1zTu1phiCH5XIs8An+Q4aM13jpBYr8/kj6HS6pa
         xZz1hF3Q1eEtF+7I4hmPG6f0TZ5XGVxdCUck5OCkDS03yTNJCzXQG3dtf20ATm6Kaqkz
         +zXuWHe5i701/RF8BU2ANKTPw9SnfjiLDClHu7KiPGOmV7hz9AR71H7fLdBUqcvMmHT7
         n37mNe9BD+b2kadx5onopL+R6lFlEsKhWYMRCm9o1M7tt+/XIlQ8+dK3OjHorzxSaBIJ
         UGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772219998; x=1772824798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBgwzx0zzY1/PqSKldnWCeFUNyWLZOQM8NUJjdzdoSI=;
        b=OCvVP9W+U54ipQdekaEwxBx3wsx0JQIXSAX8qjA1TSS3Kz9WWN+audzZRHOUc74QwA
         fvljBkPvPaV6MvkKKuJa5+G3n/nih/9Jidb7MqjZ9gKuajCWxhgonqCL+08gQjPaxp6T
         nqAEGNHS/3UbRcQEetw/+WfnEtk9ibTOXech/XpUaRG2MI06FdrYJVWzuKakfq3zHcM8
         Xkg6FYtnlIouYPYEwZ2x+RJ5GTkiw1tnHKFgQnSNbse2AzDb+TwlFxr5DuCrTVcNEGEv
         /fPqFFTSKcT+omGpSfQBUGE8qO8ES/5oeCjY95onQwCQ1a83XWdxw6GQvKmUjJMxiYMt
         sMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdYiKuWlUIBcfrwV6i07kNnvGQEeIEa3FRoLIawDUyowhGTQcihzUwnFSO0mF9iIwHp9sLyog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlCQHUBC6YPSgmbm0AOZASV931fo/6v/1PLV+CxsoJ+4ibD6rs
	xPgi9MrWQQf2woEgA6W7is1Z2MwM7GI2cY/llTPAwew0gvunHgU1vKIlC42bv1+VtQ5OZ6LRG+N
	cGowt19i+2PaHmZM4Aw==
X-Received: from wmqd21.prod.google.com ([2002:a05:600c:34d5:b0:480:4a03:7b64])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d0e:b0:480:3bba:1cac with SMTP id 5b1f17b1804b1-483c9bc55c0mr59327825e9.6.1772219997631;
 Fri, 27 Feb 2026 11:19:57 -0800 (PST)
Date: Fri, 27 Feb 2026 19:19:56 +0000
In-Reply-To: <aaHrxzWIFFUjzWhu@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com> <aaHPs-nULPEt_wJB@slm.duckdns.org>
 <aaHp_pGBxA4pNiXJ@google.com> <aaHrxzWIFFUjzWhu@slm.duckdns.org>
Message-ID: <aaHuXEO64ONKMW4O@google.com>
Subject: Re: [PATCH v3 1/2] rust: workqueue: restrict delayed work to global wqs
From: Alice Ryhl <aliceryhl@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, John Hubbard <jhubbard@nvidia.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Tamir Duberstein <tamird@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220001-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 696421BC98A
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:08:55AM -1000, Tejun Heo wrote:
> On Fri, Feb 27, 2026 at 07:01:18PM +0000, Alice Ryhl wrote:
> > On Fri, Feb 27, 2026 at 07:09:07AM -1000, Tejun Heo wrote:
> > > On Fri, Feb 27, 2026 at 02:53:20PM +0000, Alice Ryhl wrote:
> > > > When a workqueue is shut down, delayed work that is pending but not
> > > > scheduled does not get properly cleaned up, so it's not safe to use
> > > > `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> > > > restricted `enqueue_delayed` to static queues.
> > > 
> > > C being C, we've been just chalking this up as "user error", but please feel
> > > free to add per-workqueue percpu ref for pending delayed work items if
> > > that'd help. That shouldn't be noticeably expensive and should help
> > > straighten this out for rust hopefully.
> > 
> > I had been thinking I would pick up this patch again:
> > https://lore.kernel.org/all/20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com/
> > 
> > but it sounds like you're suggesting a different solution?
> 
> I'm not remembering much context at this point, but if it *could* work,
> percpu refcnt counting the number of delayed work items would be cheaper.
> Again, I could easily be forgetting why we didn't do that in the first
> place.

I guess the question is, what does destroy_workqueue() do?

- Does it wait for the timers to finish?
- Does it immediately run the delayed works?
- Does it exit without waiting for timers?

It sounds like the refcount approach is the last solution, where
destroy_workqueue() just exits without waiting for timers, but then
keeping the workqueue alive until the timers elapse.

The main concern I can see is that this means that delayed work can run
after destroy_workqueue() is called. That may be a problem if
destroy_workqueue() is used to guard module unload (or device unbind).

Alice

