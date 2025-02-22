Return-Path: <stable+bounces-118652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6166DA40848
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 13:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A2717BC11
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CC9209695;
	Sat, 22 Feb 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBlkl9/y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D81F236B;
	Sat, 22 Feb 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740226873; cv=none; b=d8gkIgS9e3vR8Jq7TNYSoKDXFOSvhn/KB3gpAySb5p+3X3MZd4PWbUMj5OEmLfnxHk0+5s7TOjytUVxCqAC0v2wUrhCxnktA+vx8mJKKhJlzNmoLGV4apvp835Gz95clWcSm/lFAxq+wJUkBL19vhQiMZTjIRf87GQQlzEZk9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740226873; c=relaxed/simple;
	bh=il6Qqd5eRhA+wprknB+USCHIJ++iO5SknhOmx3UPBNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OD2sRmbGFFPnKzJsXtIs51FYKhNlt1IY8ItofZR8o+UehMnHu6n4AnDQpVY4SO8k763exvdR/lYOfgbbp7DmNyBDXVUQOZDURIr4TEgkeNz0KmO7DZRPLuUuMQ0WPvYkRauQHSsuDfv57yJomabrmKs3ItpGqQMmhcdoL3zZjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBlkl9/y; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so774568a91.1;
        Sat, 22 Feb 2025 04:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740226871; x=1740831671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=il6Qqd5eRhA+wprknB+USCHIJ++iO5SknhOmx3UPBNA=;
        b=EBlkl9/y9eEKex0xhBWfxDVLb0fSzulmeAKcf7dPDJFOLbgQ29dzl3zp4yxRH/+vHq
         u/KK6GIo5m25BWPXp0+9VbCdtJOMVXf3WndqADYzEwcGaCptsXuIrRvIyaTNK30FgWwR
         yhmhCyl2vaJlUGnjURYClvQbLU2zIaWIq7W8bS5qJNwfXkUi3mGfB49dGNr6CeSgrhv6
         mHvZppxd5Ra4sn1vPMu7dxbWqMQmpkk7PMfv1dbgqSUnOFnT5MTm6zbTSCbEo+SpDepl
         qb+ciTE7SMB6Ixt1EMxARsHE5s+0p7TUvID/WB5a+kXIVj6rnqs5TNGHiw0UvCAPa1a7
         rWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740226871; x=1740831671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=il6Qqd5eRhA+wprknB+USCHIJ++iO5SknhOmx3UPBNA=;
        b=sga9mc4uURoIpvhdpjFH6lysHsu/LRX/XPJ4bbf3RtA5Er+UKvFkh2oIYtZ95E491M
         znr7lbrjpIxPiXEwyyIqCvCb2YPhdoDPoLQAl4k496qzR1SssWy0NDyEz3GvYf8A8XkN
         uZxEnAQ74rMsRTxvc8el/3F/cFLUjrFDKhJXehwv/fyhHD41Khk5izcyhLS52T0fR8Ex
         1W0yuQgnOY5MioOk6/W9Er1UCXd5IwKKIhOtWsIaOx0GC0S+hqkdO4YeRINrWYeMBEeo
         3xaVxRcM0fti0lKxYqLBY3Gp2YIYH5jLURQhSfB8iZiJk6RynrCfMoLS4BSlOqoyenkH
         wIJA==
X-Forwarded-Encrypted: i=1; AJvYcCVB7Sv+IKHcWQKwv9ijQexB1/N8QIL62HwmxLqTrsXPbpQ31szyowSMQ15OmXb1uwcMZZPTmmO7fQ4/VcaYwjA=@vger.kernel.org, AJvYcCXQk2Qnb5gWlpwp/E8XdcuGbtNz3r25ZLJ1cwzVMWgLfVWZ1H4jPw5N0HHnm4G6tYtYAnVCPtRiWoBk8A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTHLCvHIFW7TFb97gIy5Yo/QgpqefTYyCc7n69Aa/l7ZkJMQL
	GQ/x2AKzcCyhDE6KmxbWspKs6bQsIXhKMJV9WxMenY5c70uBbQGaiE/QRhEUJ8/f+a0AQkjmSeQ
	A7MFL/mqDvIZhbzfuZop3n/0nsbfo4AMQ
X-Gm-Gg: ASbGncskc0FTllHwldVd7ijw9oXwj6qzkmI5T1GJb6QXFVv7oOsg74JSOSRsgyrSbdU
	5b6vc/Nrvzw65FceOlN7PVK1UI1UPMOtb99oQ0v3Xu/LRaq99nHyvOvgbN8CnreougMBNMHQB4x
	sRhyVIXOg=
X-Google-Smtp-Source: AGHT+IE3qKPs7mbXALLEginuUPiswX1VxZibcwmSUbSEIvidpst8iLIyZckHqIY7J450gCzzrBZn2sazu08NQJeZq7o=
X-Received: by 2002:a17:90b:4c92:b0:2ea:853a:99e0 with SMTP id
 98e67ed59e1d1-2fce7b389f6mr4371506a91.5.1740226871449; Sat, 22 Feb 2025
 04:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef950304-0e98-4c91-8fa1-d236cbb782b8@disroot.org>
In-Reply-To: <ef950304-0e98-4c91-8fa1-d236cbb782b8@disroot.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 13:20:59 +0100
X-Gm-Features: AWEUYZmRBNJTBxN0xkGm_LxZipJHN9QJR0d5yx5U9-67EfskObL1eNFnt-yVeJs
Message-ID: <CANiq72=WyQdQfoOeb_mK=J_5GtiWBenqzA+mOr=8mN8OTWPB-g@mail.gmail.com>
Subject: Re: FTBFS: Rust firmware abstractions in current stable (6.13.4) on
 arm64 with rustc 1.85.0
To: NoisyCoil <noisycoil@disroot.org>, Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, ojeda@kernel.org, 
	alex.gaynor@gmail.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:09=E2=80=AFPM NoisyCoil <noisycoil@disroot.org> w=
rote:
>
> The Rust firmware abstractions FTBFS on arm64 and current stable
> (6.13.4) when compiled with rustc 1.85.0:

Thanks for the report! Yeah, I noticed in my builds too but didn't get
to it yet (there are also a couple Clippy warnings in the QR code too,
in case you see them).

Cc'ing Danilo in case he wants to send the fix, otherwise I will.

Cheers,
Miguel

