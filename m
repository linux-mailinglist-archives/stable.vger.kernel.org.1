Return-Path: <stable+bounces-215620-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM5mDIvvimmwOwAAu9opvQ
	(envelope-from <stable+bounces-215620-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:42:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9536F118507
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 09:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06AEB301079D
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537E33D50C;
	Tue, 10 Feb 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g86YfLjH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E6818C933
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770712968; cv=pass; b=btmDxOXtRvqb1f4XV2IwNjNHDaNvqDed/wQGXLgurirzHXyAnCaLtTF3PgVJPBrFb3V6TI6afjGANHRlYUA4yEHGkNDTl6DXsndCAdq+nHSHDkzrHmXHD/Wa2JD6KxiFoiGcbo1Hr8TxAHGxPJ7JqeLzfXMzunwFlM2RRKdTxvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770712968; c=relaxed/simple;
	bh=pzj9Ny1KxKgyvqZwK3YaJvtJxyNcZudeF2U8bB6Rm+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MaGe69ISx4FPAGcZjXvMyaAVMgO6tZt1JVQuhrhEMZINWnQQ3FAotzPWOcoRstX5+Tmf2z19B9aMDa+4M1U7WLXdOF0aG/wzaEKRjy8nI2MVFE9usUka2NN0msD+q2hLa2ftIcpM9y4iZZHVE35m8zmaMptZ5R3RiV5JsUOhyIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g86YfLjH; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124713e4244so240586c88.2
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 00:42:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770712966; cv=none;
        d=google.com; s=arc-20240605;
        b=ibr18eskQ1pHDUUY4Sj2Svd7WuGY3tCbelCP3whkAT9DkzfFgkGyvzwhc0e5V2jj3U
         OVdZAhZM9RvgKaqwT9tN7L38mLpztv6RZV3zajSGVN+06D7IZH1TR9REL8cYVrwGAuX5
         rIzdskobUrwMYnuEt23+vGnXMJRcrSH65DE9qZXz03M38ixEt7z2ebedJcn9xH8ffgSB
         1tKSM49HkJvNKmt7g/RYxGtXNctmgTPqmTwg/xNKWleAoMRwtOzg+2YgMnhHKhLvS2+V
         m1419ToWgMPP2JfLMkc64lXUFCX4+tybVdFJdF4kRP1OuT9snSEj1e03sWTHAmNkXJAX
         ESJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRd5nGkK/uJsiW/OSeGHF4f73KvZkDNQmuEV0hYZwB0=;
        fh=XqvoE9iUfZKATj4yotrcWfMz1NNuDyOeMmXJJcgAE58=;
        b=RR/r+K+2oMjtB3Y5sI8zLqUSs0rqPERjfxtqRHtuUL7TpfyTEbfz2jPNtwGQwZ0lnu
         8FADnkJ+KBP+MPweDRtSguL41o1w0gENQIVkI6mxW1y4SYj8SrHplzyvDoB1Xrl4L6dG
         0yA7/UrYvh/pFVdijVN+IFz2/R5I6kmphURwcByKv10qUXzjO0zCIXjCMGpQR4sxM+AN
         QpXaIyFzSDmWr0hA1exfvd8gwQ4QYtujeqZvNdQTTHUPc8LS3yRdRm+s6jKrev1cQha1
         D1y/t7G+McBY3bPpAIAFq7WdDfIu19O/l4dRGbZhwwMyTuPKzt/tmpNFESNuErNCGjgf
         02FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770712966; x=1771317766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRd5nGkK/uJsiW/OSeGHF4f73KvZkDNQmuEV0hYZwB0=;
        b=g86YfLjHLLROwQ2kshoDhTX3jqvWN9mGJHSO/ArVZzzwmHv3dc5RjEV3XuioS9oK+i
         2023y40IxKLhkr7WTc7eQ4UG3v7ZwfYhUp2ovmyTq3LnrovQ5Ar9sU61cYhaK7GQzjCm
         +EVJwa3guOqKJnwnB8iaM2uq9RzJSH7cAw5oAHYlylzxM1QAZncDhSZW27EtflWDtyeE
         NtO1f3fymHVUbXyxLwgL/GHJnAcjz6dvkLXJ6Fd/34IQlrkf2GrcIF6uUfr+xOPoOeg8
         QkxDi0ViaMJRH8RwfmOvCD/W1Q/fgpZkCj4fC/f1xix4UES2MuZ5oR7VH9gq8rVs/WeB
         XLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770712966; x=1771317766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRd5nGkK/uJsiW/OSeGHF4f73KvZkDNQmuEV0hYZwB0=;
        b=sIuNfOlj0IHEn2DZ6/WAG5Vgu5vyY2RuEL8htf477fas4DOaRQBImOs81tHwwHaZM1
         ObIqhUl9EKjE81XPSwefgkGkRqWutG3DxnURjiOHo9wPyU/sg+sQRVlAJtF6DMUzxHqm
         2zfTS96Tvh6/m/I1G8kH4eZrj8mT37dgYVuPUbQLVWyLElk8EvxH+Es5K8Nl7Ygf7K13
         U6/xUxhgXwPXnbv+k95F9XH9vLagKIoHMRIL8klAFguvShn/q7p+Juc7P5NIWhFtALGf
         +pWvFcxW8soOkQpAkX67afiNChR6MeCb6LQvzVssYIwoWnASDNYsPQMC577GpZGksMMR
         MJMg==
X-Forwarded-Encrypted: i=1; AJvYcCVdtk4wHmubZUy6vb8g/FfMMvGOnSY6w4nT2QW990n5WlUt+riOzrpa/v7E/kzg7Bv89XLMONw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrfGGFwSiB1s0uPh8jh1ZiHT5GEuSKh+Noi99zndQWa0YV4k9
	z38ktgl7Lh+Vq9rC0sKoqVmYKZA/g1C7bG5wt8z8j2cYesRjt5Dxvj/2OCmSlEsbKxTkJm/0M7G
	vbuPMptxdw+BMAkts5OfyQnX9IWp386I=
X-Gm-Gg: AZuq6aLOw2askhqDbxjOfoXwOiJXTy9kP9AICbQdxVdHS8SbKQpFLK3WwSLV6cNNSn5
	18vYro45vf5rSGL/zEmxTvR+I1R1YOagjlXGi4RBx/L8xYanT3O84GzScnwHSlQIooC1O8FIgwI
	3Vh57Pk7CWBjIz+b3vyEXVOfRAoBcDJIhVj8fQbrb5vfFCBHB7qRYVP5ykOALxPGdOZLBvpq3wO
	hvixTSUmvVocFZpNOlvaJidY1GElmHMPgoD7Jc2JwO5mXb4OREiuLYQ1c4dN71PmGvpGIoQ7iXE
	cOhQS/M8R0p2TsCxXZLwKSRHDRmaeV6J1P/hybPwUdu73WvZMe8WPoibi5/XOYw0awSUv5H4T1i
	FBE1JFHCtoI0inmo2A9Qy+BwW
X-Received: by 2002:a05:7300:3721:b0:2ba:7322:6bcd with SMTP id
 5a478bee46e88-2ba8cc89047mr187606eec.3.1770712966327; Tue, 10 Feb 2026
 00:42:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206204535.39431-1-ojeda@kernel.org>
In-Reply-To: <20260206204535.39431-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Feb 2026 09:42:33 +0100
X-Gm-Features: AZwV_Qg-hW3f7kkxtTxv49a5tYvs160zPEvUI7XxUzESxFFA_J56CIIMLUIrGT0
Message-ID: <CANiq72=15XC6QT2KucsBhzLOdp=rLtCgC__ncLPwWK44583S+g@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: pass `-Zunstable-options` for Rust 1.95.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, David Wood <david@davidtw.co>, 
	Wesley Wiser <wwiser@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215620-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,fjasle.eu,garyguo.net,protonmail.com,google.com,umich.edu,vger.kernel.org,davidtw.co];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davidtw.co:email]
X-Rspamd-Queue-Id: 9536F118507
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Custom target specifications are unstable, but starting with Rust 1.95.0,
> `rustc` requires to explicitly pass `-Zunstable-options` to use them [1]:
>
>     error: error loading target specification: custom targets are unstabl=
e and require `-Zunstable-options`
>       |
>       =3D help: run `rustc --print target-list` for a list of built-in ta=
rgets
>
> David (Rust compiler team lead), writes:
>
>    "We're destabilising custom targets to allow us to move forward with
>     build-std without accidentally exposing functionality that we'd like
>     to revisit prior to committing to. I'll start a thread on Zulip to
>     discuss with the RfL team how we can come up with an alternative
>     for them."
>
> Thus pass it.
>
> Cc: David Wood <david@davidtw.co>
> Cc: Wesley Wiser <wwiser@gmail.com>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).
> Link: https://github.com/rust-lang/rust/pull/151534 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks!

This is so that Gary gets it soon in linux-next for Klint -- I may or
may not need to rebase this one, though.

Cheers,
Miguel

