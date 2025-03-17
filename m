Return-Path: <stable+bounces-124740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C958CA65F4B
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 21:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6CE3B2402
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 20:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0861EB5F1;
	Mon, 17 Mar 2025 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcN2bBRj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E6146588
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 20:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243983; cv=none; b=DC6lhMKpzzRc0s5LGG+qOaonPvHrUJSjaCmrhz20tWcr+acb57aDeEUcWhXIIecD/7WaUomPI17eP8q1lYxip6/DdYFs6Uvkz//bpqiYeh2aHzl7CdQ1W1HrDC4l4ZWR8w/15NtGIRPwtbG5Z94uL9zDEWH6lsuL3UH73e885vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243983; c=relaxed/simple;
	bh=9BF/U4hINjhWVqbPqFhrCeP1x0BKPvZ2LZ4+iN7HYTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXulNEcWW3j1RaI5Agm4+HtODnCIKmpd5eza+nmZOMLd3NEV0SP84A0ZL09tukouwFAqCM9hCTN2F4pV6TzxDHlX3QUXWzIpq7UfuStLSE90ncSlGPM0PN7ED4+CE5zcLb47kDSSS7DvYgH2I+afzAI1b4+/lT12slyYEN7eDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcN2bBRj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so453373a91.0
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 13:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742243981; x=1742848781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7eiO8QnKJhhYfe7DYzz2fZcKpH6e6eRN3Vtp6/lt8o=;
        b=XcN2bBRjr3oaz++DbEsIM3VBSIoxEC0IASW4fmKn4IfFTg0WWBDNWHqMRuWDLtDFmJ
         ljbBK4W/xNj9Nn6evdlKmpzXIFu/zbHsvE4hZTua+3OOhNixxdvqYskfx65itnRgnuX8
         wO0n7ywfUJSixaB1QrVoUWXpqQkqHu2SFJNn+jMjQh1q3rRPNh8qET4bernNiLWvI+Aa
         NpJsshy8LDRhs6rMWsBxNI7OJmiawkewIuSaRNCznIVLfzt5sNd+LZ+IFJAZqn3x3R1d
         v7uQ4VQ75ZO0exjOwtZVMBAjflHhFyGxmUB55Fbrf2dz+gYwYUU5J9dwrhc7O614RtgY
         0rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742243981; x=1742848781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7eiO8QnKJhhYfe7DYzz2fZcKpH6e6eRN3Vtp6/lt8o=;
        b=SfHAO0NULZxj7w3HpjzQO80uSx2hMm7q1FtUnbEEOy4YmG4ghJd8uF9JaAmOXQEjSX
         iRE4z2BkyqFL7NjASEbDmaeVqXgzE/sOYD3euftoHe0Y9k/+CqhrpT6IZXRWHTCfyJvw
         CYDYipU1+onNOnDSqbB883xTuG+nFWCHLVTpgeTSGIJhzQ5SIQGzrntml79MFfkmXV6j
         73jWwxAuh4w2+/zGvxSSJvhuXGHA2Uis4+SMKbuQrbuIU4V6D2Ein/fSrWP6bTxssDjH
         RjOiqWCRdtGIikBceXZPuxS41rYWUgumYuMb+XaszNwxrSHvPILSaQuJLmUVFMFSA3+2
         Tn9w==
X-Forwarded-Encrypted: i=1; AJvYcCWMlm/t0GoUikARCeJi1ZYYlCTbwNg7UHqsHMvvUpemC08VLMirckV6/GD+bUjpg8DK98kAGMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWzUQSH01S/G3I3pSQ7g16DZQajLR9okXyNTQtD5kzTW5sSrKc
	dAFNzu8sKRT0s3xLHmAxRbmHT9oN2PD/lFM8+lFgZDBFgxBbHHlW2G6QJXK/fLq+/3koJEP2QVL
	SXm3prvPEkRaY+LoWQs5zIkZY364WmbqP
X-Gm-Gg: ASbGncsBGPoONbVgWwRLwrpG2lJEfcn4MBrWW3gy0bo64edztmZs6QO7uj4pOg6gDbe
	jvD7Fn17S0smTq9mS8L71t+63o5+O/D2xUZbR3DE5QRSA4Kxjsr6FJWRrErjFySqSeUaC66Bijw
	XlUJN0BFsmfO/ZVYKrBM+L6WOOtg==
X-Google-Smtp-Source: AGHT+IF0S0jtDzUAjlPWQboAOd/2DZviTZCzcMeQVE9LtL9lyfXm2MPjPtr1KuxF4EXXSRo2FfSK9DcxBZlDsLxHrJ0=
X-Received: by 2002:a17:90b:1e45:b0:2ff:7b15:8138 with SMTP id
 98e67ed59e1d1-30151d9d6e3mr6131054a91.7.1742243981092; Mon, 17 Mar 2025
 13:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025031635-resent-sniff-676f@gregkh> <20250316160935.2407908-1-ojeda@kernel.org>
 <CANiq72mEexdcTSCJuc5SMwMQ3V+hLpV623WEqLNNB5jVRxH+Nw@mail.gmail.com>
 <2025031624-nuttiness-diabetic-eaad@gregkh> <CANiq72m9EcxPcaJ0M9Wb9HVjLEi+g2r59WR8=H7F+ikgQeYGHA@mail.gmail.com>
 <2025031729-dizziness-petunia-c01a@gregkh>
In-Reply-To: <2025031729-dizziness-petunia-c01a@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Mar 2025 21:39:28 +0100
X-Gm-Features: AQ5f1JqUJxjXQJzRkmpPGyc_KDWT5MxuSV5NSeuHqKE8_Ox85OxFHyLc61ucLwI
Message-ID: <CANiq72kKDNzAtVu60AzcHtGhWm5x3oKGcHCh4tWGrhxeXYRKNA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] rust: init: fix `Zeroable` implementation for
 `Option<NonNull<T>>` and `Option<Box<T>>`
To: Greg KH <greg@kroah.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:25=E2=80=AFPM Greg KH <greg@kroah.com> wrote:
>
> I didn't notice that you changed the title, so yes, it's expected as the
> tool takes what you send and picks out the diff portion, and leaves the
> changelog text alone (unless you add some more lines).

I mentioned it in the message above, but not just the title changed,
the message too.

> Why did the title change?  That's just going to confuse things.

The reason is that `KBox` does not exist in 6.6.y. The fix still
applies, though, and is the same fix for `Box`.

So I reworded accordingly: I renamed `KBox` and `Box` in the title and
the message (and touched a bit the message to remove "custom" since in
6.6.y it is essentially the standard library one).

I hope that clarifies.

Cheers,
Miguel

