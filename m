Return-Path: <stable+bounces-121118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E9A53DDD
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 00:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AA1168493
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 23:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9257B2080FC;
	Wed,  5 Mar 2025 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfgq05JF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2732080EA;
	Wed,  5 Mar 2025 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215730; cv=none; b=VCMO1ArZr9m1x8m2yKnnhcXRWcAjC++6hXrepmnu4IWDydIOlhePQyh9TNgKhLYdSpscpyNQd+AYh0iknT9fUeSyccx6l+bEqwA+oDDrZDzOHaMkt3CxCDW0y5fI37lx3jpG189vGbfYO1RiST+3Ps0o+zMP/m4K/AbhML4WrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215730; c=relaxed/simple;
	bh=rgcs8jkGVo3NHV3xZ6/0r5NLYIo7kc98WvHTCah+c3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA15+7j919FkN44IKHeAk6Do+or5YR3FeQBhXvAZZSD5KVRZWM5UzHF+C061igRFmu4Ynj10POd7Vb6pplpkTN7mRNkL61PZmeftHwhvRPfGOXVNgYvWpwueLbtQWQ6YOo+gcqF1KoPDroVnAaH5+4Rf174E3ZQim7iX/8pRVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfgq05JF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fd44daf8so2415245ad.2;
        Wed, 05 Mar 2025 15:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741215728; x=1741820528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgcs8jkGVo3NHV3xZ6/0r5NLYIo7kc98WvHTCah+c3I=;
        b=kfgq05JFNUCR3g6AaysFXceVjCN6gFpN7jTKFqn9eBGPCEkEyTjIrOV5uI++aQ9Z/z
         EO0mFHyA8r5S7iV4d9C0iHQB8CxEqEfX4ty6kkrfri9Q1VtVw0ohg6Fc3SltdBLXo1NU
         j8sJc8A021m6j02JisuNQrq/xUtOT7oXghivWHk8lLPcDy/edJv7o/j6CklhTo7wCaRM
         B5mI4KuxRe/Hq6MbtSBQQonIlEQekUolvfGt5Vs/6njApProPM283Xmoh7Ti39sEfxv3
         fxCBh/gdYijhJeI4piV7spR9MuP/k8IdAnmbSZPsOBcBm0E0OVK8bAY/o8ri7K/XEryY
         E7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215728; x=1741820528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgcs8jkGVo3NHV3xZ6/0r5NLYIo7kc98WvHTCah+c3I=;
        b=wlaLkmM+NfsmSUchPlJJ1nPbL98LQQC43kpbzW58D+/YHhAbWOIAvjOHpR9AxmUsG0
         m9np8+GgeF91OjmK4sWSG+tg/J3rHXnX7XGVr+MGF5nX/BIIMrBZ2OCukYJcMVIuXifv
         4WudMxlDUNTCouSucM0PzvpSFAEEQvVQFqDrQjPNTo4VdFfUmWHCiVYMVbst3gBBfqip
         DQVvI8ABEpi82nqLSjkZkzF4cXAcqlyJUDtztIz1rl3w0idQZsprNvcfdEUvj56lr1PA
         6UVifOZCWdfg3TDiz/k97TTUzEDlgvzu4CqFH6a4Oq2OtCI/1P0rcNqc4/4/EoWnfyND
         mawQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWjLScoW/F0NKZC4GvNAwjvfJ8VBxVIBkpFBBRhOwF9zXvsBtqxUWTp138FsRyvXLBlgfuYi0c@vger.kernel.org, AJvYcCX8oUsfvCmmQR1koL80TbNsiNu2aIw6Cg/wYErKjc3JWl9ICWUANMXjIxkeTrIgmB5pWLt/SPM/6Ac9ZU9fjuw=@vger.kernel.org, AJvYcCXHcpuoVfaOXXrXCno+v3htsex53ajW/UgEyzYqcIkvT8ed4oiIFy3eQIIe1MYInbQ8Pg3Jk+yK/USjJBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmy7SCjcylnWX+7j4qffi+6nnLRfXWlWMo649Ddcm3wqGIviXE
	96zAmTzcZEjStm0cQ+mzNg5PeqW2MbP6gSPYYna8eCZeufWeucq3o2ZS3EpK58kI+ulB/5k197F
	ZOC86VzxVZvBcumT4ijfwio4w7j0=
X-Gm-Gg: ASbGncv6TVaAmeQSMh1gzuUvpBWSjTukK1rOvIRAFD/7oVoX6ndyXsCZK2MkDyzd75/
	mq0St3k9vjgtB4kSQN7BpMfB9E2J05OXX8QeFrvDFS/2Ub9AMzqy20F/dwVNRpjFv7VL4sG20CD
	AVUi6wAVepio0jxY/ULbQWLqFtZw==
X-Google-Smtp-Source: AGHT+IEOHQytaLDZQAvKtNTBltPyvqtYSsB5GrP/DGnmAkK70fPpVPLtg/WQaJM4nJWg6uLzp9GDjBc7m87M++pdEDE=
X-Received: by 2002:a17:902:ea08:b0:216:30f9:93db with SMTP id
 d9443c01a7336-223f1b87ad3mr29085005ad.0.1741215728049; Wed, 05 Mar 2025
 15:02:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303171030.1081134-1-ojeda@kernel.org>
In-Reply-To: <20250303171030.1081134-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Mar 2025 00:01:55 +0100
X-Gm-Features: AQ5f1Jr0OQTle1lIKSehc5uqZjrZL6QS1aOiHJlFeVVcIb6JdJy8vamJVkQrFE4
Message-ID: <CANiq72n8_rJq5SzRV69JutFmbbJak=pb_ZekSgsLtL1evqy8Qw@mail.gmail.com>
Subject: Re: [PATCH] rust: remove leftover mentions of the `alloc` crate
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 6:10=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In commit 392e34b6bc22 ("kbuild: rust: remove the `alloc` crate and
> `GlobalAlloc`") we stopped using the upstream `alloc` crate.
>
> Thus remove a few leftover mentions treewide.
>
> Cc: stable@vger.kernel.org # Also to 6.12.y after the `alloc` backport la=
nds
> Fixes: 392e34b6bc22 ("kbuild: rust: remove the `alloc` crate and `GlobalA=
lloc`")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

Cheers,
Miguel

