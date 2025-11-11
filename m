Return-Path: <stable+bounces-194489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C30EC4E442
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 142BA4E68FB
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D4359703;
	Tue, 11 Nov 2025 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZsUgUUo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84044357728
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869542; cv=none; b=cfMoCnAfcQrnOTAkYcxYQpDp4nb3xAT5EJjjK6hFEdX4gYKkqYTQHioNNU0AT67Epz2qaGgps4toxHX7Z98UxvZlNF3bGZlpxsIS3nRixT3uOrvMReCjCkMklMajoUWjZnrR3PQNRJR+hh0ioprOcCqz+dwdfPe7e0hBmcjzMwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869542; c=relaxed/simple;
	bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cfA7CG8ijWuDP4Hv9GZLVzFm6I+F7DuIIeYpHl5Mbv28qm1jFFHiobVWzFgDFThbCcDb7Wl54C/IrizlMEVOqVBlOwt9tE4YYTUqyT+i4EKo3jNhfDrMfWSAQxZFpHxszYeHy1enIIo72Lpl41vxiTVnIUDz0QX4Z2SAKOntZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZsUgUUo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29800ac4ef3so4076205ad.1
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 05:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762869540; x=1763474340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
        b=YZsUgUUoLezCFU0P/y4ACxySgN2oXPKkH5rAUf5K/Knu+yjMKYIEAtI7YWLE1CRREH
         G4CuuxoaTEockrL6hXAlWf0lY4nQRzzL80T1q7fmEJSsVau+53U9PGuFNWSL/5ALXvZ9
         gY4Gy8aWTsH+WCrDPGfy3++IOkelaCvSmWKF5ReNu5O7A3o5fX0ZZx4+cq0XO63GN9qd
         bYV9JSbp9+UvllV9KKNUO+tyGt51I3QqMtssFeRcwbmHn5h+RNSgJkV/O2Rnzmtfj4zK
         CVY9Huk2VfkwFwl9kJtqYxHo8j5N51q9r4sCHWCJUmcuSGkPkMEVb2wS/9+OgyV+2kBx
         vg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762869540; x=1763474340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRUmzVbCzzL89fOTZQBAaUfGAwTMnx1MK/93dcHh+is=;
        b=S7BTuxnZbKWElCj09sgdpSDcB5jWPsqsKqc49Ab6EhF0x9hDXVLntohmx6kavF8EMA
         s1fu6+rodFY62NFVmZkocTNYttcSPfyXquLw/iq+NQAQMaJApxNrECQVLAZebDKYtIoA
         RERcfwrbptU/hOXdLhh1tCAXtaiyhrOqpGq0xdNE2ij7hP4xEbNAEsNuTdqgO4gEddi0
         c2lPmpFYSoejZBmEzULtU6esorM4vct/4dhlqa2HPZjspk9AlMdYYU+r4svPl3Y5fesn
         pFiHKVKMfWD5DKLMyUby2uAGIFsm4Umj/iFdGjD0oWr/mLyKX4O5GtDuglurBin60owc
         QVtw==
X-Forwarded-Encrypted: i=1; AJvYcCWRQeyyJ3ulOl+08F8j5eMKfgKs0CUhlrbg9HFDdDcCH1876zyXTDYbN3Q2hz5FII18HSMQxCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFk6dnVX9/U28dmIrhZJJWgIH6+mbOjuAngjZEv2wKKak0M98l
	GREYRfV+VXXnb0+T/SWX7s2GQNq5YSRMfVpGTDvXU2UtRbZ4NKYfawevpmxTxE7o/toYkN26q/f
	NS/iE63gyl//GR0PQddRDVZ4B5F1IplU=
X-Gm-Gg: ASbGncvWpBIKtvah9CDJO+PXnNRmyRelMEWemi+t4f/wFiaUH01D1uP4wpMBhPquPIv
	zvrco7LFTOupJz9umxAWHn8IBxv22ZZ6N0BqTgNm+uTUlqyHqk0E60M0wntE3on8gnPRko8UCsA
	CqTueVidJU4T/mvbmkxDWFHpSHoGEMuSA2tnyVoqJt2dPYUVcE2u1QFVy0LSZUq+HdAN8e9mIof
	b4ITS7l20u7k/35TH0smfYVngaAWgkDDVdHxhnnfO/P6ivUFI9Daxe2elAIQp/Gwr/CS5IkOouc
	LHv/oOnDZEgyjZ1cK8QXjXjPRLTUA0egzxg9/MwpCtbcP4ybm8Aqt2GJHXSE1uJMqD7Jlj8l21r
	iBxFW0/nx6c/fug==
X-Google-Smtp-Source: AGHT+IHYXxM/I5GaOybb6g1yecFYohV3zCOa1VEm8f2yGvBo9rJ8osfE6aj7FDf3tvSiEZ9Z9+sidUs9ZqMaIBw6rqE=
X-Received: by 2002:a17:902:d48f:b0:295:54cd:d2e2 with SMTP id
 d9443c01a7336-297e4d096a4mr91553105ad.0.1762869539841; Tue, 11 Nov 2025
 05:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110131913.1789896-1-ojeda@kernel.org> <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
In-Reply-To: <CANiq72mjFobjfQEtNvk9aA+757RkLpcfmCCEJAH69ZYsr67GdA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 11 Nov 2025 14:58:47 +0100
X-Gm-Features: AWmQ_bmjChoTwnLfQhUmk8zTDZP6XuF3N7zYh0KKb3TDMGl3YRN3n87n4dAkPXU
Message-ID: <CANiq72kaoYYMq+ghFsa+YrRbTE13M2TrtOMwAK1eV1Sk9tEQzg@mail.gmail.com>
Subject: Re: [PATCH v2] gendwarfksyms: Skip files with no exports
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, stable@vger.kernel.org, 
	Haiyue Wang <haiyuewa@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:54=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> I will send a couple other fixes to Linus this week, so if nobody
> shouts, I will be picking this one.

Of course, if someone else (thanks Haiyue!) wants to give tag or two,
I can still pick those up, and that would be very welcome.

Cheers,
Miguel

