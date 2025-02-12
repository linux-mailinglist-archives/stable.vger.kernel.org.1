Return-Path: <stable+bounces-115080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BDCA33293
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7FDF164490
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 22:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F8D205516;
	Wed, 12 Feb 2025 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C76kxhF3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AC20408D;
	Wed, 12 Feb 2025 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399342; cv=none; b=oeUlNskePGyskLOR8pBi9balV9bbxJiESVFwEAcConMI5uxq434GFL9FEpu60s/nuH870gTHETU4EHNVrFCJQAb+SViFzl15SrQ+NfsXOLwSUhM1aYx/BTWzC6KyKC/OZnnINInKMlLP4u0ZK3T6U2sI/rrkr1rNHV9g1YCbV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399342; c=relaxed/simple;
	bh=olRmeoWJbLFymDQz+cYE7O9G2aS/9jPA+woKLGiFgNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABkP4TLuOjLaPRDoVnlx5864B54BLCKYunBpKglF2OJyYqDrPCNgCRtw4mrHDWZYuC2PoLp/CjOQd6njjith2DyR8LBIeokpiXdpoZiDdFBNqIqajkIElsiocGWHzm5VJX7sXhvb0kTOo7urq0M6QKn3xebF7rV3mYwYhAk8zLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C76kxhF3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fa227edb68so61214a91.0;
        Wed, 12 Feb 2025 14:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739399340; x=1740004140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0ISjjYlFd2w3B9BHStKW17Hk2awDabFxHbFIHma1pE=;
        b=C76kxhF3c8JxIa+9pwoLaKuXVhM4eIUDDCOuVgAmZPLRL2v5H2Rl36MrNxrm70pI+M
         cVEgaNq71hLmQO48f8vcl+dwIU2LHi4oj2lz9WZ6zeC5kYH6KuSVGndztTKBJjk6Pc/b
         /MZg5MNU9J/vd4o085Sx9AcBlSlVpyeNP8sUIBejyGHWUYaFxbcwalbPHDxWxqQAK5qd
         QPU1e/0dVpBEspMZKYqTcLrwSHGnM5XqZZ0FNfw4P44a2Efbwd0voSyFyzWPJGTmGPPo
         nvRFqSVbOeQ4Upo5ciuX5s/eMZwetm2dZk1eqcCDXY9wR4B8wR2SuyG0TanLqynwi3Lu
         ZJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739399340; x=1740004140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0ISjjYlFd2w3B9BHStKW17Hk2awDabFxHbFIHma1pE=;
        b=VqUKUbnfp54kqTXwJtRQ5XNUicN71YHBF9iNnIiwHHiV8mbOOHgC3PwFuM+nX6nW8t
         yyN+Br5SD65jUKavZPqcv07S+w676MoY5max9wkmmqavb0mTBi/wwvCNpiDJ/WhnONeW
         SxDO0CNn2zOI9UsHaL5LrcpCBAM2ho4wh4DlXGi2O58z4mwGL9NiaKFgAAXdJchqgTbP
         wkwPrY7BlgUAo6QN/Sepi3Dre1wHBA3uRPO17L9iQClacM+o5XH/o3yusox0jRT7AB4b
         zOSfSCvcksNHx3r3srnPSnT+WEB5dK01vDGkxotDkxL9xgl5WUV1wYOYjnPIqlmJJJtF
         nICg==
X-Forwarded-Encrypted: i=1; AJvYcCUGZqxP0ozAUx/g/L4jQosJm4e5f3+5it0c4aZ23YTKiHhV+Uva5DmysMawITNIpO0tQqAfA/ru@vger.kernel.org, AJvYcCXEVmO8RfpqSoESFMa9KKNvn3TUJ6ZNRPSoEX5CQF1urDx5ZTDUogAu8qpVUW55meBeLhDjdv6rdphlMWrOBsY=@vger.kernel.org, AJvYcCXIOd4eNFCYHu0+hWiNy62+Ujs3cKuNp3MVIrodERA4NYOTwM/C3jFEbrK3O0gQ8A4rpqL8HiFfIjsT0cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHWWGfLyrpqvIJoQknmXOxAr6y1J52EzEgxm87y9jaD/KuBnh
	NSEGDAHJWqnTZ12B6U6j4HepRVZKB81iWZWvTfWt2xyH3P9V8eZx8C60Nt//AlPuhpkak7uy2So
	YxlkAn3MK2B3YMzzwX/LpEetyBgo=
X-Gm-Gg: ASbGncuevlBMSPamgHrx5TD0xBVm9ObovIjEAuTz+m743INTnL5ufdg4go1zR9Wf2U1
	1E+4PYev1JQ6FrUJqJ0NU/8puYOzVNpiXXjtQlJ4WDrFSK4eo6O/VqkrUmiCPcasFgpP0F5ZJ
X-Google-Smtp-Source: AGHT+IGq+yPlgVO4dsKAOv/QQxkZUjh556uN1Ur2VQHSKRppM/rFN7XROxwcs8o0k1nBNY/IrDjnXGzRXpmi3u55nj8=
X-Received: by 2002:a05:6a00:3d03:b0:730:915c:b77 with SMTP id
 d2e1a72fcca58-7322c36bf0cmr2710792b3a.1.1739399339623; Wed, 12 Feb 2025
 14:28:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112143951.751139-1-ojeda@kernel.org>
In-Reply-To: <20250112143951.751139-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Feb 2025 23:28:47 +0100
X-Gm-Features: AWEUYZltnP6UMrmvD_9KnN-NbTFvWz3zGVp3W1kw8rCGt6Iqjmsr5YvFs1Qinns
Message-ID: <CANiq72=8D4X1RBCmB9d+DTkEzifzn4nTcS7-hWHyHUxe8v3q0w@mail.gmail.com>
Subject: Re: [PATCH] objtool/rust: add one more `noreturn` Rust function
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 3:40=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with Rust 1.85.0 (currently in beta, to be released 2025-02-20),
> under some kernel configurations with `CONFIG_RUST_DEBUG_ASSERTIONS=3Dy`,
> one may trigger a new `objtool` warning:
>
>     rust/kernel.o: warning: objtool: _R...securityNtB2_11SecurityCtx8as_b=
ytes()
>     falls through to next function _R...core3ops4drop4Drop4drop()
>
> due to a call to the `noreturn` symbol:
>
>     core::panicking::assert_failed::<usize, usize>
>
> Thus add it to the list so that `objtool` knows it is actually `noreturn`=
.
> Do so matching with `strstr` since it is a generic.
>
> See commit 56d680dd23c3 ("objtool/rust: list `noreturn` Rust functions")
> for more details.
>
> Cc: <stable@vger.kernel.org> # Needed in 6.12.y only (Rust is pinned in o=
lder LTSs).
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

    [ Updated Cc: stable@ to include 6.13.y. - Miguel ]

Cheers,
Miguel

