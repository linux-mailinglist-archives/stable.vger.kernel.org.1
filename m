Return-Path: <stable+bounces-42886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE068B8BD6
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2061F2231C
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7C512F375;
	Wed,  1 May 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR3GKNBr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86C12E1D5
	for <stable@vger.kernel.org>; Wed,  1 May 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573586; cv=none; b=pA6hNwkb6ddmYGVKGh8eW2UdSyGeYncZJYIRsoFTDX4OKTCNnvMVzdXk1xSISRd10Qva9g5sK+YKn93proRr+CfM5IwaV2qbfdPWc0UzI6fo7Ebn2uOigbF2NysiFNpDB9PIzSXS3xIkuzsA779F+RThrzCr43PVERQQXx/vOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573586; c=relaxed/simple;
	bh=VMK8NfRbve4gzuW1Uj7KOo11TyYI8ivwy7m1/k2iWxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4K2J3LDP8fTifdsfZIgtQlKNjFgZTaelc31Rl8JYRt6fyA4KtDRPL/5QEX9G8kQgHHhLCNzzLNgoWgbEGP0yHde6IaHTa/Rh2ZoTIesCwUmCc/1z6oSTg9uQXD386nPaiwCnwK/843dig63b3HoaPVYscOyTC+k0PN+7QQWqb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR3GKNBr; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso5812502b3a.3
        for <stable@vger.kernel.org>; Wed, 01 May 2024 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714573585; x=1715178385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMK8NfRbve4gzuW1Uj7KOo11TyYI8ivwy7m1/k2iWxk=;
        b=PR3GKNBrCbtNw22y+eHDXnDv4AKqxJtNc6izRzC5C0vjCg+5MLBpQiZpC74DhiQTPZ
         byyJTUWXxlzd2DN3JtSwQY53DBZD1yq+FlxbfFbgh3DagNSgeCvhl9eTkhbGMBgsEj2Z
         OANXen3cbATyWjdhHiMSLWSrtrgbdbhozHhwjlHVCri1McC5ooOv2U342N0BsA20K1Fc
         cWzayZUrdrrlHPdOciFHKdnVf8utAbeHVHV1ah/euFxORkLc2SqM4rJRU/F33Ze/8jGk
         jX6cbu7ok3yZAn4lbreQvp/ebLI/Jd3I1V71z31MW7MzZd2aI6DuT+137UVQF4vTo7Ee
         KRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714573585; x=1715178385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMK8NfRbve4gzuW1Uj7KOo11TyYI8ivwy7m1/k2iWxk=;
        b=LGT7e7vZw53evJv5ixGqVdcJzKgUt5CjWhXUACgWikfzxGEg+t9XVz7W65Ecedx1eD
         4lZj+XXc+moJgJRt7bvgGlx5eziQxtmmgPl4g58Mlt8TMljafJ8U9GP+jS5qBDrqVE8K
         xNEGWxtpMjpZrh5PIE5dk8EhwY6sZ4KfyX8nVvfn1mVUf18UGAi88lQeA+bev7CX7P9C
         N4Nwk21a90Ta6eohPxZljkzl5N8+PDYoGUnH8oPdCpNLFvPUn7a/hPRCOQQo24r+FIEQ
         9tOjblShNLSWI4M+FCXYiichHjCqaPqBmQosP8UdRinAhOenLPwHt5PHna5OmreIug5O
         rO5A==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZIUMYt/4B60qB2e4gtc1hovfC3N8Lhstd5GLowBlXvZ9DiLARDi8RtGT97iYYQ+mPV4WvzUnzRWnw8nvLHzwZZFTviz9
X-Gm-Message-State: AOJu0YzF8u8rE9KHZ54bEKYJ8asyDFbJgbu/LO8UAcEcNNAi4IvvOXlY
	XAqH5ix7htFZmXYj+MGLv5i2IB+I+8udYits39ZYBcNyRuxKLHP8nVFckoV2KT6iJ199QkIZarB
	P6hSCKEOYgYoi4TMRBEt7iuub958=
X-Google-Smtp-Source: AGHT+IFvdrloBj9qBCQbJx0zswt5OA0qk6VQ71xe1l10fT/mW82DI+iXrTryPbGMqOyaxylMltu1arzS6YvzA7tanw4=
X-Received: by 2002:a05:6a21:3a87:b0:1a9:852f:6acf with SMTP id
 zv7-20020a056a213a8700b001a9852f6acfmr3518534pzb.11.1714573584780; Wed, 01
 May 2024 07:26:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024042940-plod-embellish-5a76@gregkh>
In-Reply-To: <2024042940-plod-embellish-5a76@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 May 2024 16:25:08 +0200
Message-ID: <CANiq72npZyXLXBZQe3gzPX-geyUqkF1HNg6H28TKr9t_BE+DuQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: macros: fix soundness issue in
 `module!` macro" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: benno.lossin@proton.me, bjorn3_gh@protonmail.com, ojeda@kernel.org, 
	walmeida@microsoft.com, stable@vger.kernel.org, 
	Andrea Righi <andrea.righi@canonical.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 1:21=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> Possible dependencies:
>
> 7044dcff8301 ("rust: macros: fix soundness issue in `module!` macro")
> 1b6170ff7a20 ("rust: module: place generated init_module() function in .i=
nit.text")
> 41bdc6decda0 ("btf, scripts: rust: drop is_rust_module.sh")

For 6.1, it is a bit more complex. The following sequence applies cleanly:

git cherry-pick 46384d0990bf99ed8b597e8794ea581e2a647710
git cherry-pick ccc4505454db10402d5284f22d8b7db62e636fc5
git cherry-pick 41bdc6decda074afc4d8f8ba44c69b08d0e9aff6
git cherry-pick 1b6170ff7a203a5e8354f19b7839fe8b897a9c0d
git cherry-pick 7044dcff8301b29269016ebd17df27c4736140d2

i.e.

46384d0990bf ("rust: error: Rename to_kernel_errno() -> to_errno()")
ccc4505454db ("rust: fix regexp in scripts/is_rust_module.sh")
41bdc6decda0 ("btf, scripts: rust: drop is_rust_module.sh")
1b6170ff7a20 ("rust: module: place generated init_module() function in
.init.text")
7044dcff8301 ("rust: macros: fix soundness issue in `module!` macro")

So essentially 2 more commits needed than the dependencies quoted
above: the rename (which is easy) and the regexp change so that the
drop applies cleanly (which makes the regexp change a no-op). This
seems easier/cleaner than crafting a custom commit for that.

I think dropping the script is OK, since it was already redundant from
what we discussed last time [1], but I am Cc'ing Andrea and Daniel so
that they are aware and in case I may be missing something (note that
6.1 LTS already has commit c1177979af9c ("btf, scripts: Exclude Rust
CUs with pahole")).

Thanks!

Cheers,
Miguel

[1] https://lore.kernel.org/rust-for-linux/CANiq72k6um58AAydgkzhkmAdd8t1quz=
eGaPsR7-pS_ZXYf0-YQ@mail.gmail.com/

