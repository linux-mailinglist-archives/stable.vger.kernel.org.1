Return-Path: <stable+bounces-194594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DDC5198C
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D625E189B177
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 10:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4D3009D4;
	Wed, 12 Nov 2025 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MifdhvqJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06E3214A64
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762942368; cv=none; b=TEbLZa9xgddtCuJx7brbNm0mGgR+rAAcRpwbM4N7wx5CCmlh6uyX2FUzBXqRpY4AcwnosSI4+H9zTKYdHIALIx6g+3HcoWuNNDyT8H9lMe5C0HbIbArFtl9vs6pfsB4JNdHRmFpHTuJ7HaNivR9PA3DXvRL0GWQbJL3zWZQu6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762942368; c=relaxed/simple;
	bh=MHWwjzyDdlPVG7Ep2giUSyYeqBp+LJwuCtg4rAq369E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2f00hf1IXIFnm3Q9IsL/+NUPGsLP0I+3AI6qQInHkdrgJ8XFuTL6YFQOnlTeY8gAJ8rlqchbx5jYd1ikGOQHdTDv4bM1zVnd+HRhIAHnXYZM9O3Mu7AyJ74m8hTykNUpt8Yg8+G33U8300bgP1sblGb5hMxkYf39A71KDvTLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MifdhvqJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-295351ad2f5so658165ad.3
        for <stable@vger.kernel.org>; Wed, 12 Nov 2025 02:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762942366; x=1763547166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHWwjzyDdlPVG7Ep2giUSyYeqBp+LJwuCtg4rAq369E=;
        b=MifdhvqJ+tTPb55l+09TG6kR/bkYSEOysHx75WWgnuHLm0nKpxlmKNZYN9Oq3HqHof
         Idi9LIjy5A9ZujCthgUEbopWG/mIh1Bg8ur8A6Wij+heyR9UfjrRwugBBV2QOtelo0E5
         GlhmWycrrB1e8aLcGEBEPG7CbBGy6uILwpr/WhATx0ju1FnOYeWOGSo9wJcXNWz9vHcb
         mjpn7xh2OWnL6FEwNBIKNC8W6aeS+UlE9z0Fx0ugkb3NP8V+1pQrU8psLiXmBMaBZSka
         cNlu4WiJ4Z6gOxQCpSkVQE9a/NCjZoasTw5SLrICRNrdvU0MmU748ygdwxycCsaQKWuj
         +I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762942366; x=1763547166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHWwjzyDdlPVG7Ep2giUSyYeqBp+LJwuCtg4rAq369E=;
        b=flZ1ohTQ3bJ+IJ2t3sMMDMTDd0QydJhIHJgWCw42/0sqmIu+by3t038ADjQIO/ki2U
         n149oF0ieOdQvbOOagc2T1iG3/unuqj2XoDuAC+H91icrOADbnmQpjRFVsy4MSqww6lF
         v038S+IoB3QNtgWIp9SneaqAX4gInkMKD1VboNpXIG9lnQi/446cqgyrzngIa+coOmVj
         8g79CRrAnt5iCKKYhR+DPO6EFcKforerrw+C34JUkQA9y3qp0gDJmorzPjHBOINkMHNr
         oOReBurtdpdFSx4kVmg4STYRKp9l0uyFIE0w3y6Fb3mPfldu7WKq+w/k0mQ6NWmvm1Sy
         TqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+XMDejtf5HLZ8EDku+OqPraQXc2CzqOLFe7soNJ1fzTtQsm8kJ7CuaenbJ1GmK2X7pk9brHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzztDiQbCvqON80w/zB4QWV5CrMnqbiufc5NdKgGrYJ16A1D3WC
	TjamFIRs8l60yqEX9fFeN6TxfaN1hNrobzxr5iA8ozdYQdaq9ZCuKfb2XYxlN0fwutTRHCyaIqN
	tsaIdk57iiNzN8Qja+cqHYadJcygF6ws=
X-Gm-Gg: ASbGncsVS8OeRThKVrq9jXnvCCNlOaOK/cPOj3e1lIARvuN5zFRklhdxQNuwefmttGy
	V5tKiSX/igI44tRKI4iRV56irbU0g7/qStPiGxnTHH41jG7Bfume6H20naX6c9q//76zri+2vVo
	RgZ6SrVHEfEdNB0O4Rc6ZcyuDEN8uF4QYXGp40Idr1sz1Tk2lOfX18+BKkTs7Ib8L+zdFVq4Snm
	h+yF6f2oqOBptiRDE88gHAncBPEUgnLIRqzosuJe1peDyu5bLQJTR8pNxjZd5BfcpSnxQhx8nVO
	JMRtbAAKawwhcL34EpCQrYPtBRFRsPcSFbmdvl6wVKkbNHFif9k8dpi+Z921708Dj/sfAQy4IxN
	zdec=
X-Google-Smtp-Source: AGHT+IETQ3SzNJP38qICCbEJ6T16t3JXamoGxAtaT33VsTBIiPh7Ibrz13eIJsuaIOpzM+bZ1DzCCfzs16H1v/5wS4c=
X-Received: by 2002:a17:902:d507:b0:295:3f35:a31b with SMTP id
 d9443c01a7336-2984ec8c0d5mr19845645ad.0.1762942366026; Wed, 12 Nov 2025
 02:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
In-Reply-To: <20251112-resource-phys-typedefs-v2-0-538307384f82@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:12:32 +0100
X-Gm-Features: AWmQ_bnuNlJCsmBmrjk8c_BTNLULhTvw28twSuVwPkKbxpTmlUU6XbLfIppmVjY
Message-ID: <CANiq72maV_j1uV=2nPGbTgRabnk8cpc7TNN_FQ+ou52OpZ=k6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Rust: Fix typedefs for resource_size_t and phys_addr_t
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This changes ResourceSize to use the resource_size_t typedef (currently
> ResourceSize is defined as phys_addr_t), and moves ResourceSize to
> kernel::io and defines PhysAddr next to it. Any usage of ResourceSize or
> bindings::phys_addr_t that references a physical address is updated to
> use the new PhysAddr typedef.

Should we have these as actual types instead of aliases? i.e. same
discussion as for `Offset`.

If there is a change of these getting mixed up, then I think we should
just pay that price (not necessarily now, of course).

> I included some cc stable annotations because I think it is useful to
> backport this to v6.18. This is to make backporting drivers to the 6.18
> LTS easier as we will not have to worry about changing imports when
> backporting.

For context, will those drivers be backported upstream too?

i.e. we have sometimes backported bits to simplify further backporting
elsewhere, which is fine and up to the stable team of course, but I am
not sure if using Option 1 (i.e. the Cc tag) may be a bit confusing in
the log, i.e. Option 2 or 3 offer a better chance to give a reason.

Thanks!

Cheers,
Miguel

