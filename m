Return-Path: <stable+bounces-105327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B549F8183
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAD01895809
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB81F76A5;
	Thu, 19 Dec 2024 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek0EQrQ8"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12319993B;
	Thu, 19 Dec 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628118; cv=none; b=iZs4DB8Oczp+oRAXMdyWFHcsxyRCTZUpMxjCxpNHHzidD0H9qHWnleTGeYJUmkul6WUMuA3PZvF0AhT0c+Nn0eFHqr8Ri0lIU/RwUTbGUJK/Fbq5v5RPg4hBOMCZu05eL1124l36f4qFD1HL7ktAJpbOwVXQrugHCZiPU81i2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628118; c=relaxed/simple;
	bh=F+7dGP8vTLAPwakA/+BaZnuqyVBJdaIXxDi9OXgh5C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYNLffqC7sbi2AvpWTNeZv3he4ojLZJqM9uqVbfID4twQ2Y9zp42Bnc+2LZd/OmsIP0cT4ILu2Y6jD1JTxUI7xQIB0Lj6z5pSvu//ZRe8UV4BgrryXEFQsRzUvT/fL7AIFJRjttkFccX3i0EhmG5Mr/cAhS7EOyEMpc88E8HQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek0EQrQ8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5401e6efffcso1052527e87.3;
        Thu, 19 Dec 2024 09:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734628115; x=1735232915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pOS/eMcaCDd8OiASZ9fXqKTBnFb+hPXU2FvmhB2krtI=;
        b=ek0EQrQ8FDD7Xs20TjIYVX9Bd2DymU1r0Xg11gCC/yLZ5VfulcaDsua17xwSkbYxi7
         nP/jiyrr56730FtR1ojCqnZnzq55mCEb/IF+y1fxShF+uNqj9eqGKDSOUtANEz/55iAX
         nuX0jp/tYvxROVb3BGTA5ADYO48hYeCm2n46tdVdi4ew46Pm5AiXBe2ujRwwXVDUf3HX
         5WdEkZLtVht+mtUI3hGK0pU+1t7lKppX2F0Aw7paBVYAFcFJzcgaTaGoFRNypqJVz4y5
         PFoYmZ++7od9RSWIfkpdjPbg1qQFE5zmzDpjhlJi7xi/3wd7SuGpyVrOYdutp9Fag7zl
         lQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734628115; x=1735232915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pOS/eMcaCDd8OiASZ9fXqKTBnFb+hPXU2FvmhB2krtI=;
        b=MdJNrcn80vs/cjOEk13LIo6VH9tnekLEc3H3YRuy7A6w5Ps8rjAWxInfs5m1B511Ec
         RI3Ir0/OcWwgzxomrNk98NQm9imH08L6qqnpP9SImgH9ugybH3ZVMaTtxM7Yvv2moXSp
         V6SNzExcKVNVh+RJJe0S9zFlWC8u+dATAUNk2qqcH69kp4wGwFWJWgM2RwaoCnT1v7Du
         UqO6S7vVGB6CyQNmD+MCSqr9Q1TpFz85z11PBVHjJzSwAP2l+hJPXCnROWGhTzSR0kXg
         4gE83etykdVuwJZT/b4Fo3dzC7OkK71WOQ3nF8UY7q2Jqj4s2Kq8jAsFT/IhwggPygMb
         sy0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUigomwcEMdKSS2V9WQzOQlpeYZLRVsVPSA+9W5wIfQ+rdmhGUHHIm/tJI70c3fH8ULqVpeXO8l@vger.kernel.org, AJvYcCVAG2Onre2ql6ERdHBlzbmzuQP5pe9nIeEe/nrO9jS4IU8uXPDvnQjZ+7DeKMycTuVNBkA7ErUnYPoNOMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPpVZ6KzS0vNibidY3LVHc2yJh0tbS3L6DUMz6C/82L3RwjqY
	DmwajmegMb9U2TCzuW4Gd2LX/VRGYorEAYdxY3m6QDkPEgbE7OsaVi1Lh8On1IW8ccoBQ7qeKaI
	+P8HeQteMuMSsvnjM0V7NLihliiA=
X-Gm-Gg: ASbGncsJUfaEqBF6bDr+qwxhOAOFdZkJWaw1XV2a7trpTIwtSQJGPZQ7ui+aD7lnA53
	/uk3dvXrPHV3S81DOydaeUm7iX6tRXr23jI2Hlnno+EcYDDzaFoHQkTcTDDL4uOfVdDNT
X-Google-Smtp-Source: AGHT+IH1fPAWE9ZihXoqOyUcZLJ5ZMr0yMGqbJib9Q3iCHXC0iX4S0AxY1HTtW0ibC2C7611VDCclmJQ6jkesDK9qzM=
X-Received: by 2002:a05:6512:1592:b0:53e:38fd:7518 with SMTP id
 2adb3069b0e04-54220fd169fmr1693168e87.3.1734628114469; Thu, 19 Dec 2024
 09:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUWHU=oXOEj5wHTzxrw_wj1w5hTvqq8Ry400s0ZCJjTEZw@mail.gmail.com>
 <099d3a80-4fdb-49a7-9fd0-207d7386551f@citrix.com>
In-Reply-To: <099d3a80-4fdb-49a7-9fd0-207d7386551f@citrix.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Thu, 19 Dec 2024 18:07:58 +0100
Message-ID: <CA+icZUX98gQ54hePEWNauiU41XQV7qdKJx5PiiXzxy+6yW7hTw@mail.gmail.com>
Subject: Re: [Linux-6.12.y] XEN: CVE-2024-53241 / XSA-466 and Clang-kCFI
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Jan Beulich <jbeulich@suse.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 5:44=E2=80=AFPM Andrew Cooper <andrew.cooper3@citri=
x.com> wrote:
>
> On 19/12/2024 4:14 pm, Sedat Dilek wrote:
> > Hi,
> >
> > Linux v6.12.6 will include XEN CVE fixes from mainline.
> >
> > Here, I use Debian/unstable AMD64 and the SLIM LLVM toolchain 19.1.x
> > from kernel.org.
> >
> > What does it mean in ISSUE DESCRIPTION...
> >
> > Furthermore, the hypercall page has no provision for Control-flow
> > Integrity schemes (e.g. kCFI/CET-IBT/FineIBT), and will simply
> > malfunction in such configurations.
> >
> > ...when someone uses Clang-kCFI?
>
> The hypercall page has functions of the form:
>
>     MOV $x, %eax
>     VMCALL / VMMCALL / SYSCALL
>     RET
>
> There are no ENDBR instructions, and no prologue/epilogue for hash-based
> CFI schemes.
>
> This is because it's code provided by Xen, not code provided by Linux.
>
> The absence of ENDBR instructions will yield #CP when CET-IBT is active,
> and the absence of hash prologue/epilogue lets the function be used in a
> type-confused manor that CFI should have caught.
>
> ~Andrew

Thanks for the technical explanation, Andrew.

Hope that helps the folks of "CLANG CONTROL FLOW INTEGRITY SUPPORT".

I am not an active user of XEN in the Linux-kernel but I am willing to
test when Linux v6.12.6 is officially released and give feedback.

Best regards,
-Sedat-

