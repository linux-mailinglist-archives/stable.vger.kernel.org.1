Return-Path: <stable+bounces-204862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B23FCF4E8D
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8876F300EDD1
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806B931ED7F;
	Mon,  5 Jan 2026 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gh30nWXD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06F631AA89
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632924; cv=none; b=eRpZr/BLMwsr8ESwEFMHg7bBB6y0yXmQy2AJKPaBxzHv3wOYx0LlCj7c1TBocKu8y3LTg6dcCdMvdUOhVMjfvU5/+CH6NTHVyTDqVwL8zwA41FB18yqj+hnGAZfuURdk6zqkz149wdsvkrgf/EquCm5s2M92+WG5G3615ObxAPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632924; c=relaxed/simple;
	bh=amfRoCSnm0J910VRHPtMl2YPDj4b6nYy1EJ2w+HpuP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fbmlyzj/rivXnLCRH3hGyoe/72IHW7tDLDB8qopvxlpdzdLa0gzNRoLAMnqgnEdsD4nB4arCkG9eDGLqi6h3EK8zcu1fHtlU3UnolPqNYTIuHlnbiUwGqh3IQIItUucPyPFXaNRRDgo56mfJnZbiIG6836GkHhilN+/dmzw7/d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gh30nWXD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c46d4a02ff6so933a12.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 09:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767632922; x=1768237722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amfRoCSnm0J910VRHPtMl2YPDj4b6nYy1EJ2w+HpuP0=;
        b=gh30nWXD1fi6b/pzMa6xqTKD91xdz8/RpmQAdRjsyserfXNblAaRtDsjTu3Aajp2sG
         e4DipDkgkdMbKSZKr/CmFEfnPcUDf7QORRtX3w4GkIOR4kVrxLrrdQQzoQjgnX3N1pis
         RI1T5PF0+if/e3zQn2GKcxNnBqOQ2h64+X/lVC8HEB29sEtHRmvgKT571icXmiyoGLp8
         gFUGXmwgYUbagcGsijWQKPtIDOzDo/T6ZzyFJ+2NaVAIdGr3BaQkKsakPAYPAL31s3OS
         VBAfA5s/56gH/msbrEWFQEHxOI8d1oICxlb/VPE5xlYs+bThhB2scs7P0R75Lf+hhpVT
         ep4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767632922; x=1768237722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amfRoCSnm0J910VRHPtMl2YPDj4b6nYy1EJ2w+HpuP0=;
        b=IaBTDYtJMVdBGFIAwjLfnJFiC6vJ/xExY3pKdCla13FB0Dlm6MjlODGWN8XlhuDS5L
         kXlU0O/3a25q87h7jbXZsnv/zmD68CBRZLj87qfqmbsxaJyDYAiipdL/muvBrQWHpvxe
         l5o0GmiOwBVgWo66Kifojb5R/a6B906mSyg3CUobd3WZtmiZeviL+6q/7asaeV17fTvI
         koBhIjbm0XMch+XbGBbdMNkVqo3+XvEqzm/JO7unEceB3Lor5o7JWx+X+IYy2yzm+6fW
         d8J/Redqrq982uACNF3u+LYf/jbFCaWYesvDAqFYTWuN7keF86agbaJtWkQ95dgY66CD
         vWRw==
X-Forwarded-Encrypted: i=1; AJvYcCWAd0pGHouuwbQMV4CTVTzdEef2xBJtogbJJW/q4NLFoaQb3wgiqaPnB9LZyt7fIGGpthqDNS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOgLv9kqod4b0VrXIpdFS22zxtyeANeLCb+ZRbF0EOFTQoaxJ
	0NvvROzjM0XUYl1KAlLCzXc6YMhVGYgijfIwn17q0zLPoZIYvQd6eBusFwMwpdGqoxRqsKj2h1W
	NbTSjjM0zowVzLXyrtLYAdazq5d89mZo=
X-Gm-Gg: AY/fxX5VU+g6R9qO08Reod8BH8UkwDm0SpGQ0S4rQvcLcKJ5ydSHRjYQg4f0bqneXj8
	hfRiHNPiFoAP2TwpCP1z7vm5Un1lb+zH/YrDyKaBCooayk2pHaFooVVMLbkqFA4gAzGHPLJdbRT
	jsfD8SO1RdKCeW+UjyhmcWGPmZ/r7+oysHxbwGhYarpeZFyg3odOcFOEpiMOtfVueH8w0BW3FE7
	P2jR+R/mNl0pGkQu7Q+sKUgXsJl+DUc5InyJrOx9DdX99ldeT5C+Pdwbq+fA4wOq5XZ7Ic8xdgt
	Emj3PYxCU85angfBU/UyjoUd9xZ/BNfAtNcKGeEn508VcGO1SLXaYBcWOcYH/S5JN9EJcU4ZDFm
	uWCEJR781YM8RNVra9Txli5U=
X-Google-Smtp-Source: AGHT+IFCT77sjwP8WsVf38KzNhLSc389Z74WR6RbIKpq8/UH60ZTJAVplwJhfAbh32hVQxJxWaSPevjz136zlkFvBOE=
X-Received: by 2002:a05:7301:4090:b0:2ab:ca55:89cb with SMTP id
 5a478bee46e88-2b05ec45daemr23837094eec.6.1767632921895; Mon, 05 Jan 2026
 09:08:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com> <aVvu3zF2rYKR3XC0@yury>
In-Reply-To: <aVvu3zF2rYKR3XC0@yury>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 5 Jan 2026 18:08:29 +0100
X-Gm-Features: AQt7F2qgJhYo4wXjROBopa2fcjVagJmY2X_qZO28fo-0vjIHyCZZM1weSHo3PZk
Message-ID: <CANiq72kXNUQtFRDHrcox2GK884mgux0CCntPo_r-gwxzkTNQHg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: bitops: fix missing _find_* functions on 32-bit ARM
To: Yury Norov <yury.norov@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <bqe@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:03=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Which means, you're running active testing, which in turn means that
> Rust is in a good shape indeed. Thanks to you and Andreas for the work.

Yeah -- to clarify, we have been doing "active testing" for ~5 years,
even before Rust was in mainline, for several architectures and
configurations. :)

By the way, this reminds me I have to reply to your other message from
a while ago.

i.e. this "active testing" does not mean you don't need to test your branch=
.

Cheers,
Miguel

