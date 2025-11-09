Return-Path: <stable+bounces-192853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73938C4447C
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 18:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178C53AB735
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 17:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1B2309F01;
	Sun,  9 Nov 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNN2FFoM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E22FE59C
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762709085; cv=none; b=qD1Fh0zAWypvzhRNlzzfcUfyK/BVHWgmWPLtqhz/see2DhgafWHqmyqD06YJ1S5AmPG4zSDXb+PUa4fqTtsU0425/e1URrVRGuSxkf/bS8F2apgghEcWZbBlg/IMg0PjGW7DONlANGxKlkGCJyM9dDiYKlK/p8h4GoPKbDwf5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762709085; c=relaxed/simple;
	bh=J9guURLkwYhteGixB+VyKzWUVPCj7iIsef37DG+eER8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9QKBSlF4xvu5f1d/bQnQBfdGXSJagU4eIWc6a5QitwAW4EpFgVznRZykXaUAKs6Pk3A42sKLnfvs7RG3IH4rSywhB9wsBJ9p+jQoc84XxjeO3kImZgUn72rodD35ThQP6O3DJgZYPL9wn5MYLYR0Xq6/GMfGsOxOb+ZwLs/bNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNN2FFoM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29806bd4776so1395235ad.0
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762709084; x=1763313884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9guURLkwYhteGixB+VyKzWUVPCj7iIsef37DG+eER8=;
        b=PNN2FFoMPU8/wUuifcw1D8VUXvMwYXeqFIugQB0OcBwJupU/doPn5nx9/ZL88AVd2m
         t8ISO9wG2tjQMaqkK0OAu4Eo/b2F1AeJf2aNhXdnKxxqTbP+nU1YExq+jxX1IUS20n2g
         py1s6BrT6WSSxQNI0Kv3lUQ+mpWDf13ZsehsBTHrU6zUmafEsoF3lW7B0r2anZfkg7O6
         CGRO8VrCryU4BV9nPUN0gyXxf2r4XTn3K6d3epbHYtHlQbA0RMos7ouMPL2BTeqYK7w7
         In0EMyTInV/wFP0vLPzatzjC/elIgPjZdKWtt33RNsG6krQn2nnjZDucP8euwAZdXC5q
         X4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762709084; x=1763313884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J9guURLkwYhteGixB+VyKzWUVPCj7iIsef37DG+eER8=;
        b=LetKKDuIDWRXTtEXPrs1xK3kHiuULiepgQSict/lH3XyYRdKn7I6A3+L9IAIxWgwej
         xIMwb1op9EPqp3gytbrM778URxv/v5Irkh0n/jWhF5psmXff9uln8gfqFSNA6SuMj6W5
         nY8OxV62k6sjXkxl0IOKGSUjCkJFsQNTRfWGtHV3ZJPtaTOQNnVSgwn0KXyrYzflCGV5
         C0VVtc9vTYlJMRM6WN6njoGrrxRsL7jsfl9+j/o0e6itFg3aeRw7ZPnnQCAHHKMXWOeI
         ibZLOIGRvOl8og3/PGkmzmSNRbWZUUhDFFVdJbekn5QwdVqI1LL1vXHYkSwLgJR54pTC
         KE/A==
X-Gm-Message-State: AOJu0Yza6s4l2eq91CEZOKmT8YIpy2IRFUj6KPE7q3IpHJ/PGm3/oUvH
	UGP7A+MOjbX9lOx0UlEsl7tegnxMb0DmeQM4csSV5CEKWi3sXmQvXFiXOpX0QuIbsnC+4R+O245
	Blmh4HqpBvghS0YpWfsCZG12STWtb7nI=
X-Gm-Gg: ASbGnctLK0Ojctls/EbSY8u4GpPyzAKbC9wA6hJFlN0XiM7WoevqFitD5hKhshGri4t
	fZpnPTNg3Kiu1YAsCb0N7jMCQzUXsvWLW8cTrWZYM7KOd64D8JNn0IVefqn5rHvp6Lf8NtvRhnY
	lB2UYMqJjefTEzYrffrjyD3LJuvcmZYO4gP4vzzGKYZwmIzz3uV/+AbqFXlkmvSGuXhywzWYQGG
	S7lIH25rRS3AWeUktfRtbx2BnznmPAt+8ogm8hkF/TjDBoFu8Kio3XSw9eBIUSEH5u7M8XnTXJb
	dDaCidGQV3XdgJ01VfCKoVo6OPD6R0E3YxNMb3MfYrmsd16PeccmXb7RFqnkptcI66aVDRfBO1C
	idcV7N8QotY15Zg==
X-Google-Smtp-Source: AGHT+IGVG/HbwysAaLWl2yEy4JPM/I9w39b1zM7dpUahWQFr2Xhmi3Qhqdh2+hubcZWU1cWtnlCAarGsjQodS6A4Ttc=
X-Received: by 2002:a17:903:2308:b0:297:df7c:ed32 with SMTP id
 d9443c01a7336-297e4bfa725mr42426435ad.0.1762709083638; Sun, 09 Nov 2025
 09:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025110805-fame-viability-c333@gregkh> <20251108140352.127731-1-sashal@kernel.org>
 <CANiq72m3Rv+L8P1J+JZu4LnR6YUKqssQu0G0yMQa51xCQWK+-w@mail.gmail.com>
In-Reply-To: <CANiq72m3Rv+L8P1J+JZu4LnR6YUKqssQu0G0yMQa51xCQWK+-w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Nov 2025 18:24:31 +0100
X-Gm-Features: AWmQ_bk_nFchMF8iQjW1qWFC7IhSdOUaBs21ZLkLtM_F7xaq0Fq88r8wZGO1T-c
Message-ID: <CANiq72miFRfX=_nwGDxLOKquLKgeNO9sTQdurik-vamR2McgrQ@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] rust: kbuild: workaround `rustdoc` doctests
 modifier bug
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, "Justin M. Forbes" <jforbes@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 6:21=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Do you mean you added the patch that added that workaround? Which branch?
>
> The resolution below does not show the comments, so I am confused. The
> resolution itself seems OK, but that line on the log plus not seeing
> the comments in the diff that are supposedly added somewhere else
> seems odd.

Or maybe the line means it is adding the comments here, because the
stable branch misses them, but those comments are not in the
resolution either (and I am not sure why we would add them here in
this patch anyway).

Cheers,
Miguel

