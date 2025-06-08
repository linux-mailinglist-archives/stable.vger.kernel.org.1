Return-Path: <stable+bounces-151940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53883AD1325
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 17:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8513AADE7
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5F18CBE1;
	Sun,  8 Jun 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3e4SeoD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA342188006
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749398368; cv=none; b=KLeoKFAC0edpulsOr07i9DbVfzzuR2+PqwKYvN39hHYqRLV+PSJmNnJ/lI55WwfAKqY86Rwb0rrrn70X7JhYNOulh4ppFAheE6sinSIUjB78J7JyhqRCZ075Dz+Ll0X/8I9/mfYLO1Fo/C7eiLc+sh+28MKvoaslQBwG4vqbNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749398368; c=relaxed/simple;
	bh=f+QoFjIDZFPDOTX54jJm4Wl58uaSfH1vOYDxQQSh9Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfN2cobTc88V2/S3dQSfHyBZK/RmDSTzHsDwq501Y+28DCPROmEWycQjz8bR8gGrFPiPGSUscjcP+gvAMTK2JGj0FLldtZpoE0o+JcnBCoyQDoa3IcZYXaUT7hX+QuznZs4JL1RiwJcaMM4P33nkkRlqw8RXit9Sibqehv0vfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3e4SeoD; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234c26f8a25so5610305ad.1
        for <stable@vger.kernel.org>; Sun, 08 Jun 2025 08:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749398366; x=1750003166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8ycf1AXSHphVXFtQ61lCtqmprgiNNhERkwbmny8Hc0=;
        b=O3e4SeoDz3zp1OGy99nfeYp74U6Xay5NpQA08hchAGu9CGCFxW2RFN5KwzHB6JGiKs
         1nnsL+hAEGzKEn4aklw+bq+tNmzS1mDp7RNSyKKphhha6GxucBKoJG+heXwxQX9vval8
         I0wgzll6hGj3p4nt6tuQbnRkp0sfBLY8A3lsdZP+0piCxRGQLVU5Vkub7rKOOqtH98u3
         GqaFHJCFKDh8CMzaniX0GHnXpA/v+Nwx94DkF5wThrDU2i0WEuXmaNosJ9IzYwa3eSOf
         7zxd8RL8Te4UxTPzwUdJNP11wV226ahVlATqRS/CdDGMsp9wHmSa3n+4J6gBjuyG676K
         iOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749398366; x=1750003166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8ycf1AXSHphVXFtQ61lCtqmprgiNNhERkwbmny8Hc0=;
        b=Jk5cLvFoStzXKY5eoXHsPqrJkoQ0robOU62DOhnunkkq0uemy+HPdPyoMyakiToxcH
         Y7jsLCu/Y8Ee5b6S/sT4OkeorJ861MQeDq/AzlTne76J4Qx7SudRje2UB08rce391/qs
         8GywvdpbWl/qgc5XjU7fMsR+cNRDpOQnf2XJbQ7FDMOBvmti/ZUSpgHwpxBpPLYSBXxc
         fjvlITzKzkKg98b/Z1bX09FyjXbG2AjZt7LvV3iDILO14H3YB2Xx1M/Xn4/AxAgjeW81
         AsxJLnrg/IStFkDZs5R/+u637Cp6D0IJiEvzqhmajQ3DAMdGnyZ8AYnB7lqgo8ZrFCyV
         uanw==
X-Gm-Message-State: AOJu0YyJ55APAFs8xVQ1opazt2Cuk/tFyfSgkya25r/djWgddQaFBxxo
	dQScEE6Z67WfirJfKeOLRiWyqfRYMB6LNUrH44YFbow6fDkQ3RtIDaqZLe3xNuez0KzORiiAffz
	bgeP9rvR6i+1liT2jqEfBqkQHDUqcjx0=
X-Gm-Gg: ASbGncsQLTpGVZip328wCqWnJJksrLF9PVOyCQz089btdumkBwe8wwsYMz2BsRWUeDT
	gKycPjNT6VMlNNj0C1TH03EUl3gu12TYFRLs5TRM/xwCF/oHDXXKxpOd4qMtniUMcmsAt/Rx+oW
	P9dWxd3wNDzA+cqaPXf+NyfIG2GU5pYZ06
X-Google-Smtp-Source: AGHT+IHigUm9BG6VuZSJkB6xcnFFuYgsMV5Z5jdEQSH8725iIwiXo7Ps+spVxuipFkascjjS62XDyUXSUQPaXaxQPQ0=
X-Received: by 2002:a17:90b:3d04:b0:312:ec:411a with SMTP id
 98e67ed59e1d1-3134e3fa0e4mr5009465a91.3.1749398365982; Sun, 08 Jun 2025
 08:59:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608145450.7024-1-sergio.collado@gmail.com> <20250608145450.7024-2-sergio.collado@gmail.com>
In-Reply-To: <20250608145450.7024-2-sergio.collado@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 8 Jun 2025 17:59:13 +0200
X-Gm-Features: AX0GCFtEAcC86nLB915euxMEtvtVTtaVASyrg4hzaaaba8XpyxMLCc5Ctdu7nzI
Message-ID: <CANiq72mVx258c0rbGDwF1sP_gn0v_L7PPMG1q1XcBF2OQWH9-A@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 1/2] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 4:55=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> commit c104c16073b7 ("Kunit to check the longest symbol length") upstream

I think this may need to be the full hash, and a period at the end:

    commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.

But like in the other patch, maybe the stable team's tooling still
picks it up or maybe they fix it manually.

However, more importantly, is there any difference w.r.t. the original
mainline commit?

If yes, what the difference is should be mentioned.

If not, this probably could just be Option 2, since at least if I take
the hash I can directly apply it (auto-merged). Same for the other
patch.

Thanks!

Cheers,
Miguel

