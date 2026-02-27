Return-Path: <stable+bounces-219996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B8vNgXqoWmSxAQAu9opvQ
	(envelope-from <stable+bounces-219996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:01:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9D1BC3CF
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF3F6303AF16
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844FF3859C6;
	Fri, 27 Feb 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZCIOjRq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241C8345736
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218882; cv=none; b=mYSnRcV/qFS+l3yHZmLKB2u5xkll8UyEY3KaEMSzFymMm7grI5Ovcy4rCb/rfZrgKR3SiZD1EVWhOJzeDM2Bf77jXFKMKn/ygs1NQXH9tRrAES0h+0mo6pEU9n5uHcPoT+l4jhRo+2MW3QusUaTN9WSnAxi/uCrNtoqqtvEckg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218882; c=relaxed/simple;
	bh=FJ5/Y7lkvMiZD3996h5Kzz1gx0aNl94jykd5wUZUaSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vFa1B4hx/wNVndgNpctLc/cwrlSN93hoNvgGuIRSw54E6vOuLB5wbOzoayltekxNjab1hrHbUQnsx+75ik3XqSnkYHGBQ9+o+dtPGJt+i4lnXNVCwJw/MttKNtcqUOf6wmd2QB2Ya0dtMV70MkxKLzNcQdqQNHBEOJcREX6YzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZCIOjRq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837a718f41so12097765e9.2
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772218879; x=1772823679; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z76+M/HerVegBYFMUlZFszGzoRv/Jzqi5XqbM2psUic=;
        b=FZCIOjRqXkQarF3Xp7l2RSjcateE9lJNmv5MZ21MTpHih9YPZisuzCdZE0NGXTw+ru
         ou/a6ZlhP1zQUuPlMok0SrjdkWtU//IHBjNPfVUwfJhKVHuw/0+LXecEQjSYtQmWZifQ
         jNF2swb2cOiW6nAzi6ET+e9kviJpX2/JPy48jNUDl+meNxHQvNEfN2PvbEoJRTolX3/i
         H/9fXJAuNSTCICBBqdd1W2lCLeIEg/w/p5/qnSghqdrrag8yfltIaN5pMBBqq8VTdmat
         8/zyw/NSnUoy7TT9Vsz/qcWvpdYk2s4B6yvp1r9dHONL5hN7LewPuBNvP+IfbHYHzlYy
         PVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772218879; x=1772823679;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z76+M/HerVegBYFMUlZFszGzoRv/Jzqi5XqbM2psUic=;
        b=aS30DSqL5zoUR1aan+MyqPnJRdTk/+55MoXRnb7tXGrWq3TtTniYvtOr7P47iuOtrw
         4gu00gMAi1xu94nFGmdKp2Evfz+vLJeTRDsuCQVDFBYDkSJhek/F6kWKQDY6hZcVZIVO
         n0cb3ewmRL0EEWIsjHTBr/Tl0fL1hDpRzyFQ3NAxRRJ1YDc3XP2b3de7rSMwZUTezU4U
         7uDmOUxRTULup4VWlpK+6Gx/Vm1fDp+umPI9B16OnSiHpAvaTYicdR0/1g0N9EdnuEAA
         a4i9vVa9VzF8S5utrbDyh00TDy+dqiIWePKVJWb12k2nvzyIMrfZiyZU3JKP7x5oCcq8
         U3rg==
X-Forwarded-Encrypted: i=1; AJvYcCX4JnrsvNEa6cKb3HvYXGxKbUfT+rCBFjkvMo+kFTHs7osE8Z34pc7L1KLfsedKdgYO/rSSNBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznFCNLHlsuRKQVlRZhIAxioP2CnsfbRijLXw3ZADmPtYU4WUHz
	jPoaHSYkyM48YyRpHkVgAzBuhQyL2BzGY5zdMZsqXOF+LX494QEVojYtzwlITxaJkqnnZQxoMf/
	H28yymUNgJNu2oiJ+lw==
X-Received: from wrbeh6.prod.google.com ([2002:a05:6000:4106:b0:437:6c0a:770e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d12:b0:483:9cdc:8ac1 with SMTP id 5b1f17b1804b1-483c9b9eb7amr56134105e9.11.1772218879316;
 Fri, 27 Feb 2026 11:01:19 -0800 (PST)
Date: Fri, 27 Feb 2026 19:01:18 +0000
In-Reply-To: <aaHPs-nULPEt_wJB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227-create-workqueue-v3-0-87de133f7849@google.com>
 <20260227-create-workqueue-v3-1-87de133f7849@google.com> <aaHPs-nULPEt_wJB@slm.duckdns.org>
Message-ID: <aaHp_pGBxA4pNiXJ@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219996-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BD9D1BC3CF
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 07:09:07AM -1000, Tejun Heo wrote:
> On Fri, Feb 27, 2026 at 02:53:20PM +0000, Alice Ryhl wrote:
> > When a workqueue is shut down, delayed work that is pending but not
> > scheduled does not get properly cleaned up, so it's not safe to use
> > `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> > restricted `enqueue_delayed` to static queues.
> 
> C being C, we've been just chalking this up as "user error", but please feel
> free to add per-workqueue percpu ref for pending delayed work items if
> that'd help. That shouldn't be noticeably expensive and should help
> straighten this out for rust hopefully.

I had been thinking I would pick up this patch again:
https://lore.kernel.org/all/20250423-destroy-workqueue-flush-v1-1-3d74820780a5@google.com/

but it sounds like you're suggesting a different solution?

Alice

