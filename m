Return-Path: <stable+bounces-132638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8188A886A9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407651902C03
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FFF2522B2;
	Mon, 14 Apr 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsNBtTCo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B844C77;
	Mon, 14 Apr 2025 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643321; cv=none; b=QYDsNh/4AQYoZZCEMMYfP5O57yjbZTX6NQi9VtxbsETHwTNgKoPKpq22Yy5PmgNmMjJRmAPWHAB7bopdvIHQ34V4YgDzcmB0cM20jCJ5xc/yjCiwf5vBYMH6xAAUzDgKQyiJRC62H3EYjPdKDX/crJQK0d/Ofc063Lyd5hUbfbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643321; c=relaxed/simple;
	bh=DK4Qu0qldN+pzv3ZrtGi5/PL9yAuBfEn1jbExHHQuoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLym3XuETicsYQO3Izc2zJT2z0kjldwaZvWw77Q+Iky5dJRnyAfhb0u3XqqKbkzMZfGqbcILpFMLHxS7/LyFeKSSARviv83bfYvbtcab5nU4BAjelJhQI/Fr+HeLim+Dl0RHMqSAybBD7nh7+o1MiRcHTVahSZFBTMwbKPFfhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsNBtTCo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so782632a91.3;
        Mon, 14 Apr 2025 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744643320; x=1745248120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DK4Qu0qldN+pzv3ZrtGi5/PL9yAuBfEn1jbExHHQuoI=;
        b=XsNBtTCobxxpHg3gxMNH59EaDjByQJLkX7vcxz88dfYJ+xhHCqA3XZGRNIAWx47bBS
         v4IBRLC42OtO0DhjCorpj/vAXaN6nOTf7YlU8g7OqurVo4ug+uQmfdoSMzzyYYD+IAKd
         VIZiJzgDdloiiEADELETnE58Ys1w8wu7aDRjltoz0yCIPbZGZAIfTRkWBpxOKbyTnsWg
         pzSo/EyCW9r3LxZh1hSGNYq1DIQO7UAyNAtpV45ppHxHO+UxmfPQQlml70b99jp0Wo59
         U/BBApiGRr2z3xzoHjHmUI/JYtODrr7cAOGl0mfoIBx8oFBYi5s/9+u7Sz6c6HVoRJbc
         1BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744643320; x=1745248120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DK4Qu0qldN+pzv3ZrtGi5/PL9yAuBfEn1jbExHHQuoI=;
        b=Wdn3UuxOfPJh7mv5Y+nGv4c4wJW948AzTPywhGDglpzzLrOH0YJFcX9m05HPyJnNC8
         sAAlcVx/3mFFkbFQ6JyLELUVG0mmz/c7jPqZazPTY1HTfjwMOhz7hmcIzGvw81m7d1s3
         UJze7bjbv1EyMFJ9r8V1mjIQ021vOpnLODZubcjJ0fUvBTS9pwxx1kAlTZ7J1a15sMVr
         SKi6XO7srIEwgYWCpf7EbwFb0IurVn1OSW0y/YSIbaK1NMgWHcCcg/csbus6ufY0Ndw0
         L8I4nBPZ6yv42lMuY9KASZ98I/hgT2f1QopuOn3inoNuooSwk+bXKyPlAUuvV5cfTFof
         PODQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwImfnndvjQqwaf8zEpH7runshI5XGa7lf1ATKlacTnErc+sYoZiuXVUkjiAUKcw3ZA+yRd/L5@vger.kernel.org, AJvYcCUxpv2z2RnTKLCRbiooMg6op+1UcwnYfgtoPK6P3We/ASyhLgHnWutTXCkZYLZcIagQFd6ooLvGUhjx5SI=@vger.kernel.org, AJvYcCVkdmuk3yKPjSUqBIakne8jDioHvDdZm1wKkqy40XI/tTYNJiQct/HotJwz81/vabIcDwpU53k968uTDXU/IgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SD/JHC1GLFhCCB8ri3IQ0o/f9WOsgf8t7oTaV88YtpUNb75a
	TXWLkLYJVgx5Rs/0mTVRTOUkS2LhFpxVVC4EsfVFTD/eFeDjTNqHc/g32Z8UYLNfwwqVTb3DC2Q
	jHF4nE/aSXRcowVHXgvpeDertkFc=
X-Gm-Gg: ASbGncs2HaZBSEAE2ac7xdEFRJyDI10z8drS48RcrMyIiSWcptzcfgZzByTlO/9DmOn
	A3WfKFOH9V1/2mprqU5d5Asp/SncavAFjtYD13cN87a6lebufjBepb+QvuhLWzw7srZH+Pp1By1
	GF5RNfpEPAsFxq6MIOtvapBQ==
X-Google-Smtp-Source: AGHT+IF/3Sug4cH71Iy1yUd34jEFWmX1uxiWoMXWWYEYLAEU8PckJu1uG0PfMyeFYO7FJKOwZzJ7L3pUGCudlaYn1Cw=
X-Received: by 2002:a17:90b:384b:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-3084e75753emr84387a91.3.1744643319470; Mon, 14 Apr 2025
 08:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250413002338.1741593-1-ojeda@kernel.org>
In-Reply-To: <20250413002338.1741593-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Apr 2025 17:08:27 +0200
X-Gm-Features: ATxdqUH6rGk6r6-lQ_KWE9TQvnHIiYAFIJPEWNi0sSuE_uUs1uqjOst-DwFVQ_g
Message-ID: <CANiq72=W_JOV+WLWFpkqt=cbqOiOKkxbsa4wvyuW82O80srMoQ@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 2:26=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Thus add it to the list so that `objtool` knows it is actually `noreturn`=
.

Applied to `rust-fixes` -- thanks everyone! I applied it early to
start to get testing -- tags still welcomed for a day or so.

I changed the title a bit (adding "for Rust 1.86.0") to avoid
confusion with a previous patch (and future ones), since a bot already
got confused.

If `objtool` prefers to apply this instead, please let me know and I
will drop it!

Cheers,
Miguel

