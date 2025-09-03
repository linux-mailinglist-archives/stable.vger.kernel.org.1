Return-Path: <stable+bounces-177633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD09B423EB
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA6C16E8CB
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34CE212D7C;
	Wed,  3 Sep 2025 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPGwzYpG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0761C862D
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910561; cv=none; b=VotJ/6R3Vx2ypytJ6fp6/nyObNfWd/BgYlii5OsC5VNo6FPUHTXjZkOsPBp5umx+TwBq5WXAGn0v7V0s8lfUJ988N4rWLRTGDPsoc9800s9TviXPXTL6xhrbp5jlxrnktKB8Wvv2lXAMhOwUWlGBUVjLw4W7dfrjyP9J0RviASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910561; c=relaxed/simple;
	bh=z67dRu2obS0XdO7wMVJi26f7U9iwTG7XsqpJEjA3wmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B/SiHLByGqHxkbz7r2SYGaZkrOvFfCgvpN6EqBjl+WGRF2icFDOs6YXevzNII16DkHmdLwxhVjuyktaP8eGR9QsksNm1Ui7Ey/NG7raX2Pok65/C2zFq4GbR00fRB4jGljf9KT5ZWyy7Q4Iv/esSbJLhmEpcOXy1Yuac95gIP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPGwzYpG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f7039a9fdso4572477e87.1
        for <stable@vger.kernel.org>; Wed, 03 Sep 2025 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756910558; x=1757515358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uU5kJy9uT+DHIQQpDfuisog2w+qcE4qmCMqvE2k0Iqg=;
        b=BPGwzYpGrJ1rgzh26tozR4WUtV6ox3Cg45FPKV/0E3EOd9ACtBroTkNiA2EgcPe3uJ
         1ML6C1mfGJcIJm97lVcnMwpsFK1jDtmC1WN0LHLPiugEFC4wS5B88xUF9np4SPIv0z7L
         Rv4V+dPVBIkJi/4WZ45RbpBhnllFDuKczxDOF7H1oXfeK054QYwnJnN8Ks63Y5r8t5AA
         XctXL84YMX5VAnDN3aJ0t1JTFn3T9qpXCnUUqQrTdYT+uMdVKrRdzZWrZuBaG23pPopN
         x75yabzwL/oCGwIH9o9/c5L7M3WHaIRS/bOUW319hZzopZPbP1INpuTu0T9bzdD3ZKmN
         13/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910558; x=1757515358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uU5kJy9uT+DHIQQpDfuisog2w+qcE4qmCMqvE2k0Iqg=;
        b=cd4ilCeOVxq7+3qN5hWbrtEgK2SssYrmOc3Z0icHGOx/biqaCwD4aabS0dx5mNpEW9
         Oc1XAiWnG91nH/TPWCFQKAy5CDzuXd6m0z1iXJWfApw9W79GSLejOvYONzvii1kcOWt+
         n8Nq9HuBQiSN4qLTUBvVQe85EMnD6Uy1oSSptPI5psNZ4B6qZX1DTEeNwAK+b5kDuvfK
         RTZEl3bsJM/hnyyzbCkNbyEWkw7q/7fATlKn6CsONnTXlkdt5jtNJdlpEg5oPRs1BC0d
         rdR3+y2c4eBc2Eq0dW7DMHCnL3CQLON36KNR9GDekOII+JQ+o2O/nte54ZNco6wlW9RI
         csjg==
X-Forwarded-Encrypted: i=1; AJvYcCWRmLigvy63XeXdWHQfOuAVEvbDiO5M8Xk+kwtbSNseDqIz3ogZtxMFUxsaT9j6umcswTbKxws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4hqLapliYZtn1k1Pr6CZKnmuddb1yVf6N/AZvenVIsHDDomt
	DrqgAXYIJv4SvQVG94uchkj6zVNTXkbnfFZnnQ4dXbDXjBhryQeH6gL751U6/K98CbJnxO2Ly28
	CWh5ule+I8W9GWgQtzGKEDkkSB9HL3ic=
X-Gm-Gg: ASbGncvn7o5qG6nqgY4KEMUxjtCaofwlRQmfGE61Z8rcSHInl0f1GVQHCJdrrd69uRs
	KWjOvWjGWFFHVWbsfoRzeUvVJ6ug7ERyCDImyqp+SBPz90ujW5e7YHOZVuZJrivU641ZIb7/Yrh
	9SpCZ+ol8S4WmJ6dAE8UIUGQFglJUSEPlHF4GiFQhEqtZeA3g8AM7XuA52nRpcFR1cmHQIxErnh
	liKPK3OuccT8o6iDTSo
X-Google-Smtp-Source: AGHT+IHuOIEVL1UdRdwUnqO8/whh8JavZ68kxkWmX6vbV+BklRG9uEjZoexngAXc2UQYqr/IeS8AixJsPKfZahmZmDM=
X-Received: by 2002:a05:6512:ea2:b0:55f:4bf6:efed with SMTP id
 2adb3069b0e04-55f708a2ce1mr4818573e87.1.1756910557626; Wed, 03 Sep 2025
 07:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUWXiz1kqR6omufFwByQ9dD9m=-UYY9JghVQnbGD2NMy1w@mail.gmail.com>
 <aLH1M-F001Nfzs7m@eldamar.lan>
In-Reply-To: <aLH1M-F001Nfzs7m@eldamar.lan>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 3 Sep 2025 16:42:01 +0200
X-Gm-Features: Ac12FXzosaQOdkehpxu68kS99AcJ29bqCUHfPA4ujR27Iy2UXuRgDkassd7HsUc
Message-ID: <CA+icZUXo-C9sSvqZ9nmZhyZvPtJmE8wgzTm2y+k0P6=mynWZcg@mail.gmail.com>
Subject: Re: [stable-6.16|lts-6.12] net: ipv4: fix regression in
 local-broadcast routes
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Oscar Maes <oscmaes92@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Brett A C Sheffield <bacs@librecast.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 8:45=E2=80=AFPM Salvatore Bonaccorso <carnil@debian=
.org> wrote:
>
> On Fri, Aug 29, 2025 at 06:56:52PM +0200, Sedat Dilek wrote:
> > Hi Sasha and Greg,
> >
> > Salvatore Bonaccorso <carnil@debian.org> from Debian Kernel Team
> > included this regression-fix already.
> >
> > Upstream commit 5189446ba995556eaa3755a6e875bc06675b88bd
> > "net: ipv4: fix regression in local-broadcast routes"
> >
> > As far as I have seen this should be included in stable-6.16 and
> > LTS-6.12 (for other stable branches I simply have no interest - please
> > double-check).
> >
> > I am sure Sasha's new kernel-patch-AI tool has catched this - just
> > kindly inform you.
>
> As 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
> has been backported to all stable series in  v5.4.297, v5.10.241,
> v5.15.190, v6.1.149, v6.6.103, v6.12.43, v6.15.11 and v6.16.2 the fix
> fixiing commit 5189446ba995 ("net: ipv4: fix regression in
> local-broadcast routes") would need to go as well to all of those
> series IMHO.
>

Looks like next stable releases will include this bugfix - checked
stable-6.x only.

Best regards,
-sed@-

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/=
log/?h=3Dlinux-6.16.y&qt=3Dgrep&q=3DOscar+Maes
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/=
log/?h=3Dlinux-6.12.y&qt=3Dgrep&q=3DOscar+Maes
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/=
log/?h=3Dlinux-6.6.y&qt=3Dgrep&q=3DOscar+Maes
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/=
log/?h=3Dlinux-6.1.y&qt=3Dgrep&q=3DOscar+Maes

