Return-Path: <stable+bounces-273394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 12FhO3MyUmo2NAMAu9opvQ
	(envelope-from <stable+bounces-273394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 14:09:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EA74175F
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 14:09:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=o2Q4KDTp;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273394-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273394-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2943730078BD
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 12:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E3E3A5421;
	Sat, 11 Jul 2026 12:09:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47C25B0B6
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 12:09:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771758; cv=none; b=PNOgpcay9RDBAbJek8hstIMp9kJfVl+WpUY9lr+XUObi9vSeFVtgTurfQtmpsIddmFD2H8dJ0me6MRaYLpgmGIFjGceOjMveI7sJEMV+fswV301Fc5m1KxaHhgbENblecRokjrHinmt09M1z6M3B9yh+kyPAM82SJLsfoczi8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771758; c=relaxed/simple;
	bh=NTQUTiOY6fWGJY+qqToUuWf4suAV/H32seKG+A+pnBk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F0TLpt2JIH582+0Jr7nqiL2RC51d4kzqjeyhmEZZQSbhVVDwPMwqdECBzQG+L5WzTybJfyoiBs/+GjmxP0U0C58Nco5SrltGupxGg3Ohdx6dKNn5rsJw7TABDjnLk0ChHBuiupaRcK+cDF5/8wuc1rHWN7/AE1ptw6pgAaKAVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2Q4KDTp; arc=none smtp.client-ip=209.85.221.73
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-473e18559b2so971107f8f.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783771755; x=1784376555; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZECiUz8iXrro/+1KsBtJNmjhFi5kdYHy3t1PHyk/II=;
        b=o2Q4KDTpENi27OJyUXz76+iAkjyePGLqWtRfSeYbujgi4tC0dYixHvcNwY6aI0dh/R
         P3KpHuNzOgT5au/9VLQawB8WxNA2xIqXGzGqpnVew9P1Dl+sZ904l3dJKPPiwUuABVYW
         uMZ8bclaG9bWCXfV//+EKw983xCvg4yZWlCBXGtLmI3IYP+2zQnQHiEDNjGKd0XeGJVl
         4DkXnNK9g4qQi+E/1ZAwuAcJkvSH8B5hKNpxSgEm03C5qoWmap/gUmtw64/SRyU4qxrL
         Xjctgu5Zw+/nRPiTidPt3jiVkWlo09Cms8Jh45Gmp+jg+ihhan6O/nkjf+ebV62fOx3U
         RXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783771755; x=1784376555;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rZECiUz8iXrro/+1KsBtJNmjhFi5kdYHy3t1PHyk/II=;
        b=YbjYUbJIwF8Q3rSWPi1xHvGWxz5eNQ7bfHCXCB3vh0B/SbqiwgLInXULsEL+dID7qa
         046/xI9nFqgkCLIynTmO29iCp2riKLL9+hGbHM5JR5UmI4ksg5HpaUCBOyk/HyUSXHB1
         aviu0Q64mwfdzgSSNl5H/bBAUkvof0HZFTfoDqaoLgn3YAhGtH2oeLeLVSThOLVCjN+F
         gt+O+CiHZJ8MbwwVWv7HDCsBV9XnfRoMAR1cIXAVeoHLZLn6PJw+6jPhja7EyItxFkXw
         QbdtXY3oBbU5ZHIm5CWdgJX4f7eRKiamewghRQrZE06AMRj8QY9QfheG5DxbJaZC4BF6
         jUtw==
X-Forwarded-Encrypted: i=1; AHgh+RrQUAEOOv53jgDP1Nk+EPBdRSLaCcKLLukLPCwa5i9Lb0bTeU8L1uRYzNQTFlwgaelmEPXDwdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNn+5aCQT/eqravrCo1AI/BMb692Npcwb0wYAOgiznrJdwqfD
	LpaVNZ/3fwGWakoQBzOQrZnXyhI35OZuVCirJlvz7U3x9e3gAJz7rvqwdZpGPWXEXVhDm/wAc9A
	G9pjbI17R0la2TGakKg==
X-Received: from wrwq13.prod.google.com ([2002:a5d:574d:0:b0:472:3bc6:772d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:588e:0:b0:47d:ee7d:c125 with SMTP id ffacd0b85a97d-47f2dce2cc2mr2261213f8f.40.1783771755149;
 Sat, 11 Jul 2026 05:09:15 -0700 (PDT)
Date: Sat, 11 Jul 2026 12:09:13 +0000
In-Reply-To: <20260710173252.191781-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260710173252.191781-1-ojeda@kernel.org>
Message-ID: <alIyaWz_32wZc2rK@google.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function for
 Rust 1.99.0
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, rust-for-linux@vger.kernel.org, stable@vger.kernel.org, 
	Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273394-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,garyguo.net,protonmail.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,vger.kernel.org,suse.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:ojeda@kernel.org,m:jpoimboe@kernel.org,m:peterz@infradead.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:rust-for-linux@vger.kernel.org,m:stable@vger.kernel.org,m:petr.pavlu@suse.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 500EA74175F

On Fri, Jul 10, 2026 at 07:32:52PM +0200, Miguel Ojeda wrote:
> Starting with Rust 1.99.0 (expected 2026-10-01), under
> `CONFIG_RUST_DEBUG_ASSERTIONS=y`, `objtool` may report:
> 
>     rust/kernel.o: warning: objtool: _R..._6kernel12module_param9set_paramaEB4_()
>     falls through to next function _R..._6kernel12module_param9set_paramhEB4_()
> 
> (and many others) due to calls to the `noreturn` symbol [1]:
> 
>     core::panicking::panic_null_reference_constructed
> 
> Thus add the mangled one to the list so that `objtool` knows it is
> actually `noreturn`.
> 
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Link: https://github.com/rust-lang/rust/pull/158796 [1]
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Link: https://lore.kernel.org/rust-for-linux/alEBInX9gD1M5NAr@google.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>

