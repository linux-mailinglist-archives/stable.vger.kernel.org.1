Return-Path: <stable+bounces-210043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C06DFD30AB7
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 868CD30115F6
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC72D37A492;
	Fri, 16 Jan 2026 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftQZ+rdP"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EACA3612E6
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 11:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563944; cv=pass; b=jhdxDE0HDnYD8eWBOZg5BrUux55XMozKCNcE1u+FEiCsjwWY1oxdPTURqOdcNvVYVutIk0th0LY4FYYBO6atoF/pgPdDn5WZBMSDXcq5F4RZG2EQgPRsHCCTxoabvfJ1bkznHGJDGO7mRAUGKTLZAs+hY2Q8eDx/e5W/cvy+O3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563944; c=relaxed/simple;
	bh=pTJDT6aBf5f2SgUDw2Y1HK0c40HgHOOicrIIXRU7nrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZryYIgNeXa1lHiwYLfs9oK6xVRyDPhwT8eRt/UFWDa8zUW5OdTIJI+VdrlFvioupB3z157ZvjWqHLIC9h5C48mfyXnWBvxq5SaRUupLYZ8qF3JZjgwFB+n3bVuGRO8Fai3bq+HIid8MvKK5F4dCXFRKfyOMvSV9D6VLrX3qMSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftQZ+rdP; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12336c0ae91so136091c88.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 03:45:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768563942; cv=none;
        d=google.com; s=arc-20240605;
        b=QdHKdWibJy7K3zSmBeAy3F74CbtVT0LbnyIAXv3T6jpL9oIGBmf45RMabbPrtckkKS
         IppIcNza8US5cn7EzdxJhB3u70wMvS8Wi5YMowE3YZiwYuPNBFFdAR4HhwG1B6peUHs0
         eh/761yApn2B+ISgM6pLmC6Gh4qyBqftxxsBSYwblP8tNPSWYozAeNV9n5i3dQAbNodp
         /Z3lVS0kZrUsW3MF+G5HThuT1Q6lBzN5oxEY4rUytDacdDAh9aZW5EA58kCDO/HyZE+5
         BOJuOTq2T/r/rXk75TjtZDcoYTPKeCr4sqMugyvyegy/xqzhtFdh87/BmhzzUsA4Zqsy
         tsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pTJDT6aBf5f2SgUDw2Y1HK0c40HgHOOicrIIXRU7nrc=;
        fh=DC1XGE3nVjIn90Rsxosr0wcxOe8xW3huS4p9mL72Boo=;
        b=LvILiDIMecmZxiHu4Qy7bnhcAKcO/67Pgm/Su/Vul8jsssCskq4WMqXkivoFL3oC/n
         gNnnGYJ14I93RFKWU2DyG+lS1W245F7BdhN9qC5+uTZM4yhGiJirZxKki2oEAoqw+OIV
         dPGYP8TcB9l0bNRD+uRgVjwJj+WtudXVLWOCcaucUxkpPlnloBONXuwJnzfVRqTWf+9G
         gkyLWQfxtYOADD2WuWQGKFajTQ63yh7DZ4R4+8X91f4IWgDsmes4f4Z+Wdz+Qd6hfbez
         5VG3DzAtk9570dmFfOX8oEHo2A7n6UbrvHqLjOy3rvDosifM20tPF7UGnHE4Ba3R+A4o
         qC2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768563942; x=1769168742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTJDT6aBf5f2SgUDw2Y1HK0c40HgHOOicrIIXRU7nrc=;
        b=ftQZ+rdPu+KCwNQNzIyzTo88PpBHmfAC497r1c9HDY+90I1SYN90jHPgDcvxEQYd8T
         2iFlvRY1omULGhpQHu+c6DZeN3WxPcyCQp5FqS6j+Jol6nFoegbd7bpFVacrYhRj5Xog
         yyJKH+VyyF6ovifq8ELpEE83G5uxss5nQ1kPGJ84qtHVBruoDZhqbiOOv2mM425VOZ+Q
         +piydc2O1PTkiFYCmyrtzpELAMbNA+Cg0JWM8/NSkjNQP7cXrYuEN1CuEorDkBVs8/A7
         ISokM8eqO5WKn4+n73YwBCDu+Gbes/5y9yoEJtqf33s00vrKSQCmmNHKKSY2K1y2dULC
         Mgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768563942; x=1769168742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pTJDT6aBf5f2SgUDw2Y1HK0c40HgHOOicrIIXRU7nrc=;
        b=YyzJ0qYzzmRXdCBSJH0uIA+i2fCGc2P5GKS/mYQw8pgtmqpbmISqNmOzngmwIcO15A
         qTtI5LTvrPqirwDMXG8TNBbT2jtlb9+YYwXUyQoLvGbxbb6DgEFt8dHSkRv+Tyn8SYje
         /OcLDJGOpOQtDt+R8WrJo01EvrayrIPDdXS8lRB6xLJmtY5JsecmHtXrapxYEg9vCKZq
         lUYw7T8paAWU6fCTAJR9jnY7t9pLYRg/b4YQtcnLHy8T3cgpTG+OPn/r1ks+PSgPVWll
         SOs0thwgc2MA6wIlPfBL5EGyAxv4q1lYBbOMDsV9kKhqWv0np022B9XglV2GzdBy9ICs
         nidA==
X-Forwarded-Encrypted: i=1; AJvYcCUAwBklPuBAymYGBmwCckmMOqzqhJ4bbhXOXL+ylmzqwxTB58glJyzfXM3WBxm23jX1s+T9JR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxop1YjkdlTs6vAuXXYGq91we5JepPu9VplVmlVjKtaa8gbNMLd
	q72WIOFDS5GdCb2z/BGLHIx+DJ0R1CIOJ3gMxZcG9TqqiQPRQFwcojplLkkYoaLYAchIMeL7kZX
	xFgm/DY1cs5AHsHcEYusNVa8KGQ/YyzE=
X-Gm-Gg: AY/fxX6HtRPimGEbtLCIPEuJrRpNOdw/IVEK6AaRw68ubCPM/u0YvYKz9IsvesV0EUR
	kIuxl63RveYd27T7HA/UUQEjIDUjX5uXKeZ/YmdQm81H6jkG/2BUspTslXTG14GAhCDGbMUx3hF
	y/2ehiqpKnHTSWdsCZQk4UOyzMnAvacAi/FpR6z/zkz339EotmLT077+ks2urvmdw02tKoqTcGa
	hStm1E1ZV5BR+Olwe7huHZ5/MP0BYpIaeWKT5X6lyzLd7KUbV42FJ17i3ErxpmQ9uQJxnDc+sec
	T2CFP8e0Piqk9mU16nQposxd6RsuOqRX5iF/AUHobpjgOGoIycqo090AfNTi+YEboPk1kM64mce
	LAh40E0Dp70l3
X-Received: by 2002:a05:7300:c88:b0:2ab:ca55:8942 with SMTP id
 5a478bee46e88-2b6b41158fdmr1228451eec.9.1768563942070; Fri, 16 Jan 2026
 03:45:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115183832.46595-1-ojeda@kernel.org> <20260116050046.GA1452322@ax162>
In-Reply-To: <20260116050046.GA1452322@ax162>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 16 Jan 2026 12:45:29 +0100
X-Gm-Features: AZwV_QhV6K-qT3UXCGRcMn9P3-NDEJ2FPKUMtsDwU-sRw8aTakC0RUNjVyAPQqo
Message-ID: <CANiq72n71Pm84F3CvFebdXumHp5xfe9+DPberh_64v_8do1qDg@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: give `--config-path` to `rustfmt` in `.rsi` target
To: Nathan Chancellor <nathan@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:00=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> I assume you will take this via the Rust tree?

Yeah, either way is fine, but I can put it in `rust-fixes` since I
will send a PR in a few days.

Thanks!

Cheers,
Miguel

