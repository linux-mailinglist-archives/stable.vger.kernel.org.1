Return-Path: <stable+bounces-245159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ja/JVqTAWrsegEAu9opvQ
	(envelope-from <stable+bounces-245159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:29:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F29FE50A1B0
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45EE9304CE9D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078583BAD9F;
	Mon, 11 May 2026 08:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPmvJQ7L"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B203128A2
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487719; cv=none; b=WFxFAzXI0AqQyk2p4VroFG4C6iVPTHKW0A3mUFu8GPRB8QoJMffhRvRCW6RwrdRyFHSJJrPbFrVMLUT3RLF+zsphWyMEqV37muLk9rCabISbQzgX3RA8hAkunu/BKrVolmUi3gpEQrP1tFRUJilng9cFw3Qs2th0RHpn7+jXBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487719; c=relaxed/simple;
	bh=xxGTlnGfhdKoOL0DYOX91EbPCenUZRvvCeEUnu1R6q8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MN+oHwnVM3Q+E9IX231gdHnp6g02eNTvf8cxH5sZ8o9bpLK58DPsqVFfk+YQtxx3IxFjRGv6C5wLoj8AY2EvaoU0iC3DlkZHoxPbdMdCann1TIJ78AYhHiHNlM0f9J8Iy9M1/hfwZWhjtHOoJt5/Q6RUvDFlEIYBjzbq8G8vn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rPmvJQ7L; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so2689936f8f.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 01:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778487709; x=1779092509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5H14eAjov8dp7zxAeJph/4QZj8xDXhb6FCjRwRisaFI=;
        b=rPmvJQ7LQQi9j2hlSQT9pGswRpRQJqeR+qti2H67QNYONDa6yr7oqg5j7LRQVcbkFP
         2zkaIDmPEM87I/gU9ag+/D2AN494+CQu0rKwLrk6v9UPW8WZgofS91REJNsLAwPcdX8k
         if24c0eaVnW4rbZwHQjwB19TsfnIiIBW465jwDOST8WM1KRAtkx+cfIdyGvqEPGgJ5MF
         TzLgPSgN1JkDH/xe8wgSiQ2iSZ/IqrQOIya5c8MO6br90OxmxgmmDAd9MxVX5Bl0YaGB
         vqnr1Z9LEFckkeV8x655f8tpmqezK2KSyU/aLsdNnWv+0NWLauOYGROEgeY0cPermpgS
         ti0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778487709; x=1779092509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5H14eAjov8dp7zxAeJph/4QZj8xDXhb6FCjRwRisaFI=;
        b=pE579ImqpZaxNZbN5IFdJFJO1pSBy62NoxX0/E7HDU8ootmIJ7hwOZNXkJynW9bMsT
         WTf9wbGAkFN4oQazH/r/28LXDyJJgp1E3NY8dIuGUn6wQBBiKOVe5t43B5gZf3IAiuHl
         UTRI4VFMZDYAB8uCcIbiwpwn83vfJ5Lkz0DeErjKLjKtq4bPEpJYN+vHCY/H39ExT1LF
         kpSJrekIbBhbCas3MoIDWcYU3ts4rml8cCB+Z9q24odTo2e2KUn4V1X8MT5AFZWPfmfb
         i+ibGzDLMgqiiB3f/eqUtE2TfaTL9xFT13/KOHTPA8Pkwiw/c3GPXV5r6bmLncKfajCb
         XBow==
X-Forwarded-Encrypted: i=1; AFNElJ/MydMzYoMvVt93H885X5QBZyQGCO5MQFv05GpWMbxWY3cSs05wtBuLI3bFExfx2ooajNbHiJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOTgtM2pxHZPaf4Qc9FiBU5vuaVuDIwO3WfvGxuuZtOTaiPQQ
	PtKyMYuarS8voVqsRmqQi/FwiIuwwTuDBmNGvqavp/T/P8WKpgrvrKvCUfQQ2EPq7tJlHgoqLQ2
	jj3G34orX7yRmF2jhzg==
X-Received: from wrqp16.prod.google.com ([2002:a5d:4590:0:b0:43d:6f59:cbd0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:288e:b0:450:e5fd:e1a1 with SMTP id ffacd0b85a97d-4515b05728dmr36098093f8f.3.1778487708994;
 Mon, 11 May 2026 01:21:48 -0700 (PDT)
Date: Mon, 11 May 2026 08:21:48 +0000
In-Reply-To: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511-arm-avoid-rust-with-kasan-v1-1-24d55f4a900b@kernel.org>
Message-ID: <agGRnHVTLiwobb9W@google.com>
Subject: Re: [PATCH] ARM: Do not select HAVE_RUST when KASAN is enabled
From: Alice Ryhl <aliceryhl@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Christian Schrrefl <chrisi.schrefl@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: F29FE50A1B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245159-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,kernel.org,garyguo.net,protonmail.com,umich.edu,gmail.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 05:02:44PM +0900, Nathan Chancellor wrote:
> When KASAN is enabled, such as with allmodconfig, the build fails when
> building the Rust code with:
> 
>   error: kernel-address sanitizer is not supported for this target
> 
>   error: aborting due to 1 previous error
> 
>   make[4]: *** [rust/Makefile:654: rust/core.o] Error 1
> 
> The arm-unknown-linux-gnueabi target does not support KASAN, so avoid
> saying Rust is supported when it is enabled.
> 
> Cc: stable@vger.kernel.org
> Fixes: ccb8ce526807 ("ARM: 9441/1: rust: Enable Rust support for ARMv7")
> Link: https://github.com/Rust-for-Linux/linux/issues/1234
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

I would probably suggest moving the conditions out to a separate
RUSTC_SUPPORTS_ARM config option similar to what I did in commit
d077242d68a3 ("rust: support for shadow call stack sanitizer").

This way it will be simpler to adjust this logic when the target obtains
support for this sanitizer.

Also, we may need the same change for CONFIG_CFI too.

Alice

