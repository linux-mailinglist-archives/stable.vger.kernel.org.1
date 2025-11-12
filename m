Return-Path: <stable+bounces-194597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E884AC51ACF
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255A1424216
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829083064BC;
	Wed, 12 Nov 2025 10:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V923ZWF1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A4302165
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943089; cv=none; b=QvZi+37xxSgrq/91l00+0fIJnCxeJsBgvocO5zYQZe3yCXIUpbSXDowyj7kWWS4blLHVSmzg2OmW9hcwgjfVxCfokHGkiohThuFJob82fx2v/CtCoTDLlBV0N0DDVqT9pjt6EzRQYxjJ5CDV24vGLc3a1qlU3vKzkBPpf386taA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943089; c=relaxed/simple;
	bh=QV16gLuhA6QXk0TLawQZc0iHWhNFDaMJpFOCm3aRQps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k2zNNtPT+MUxw7Tl+Ak+THXS8XVPUYZTBu8xDEtx4aLT0q6Opm3rLWBJJc0ilEkIT+qhL9SLQDfoVi4lb1t9lLXaplGdbmn4wKoUr0tK3ppiqnqy6cV8NkxUuD4Glzh6YlNEekmEebPSu8WOVcx+gL9E5TA/+n8pEuGrkYAm+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V923ZWF1; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-641613171cfso626650a12.0
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 02:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762943086; x=1763547886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QV16gLuhA6QXk0TLawQZc0iHWhNFDaMJpFOCm3aRQps=;
        b=V923ZWF14LJOtIKqBD14V6GFHbL/fEsOkBkVmUGlLOSjtppIkaH1u9MgF7Fvo8lbjs
         aX5k+1NYgzmxRJF1hiesJAg3OXqsFcIVLYqTQb827pUy4SYP1pPJEfPWQDO5FNBkONJh
         S7fjg7pnOwfJoMznbVDUD2rQJHC00NDMjL4i1MHSAFGF5Zheq7FdV59nzj98sJzJWCKI
         +MgZiIN+r5Vhx5MJE5qz9Xrcy6UPxVjRMceJ8PB05vyivSaDL4J3rdslQpWR62TPRxGC
         5FDD0mShIAsEIx0uRVuTZqpj4EVSs9a/yyrjj092BhYmZOCBfi5CCl+DFQE2MDKbInFE
         3AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943086; x=1763547886;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QV16gLuhA6QXk0TLawQZc0iHWhNFDaMJpFOCm3aRQps=;
        b=EQHg1AILSkakU0tL4Hm5x8HhnQpREyyQmVxPVddVYkj0+dSwY8U0Dnl7kOFEs+Pk6n
         N5IK9bx9B9GC5SaZDh0TpsJRiqn2WSBgltKqV8Vm1Kj22oQhDvcM0SmAzXr4uhoGcgSr
         CgKpmW1DmvC3ivjjb/bjocUvCfPS/Uf6b38cCr9ZQ6tBGL22kG1JXCug2tQmmHhaw/kQ
         8TkxR6YqmRFAXteZkmW87Adn1j2OcaX4vmlooSQMYyrzTeOSQY0Kom7AgMY92LKDK9Qf
         thkOPsgrmwp8dS6fW/ysW1xKlvO8pUGT5oKkIsssOcKf7uViHpoNo/MbuJtX9D3H1nTH
         KQhg==
X-Forwarded-Encrypted: i=1; AJvYcCUlPWLB9eqpo7XUjawEYeBFsvl3rVVSt/MFhLFlo2mgx9zcgzXOVemKg+UF5v8+1kQnVEoiWmM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5nPU/iB/WIN87+4q/q5TM3CCB/CaJWpg4tuq4vjdk6+LSXD1W
	9WF20lx055vn/I8epOMBub3qQnkGL+uEx2tHh1LyPfKN/KfcgpryLgevSSCVh2eECqG013VLhug
	ef/gV6huWZfV5ZKjDEA==
X-Google-Smtp-Source: AGHT+IF1pxUgNK4s9SnZynMy7vzcNMtbfcJwnUyBona8xZEdQaGlDIF17TEFkA8h6w502BmTVUazVQKjBBbbcF4=
X-Received: from edh10.prod.google.com ([2002:a05:6402:504a:b0:641:2f00:1985])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:440a:b0:634:11d7:f70c with SMTP id 4fb4d7f45d1cf-64319f08cc8mr2418980a12.2.1762943086210;
 Wed, 12 Nov 2025 02:24:46 -0800 (PST)
Date: Wed, 12 Nov 2025 10:24:45 +0000
In-Reply-To: <CANiq72maV_j1uV=2nPGbTgRabnk8cpc7TNN_FQ+ou52OpZ=k6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com> <CANiq72maV_j1uV=2nPGbTgRabnk8cpc7TNN_FQ+ou52OpZ=k6Q@mail.gmail.com>
Message-ID: <aRRgbZ67cuW4ZoBN@google.com>
Subject: Re: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:12:32AM +0100, Miguel Ojeda wrote:
> On Wed, Nov 12, 2025 at 10:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com=
> wrote:
> >
> > This changes ResourceSize to use the resource_size_t typedef (currently
> > ResourceSize is defined as phys_addr_t), and moves ResourceSize to
> > kernel::io and defines PhysAddr next to it. Any usage of ResourceSize o=
r
> > bindings::phys_addr_t that references a physical address is updated to
> > use the new PhysAddr typedef.
>=20
> Should we have these as actual types instead of aliases? i.e. same
> discussion as for `Offset`.
>=20
> If there is a change of these getting mixed up, then I think we should
> just pay that price (not necessarily now, of course).

Maybe later. Right now I think it's more trouble than it's worth.

> > I included some cc stable annotations because I think it is useful to
> > backport this to v6.18. This is to make backporting drivers to the 6.18
> > LTS easier as we will not have to worry about changing imports when
> > backporting.
>=20
> For context, will those drivers be backported upstream too?

I could imagine cases where a normal fix gets backported upstream and
benefits from this, but I mainly thought it was useful for backports
that happen downstream.

> i.e. we have sometimes backported bits to simplify further backporting
> elsewhere, which is fine and up to the stable team of course, but I am
> not sure if using Option 1 (i.e. the Cc tag) may be a bit confusing in
> the log, i.e. Option 2 or 3 offer a better chance to give a reason.

Using a different option makes sense to me.

Alice

