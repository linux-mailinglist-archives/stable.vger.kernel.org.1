Return-Path: <stable+bounces-118658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F8A40966
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 16:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B972700DA0
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9C1AA786;
	Sat, 22 Feb 2025 15:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eITl0yA7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0219882B;
	Sat, 22 Feb 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740237271; cv=none; b=e85x3HPLf35uXqizAxWECV/EOOOcy0P1uo+RjxHDuCOGIBWwq5kQp/hgNPmuA0Mpqk+xccRllt/l+3pmQ2VUQxeZJdPnzrSw3gIK3QLKOQYcHeh/2V/E5Ek909TEu2H3ySRvK4MRpcmT5/vOqgdzLyrbxm3A+76vldXBeburcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740237271; c=relaxed/simple;
	bh=gb4Sl+NAFfnDd3eu0lMM0znOWH1iZWbVNbCdUr6/vmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhtNAZn5WHFJYGYU26bLg368uNAUji22oCM+fX2ScHd7yJKHiRePIUcPFwqSbpMxHkuXVda9I3nnP+Rt/ZDNAJi2ChDwFaEfJTcQ7HCb/AlomFpG64Z+0cyscA+ghpwsqgeOw7C/z3y1TJ6kYVFgO1UAo+jWSIBEthDYbfj0IDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eITl0yA7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5456a71a7d9so532710e87.3;
        Sat, 22 Feb 2025 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740237268; x=1740842068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gb4Sl+NAFfnDd3eu0lMM0znOWH1iZWbVNbCdUr6/vmE=;
        b=eITl0yA7Drayy6Et1i8gGRpTP5I0u8QQINLZglpysJzRhCqKquswYdxneS8RFzTbSb
         3lJ2S/MfpKIQBnHd+vPDXC+SrrX7xI8fJVXyz9ulKky2Fufydtz8vOryxuUraDuZ349m
         d95smFGOiqk4fJm6oPuz3DA5TZa4gvHF/8JcawWNhISJZBjnvwOmePuo3ji5WhBa9PCS
         XyEbhw6zL152f1xoh837W47WTOSX5wkdLCZR62RkqtPuWvAYndwVDwIiVxUqcyC6VA6o
         0t0IMEEdSQpxWpXp/8yEqaerkVBCu4dNRgmodhtQOqPBtacyIHkAX9vTDoHOkrQqx00Q
         tLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740237268; x=1740842068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gb4Sl+NAFfnDd3eu0lMM0znOWH1iZWbVNbCdUr6/vmE=;
        b=m/6xiBpFMiIygZkvqLaI6ITCXcmEBaluf3tENazKfB+9Mhunewjm7Npi7/RteQr0L1
         37R40IqKUZnAljpvvTxnSXCXSbc9FYZvcXeRtmdqEeHXBdng6RR04imtrnNF7UOPIQRv
         osMOF/txwhQCzVfN5HgKb94GcjQBhAisQj9R18kP7Orh8Ppfmt6irnZflXslFdIOoC28
         xdTA0GmRGwO18bSzdXfuHs/jJVRxB/0yQKj+K+poBk7xMaHp7O7y4Xj9QaR3jeXxkzcw
         Md8KkPp5wXtDE1IUTPJbQqBobhE3/ImaaIRZI/AW5uUasU6Szr9mHE/47IE/7F6ZXaSx
         CVPg==
X-Forwarded-Encrypted: i=1; AJvYcCUpMwoTNge1IJIaRocDy682q0nj6zR6vudBSdi5HLmoBjJXUJbbctlCNKasTedy/ry3tjVg0uQf2vARKS0=@vger.kernel.org, AJvYcCXDAfHPZJS7vbtk7mR2pJKFzIYLOdUhgkq7LiKjULQMiOtrj24AiHzqTyUzfE1DFqy5v4kzqWWaWvrxG88wp1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfwak0Wur6EFhHN7DzVLVKEq+AK1ZrCK7UEFXsaxg1viz4H7b1
	BN82LEQE3sutbFhjyJfCCdtZw3WQB/rh1iOKkPr5AXkBrun/oXQB3oah70qXA6hTxvJrgJOPQQ+
	/QsHLrWJp9YreWIe7GyAavQpfrTw=
X-Gm-Gg: ASbGncuI8WyWuyimOXeTz5zzF/RpNVDLx4UIgwAcT6X8KOd5YCkuFy9NKbJFGt1VvNO
	Gn8ht3zL7Opkg1AtVlO4gtJ3LMh7ZwHwLeltEO48nmbrhMPbQuRBaoCtDuxvSl8c6PMNUca6EmX
	vzlD52H0s=
X-Google-Smtp-Source: AGHT+IH8Tym24vcrnRxEuyslXSwW3y9ZazTyaHZg3gYD5Yy0qwHtZLgjrL5WHKrpGR42kgpwlimOtJGd7bnoDbYEgQ8=
X-Received: by 2002:a05:6512:e99:b0:545:2fae:cffe with SMTP id
 2adb3069b0e04-54838f5a573mr936010e87.10.1740237267476; Sat, 22 Feb 2025
 07:14:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ef950304-0e98-4c91-8fa1-d236cbb782b8@disroot.org> <CANiq72=WyQdQfoOeb_mK=J_5GtiWBenqzA+mOr=8mN8OTWPB-g@mail.gmail.com>
In-Reply-To: <CANiq72=WyQdQfoOeb_mK=J_5GtiWBenqzA+mOr=8mN8OTWPB-g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 22 Feb 2025 16:14:12 +0100
X-Gm-Features: AWEUYZkDVyQ7F4Gp9ybyNiW1F1rAJPNqvAp0Zrl2cJ0pS2ctF7P1QLlwfAuRl3I
Message-ID: <CANiq72=gJCauuTv3_+vvHU2r=nFpKCdL5tsjS+mj7Ttqra5oLA@mail.gmail.com>
Subject: Re: FTBFS: Rust firmware abstractions in current stable (6.13.4) on
 arm64 with rustc 1.85.0
To: NoisyCoil <noisycoil@disroot.org>, Danilo Krummrich <dakr@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, ojeda@kernel.org, 
	alex.gaynor@gmail.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 1:20=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Thanks for the report! Yeah, I noticed in my builds too but didn't get
> to it yet (there are also a couple Clippy warnings in the QR code too,
> in case you see them).
>
> Cc'ing Danilo in case he wants to send the fix, otherwise I will.

s/fix/backport -- actually, sorry, I just sent it.

Cheers,
Miguel

