Return-Path: <stable+bounces-195124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75087C6B3F1
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 19:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 6BA2528FEF
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 18:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAA2D9EDC;
	Tue, 18 Nov 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Qv7Yg4Fh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6642D640A
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490956; cv=none; b=YtyxzHq1JawKn5JcvLSIzgiLoJaRHtVKCAXs7ZjXeamGYkis2tOP8HeWfqH0VPHmLKSBmkrBN5qzk8E64crOz3HFV7K0oqOVW9VfxAmJ/+56FNSkJlVR+1BsQtDbhCvzFBEZFOQgkBVBXbSjgeXBj1GZXeRAF8W4U67SFVOYCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490956; c=relaxed/simple;
	bh=RyRTgkSKs87SB8s3jqLkcqh8DAVS3ymL4PEzUKP4wbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lw4AA7UNukDaBCQi2iwkp6sqsMhRFqYwu1j4LJSMzXTGh/W7NE1z+s1j7O7mXhUSVuh1XoXVd3gShjrgTkwzPJYl5xbCSMezd0wGBAYkCgC5Rt7z7tnHJoEjUbQ2GjciD/mRvfZHdnndDSlZPp+tZzGQktV9MAesxRDWxAlADS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Qv7Yg4Fh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso167477a12.1
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763490952; x=1764095752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyRTgkSKs87SB8s3jqLkcqh8DAVS3ymL4PEzUKP4wbY=;
        b=Qv7Yg4FhGDVblemOXNp0PUUqizD4/s/56CluUOVY6oY2gz4yKGmaDb1s5q2KmCblJU
         E0/hWfX8x1poXU6mTe2DFFHGjq4UJo5TtUI837ZnCawzDBeccM2LzaSrLMYhmSx5SHd1
         +vyhUuJQe+Du1+JhCvBjoE8XMjC8r2cM2LW0pqAr1Mph6dwMFcQBfV+BkEDGO7Uqan+u
         Wm7QaNUzAzyExvM42C/jMgxNy2H+7mVSeZLwY9pLNzsTSGK3tnBVQWS/pS4lb33m/zs+
         Jpvu+4DCJMLWXRT989xvbOJwO2UcE8ttCwkD5jLLa3y5ngU2xa8RVOXqWIqXmW2WPBdb
         1EdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763490952; x=1764095752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyRTgkSKs87SB8s3jqLkcqh8DAVS3ymL4PEzUKP4wbY=;
        b=OcS06bxB79MyeKKZ3EI9n3028tfTf6z0vdkEJ9VAmDM3e0DeqVTlAo60YHK5USJDOR
         aIXgP17WWfY7xC0A6jiXdD1rkABm0ZuABsDE790ps9dPuLDng3kPU5qy7/2apq8e+QNJ
         l0xp8OwL/53sojIE76kM2xzH24jejqULhBE0Z4aycfPF+oF4Mo/lFvMERFXSJaLFlWQk
         tlAPGlhynM/R3huzPci5UHZzRD5NV4HXsS7G4wQlZ9hsBegB+LGLTv/dDnHLDRH49rNP
         3Uxf1o2TJ8hx/KAvMhExm645L5mMLXEIog8Iq7okCloqCtUj3mwZNLT2kcZKzXL+EJjk
         98Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVGiWAvhr/jMArd/939APYfwG6OteZOsRWwROm+XBDb9mZgG9Vyg0qkIUneNAaDuPOktjYxc30=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWVeIMxmBA80c9riomuovHnU9YVJBj2YGoNQwsI94/WN0g3OEL
	akOskyIkre8wRWBio3D2W91dl0hyiGnTEq+Ygs1XrwnOKhYN0oO2P2ydLuKk3JkdwKA6yBmPEVV
	BVTBzkTJnwr9h2MPTbf3QQDujaeQfc3sKj88PEY03oA==
X-Gm-Gg: ASbGncsRl7rAyGd+qmRUFxxErzFUFuInq74jWkGN769sR8KV9SSJLU3c1woJHJBPnbk
	O/m8B3Voh69+HdHmsD8bjuqGLIdf/GtaiqWVEttOffyiZzxvmp+ltQspPn8ea68zB4mEiko4o21
	oe8HojD2sVZXhDsmN+eNg+87Rq20w41GZVSxfq8QJq4XTs076IScPRCJ9sFbgMQGNBQTJhJjiWZ
	P+euIEJnZjI5Oj5YkXXhNxiaIsgr4FpCx/BMbuk+1gq9YgYC6jqDdnDF8hqoexprzjT
X-Google-Smtp-Source: AGHT+IGY1b8vCf1fid4hLfUOxiAz8fmDTgBhQ1eRdZ4VYO7oROGSK3fr2sUwAVyfU+H5ZlCd9QfKeCG+BFuDsmYifK0=
X-Received: by 2002:aa7:cc92:0:b0:643:eae:b1b6 with SMTP id
 4fb4d7f45d1cf-6451a78c2a8mr289851a12.12.1763490951883; Tue, 18 Nov 2025
 10:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118182416.70660-1-pratyush@kernel.org>
In-Reply-To: <20251118182416.70660-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 18 Nov 2025 13:35:15 -0500
X-Gm-Features: AWmQ_bn-9Az87x1D-uqAKwYqa32LAYYFMR57J5R9sIXwHik0qL2mN1dUbKo6LOY
Message-ID: <CA+CK2bCFxMvSsafk1VVQe=uUfFQMeDNtBSkTUexbfvpCeWocAQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 1:24=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
> KHO maintainers can get patches for its test.
>
> Cc: stable@vger.kernel.org
> Fixes: b753522bed0b7 ("kho: add test for kexec handover")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

