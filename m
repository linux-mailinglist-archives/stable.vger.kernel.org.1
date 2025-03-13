Return-Path: <stable+bounces-124269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3AA5F1B3
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 11:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF7131894A87
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6231DF975;
	Thu, 13 Mar 2025 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDB6gDR+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F901EE028
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863560; cv=none; b=DaETji/74k0Din32TXH/q9VHKeKa+qChCXlLQ/VyZJc+69DsSzUDCRb8N5zjeKeVVDfe0BrIBVB1+URx/09VYNXc0S0eL8Ul7xBKVqJoBAWgScSikhtsg3FiB9tyqECnM7pKU99N3QOUIH7ZVX/OAarsJEEs9WSX1xZwnVRgUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863560; c=relaxed/simple;
	bh=uaFe2l1Ky0UaDkQthSh7nPRH05SiRjO+6gB6PyBSLak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8ErTmvKouw+K/s1r5OKysFYcfTstA2YOGTPiRIbPVjb67r52lIlZSOd6MLW0XM3O+viZG6UFcQ0S0MhalUOsl3mWtY1MxTWSxi/ko+9tvKQngNV+sbU27Jfmo/CPMNC0z9cl2x1Psgb8jx5YbeRqu5xrdrJUCeD1DAesWEfw5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDB6gDR+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff611f2ed1so212315a91.0
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741863556; x=1742468356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaFe2l1Ky0UaDkQthSh7nPRH05SiRjO+6gB6PyBSLak=;
        b=FDB6gDR+q3wwxmxiBFn46mHx1Sjie5J8/xeYtA7DMZQcQ7oK/fPEzgLGQCKo0P4wKZ
         BeenOxmQ/1/UyEIU5F/9yCwzLfSZJw0tpG5rczy/4oSUqm2LSTMai45+a8noyJK3G3e+
         xc3x+PlcsOKbSoPGk6euPgkW/hfDN+aC95qJaiL4RBeA3kuOtDIOUDLGsu2g8Oy5CJni
         XNpNLkLZ2DUeXlMF1srYOdnOCSkhqqneiGGDrkX+6pgJgD5NEURFUCYiGUw4s4hyMZmG
         6rYP4VYqOo0Hm2gCjZmihVtXZGuWnrXTVE8cgwoAu/wRS6IXLKI9LNWJc7BO2pC/SbrJ
         hg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741863556; x=1742468356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaFe2l1Ky0UaDkQthSh7nPRH05SiRjO+6gB6PyBSLak=;
        b=jwNUFianW5eqplDHz2vGTZJlO7tqCBgFkAZo0CzvaylnM0JK0mMBVZ7Gg8+UfNUhEZ
         mOPpwqyLc/72jrD89W7KXb96ejCZ2s3D8TCImt8fOhSLdlq2RCDH3XJ+ziimA4pr4tx6
         rQLtaaWYmcC2qELidhoYLfMoujBul324YCELErRoOd+AiOMwj8ITpG/YEBIcDGbt6IKE
         TjX++9rfJHAk9SbA2iDDWrmelfKuflsthz8x0e5U42PedE/1L3eGGRhg8PfleX101dQx
         z+ZUmjYNx6t+XOpPHQqffniURfoRkEoPf/ms5p2bQdQWajVxfrGz8BpTM4iLq3VVxsxh
         qkbw==
X-Gm-Message-State: AOJu0YwMVrAOOmRr4MDOLkR2QFQPqx5YZmbVqN/eNNFVhi422DOhEx6j
	S/SkNS//kbPZBjbjh4Xe2f0HUNPnO7RZpjVqzj2sBlxtUij036Ku7+igNpEgGt3mqnLOsbkvTWm
	911xfQrKV6wmWquc9XOCN73aE2fk=
X-Gm-Gg: ASbGnctYB/9VexZpEG0F4Cu6pXBfhkGPasYnX5mhuDzcs7gWLEXn9hhehw9sobFYWbC
	6dFJK2BVad8ZWRiLkMu8ZzbeK12ab7FU3H66HiyJdvfsoezAKsyZ8aGF+nC+ll0pBl7RXvk90hb
	mhbrGovCkLFgX7T6WQkSyGlUitMQ==
X-Google-Smtp-Source: AGHT+IFYO8A9P9AWxU4BuuGIiigBWLaaHALj2AMZT6baihSMU/Yk/H+T9+oLY72ta2upEvmGHnNIn5TaOJYBj7KKldI=
X-Received: by 2002:a17:90b:1b0c:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-300a5788588mr11286730a91.5.1741863556081; Thu, 13 Mar 2025
 03:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309204217.1553389-3-ojeda@kernel.org> <20250312231655-f84e0943cc19faf0@stable.kernel.org>
In-Reply-To: <20250312231655-f84e0943cc19faf0@stable.kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Mar 2025 11:59:03 +0100
X-Gm-Features: AQ5f1JpY8VWzqbtI83mjuvK8iI_ay9hqTYtx1c3x9tdTzTFliO-qlXf2OGGOX_c
Message-ID: <CANiq72nCQWwoZBKqsM1+aYD0JgHB40R5Sd4GPi_9g0ma6vBNMw@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 2/2] rust: map `long` to `isize` and `char` to `u8`
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:01=E2=80=AFAM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> [ Sasha's backport helper bot ]

> Summary of potential issues:
> =E2=84=B9=EF=B8=8F This is part 2/2 of a series
> =E2=9D=8C Build failures detected

> Failed to apply patch cleanly.

> Patch failed to apply on stable/linux-6.12.y. Reject:

Hmm... these patches are already applied in -rc.

I guess the bot picked up these 2 "independent" patches that were not
really independent but rather were meant to be applied on top of the
other 60 I sent.

All 62 were applied by Greg, the 2-series at commit 9cbe3832da9c
("rust: map `long` to `isize` and `char` to `u8`") and the 60-series
at commit bfc1c86b1e13 ("rust: alloc: Fix `ArrayLayout` allocations").

I hope that helps!

Cheers,
Miguel

