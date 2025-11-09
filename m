Return-Path: <stable+bounces-192852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2E2C44464
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 18:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADBB64E72AC
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 17:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A44305E14;
	Sun,  9 Nov 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4AKlMKt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65F305E3A
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708895; cv=none; b=cpzadO8J2p54NLjlIb9bDIuWpfabfQJfHcHG46rvBrN+6p9PbhOGojisMXIggbCOuUd5J9sdYRYNs9704+TkTnX5Vg3GotD3tcl9BILMBa4tFBhYz9zHy3j4WoJ3tq1UZTZVvbj4n4W3PN07pciGIIxkC/P5j1nvUQ5JgxgYiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708895; c=relaxed/simple;
	bh=NnsGoKiTyPx8zg/f8tmzCRC1xASM1M2Ey3ZPxzdRdpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eq50iNzN4W0YRz8VYlnwSPiPplKDLAEFdmLEVPjfJvc71WMINMxLEwgy165y5c9WiLSgjynAL/ZoIkXnUbK3LZQmxJnWcXN5Kl06WbowrAKJKzuKsOAk5M+a5Qa7HMJY4HroWVKH+f6WKq1I8Oj8ShlGeixjq2r0Wg/ZJup4S04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4AKlMKt; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436b2dbff6so310876a91.2
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762708891; x=1763313691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnsGoKiTyPx8zg/f8tmzCRC1xASM1M2Ey3ZPxzdRdpI=;
        b=f4AKlMKtmi20btpJjRWN+KGaxIUHfuKWNY9h+9PNaz0iIRnVHQ8ojcNL9xs2PyUrTQ
         xQ3lSm7t59QXmTsJ1k3vr6XOsqSYbHcl7enYH0nFWiXoXMcDvhZ6ZA2yCALbYDYcPWVK
         xPkdegs0VrsU+hKQDYYSPiHMShRCr+Cce65LI1VmA2fo+uubYBBGM030CQi67/0clYGC
         kuMy8Wgmz/rh11AY2Z9Kajhh0dwArQZlVIFuOwv+bCTsiGUJ7e7KE94HaDbrINdNqiS/
         aAQoo1IywpZZPe10t7zPCIN/N+5DL8grnZbFdJVpmPvz1TQmMMbrbNGaVZa5oWaRV/jx
         no+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762708891; x=1763313691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnsGoKiTyPx8zg/f8tmzCRC1xASM1M2Ey3ZPxzdRdpI=;
        b=Q0GbeWKDorDWK8NllmliKqsgM4gkyzx5FkeREKT/YZEj67pycJhOLYy3wEl2CzvmZd
         wZU1TwQSjLcpU50anO9v9tz1DFXg+8GMV9ZK3jmu1U13CsKuoXWz7oRKcO/WPtbcJFWF
         gN0M/ion+tSq8iKW7njn7kSC0Adg4DU2pbvEHVhebA0gRFuDGOe31duhTt8PrVNSplpU
         CpzuxLg84fdeoy23I4GQlS8R0Bm2nbfKj6QMFGqGkd9ot8J+wjgA8C0yaWWdeSyz5NUX
         +A7oeesER1cV6BkxH/GgBbTyyVN3qjSt6w1hRoAIdVVoSlbiXyM6sTAqPd2BpMsqC2u4
         KVZA==
X-Gm-Message-State: AOJu0YyYi5eAcT8zF2yo6n77RlgqSwFpU3GfA/Wtz+Uy6HGH8cNiDMQ1
	UtBZtxHEVTILEZr20twPYdgbJlKwHzZOpzoyJi6cSs2hDwZsmzCpHBDtBAe9TeOdlhZrG9NyAJ5
	J81rj6d+u10TBLyPBoCzh0VUuo9Ljua0=
X-Gm-Gg: ASbGncsg0RMXrLD8a/JVky7Dj7ZF0XB/FzRSBT2P32MCRhmJ9ccEEiRKG8vW+7iKoZP
	/KC+krl7oei9nRA7AWuBtz7RjdmCmUAfmHb8oy+YtPSUSxy/N0gwZp+Q16Ek6jyUiZc4AJlH0H+
	L7iL98UYvalnY/qBJVN3GNq9PtjuAu3sUSO9IlK0FtH3n1kIWv6Xiwfdw9KKJ2e8t4mKB6HEXe9
	hNIhgmhwITxsD3jZSlAcRaM5qUX0D/18yFIyy0n4QiLsAGoer33P08WT7NubefOnfv5lBvtEh1O
	3Zw25d0xK6DS3nfY8FSLBWNo9KfYSq5IhM9COl2TXVx0Kf4VcR79KQJlGGvBtPF6b0ZNZfkEhKZ
	ViovewhY74uaRPcPTniqJ/CAJ
X-Google-Smtp-Source: AGHT+IEsrsRmGzGX0Or/E4Yckd+pbm3IZ5RI+Z14i8gevQrTMTGwto3BG5Li6qt/ZxTBwRLMgzk7TWq+OxERC0Y/2Ww=
X-Received: by 2002:a17:902:d4c8:b0:297:fe30:3b94 with SMTP id
 d9443c01a7336-297fe304a7fmr24467475ad.9.1762708891525; Sun, 09 Nov 2025
 09:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110805-fame-viability-c333@gregkh> <20251108140352.127731-1-sashal@kernel.org>
In-Reply-To: <20251108140352.127731-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Nov 2025 18:21:19 +0100
X-Gm-Features: AWmQ_blw_VTPuJ-cYsShIwkbUFeNs9X1qIhnLLS-NnVZlfJn4JIZHyQfupDVwjQ
Message-ID: <CANiq72m3Rv+L8P1J+JZu4LnR6YUKqssQu0G0yMQa51xCQWK+-w@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: kbuild: workaround `rustdoc` doctests
 modifier bug
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, "Justin M. Forbes" <jforbes@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 8, 2025 at 3:03=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> [ added --remap-path-prefix comments missing in stable branch ]

Do you mean you added the patch that added that workaround? Which branch?

The resolution below does not show the comments, so I am confused. The
resolution itself seems OK, but that line on the log plus not seeing
the comments in the diff that are supposedly added somewhere else
seems odd.

(I would add a new line here before `quiet_cmd_rustdoc`).

Thanks!

Cheers,
Miguel

