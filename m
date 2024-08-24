Return-Path: <stable+bounces-70095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCD95DE8B
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 16:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34602831E8
	for <lists+stable@lfdr.de>; Sat, 24 Aug 2024 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C817C9B3;
	Sat, 24 Aug 2024 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyH1roT+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925E179647;
	Sat, 24 Aug 2024 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724510753; cv=none; b=o5G5sqKhnI6vthAKTR0gsfsGB3UCUIMftQsZ+AbPxFL6pFfKBDMZ2L6/XMAyCFUBaXLTDnd57yGKETDUDRobYHd5WT9GvPejvggKWWPkYQ+i0fHlcFAi2vHsAAeiRLqea3UB1GqmPwJ4Y1/yj0lqJzj8p3oLtrXPZizp14uPSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724510753; c=relaxed/simple;
	bh=/AY/sNru5AP+z05Xzfrj8YNsnhwxuUTOdjXIlQJ6XyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeqVTQUIh3KLOwMtnFFBPHrkggzLFzN4fNcTw1SLSPEwLhiaY9xhYSplP5KPUDowAJqZGc2/Kqj7MD/2dfXpIEU/YsTBF1f6rCDYT84ZdkcmyQCCo0Mp16nUhw4knQhteird6JbMXQDo+eForJ5WRhB5OtFAJJREdmgIixrFG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyH1roT+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3bc9405c2so346395a91.2;
        Sat, 24 Aug 2024 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724510752; x=1725115552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AY/sNru5AP+z05Xzfrj8YNsnhwxuUTOdjXIlQJ6XyU=;
        b=FyH1roT+wI34LlaNYz21nVP0R/+D70hlHTOrz/2wCcokObC7g3eKhgfJ1A3HPkZ2Kl
         KGM+JUHiE/Qs87hKyILUWPEDPCmFA2j2uTOa5W5U+BuRKVuAjLoz3/Zw4h1XLYQJwCAU
         EPoO/z3iXYakEIRI9NmJbMIMH1AJcbC6ZCyx2ZcZUC9IhSljItD7RtEevatawfc8FSXz
         0lEBALSTKeWKOC3FQvofjcg1luf3f1lqD63P9OrEqzm8CrFLmDKCcDU/D7PSeAvjG2cR
         jjaYelAnh/ytc8xxmEFToL3a9nsTXw9E2cxniI1GGzLQFMDjp+NCpmOr3wc5gTC+DHfO
         O8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724510752; x=1725115552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AY/sNru5AP+z05Xzfrj8YNsnhwxuUTOdjXIlQJ6XyU=;
        b=Gt2d9IXa06Yt+b5q3ufAToC5xTZL6aHeGq0uwZmOEisHWYgzxk4+LCAtMrUry3ty6n
         Tn5szyvcpElILPvm42gdFdTQMXwA6r9lK1eNn80+myqC9BwaAD8UopWd5KKJeVhViv+5
         nlmAhV3UY07WGyt2dg+Z4YdDR2EYjRQPUizxzfmh864GtuflAIkqR63GpVbfa6XaRV82
         MvqmhTMfBQ++yAssr4SW3Hq3wOPvIgm7t2lI2GpC0B7Lh5rB3Mf3owEPm+gSXiSoSigO
         gAJzsRavVCjMgg4i4heOjmhxG18a9Y6M4LxdVsmTo8dUKGUb64i6E6REJI7HjFe6053j
         9DbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoMNGV74Odh1vr4dV0/m/q1+f25lnfXGpofb6y4HToTkVKtAWzlpPEzYzKPx1VmK8lQJvPJ7zF@vger.kernel.org, AJvYcCX/W3PyEoJtbWq/uC6SolCRCoKGvsW1cBMT1d0+nGlnO7eFagGlndrdIqOCritc2LF5prkA4IDysd+vRxrU8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwShoxQUceNedEtOFxQwIb2cb7duCqdSMtOt/kR8tay6U2B+5KJ
	Nh0y60NiXvLIPpTHCy1EQKFffl+K5LoJS+LA7joCfNC/DkfdioJhltik7oHGcW4fI332COVNaj0
	ZtJke2ZIVzS140R88cMHnIddIj5M=
X-Google-Smtp-Source: AGHT+IGfX8QIzewjfC1VpX6LrP8Cy2hMePVnGVnVmq6AtmnErsRclJnUUAQfjFofiK3pLD75V1yJSc/BeFY9dH0Q4ck=
X-Received: by 2002:a17:90b:3e8c:b0:2cb:4382:99eb with SMTP id
 98e67ed59e1d1-2d646db48c5mr3602585a91.6.1724510751965; Sat, 24 Aug 2024
 07:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823140121.1974012-1-sashal@kernel.org> <20240823140121.1974012-10-sashal@kernel.org>
In-Reply-To: <20240823140121.1974012-10-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 24 Aug 2024 16:45:36 +0200
Message-ID: <CANiq72=gqDOeqHhL=cvohoBWrc-gp8p6p11+13gE7C1MA6pwyQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.10 10/24] rust: add intrinsics to fix `-Os` builds
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Boqun Feng <boqun.feng@gmail.com>, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, nathan@kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 4:01=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> [ Upstream commit 02dfd63afe65f7bacad543ba2b10f77083ae7929 ]

Sounds good.

I don't think one can hit this, since we only saw the issue with Rust
1.80.0+ and 6.10 Stable supports only 1.78.0 so far, but it could be
that we later need it or someone unpins/upgrades the version.

Thanks!

Cheers,
Miguel

