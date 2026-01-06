Return-Path: <stable+bounces-204966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0C3CF61F0
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 01:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 549E930081B1
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 00:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6BD1F91F6;
	Tue,  6 Jan 2026 00:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RAsUORX1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594D7404E
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767660892; cv=pass; b=YuyNnuttPpTMn4NxFZoXDpv9rFKTvUvllszbN2WDWxedTNwIcApI2v/Jm0K/XuGeyc6zdDAoDXSzyTwCOr4xcT1Bs9VumeeiM/Qo766YCPWKDljEY5pkUI4Uon0PaP1a4gY/Ii984ceTl7vO0XJvlnXoIWapd/lU5lgOUd6GRSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767660892; c=relaxed/simple;
	bh=U5ZdZIa4tcOeth8EAljZfL40JPYFUxc61pVVRnuLKFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rubEcZLVSE53ztti/9ZR990xBjzdvj9eX5rkj3vG9usF8hNgBgF18oCNxcixNbvt9uK+luzAJvPDUZ7HyXDsUzVYThaDLfEF7UUn1qeAO6QQcoYAvXJDCJQJ8QO2GYftz5ce92qW2L1fbffTAqWWvbn4iWoC5/WC6fjXZ7ZXjFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RAsUORX1; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b72793544so2346a12.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 16:54:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767660889; cv=none;
        d=google.com; s=arc-20240605;
        b=hYh84ueogUnc9mhVqGdyhInJMaLjydo7Ns6pjzKw9n11WfG+nf27DDeyl31cFGHZ6N
         FSVgP8z5lbWyjUvKOmppFi06Xyxeu9X/O8hH8+5qAJfM7XUPBBcqYIDQ2ObiMF7oVZkt
         RyhVq3b00BmEbUrZVyB9c4g5yBwuxIGQWZ1Yn559jXgvrnZDxflwdD5mi0HoV2PVgCeP
         XKVqqU8SO1wz3Y0D+L0/uWeTPcsDhkSBPou0MFTHAijwRBvR0XtdIdNZfr37zY4MK7ky
         /EyL17CTyerQFLms/KCQR8edm1H8eLmNnDW0gxXMZqH6bvMjOPyuliD2fLv5Zyabjnm5
         p4IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EWNiWePs4Ni8e6iYqPJa5/G2oW8FgnO0nCVcy739CK0=;
        fh=IM7QlZxLiCLO4GuG6TQKdv0y7GDFbOpnWkpcZrtB2s8=;
        b=dHs/WNrd3StqjuMYek0wXpPoP9Z3hgnvZ9zp+PzGjh3FyHwpBAWrZtBhx5YzkiWTuJ
         aRx/n70Hm87wzXLt9lQP/QpFS0+G9CHSyr5NbMhZWEoghhNMVXe7iYwV1Y2gcDeLV6gF
         XJRFN0LW1GxICb077RXwaxhQKQmqcvXhTJPo7yJfdHi8oU5RIX8IBh6nWTnTGh7A5iux
         KVu/0tIGqx6yp6bkiEEnxcsqtlcBTUYu9YUYWLKODRxlzZRZvhw7usliuYrZ1ZGTA0AT
         95xtgN37kWz7PS9OceqstGhXiD0QQkHCUwJm0aB6yJWye/XPa/8MtYo2oOYSJxQr102+
         Gc+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767660889; x=1768265689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWNiWePs4Ni8e6iYqPJa5/G2oW8FgnO0nCVcy739CK0=;
        b=RAsUORX1omNX0o86SZCqfLDpJt3CoHZ3fHII36wXTBtatjBSwEsm/EC8AWm/ZJePid
         e+sQQkzFqsRAC4ebx5fvwoFV6t9T7V1v6dM6ZEuSnLnHABAmyKYm1Ds9mi9X+z4maAJv
         A6pDnhhBS7DYh+uBNRf1p6hdDMBWTzKv46r+kZmhv7Gco2TnJf0Rg8eQBIyYA2D7DRbV
         dARfLEgH6YO9ZBY+HnYgBMeFiiXTktchYwYqv/3K+VdAs6Q1bI88tb1Tu64/qt0dJVmh
         qOSduqHTvfHh2MhlQAO1ZoJkfiat+zVPl3Tsc4UI8Nzmr2/F0iPIzKwclDz7IA5H5JFx
         KLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767660889; x=1768265689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EWNiWePs4Ni8e6iYqPJa5/G2oW8FgnO0nCVcy739CK0=;
        b=t8mHdvxVpk4OztMsSmQip59DxYKmqtWDyfZ9W5stWm1URHzVX4DKOsJ30NOCtDRF88
         V5p0ifPrb+7wAJwfIv+Y34y6zWwguW24oQ1Eg1A4/2QCnXBOb64JC+SC0TX0ZI8TN8e+
         4HR4ET6+pJuYbIT23qnD/BS8VN1nKNbOkIZ3wNQQcOxnYQQWuI360J6LMFkWxPCMuN4H
         QDV6YVY/pw9kuO9g85+ild7VMbXItBNwrelyLND+gUbYMt2sMHAABlmzjAJDWYNQVQYg
         Lsk9CUGWzvO6w6bfzKk38+cUGIdJL+k0EBD7oNgoP3QLnPC7UmehMH5Hoc5zw3rpdQWj
         2PkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXnWlCl5kvTV4QhHDPusMRNdcfY/vZkYzcJjVeJUJKWNZETPxBuHWrqi3S9otNPTsnlX1Spjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/30Un4XV4zKcNFv82n6aGtzs5M+GyYqi+cd3nr73xB1EUe4iT
	6RpZ/6/sJgZrmAH/szPGHWH4MygYXQygaDStJQooARM9Rkr81ByGZDsFZTcHhiXbHLqY19DMEuU
	iu9pcO3xouOV76/dHVmrAqwFrGlbycqE8Iz+P3SgF
X-Gm-Gg: AY/fxX78RDzOBoFNOATos5h7Md+jPDC/WdcFH5RYxXDx5SnHbfr3pwG/8+CzC4Gsfo4
	HonrWdjhl0tQAtOBztnGX9xmhLi5RwdlKwW0vabzcd80bpI7oA7bXFwBbLdAnT1+lRGZO/o0mKz
	5Kh1u3HuFzxsc0wPPkmazpu5lNMtxT9e8vC7rk5I0NgHuGgpYCb+3GuPldI3/Vk02oHT5z5BmSH
	ykWNHiAKWj4OSElDc0AYXkL0U4bpNZQjezioW2CUIPmJkzQRYoGjYKXzCA1EfePUaIKp90c1gZl
	Mxg5jA==
X-Google-Smtp-Source: AGHT+IGWKSRnkkKYnK7JG/CvYiGarDCI+ajo3F5kb+1PzJYaiyiFcGanq8SprbF89rYnLJhh9RH/tsrB2I04BC58k8U=
X-Received: by 2002:aa7:d9c8:0:b0:650:5d5c:711c with SMTP id
 4fb4d7f45d1cf-65080907ee8mr9405a12.17.1767660889313; Mon, 05 Jan 2026
 16:54:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260101090516.316883-1-pbonzini@redhat.com> <20260101090516.316883-2-pbonzini@redhat.com>
In-Reply-To: <20260101090516.316883-2-pbonzini@redhat.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 5 Jan 2026 16:54:37 -0800
X-Gm-Features: AQt7F2pqIe33A5HTxusplRp5TOpr0YDWt8-n-oDeaTTLO1max17quIB6VH1aut8
Message-ID: <CALMp9eSWwjZ83VQXRSD3ciwHmtaK5_i-941KdiAv9V9eU20B8g@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/fpu: Clear XSTATE_BV[i] in save state whenever XFD[i]=1
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com, 
	x86@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 1, 2026 at 1:13=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> From: Sean Christopherson <seanjc@google.com>
> ...
> +       /*
> +        * KVM's guest ABI is that setting XFD[i]=3D1 *can* immediately r=
evert
> +        * the save state to initialized.

This comment suggests that an entry should be added to
Documentation/virt/kvm/x86/errata.rst.

