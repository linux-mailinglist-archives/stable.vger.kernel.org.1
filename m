Return-Path: <stable+bounces-191601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FCCC1A1E2
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 12:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EA71AA5759
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 11:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB2933A025;
	Wed, 29 Oct 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZNhZavJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584D339B2D
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738679; cv=none; b=aX2Ci0qP32VZh4UiSpIesFqVN2C1D/7D/NcU/p8Ar8g6nPQ3qj8q7Mj8TZzrMfCWNgXvffR8HNalABDjNOLXuEN9HNyTMtA/bgQEWlpOqdmL+CKGg8EkJqdl2reEH36/g5nhyJICRBZGvfLUzVkRJwJh4pKidogA+6mmuoIsmq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738679; c=relaxed/simple;
	bh=4eAuxRdra6xYn2AEu5URxIFLv0U3aPRV4JUn3Rr/2D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOjlejY2hSLN2Znud8tAc3M6TMubV18tu9fL3mXOiy4zIKXcZ8UPMkOhOq3mxOBu50cRj/swPioPoMgr04gm3K9Scm5wKjxJVRPANzHw4r8f5TYNyA/VRMJIEiGQDEHRWana4mNrVEfP3rjM+/cF1R+i2/NYaj5nupnTSGbQyP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZNhZavJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26808b24a00so9844575ad.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761738676; x=1762343476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eAuxRdra6xYn2AEu5URxIFLv0U3aPRV4JUn3Rr/2D0=;
        b=YZNhZavJSqfaJP3lGCg5xmuwsDrK3PMeTIXFKOFMbd/zeYvMmNHdthI7to4fL7CFDG
         FkWYH7RX1+7ztmcKe/vd/Q8ZUI9xHAipPxMUZbYZxJ3V3KUfdrVb0/7MP2DX2EtHyL/R
         NkhxXDpvBBgnhmeozECfV5WdCtp9JEnXWnSWA4RWusRdxorBmVcWFvWjjjuf2C7Jm6AS
         Xf4VL0wnxlxu9KJtOeCdJ/prKJLXaS+uRTlu4qB2mwB6+aU/+NVGVpqxZ+tYJxLlumKZ
         9jzJtJAtpByn0VCBuBxYLEvk6gUNndUYst10HUhJVo3lF1Jjcyx9iL+2ntcg6kxl87sT
         +KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761738676; x=1762343476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eAuxRdra6xYn2AEu5URxIFLv0U3aPRV4JUn3Rr/2D0=;
        b=kdUz8F5Ha3LFwjoyODRDKhrALdZOflQGWXy4/1P+ohAPfA3eshYc/jmq2MgRUzElwK
         GqUvr038O9vpzR+yjeftKwApLwJZmjfQTbbp+SvoFgFy3i7+g6ySXeamhxwcXzjQE+62
         +q4G9/deQeUGbefA5UfCUjAM17IsqhOnZj2mfUupHkxCWzb8+MuEIqQLOv0im7ZNR+W9
         quy6QvI/Mi3U46/7MD3FHLu60U1RPyDohtsmHKUREc36eUCu9jy/KLkurHtrcHzh++0H
         0WgvQUE2uB2tQzlfs2zWkUE+Qs4sbEnDYO/uL4GjzTvR82rTo+tFz5TCpteKLv4fQHVt
         /2VA==
X-Forwarded-Encrypted: i=1; AJvYcCWH+wf2uMk5G6Lm08IztaEh7RGbPzLadLXiOEPCicrVsIvPD6xrsnJFW0IKHZhxujuSGpnSZ5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7c1WQJu5fJs6GBVi4LqqT9hWC2G1cQ+OY3IzLawj8TNiXfLph
	WgpAAuBYx4Y6cTLED9R8qNziWwD4q7W7CI4nYpEUDeSc6iinoKp8QpTGUsqMHT7zY17Sqp+VIvj
	RBc0zCniS8TlhgIzKjffAYmiPZsnb3TY=
X-Gm-Gg: ASbGnctYAAv67vtJG2gPCq0Hd9mFRC560xvOfW9rRPF7Ml/GpGqLYuFd02HA//nt12a
	NY7zYBwv/BTczFghhMP7CB34sc46zghA6YxRUEqsfPYNB9uBXxncMuTxc4tls414+On/xc4Wkny
	yCKCKpDoqiXDYWHqLVnUbmwa3OqJweUX+QsBcdzgTnb9q6QS/B9xIkKlKNBSo/MSTQIKZyBVy08
	FCrFVEq20kSefNHv25wX6SXP1MU2Yg2pkj6ugOLHvLoQp65VeHR2EXKxTXTbezdjOx6APax6u8m
	stnw5kCNykDn3GWQThTUPNONYczxNglQsvMy1Z5qUfZfELdFzETFQvNL5UUb1O96Bps/uRJae1c
	ZnM0=
X-Google-Smtp-Source: AGHT+IHydl5eW0/Dx2EkVGLSZgmAKiTuqfAbgJdkgdsRFye8YTtzwH3XYU7OFAr/IP3WtWR2QZHXmGbjwyn2fqhtndQ=
X-Received: by 2002:a17:902:d4c4:b0:290:bde0:bffa with SMTP id
 d9443c01a7336-294dedef47amr16261185ad.1.1761738676328; Wed, 29 Oct 2025
 04:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029071406.324511-1-ojeda@kernel.org> <DDURZLGB2VRJ.28Y4AP92FNFPS@kernel.org>
In-Reply-To: <DDURZLGB2VRJ.28Y4AP92FNFPS@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 29 Oct 2025 12:51:03 +0100
X-Gm-Features: AWmQ_bmrmooyzWnmY9GxFiFIfc56zKAyCS5p4B1qi25Pm2Uzdfv_Hs5RDQeg1vo
Message-ID: <CANiq72=HhDQP1ucccLzZj0mtb5Qa8u-1oorRwCqNv+aEJfZh7g@mail.gmail.com>
Subject: Re: [PATCH] rust: devres: fix private intra-doc link
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:39=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Given that, do you want to take this one through your tree? If so, please=
 do,
> otherwise please let me know.
>
> Acked-by: Danilo Krummrich <dakr@kernel.org>

Yeah, I sent it independently in case I take it as a fix earlier;
otherwise, I will put it before the `syn` series that will go via
rust-next since it is not an urgent fix anyway.

Thanks for the quick Acked-by!

Cheers,
Miguel

