Return-Path: <stable+bounces-151943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A49AD134A
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 18:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A49A7A1C4D
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BD8199E94;
	Sun,  8 Jun 2025 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+49KPZx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAC2110;
	Sun,  8 Jun 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749399952; cv=none; b=rvP9N3VlTPqHqKtFgDUE0062KyjuMFy02MLVsTiKu19uIi4BkPnQiZR62C0mh4rcrWKTsLxhglDbCaqnnp0/Ai3F91vz5B7gxWNmTVHdynfUGgJCfUt00ER9lb+Hcp0i0Uuy8nUD8vjfqenBWwFa1HHatiXGUZ+uYOaIHxJpSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749399952; c=relaxed/simple;
	bh=Va1TbSjqbI2pgSwaawgPxh3NVqwfXm5FttWoY8PlOKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRqtF0XgnYeIZgd5Lh27EHW5XzQu/LXYMPybCF9qWaxVb2zf5Qh5Ehyu3cQ20G2jdJDqpshYkJFD/KENk0KGqRp73aeydGrK+UlMAuuWzHiehFkv+lUP1vJK0ufOosYzPMJY3mp5OQ2ZZ6jUhU2wOsyoTezzYM1grNonoRQ8iS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+49KPZx; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313067339e9so527199a91.2;
        Sun, 08 Jun 2025 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749399950; x=1750004750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va1TbSjqbI2pgSwaawgPxh3NVqwfXm5FttWoY8PlOKY=;
        b=V+49KPZxrIoL/Lj6MQumiPqPbzEkmd21Qg1cZYCmbYy95ibOYcyEnidehoeuLi5zlM
         eXaL8vEm++YHU3KQ26aRiSlt5oZ3teV0cfc0Bw2houXpO2Kv4BLG6ezWq2wDYNnS+NYd
         92ews1jqMYwUFoa5KAwjtoOgWocoMcyIC50e6It4TZRBcoBm+a2vWg6GtydjpfS8qGx9
         2hNAImkwzTuuNk1ydHHL/uvBfkGtooDW+wEhy69ZybbDUSQR0jiNfosSz+TXNkWAzuQC
         XpldVKTZHabPIkqAV46HEMKhqA00weGZ26KVf+hmlEsDFpp3VbvKxUIY+S2rLLuLaHkv
         i5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749399950; x=1750004750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va1TbSjqbI2pgSwaawgPxh3NVqwfXm5FttWoY8PlOKY=;
        b=Ucdvi8XEy6CXwozAMDGrbIxAnQ1ycTlvfYMWuRWCl9xyUCTNumQcS1N6YWvcdmxiDz
         Nrcdu2JBlRuO1H/fPtKCVA518GmFPyObLYKL7imQiAFvlSqZ5KkUCDIHrCehwQIT4zgB
         YiZyw9IG7E6vF6r0dNlLL8R5IfxJTJjPAbPlsrflojScbTWIertkpmrHLbqCi0s2VRc+
         oGzhFjauGnTC75emcYOlbi7Oi3kHvyl7uyoc/kLcwfwqYkFxAc0oIJTMgbtVqt03wUnZ
         W8LOHvL5DQVa7cTv0KmgKYgbuy9Ud6dusGLMnLL5dvP6bwvJ4P3CPHojdICC69BRYkiN
         D43g==
X-Forwarded-Encrypted: i=1; AJvYcCUhnf0cxUt6wQrWwpjWpwbfEy0E09grSW86eHI3819BfOB4IHFqq45p9Ux863Iz4S8cpa89eMDRncc5jVOcaw==@vger.kernel.org, AJvYcCVymDXWYRrHn/hxNQeaUsZ8DwxiTRQB+tR6oN91JZXO6Mn1i0l3HwcJ5LdzSCkxiURhonPQSm/0@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRok8C2/BtU5OwmzirnNZ1ObTkFa1cSyPweRulcVZhmqFtfcn
	ZNwO03Gn0e3Q1b2UUiIR07VBLvuL0JY4raiS3EDFKIvc8nUwAP65Nc98N2JEHG6+upj7HQoUspy
	E+mYN+q1mfzki0V0Irrztz6jIi2PGsWtJkMJ9
X-Gm-Gg: ASbGncvN3pW/GvBt6ihrD4P6EMWNRKd4ehjm5W80je5ge9Dc+00MhPecUj73HyeZKp+
	gvYMYbUEF4qePbBaWnwhc1sckVU2pPnyO4mCfzEsv8bS524PKztK6ACL3a5LYibmjhiK/4Grr6B
	6wrBzN8rC9/on1QeQLnD5JQDinYmW6WR5U0nOnrPtAM5g=
X-Google-Smtp-Source: AGHT+IEW3omqkNJDfhU8ZoJL0yKzGfVK5jywDam3te+/ue9oCB7B7Nob2m0ticF9d6pK3z7XWL00d0hE2jTDyPOPXJI=
X-Received: by 2002:a17:902:d511:b0:235:737:7bf with SMTP id
 d9443c01a7336-2360409dcd6mr55412335ad.3.1749399950244; Sun, 08 Jun 2025
 09:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608125507.934032-1-sashal@kernel.org> <20250608125507.934032-4-sashal@kernel.org>
In-Reply-To: <20250608125507.934032-4-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 18:25:38 +0200
X-Gm-Features: AX0GCFtT_R4cZ5X4zaggASOXnbSzNJHThJNf6cWOW5majDssFLNveZWMOL5-zr0
Message-ID: <CANiq72kb3GDKxhj_+SniG-vwLmcb-=9P6HANdxxJrsVcpwF84g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 04/10] rust: arm: fix unknown (to Clang)
 argument '-mno-fdpic'
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Rudraksha Gupta <guptarud@gmail.com>, Linux Kernel Functional Testing <lkft@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, alex.gaynor@gmail.com, nathan@kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 2:55=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> **YES**

This does not need to be backported to 6.12 since there is no support
for arm (32-bit) before 6.15.

However, it should not hurt either.

Cheers,
Miguel

