Return-Path: <stable+bounces-176430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB95B37332
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 21:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21704639EF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF81A23AF;
	Tue, 26 Aug 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeQlejmd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D3530CDA0;
	Tue, 26 Aug 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236855; cv=none; b=DL58nu+Yiy5KyPupBXOlHTjrwqswjXhu+gZ/vdz2FYK0wYp73gLxOFtqBcj23CIvvFBz0lR8xILhDp7yXaAIbuAVL2LL/tyYOMYbPP1yfvJ3hRgxyyL04hEPImvLBMeZdBuqoUE9dQSEjaJejSzBo17OLfhvnHQQuR2lAwMKyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236855; c=relaxed/simple;
	bh=B1JjpOE1ucuZyY8BzZRnNa5t4FVs2T8yEQ1ySGA0bgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHkmoR5cDgjLjTKqXYQXgJUaFwtRhsPiuveSlArX6GEXvwxhTKrfsg9nWUa/R6bH7ewm4o16CKdzSQsKCCTJ6s267uRHBlXa8WYnoJV8DecprtljL75w9BN60cwPGbF27ayWVugwx3cHObjuFibXkCMHmsdRRenzasj7lduSUvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeQlejmd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c6df24f128so2841535f8f.3;
        Tue, 26 Aug 2025 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236852; x=1756841652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1JjpOE1ucuZyY8BzZRnNa5t4FVs2T8yEQ1ySGA0bgg=;
        b=XeQlejmd+P/U5N1hbgHWYRYUeQIES0D3/sFdWDlEZYYOHRfIenP3IunbLVKva6b95P
         YpOG7HqfkOulrey5rG6Wi7TwJz/zhYXW6mS3uwp9v0Cv2HG/c+UdTec4W3bhXY1wSo93
         1HlsXHNmexIc+Jlce0UfBHIGh4jOS2GWyQBi1yX2AJcU5LCttf4ItEIW/RvVf0ZsqlK+
         SMd5rdnr5SCFyzM/O9sVFiFxOPBw8gEbECXwHFTpRkt2N5cVJoW2raEeEzQ+K0sOlDkj
         hNOnsfvpbbKmVVEAcuE+2v37aToLmn6bd00sD9rQ2+TsJHd+RS9pQIAgxZQ4WR+umlY/
         kTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236852; x=1756841652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1JjpOE1ucuZyY8BzZRnNa5t4FVs2T8yEQ1ySGA0bgg=;
        b=KcIqD5Obwq8DVWIu93rnorKir6O/ykxk10f+E0IRjawQwI9zCa/xRCVIvwWuuPRmmL
         REpq+5ZRPJnHM5ctXf5+vi9PG/UX0wrNNebZDvGCwpcCvr/UDVZVmmzgfxB62OHqomr/
         BEnk5yfMiuPgMrzc16KmNKjqI5YnupRoo6b+HokJXhFW5twyA5xrOxK4b39bOJfKEa7z
         1/vZFnqDPj2qf2865M1Yy22LZPpEgWTA9b8W+4ub/qDqCMZ5VPlkV3V4j5Ew4x8RqW3x
         p5jbQyK0P2fWUp8dJ4cBTbRV4EA0hCoMjX3kQS6EMiMyjqVjayaAvHtKIdkx5njgTGVM
         hlnw==
X-Forwarded-Encrypted: i=1; AJvYcCVc6GvbRJ3ApnLuM04IV5oP+ZM1KT7c5Z5+lxb5sXCyqR17GSe2yWrq6YtRMMLOpUrDvJJuY81i5Ps6980=@vger.kernel.org, AJvYcCWE7hnNZZJUTyH0xSHQSxl0RtT4ZXD942WwcwkV0nI3h9rUMgr8bwym1NYoxI/3YvqMOOUIM7ot@vger.kernel.org
X-Gm-Message-State: AOJu0YwbAJ8VlcpjdWIvukKXAjFfLTFajUa186hkv5+1doIOdIyuy5Re
	gCblM46FLQUPPe32Ggzy75SQFm9XWuiWctDfDJe2kApQllPUVgp9JKj5wq2bh6PJDq+7qCqWLoJ
	dQOaBWSdoKS6sUy2cdVJ2ee8MZiFCBLc=
X-Gm-Gg: ASbGncvaNgxik2wVxjLiFu6mfjkmTm0TKLykwgtcltQUc0CEREcWkbEFxY+zm4L8obC
	QQ0r5xf1GIHlnUrE2RCguJiFcsXjdo3HerPODSKSahXK8GVxRp9oD5G2L5cYxuxqVH9PL4BFxyn
	ojtABl3m++cdSh7SUbPdULPbVRb+pUmQLq3t4HmhXvXhtyzJLfk7wHH2TOejsBpIVi3e/JUdMUz
	kTDkhYuUkeyhPbzt4I3JfRhwCuZpgatZ43aI8F63Q79wF/PyhGrNpuwe8VNXoZ9QdWFUI6xX2A1
	w8EHqQ0/8Jw6rjaPlg==
X-Google-Smtp-Source: AGHT+IF4jA3hebq+TxqejHpsJdzVgo6yJA8tVNVCWVSES5L3g/vKgbx6IXIv9F+15JrZjVk6OmPJBOUbma5xs8mYElo=
X-Received: by 2002:a05:6000:40dc:b0:3c9:38ca:2c1e with SMTP id
 ffacd0b85a97d-3c938ca3186mr8404870f8f.63.1756236851806; Tue, 26 Aug 2025
 12:34:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822041526.467434-1-CFSworks@gmail.com> <CAMj1kXH38gOUpDDdarCXPAY3BHBbuFzdD=Dq7Knsg-qHJoNqzQ@mail.gmail.com>
 <CAH5Ym4gTTLcyucnXjxFtNutVR1HQ0G2k_YBSNO-7G3-4YXUtag@mail.gmail.com>
 <aK2DV_joOnaU85Tx@J2N7QTR9R3> <CAMj1kXGWjC3_hNDUxiZWU6UVHoViU=iZuZ2VbCsaqDr-5tMK8w@mail.gmail.com>
In-Reply-To: <CAMj1kXGWjC3_hNDUxiZWU6UVHoViU=iZuZ2VbCsaqDr-5tMK8w@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 26 Aug 2025 12:33:59 -0700
X-Gm-Features: Ac12FXzbn1skHkIUrxKo1DPsOGCXKj1s_SA-_l9aRPtsFagBnZChe9EDxhpfWqE
Message-ID: <CAH5Ym4jK6dHOgO10WTPrHd6w6UK7gJH-95t1Da4NooF+ORB=oA@mail.gmail.com>
Subject: Re: [PATCH] arm64/boot: Zero-initialize idmap PGDs before use
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baruch Siach <baruch@tkos.co.il>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:18=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
> Indeed. And actually, it should still be the ELF loader's job to
> zero-initialize NOBITS sections, so ideally, we'd make these NOBITS
> rather than PROGBITS, and the bloat issue should go away.

I completely agree. NOBITS seems like the best approach:
- It doesn't meaningfully increase the size of vmlinux
- It has no runtime cost (and indeed shouldn't change the binary image at a=
ll)
- Yet it still memorializes in ELF our expectation that these tables
are pre-zeroed (and addresses some of my other "what ifs" like "What
if the user wants to use objcopy --gap-fill?")

> If the ELF loader in question relies on the executable's startup code
> to clear NOBITS sections, it needs to be fixed in any case. Clearing
> BSS like we do at startup time is really only appropriate for
> bare-metal images such as arm64's Image, but a platform that elects to
> use an ELF loader instead (even though that is not a supported
> bootable format for arm64 Linux) should at least adhere to the ELF
> spec.

Here's hoping -- I'm afraid I can't substantially change anything
about this bootloader, so I've been looking to replace it instead. But
we are in agreement that if the ELF loader isn't following the spec
and NOBITS doesn't solve my problem, then interim workarounds are
solely my responsibility.

Best,
Sam

