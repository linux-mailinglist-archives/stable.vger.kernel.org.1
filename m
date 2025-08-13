Return-Path: <stable+bounces-169339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BF8B242F0
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 09:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B7E1B6305E
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313A2E11D1;
	Wed, 13 Aug 2025 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYNS9sMr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5C2DCF42
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755070861; cv=none; b=GekliS4UyWaxi394Etsxh7SIHzT1I9kgcdK8LdC2c9hfuRk0t3HWFhm6GQqAoVl8W3v6mJHjSZjsuEVFXURLFSb0RhYxIm5VWNQIyrgJAZlvsjivJVAr2O2rB0iZvvcp5FUr4k+8gWtoedpFrlSKgK5GMiY3k4zDsuvj/n+o0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755070861; c=relaxed/simple;
	bh=c9Ccc4FdRlKahKVue2t027gTXn3WFY4nUn/bdTfbFWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcNMb0WbIG2By4+FFj3Z++b7gzsUZZGc0fCslPaWXIwm26Gg8v1TUjZm3qBj2RvcxtXaMb3Ctyco0ALtm2RSqxkGAO5yCx6aHIM9+UOep9ehD+9RDRTFOz1HhgGSzUTUulDeA+S97ANOMONjE2xmVeRp2JqdvMu+LDE5tJGgTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYNS9sMr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b788feab29so3849103f8f.2
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755070856; x=1755675656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9Ccc4FdRlKahKVue2t027gTXn3WFY4nUn/bdTfbFWk=;
        b=oYNS9sMr6a1jozHeEjf+SffWX8dSDvJxiFp8QIjNJr1EF9wwdkZQsblYzf+SIU/YY2
         4bxlhy3CpnZy/s2efNbWCnwrZeR2q9Ut1aWWoZ+TKwEgxVjN83WTgir9MozdhVEiopO8
         rf9S8FV5MgkKwSUp6zIo0999djvYEhsmEUvJUj65Zyp7aG323LL5AfelEN8METZ2t7P7
         WLruAOqR46oDWgVfGl78cbp1WyLUOmcVEUcSbk6wd7uBNflOO5KpmTezRTFid0QCFlha
         XyeLFPxICKNonexgxUOSBWkUURyLDjbiBFzhTyp3Bqeu067/Sy+3wqs/4veTwsL6dE/h
         LYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755070856; x=1755675656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c9Ccc4FdRlKahKVue2t027gTXn3WFY4nUn/bdTfbFWk=;
        b=Cn+k2Nqg1XyyYeuJ8AZq5qNPvFROzxh7GSSZoQrRF4KBGSTq1y64rgeS8czlyI6HtC
         xpTp/XGe7eP4y/P27COB/ucpI1MYF7Uksmna+uIMP13sywAX9bvZpz5CPrmEdqcDnErB
         1epZ1I+LRu84lqpMZO9CVqQwHVRgZnTdgobPfEceAl6RJ7TdXE+2LAmCZ7RG7cMUXEED
         /+TNz1oS6iK6k2QNE3e1R8DFCd/fmWbot1k5GHWTvJeRANZk5aCFF3JKSvfV+z/sJUf5
         BdXW4yNehdEkj6U8UwsWtRE58xmmkY2yV7dlqisDvAWtyt8w/iEAC4l3NTWpn0H478A7
         B60w==
X-Gm-Message-State: AOJu0YyBv73vUmmM8hjAWS8oZLboaJJeVltqOIvd2JouJP9iIlMYPOUy
	aYRl2aSXVjhEuTJ+HM9f8R0l/zLRRrj4r8CosvNMMl4FfMoqhlhW4jZz/PVSRHZ+Z7ZFYG/0hlX
	GCw/NopsRgeBMVKe8kY66f8tYYYMQ3AHtz5XCp/GI5Vta4f/DPiAiOifK
X-Gm-Gg: ASbGncu7Fy+Q5rURbmEhR9irwxuPVN7TitN5tLJ7tmgIPa/O58b/arBaY4QqIATLVJZ
	TXXVqDyNqbvEu5BvPw95AB60h+VgHElNqo6gB0EBFnS2BLugE93Vk1ddZj9LAn0ajpTZj9KGBqL
	SvRPR+4QI21z5PPVrgJ9QNVlnlIHpfyb51HpFg+2Hq7BvhLA9I6yB/qW2M8rqQLkNiQpC1Rj/PJ
	iSFDO9ocVC3cPGd1+RaT51oXSKH+YR2PYLznWUxK2EHd0081U+uhQajAM8=
X-Google-Smtp-Source: AGHT+IGGtpaH+it538UfR2iaRDBz9X7fJpT1gAY6RgW0EDKE5fzEZ79ezay15oRdLHx3Xf5OdtuQ3FdbihxaglEAAsY=
X-Received: by 2002:a5d:64ca:0:b0:3b7:8fc4:2f4c with SMTP id
 ffacd0b85a97d-3b917d2b0f8mr1196666f8f.1.1755070855659; Wed, 13 Aug 2025
 00:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812144215.64809-1-baptiste.lepers@gmail.com>
In-Reply-To: <20250812144215.64809-1-baptiste.lepers@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Aug 2025 09:40:42 +0200
X-Gm-Features: Ac12FXx8h4Xky-40CstbMiW32Dc7_qYQSYrfMREs0zT_bsEsb1sqx3OupPHpEcM
Message-ID: <CAH5fLgg6eFYZ906GPFev_nha0axsUR71yC+En4X_fMjSn85UiA@mail.gmail.com>
Subject: Re: [PATCH] rust: cpumask: Mark CpumaskVar as transparent
To: Baptiste Lepers <baptiste.lepers@gmail.com>
Cc: stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, 
	Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 4:42=E2=80=AFPM Baptiste Lepers
<baptiste.lepers@gmail.com> wrote:
>
> Unsafe code in CpumaskVar's methods assumes that the type has the same
> layout as `bindings::cpumask_var_t`. This is not guaranteed by
> the default struct representation in Rust, but requires specifying the
> `transparent` representation.
>
> Fixes: 8961b8cb3099a ("rust: cpumask: Add initial abstractions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>

Only during CONFIG_CPUMASK_OFFSTACK=3Dn, but yes.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

