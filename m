Return-Path: <stable+bounces-86636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF9E9A2548
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 16:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064112813B9
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C641C1DE3AC;
	Thu, 17 Oct 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdtQwLTc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8711DE4CB;
	Thu, 17 Oct 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175967; cv=none; b=I50rbckvtWO+hFD+hSMSTD9WRbj8fTxiD6XNlrkCExDmPVsE7uDTBX7tUfzAwB5vH8Oq7CgDtE1XaRe1X+B6qV/dDzLb5Fqfc6u8EkPniQxHmaDG+S4BjiD6TwcrgSc4gaViHbWpvj9TpASVZzGZDv/vHCBhNrGW1LUVF57oUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175967; c=relaxed/simple;
	bh=9oit/thLyld+bUeO2UJnVhAa57xvMBNyYEsD/Io8Cjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LogP8aVmO136Gn4lpyneVEQiUKR7w0v04kUpIBKF1urGSOsTK5mmt1pbYxrImBEX1P/ezgqeppTfQgb0Z9vzkrvlPexhCGubra+nm/O/hkUOegj2vvlvXzSxHkOmv56N3sqfikqoEY9DTE3dEQhTYiBRfn/7QyEabuoCG4U1oyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdtQwLTc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5be4381dso12777961fa.2;
        Thu, 17 Oct 2024 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729175961; x=1729780761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ao1EDwk8G2Gh/KlletTTz27frRb4cGhvN/Lwv/y4ZgY=;
        b=YdtQwLTcUjataNLkh0Mlk0GvpBtYR1fRv2F7bz009Nl8q3Ly3HiS6H4UEnrkokyeQj
         /TB9VVFs0N7QW+uJi/wYcNwhTy8YTUN6w0viWngg5Jl3ZxIuL8xkBdvUyq16duceFiDh
         EZ5Qj02tPJCAopCc3gLnNPpwZJmJHYWdpL5ZyjAU2HqDq9s8ot8o4Izza0Lfznngxqp4
         9w4pQbFKXnBzVNzl99bqvqMLL6JAQjfiy2bVm5zIVeAUurTwV4TFRlfcH2wWP650Xc8Z
         fA7rezgYAP/fMngi4q4I2HLkhtgxP80pjHy7HTOX132MI8xtQl4YuGEM25FVYmYYa6q4
         YfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729175961; x=1729780761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ao1EDwk8G2Gh/KlletTTz27frRb4cGhvN/Lwv/y4ZgY=;
        b=CWx8C7uzN54ys612u/5yTkfzV5PK+UMHvT0u+GpBM5+5n+tLC09sDGcaPVXGqi4fRp
         t7mcYC87CwOU+McygIe7Njqb/9zPaSEdgaKWk0t7ACxMQTp62zWrRCRwIYkTyaxpoBEf
         2OgXTufeSnOarshhsldAAFzVWd3uRYMz3j0orARxD4OOxyEOxuIvjkwG9HwN6iZkPMm0
         rBUz2kjWwArECHNJtUXveWjDg3lgs5Feoct+eNqkvr0FrtHBOhcrviZGrgwdZhEnp+Vb
         YINvHpEH51x3nxfajo5u2N4mNftdBFRpQaCy0hD1jmYmjjiPnGAkibVjVTQXOrS0FgD+
         QIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVj6TR7srur5I456ql2KVi1mbeAy5zm6EDGZnnitGrEkTVcO8ojoq0DUY1qcT66wGhiiBbZI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35spGGhgK7/m6XH9CCCsdVyeZRh//FtYUPjzZflTsJgdebVXP
	UrnUmgYNN7L1qYTLVjVbz5uncIqmAjeHzkLsl14M2A+qtUfQB0uE9CB2Wgclke1pq1K3UwiUi9a
	muqUH9WRzhjnLuK4rQVUfmlC+EYs=
X-Google-Smtp-Source: AGHT+IGzqtZS7+rlQOpFBWT7CS7K9qxJDD0BXRTjzIHXK5LIuMKlmWTZ0Fik7DL47ZG3BwfcaVKmt4GsyfqdkOdxzoI=
X-Received: by 2002:a2e:a986:0:b0:2fa:dadf:aad5 with SMTP id
 38308e7fff4ca-2fb61ba2de2mr56101521fa.28.1729175960369; Thu, 17 Oct 2024
 07:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009121424.1472485-1-andrew.shadura@collabora.co.uk> <1e450049-d173-4a6f-b857-71b7c6f50e6f@collabora.co.uk>
In-Reply-To: <1e450049-d173-4a6f-b857-71b7c6f50e6f@collabora.co.uk>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Oct 2024 10:39:08 -0400
Message-ID: <CABBYNZLfwE=L-h4c+eqJqdhZt+LvDTnDCADrtEsLbVLwP-uaNA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Fix type of len in rfcomm_sock_getsockopt{,_old}()
To: Andrej Shadura <andrew.shadura@collabora.co.uk>
Cc: linux-bluetooth@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, Aleksei Vetrov <vvvvvv@google.com>, llvm@lists.linux.dev, 
	kernel@collabora.com, George Burgess <gbiv@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrej,

On Thu, Oct 17, 2024 at 9:47=E2=80=AFAM Andrej Shadura
<andrew.shadura@collabora.co.uk> wrote:
>
> On 09/10/2024 14:14, Andrej Shadura wrote:
> > Commit 9bf4e919ccad worked around an issue introduced after an
> > innocuous optimisation change in LLVM main:
> >
> >> len is defined as an 'int' because it is assigned from
> >> '__user int *optlen'. However, it is clamped against the result of
> >> sizeof(), which has a type of 'size_t' ('unsigned long' for 64-bit
> >> platforms). This is done with min_t() because min() requires
> >> compatible types, which results in both len and the result of
> >> sizeof() being casted to 'unsigned int', meaning len changes signs
> >> and the result of sizeof() is truncated. From there, len is passed
> >> to copy_to_user(), which has a third parameter type of 'unsigned
> >> long', so it is widened and changes signs again. This excessive
> >> casting in combination with the KCSAN instrumentation causes LLVM to
> >> fail to eliminate the __bad_copy_from() call, failing the build.
> >
> > The same issue occurs in rfcomm in functions rfcomm_sock_getsockopt
> > and rfcomm_sock_getsockopt_old.
> >
> > Change the type of len to size_t in both rfcomm_sock_getsockopt and
> > rfcomm_sock_getsockopt_old and replace min_t() with min().
>
> Any more reviews please? It would be great to have this fix merged :)

I was waiting to see if David had any more feedback, but if he doesn't
I'm happy to merge this later today.

> Thanks in advance.
>
> --
> Cheers,
>    Andrej
>


--=20
Luiz Augusto von Dentz

