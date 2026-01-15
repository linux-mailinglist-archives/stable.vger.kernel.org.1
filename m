Return-Path: <stable+bounces-209957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE26D28AAE
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 22:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EDB130215D2
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B4832471E;
	Thu, 15 Jan 2026 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE2wCFq4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F432573C
	for <stable@vger.kernel.org>; Thu, 15 Jan 2026 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511568; cv=pass; b=sNNzSv9Ie3SmNg7zwkqRRfCY8v8OA7Y4/iS2cvB04AbYfH14ZGSY+jftBtDFrpnzHegyDe58Tb5ZOsIE1mFdeLQNhx3qWCmzxy/bZqAvOTG2DTC1dnM/I7GDp36Y7C0L8PES/Lmm480+zNXpiogZTqI5ePzyfFxkd5HoyQtasME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511568; c=relaxed/simple;
	bh=eWp2kr5mDcUCWr42I05pJmfkg2nITrvdljuMGPPIAVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aI8DzQxfR+OuUrU3+64fwK/QycXvl0jjQcnICBAwmjenqDbYcKz9BEnh4LrZLRGm4Dlu2xbRNM2mXzjWXJFWHh1HNGnrpYUTkxgoTchmqD1qFabccR2yyAKveIKND6GOHPlomTlOopSOnjQkN8I6HcX1BB3VsqQESgaBYN2Y3Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XE2wCFq4; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2a44d954c24so81055eec.3
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 13:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768511566; cv=none;
        d=google.com; s=arc-20240605;
        b=RVSuirLZlqtiTeLQo3GybH+geHsz5bAHY54w2YCcejJRM0330ycL5a9+CdJp8v6iU/
         CFmVnsNNIyLgkvmqssDx7MgtdjzTTVVzjKhYOImZiWmzGEST99MtiyodojsmJ0Um20CE
         wd56CgsQtuP+/MQwv5kTWcHpepfDswqvxrIA55J5UK+jLm7UNra93QggsmcM1M2J6Ba0
         Ku8+Jp0dVmR0hjnjEKisjUyfgTwsDMlFAAnAuLYZ1yTg5CiQkLgd1tyStRe8XZWeXkyT
         reKRJnJ7fr/IZkpbF9LTpeuitUpqIWVKc6h/adYefkVZ7AFNtCDx41nsP07AJSfQ1lXz
         MoNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eWp2kr5mDcUCWr42I05pJmfkg2nITrvdljuMGPPIAVo=;
        fh=A85XMwudf0o9EfGmPRHYSBog7XvAv8iIpu18JnBg60o=;
        b=CB9evEn15aRch/7NZ/9shVDNB+Ekb5eu19TdykcStMGbdLE1bgb7M8Vo8vZkojGMQr
         Nc3lElqbytK5K8Mh1SrcQtTXlZj93ZTKTcAbqGc/OWOAn9NacklNRN8TWrHruPR0UAiM
         sRyDfD8ZFJKouWXP/KBW54rl3CbJMBdOTclgea2NBKTzhcAv5IOl1Bro8zQPYExN8mDW
         cp+zaSUO+Af8AL/imGS+eOFX3kVqWxCuRhl0Q7xekDMx2tLBwaeutLBm/MC3a09R9bBu
         2Ekw9HTH6jXfwMmx52G2XqpYPvDie796oQYIq5il9lffHI2NvpTmIl8/gYnSSKZ0Mq8S
         MNug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768511566; x=1769116366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWp2kr5mDcUCWr42I05pJmfkg2nITrvdljuMGPPIAVo=;
        b=XE2wCFq4G75Ui9snd1KyQlMY0Ec406W74mRt/LHgPn3DstOJeptUsXRC08JvuedrTw
         tiyrPwPfwQeZ0CHaCDghFNvkyRHmYWzcy0M2VdrEVbZsXINqH2/u068puphw+RucvUOj
         aXeYMXnbjhnLm8ucP8XviNXKpuJYG2YhFV+xqFzBng3z3yNh4Qv0WC5VayBquKLOk/c0
         8XZNUBsjLm5Kzfjzw6KLVsqRRlsRU4gvmt+pebK9Rs8Nn8o1+uC0d6Yt1GZ1n+9YI/Ka
         TjMtp6A2/cTWOkFl2wIw7aTDu84/hKpqjR2M6qwwgCKdUK9Bz4gaq26Mr7f9wWIwNNJM
         FSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768511566; x=1769116366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eWp2kr5mDcUCWr42I05pJmfkg2nITrvdljuMGPPIAVo=;
        b=peAjME4YBwyGwX794NycwQICBuqsj4082qHvASdmlv7wrzl+FlhrpQwLqzvQHCqE1u
         mPHhNlqzWpmVdP/tyqqq1+fmxYxDZHVsiF/qdaGL0fSlTTnC8KxvgmL3s7rVJkrL+xsI
         76nh4W81S/rIvCgQpTdOwUNkwVrL8vZm7kSnM0AEZ8aUA7JUWzNOdY2Q0rzHD/HL3KMP
         nazhhFn6o5jOvim/yB+D9uGAlxO3T9y2LIAa2rpWGZ1sE2SdEovCAUX9PyQ5AOVXSzrL
         XTFAsylmyPGkYIqP+DYAPRgl8+Rvmrpb69BsntFjyoWa7YxjCLrIApt9LLhj8GOGhrEm
         +GHg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Z7ntYC2osm4Jh7SiEX8EuUfOoNa44oyyGHJnTdlwWXbJZmtO4TKImByHC/ghzDOYemW2b28=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1uQ5sR9ek7ofrcyFUN20z97iW7KluVQqqDbggTnJL7+jY6uG
	kd+yrSYyEfVE3h8+S2qLzbay+VvYcfBcpK8sgxlkCFUN+KH5+jxUGqRVwuoL58J/5su5cyXKa5v
	zx1g3q7mB0yXecmwna3ZYiMR7MGqSgY8=
X-Gm-Gg: AY/fxX7jstzWtrMR5gZ4Fily5PBANRgY7zTnqbRtZCfNNJrGUdqNWkXHRAQ7ZGKGmDe
	gjKvbTuR8Xz7pZRj2CcWs3oYCGBxYbsGYCXQbDj7rAKeuNeqHXZxzlGeRcHgD/xIN8+lBnO9YR2
	Aq5b25/cnp85WIiKaIXLhkrvXQtedhU1Z/HOCd63OC/RvJ8eFJ9YnveowG1ErrJev2HFkSuaS/Z
	rImjuU0W48HFQ0o087Yixy1MOCBkzGptUgCpcO8nLsiYJwsIYelPe38BflVZi+nQR/GNpNFLM0r
	k14ufp4bJXj9ODR/CuC17lNvJ3Lf9T6WZrERYKgfDy7U11n/79/fh/tZmMJimHBhGZ6R8bHu4pI
	Ia1zXkMn9znlOCjupnjokaGw=
X-Received: by 2002:a05:7300:2211:b0:2b0:4e90:7755 with SMTP id
 5a478bee46e88-2b6b41219a4mr443036eec.8.1768511565770; Thu, 15 Jan 2026
 13:12:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517085600.2857460-1-gary@garyguo.net> <CANiq72neLdtGORQ=GMsJ-mVgWscrAw4CB+_2cfbR4gtju4+azw@mail.gmail.com>
 <CAJ-ks9n2pXZWUePZVNbR_dtvtdjZ0uW2NknkA69UsFeUiCV_gQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9n2pXZWUePZVNbR_dtvtdjZ0uW2NknkA69UsFeUiCV_gQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Jan 2026 22:12:32 +0100
X-Gm-Features: AZwV_QgpY9NOETAmWNodXN4EHE24mi60VbXv3TD46aMHdmcI3MGPIvhsDDShtIw
Message-ID: <CANiq72k_=37BXwgkBjj31N48njMSJBB7aT=JT9GV06dVA5OB8g@mail.gmail.com>
Subject: Re: [PATCH] rust: compile libcore with edition 2024 for 1.87+
To: Tamir Duberstein <tamird@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, est31@protonmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 4:51=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Hey Miguel, regarding the rust-analyzer changes:
>
> I see only core was changed to use `core_edition`, but other sysroot
> crates (alloc, std, and proc_macro) still compile with edition 2021
> despite all having been updated in the same upstream PR. Was this
> intentional, or just an omission?

Hmm... I guess we overfocused on `core` here given it was about fixing
that for the main build, and I applied the change of the edition for
`rust-analyzer` too, but then we didn't update the others, but hard to
say.

I see you replied in the linked Zulip and sent the patches -- thanks
for taking a look!

Cheers,
Miguel

