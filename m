Return-Path: <stable+bounces-224709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF7zIzOSsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:02:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C4266EAD
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9310300E1B8
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DDA3CBE79;
	Wed, 11 Mar 2026 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IVe4iYlh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673CC37B029
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244970; cv=none; b=pprE+7E/FiH7AcZYRNunxf1sk+u4V3qkF1EzbP2he9YOkzWC8NI1qffx+/JRVnTGuMraSLli2BPYwhfP82rcgG9ILxAc/n3/LNFktoRJjBIMN2z81hXPCtrYSY/jKTlInNiMrL8dftXtN9g/gJbEVBT05dyRQ4ifJgJ8b3fpub4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244970; c=relaxed/simple;
	bh=bmjrHpFJ+o4At4T8bPtvGMBjQTbocjYbPF9mqE1+xew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T4KjcbLikDQpnYBPkSR1WALhuehYCNGD+F1KuKhZ5CoC1QReqALPbWUcNEkgs1jKsm2iMK3ybkYaqGlddHCbqX16KZWG/ZWxsh1e8nxzXraoxiRwndZPeXz8WxEl8CZSjmGnc5E+mLjp6R+fM2K/qYSc3SPOvdBjJyXluxZx9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IVe4iYlh; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-66142e571c9so7055287a12.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773244968; x=1773849768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2byL9779uGNK+rD0Ul8vhdNJW5F3S+57dqzGzFKDnmM=;
        b=IVe4iYlhcwZUmW67TNYdrC46r8TdFtBswHQwjOZmagUnE1ajqPkv7NpTSMcsoBT/rN
         hGvqaTdt8Y0eRGPcpYR82Oa0nL0Kjd2S9jVJt9+BdvsAJUtiZ6tqy4Y+sy5Uu5CcEi1e
         bWkztM8PsU3N44pH1OfpgAlV+AMv7LNNSXo74UMSpS5IZn0r64941pS+WBWvC/i1ThLN
         Mt6mdrJ1fSfhgazZfswi48XlDwXXyklb/p8HM2kV2YCDceGUsE2DjIaIrI8tjHxm5EOb
         Gn1+7wWCRuqkI9xkEPINTgPO0IAC4bwFgbL5jfi9AgKedeSOSK/Hwo37hqFHORCNRjY/
         rq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244968; x=1773849768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2byL9779uGNK+rD0Ul8vhdNJW5F3S+57dqzGzFKDnmM=;
        b=udLuovzo/zoQdqZtZ7PxJ9pFDmOUwJDRXINOzogVEMS8hNaWCDeip4JlFYxQC/Avef
         dxvxVrWaCJRH6x2u/9t3e6pWaY6aFep5HVRoC8AIh973EEJdjvuJkndcVCO/SP7yR/l2
         kc0FJVhPoitOizVuOOIk3gr2Ioh59QlrF2AxW1N6KHClDxpUXPlhvQH0v100o9DGymXY
         hqV7q2N1k9PG7nr1JlaxP1JtcOPSG5s4C3mheqa3LRVT/5JHlVaZM467up3m7eLZQvJr
         oVyTjCuozUvaxfAUudYHqyZ0va/Emv7qbzB8j90rsjvEmBO4uEYuI9AanRrgBAmPQImx
         PEfA==
X-Forwarded-Encrypted: i=1; AJvYcCWs7fUkOVLqGX+h0xt8Sm/X+nIa5MJDn6kjjgqYFWNBFPmUsBM8QIMWqcH1dy6waPd175CYu2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy9PG0tSeDoPod2LIjeXpwMebgIp1VDM1bqwBCDVX+Jotzk/qD
	y4edvwAeolXoC+KcoRpezoPXTST63CY0a104npCX17pmpREDJQnUchGPKCYLIsVbw9eEJNYe0j1
	TrnOIFDcGmrxPE3l7oA==
X-Received: from edgi10-n2.prod.google.com ([2002:a05:6402:a58a:20b0:658:6265:19e4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:84e:b0:663:4c4:e63c with SMTP id 4fb4d7f45d1cf-6631a5e4b58mr1375889a12.25.1773244967553;
 Wed, 11 Mar 2026 09:02:47 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:02:46 +0000
In-Reply-To: <20260311105056.1425041-1-lossin@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311105056.1425041-1-lossin@kernel.org>
Message-ID: <abGSJlUHmPEC1kJT@google.com>
Subject: Re: [PATCH] rust: pin-init: replace shadowed return token by
 `unsafe`-to-create token
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Tim Chirananthavat <theemathas@gmail.com>, stable@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224709-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[garyguo.net,kernel.org,protonmail.com,umich.edu,kloenk.dev,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC8C4266EAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 11:50:49AM +0100, Benno Lossin wrote:
> The reason we initially used the shadowing solution was because an
> alternative solution used a builder pattern. Gary writes [3]:
> 
>     In the early builder-pattern based InitOk, having a single InitOk
>     type for token is unsound because one can launder an InitOk token
>     used for one place to another initializer. I used a branded lifetime
>     solution, and then you figured out that using a shadowed type would
>     work better because nobody could construct it at all.
> 
> The laundering issue does not apply to the approach we ended up with
> today.

You could always make the unsafe-to-construct token generic over a
locally-defined type to avoid issues with laundering.

> Reported-by: Tim Chirananthavat <theemathas@gmail.com>
> Link: https://github.com/rust-lang/rust/issues/153535 [1]
> Link: https://github.com/rust-lang/rfcs/pull/3444#issuecomment-4016145373 [2]
> Link: https://github.com/rust-lang/rust/issues/153535#issuecomment-4017620804 [3]
> Fixes: fc6c6baa1f40 ("rust: init: add initialization macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benno Lossin <lossin@kernel.org>
> ---
> This is not yet a soundness issue, but could become one in the future
> when TAIT gets stabilized in a form that allows the problem described.

Let's just land it now regardless.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

