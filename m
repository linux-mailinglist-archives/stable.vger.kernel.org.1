Return-Path: <stable+bounces-220003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ7OF1LwoWnYxQQAu9opvQ
	(envelope-from <stable+bounces-220003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:28:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBEF1BCC7E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC9EF3014515
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4354C3E8C73;
	Fri, 27 Feb 2026 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwg7qZeS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914E361DD9
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220495; cv=none; b=VRK578Hp/0v5ooIv/5Pivy4ZvF+8Q2W9v0GFWvesgTm15H7t9BBGUO58zxNoUawFnORjYgfXVse7W1OM6YxwY61sFU9DxSfYczZQz3jrm1w+aRD6zvdYwx2glcttlh26VgwUpooeJFU7l3qhFsrVfNqtx2/UR0uUyr/WZ+dlK5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220495; c=relaxed/simple;
	bh=HfVDmGC4fB3MiRfy2NmM8QDzL0ngy1GxNiE1UvPUglM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YNBi0VKtmpzKmlaq4sS4ZIR+nTOWI+A3gciKKE71FuAzNQzUEs4uYRxLsCwlUtz3AzHw4bjgFd/o2ua0Q22LHYmc7KjM/LBnG82eCjRYKmRCK/O9+mNzkv+CJOOxy0QnY/dOgFyRhsDPEeeqbtQ/MfLvc+UpSsNpT1PMNxkhZ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwg7qZeS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836cf00787so32436895e9.1
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 11:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772220492; x=1772825292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1HcWsQPS7f+mcem6RVU74G7Wi+GwI58L79rKUSwDFo=;
        b=pwg7qZeSJeHFvzKt9o6skkwd7BF9E0NkMset5m4FOpTOC+Ki5A4QecbY445B2Mf4DQ
         kEDnjWx+zcApBKkUXcNOVIjataP08wdFNaNVG8Y23kuT8h3DTErjOrqc+9GKh2vzNKwC
         EumL0Q8yggt21gazgHckhK981jwUwXI3RB6Dnh8aB2FlTlLNFYvTz1yUv+FHFVzOHA34
         04jwx+a5CZ4qj8kvUnxpYHj2Y0F00eX0IOpONyMCC3rMS0w8tzUxGn2FC39fpEril06u
         2hcBXY4ONE54t+Wzwy95iVFrfm7BVL7CCTOFnTVT20IrjoJvVFiPC5P+Ai4LbC+rhJdE
         6ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772220492; x=1772825292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1HcWsQPS7f+mcem6RVU74G7Wi+GwI58L79rKUSwDFo=;
        b=XoqveAHVkgY+K7hEspZjnL4q+cIi8/UEbvuPGDbOzsj9SYAlIirPi9OWBJBY6tBSnQ
         j5wh3YidwtN2+FKa/6Jp/cCb4FrWjpbFOetRiQLysZ2tqDo4Qdcn1WKmlR29wMA4407j
         5IHzGP+7WqvD3YUu3I/452C7T8ym3eHjzqLNpaimWU6yiipqCeyg5R3kd/EysVFihjQi
         R6BNkONhXzFGO3BWQg7bQaIDC8YGae2+ZatgUjwJ1aqytGbM+YatSKw7rOsgRYXZINSm
         44GuT159GCJWBVRxkvs0sR0njY1a619uyIbCUBV4CXKl5RJ4i6AZG8SzM2KbMXgxog4B
         T58Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSP0wHAVrlfWhCSdP7nt+C5MYp2lbQSa1JP5O8WKWWm4Jy8nlK9zr1g0PbfzvXm8W0I+eij9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhO6/rC486f4yaUdlLugSzKJjfVoSRO4Jy7++mVQERI8nkZsSQ
	5/cdqvMf8czgYtAOEnxhMtJ97YIuZn9rLBtVImAvCX3R7VVdP3jA3dPMRrahZpTcrmkiEn66y8E
	QhPdoNbOyrp2AnV45PA==
X-Received: from wmxb15-n1.prod.google.com ([2002:a05:600d:844f:10b0:480:4a03:7b80])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c1d:b0:483:4b37:8620 with SMTP id 5b1f17b1804b1-483c992e330mr68942145e9.10.1772220491946;
 Fri, 27 Feb 2026 11:28:11 -0800 (PST)
Date: Fri, 27 Feb 2026 19:28:11 +0000
In-Reply-To: <aaHvcvbmkl7oSFOR@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com> <aaHPs-nULPEt_wJB@slm.duckdns.org>
 <aaHp_pGBxA4pNiXJ@google.com> <aaHrxzWIFFUjzWhu@slm.duckdns.org>
 <aaHuXEO64ONKMW4O@google.com> <aaHvcvbmkl7oSFOR@slm.duckdns.org>
Message-ID: <aaHwSxIaTqLWndkw@google.com>
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
	TAGGED_FROM(0.00)[bounces-220003-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: CCBEF1BCC7E
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:24:34AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Feb 27, 2026 at 07:19:56PM +0000, Alice Ryhl wrote:
> > I guess the question is, what does destroy_workqueue() do?
> > 
> > - Does it wait for the timers to finish?
> > - Does it immediately run the delayed works?
> > - Does it exit without waiting for timers?
> > 
> > It sounds like the refcount approach is the last solution, where
> > destroy_workqueue() just exits without waiting for timers, but then
> > keeping the workqueue alive until the timers elapse.
> > 
> > The main concern I can see is that this means that delayed work can run
> > after destroy_workqueue() is called. That may be a problem if
> > destroy_workqueue() is used to guard module unload (or device unbind).
> 
> delayed_work is just pointing to the wq pointer. On destroy_workqueue(), we
> can shut it down and free all the supporting stuff while leaving zombie wq
> struct which noops execution and let the whole thing go away when refs reach
> zero?

But isn't that a problem for e.g. self-freeing work? If we don't run the
work, then its memory is just leaked.

Alice

