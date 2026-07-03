Return-Path: <stable+bounces-271719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1meGI5mQR2ogbQAAu9opvQ
	(envelope-from <stable+bounces-271719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 12:36:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB7D701455
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 12:36:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=PE9ZAjpS;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271719-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-271719-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B8373049C66
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 10:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CBE3D7D93;
	Fri,  3 Jul 2026 10:31:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C123D7D67
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 10:31:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074719; cv=pass; b=NWt1LSwRWyfeL8Syvdr8GtK7KP2XyZZqLeETHOHOoD/1+0s1gGrxy5IoKK+btZgz0sWHddtZvPXDsRDmNhCmP8jLTwV/6vUWjhdWcWfaZSuqQqxtWaEIH+QEpByZdiyhFrB1HqUfntGkhvsuLaIEH9X881M3gFd3YOQpN/FoHaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074719; c=relaxed/simple;
	bh=wZct5H4oZRgbe0zO/Wk+pTpYy6BKCX6igmM0RtUPcnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bC9Mai/84RM/OJPsmlYcz7GKe34lvny50+eNqVqtI/Y1UwGqYfbU/hPpCgiMx6yEDJdFeV88WS1c40UfLmuNlZr20tShT88+5leGvvPGqiyGtX3wn9JHPq0dQ9OyDaBk8Ifp9EuszM62HUVd3HGepO+pv/8vrUKtUMxkY864Yug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PE9ZAjpS; arc=pass smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47362928f65so412445f8f.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 03:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783074716; cv=none;
        d=google.com; s=arc-20260327;
        b=PtXDSfjqtrcAUHNdi9XPmYOWBhIP0BCIfczxvZE6dx5Ue2geOrd/ZOAouz/+Hw4XtL
         Vh+AiB5jf+qKwZK1l+pNiGT6N3mEnRD9vaJyS6CcJlpF+TtduUGqHoeZsqLDOPvwX9pX
         0+ROvLmutbtmEYyAcCj9vbipbzZm2l8fwqmf/t51eg9DunbvwvC6zIDr1c+Uz75ie91+
         uEjNwmscdrUSVJ6tOo3UYmgQgLj9KpW9ngIiicjkOEp07qNtwov1P2ssA2KIzDM0L6dR
         esIxpx+J7tf9hYSYfnuujfNMSTSsrlAnvmkm21GygYrcCqFUD+MmvKdl70eAelg3YKHO
         ruPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c0p6PCPInYRHIvbfOh74XQd4xO+04JPZ+hZDQnh8FOc=;
        fh=C3kQDQph2y8qde+B2MpSzoGsW4ZGLEoBJ2S5ip+39o4=;
        b=epNYU/3LRCqVsBq49kViXdfzqobl6OO0tbXJ7ihVkcMQ1izOGtCV5sMoUZECvpv7BK
         EHhD/8h/ue1sn5Mak3GFvjvQYyeIn49W1hEPRQT7G0Gc8lZh5Qr10dh2E3Ejh2zb9iIr
         7QI6Z7H4/KEoJy/zcCCSZ/SrKWRG/TMCL59jbd2XhfVGvM8/ELdqPcJRai0mdbsBVyFp
         336LUjq9zWbHS8z0lDmboohX9/CZzWej5/T5FymrpisWs40kM9FSSGqEZbRDIdqH9B5a
         TLqYojiWAd4hY/CipbV9fJblgTChl/6/08wKMr361FmqkE/sYv4ZbN7wX21fR8rcGYyb
         vL1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783074716; x=1783679516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0p6PCPInYRHIvbfOh74XQd4xO+04JPZ+hZDQnh8FOc=;
        b=PE9ZAjpSGy2A43HDeZ4sJ+r52bGGS96WrB+rOWXI/Fz7yznMxmjEKXqnj3DSp749di
         jCm8igAyA8PA/gU9TEzg0Iu0e1JCof1c9Tgjuyf8TUI5HNmgXMyCCvykLXFtxc965Jq7
         vMgo4Lpe08VgHbAnfsfudmtYGUaxKUFYba887J/IdItKr1eC4/WE0/9KDsFAcCWlE5Ie
         NEzFePglxPq1UI5EPpNMq+dE9oizaYgfDs4l9EhWi+yn6yC3M5911Lo3xbasIlBprO0C
         cAzl0eWdO4kDZuJUitsYM9BUUeajVTCSilDg7Kje8iKZJZdZ3ohqPPK4HGGweftSP3P9
         29xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074716; x=1783679516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c0p6PCPInYRHIvbfOh74XQd4xO+04JPZ+hZDQnh8FOc=;
        b=po6VJ4Sd5wHfJVlUHobfm81X0auAMnC2TbsTpADmdDN3rlJIApk2EJAinICMKIHXut
         H9uq9PFtO9w+cxP38k6oLVLfDtRbv9MvZQeeuRRONJassv28AaqjL9xi59vxoiPr70pu
         NfXkRLAxe3cPqIVdgwA9Os2cl8IBEH2d6ZRYnSvCWc1jJhcXdWdiX7JmF/1YDrM4ETqf
         UCgmBvHjH+7yhNXxkT3FkxmkHOGJnUFdL3qyPZSqJATcLbs0XT0fAMIhkJbktXwMM7uE
         rMDMF/qfATzY8CzWevUQjYq4qo4eNS41C04gQVPZeDcz3sDjwwM9hV76V9MMD0rjQMH2
         pXRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqOiZckU1b1rtRng9tc5wXBqDy4fnnQiiiXpxP53uUhCaJQHvddYTgtZzR2M9y4xvmKTVqEdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVPKyNnuxJN6MTIBrfTE1qSkdJ9GAm7wx/Nsqwn7EqQPUS6fW
	6TKlu1DysQ24GcE2W3g6l8lWuuRKzNnyOf4SxL9WoS+viTbp1rgpKdBjmwmmq6l0/scC5c/9Jwe
	1f5QaNrkCbVaKUHLdHPIIoBj+EpHFM5V5bXe7UYpH
X-Gm-Gg: AfdE7cmRyash3tiROM6jw8kKtpa7vXpJW53lZ3u6IERc81O8cMwwJ0LhYfhHb8ZcshS
	ClhF1G/jJgPdmbZT4v8QU0VZmlk9qw/hAx2k7I2TMoY6iZ3Apnpd7K8fZ31QRhrPySLnqPgLU2j
	cZ3Xvj0vXtG/TASjXMjB1JzrMl7/zSKIeIT/uI4kASRLN0dEgw/yVwFX9de8bcnnjbvg/lXTMwj
	FEjpD/jJdPOuj217fMXLaf+tPFQuHpIeFpspCs5Hl8TyAi6Ls6s3rqtiwQJ1sLL60zGqbCHxQ+p
	9bQScDhOSzZBaZctnhdqWD3l3J84wkR9Z8MGX2tVdHyZVtN59xmfuJRUPJQ=
X-Received: by 2002:a5d:5d86:0:b0:478:65a8:6305 with SMTP id
 ffacd0b85a97d-47865a86935mr9505643f8f.49.1783074715259; Fri, 03 Jul 2026
 03:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-remove-freeze-on-remove-node-v2-1-93b31766e7a8@google.com>
 <2026070344-alike-ducktail-5fe0@gregkh>
In-Reply-To: <2026070344-alike-ducktail-5fe0@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 3 Jul 2026 12:31:43 +0200
X-Gm-Features: AVVi8CcYDMhnQJ6NRuMOCgpFIWUkfnsR7h0Za1htseTBHxGqGlrgTBBqx5jze2o
Message-ID: <CAH5fLgj=YDfcaKAVseHrNPwfLe_yJM4zjZsZqvAEK_QjmrT7rw@mail.gmail.com>
Subject: Re: [PATCH v2] rust_binder: clear freeze listener on node removal
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Carlos Llamas <cmllamas@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:cmllamas@google.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271719-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EB7D701455

On Fri, Jul 3, 2026 at 12:27=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 15, 2026 at 01:13:16PM +0000, Alice Ryhl wrote:
> > Generally userspace is supposed to explicitly clear freeze listeners
> > before they drop the refcount on the node ref to zero, but there's
> > nothing forcing that. Currently, in this scenario the freeze listener
> > remains in the freeze_listeners rbtree and in the remote node's freeze
> > listener list, even though the ref for which the listener is registered
> > is gone. This could potentially lead to a memory leak due to a refcount
> > cycle. Thus, remove the freeze listener in this scenario.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > This series is based on top of:
> > https://lore.kernel.org/all/20260615-binder-noderefs-spin-v3-0-3235f5a3=
e0a0@google.com/
>
> Hm, but that's not a bugfix series, so I can't take this patch now for
> 7.2-final.  Do you want to redo this one or wait for 7.3-rc1?

I can reorder them.

Alice

