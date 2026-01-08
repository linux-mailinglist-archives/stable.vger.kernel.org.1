Return-Path: <stable+bounces-206408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A25D060A3
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 21:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF91730124EF
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 20:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3D432ED27;
	Thu,  8 Jan 2026 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RVqURCVn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D29327783
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903986; cv=none; b=lMljPRa2FFOdZ1g3JHtDoyzV0WQ4zJBMSeOJbPraXpMvXkht2JgpxD6ht3L/N4QLR/3rtEV6tbBZSumRe4MmnoHKYlLcmGYQ7XvqEDbvTu6jEiG4NHs7oCWGYiBnere+C+67CdNeTgb4u6ycABGtgdETy3cxtmVw+7N8Q1Rzmq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903986; c=relaxed/simple;
	bh=vIRf8ek37UC4I8pZL8f4DnX+0SWacmoiw+WywWiO7KQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BGD64onD5h4ij9wBlEk2Qakl0MiOh6/IqER9cnnIFynLHsOtzVW892tnUnnVDUuvKZWKKbyBtFf+u6gXciDPdWpdd2mLBtTt22LlD/88JYQSTdLixmc4RAeJ386GXBLUiuTBsI8x4Jlfo9VqMI+18cXsDyRLeWPeZZ779Yb1/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RVqURCVn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29f1f79d6afso52464025ad.0
        for <stable@vger.kernel.org>; Thu, 08 Jan 2026 12:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767903984; x=1768508784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHFQ1zwwcYEgWyhJUZX4RICWrZYFGmhNrU0B1R8MCB0=;
        b=RVqURCVnGMRIuzLvfLM/Byl2mxDgAJUySNqs2YVdf6k+EGfpuTOtx9PoyOfxkYBdgV
         h3EhbCF6CRO+XoEaAzvga1Nj4t5uXTkSdqnpTRBoFnu28KfU9rez/mY4wxL0BEdYs/OA
         y593fufPCcLlf8xr1rksYutbBLkpNPos1WcUoCGZ8atClcF1YOmfO86s+5lyfDtu4vCI
         j75Hq8XYvlFryGB3VEafgFK4uC6raeNQ81hQ+1Zkm25Duf1z7xPVicjupElYkzRWSy2N
         G60RmSaNVvbpoHB2p//l9YkENUyEFN6CAF1Lx/qG93BEZx6uqINhbKKkuQa6Ml54OyX3
         rNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767903984; x=1768508784;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KHFQ1zwwcYEgWyhJUZX4RICWrZYFGmhNrU0B1R8MCB0=;
        b=F/NEqKQUQQNW1LegRxkvaB/OjM/rrKi2KzoTotuPpAVnwC6BEFxK/M2bLp7F5FhWG7
         2wnU4R7gG3wdrlkAAAaGZp/UblNjsmzZdBP8elBxIEzy0JYYQRj7BmLJimneT0gLRNLE
         ad61+rtGDOZB7C1f/c+hVrzMozM6LumMCSDyrbo9DW333Xlfl4UsintJG4TfI3waTBA3
         soGbz4D1zoMHvEh7fc65J2HXwctZtSb7Sf9XYNj4GjjyEYxCh/uMTYQPPf5KhE4peT4f
         HSz90LzXp+x5uXxSUb9+2sYu8afg8FRIv2QdW96Vj3pfhZTwire0r98+NktC4NdzKqf6
         AITg==
X-Forwarded-Encrypted: i=1; AJvYcCUK+HB5Sb7N+j1LQYPMgzPOcZVn3iisC7TqojIGfhmfTw5MmbtiadQSv7xzo9gE6r8qaCjyR6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgYSdwqETXVPXw+gDk5ea+wvWmoOR2SDv5FRMzQvr7K18cDig
	dqYyy7zJ2NnqdHKY7D3sixYrG/56P/sVnPBSOKmBlHqTJKk0tLoD4Z5yT/KLW4uwx7mXcH6GEw4
	NXzvVkQ==
X-Google-Smtp-Source: AGHT+IELS2jNbkin4p6y/JaFdumZZ6d4Quwy/rgYJYNAtZ7zSyujQrglRfN5SOfYVkHyE9oSzxVyjGEfPAs=
X-Received: from plbbh12.prod.google.com ([2002:a17:902:a98c:b0:2a0:d5be:7bb3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c5:b0:2a3:e89c:593e
 with SMTP id d9443c01a7336-2a3ee41f181mr81057965ad.4.1767903984247; Thu, 08
 Jan 2026 12:26:24 -0800 (PST)
Date: Thu, 8 Jan 2026 12:26:22 -0800
In-Reply-To: <CABgObfZSchPMdqSvvVPgy9s5-TkHHZpLPHNYSsK-YHRye0SAaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260101090516.316883-1-pbonzini@redhat.com> <20260101090516.316883-3-pbonzini@redhat.com>
 <aVxRAv888jsmQJ8-@google.com> <CABgObfZSchPMdqSvvVPgy9s5-TkHHZpLPHNYSsK-YHRye0SAaw@mail.gmail.com>
Message-ID: <aWAS7iCLgJHd_GgZ@google.com>
Subject: Re: [PATCH 2/4] selftests: kvm: replace numbered sync points with actions
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2026, Paolo Bonzini wrote:
> On Tue, Jan 6, 2026 at 1:02=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
> > > @@ -244,6 +254,7 @@ int main(int argc, char *argv[])
> > >       memset(addr_gva2hva(vm, xstate), 0, PAGE_SIZE * DIV_ROUND_UP(XS=
AVE_SIZE, PAGE_SIZE));
> > >       vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xstate);
> > >
> > > +     int iter =3D 0;
> >
> > If we want to retain "tracing" of guest syncs, I vote to provide the in=
formation
> > from the guest, otherwise I'll end up counting GUEST_SYNC() calls on my=
 fingers
> > (and run out of fingers) :-D.
>=20
> I had a similar idea, but I was too lazy to implement it because for a
> very linear test such as this one, "12n" in vi does wonders...
>=20
> > E.g. if we wrap all GUEST_SYNC() calls in a macro, we can print the lin=
e number
> > without having to hardcode sync point numbers.
>=20
> ... but there are actually better reasons than laziness and linearity
> to keep the simple "iter++".
>=20
> First, while using line numbers has the advantage of zero maintenance,
> the disadvantage is that they change all the time as you're debugging.
> So you are left slightly puzzled if the number changed because the
> test passed or because of the extra debugging code you added.

True.  I'm good with the current patch.

> Second, the iteration number is probably more useful to identify the
> places at which the VM was reentered (which are where the iteration
> number changes), than to identify the specific GUEST_SYNC that failed;
> from that perspective there's not much difference between line
> numbers, manually-numbered sync points, or incrementing a counter in
> main().

