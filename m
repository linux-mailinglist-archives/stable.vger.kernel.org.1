Return-Path: <stable+bounces-116409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F81A35E28
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD327A4DB5
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C17266566;
	Fri, 14 Feb 2025 12:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Cr4XXrGs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E9C266EF4
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537896; cv=none; b=UEJwQkH27YdQPehl0m32s2KZef8du2RAdn/KDYQ5q38oHYHMtsCjjMv3HSRK6CwjMh9IX9GRxNuS4f3Alt2hVoHYJFufFO0SfTgQF1hqoXAY79/Ovta4h6KSEwIQPSRpVbBHe80C4CqGeJF4cigb/ga6yzQVT2MYdLaW5P10tAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537896; c=relaxed/simple;
	bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUCpV9anOEEVOR3FDwSrUytA5FKuG6ZDyF6ckzbFyMmRL8JdFjX1w7gSFQhWe8l3T3ZR+9ZMgt0rJAZtSbigXOou3HSCze558xZIW81v9HcIBFyxNsjuK/pO1rU+i3lKOnPl4nt2/kplSPikWEzb9SqVNGtdgIzQz3eG98vWxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Cr4XXrGs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaedd529ba1so250281866b.1
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1739537892; x=1740142692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
        b=Cr4XXrGsfnSJkI4egEnIi4Qm36HM1/pM2XXGocSHMBy7dRQR2U9nGtAhtmQkGXnTD8
         045IxGVkJ1blxDk0cxjAg47Y/MXPCr7nHKkPrMHtT/OeGoc3qeyjX2nezhHuzl6qYSeh
         ULhgfa1QkX5q5Am+8nq3TbIkEOiat+f/8g81eYYp8dcXstfgisVdRCA/Ah5ttF3Zxs88
         J4vlBdJ2JkQCVUxzbHsoJEF22geGcY6RBQQgqPW/Uj31SYEK61TwolGwKkmPQchJx5u6
         9TGu7x1zMzbwp/ymfQN0+4Vp/Y0eJBMWX9HegzjpR6dPpGQj1nKRJCHytEuXG+2v9wgx
         OggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739537892; x=1740142692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQsZ4UndctShqa6chFNFDzmOS8h3FjVBV4y0ULOFnwE=;
        b=uTeve3leOy6qh4dhE3B5MQhLSt1+Y6wGiWb1tw8rhGtFg8pjWug/I9Ffa0DXwkGrus
         hJtXzh+ZJMMXCTewIluJE4WucGNaYxnmaZixKnwRilBQt9s/V15VUb0aPDt+ym3T19t3
         OFcP5ZqHFkcB5MO4brMUMXvYO/losS1y3G21n+K554hNhLqbHsoiW8PwCchew53b8OeA
         zdEz0bpEO4XSn2wxQb3BqSrojatByuJcCJf8GTTOxFqEjFzcIXwjBfUanDL+A1EmSxvh
         qOt2JYORcKaKeWhFh0i2SBidmsf7Yc+rrAMYujzys/exP5EvrmpfpnmbIczA4bRKtEQU
         nzqA==
X-Forwarded-Encrypted: i=1; AJvYcCU9GAHeyPOH3ZoAduiuGqSroqTPwJM9l1b+/V/RP+6QCL/xFzgAsd/KD32AmYwh2DSUOP0oERY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6o7BKnOLz1V0PHj+p1uJX6s0IwkkOJio03Zqy3x+Te0OmL5+8
	kDb9Gg36aOgL76Umdd1B420HFUB8cw5u4qZSJDZQnx6+Kqle2CN+iwAlh8PKKo52Mo/P7IyeTxa
	QhT56//hC67MQezM2UMFqH0LE1w0q6G91Yfi8DQ==
X-Gm-Gg: ASbGncsWvJCc4euF838eI8Gk4mZ2HvpV6QmN417XRT+VvXQR/zOPeRB049G5Q+3oySS
	OMhMvnLbLlbNNfRaZqmIASpaswrj4sb00NoVdv20NMOcXbuB64mjkq0Up//NgAsqhp2FA19vfSn
	3fCTzodstggpxui32mu6rMWyCDBw==
X-Google-Smtp-Source: AGHT+IHLe7+YddvwF1jEwniu619wHEGtN11Tr41dYTgRyswr/oDOoR/sEJkfGEC7KAtiD2iVWAPopvcxL2FDqAZcQrg=
X-Received: by 2002:a05:6402:2387:b0:5de:db71:3c56 with SMTP id
 4fb4d7f45d1cf-5dedb713c8bmr5113028a12.20.1739537892171; Fri, 14 Feb 2025
 04:58:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211093432.3524035-1-max.kellermann@ionos.com> <3978182.1739537619@warthog.procyon.org.uk>
In-Reply-To: <3978182.1739537619@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Feb 2025 13:57:59 +0100
X-Gm-Features: AWEUYZmPI7kPTw9KjZhYB07W4f8cfJRiru9zF2iZKyu1QvSWQCmjZ0cvWlpS8mI
Message-ID: <CAKPOu+_6v4Dc59CHOTpP0PuzY3hie=nCUjw0WNBTwiHzCRc=Nw@mail.gmail.com>
Subject: Re: [PATCH v6.13] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 1:53=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
> Signed-off-by: David Howells <dhowells@redhat.com>

Thanks David.
By the way, we have been running 6.13.2 with these 3 patches on dozens
of production servers since I submitted them. All netfs problems that
had been haunting us since 6.10 are gone. No more crashes, for the
first time since last summer.

