Return-Path: <stable+bounces-70092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC6C95DE85
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 16:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5952830FE
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 14:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1261684A5;
	Sat, 24 Aug 2024 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ/gvwLA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C364A94D;
	Sat, 24 Aug 2024 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510737; cv=none; b=lwJyfUKTYmTB2JEmOGd80IocDJ1XzLdcEtluFOKZ2Q5oHp5vW5Z0dEfMqG0tccGzhedOx81cTHLs2skk/shIpRvt24LrVX63kFO2w0czHw3Rf12kCzeqZj21IcInGEAPSeboYoyQRH/XROatWzP2ayySsYx2EaLxfSmt2jaNXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510737; c=relaxed/simple;
	bh=hcZfQXCPMfbtBofazNo1S7/ZYeLZhUtzfyiS8oPPyz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKktHgKiDibWFZGLgU9C/RE4NZ6MJbvWn86moGU1UEEl1fSvLkJDrD3XxjeXXBmthr2Aihxl5ux2XLZwwgVIWVyjT9opGmHRKJwO850o+ZctMqxyWpPhdSh1xbZTo+lsGABWca+oRheWY29UKbeEYmxhWyrbqM9xi7HoJXSmT/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ/gvwLA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3bc9405c2so346377a91.2;
        Sat, 24 Aug 2024 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724510736; x=1725115536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcZfQXCPMfbtBofazNo1S7/ZYeLZhUtzfyiS8oPPyz0=;
        b=fZ/gvwLAEwlaEBk/oQ+/v6ovYVUTlrPiijoZE3gjQw8fLVKmzwMqpzgngvxWKZsKtj
         Z8XGVx1BnrP90uNSgMOxjwHsWYrHWmVK/N1RSLeVZMrMlucyUoc6avx4FICGPVUioMGI
         IOuc3hk8yXoXmIDEH5cQEvEgM1OE5H66JKCKZ6C57Ufhk3FNBQQmH4nqCoILWN09jwiR
         rSnSOtDyyE2KSeyPgt7j0bb0OPEfl1r0jaKr9VSNoXloKUHGhJ1sSFBly7abdkBj2dCS
         23g3rYFnbydt5gctMLQ7Hwhu5FOSXvI6PP/so1kSulWlGr4FtsFbkRLEICIZgoX43Zlj
         UKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510736; x=1725115536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcZfQXCPMfbtBofazNo1S7/ZYeLZhUtzfyiS8oPPyz0=;
        b=r21PfQFQxik3/QDhNkA2sY0ZciPmaxO/mNqMe5m5dCB6goImNze96PQxzFWJPlbE1R
         Hy+7TLxhDqG5WBsr6xJ22NS7if8koJZhSIKjAEy8BzlRW4+aiU/L8MWaCedbKf5Jjtw7
         9Jeg/0WXOEOEW5iYaXkrHlCy88K6m2pGrzonM4XqqBlYzo69VlKtb0Q4ertYPluwNCIy
         4ICQXnlp5YX08O9RbDXmuGKFM44Doq9SFONhf04mOmpSIDhjZwEv3NuH4bdyA2rORnoZ
         o9OLIrvso5M2PqFgkbCxsH87M2wY8Fpu6sc3eMLcJM0gAJjJqkVnzWfiXvxokpSv7ymH
         PBnw==
X-Forwarded-Encrypted: i=1; AJvYcCVFO/FGqiZRS7ES/C9CAMoP/pa1WYHMZmzeFp/53SkjvKzeF8gx5O1ls7hwSvOcWlUSpX18EAh9UYh7qks1cw==@vger.kernel.org, AJvYcCVWWnt43dCWIYDg4o3K2l9y9GAbR3yiSnsLnxhUzBI1E7xZpM6dHENM96h1Qz1aS3LxRl3ueobr@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOdmwz/4IXk8tAlLY+Cig6yoouqSQL7TBqq5E+P8+Nhvm6ghk
	JLcXurCJyoVnxgK5kZ94P6jSM5PSdBboDb+sfrTvwoKlCYj68RSSx+Wz5++P5HZMRbHu6CZ38Y3
	ETBUqzkat2uW+fYC8VjzJfPY1vdg=
X-Google-Smtp-Source: AGHT+IE+OBhuNFTc2DhxpTSuK3T4/iWGGKYoPxf5Nnc7rEcJ9gV3xAdvO1Lvms8P0I60wdRp+Ei95r14uPTkAGKZUPA=
X-Received: by 2002:a17:90a:1f07:b0:2c9:6920:d2b2 with SMTP id
 98e67ed59e1d1-2d646b9d9bfmr3741225a91.1.1724510735795; Sat, 24 Aug 2024
 07:45:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823140121.1974012-1-sashal@kernel.org> <20240823140121.1974012-9-sashal@kernel.org>
In-Reply-To: <20240823140121.1974012-9-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 24 Aug 2024 16:45:21 +0200
Message-ID: <CANiq72=WHzjck6fU4b-Tjv0iJPCT7EeGdgKbyQ62JwcgzfW+wA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.10 09/24] kbuild: rust: skip -fmin-function-alignment
 in bindgen flags
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Zehui Xu <zehuixu@whu.edu.cn>, Alice Ryhl <aliceryhl@google.com>, Neal Gompa <neal@gompa.dev>, 
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:01=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Zehui Xu <zehuixu@whu.edu.cn>
>
> [ Upstream commit 869b5016e94eced02f2cf99bf53c69b49adcee32 ]

Sounds good.

Thanks!

Cheers,
Miguel

