Return-Path: <stable+bounces-224595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA1BHyCfsGkwlQIAu9opvQ
	(envelope-from <stable+bounces-224595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:45:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925C2590B3
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 23:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 74CB23025120
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968E43B636E;
	Tue, 10 Mar 2026 22:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIkxt3pp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACEC2D8DC2
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 22:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182747; cv=pass; b=hFJ4DsAfHTNEQWWXW8gmBQIIgAbC/WD45tyuD+CrN+hVQvKwWbCn5worRQ4QvUBgSlSRUXracCDvCKKR5FO1+YnSTsjrKypOXaaYrxnA+PutiMzUtYXIGw8q5vRZ0PSCsYbZnkQm6q4I2gbqpnkzTHkxp0374tEMPTPx3x3yOWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182747; c=relaxed/simple;
	bh=NwwXHeQBm0xRS2zYJadsYZWaw82EYyPo5w3EDKS9vp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=i8s09B6KbcOwD1Bmq+ql9pP5MWG50OoNjh51vS+gL8QzFShgYLtOJXcgOl1hfO4wP0IC93YpCD2wolrUKGqi0d9n0ImgpSjJpX77mURNj7QRE1CIQ23WiQTCvyZvn2Z3nbvG9GLoTAxUIL5LQhBLq5U/UIL+gsUId0icNvRnOvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIkxt3pp; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be22d699c9so550956eec.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 15:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773182745; cv=none;
        d=google.com; s=arc-20240605;
        b=NPRG/yrJvfqObUTktvInkEDE/R5rv8NwSsxLFJf3TPU36nuwBWzdl7I5qsIXzdih80
         9ELQG0N2357kev0lKizDy6GrRn1EH5eTiXcu3AU11EICbJrRr6LdeolLHxGoIUMEBXI1
         8FWI1kMGyOd1vb0oT/dBUEg9Om8lQFzjc/GjABr6oM7+OnPGagu4v2n75/agrLonYBUZ
         +NEc4nygFbYiT9OMQT7N5s2cm9z0zS72cSeqXdzOVoskvpJbJtQhdyLEJUuXTCO+7iAu
         CX3+mb4hXCo8Njtgrj3PSWMnywoPY7CKzv1/crr9WkvBcQcDMKok3uTLGRmwVP/riZf2
         ERfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AcppTpjnVFhwx13Ei2/3uaCsu4NJqsetsGA5pNmZ6VM=;
        fh=0+M6lS5WkmHDm/Z6/nOrEP90vKcy80xLvqJDOcXrBGY=;
        b=iShrsFUkjGvzMQDQWcAJDh+l+WTo4e8WDGQs5DbVCNPm8H8DcjKornRDgXDU0+mg/S
         GJlHKcsYznbh1XD891bBilLVwj+WPSoPi9YX8dM355IglXFOQrJH9okSPEYPQf+X+0k1
         7QdRiUaMZgi01CuY2NFs/n8uNxbvNdkCS6h1fGKnDsrBBE7fhmdbfFnvBrhOep+MDntK
         NSAWCeFcsgKAHuH+vmNNngs10G20t6M1hHH8Z8xfNe20PgKE6EjlNLM3h5kKCi6Lntyg
         WQgeaKMicanJO3CK09iALmo9+SwteEacnJ0oy7xTLn4Qe/lOgHD9O+XEMjRWwy090tKq
         b4LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773182745; x=1773787545; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcppTpjnVFhwx13Ei2/3uaCsu4NJqsetsGA5pNmZ6VM=;
        b=JIkxt3pp3CLOTQqhAFNxefuFPdiS2it8Up4l96I8OJHdXhDWcgEev4/os3tOee73zP
         P2pV/pv2tTXFlt4VZByLmwvD/VncXBozBRgi7EeFuqKrCqgd1s1bk2IFi56ilA+Zd0CG
         r/O3951dFGhc4crweV6247RJBXeNSHeY+Q7oIn3RLQ37/O3Slr/lwTNGPNuxCCn1V8UP
         Ke8t6cVagVf5YVaQDJh28dV6fFGcEkSVXSjIbvbLKF5ECSmUxkwt490c++kumccQRa1H
         cUBjr8q+aEAlxsAvnncuz9F/k+tYCkUf7TDaUAG6t/4vEl4lMWTh7d4NcunXbnY0wX8q
         /5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182745; x=1773787545;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AcppTpjnVFhwx13Ei2/3uaCsu4NJqsetsGA5pNmZ6VM=;
        b=ng0UeaEpQlxvuZxwuU8Jf7ICPK9WNVIvzvMPVaoQ7p19g7zqMYPrXmzQGwHFz8bCiz
         ZkHrtZVqee+T7E0S1/+C8deFmduILeORD92FO45xEtSyN9WF8ynDL+4Do+IT2Fx4hNXL
         x+arIa2joKwxMuXy+p5xsDA32erqbpwh5L30TS8SrC50tP+SsfVsithqVqgVt1JNKXH0
         EZX7OItkcyjZIG/EpTuMDzTOusiXpGvBFTmZiOEnjthhQUUJv1UwUehj+fDaku7BR96s
         kFV6gk1QjqkbuO+opn+bbXU/DEAhCmvsKI51vkA17WnPbPNT/iYNzYm8DCVTwMgt/F2j
         mYKw==
X-Forwarded-Encrypted: i=1; AJvYcCVNKygx0p+FfPTcvByf/K5MA+Y3o/X1XqQBFribJXmVUuBSXngmYrm72QinBJBW30YbH0mVPjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7R3iNNUXM2D8QibFkv93pSUr0FctzpSWFUvDJPphSINre5uq
	cnEMnWgvaBgWhy4RdR28YYizCWoLvqxt135iSg2+GdjA+Krl1MQfr5JGAbNLZQySXez2WxIrZvY
	EfI2TUFkFEHhm12aWm2sjQVFHVNAtJGM=
X-Gm-Gg: ATEYQzwYV6+X18AnlkTvM3v3Gnh7DWyvkz8kfs48lYuXNyKtCWsMv7607DWzGFiDLFF
	xliP7+PxkIPkHk4WH3fqmD53WEmSFKV3qESq9AzVlK7oO/hzc5WIyye4eygyzU/bYxy1cXkNo3C
	4l4/zc9VuxqK+sfAmlC01+EO+2Ji0/cZ/hrL4zIhPUHYrnOH5W4elsTiF2UG0S1QpPheNYAdbtB
	oLVsBYbV7CTUiyJgqTCmIfxiNHnVUJzBuqDZzDk+0nogr+gVqvTmQq1StU05qHUCJh7KlFeSZ36
	srTuadi46hAe+zrXY8jbulixEWCzUZQ1eidjt2GMy2LEh1plq2WpWnYtHXeoLeUknIo10zl+TVH
	tj7v+pR1HQEkbNsGGfVclW2U=
X-Received: by 2002:a05:7300:3253:b0:2bd:d111:cf18 with SMTP id
 5a478bee46e88-2be8a589a62mr79976eec.8.1773182745139; Tue, 10 Mar 2026
 15:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203221224.GA2703490@ax162> <20260205131815.2943152-1-mlksvender@gmail.com>
 <aYS9bRugxr1rUvA3@levanger>
In-Reply-To: <aYS9bRugxr1rUvA3@levanger>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Mar 2026 23:45:32 +0100
X-Gm-Features: AaiRm515Nd5QLPcAZuOPkqTuJziLIjbUrquMksP3iOdIj6zJC7o4W4g4PWJLZlo
Message-ID: <CANiq72n-z0v_deUVPWeg1h0c6KQ+r6xfNDf72o29_0yy6KbqGA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kbuild: add rustc-max-version macro
To: Nicolas Schier <nsc@kernel.org>, HeeSu Kim <mlksvender@gmail.com>, nathan@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com, 
	boqun@google.com, charmitro@posteo.net, dakr@kernel.org, gary@garyguo.net, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, lossin@kernel.org, 
	miguel.ojeda.sandonis@gmail.com, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1925C2590B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224595-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,google.com,protonmail.com,posteo.net,garyguo.net,vger.kernel.org,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 4:55=E2=80=AFPM Nicolas Schier <nsc@kernel.org> wrot=
e:
>
> For readability, a less-than version check might be easier to read; and
> that would probably better match the suggested version range check:
>
>     rustc-lt-version =3D $(if $(call rustc-min-version, $(1)),,y)
>     rustc-version-range =3D $(and $(call rustc-lt-version,$(2)), $(call r=
ustc-min-version,$(1)))
>
> so that the actual version check could become
>
>     # The bug was fixed in Rust 1.90.0, so only apply for 1.88.x to < 1.9=
0.0
>     rustdoc_modifiers_workaround :=3D $(if $(call rustc-version-range, 10=
8800, 109000), \
>                 -Cunsafe-allow-abi-mismatch=3Dfixed-x18)
>
> or:
>
>     ifeq ($(call rustc-version-range, 108800, 109000),y)
>     rustdoc_modifiers_workaround :=3D -Cunsafe-allow-abi-mismatch=3Dfixed=
-x18
>     endif

Yeah, exactly, I think the range check looks simpler for readers.

I would say let's do it as an improvement on top, and to simplify the
delta needed later on and to avoid the `99`, I will change the patch
on apply to be `rustc-lt-version`.

If no one shouts, I will do that, keeping the Acked-bys. Then we can
easily add the range check on top.

Thanks!

Cheers,
Miguel

